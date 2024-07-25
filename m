Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3933DC8DF
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Jul 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721914634; cv=none; b=oheCVtzF5aKXhJ1aMvzCBV4uRsRwZLd/XoZt6BnEYpf2Dy0c0L2NRy/v2iCynm15aE9e4cQEww5eYPARzM0dK4pS8AQn5hu7Hl0a8rkQVeLg6D28dmTsXxODNHLaIsmfrrNNi84BxV+VSwXujy7MWS0ZUVneb3kVM6wsSxcD/2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721914634; c=relaxed/simple;
	bh=o0uQJvVuRQKtdPILxw5p5qFJkqyt1RvqnNIoq//MgM4=;
	h=From:Message-ID:Date:MIME-Version:To:Subject:Content-Type; b=bxcfiR1tL4DWgtyrIunOnXlEstjVqCbDdUuhAY41U6JIREMqcUMMm+s8h6AYyKTjXdZVBigr/eqNbcEQhzzzYqNaGnvNqWNp20CyblB50eBwdln7xMv2GuoYiPunrFwHTT73gFnl2tgHbTXDVMpzHuo1dICisTeT9BEaBOidoWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwNaYzRc; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwNaYzRc"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1fc66fc35f2so14589935ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Jul 2024 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721914632; x=1722519432; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:to:content-language
         :reply-to:user-agent:mime-version:date:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbEyqxt3pbwRLyaSYBtgl2ErzpCrkUKF/ERBBrfvCk0=;
        b=DwNaYzRcrSPCPAOKB46kYWXmsdLsEYOuZn7U7Avn/FBulazbxCNUF+OV/uINABISg0
         0TOUt97hvzH50srEZcnyUTc7JJlFXkf3uBGUC1MPOjWCSSZ5EswZUmI4oiXHEtJ+80PI
         nSYhQqyZ2KNK8TspIRIoJmw0vSCvjj7iMtiUIDaZD/MuZxSvRO12pLpzDwIYONrnVH32
         uh75x75ed4VNO1bno51XtEHtogZzIVHdFNnqxg8p1hHwi0dl7z0OZy5VxxHmP4lkSx96
         dm9KZRE16FCRzrIiWj5OO/MTHTgH8+tAzjURVYdVvUauXNiSY3TXphSxilQPa/FEvDJt
         A2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721914632; x=1722519432;
        h=content-transfer-encoding:autocrypt:subject:to:content-language
         :reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UbEyqxt3pbwRLyaSYBtgl2ErzpCrkUKF/ERBBrfvCk0=;
        b=IUHvPcbbeMzIlgrYfKNWgkS29KO0tKNPMjY8+smYc+DKJQPGX2EWxNy33X9rG+U0c2
         VA9KNPx4f0WApf51VBmRG+XBZp6cHoODyZ6HfdD0pnnjCib+IdTlzoVT4R2pfbMvWb4r
         i5YdFxgo2NexZvPD3S/Z7QaRLNlCkPC9un4uesQg2DLxlzM5LHwpC4yOemdZqzOy7lJl
         0qnoXpjvmQdVzu4vWaTBpS1ThYl77RXRveyxjptQXOQqvvXPooSx7DDLFTJu3h4Mz6Xt
         cFcE6fdy+FovTpQjf1Nt82Slj7NNQor1vvUhVgiQgsvY77CZudU48vQb9H2Ni4h+NbnH
         7ZHg==
X-Gm-Message-State: AOJu0Yw14xW9M6uyWhw4DGn8qI520epdFEO7P8CcB5yPSovpa8R5+sKP
	Ym8MT35MF8tacd5QB27pD02FEhqNU+NOWM0WubECwA6BA6Q8DSADFQlZc37r
X-Google-Smtp-Source: AGHT+IFEwYspsD9OI+XUGIgC+IifoxtQPypXFmgzm9/Ua9otpQRnKoMNdRyYTqvwbYHdr/GdSaEkXQ==
X-Received: by 2002:a17:903:32cf:b0:1fb:7e12:ee41 with SMTP id d9443c01a7336-1fdd6e26869mr90113725ad.22.1721914632278;
        Thu, 25 Jul 2024 06:37:12 -0700 (PDT)
Received: from [192.168.0.154] ([116.206.223.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d0023fsm14171555ad.93.2024.07.25.06.37.11
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 06:37:11 -0700 (PDT)
From: bbhtt <bbhtt.zn0i8@gmail.com>
X-Google-Original-From: bbhtt <bbhtt.zn0i8@slmail.me>
Message-ID: <a69b8aca-9b37-4a72-a657-f708696c192b@slmail.me>
Date: Thu, 25 Jul 2024 19:07:09 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Reply-To: bbhtt.zn0i8@slmail.me
Content-Language: en-US
To: linux-perf-users@vger.kernel.org
Subject: Perf is crashing inside Flatpak runtime
Autocrypt: addr=bbhtt.zn0i8@slmail.me; keydata=
 xjMEY56QvBYJKwYBBAHaRw8BAQdANKy2M8mCEDPIat/ExPT0UYcuPEe5+ZNdDOIm/5+xqI3N
 NkJvdWRoYXlhbiBCaGF0dGFjaGFyeWEgKEFsaWFzKSA8YmJodHQuem4waThAc2xtYWlsLm1l
 PsKTBBMWCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE0m11M5UAnbKzsmCUDDJR
 okdF5IQFAmOekjACGQEACgkQDDJRokdF5IT9SQEA596vQJxu0ahysZSVQKxo0BDtzBbcUkdj
 A499fdO5soEA/jQEaE/bmf6jWIB5pw69SwMBOp0bdDyAH+ANfBmfl4AMzjgEY56QvBIKKwYB
 BAGXVQEFAQEHQOo+dkmpNGtRiNUfeEjf+5W6GRbeNioc8WWSjy2BkctaAwEIB8J4BBgWCAAg
 FiEE0m11M5UAnbKzsmCUDDJRokdF5IQFAmOekLwCGwwACgkQDDJRokdF5ISilAEAzB1ST9C6
 h095JnQ3UFZsQQVSq3by9NXMg+sk+9bHkDsA/3yuK5GmtqlvrtaivFVyekZCHfL7NnbzUoeU
 Ag37QMUA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

We were reported by a user that perf is crashing inside the
`org.freedesktop.Sdk` Flatpak runtime.

To reproduce, please install Flatpak for your distribution [1] and
then install the `org.freedesktop.Sdk` runtime using the command
`flatpak install org.freedesktop.Sdk//23.08`. Then get a working shell
inside the sandbox using
`flatpak run --command=sh --devel org.freedesktop.Sdk//23.08`.

Once inside the sandbox, run `perf record -v -- ls` and see that it
crashes.

The output and a backtrace is below. Any help is appreciated. The
downstream issue can be found at [2].

```
perf --version
perf version 6.9.9

perf record -v -- ls
DEBUGINFOD_URLS=
No PMU found for 'cycles:Pu'
Failed to read max cpus, using default of 4096
nr_cblocks: 0
affinity: SYS
mmap flush: 1
comp level: 0
Problems creating module maps, continuing anyway...
No PMU found for 'cycles:u'
No PMU found for 'instructions:u'
No PMU found for 'cpu-clock:u'
mmap size 528384B
libperf: Miscounted nr_mmaps 0 vs 1
Control descriptor is not initialized
WARNING: No sample_id_all support, falling back to unordered processing
Couldn't start the BPF side band thread:
BPF programs starting from now on won't be annotatable
perf: Segmentation fault
Obtained 13 stack frames.
perf(sighandler_dump_stack+0x48) [0x55fab63072a8]
/usr/lib/x86_64-linux-gnu/libc.so.6(+0x3ee80) [0x7f2f4ac51e80]
perf(perf_cpu_map__max+0x4) [0x55fab63f3104]
perf(+0x1de854) [0x55fab635d854]
perf(perf_event__synthesize_cpu_map+0x56) [0x55fab6360c76]
perf(+0x854cf) [0x55fab62044cf]
perf(+0x88e2c) [0x55fab6207e2c]
perf(cmd_record+0xf95) [0x55fab620b155]
perf(+0x12e8b1) [0x55fab62ad8b1]
perf(main+0x687) [0x55fab61f30e7]
/usr/lib/x86_64-linux-gnu/libc.so.6(+0x2808a) [0x7f2f4ac3b08a]
/usr/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x8b) [0x7f2f4ac3b14b]
perf(_start+0x25) [0x55fab61f3425]
Segmentation fault (core dumped)
```

```
perf_cpu_map__max (map=0x0) at cpumap.c:382
382		return __perf_cpu_map__nr(map) > 0
(gdb) bt
#0  perf_cpu_map__max (map=0x0) at cpumap.c:382
#1  0x0000555555732854 in cpu_map_data__alloc (syn_data=syn_data@entry=0x7fffffff7c80, header_size=header_size@entry=8) at util/synthetic-events.c:1289
#2  0x0000555555735c76 in cpu_map_event__new (map=<optimized out>) at util/synthetic-events.c:1337
#3  perf_event__synthesize_cpu_map (tool=tool@entry=0x555555eb4b80 <record>, map=<optimized out>, 
    process=process@entry=0x5555555db480 <process_synthesized_event>, machine=machine@entry=0x0) at util/synthetic-events.c:1357
#4  0x00005555555d94cf in record__synthesize (tail=tail@entry=false, rec=0x555555eb4b80 <record>) at builtin-record.c:2103
#5  0x00005555555dce2c in __cmd_record (argc=argc@entry=1, argv=argv@entry=0x7fffffffd880, rec=0x555555eb4b80 <record>) at builtin-record.c:2536
#6  0x00005555555e0155 in cmd_record (argc=<optimized out>, argv=<optimized out>) at builtin-record.c:4257
#7  0x00005555556828b1 in run_builtin (p=p@entry=0x555555eb7728 <commands+264>, argc=argc@entry=4, argv=argv@entry=0x7fffffffd880) at perf.c:349
#8  0x00005555555c80e7 in handle_internal_command (argv=<optimized out>, argc=4) at perf.c:402
#9  run_argv (argv=<synthetic pointer>, argcp=<synthetic pointer>) at perf.c:446
#10 main (argc=<optimized out>, argv=0x7fffffffd880) at perf.c:562
```

[1]: https://flatpak.org/setup/
[2]: https://gitlab.com/freedesktop-sdk/freedesktop-sdk/-/issues/1739

- bbhtt

https://bbhtt.github.io/

