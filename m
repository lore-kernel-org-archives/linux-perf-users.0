Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08518387590
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2026 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768242555; cv=pass; b=W94Yr8oPCL9aDlxdWGQznvReE5v7RaNwPKyo5GfgeDKazHeCEWiUmrX5O6SQGQTsHCxVgWpbQwXsdNVX2469GmUHFZ88/nBKkBeepZuppT1sppyexGM7ZP5Tt8+j06hTH+G+sUS/08NEn0sH5n8YjcPuXjWLU353CNOUfzIwV2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768242555; c=relaxed/simple;
	bh=hNIrTYG/8vt51Bmmlg0275VlGwQ57cifgYg954b43lI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FaiVCETdu2N9yRF+F0USBBq4C/hRi5Vts4/kLVPUpyHVGJrVjpJvSPEa+cpdh8knLM0AWVCAYSnE3a2E8mG3pd0h1y8q+7iEU/cl163G6J4pScR8CBGVSPP/R7yunEkOWngdLvthrgEdyx02rW80rxSbYNXo25dtq0MKIRLqVIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oTzuuIYv; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTzuuIYv"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-11a247de834so559c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2026 10:29:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768242553; cv=none;
        d=google.com; s=arc-20240605;
        b=lHIyfS6t76g902wG6LyulMd4f0Tkj3gymz5k8IXD2g0Zc0TZLUVZR1fgZL3Y5IJOp2
         km2nukGuBtwCfVKY0Ct3UvPBm9JRoCStCgc4offiV2XexG5tA4HfMqySRuVkELSDe9Jw
         JyBQC6cvd4eGsQpyjWEFKF0QKsy7dCrdlGIHA364uoF1n7sGJPDhs8vo9deg4aTW74w7
         lvdPSigk+XGx3IhkzQPBcX/OLTT35n/iGFA9/JcmjWogSc6aPdPrjvzMQHl+WKv7y/FD
         j0pgHBw0nFRd7F51RyEf/rJKlAYOnPrKuzjX+EgDWIfNtasmE6aVPTcHAgp70ECGYkph
         8DeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f9How8LlxCwaUsZUViuCjNRC7NQFZ609DBuPrkUcPUI=;
        fh=EyQLpyNt9bKLfGilcrUZcd3W0MuL+CboIFxK/px3Hc0=;
        b=AmucehiBlOCN4p+zm2tc51lZMgw4hygEqjp8DjAPHx/7naEy2no9U2GBPe24i3fhLj
         m4A9BFtQgMutjLB1PcVQknPir94cSyFtavruqWHrO5Z11RQrcOdKhdbXvLF4fpOjM0IQ
         axLE2v21915tyqLFZeTMQcnkhC3qi4Nrn/AxoXPoXa4NNGfIIBVU0vlYh8UrZxmeyrCx
         OWipLyOtp5FbmuH39ZufPetfkxUff9YCKl7pi26q/JQVdga7ywF2VZ7RXCq26xfI/ax3
         698xUuiIOl73bfAwlOGDj4C0P4qti+no9q8sff+011fifhxygFK/fcHXub0ZlinyU5Ph
         7pKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768242553; x=1768847353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9How8LlxCwaUsZUViuCjNRC7NQFZ609DBuPrkUcPUI=;
        b=oTzuuIYvhlXMgFURELfr8FpPgYs7KKnowmzRDj1dTziPiUbp0b5xaPIkdU30RC8wUX
         alWppdqG2KTdHb8BeCmOHYUgIZs5pQhndrAgX1cdhoxYkZRFQujPYZ87/YS3rdX/b7XX
         9MWnCChLaf1j4CbgKrIS2nYJSjHXO3p3iqKh1k/He2cCAY4lPG1buf/9SLhp3vIwdiU6
         T/k0SgeryLxL565qko9gUF1fdB2VF9TJYHFve8hkGFWDBW/CxVpimviPKy0Mv0H3c1Pp
         uoiTrNagpY3D3YQ2lLjXVIFBRnKCJOpxrbIgaMA8TijTNggM4lf4hnp0ldcUiY5TJH+r
         9i2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768242553; x=1768847353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f9How8LlxCwaUsZUViuCjNRC7NQFZ609DBuPrkUcPUI=;
        b=DWnYJk4oVqHQj48Fl1ka+wt0FPDoJBdgVe30y3GZ9RnIWEfQOQy07KYH1avH+B03RF
         XlZ6ft/sHTNf6rRvyvxTzhu1XtwY30hfV4z6e7pVK4uRS8d5nr9oyNfQzT2PWxo+6fqH
         qiO3I2yEMrnuPnmrOafE0AC0arJWfcQNlHWtXzeSSBZxlxadnnqpdj5AvImNUHgmPFQr
         ayZIkz4Gb9ACEWMiPqLVpPnfBvX9wP1wDqXOHwRFwnkm31SlNiRyrvO6LYG1RJIvpsSE
         d9qtojwawePmgB6JX7WJkM9o6xKtyVAviTNsBWKcwutILj/ynNZNw153ThuVUUH5poly
         cspw==
X-Forwarded-Encrypted: i=1; AJvYcCWP0V/KNntGGOrdPXWHBjecV18mXjaOYqaWGcRZjSrrT3Oii+KjfiOz2XMAASux/5jlxhClYjhm0UoZzQEsgw5x@vger.kernel.org
X-Gm-Message-State: AOJu0YxiJ/LF7SDpePpBfo4NOaHwaa6SKgT4MuCNYPnVGSosOV/bbfYE
	2+xxh+Fs9BjoDbjG6OGpnvs19FC88QBCRRdrP7XSvhbP3jKh6mWd8Pa7d2NiIXN1MrMnLwPbDjk
	LUR5avln3mELuGB4lOh5fGcDUAVP/NwCJ8MO4+OBi
X-Gm-Gg: AY/fxX57QBcnRFh99OJxVXxjyCO1U9jNv7CJxRoA9TWK0QUlUbs3Ais9k7s760YpQop
	We8FVmZrjUisHOpel3R5iMv/C0ZnBvyDeuhR9VgL9dvKzVMmczIafx3OuNDmRq2OjoaxDuUVJvB
	HpMJrWgLVPVU/lM+Xxjzk7fRa4b0Y0yy/RwUaDORtmm8yrZbyqB4Gr0ixliJfUkt1pjA8GEAOL+
	O3dt9Yn50dnyUjpoT3Efr6nnu0GxM0CoYP423D6Kfp8pz3Uv7+1W4hMAb3QCc+/Bj9ZuhoPwTVD
	yIwnZrwdiFfVVsj013q2uqKBcw==
X-Received: by 2002:a05:7022:f214:b0:119:e55a:8091 with SMTP id
 a92af1059eb24-1232bed4ab0mr4689c88.14.1768242552551; Mon, 12 Jan 2026
 10:29:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111041338.1817056-1-irogers@google.com> <dbdd0541-0a67-4d61-9ae2-7820920e8f7a@linaro.org>
 <CAP-5=fWWHHioXCsZhxL=ooEPD_qZyd78t0Qjj1ieZYSB-Z_fsg@mail.gmail.com>
In-Reply-To: <CAP-5=fWWHHioXCsZhxL=ooEPD_qZyd78t0Qjj1ieZYSB-Z_fsg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Jan 2026 10:29:01 -0800
X-Gm-Features: AZwV_QhHpM16JvkGQ1fkJkw68u9IYBA_ELARAnrUSH9W8tBuJj8Ev-dh2z215Yc
Message-ID: <CAP-5=fVm8NfxyQcEEpKqLeXEGhzzruNFY=sBXGFzyiftQCPWPA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] perf: Add a libdw addr2line implementation
To: James Clark <james.clark@linaro.org>
Cc: Tony Jones <tonyj@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 6:49=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Jan 12, 2026 at 3:18=E2=80=AFAM James Clark <james.clark@linaro.o=
rg> wrote:
> >
> > On 11/01/2026 4:13 am, Ian Rogers wrote:
> > > addr2line is a performance bottleneck in perf, add a libdw based
> > > implementation that avoids forking addr2line and caches the decoded
> > > debug information.
> > >
> > > Allow the addr2line implementation to be picked via the configuration
> > > file or --addr2line-style with `perf report`.
> > >
> > > Test/fix that inline callchains are properly displayed by perf script=
.
> > >
> > > An example:
> > > ```
> > > $ perf record --call-graph dwarf -e cycles:u -- perf test -w inlinelo=
op 1
> > > [ perf record: Woken up 132 times to write data ]
> > > [ perf record: Captured and wrote 32.814 MB perf.data (4074 samples) =
]
> > > $ perf script --fields +srcline
> > > ...
> > > perf-inlineloop 1814670 293100.228871:     640004 cpu_core/cycles/u:
> > >              55a11d6e61ee leaf+0x2e
> > >    inlineloop.c:21 (inlined)
> > >              55a11d6e61ee middle+0x2e
> > >    inlineloop.c:27 (inlined)
> > >              55a11d6e61ee parent+0x2e (perf)
> > >    inlineloop.c:32
> > >              55a11d6e629b inlineloop+0x8b (perf)
> > >    inlineloop.c:47
> > >              55a11d69a3bc run_workload+0x5a (perf)
> > >    builtin-test.c:715
> > >              55a11d69aa9f cmd_test+0x417 (perf)
> > >    builtin-test.c:825
> > >              55a11d6155f5 run_builtin+0xd4 (perf)
> > >    perf.c:349
> > >              55a11d61588d handle_internal_command+0xdd (perf)
> > >    perf.c:401
> > >              55a11d6159e6 run_argv+0x35 (perf)
> > >    perf.c:445
> > >              55a11d615d2f main+0x2cb (perf)
> > >    perf.c:553
> > >              7fae3d233ca7 __libc_start_call_main+0x77 (libc.so.6)
> > >    libc_start_call_main.h:58
> > >              7fae3d233d64 __libc_start_main_impl+0x84
> > >    libc-start.c:360 (inlined)
> > >              55a11d565f80 _start+0x20 (perf)
> > >    ??:0
> > > ...
> > > ```
> > >
> > > v3: Make the caller inline file and line number accurate in the libdw
> > >      addr2line, rather than using the function's declared location.
> > >      Fix reference counts in unwind-libdw. Add fixes tag for srcline
> > >      inline printing.
> > >
> > > v2: Fix bias issue with libdwfl functions. Use cu_walk_functions_at
> > >      from perf's dwarf-aux to fully walk inline functions. Add testin=
g
> > >      that inlined functions are shown in the perf script srcline
> > >      callchain information. Add configurability as to which addr2line
> > >      style to use.
> > >      https://lore.kernel.org/lkml/20260110082647.1487574-1-irogers@go=
ogle.com/
> > >
> > > v1: https://lore.kernel.org/lkml/20251122093934.94971-1-irogers@googl=
e.com/
> > >
> > > Ian Rogers (7):
> > >    perf unwind-libdw: Fix invalid reference counts
> > >    perf addr2line: Add a libdw implementation
> > >    perf addr2line.c: Rename a2l_style to cmd_a2l_style
> > >    perf srcline: Add configuration support for the addr2line style
> > >    perf callchain: Fix srcline printing with inlines
> > >    perf test workload: Add inlineloop test workload
> > >    perf test: Test addr2line unwinding works with inline functions
> > >
> > >   tools/perf/builtin-report.c                 |  10 ++
> > >   tools/perf/tests/builtin-test.c             |   1 +
> > >   tools/perf/tests/shell/addr2line_inlines.sh |  47 ++++++
> > >   tools/perf/tests/tests.h                    |   1 +
> > >   tools/perf/tests/workloads/Build            |   2 +
> > >   tools/perf/tests/workloads/inlineloop.c     |  52 +++++++
> > >   tools/perf/util/Build                       |   1 +
> > >   tools/perf/util/addr2line.c                 |  20 +--
> > >   tools/perf/util/config.c                    |   4 +
> > >   tools/perf/util/dso.c                       |   2 +
> > >   tools/perf/util/dso.h                       |  11 ++
> > >   tools/perf/util/evsel_fprintf.c             |   8 +-
> > >   tools/perf/util/libdw.c                     | 153 +++++++++++++++++=
+++
> > >   tools/perf/util/libdw.h                     |  60 ++++++++
> > >   tools/perf/util/srcline.c                   | 116 ++++++++++++++-
> > >   tools/perf/util/srcline.h                   |   3 +
> > >   tools/perf/util/symbol_conf.h               |  10 ++
> > >   tools/perf/util/unwind-libdw.c              |   7 +-
> > >   18 files changed, 486 insertions(+), 22 deletions(-)
> > >   create mode 100755 tools/perf/tests/shell/addr2line_inlines.sh
> > >   create mode 100644 tools/perf/tests/workloads/inlineloop.c
> > >   create mode 100644 tools/perf/util/libdw.c
> > >   create mode 100644 tools/perf/util/libdw.h
> > >
> >
> > I don't see the differences to the other addr2line implementations
> > anymore, but only because it falls through to the old ones when libdw
> > fails now.
> >
> > For example when building Perf with LLVM it can't get the line in the
> > inlineloop workload, and there's still a few things in libc and other
> > system libraries it fails on.
>
> Hmm.. I wonder what the issue is. I was looking at the dwarf output
> from my gcc builds with llvm-dwarfdump. I wonder if LLVM builds are
> doing something to confuse libdw? I'll try to investigate. There are
> quite a few levels of libdw: there's the raw libdw, libdwfl (frontend
> to libdw) that does the parsing and tries to give things like nested
> debug scopes (libdwfl is the one needing addresses with a module bias
> rather than raw file offsets), and then there is the dwarf-aux.c that
> is in perf and is used by things like probe finding (I believe this
> doesn't need biases addresses). Anyway, with the biases there are
> things I can screw up (like in the v1 patch) but maybe the LLVM issue
> is just a libdw and dwarf-5 kind of thing. Maybe it is ARM specific
> :-/

Testing with clang/llvm on x86-64 (dwarf5):
```
$ make -C tools/perf O=3D/tmp/perf DEBUG=3D1 CC=3Dclang CXX=3Dclang++
HOSTCC=3Dclang clean all
...
$ llvm-dwarfdump /tmp/perf/perf
...
0x0014f852: Compile Unit: length =3D 0x00000294, format =3D DWARF32,
version =3D 0x0005, unit_type =3D DW_UT_compile,
abbr_offset =3D 0x1879a, addr_size =3D 0x08 (next unit at 0x0014faea)

0x0014f85e: DW_TAG_compile_unit
             DW_AT_producer    ("Debian clang version 19.1.7 (3+build5)")
             DW_AT_language    (DW_LANG_C11)
             DW_AT_name        ("tests/workloads/inlineloop.c")
             DW_AT_str_offsets_base    (0x0004a550)
             DW_AT_stmt_list   (0x0008c3f2)
             DW_AT_comp_dir    ("linux/tools/perf")
             DW_AT_low_pc      (0x00000000001e61c0)
             DW_AT_high_pc     (0x00000000001e62e9)
             DW_AT_addr_base   (0x00022248)
             DW_AT_loclists_base       (0x0000018a)
...
$  sudo /tmp/perf/perf record --call-graph dwarf -e cycles:u --
/tmp/perf/perf test -w inlineloop 1
...
$  sudo /tmp/perf/perf script --fields +srcline
...
perf-inlineloop 2284167 423038.015394:     569917 cpu_core/cycles/u:
           56390020d2c6 leaf+0x26
 inlineloop.c:21 (inlined)
           56390020d2c6 middle+0x26
 inlineloop.c:27 (inlined)
           56390020d2c6 parent+0x26 (/tmp/perf/perf)
...
```
I ran inside of gdb and confirmed that the libdw code is creating the
inlined information (breakpoint on libdw_a2l_cb, etc.). So I'm not
able to reproduce the LLVM issue for now on x86-64.

Thanks,
Ian

> > But I think it's fine because it doesn't give the wrong line anymore, i=
t
> > just falls through to another working addr2line implementation.
>
> Just to confirm that with gcc builds it isn't failing now? ie it isn't
> just an addr2line implementation that falls through all the time? I
> was seeing things working/testing on x86 with gcc.
>
> > Reviewed-by: James Clark <james.clark@linaro.org>
>
> Thanks,
> Ian
