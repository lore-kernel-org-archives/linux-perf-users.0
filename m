Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ED1392C2A
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083023; cv=pass; b=bhekf4K7snozKyEq9PfhEXHNI2fe3ReRXRP0d/v04RgxygzYjdHSeZqyJ8DwfvqGk9CeXv8OTzqr22owxgnEzaiS5kYNtRSMoIIJyMMQem6ZlANnDo+68LwdwB32dlIuyVJ9ZVk48a2nfDamCpThlwPbazx7QFgjxW5UgOioJwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083023; c=relaxed/simple;
	bh=hJ007eQWrmiiTyhYCIG5NbIfhXzJmaHuigzDsGpKYoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kzgdv9a/sWKkHX3Pr1+yz1Mb39WPpZlJGSZxcPn9QNM8vhp+in9m4wSi9StVonggg8aeikRPHrvmoERpyntJx6LOgd8NOAuXkrbER9VM9P5NlAJdIk+w3zwHsm8DGU3bunwQJte2XO+0tAGJTOLPoCMEorFU5OXQBVvldmmN97Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2XBRXnw; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2XBRXnw"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-45c92df37fdso339089b6e.3
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 03:57:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769083021; cv=none;
        d=google.com; s=arc-20240605;
        b=UGdCMo6d0SimUTLSfC+CSsCtrSvZXgk+/2edyWb6CPPpX0VqbLlpdwsy6LTsKx94Dg
         OMmRtpmmYW27tSlzD0N8ZvAxPSTeb24/QNSVhZdXnLF3aMlViwBNW6LQfH3uVMCcUKwE
         +5eRV6nPtsBh/+Ye2tw3qfHZtRi1kjc+pve0cNu78qxalsUT2DoSlJpeLkCMRL06BLOa
         7kj0wy8zcbXJKZNxysimUN1jC/LgqnHKkJ/2i8zCpDbWJgWp8O62sHl+Nmi0w1We4+mX
         aUB4IxhwX9uHgVYx3K2OTBqZ/hRrY6S6TLz9MnMS4u4E3rcdpS3uqAtf+FdSh9Xe0VOm
         vcqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BJsfpOClmaQvG81S67nCd+VIer0uq8erZuxF5hyxS28=;
        fh=qJlNw2edwwVAXHX5w1fHZK7s63vUnUiIpDQsaMJFpL8=;
        b=kJ/34wsp9Rfp/mGs21abJx3VIZtki88nsbaoPXKA9dY6IzpfFF8dXsyekwaNQsDp6U
         1jCS6HfdK5IQ9yj1Cd82Iix2DLfCPg+9mGMoHCdkw9i8HT9sTMgDmJnaDqx6fDku2SRi
         sJoCS3zUq0W9vO3gzs0dNBo10Gb+vTEGkGNXr4OronKMijqhz0LwKC3d7ZquJDU55mD5
         BeZ4mMOqMBMYBg8MIlucUJnnFRudWwSC8D2+jDlzjH8rRoBN2nQCFYBj9BQBnsPmmYcY
         hqrkKz7gaORLdxqdZAe6SLwS8LgPZciPolRP+Ch/l1VG+znxBFJEQ9UKnug+C8/prc01
         wiGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769083021; x=1769687821; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BJsfpOClmaQvG81S67nCd+VIer0uq8erZuxF5hyxS28=;
        b=d2XBRXnwJAV3Iu89GZptHtxI/2k1bbUUzHrgf1kn1Z3qYqMHOXheWEr+5rsmNICoJI
         t/DNSZj/Ar/JUyDJRboisrSBH7jlonzvQ48vl0XEP7l9FUPPkJmcUoxwOSo+yu514HP4
         4997OcyrRSxXLWTGFxexH9ZBcwChyAFCLzUlRg0d4V5HcaXaJvh/m506m4c6zFvnKpsx
         AdPFTYZcACKAxBcdXGWwb+Q356dHiX3q8bh3JPeEi06uuwL+D7b2S55JGLvjYhtWRX2Q
         Hls9psDgDt9FcpAP7kyCOiv3/fq7gibOzzPHhJPRqnxfF/zK871VhkjFN7sTKK/Err9n
         ARUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769083021; x=1769687821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJsfpOClmaQvG81S67nCd+VIer0uq8erZuxF5hyxS28=;
        b=iYUH0isjT1kl0qKgJg9meywrjMqPrKww1SSjiyeqTPLKW0Fz+WxP7ejMgbKJU+1eaU
         OkxNvLpcJohOyynidWA++OoSpDlNM3/sQcy7se7KIRv9sJaypJo47KMuoRVZdsGKG2zf
         HwUkTDpSNOghuAXhGE4xs4404wUiw3UwLVWLSr4ubvl1yUqdjk6WrQeO6GLGvUymj4t1
         eGf1lwlOzDFNkPh2grxVN4+60/CvwhOR5r1XtpmsZbvdg/DP+9/IJWz6nQOKGl+ph3dC
         emm1wwJNBaz2EJG9f7NWWJdBsjszb4Mvlyg8ZRfPCwCFM+zIZy+8PeANOrVlwCquP1sg
         yr8w==
X-Forwarded-Encrypted: i=1; AJvYcCWaCRxwOc0H9IrgE2bRJuaxbgECW61bCd3n+sVTFchih6nesvxP2VCI5uqTDOh5crfWw8M62VyE4xPWWUW2LqrX@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQFyzIeK7fGSJVXLyfYAgS2DVR6WKvQGZ+PY425SAVSHbidmd
	eq2gXtnNOGesSxdF0aqHlc7jczBxOMmGfcxrZsqdwCsp2BZI9saadIur3EI/98M0DiM/8GwFHvk
	lSuK/BWL0l80czBKLDQvAsojyYwfoayU=
X-Gm-Gg: AZuq6aLWRjwV7pB/oKS1Ca0rhLVv2Iu2G2I3RUImkdNGVRc15UdrkSVOhyHZlyr8aT/
	pdzuuDOZzr7EJm9cZKM/SuDV5GgMnvQkiDB8T7vDztsP8dyJBCcRa0XWJB2wqr8kp8Lk5dbZn69
	FJU8pPbao4yOLPC5TIdZPV4FpVRuzfjx+XImiQs3Pp+SZXPq57+1vAumzs0dl6QAFTyW/Sk5gch
	89VZiVjzI15gIgXHQXtckhueWiE//pUQrgMr6ZEkPEo90vsWXwzE4wnwWDy8qr27bjQoJjX
X-Received: by 2002:a05:6870:c69b:b0:3fd:ec4f:d1d2 with SMTP id
 586e51a60fabf-4044c157df6mr10910160fac.10.1769083020732; Thu, 22 Jan 2026
 03:57:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122073127.375139-1-irogers@google.com> <9fd8375c-2de7-4305-ac3e-42ff8f919964@linaro.org>
 <10c875e6-6cc2-4695-a0aa-01507541daf4@linaro.org>
In-Reply-To: <10c875e6-6cc2-4695-a0aa-01507541daf4@linaro.org>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Thu, 22 Jan 2026 17:26:49 +0530
X-Gm-Features: AZwV_QjFtuAtj7gs3qI-DenUm1XMW9RrPz13HXtm-zTDxJ_0wzsKC5Z_5vStStw
Message-ID: <CAO9wTFjaxNMcH7TgQyYjKR=3fNoO+D3cp6FgtRd9Li6JparYbA@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] perf annotate arch clean up
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Zecheng Li <zecheng@google.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Aditya Bodkhe <aditya.b1@linux.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Jan 2026 at 16:17, James Clark <james.clark@linaro.org> wrote:
>
>
>
> On 22/01/2026 10:43 am, James Clark wrote:
> >
> >
> > On 22/01/2026 7:31 am, Ian Rogers wrote:
> >> 2 initial memory leak fix patches for perf annotate.
> >>
> >> Move the disasm.c #included arch files into a new util/annotate-arch
> >> directory. Make the code compile standalone. Try to better encapsulate
> >> architecture specific code within the files and with a
> >> arch__new_<arch> function that allows additional data to be associated
> >> with the struct arch using the standard container_of trick.
> >>
> >> Make the lookup of struct arch use the ELF machine gather from a
> >> thread rather than an evsel. For example, the evsel can't determine
> >> the difference between EM_386 and EM_X86_64 so generally the latter
> >> has currently been used. This means the dwarf registers are off as
> >> register 1 is CX with EM_386 and DX with EM_X86_64. To facilitate this
> >> change map_symbol is refactored to use a struct thread rather than a
> >> struct maps, the maps being obtainable from the thread.
> >>
> >> To make in and out arguments clearer, for safety, etc. try to constify
> >> struct arch and its related structs.
> >>
> >
> > Hi Ian,
> >
> > I get this crash, not sure which commit causes it exactly but it
> > happened 2/2 times on both x86 and arm:
> >
> >   $ perf record -- true
> >   $ perf report
> >
> >   < Select first sample >
> >   < Select annotate >
> >
> > perf: Segmentation fault
> > -------- backtrace --------
> >      #0 0x5df8f58ba973 in ui__signal_backtrace setup.c:110
> >      #1 0x74373a642520 in __restore_rt libc_sigaction.c:0
> >      #2 0x5df8f5963f0d in dso__kernel dso.h:532
> >      #3 0x5df8f5965d0a in __map__const_kmap map.c:627
> >      #4 0x5df8f5965a36 in map__rip_2objdump map.c:531
> >      #5 0x5df8f58e5bef in symbol__parse_objdump_line disasm.c:1032
> >      #6 0x5df8f58e498b in symbol__disassemble_objdump disasm.c:1503
> >      #7 0x5df8f58e3852 in symbol__disassemble disasm.c:1621
> >      #8 0x5df8f58c638d in symbol__annotate annotate.c:1055
> >      #9 0x5df8f58c8628 in symbol__annotate2 annotate.c:2209
> >      #10 0x5df8f58a36b7 in __hist_entry__tui_annotate annotate.c:1189
> >      #11 0x5df8f58adf86 in do_annotate hists.c:2488
> >      #12 0x5df8f58ad762 in evsel__hists_browse hists.c:3441
> >      #13 0x5df8f58b78f2 in perf_evsel_menu__run hists.c:3556
> >      #14 0x5df8f58adabc in __evlist__tui_browse_hists hists.c:3643
> >      #15 0x5df8f58abf3b in evlist__tui_browse_hists hists.c:3691
> >      #16 0x5df8f571ac3a in report__browse_hists builtin-report.c:688
> >      #17 0x5df8f5719943 in __cmd_report builtin-report.c:1177
> >      #18 0x5df8f57181bc in cmd_report builtin-report.c:1890
> >      #19 0x5df8f57b5c3a in run_builtin perf.c:348
> >      #20 0x5df8f57b53b3 in handle_internal_command perf.c:398
> >      #21 0x5df8f57b5b2f in run_argv perf.c:445
> >      #22 0x5df8f57b5091 in main perf.c:551
> >      #23 0x74373a629d90 in __libc_start_call_main libc_start_call_main.h:58
> >      #24 0x74373a629e40 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
> >      #25 0x5df8f56ead35 in _start perf[55d35]
> >
> >
>
> Also the annotate test fails:
>
>   $ sudo perf test 74
>   74: perf annotate basic tests                       : FAILED!
>
>
> >> Ian Rogers (11):
> >>    perf maps: Fix reference count leak in maps__find_ams
> >>    perf annotate: Fix args leak of map_symbol
> >>    perf disasm: Constify use of struct arch
> >>    perf disasm: Constify use of struct ins_op
> >>    perf disasm: Constify use of struct ins
> >>    perf disasm: Rework the string arch__is to use the ELF machine
> >>    perf disasm: Don't include C files from the arch directory
> >>    perf disasm: Refactor ins__is_call/jump to avoid exposing arch ins_ops
> >>    perf map_symbol: Switch from holding maps to holding thread
> >>    perf disasm: Refactor arch__find and initialization of arch structs
> >>    perf disasm: Minor layout tweaks for struct arch
> >>
> >>   tools/perf/arch/arc/annotate/instructions.c   |  11 -
> >>   .../perf/arch/riscv64/annotate/instructions.c |  36 --
> >>   tools/perf/ui/browsers/annotate.c             |   6 +-
> >>   tools/perf/ui/browsers/hists.c                |   3 +-
> >>   tools/perf/util/Build                         |   1 +
> >>   tools/perf/util/addr_location.c               |   4 -
> >>   tools/perf/util/addr_location.h               |   1 -
> >>   tools/perf/util/annotate-arch/Build           |  11 +
> >>   tools/perf/util/annotate-arch/annotate-arc.c  |  18 +
> >>   .../annotate-arch/annotate-arm.c}             |  48 +-
> >>   .../annotate-arch/annotate-arm64.c}           |  59 +--
> >>   .../annotate-arch/annotate-csky.c}            |  29 +-
> >>   .../annotate-arch/annotate-loongarch.c}       |  57 ++-
> >>   .../annotate-arch/annotate-mips.c}            |  29 +-
> >>   .../annotate-arch/annotate-powerpc.c}         | 125 +++++-
> >>   .../util/annotate-arch/annotate-riscv64.c     |  41 ++
> >>   .../annotate-arch/annotate-s390.c}            |  59 ++-
> >>   .../annotate-arch/annotate-sparc.c}           |  26 +-
> >>   .../annotate-arch/annotate-x86.c}             |  89 ++--
> >>   tools/perf/util/annotate-data.c               |  12 +-
> >>   tools/perf/util/annotate-data.h               |   2 +-
> >>   tools/perf/util/annotate.c                    |  88 ++--
> >>   tools/perf/util/annotate.h                    |  10 +-
> >>   tools/perf/util/callchain.c                   |  12 +-
> >>   tools/perf/util/capstone.c                    |  18 +-
> >>   tools/perf/util/db-export.c                   |   1 -
> >>   tools/perf/util/disasm.c                      | 424 +++++++-----------
> >>   tools/perf/util/disasm.h                      |  95 ++--
> >>   tools/perf/util/event.c                       |   2 -
> >>   tools/perf/util/hist.c                        |  18 +-
> >>   tools/perf/util/llvm.c                        |   8 +-
> >>   tools/perf/util/machine.c                     |  13 +-
> >>   tools/perf/util/map_symbol.c                  |   5 +-
> >>   tools/perf/util/map_symbol.h                  |   3 +-
> >>   tools/perf/util/maps.c                        |   1 +
> >>   tools/perf/util/sort.c                        |   2 +-
> >>   tools/perf/util/unwind-libdw.c                |   2 +-
> >>   tools/perf/util/unwind-libunwind-local.c      |   2 +-
> >>   38 files changed, 752 insertions(+), 619 deletions(-)
> >>   delete mode 100644 tools/perf/arch/arc/annotate/instructions.c
> >>   delete mode 100644 tools/perf/arch/riscv64/annotate/instructions.c
> >>   create mode 100644 tools/perf/util/annotate-arch/Build
> >>   create mode 100644 tools/perf/util/annotate-arch/annotate-arc.c
> >>   rename tools/perf/{arch/arm/annotate/instructions.c => util/
> >> annotate-arch/annotate-arm.c} (59%)
> >>   rename tools/perf/{arch/arm64/annotate/instructions.c => util/
> >> annotate-arch/annotate-arm64.c} (70%)
> >>   rename tools/perf/{arch/csky/annotate/instructions.c => util/
> >> annotate-arch/annotate-csky.c} (67%)
> >>   rename tools/perf/{arch/loongarch/annotate/instructions.c => util/
> >> annotate-arch/annotate-loongarch.c} (66%)
> >>   rename tools/perf/{arch/mips/annotate/instructions.c => util/
> >> annotate-arch/annotate-mips.c} (59%)
> >>   rename tools/perf/{arch/powerpc/annotate/instructions.c => util/
> >> annotate-arch/annotate-powerpc.c} (73%)
> >>   create mode 100644 tools/perf/util/annotate-arch/annotate-riscv64.c
> >>   rename tools/perf/{arch/s390/annotate/instructions.c => util/
> >> annotate-arch/annotate-s390.c} (70%)
> >>   rename tools/perf/{arch/sparc/annotate/instructions.c => util/
> >> annotate-arch/annotate-sparc.c} (85%)
> >>   rename tools/perf/{arch/x86/annotate/instructions.c => util/
> >> annotate-arch/annotate-x86.c} (93%)
> >>
> >
>

The annotate test fails after applying the 4th patch.
