# Update a static webpage and timelapse mp4/webm videos
# from *.ds containing webcam images

dirs := $(wildcard *.d)
mp4s := $(patsubst %.d,%.mp4,$(dirs))
webms := $(patsubst %.d,%.webm,$(dirs))

FFMPEG=ffmpeg -r 5 -v quiet -y

all : index.html

index.html : $(mp4s) $(webms) web.sh
	./web.sh > index.html

%.mp4 : %.d
	$(FFMPEG) -i $</%05d.jpg -sameq -vcodec libx264 $@

%.webm : %.d
	$(FFMPEG) -i $</%05d.jpg -sameq -vcodec libvpx $@

.PHONY : clean

clean :
	rm -f index.html $(mp4s) $(webms)
