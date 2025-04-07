Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39821B4F0A
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744005758; cv=none; b=fNc9CpSKr2rJlUejpJSvVCJ0EiR/8dk9hDMtyxpvzWbSWRfk7zSJqYUkX6W8WEcVqibkn/dAY589oliFkhVnAJtPCSte1OekWAApZiveskRgnqrrOL9YM5pI7KL7RD9Ns7suj/c+Y0fUOgYN0KThfdHjYugfqzhLz3Rr3eKW/w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744005758; c=relaxed/simple;
	bh=D9b4/gGBQHas3H4BpxL1TtToyw3tCTKzfitMjfeJox8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=maNJg9gUGPpE9UQy6B4fcxAOa9L4WXcIdE9Ax8hwjPKuSgWCHLYniss23gXSiYyOvwS13Yid1+/6BRDnfzpJzlPB43K4B/uW54fETc79HQbD31Afkde6fUnwZyHhgINbUDwF2p9tjeqnM3zRwASmLjl0lRbngFI9ipyzJEW3jb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFsI353d; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFsI353d"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e6e50418da6so220423276.3
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Apr 2025 23:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744005755; x=1744610555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ig4ialZg7LHojDgPuHoIWpgNP14xYntB99BIWw3Jyzo=;
        b=LFsI353dx4aKTYcF1i/68tyZQee+rIzCyXyiHxkwYs5z5GFOk6TODnMCVHy5rxEk9v
         YcgMmBlWBWZEmlzVTt6q5MQJUganv5xxFzVG1Q08L9LP6r7tCHw+ijhwNBBSvLTApfF4
         E1ed/CHWcmHgEOZ2pK7D6Va1467iBaw2Laf3xz6SBXmdMc0PLu9GFyGrQ1oBHV28AV5Y
         LMvTBHQzV4nRQm0HuFu8aEgHekkioHvXn3+BcSAX/16G/WLWTt55ts974y0fJ4dTK8OJ
         wRQa0uF+t+o/kIvg+xT/EeC7/7Briqi/EdpUIdJiKf9VTPzFtVVu+wuFt0xeiu/01xxw
         5xRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744005755; x=1744610555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ig4ialZg7LHojDgPuHoIWpgNP14xYntB99BIWw3Jyzo=;
        b=UThhinowaxFr2I1EvOLxRvdoXJliJRYiR0qu0s7O4EgYlkLuxuVHH2ctcf6hkinU4p
         A5Y6OoIiywTX3Bpj78e6NzpgiGDrEUyoUAhstqIn4It9nzzu5RoPCBz2wXKUJiTHUhgB
         qs97bN/AlzVcCaDll3Y0/ImpuOX+XEz+XJD5D0R4pld8hxPvdGNaKTGbMd71Vci3sPCk
         WF3q43+mS/V11SLCFC+UWlHLSxaXbFhQmIJK10h2zRrRJVnnpxpGECXiLvzKkFbn0yti
         8+VEGsaGzeR19AGBJZLZrtfEyq3v8PsaOhr6p3j0O/15SQ/OsNZaXqio6w8YBRk5crbl
         k7lA==
X-Forwarded-Encrypted: i=1; AJvYcCW559f7o9OzUGBfzkw5BAqIpSUj1HvlHyfOFWjR3AbhJW821FXgaHyUDeLK+04S6eOTUDySDKw8Bjz3CcgWqFwZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzOy/ZS2ADZvz23MCsSNA5XHaQWz5bv5gu9HCr/zYOiNVjTaJTi
	EOU5TqEuODGn1FVA1gw4XjHZRyZZhMWb17hrcGQEqK7eYW6K6Q+PnFotebgDkWmFioUGYcF8YOZ
	58AdHvsbgrO6SH6KxTHSCobUz9xU=
X-Gm-Gg: ASbGnctTSLSofgicC9CjLByy+S+XLGb5VNNf7nKYRDReOOkKhrQ64/Dy0+ipeu0GlR8
	aY7w8pR1D/BJFB3I8SGrhwJZp5N60oBARi2An95BfrBQkOIvLxqFEzDL/AETzRnWPWxpgJYu5FG
	2aiqbrp63Q9+ixvLnMao1ZiOXi
X-Google-Smtp-Source: AGHT+IGOxfSVW0Y5YUuXLK2a3/Q7qUWs13r8P3pgz+GMamk6on1P/R3ydnlpmFXN3BH1dSOcp9wv8tBQnaFLyj7QELg=
X-Received: by 2002:a05:6902:12ce:b0:e6e:1892:6288 with SMTP id
 3f1490d57ef6-e6e1f9b147emr18591763276.16.1744005755580; Sun, 06 Apr 2025
 23:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307080829.354947-1-namhyung@kernel.org> <Z9tjKcKvjYgbR6hb@google.com>
 <Z9vgt1pjiNbDBDbM@gmail.com> <Z9w_aFlzOkoCTSqK@google.com>
 <Z-EJnye74la1triY@gmail.com> <Z--pWmTHGb62_83e@gmail.com>
In-Reply-To: <Z--pWmTHGb62_83e@gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Sun, 6 Apr 2025 23:02:24 -0700
X-Gm-Features: ATxdqUHhkJJdWvs3K_gACfWJWp7sbQDpiJ0N2KjMbNZ0EY1gHWC1-KpWPn_T7LQ
Message-ID: <CAH0uvoi3oaZesWKLtaJRm3AkJx9j-G_Xm66Z276xH5+k11zisQ@mail.gmail.com>
Subject: Re: [perf top] annotation doesn't work, libunwind doesn't seem to be
 working either
To: Ingo Molnar <mingo@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ingo,

I use Ubuntu 24.10 too and my cpu is also x86_64, so I am taking a look.

On Fri, Apr 4, 2025 at 2:42=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> BTW., here's a few other 'perf' annoyances I have, if anyone's
> listening :-)
>
>
> 1)
>
> I cannot get the libunwind build-feature failure to go away:
>
> ...                               libcrypto: [ on  ]
> ...                               libunwind: [ OFF ]
> ...                             libcapstone: [ on  ]
> ...                               llvm-perf: [ on  ]
>
> I do have libunwind-dev installed:
>
> ii  libunwind-dev:amd64                                         1.6.2-3.1=
                                           amd64        library to determin=
e the call-chain of a program - development
> ii  libunwind8:amd64                                            1.6.2-3.1=
                                           amd64        library to determin=
e the call-chain of a program - runtime
>
> but it fails to link:
>
>  kepler:~/tip/tools/build/feature> cat test-libunwind.make.output
>  /usr/bin/ld: /tmp/cc2BfaNM.o: in function `main':
>  test-libunwind.c:(.text+0x1c): undefined reference to `_Ux86_64_create_a=
ddr_space'
>  /usr/bin/ld: test-libunwind.c:(.text+0x44): undefined reference to `_Ux8=
6_64_init_remote'
>  /usr/bin/ld: test-libunwind.c:(.text+0x6b): undefined reference to `_Ux8=
6_64_dwarf_search_unwind_table'
>  collect2: error: ld returned 1 exit status

 $ make test-libunwind.bin
gcc  -MD -Wall -Werror -o test-libunwind.bin test-libunwind.c  >
test-libunwind.make.output 2>&1 -lelf -llzma
make: *** [Makefile:212: test-libunwind.bin] Error 1
 $ cat test-libunwind.make.output
/usr/bin/ld: /tmp/ccPpmuee.o: in function `main':
test-libunwind.c:(.text+0x1c): undefined reference to
`_Ux86_64_create_addr_space'
/usr/bin/ld: test-libunwind.c:(.text+0x44): undefined reference to
`_Ux86_64_init_remote'
/usr/bin/ld: test-libunwind.c:(.text+0x6b): undefined reference to
`_Ux86_64_dwarf_search_unwind_table'
collect2: error: ld returned 1 exit status

You mentioned your machine is x86_64, I ran
 $ make test-libunwind-x86_64.bin
gcc  -MD -Wall -Werror -o test-libunwind-x86_64.bin
test-libunwind-x86_64.c  > test-libunwind-x86_64.make.output 2>&1
-lelf -llzma -lunwind-x86_64
 $

And it successfully built test-libunwind-x86_64.bin for me.

>
> I tried to install the libunwind-19-dev package, I tried to
> uninstall/reinstall - no combination seems to work.

 $ apt list --installed | grep libunwind

WARNING: apt does not have a stable CLI interface. Use with caution in scri=
pts.

libunwind-dev/oracular,now 1.6.2-3.1 amd64 [installed]
libunwind8/oracular,now 1.6.2-3.1 amd64 [installed,automatic]

Built perf with make clean install, my libunwind is on.

...                               libunwind: [ on  ]

But when I ran perf check,

 $ perf check feature libunwind
             libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT

libunwind is OFF.

plot twist: I uninstalled libdw, now libunwind is OFF.
...                                   libdw: [ OFF ]
...                                   glibc: [ on  ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ OFF ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

So they are somehow tied together. Don't know how to fix it yet. So
maybe try installing libdw for a usable perf annotate?

Thanks,
Howard
