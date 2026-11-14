Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633915;
	b=G2PERFo3UhdS1U/eLRuNIr/bEDk9LHeYp5Cj7N6eyZPtsbU0DQ2rHFzuD3f0VhfR2I3N
	 T32kii5/7rkKvV0sZ/4CDq+rRsEUXoGGTUzlX1BjSdh1icNJO4PqhsxlSbFeJgcUFYK2h
	 sDamW4iTQAD7enM6xvUNPXbfhejIYILdCxMCrjV7bHWjwCZd0UvMPSa8EF3fMjupFrK2J
	 Qh8OXrxB5PoO5gTk84pw/bavi8hdxob2q5yBKRqi2FN8apUCMFoqX7SG9JWY/d+CIoOUS
	 Tzisb2gzuT/GYh5cUar2t/AKj7mTMzXzNTUupc7Ybk4QcyyNJbSG9o7RtZXSnRau6bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633915;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=G957/sYSSjsxjXZ6xa/V+ZGQcypevMQZrpwRMmbz3rI=;
	b=cwXWFD+Dl9pAMYxjbq2wbv0KnjHziEejiHqjiZbnZrkWh6n9oNFLOmKJI7ForO4BgLTV
	 UwLMuPBSSTAFNreqeD5E+wryKCC9RroQPuwg0pEbjPhnVTWh79sbgaurmY4yuC9ryJWAq
	 8ExakOuqO1M6if+ZaBkzj2yBWC82j2kLBq/+EkAI3oJBkPaZrprC1Fkqe2IEG7ZjYAcVf
	 b5QI2YkkFHuRiYNAOV1DnExIDXB7oyCQKsLbJ7hLNnADBi4OnMTU4IkmlkBnbo6uG1f6o
	 oUPtN94/Cgia+ao0PBhajUFBNyMjFwD6C7xV9R7LHIXmMkmqofGVB9EPP1EoUfgNZTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=h3oMVmAo;
	arc=none smtp.remote-ip=185.70.43.18
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FAA606A327
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 05:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92FAA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=h3oMVmAo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1794633908; x=1794893108;
	bh=G957/sYSSjsxjXZ6xa/V+ZGQcypevMQZrpwRMmbz3rI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=h3oMVmAopLQfnIYX/WY17dQfkb3DrY/KbOWg13XYhq7ETZuORtXvba358moIARq+f
	 +ddUkJED1ugY8XVIU/aRwbJn9QF0nTKe1U7eBC5KnyuXGp8de9dtW9RkIAMrzsiyqt
	 hAhscnTT82FkjBtYfJFZr0LSIQKYOVHdQdFTSFlrqT2RX7RcOtnpOEDA7uwahNZBKQ
	 FFUDOgglCBiG58XPNs8ovWKWNT5jLgaO9vRRrzO8HnUgOSVpvIjdObttbRRcsqrXK5
	 H2w4aGSQlp8kONtET/0Xtu6WY1ecIhGRlXyTaNKSTZfeUmkBQydwIU6f6swUCtk0BT
	 ETCbGBNRtWiaA==
Date: Sat, 14 Nov 2026 05:25:01 +0000
To: Namhyung Kim <namhyung@kernel.org>
From: Paul Moses <p@1g4.org>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] perf record: reject CPU indices equal to the mask size
Message-ID: <IXvxC0HMcBQR9FfdoTQXA2g84e5zjblvs2JieHL43ZVk00pM5aBX4sAeleDdL2AYcb6YF0rxFcdcOOd4CKrT4kJBRgnrYaVv6Cqpqcc9-sE=@1g4.org>
In-Reply-To: <au1_ow_duqzf7nyY@google.com>
References: <20261030064825.2156317-1-p@1g4.org> <au1_ow_duqzf7nyY@google.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 6a3d9a7cbb06d8b5f2a4c2166ce1a1c097ee46c4
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Friday, November 6th, 2026 at 1:20 AM, Namhyung Kim <namhyung@kernel.org=
> wrote:

> On Fri, Oct 30, 2026 at 06:48:50AM +0000, Paul wrote:
> > From: Paul Moses <p@1g4.org>
> >
> > record__mmap_cpu_mask_init() rejects CPU indices greater than nbits but
> > accepts nbits itself. Valid indices end at nbits - 1. When nbits is a
> > multiple of BITS_PER_LONG, __set_bit() accesses the word immediately pa=
st
> > the bitmap allocation.
> >
> > User specified recording thread masks reach this write before they are
> > intersected with the selected CPU mask. For example, an affinity mask
> > containing CPU 64 overruns a bitmap allocated for 64 possible CPUs.
>=20
> What's the exact command line?
>=20

  mkdir -p /tmp/perf-asan-build
  make -C /usr/src/linux-7.x/tools/perf O=3D/tmp/perf-asan-build -j"$(nproc=
)" \
    WERROR=3D0 NO_RUST=3D1 NO_SHELLCHECK=3D1 NO_LIBPYTHON=3D1 \
    EXTRA_CFLAGS=3D'-fsanitize=3Daddress -fno-omit-frame-pointer -g' \
    LDFLAGS=3D'-fsanitize=3Daddress' perf

  qemu-system-x86_64 -enable-kvm -cpu host -smp 64 -m 4G \
    -kernel /boot/vmlinuz-$(uname -r) \
    -initrd /tmp/perf-guest-sym.cpio.zst \
    -append 'console=3DttyS0 rdinit=3D/init panic=3D-1 loglevel=3D4' \
    -nographic -no-reboot

  ASAN_SYMBOLIZER_PATH=3D/bin/llvm-symbolizer \
  ASAN_OPTIONS=3Ddetect_leaks=3D0:abort_on_error=3D1:symbolize=3D1 \
  /perf record -e cpu-clock -C 0 --threads=3D0/64 -o /tmp/perf.data -- slee=
p 0.05

RUNNING: perf record -e cpu-clock -C 0 --threads=3D0/64
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D540=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address 0x6=
c9cc78223b8 at pc 0x60af685bdb4d bp 0x7ffd1e954400 sp 0x7ffd1e9543f8
READ of size 8 at 0x6c9cc78223b8 thread T0
    #0 0x60af685bdb4c in ___set_bit /usr/src/linux-7.x/tools/include/asm-ge=
neric/bitops/non-atomic.h:22:6
    #1 0x60af685bdb4c in record__mmap_cpu_mask_init /usr/src/linux-7.x/tool=
s/perf/builtin-record.c:3695:3
    #2 0x60af685bde4d in record__mmap_cpu_mask_init_spec /usr/src/linux-7.x=
/tools/perf/builtin-record.c:3710:6
    #3 0x60af685bde4d in record__init_thread_masks_spec /usr/src/linux-7.x/=
tools/perf/builtin-record.c:3819:9
    #4 0x60af685b9bcc in record__init_thread_user_masks /usr/src/linux-7.x/=
tools/perf/builtin-record.c:4015:8
    #5 0x60af685b9bcc in record__init_thread_masks /usr/src/linux-7.x/tools=
/perf/builtin-record.c:4075:9
    #6 0x60af685b809a in cmd_record /usr/src/linux-7.x/tools/perf/builtin-r=
ecord.c:4395:8
    #7 0x60af686cc167 in run_builtin /usr/src/linux-7.x/tools/perf/perf.c:3=
48:11
    #8 0x60af686cb739 in main /usr/src/linux-7.x/tools/perf/perf.c
    #9 0x707cd1a470b9  (/lib/ld-musl-x86_64.so.1+0x690b9) (BuildId: d1535db=
89359be00fb635e9145a3a49d0cbd8261)

0x6c9cc78223b8 is located 0 bytes after 8-byte region [0x6c9cc78223b0,0x6c9=
cc78223b8)
allocated by thread T0 here:
    #0 0x60af685506d2 in calloc (/perf+0xc266d2) (BuildId: c5c8ceb2947501d8=
a08fbc5dd506840be170f336)
    #1 0x60af685bdcd9 in bitmap_zalloc /usr/src/linux-7.x/tools/include/lin=
ux/bitmap.h:121:9
    #2 0x60af685bdcd9 in record__mmap_cpu_mask_alloc /usr/src/linux-7.x/too=
ls/perf/builtin-record.c:3093:15
    #3 0x60af685bdcd9 in record__thread_mask_alloc /usr/src/linux-7.x/tools=
/perf/builtin-record.c:3117:8
    #4 0x60af685bdcd9 in record__init_thread_masks_spec /usr/src/linux-7.x/=
tools/perf/builtin-record.c:3807:8
    #5 0x60af685b9bcc in record__init_thread_user_masks /usr/src/linux-7.x/=
tools/perf/builtin-record.c:4015:8
    #6 0x60af685b9bcc in record__init_thread_masks /usr/src/linux-7.x/tools=
/perf/builtin-record.c:4075:9
    #7 0x60af685b809a in cmd_record /usr/src/linux-7.x/tools/perf/builtin-r=
ecord.c:4395:8
    #8 0x60af686cc167 in run_builtin /usr/src/linux-7.x/tools/perf/perf.c:3=
48:11
    #9 0x60af686cb739 in main /usr/src/linux-7.x/tools/perf/perf.c
    #10 0x707cd1a470b9  (/lib/ld-musl-x86_64.so.1+0x690b9) (BuildId: d1535d=
b89359be00fb635e9145a3a49d0cbd8261)

SUMMARY: AddressSanitizer: heap-buffer-overflow /usr/src/linux-7.x/tools/in=
clude/asm-generic/bitops/non-atomic.h:22:6 in ___set_bit
Shadow bytes around the buggy address:
  0x6c9cc7822100: fa fa fd fa fa fa 00 fa fa fa 00 fa fa fa fd fa
  0x6c9cc7822180: fa fa 01 fa fa fa 00 fa fa fa fd fa fa fa 00 fa
  0x6c9cc7822200: fa fa 00 fa fa fa 00 fa fa fa 00 fa fa fa 00 fa
  0x6c9cc7822280: fa fa 02 fa fa fa 00 fa fa fa 03 fa fa fa fd fa
  0x6c9cc7822300: fa fa fd fa fa fa 00 fa fa fa 00 fa fa fa 00 fa
=3D>0x6c9cc7822380: fa fa 00 fa fa fa 00[fa]fa fa fd fd fa fa fd fa
  0x6c9cc7822400: fa fa 00 02 fa fa 00 fa fa fa fa fa fa fa fa fa
  0x6c9cc7822480: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x6c9cc7822500: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x6c9cc7822580: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x6c9cc7822600: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07=20
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
=3D=3D540=3D=3DABORTING
Aborted
PERF_RC=3D134

