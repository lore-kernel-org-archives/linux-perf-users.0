Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE8B42BC46
	for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786819237; cv=pass; b=MKkq3554v+fGRtO3lexWKS4WA41cryF3OrWpvIPwTkHvVsNnE6By9BY/rjU/3r2Anv3nctjSFSlrh+7D91vvfGmVDBXClGfImJAwlcgGJZWzHr8+PkI33zuyJProdjo4Dymd5ddrldIESzSuLP76ojskqR0sENUJZCQcdpWWXHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786819237; c=relaxed/simple;
	bh=SLUYfsa0Ppd1yNdayeftYDhgIpuNx9R5a6gxCuswr7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjS4lOz2RTGIoPf+TtVCpUssF5GWWzM5l0RzSf4Gag6hhCNyv+JK+76kgmR8lRZqLm45itF5bKH1blwUud+fekhA+JKMS3pi+P8qgIO2kWLujPD6gJ1dyOOwDSKNRO7Rsc40W5r9Ry7q1ZGLReEkq/gbOuYRXTO5zQQpaE7cFac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h62vrYBT; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h62vrYBT"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c01c79467so525591cf.0
        for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 11:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786819234; cv=none;
        d=google.com; s=arc-20260327;
        b=QCZLuU1jZMfV8u8ExGn31ETowlGLIClJl1X4qtYzbfQDb9mawIIH77qV+8zNkuwVE7
         rRPnsadz79gaeeNc9yqWlrwOJviq/GyZNPrv4uzN5+2860FJRXcodvNMKVRylo4SMvlZ
         ejSnOoPWslrRBF9jLn7hSZZusDy4xoXeTZgK9Ci1opIs5XFf6/bWGZKjs7aW1UMwW+tg
         tPt9gyhQNoqkzcx2z64Pvy/Aw4XHxLXP4M6qIQ3/PggM2VAwIMxDzln2jNotu0WlekOs
         EPK2xYz/xmZXxCqvJlxPSDGT0vKjglMLdNBWvYVWevIGUy3X19bLKbnqHmArVcN4Llyp
         TE6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cM0n/v9CSNZPkVilOS4eP+dgGE0SWqCb+AKZIBou57Q=;
        fh=ViAEnePQYmxBeddixDQyjeddofWAshTVKMRiWMO7Wko=;
        b=F/rG6mSkLrXZ/ct5DcI7ScLW+xnxV2tN2tFw0oMG1I4eQNl9Of3yUYo/n013tcLQBW
         YLFRyLZPgQi/dTKH5pYJ3NDkafC1hhJ7KOyOf/XXkux68Lp7oxaCxO8xDmu2N4z54r3J
         kGoLMZR1uMTnGZMO5009W/xP47xwkLQYXie19wmJuAvBvQVOxK43feTMGOptQbC2ElAs
         vS9O4a0MBgEZpzXsw9r0ZsTAua/sQn9gXsD7vy3ChSyIxGUFiga01hql2wJVtZGWjX2p
         W77lEOQKCrtXHKyQ5ZZBPUXCimqzAh89GoiaZkMGz3gtKh2PYKWbwBd9MNtdj2FS2BEH
         kYsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786819234; x=1787424034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cM0n/v9CSNZPkVilOS4eP+dgGE0SWqCb+AKZIBou57Q=;
        b=h62vrYBT6VTMV920ZOLofKTX97zeyYzfBESFyryyfjtP4ILhA3Y7+3E5pWgq3oFuZs
         OItGsbBw6ANGZeZ2JR1fIJdel1ueKVvy7KtcBO+WGBIdTGAvoarOAyvbR6qXoZqFqTMO
         bep2+4zCfqKIsUNDVun9upuyJ/t4Y3S62Z9vO0wOVZ2VHk5E3n1vhTbhWliOeYfIYeIx
         vkYFDF9LIc/V2haQC5b7G049yzK3gXLE6uBVAkoe/7JzQVq9M4mO76hGHEWwmNKEEcDd
         tDD01j6TDjAuIS90IEm8T2mFB30AeIyo+fm69V1FEBcEhmX2iUTchxXcPWBM8ztCAYTD
         vKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786819234; x=1787424034;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cM0n/v9CSNZPkVilOS4eP+dgGE0SWqCb+AKZIBou57Q=;
        b=IDa1kZ8HhlhFg4xL7r1EXzEA6fTWqdnGDxx+NEZAx8qtdXGzSmZhCrsz+wb7uN+jZq
         V58HRiuVvYiQJT6x7MOUi2nTuwXOZxjAWzpsmejO+si6wep158RygxlClOGN88UTGmML
         ImoPVjhlHf7irzG5FRr5EGJtI/ExPU4NnUol/YR3X6BBotdPyqy+wOtpgdrFuA57dIoT
         ddveK5k17CHvL0ju2Vbw532PnX3wUCLaeATkV2Y4FbtWxO4lp0WeuVH87i7PpZDzG2Zi
         1CMD1EdjQVgv6Xtsw8xHb9iM/WgAk7ecKgjWVXzp5n4xDUeJZiEaOL9p9kH6ei1Hus92
         ORMw==
X-Forwarded-Encrypted: i=1; AHgh+RpDoNZIR8eZQQ7jbELhPYMs2mYwHUVFq76yLVtPDE4HslrkSddX7Ix+VL3OymfeGNP2ngGxf4tQQLd8np6XdTd2@vger.kernel.org
X-Gm-Message-State: AOJu0YxFm98v/sVt1bP5Kvfhy4jOJ3/PZxQYIE87O9fuxSzskX7/dHbv
	4sV9tmLCV+cnmOE5g/h1E/aqZ3bYM5lisSoCXtOdNva4U70tmF9AWQkEq170kk9MwkikPdrhlts
	0IZ0bFTyiiKGmEj78Kx5Nv060F73ONPgsKCyJjEix
X-Gm-Gg: AR+sD13g2T7RL7gw4C16NdcWPJT5Po/5YSByrTo7jfDBvRmP/1Sq4CAPiHLBH2f1Wg5
	QZk7xDqNyddJCyBnXZqnZy1AcAwQe7uLsXAIFG/zgGDXscoypg0uLDaafucEcwrny6Af1A8gHX0
	YzmxyEeQib2Xt+jUbA1y8KDiBFdpfQrrIB3XkObwlx9VAyMwhVk0ep3iyW9/r6T6dRH2Cwr0Bh9
	0p4KT+Gyh23AyLPS2kyNJbLkGO2AJwJ18E9uB1Dx6xVMv012MYgEO7++cTwon/oM65hhgQJ/KJ0
	WqAcqq7VEvj53A0/KqguNi4jz0XcPeW3ZXknWelVDX3tdw==
X-Received: by 2002:ac8:6f12:0:b0:517:64f6:3365 with SMTP id
 d75a77b69052e-52d8463bf0dmr5192551cf.4.1786819233616; Sat, 15 Aug 2026
 11:40:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815082048.4043217-1-irogers@google.com> <20260815172712.50119-1-irogers@google.com>
In-Reply-To: <20260815172712.50119-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 15 Aug 2026 11:40:21 -0700
X-Gm-Features: AcwNN1UYlMmOx40Qfkx7nmmfd_CnoRWUIPJvxm0HW-dAz61-gmhbNaolDhGzeG8
Message-ID: <CAP-5=fU2iOANQkoviXOJp=wt-a2A0xfCJSJB0nBs=gq1-PVp4A@mail.gmail.com>
Subject: Re: [PATCH v13 0/3] perf: Add Raspberry Pi AXI PMU driver
To: irogers@google.com, florian.fainelli@broadcom.com, 
	linux-perf-users@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	pbrobinson@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 10:27=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Motivation & Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> Currently, Linux lacks a standard perf-API compatible driver for the
> Broadcom AXI performance counter blocks on Raspberry Pi platforms.

The patches now have no Sashiko reported issues except for the
deliberate backward compatibility #ifdef to support earlier than Linux
6.13 builds (I believe Raspberry Pi OS is currently using the LTS
v6.12 kernel and when they switch to v6.18 this can be removed):
https://sashiko.dev/#/patchset/20260815172712.50119-1-irogers%40google.com

If you are testing the patches the easiest way (imo) is to build them
outside the Linux tree doing something like:

# Remove the non-perf driver
$ sudo rmmod raspberrypi_axi_monitor

In a directory have rpi_axi_pmu.c (from the patches) and a Makefile with:
```
obj-m +=3D rpi_axi_pmu.o

KDIR ?=3D /lib/modules/$(shell uname -r)/build
PWD  :=3D $(shell pwd)

default:
        $(MAKE) -C $(KDIR) M=3D$(PWD) modules

clean:
        $(MAKE) -C $(KDIR) M=3D$(PWD) clean
```
then run make and `sudo insmod rpi_axi_pmu.ko`.

On a Raspberry Pi 4 and earlier you should be able to test counters like:
```
$ sudo perf stat -e rpi_axi_pmu/h264_rtrans/,rpi_axi_pmu/h264_wtrans/
-a -- ffmpeg -vcodec h264_v4l2m2m -i test.mp4 -f null -
ffmpeg version 5.1.9-0+deb12u1+rpt1 Copyright (c) 2000-2026 the FFmpeg
developers
  built with gcc 12 (Debian 12.2.0-14+deb12u1)
  configuration: --prefix=3D/usr --extra-version=3D0+deb12u1+rpt1
--toolchain=3Dhardened --incdir=3D/usr/include/aarch64-linux-gnu
--enable-gpl --disable-stripping --disable-mmal --enable-gnutls
--enable-ladspa --enable-libaom --enable-libass --enable-libbluray
--enable-libbs2b --enable-libcaca --enable-libcdio --enable-libcodec2
--enable-libdav1d --enable-libflite --enable-libfontconfig
--enable-libfreetype --enable-libfribidi --enable-libglslang
--enable-libgme --enable-libgsm --enable-libjack --enable-libmp3lame
--enable-libmysofa --enable-libopenjpeg --enable-libopenmpt
--enable-libopus --enable-libpulse --enable-librabbitmq
--enable-librist --enable-librubberband --enable-libshine
--enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libsrt
--enable-libssh --enable-libsvtav1 --enable-libtheora
--enable-libtwolame --enable-libvidstab --enable-libvorbis
--enable-libvpx --enable-libwebp --enable-libx265 --enable-libxml2
--enable-libxvid --enable-libzimg --enable-libzmq --enable-libzvbi
--enable-lv2 --enable-omx --enable-openal --enable-opencl
--enable-opengl --enable-sand --enable-sdl2 --disable-sndio
--enable-libjxl --enable-neon --enable-v4l2-request --enable-libudev
--enable-epoxy --libdir=3D/usr/lib/aarch64-linux-gnu --arch=3Darm64
--enable-pocketsphinx --enable-librsvg --enable-libdc1394
--enable-libdrm --enable-vout-drm --enable-libiec61883
--enable-chromaprint --enable-frei0r --enable-libx264
--enable-libplacebo --enable-librav1e --enable-shared
  libavutil      57. 28.100 / 57. 28.100
  libavcodec     59. 37.100 / 59. 37.100
  libavformat    59. 27.100 / 59. 27.100
  libavdevice    59.  7.100 / 59.  7.100
  libavfilter     8. 44.100 /  8. 44.100
  libswscale      6.  7.100 /  6.  7.100
  libswresample   4.  7.100 /  4.  7.100
  libpostproc    56.  6.100 / 56.  6.100
Input #0, mov,mp4,m4a,3gp,3g2,mj2, from 'test.mp4':
  Metadata:
    major_brand     : isom
    minor_version   : 512
    compatible_brands: isomiso2avc1mp41
    encoder         : Lavf59.27.100
  Duration: 00:00:05.00, start: 0.000000, bitrate: 204 kb/s
  Stream #0:0[0x1](und): Video: h264 (High) (avc1 / 0x31637661),
yuv420p(tv, smpte170m, progressive), 640x480, 202 kb/s, SAR 1:1 DAR
4:3, 30 fps, 30 tbr, 15360 tbn (default)
    Metadata:
      handler_name    : VideoHandler
      vendor_id       : [0][0][0][0]
      encoder         : Lavc59.37.100 h264_v4l2m2m
[h264_v4l2m2m @ 0x559bdbefb0] Using device /dev/video10
[h264_v4l2m2m @ 0x559bdbefb0] driver 'bcm2835-codec' on card
'bcm2835-codec-decode' in mplane mode
[h264_v4l2m2m @ 0x559bdbefb0] requesting formats: output=3DH264 capture=3DY=
U12
Stream mapping:
  Stream #0:0 -> #0:0 (h264 (h264_v4l2m2m) -> wrapped_avframe (native))
Press [q] to stop, [?] for help
Output #0, null, to 'pipe:':
  Metadata:
    major_brand     : isom
    minor_version   : 512
    compatible_brands: isomiso2avc1mp41
    encoder         : Lavf59.27.100
  Stream #0:0(und): Video: wrapped_avframe, yuv420p(tv,
smpte170m/bt470m/bt709, progressive), 640x480 [SAR 1:1 DAR 4:3],
q=3D2-31, 200 kb/s, 30 fps, 30 tbn (default)
    Metadata:
      handler_name    : VideoHandler
      vendor_id       : [0][0][0][0]
      encoder         : Lavc59.37.100 wrapped_avframe
frame=3D  150 fps=3D0.0 q=3D-0.0 Lsize=3DN/A time=3D00:00:05.00 bitrate=3DN=
/A
speed=3D12.9x
video:69kB audio:0kB subtitle:0kB other streams:0kB global headers:0kB
muxing overhead: unknown

 Performance counter stats for 'system wide':

       429,721,472 Bytes rpi_axi_pmu/h264_rtrans/
       163,431,488 Bytes rpi_axi_pmu/h264_wtrans/

       2.152513625 seconds time elapsed
```

and on a Raspberry Pi 5 like:
```
$ sudo perf stat -e
rpi_axi_pmu/a76_dsu_l3_rtrans/,rpi_axi_pmu/a76_dsu_l3_wtrans/,rpi_axi_pmu/d=
ma_l2_wtrans/
-a -- sh -c 'dd if=3D/dev/zero of=3D/dev/shm/test_ram bs=3D1M count=3D1000 =
&&
rm /dev/shm/test_ram'
1000+0 records in
1000+0 records out
1048576000 bytes (1.0 GB, 1000 MiB) copied, 0.255655 s, 4.1 GB/s

 Performance counter stats for 'system wide':

             2,656 Bytes rpi_axi_pmu/a76_dsu_l3_rtrans/
             1,152 Bytes rpi_axi_pmu/a76_dsu_l3_wtrans/
               576 Bytes rpi_axi_pmu/dma_l2_wtrans/

       0.279860667 seconds time elapsed
```

Thanks,
Ian
