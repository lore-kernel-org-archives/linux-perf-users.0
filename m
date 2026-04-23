Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6718F49
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918126; cv=pass; b=qO4deHyC1psTeM/0ufRoA78vXUhLYHwsYoPYCeg1ldcMywpAbeUj7ah7pek8nzAn3kgREzvd5Jj8uqMnPq5612rzbgMKZkWREk5k5JucOoAXx2myuDnYkQxlO3RcntmPpH2q8k8xJA5w058nkrcb2aVe5cvdE6pMTjq35Wi1wkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918126; c=relaxed/simple;
	bh=xWSoYJJpnhe0qxCauru24BDnrYYmdqLDSeDes/7Q0gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkbCmEs9GqiNPEudDfX+Zop/yPLL6JSdnhu2DLeb05yfEMyooAVlfErBbYU9mlWy8RJhkvXynqF6NbXHTvOOxW/NB+RFgIk5FxFSKtIxloMXuk9BASllds5yIzdET4fs7MopJhRJfjwIS9ShWtMvLqNe29SSw6JonTSAKgwaOuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQL5w7KN; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQL5w7KN"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b46da8c48eso75605ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 21:22:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776918124; cv=none;
        d=google.com; s=arc-20240605;
        b=itF8gFB4au3iGh4B2BKVCEjtkYnEq1VsEJgjaQrUgunCMXbb8soQk4ustQ0YyokPs3
         uC13Ginbl2rPHQzLwu+vkGeaZW1Qp2utuk6+wOz5rvo3oYT9WnKaMgA6kx3GRx+LVKVU
         VDmc4zbyk1iCusqCZ3gPgYXYu6w1d2ci2HhA0QJ7lHKhW4VRb8B6gX0LwWMnfoH8e8TP
         6hUMrqZF2Zl2pvkCnp6o5UAaWi3wQjwomkH7sYck3hqhWJy/xmc2aY+YfTd4MBwJUY/9
         ZE7cZYI6L3bRATmC5JjsBvDArkMRa6S58a1/RuOoHIsAdPh6jbrx+sUQsRbyL/M08z2v
         +Yhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dvdyVuZzeVb4GWq7NMffr9IUMTRihrJZDULnC7CA6QY=;
        fh=MuBTXxFPy+gnNBVZRRvkhNnGFj0dbX575UYG89B7ycE=;
        b=Q5QRa4V5T+o9m/cHQev1swRPaOB01bUYOS7+xA/4QkH0+W1nL8XJH9u6zOvv/3yQBT
         LalnWY7ZmT5qPrTLmHWHDbhHSCM4DBYU+zArnOwm/FHwmUApTEpPEUFdTtaMBuukvAHW
         W+f8pQlJtRZAl5N5+Gc2h/ZzpiPgsUwZlXdVWEMD6oN+rMKGcEs2IdOSWEDoMkrDgj16
         mnyJ3Ibne1KZkRhKwYoAed91A/LcLOWCyQX7h2Eq1lag8fN+9O45j7+8I9etFlavukN1
         3qWyesq0ylhp9r6LU4XVcVRtdgK7GUBTdHVi1Q6MfJyFJqhr3+Ix5o0nJDnU/p3bESvy
         D13A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776918124; x=1777522924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvdyVuZzeVb4GWq7NMffr9IUMTRihrJZDULnC7CA6QY=;
        b=XQL5w7KNrAxf5RwYYUzQAGEupJHPOdLcM6OvNXt9LfJn7DB+5QB5mJFS8uRa++GokA
         PYuc7r0q0J52BoEjk1GV4YCLfWdZmTia6isMTySL7FxMKhwsP3BkEZHx4kpOx2FU1tg4
         mOE5+eveR9GvdUv6W+OrxAvu1vGh07r2rzJ7USbdUXFDeENjSKbtASN9sMf2DfhJEKg+
         Qg0taxDdScL75ojjFFygVSBOQzCOHLbygBtBrDzRyCdHmQX3iBnJJ/399wu68JfgCA3m
         6IpeMqdZgaHOk1ECg+ryhvNBGus80sNLFRa4RdTjKQKTlO0Uzg4dU1rn5jZqnMpVwqEs
         +MMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776918124; x=1777522924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dvdyVuZzeVb4GWq7NMffr9IUMTRihrJZDULnC7CA6QY=;
        b=Q9PGNXjx8u4FzTbPl5oO+MYb2Ak7tL8XNWpufkpBjOnN3wi5FMaVyrwdZiv5NEsoKW
         WE8BeVbjzH0WZJOsH49Ff0MUJr6qv6DL7FxaaW5MvkKiBRhd35t2yHPTPrI+vATVJWEy
         Bo5EN5cCOOhB25phN8e3mGBbIMpEACFdChY91s4VYoZacAp7yS71UiC5FbYii5S8dWOJ
         Iak/NQLySpOhejyTTHzyyhy/4l36aLrI6tcvJtqAsEk9MSdt9i9hVK1rivC49aEwfHNl
         ky/jNzmyEMV8NFxHygQF+/YAFDlrrmLd0bccYIZTbGwgGYNEUnrwtcrWr88tfFVu8Bd6
         puKQ==
X-Forwarded-Encrypted: i=1; AFNElJ+EYLS5bB64ERxwZLJooYUSrtMBT+my3qUYspNTD9ipSAp8mPr6Qj1uN9NRTliQkJCktTRl3dF1EEO1Id5OxsE7@vger.kernel.org
X-Gm-Message-State: AOJu0YxuVC7bQCxDe2QHjlK02aCb5lUWAq8YUWyug1Q95oRqtCmEs7DI
	ucsNsbAzzGHg5O8WnjhswwCBvCTZ9PFyd4YTgj/JHxDFoymaF+zObI0xSlYXAZnDMfXPV5aUdli
	+/udlVbtrsXElVbLn5k05U4fr+62TcpuoswdfD+XW
X-Gm-Gg: AeBDiesVoRae8vYkd6v0fokpS6pTaz3Up/uArkxbGzC/izHXGVM29GJi41D4DO5EEhh
	OiCODDFz/CGYgyMmm4YrDLoLtzMqmjwZMHS7z2XI2ETi/TUAlceYKiy2izkE6j+pdYp4GgTNwkr
	ChfjyDRhchFr3DBoGYRTRX7XqFTI/gUVCtzQ/A2PIsrG+Eogk/znIdw573gzcjNbhIbdkWN2nsa
	5WNl5tl/UbUBK8CGtvylEwUVnaJuNjFjV+e3TT9f0qnm3mkeGfJOgLQ/3rivSthMatfX0epIjQM
	WcXK2byLFj12+bEdwZt6rNxL7/3tLQ==
X-Received: by 2002:a17:903:2392:b0:2b0:b925:da98 with SMTP id
 d9443c01a7336-2b603f88d3amr5106245ad.19.1776918123777; Wed, 22 Apr 2026
 21:22:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aejMem8Pt3iCxaka@gentoo.org>
In-Reply-To: <aejMem8Pt3iCxaka@gentoo.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 22 Apr 2026 21:21:52 -0700
X-Gm-Features: AQROBzC3iswIdOMz_o6OTXs0KNQgLmCzFtYQ1SDTPAuqNX0lMH_JtLX8ev7dflM
Message-ID: <CAP-5=fX6PT2FsvAoy+0AGq3AFEQ9XU_HBhGkZdX0fn0Ltss-JA@mail.gmail.com>
Subject: Re: perf performance with libdw vs libunwind
To: Guilherme Amadio <amadio@gentoo.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, libunwind-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 6:26=E2=80=AFAM Guilherme Amadio <amadio@gentoo.org=
> wrote:
>
> Dear Ian,
>
> Now that linux-7.0 is out, I've updated perf in Gentoo and moved it
> to use libdw, as libunwind has been deprecated. However, when I tried
> to use perf, I noticed a substantial performance regression and some
> other problems, which I report below.
>
> I use here an example which is my own "standard candle"=C2=B9 for checkin=
g
> that stack unwinding is working properly: the startup of ROOT=C2=B2, whic=
h
> is a C++ interpreter heavily used in high energy physics data analysis.
> I simply run 'root -l -q' which is the equivalent of 'python -c ""' for
> ROOT. It takes less than a second to run, but since it runs a full
> initialization of Clang/LLVM as part of the interpreter, it produces a
> rich flamegraph that I know ahead of time how it should look like, so
> I use it to check that stack unwinding and symbol resolution are working.
>
> 1. https://en.wikipedia.org/wiki/Cosmic_distance_ladder#Standard_candles
> 2. https://root.cern
>
> Below I show a comparison of the timings of perf record/report for this.
>
> First, I run it with perf-6.19.12 which is configured to use libunwind:
>
> $ perf config
> call-graph.record-mode=3Dfp
> $ perf -vv
> perf version 6.19.12
>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
>             debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
>                  dwarf: [ on  ]  # HAVE_LIBDW_SUPPORT
>     dwarf_getlocations: [ on  ]  # HAVE_LIBDW_SUPPORT
>           dwarf-unwind: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
>                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT ( tip: Deprecated,=
 license incompatibility, use BUILD_NONDISTRO=3D1 and install binutils-dev[=
el] )
>         libbpf-strings: [ on  ]  # HAVE_LIBBPF_STRINGS_SUPPORT
>            libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
>     libdw-dwarf-unwind: [ on  ]  # HAVE_LIBDW_SUPPORT
>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                libLLVM: [ on  ]  # HAVE_LIBLLVM_SUPPORT
>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>             libopencsd: [ OFF ]  # HAVE_CSTRACE_SUPPORT
>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>                libpfm4: [ on  ]  # HAVE_LIBPFM
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
>              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
> $ time perf record -g -F max -e cycles:uk -- root.exe -l -q
> info: Using a maximum frequency rate of 79800 Hz
>
> [ perf record: Woken up 23 times to write data ]
> [ perf record: Captured and wrote 5.688 MB perf.data (19693 samples) ]
> 1.25
> $ time perf report -q --stdio -g none --children --percent-limit 75
>     92.63%     0.00%  root.exe  libc.so.6             [.] __libc_start_ca=
ll_main
>     92.63%     0.00%  root.exe  libc.so.6             [.] __libc_start_ma=
in@@GLIBC_2.34
>     92.63%     0.00%  root.exe  root.exe              [.] _start
>     92.63%     0.00%  root.exe  root.exe              [.] main
>     91.53%     0.01%  root.exe  libCore.so.6.38.04    [.] ROOT::GetROOT()
>     89.36%     0.00%  root.exe  libRint.so.6.38.04    [.] TRint::TRint(ch=
ar const*, int*, char**, void*, int, bool, bool)
>     88.18%     0.00%  root.exe  libCore.so.6.38.04    [.] TApplication::T=
Application(char const*, int*, char**, void*, int)
>     88.10%     0.01%  root.exe  libCore.so.6.38.04    [.] ROOT::Internal:=
:GetROOT2()
>     88.08%     0.00%  root.exe  libCore.so.6.38.04    [.] TROOT::InitInte=
rpreter()
>     75.62%     0.00%  root.exe  libCling.so.6.38.04   [.] CreateInterpret=
er
>     75.62%     0.00%  root.exe  libCling.so.6.38.04   [.] TCling::TCling(=
char const*, char const*, char const* const*, void*)
>
> 1.86
> $ time perf script -c root.exe | ~/bin/stackcollapse.pl --all >| root-per=
f-6.19-libunwind.stacks
> 4.08
> $ flamegraph.pl -w 2560 --title 'Flame Graph: ROOT Startup' --subtitle 'C=
reated with perf-6.19.12 using libunwind' < root-perf-6.19-libunwind.stacks=
 >| root-perf-6.19-libunwind.svg
>
> So, as you can see above, a simple perf-report took 1.86 seconds, and
> perf-script took 4.08 seconds with libunwind. Now with perf upgraded to
> perf-7.0 with libdw, this is what I see:
>
> $ perf -vv
> perf version 7.0
>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
>             debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
>                  dwarf: [ on  ]  # HAVE_LIBDW_SUPPORT
>     dwarf_getlocations: [ on  ]  # HAVE_LIBDW_SUPPORT
>           dwarf-unwind: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
>                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT ( tip: Deprecated,=
 license incompatibility, use BUILD_NONDISTRO=3D1 and install binutils-dev[=
el] )
>          libbabeltrace: [ on  ]  # HAVE_LIBBABELTRACE_SUPPORT
>         libbpf-strings: [ on  ]  # HAVE_LIBBPF_STRINGS_SUPPORT
>            libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
>     libdw-dwarf-unwind: [ on  ]  # HAVE_LIBDW_SUPPORT
>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                libLLVM: [ on  ]  # HAVE_LIBLLVM_SUPPORT
>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>             libopencsd: [ OFF ]  # HAVE_CSTRACE_SUPPORT
>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>                libpfm4: [ on  ]  # HAVE_LIBPFM
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
>              libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprecat=
ed, use LIBUNWIND=3D1 and install libunwind-dev[el] to build with it )
>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
>                   rust: [ on  ]  # HAVE_RUST_SUPPORT
> $ time perf record -g -F max -e cycles:uk -- root.exe -l -q
> info: Using a maximum frequency rate of 79800 Hz
>
> [ perf record: Woken up 23 times to write data ]
> [ perf record: Captured and wrote 5.766 MB perf.data (19922 samples) ]
> 1.28
> $ /usr/bin/time -v perf report -q --stdio -g none --children --percent-li=
mit 75
>     92.44%     0.00%  root.exe  root.exe              [.] main
>     92.44%     0.00%  root.exe  root.exe              [.] _start
>     92.44%     0.00%  root.exe  libc.so.6             [.] __libc_start_ca=
ll_main
>     87.95%     0.00%  root.exe  libCore.so.6.38.04    [.] GetROOT2 (inlin=
ed)
>     75.78%     0.00%  root.exe  libCling.so.6.38.04   [.] CreateInterpret=
er
>
>         Command being timed: "perf report -q --stdio -g none --children -=
-percent-limit 75"
>         User time (seconds): 250.33
>         System time (seconds): 21.18
>         Percent of CPU this job got: 99%
> **      Elapsed (wall clock) time (h:mm:ss or m:ss): 4:32.97
>         Average shared text size (kbytes): 0
>         Average unshared data size (kbytes): 0
>         Average stack size (kbytes): 0
>         Average total size (kbytes): 0
> **      Maximum resident set size (kbytes): 4433000
>         Average resident set size (kbytes): 0
>         Major (requiring I/O) page faults: 7
>         Minor (reclaiming a frame) page faults: 9850739
>         Voluntary context switches: 226
>         Involuntary context switches: 11388
>         Swaps: 0
>         File system inputs: 80776
>         File system outputs: 232
>         Socket messages sent: 0
>         Socket messages received: 0
>         Signals delivered: 0
>         Page size (bytes): 4096
>         Exit status: 0
>
> After seeing how much memory perf was using, I decided to record that
> too, so as you can see above, perf 7.0 with libdw took 4 minutes and 33
> seconds for the same simple perf-report that took 1.86 seconds before,
> and the names of the symbols are not as complete as with libunwind.

Hi Guilherme,

Thanks for the feedback but I'm a little confused. Your .perfconfig is
set to use frame-pointer-based unwinding, so neither libunwind nor
libdw should be used for unwinding. With framepointer unwinding, a
sample contains an array of IPs gathered by walking the linked list of
frame pointers on the stack. With --call-graph=3Ddwarf a region of
memory is copied into a sample (the stack) along with some initial
register values, libdw or libunwind is then used to process this
memory using the dwarf information in the ELF binary.

> Stack unwinding itself also seems inconsistent with the previous run.
> Here's the equivalent with perf-6.19.12:
>
> $ /usr/bin/time -v perf report -q --stdio -g none --children --percent-li=
mit 75
>     92.46%     0.00%  root.exe  libc.so.6             [.] __libc_start_ca=
ll_main
>     92.46%     0.00%  root.exe  libc.so.6             [.] __libc_start_ma=
in@@GLIBC_2.34
>     92.46%     0.00%  root.exe  root.exe              [.] _start
>     92.46%     0.00%  root.exe  root.exe              [.] main
>     91.38%     0.01%  root.exe  libCore.so.6.38.04    [.] ROOT::GetROOT()
>     89.24%     0.00%  root.exe  libRint.so.6.38.04    [.] TRint::TRint(ch=
ar const*, int*, char**, void*, int, bool, bool)
>     88.05%     0.01%  root.exe  libCore.so.6.38.04    [.] TApplication::T=
Application(char const*, int*, char**, void*, int)
>     87.96%     0.01%  root.exe  libCore.so.6.38.04    [.] ROOT::Internal:=
:GetROOT2()
>     87.95%     0.01%  root.exe  libCore.so.6.38.04    [.] TROOT::InitInte=
rpreter()
>     75.50%     0.00%  root.exe  libCling.so.6.38.04   [.] CreateInterpret=
er
>     75.50%     0.00%  root.exe  libCling.so.6.38.04   [.] TCling::TCling(=
char const*, char const*, char const* const*, void*)
>
>
>         Command being timed: "perf report -q --stdio -g none --children -=
-percent-limit 75"
>         User time (seconds): 1.79
>         System time (seconds): 0.08
>         Percent of CPU this job got: 99%
>         Elapsed (wall clock) time (h:mm:ss or m:ss): 0:01.87
>         Average shared text size (kbytes): 0
>         Average unshared data size (kbytes): 0
>         Average stack size (kbytes): 0
>         Average total size (kbytes): 0
>         Maximum resident set size (kbytes): 265108
>         Average resident set size (kbytes): 0
>         Major (requiring I/O) page faults: 0
>         Minor (reclaiming a frame) page faults: 37887
>         Voluntary context switches: 4
>         Involuntary context switches: 77
>         Swaps: 0
>         File system inputs: 0
>         File system outputs: 8
>         Socket messages sent: 0
>         Socket messages received: 0
>         Signals delivered: 0
>         Page size (bytes): 4096
>         Exit status: 0
>
> Then, this is perf-script:
>
> $ time perf script -c root.exe | ~/bin/stackcollapse.pl --all >| root-per=
f-7.0-libdw.stacks
> cmd__addr2line /home/amadio/.debug/.build-id/30/d45df71aac8ef054ca89646b1=
79487af641c45/elf: could not read first record
> ... (line repeated many times)
> cmd__addr2line /home/amadio/.debug/.build-id/30/d45df71aac8ef054ca89646b1=
79487af641c45/elf: could not read first record
> 273.49
>
> I see many of these cms__addr2line errors, and it takes 273.49 seconds
> compared with 4.08 seconds with perf-6.19.12, and the flamegraph has
> abbreviated function names like "operator()" instead of the full name,
> which is also somewhat problematic as there's loss of information
> relative to what libunwind used to provide. The flamegraphs for the two
> runs above are available at https://cern.ch/amadio/perf  I didn't want to
> attach the files here as I don't want to send big files to the lists.
> For the record, I am using libunwind-1.8.3 and elfutils-0.195 in these te=
sts.
>
> If you'd like to perform the same kind of test, you can install ROOT
> from EPEL on a RHEL-like distribution inside a container with a simple
> "dnf install root", or just try the same record/report commands with a
> clang++ compilation of a simple program as a decent replacement.

So something that changed in v7.0 is that with the dwarf libdw or
libunwind unwinding we always had all inline functions on the stack
but not with frame pointers. The IP in the frame pointer array can be
of an instruction within an inlined function. In v7.0 we added a patch
that includes inline information for both frame pointer and LBR-based
stack traces:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/tools/perf/util/machine.c?h=3Dperf-tools-next&id=3D28cb835f7645892=
f4559b92fcfeb25a81646f4cf

By default we try to add inline information using libdw if that fails
we try llvm, then libbfd and finally the command line addr2line tool:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/srcline.c?h=3Dperf-tools-next&id=3D28cb835f7645892f4=
559b92fcfeb25a81646f4cf#n145
I suspect the slow down is for doing all this addr2line work on a
binary that's been stripped. The good news here is that if you can add
a config option to avoid all the fallbacks, "addr2line.style=3Dlibdw".
You can also disable inline information by adding "--no-inline" to
your `perf report` command line.

Your report suggests we should tweak the defaults for showing inline
information. Could you try the options I've suggested and see if they
remedy the issue for you?

Many thanks,
Ian

> Best regards,
> -Guilherme
