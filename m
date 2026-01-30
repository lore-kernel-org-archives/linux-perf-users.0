Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8FC3859EE
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769799623; cv=pass; b=MTIBekfbDF3KEKBo3v8/UhvHO35GzG8HjRsVC0sl+HzbER6NmdHM+EPT2Cqg9ozRIFR4irl+qlI/69chkdPLuWQlW5moUrKE9KFuuRYIiAmvRfUMn5JF3tGt13vZ+/gW0bN8Sa4tEBqLAlxwBvzbu5bFrLejE14b7lMFn+Gu0uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769799623; c=relaxed/simple;
	bh=NhbmuSTLkYKdG9BeEJF2hiRSY2HooXC7JFtgQNMN9ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzL2NWQyVzjDB7uUHTF3jVZN/DLJpRYjqb8pcyQicPVAbA68eIvplOsGVffY2hzxk86Xo28KVkgbNwKOUWlYuSR5URObtuWQd0O8BMUgj25lUL8OGWIMVhj3OWek14wTiQbUa0sd0z+2dwop10jQDrW/q8DNRGF9bw2gur5ER98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ckdHBME; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ckdHBME"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a8e4ae61a0so8585ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 11:00:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769799611; cv=none;
        d=google.com; s=arc-20240605;
        b=HyhaX6hoVgcSqU0liKVrjd6qCj8PPKs1CIOZO9+xqH4Z7sHXKnppBDpdeyZfovF6b1
         te9qpvT2L0+Hjw+rqGA2W2b8VMD2vqduLpLsBLIu9XI24yng3XF37VY0wl08myBDNudo
         fVWDfNyJvqQGOYuD3dNpBw4+KrereFunOBhgR3G9e3w+4X3fHSZ4al/83JSYiHAfJOL3
         6kiLcPCOvrOGTFMdjXFQRLbPHUWnoL6lz73Mek8OM7hO1bZ24qWRW/PYUDCOJQubhUlJ
         ELCqZ8reGVGiy9emCMvFLeOvOAV7VDBBTASURD4mUHv4MXyt6IMix7CSmLO9MPnSQ0gF
         cXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r6RcU6AeNk7P4EPwKiF1KtguLXFCSbP10h3roHW3P7c=;
        fh=DN46pmYwIeeOrIG8kn3FXfD7VZ8e1/f7frHP+y4OSws=;
        b=io+yVRVE4dSh7y6ZGzoIPtS0o9t2FOjyHpddZCl9So1H7CM6ohUOrlHEax8nM+uu9q
         nq/EEGWUNhJLgruxjsoWxA1o3eTp3CF/fCOMFClqyNP35BtZc/PZ/MPfIiD4OSRJJZOP
         6PZT683sAb1wALY2uaGRmHneomwmfaqH4AKxYVg1sxzn1YFrdmCOvgQtiB5EOEBUd89m
         yIsekHJ1+s6KGKkEadQHvHM1eCQtY8VgSP817zeAAvcW/BYGXOZ86AYcGm2zmDaAYkMs
         0TNq0sXEhEyEzAF+8/B+41nzb91HpDhZrzMbNco66jsWPNyaV+k4Ocr6LwPiiQ90KnSR
         VdtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769799611; x=1770404411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6RcU6AeNk7P4EPwKiF1KtguLXFCSbP10h3roHW3P7c=;
        b=2ckdHBMEXvghkwKtm4YrMTxfnJ+hXs9CqLInIjSQPvAKam9uO93SVEwxnJ3DoKMF27
         UzC1AftRKWZSDDuNpftx4uaoWRYeNwvKWwdJ1TLQX+1ONoCSbXla293pbHkE4C8i632/
         FUztq6Fu15RVvDmy0u6LuyzsL713iUjx9JWPdBVMCJleriA/yr4YGqYJju4zb3SBHf0t
         OfM84GEbmwsjxVJvA0qnvj8uIvFbzXfAMw6HgJFiUNucPNr6DF8xIWCk4zNsGRnMGJWS
         zdpymdMShbrVlYZ+Lm46P+NfMTs0MRctDmh/t2JrWWqkbnqZ2IINXRGJAHINzYvqdkcm
         f8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769799611; x=1770404411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r6RcU6AeNk7P4EPwKiF1KtguLXFCSbP10h3roHW3P7c=;
        b=Bbt4tR6J2KH72d1pCfHgg17imgFBAhjexi9jz1UjitSX3cugN5paegw1UD8mebHReP
         eZwY7P6475ILP7QOWh0+R2NlDpiELVksT9WgrQO+bW2zls1qmaXUeOPtReog+yhanxIa
         B+kcqMyjqf4yhGFThZqj037Tz3Y1dksYIdDMcSCHPii/w4jreOcp2ND2ghM4SZji0id3
         cK+lvWhWQ/oR3ChRI4+YoZmLVWXdcKrs2XwMfGRyePC8PaPn3tWuuyHO/HK7/xCWJMm8
         JzjZ+V9Pew74Vcx/tNV8P9809dvzSN9Q20+rW3youzQOF5ViopNSsI7KM1BkE76cq3yg
         q2zg==
X-Forwarded-Encrypted: i=1; AJvYcCUwonjPwv67JnaBdqvk+51ACjIXFyTlgJOxvS6JNd2sb4QjnrKmS+5t8YlW88aYMI5dvbT4NebhRMKDOwnBMg1K@vger.kernel.org
X-Gm-Message-State: AOJu0YwbNFpKDNx+4pds1rM+kN+MScaCz/6VeKUmKKv2HD8hqESA++ry
	LIpXKnWC+i5EBbR+pRecS/58pNTrmpgvTxILzqAc0w8xrhqV9cqBxrYod8qrAc4IoFFTdXlFRoW
	0/JiHe6gbNYrT51oeO/3LXkgtbYCJ1wuRekuxVXcm
X-Gm-Gg: AZuq6aLHLC42uIM1kwVCV25SoAXBrKQIjC6LKH9SyfKFVslc+RAwPm76df1ckdFKT9e
	wDRaQLxxBJa9GsItoQuz5XMCThDEt0vvRxF94Loa9Wh8J+9ZjLwuyrBZ6xAJbCEbuZMMRyuI5I/
	pTWWYrHuGTiN9B3MRHD0aJHqnYVYy8dw7sIC6n1leX+DPq6ujZ8trvnbpfIq809Z7GElbtCh3Fv
	eptEPkWtk3NwXbBipyelOrSpp1SLJY27sWT780X08kRdbuq9rMyHOUmtzbQ/4zPBqA++Gcc1KIT
	YGCbJNYDvbF+yBhmN+lTGCSp
X-Received: by 2002:a17:902:e885:b0:2a7:6c4e:5924 with SMTP id
 d9443c01a7336-2a8f32da4c7mr246105ad.12.1769799610348; Fri, 30 Jan 2026
 11:00:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127062302.544809-1-irogers@google.com> <20260127062302.544809-2-irogers@google.com>
 <aXpZvOZyQLIz5gTF@x1>
In-Reply-To: <aXpZvOZyQLIz5gTF@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 30 Jan 2026 10:59:59 -0800
X-Gm-Features: AZwV_QguAtmWzmTD1a48Cjpho1UB2faxT84HaY6nm5MyET3PzQ57vTQM5dFRNNc
Message-ID: <CAP-5=fX2+UMzhMCEBVtA0Es_-T7QNxn2c7rPJi4se6bamLsD=w@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] perf capstone: Support for dlopen-ing libcapstone.so
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 10:47=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Jan 26, 2026 at 10:23:00PM -0800, Ian Rogers wrote:
> > If perf wasn't built against libcapstone, no HAVE_LIBCAPSTONE_SUPPORT,
> > support dlopen-ing libcapstone.so and then calling the necessary
> > functions by looking them up using dlsym. Reverse engineer the types
> > in the API using pahole, adding only what's used in the perf code or
> > necessary for the sake of struct size and alignment.
>
> Trying to test this, I built it with NO_CAPSTONE=3D1 but with:
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ perf config
> annotate.disassemblers=3Dcapstone
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> And:
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ rpm -qa | grep capstone
> capstone-5.0.5-7.fc43.x86_64
> capstone-devel-5.0.5-7.fc43.x86_64
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> It manages to build with the needed dlopen magic, etc and ends up
> calling dlopen, locates the .so, loads it, etc, but eventually fails:
>
>
> Breakpoint 1, perf_cs_open (arch=3DCS_ARCH_X86, mode=3DCS_MODE_64, handle=
=3D0x7fffffff93a8) at util/capstone.c:152
> 152     {
> (gdb) bt
> #0  perf_cs_open (arch=3DCS_ARCH_X86, mode=3DCS_MODE_64, handle=3D0x7ffff=
fff93a8) at util/capstone.c:152
> #1  0x00000000005e2eb8 in capstone_init (machine=3D0x1083b98, cs_handle=
=3D0x7fffffff93a8, is64=3Dtrue, disassembler_style=3Dtrue) at util/capstone=
.c:278
> #2  0x00000000005e37f7 in symbol__disassemble_capstone (filename=3D0x7fff=
ffff96f0 "/home/acme/.debug/.build-id/cc/315df11334de01fb444465f08f6bca45a1=
2bd2/elf", sym=3D0x10b0d20, args=3D0x7fffffffa770)
>     at util/capstone.c:489
> #3  0x00000000005ee303 in symbol__disassemble (sym=3D0x10b0d20, args=3D0x=
7fffffffa770) at util/disasm.c:1622
> #4  0x00000000005d25be in symbol__annotate (ms=3D0x10a4dd0, evsel=3D0x108=
42f0, parch=3D0x0) at util/annotate.c:1056
> #5  0x00000000005d4808 in hist_entry__tty_annotate (he=3D0x10a4d30, evsel=
=3D0x10842f0) at util/annotate.c:1710
> #6  0x0000000000404544 in hist_entry__stdio_annotate (he=3D0x10a4d30, evs=
el=3D0x10842f0, ann=3D0x7fffffffcae0) at builtin-annotate.c:332
> #7  0x000000000040516c in hists__find_annotations (hists=3D0x10845b0, evs=
el=3D0x10842f0, ann=3D0x7fffffffcae0) at builtin-annotate.c:545
> #8  0x000000000040569c in __cmd_annotate (ann=3D0x7fffffffcae0) at builti=
n-annotate.c:655
> #9  0x000000000040685e in cmd_annotate (argc=3D0, argv=3D0x7fffffffe070) =
at builtin-annotate.c:949
> #10 0x00000000004cbebb in run_builtin (p=3D0xff2cb0 <commands+432>, argc=
=3D2, argv=3D0x7fffffffe070) at perf.c:348
> #11 0x00000000004cc10d in handle_internal_command (argc=3D2, argv=3D0x7ff=
fffffe070) at perf.c:398
> #12 0x00000000004cc269 in run_argv (argcp=3D0x7fffffffdeec, argv=3D0x7fff=
ffffdee0) at perf.c:442
> #13 0x00000000004cc53d in main (argc=3D2, argv=3D0x7fffffffe070) at perf.=
c:549
> (gdb) n
> 159             if (!fn_init) {
> (gdb) n
> 160                     fn =3D dlsym(perf_cs_dll_handle(), "cs_open");
> (gdb) n
> Downloading 8.80 M separate debug info for /usr/lib64/libcapstone.so
> Downloading 2.02 M separate debug info for /home/acme/.cache/debuginfod_c=
lient/6f0ac051dccbc6a7a322a5950c4955eca60e8498/debuginfo
> 161                     if (!fn)
> (gdb) p fn
> $1 =3D (enum cs_err (*)(enum cs_arch, enum cs_mode, csh *)) 0x7fffecad7cd=
0 <cs_open>
> (gdb) n
> 163                     fn_init =3D true;
> (gdb) n
> 165             if (!fn)
> (gdb) n
> 167             return fn(arch, mode, handle);
> (gdb) n
> 169     }
> (gdb) n
> capstone_init (machine=3D0x1083b98, cs_handle=3D0x7fffffff93a8, is64=3Dtr=
ue, disassembler_style=3Dtrue) at util/capstone.c:283
> 283             if (machine__normalized_is(machine, "x86")) {
> (gdb) n
> 289                     if (disassembler_style)
> (gdb) n
> 290                             perf_cs_option(*cs_handle, CS_OPT_SYNTAX,=
 CS_OPT_SYNTAX_ATT);
> (gdb) n
> 295                     perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_=
ON);
> (gdb) n
> 298             return 0;
> (gdb) n
> 299     }
> (gdb) n
> symbol__disassemble_capstone (filename=3D0x7fffffff96f0 "/home/acme/.debu=
g/.build-id/cc/315df11334de01fb444465f08f6bca45a12bd2/elf", sym=3D0x10b0d20=
, args=3D0x7fffffffa770) at util/capstone.c:493
> 493             needs_cs_close =3D true;
> (gdb) n
> 495             free_count =3D count =3D perf_cs_disasm(handle, buf, buf_=
len, start, buf_len, &insn);
> (gdb) n
> 496             for (i =3D 0, offset =3D 0; i < count; i++) {
> (gdb) p count
> $2 =3D 32
> (gdb) n
> 501                                         insn[i].mnemonic, insn[i].op_=
str);
> (gdb) n
> 499                     printed =3D scnprintf(disasm_buf, sizeof(disasm_b=
uf),
> (gdb) n
> 502                     print_capstone_detail(&insn[i], disasm_buf + prin=
ted,
> (gdb) n
> 503                                           sizeof(disasm_buf) - printe=
d, args,
> (gdb) n
> 502                     print_capstone_detail(&insn[i], disasm_buf + prin=
ted,
> (gdb) n
> 506                     args->offset =3D offset;
> (gdb) n
> 507                     args->line =3D disasm_buf;
> (gdb) n
> 509                     dl =3D disasm_line__new(args);
> (gdb) n
> 510                     if (dl =3D=3D NULL)
> (gdb) n
> 511                             goto err;
>
> While doing it without NO_CAPSTONE=3D1, i.e. dyn linking against capstone
> seems to work:
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ perf config
> annotate.disassemblers=3Dcapstone
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ ldd ~/bin/perf | grep capstone
>         libcapstone.so.5 =3D> /usr/lib64/libcapstone.so.5 (0x00007f1f9458=
8000)
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ perf -vv | grep capst
>            libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ perf annotate -v | head
> symbol__disassemble: filename=3D/home/acme/.debug/.build-id/cc/315df11334=
de01fb444465f08f6bca45a12bd2/elf, sym=3Dcache_rpath, start=3D0x7efd8294fd90=
, end=3D0x7efd8294fdfc
> annotating [0x1d043db0] /usr/lib64/ld-linux-x86-64.so.2 : [0x1d0c2b50]   =
                 cache_rpath
> Disassembled with capstone
> Open Debuginfo file: /home/acme/.debug/.build-id/cc/315df11334de01fb44446=
5f08f6bca45a12bd2/elf
> symbol__disassemble: filename=3D/home/acme/.debug/.build-id/cc/315df11334=
de01fb444465f08f6bca45a12bd2/elf, sym=3D_dl_start, start=3D0x7efd82967990, =
end=3D0x7efd82968069
> annotating [0x1d043db0] /usr/lib64/ld-linux-x86-64.so.2 : [0x1d0c6470]   =
                   _dl_start
> Disassembled with capstone
> Open Debuginfo file: /home/acme/.debug/.build-id/cc/315df11334de01fb44446=
5f08f6bca45a12bd2/elf
>  Percent |      Source code & Disassembly of ld-linux-x86-64.so.2 for cpu=
/cycles/Pu (1 samples, percent: local period)
> -------------------------------------------------------------------------=
---------------------------------------------
>                             6d93: 1
>                    h->nr_samples: 1
>          : 0    0x6d90 <cache_rpath>:
>     0.00 :   6d90:       movq    (%rsi), %rax
>   100.00 :   6d93:       movq    %rsi, %r8
>     0.00 :   6d96:       movq    %rcx, %r9
>     0.00 :   6d99:       cmpq    $-1, %rax
>     0.00 :   6d9d:       je      0x6df7
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> What am I missing?
>
> Fedora 43.
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ git log --oneline -20
> e88f915e5f2a809b (HEAD -> perf-tools-next) perf llvm: Mangle libperf-llvm=
.so function names
> cf0b92a9652719c1 perf llvm: Support for dlopen-ing libLLVM.so
> b8bf08b8e4e22c39 perf capstone: Support for dlopen-ing libcapstone.so
> e205952db7717557 perf jevents: Validate that all names given an Event
> 82e53e7ae09a054b perf jevents: Add cycles breakdown metric for arm64/AMD/=
Intel
> e74f72a7e2178233 perf jevents: Add mesh bandwidth saturation metric for I=
ntel
> 5dc81578ad77c298 perf jevents: Add upi_bw metric for Intel
> 6ec3058e709cc635 perf jevents: Add local/remote miss latency metrics for =
Intel
> 1fee2701a7d35fa7 perf jevents: Add C-State metrics from the PCU PMU for I=
ntel
> 2166b44be9384209 perf jevents: Add dir breakdown metrics for Intel
> cde9c1a5d92520a8 perf jevents: Add local/remote "mem" breakdown metrics f=
or Intel
> 130f4245af99e140 perf jevents: Add mem_bw metric for Intel
> 426b8442898de9af perf jevents: Add Miss Level Parallelism (MLP) metric fo=
r Intel
> d666f0172ab306fa perf jevents: Add FPU metrics for Intel
> 2f3d6ea05deca7c1 perf jevents: Add context switch metrics for Intel
> 59341f4e171170d3 perf jevents: Add ILP metrics for Intel
> d80edef23124baff perf jevents: Add load store breakdown metrics ldst for =
Intel
> 7413633e255cb02d perf jevents: Add L2 metrics for Intel
> cd1c6a487407a350 perf jevents: Add ports metric group giving utilization =
on Intel
> 397fdb3a24435f55 perf jevents: Add software prefetch (swpf) metric group =
for Intel
> =E2=AC=A2 [acme@toolbx perf-tools-next]$

I can repro the issue. I'm noticing that the patch has:
CS_ARCH_X86 =3D 3,
but that doesn't match here:
https://github.com/capstone-engine/capstone/blob/next/include/capstone/caps=
tone.h#L90
where X86 now has value 4. Fixing up the values I still get the issue
and so more exploration is necessary. Given capstone's ABI isn't
stable we may not be able to use pahole constants and require a header
file like Namhyung asked for.

Thanks,
Ian

> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/capstone.c | 285 ++++++++++++++++++++++++++++++++-----
> >  1 file changed, 248 insertions(+), 37 deletions(-)
> >
> > diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> > index 9216916f848f..43168d43e4a3 100644
> > --- a/tools/perf/util/capstone.c
> > +++ b/tools/perf/util/capstone.c
> > @@ -11,20 +11,250 @@
> >  #include "print_insn.h"
> >  #include "symbol.h"
> >  #include "thread.h"
> > +#include <dlfcn.h>
> >  #include <errno.h>
> >  #include <fcntl.h>
> > +#include <inttypes.h>
> >  #include <string.h>
> >
> >  #ifdef HAVE_LIBCAPSTONE_SUPPORT
> >  #include <capstone/capstone.h>
> > +#else
> > +typedef size_t csh;
> > +enum cs_arch {
> > +     CS_ARCH_ARM =3D 0,
> > +     CS_ARCH_ARM64 =3D 1,
> > +     CS_ARCH_X86 =3D 3,
> > +     CS_ARCH_SYSZ =3D 6,
> > +};
> > +enum cs_mode {
> > +     CS_MODE_ARM =3D 0,
> > +     CS_MODE_32 =3D 1 << 2,
> > +     CS_MODE_64 =3D 1 << 3,
> > +     CS_MODE_V8 =3D 1 << 6,
> > +     CS_MODE_BIG_ENDIAN =3D 1 << 31,
> > +};
> > +enum cs_opt_type {
> > +     CS_OPT_SYNTAX =3D 1,
> > +     CS_OPT_DETAIL =3D 2,
> > +};
> > +enum cs_opt_value {
> > +     CS_OPT_SYNTAX_ATT =3D 2,
> > +     CS_OPT_ON =3D 3,
> > +};
> > +enum cs_err {
> > +     CS_ERR_OK =3D 0,
> > +     CS_ERR_HANDLE =3D 3,
> > +};
> > +enum x86_op_type {
> > +     X86_OP_IMM =3D 2,
> > +     X86_OP_MEM =3D 3,
> > +};
> > +enum x86_reg {
> > +     X86_REG_RIP =3D 41,
> > +};
> > +typedef int32_t x86_avx_bcast;
> > +struct x86_op_mem {
> > +     enum x86_reg segment;
> > +     enum x86_reg base;
> > +     enum x86_reg index;
> > +     int scale;
> > +     int64_t disp;
> > +};
> > +
> > +struct cs_x86_op {
> > +     enum x86_op_type type;
> > +     union {
> > +             enum x86_reg  reg;
> > +             int64_t imm;
> > +             struct x86_op_mem mem;
> > +     };
> > +     uint8_t size;
> > +     uint8_t access;
> > +     x86_avx_bcast avx_bcast;
> > +     bool avx_zero_opmask;
> > +};
> > +struct cs_x86_encoding {
> > +     uint8_t modrm_offset;
> > +     uint8_t disp_offset;
> > +     uint8_t disp_size;
> > +     uint8_t imm_offset;
> > +     uint8_t imm_size;
> > +};
> > +typedef int32_t  x86_xop_cc;
> > +typedef int32_t  x86_sse_cc;
> > +typedef int32_t  x86_avx_cc;
> > +typedef int32_t  x86_avx_rm;
> > +struct cs_x86 {
> > +     uint8_t prefix[4];
> > +     uint8_t opcode[4];
> > +     uint8_t rex;
> > +     uint8_t addr_size;
> > +     uint8_t modrm;
> > +     uint8_t sib;
> > +     int64_t disp;
> > +     enum x86_reg sib_index;
> > +     int8_t sib_scale;
> > +     enum x86_reg sib_base;
> > +     x86_xop_cc xop_cc;
> > +     x86_sse_cc sse_cc;
> > +     x86_avx_cc avx_cc;
> > +     bool avx_sae;
> > +     x86_avx_rm avx_rm;
> > +     union {
> > +             uint64_t eflags;
> > +             uint64_t fpu_flags;
> > +     };
> > +     uint8_t op_count;
> > +     struct cs_x86_op operands[8];
> > +     struct cs_x86_encoding encoding;
> > +};
> > +struct cs_detail {
> > +     uint16_t regs_read[12];
> > +     uint8_t regs_read_count;
> > +     uint16_t regs_write[20];
> > +     uint8_t regs_write_count;
> > +     uint8_t groups[8];
> > +     uint8_t groups_count;
> > +
> > +     union {
> > +             struct cs_x86 x86;
> > +     };
> > +};
> > +struct cs_insn {
> > +     unsigned int id;
> > +     uint64_t address;
> > +     uint16_t size;
> > +     uint8_t bytes[16];
> > +     char mnemonic[32];
> > +     char op_str[160];
> > +     struct cs_detail *detail;
> > +};
> > +#endif
> > +
> > +#ifndef HAVE_LIBCAPSTONE_SUPPORT
> > +static void *perf_cs_dll_handle(void)
> > +{
> > +     static bool dll_handle_init;
> > +     static void *dll_handle;
> > +
> > +     if (!dll_handle_init) {
> > +             dll_handle_init =3D true;
> > +             dll_handle =3D dlopen("libcapstone.so", RTLD_LAZY);
> > +             if (!dll_handle)
> > +                     pr_debug("dlopen failed for libcapstone.so\n");
> > +     }
> > +     return dll_handle;
> > +}
> > +#endif
> > +
> > +static enum cs_err perf_cs_open(enum cs_arch arch, enum cs_mode mode, =
csh *handle)
> > +{
> > +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > +     return cs_open(arch, mode, handle);
> > +#else
> > +     static bool fn_init;
> > +     static enum cs_err (*fn)(enum cs_arch arch, enum cs_mode mode, cs=
h *handle);
> > +
> > +     if (!fn_init) {
> > +             fn =3D dlsym(perf_cs_dll_handle(), "cs_open");
> > +             if (!fn)
> > +                     pr_debug("dlsym failed for cs_open\n");
> > +             fn_init =3D true;
> > +     }
> > +     if (!fn)
> > +             return CS_ERR_HANDLE;
> > +     return fn(arch, mode, handle);
> > +#endif
> > +}
> > +
> > +static enum cs_err perf_cs_option(csh handle, enum cs_opt_type type, s=
ize_t value)
> > +{
> > +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > +     return cs_option(handle, type, value);
> > +#else
> > +     static bool fn_init;
> > +     static enum cs_err (*fn)(csh handle, enum cs_opt_type type, size_=
t value);
> > +
> > +     if (!fn_init) {
> > +             fn =3D dlsym(perf_cs_dll_handle(), "cs_option");
> > +             if (!fn)
> > +                     pr_debug("dlsym failed for cs_option\n");
> > +             fn_init =3D true;
> > +     }
> > +     if (!fn)
> > +             return CS_ERR_HANDLE;
> > +     return fn(handle, type, value);
> > +#endif
> > +}
> > +
> > +static size_t perf_cs_disasm(csh handle, const uint8_t *code, size_t c=
ode_size,
> > +                     uint64_t address, size_t count, struct cs_insn **=
insn)
> > +{
> > +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > +     return cs_disasm(handle, code, code_size, address, count, insn);
> > +#else
> > +     static bool fn_init;
> > +     static enum cs_err (*fn)(csh handle, const uint8_t *code, size_t =
code_size,
> > +                              uint64_t address, size_t count, struct c=
s_insn **insn);
> > +
> > +     if (!fn_init) {
> > +             fn =3D dlsym(perf_cs_dll_handle(), "cs_disasm");
> > +             if (!fn)
> > +                     pr_debug("dlsym failed for cs_disasm\n");
> > +             fn_init =3D true;
> > +     }
> > +     if (!fn)
> > +             return CS_ERR_HANDLE;
> > +     return fn(handle, code, code_size, address, count, insn);
> >  #endif
> > +}
> >
> > +static void perf_cs_free(struct cs_insn *insn, size_t count)
> > +{
> >  #ifdef HAVE_LIBCAPSTONE_SUPPORT
> > +     cs_free(insn, count);
> > +#else
> > +     static bool fn_init;
> > +     static void (*fn)(struct cs_insn *insn, size_t count);
> > +
> > +     if (!fn_init) {
> > +             fn =3D dlsym(perf_cs_dll_handle(), "cs_free");
> > +             if (!fn)
> > +                     pr_debug("dlsym failed for cs_free\n");
> > +             fn_init =3D true;
> > +     }
> > +     if (!fn)
> > +             return;
> > +     fn(insn, count);
> > +#endif
> > +}
> > +
> > +static enum cs_err perf_cs_close(csh *handle)
> > +{
> > +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > +     return cs_close(handle);
> > +#else
> > +     static bool fn_init;
> > +     static enum cs_err (*fn)(csh *handle);
> > +
> > +     if (!fn_init) {
> > +             fn =3D dlsym(perf_cs_dll_handle(), "cs_close");
> > +             if (!fn)
> > +                     pr_debug("dlsym failed for cs_close\n");
> > +             fn_init =3D true;
> > +     }
> > +     if (!fn)
> > +             return CS_ERR_HANDLE;
> > +     return fn(handle);
> > +#endif
> > +}
> > +
> >  static int capstone_init(struct machine *machine, csh *cs_handle, bool=
 is64,
> >                        bool disassembler_style)
> >  {
> > -     cs_arch arch;
> > -     cs_mode mode;
> > +     enum cs_arch arch;
> > +     enum cs_mode mode;
> >
> >       if (machine__is(machine, "x86_64") && is64) {
> >               arch =3D CS_ARCH_X86;
> > @@ -45,7 +275,7 @@ static int capstone_init(struct machine *machine, cs=
h *cs_handle, bool is64,
> >               return -1;
> >       }
> >
> > -     if (cs_open(arch, mode, cs_handle) !=3D CS_ERR_OK) {
> > +     if (perf_cs_open(arch, mode, cs_handle) !=3D CS_ERR_OK) {
> >               pr_warning_once("cs_open failed\n");
> >               return -1;
> >       }
> > @@ -57,27 +287,25 @@ static int capstone_init(struct machine *machine, =
csh *cs_handle, bool is64,
> >                * is set via annotation args
> >                */
> >               if (disassembler_style)
> > -                     cs_option(*cs_handle, CS_OPT_SYNTAX, CS_OPT_SYNTA=
X_ATT);
> > +                     perf_cs_option(*cs_handle, CS_OPT_SYNTAX, CS_OPT_=
SYNTAX_ATT);
> >               /*
> >                * Resolving address operands to symbols is implemented
> >                * on x86 by investigating instruction details.
> >                */
> > -             cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
> > +             perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
> >       }
> >
> >       return 0;
> >  }
> > -#endif
> >
> > -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > -static size_t print_insn_x86(struct thread *thread, u8 cpumode, cs_ins=
n *insn,
> > +static size_t print_insn_x86(struct thread *thread, u8 cpumode, struct=
 cs_insn *insn,
> >                            int print_opts, FILE *fp)
> >  {
> >       struct addr_location al;
> >       size_t printed =3D 0;
> >
> >       if (insn->detail && insn->detail->x86.op_count =3D=3D 1) {
> > -             cs_x86_op *op =3D &insn->detail->x86.operands[0];
> > +             struct cs_x86_op *op =3D &insn->detail->x86.operands[0];
> >
> >               addr_location__init(&al);
> >               if (op->type =3D=3D X86_OP_IMM &&
> > @@ -95,7 +323,6 @@ static size_t print_insn_x86(struct thread *thread, =
u8 cpumode, cs_insn *insn,
> >       printed +=3D fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_st=
r);
> >       return printed;
> >  }
> > -#endif
> >
> >
> >  ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unu=
sed,
> > @@ -106,9 +333,8 @@ ssize_t capstone__fprintf_insn_asm(struct machine *=
machine __maybe_unused,
> >                                  uint64_t ip __maybe_unused, int *lenp =
__maybe_unused,
> >                                  int print_opts __maybe_unused, FILE *f=
p __maybe_unused)
> >  {
> > -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> >       size_t printed;
> > -     cs_insn *insn;
> > +     struct cs_insn *insn;
> >       csh cs_handle;
> >       size_t count;
> >       int ret;
> > @@ -118,7 +344,7 @@ ssize_t capstone__fprintf_insn_asm(struct machine *=
machine __maybe_unused,
> >       if (ret < 0)
> >               return ret;
> >
> > -     count =3D cs_disasm(cs_handle, code, code_size, ip, 1, &insn);
> > +     count =3D perf_cs_disasm(cs_handle, code, code_size, ip, 1, &insn=
);
> >       if (count > 0) {
> >               if (machine__normalized_is(machine, "x86"))
> >                       printed =3D print_insn_x86(thread, cpumode, &insn=
[0], print_opts, fp);
> > @@ -126,20 +352,16 @@ ssize_t capstone__fprintf_insn_asm(struct machine=
 *machine __maybe_unused,
> >                       printed =3D fprintf(fp, "%s %s", insn[0].mnemonic=
, insn[0].op_str);
> >               if (lenp)
> >                       *lenp =3D insn->size;
> > -             cs_free(insn, count);
> > +             perf_cs_free(insn, count);
> >       } else {
> >               printed =3D -1;
> >       }
> >
> > -     cs_close(&cs_handle);
> > +     perf_cs_close(&cs_handle);
> >       return printed;
> > -#else
> > -     return -1;
> > -#endif
> >  }
> >
> > -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > -static void print_capstone_detail(cs_insn *insn, char *buf, size_t len=
,
> > +static void print_capstone_detail(struct cs_insn *insn, char *buf, siz=
e_t len,
> >                                 struct annotate_args *args, u64 addr)
> >  {
> >       int i;
> > @@ -154,7 +376,7 @@ static void print_capstone_detail(cs_insn *insn, ch=
ar *buf, size_t len,
> >               return;
> >
> >       for (i =3D 0; i < insn->detail->x86.op_count; i++) {
> > -             cs_x86_op *op =3D &insn->detail->x86.operands[i];
> > +             struct cs_x86_op *op =3D &insn->detail->x86.operands[i];
> >               u64 orig_addr;
> >
> >               if (op->type !=3D X86_OP_MEM)
> > @@ -195,9 +417,7 @@ static void print_capstone_detail(cs_insn *insn, ch=
ar *buf, size_t len,
> >               break;
> >       }
> >  }
> > -#endif
> >
> > -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> >  struct find_file_offset_data {
> >       u64 ip;
> >       u64 offset;
> > @@ -214,13 +434,11 @@ static int find_file_offset(u64 start, u64 len, u=
64 pgoff, void *arg)
> >       }
> >       return 0;
> >  }
> > -#endif
> >
> >  int symbol__disassemble_capstone(const char *filename __maybe_unused,
> >                                struct symbol *sym __maybe_unused,
> >                                struct annotate_args *args __maybe_unuse=
d)
> >  {
> > -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> >       struct annotation *notes =3D symbol__annotation(sym);
> >       struct map *map =3D args->ms->map;
> >       struct dso *dso =3D map__dso(map);
> > @@ -235,7 +453,7 @@ int symbol__disassemble_capstone(const char *filena=
me __maybe_unused,
> >       const u8 *buf;
> >       u64 buf_len;
> >       csh handle;
> > -     cs_insn *insn =3D NULL;
> > +     struct cs_insn *insn =3D NULL;
> >       char disasm_buf[512];
> >       struct disasm_line *dl;
> >       bool disassembler_style =3D false;
> > @@ -274,7 +492,7 @@ int symbol__disassemble_capstone(const char *filena=
me __maybe_unused,
> >
> >       needs_cs_close =3D true;
> >
> > -     free_count =3D count =3D cs_disasm(handle, buf, buf_len, start, b=
uf_len, &insn);
> > +     free_count =3D count =3D perf_cs_disasm(handle, buf, buf_len, sta=
rt, buf_len, &insn);
> >       for (i =3D 0, offset =3D 0; i < count; i++) {
> >               int printed;
> >
> > @@ -313,9 +531,9 @@ int symbol__disassemble_capstone(const char *filena=
me __maybe_unused,
> >
> >  out:
> >       if (needs_cs_close) {
> > -             cs_close(&handle);
> > +             perf_cs_close(&handle);
> >               if (free_count > 0)
> > -                     cs_free(insn, free_count);
> > +                     perf_cs_free(insn, free_count);
> >       }
> >       free(code_buf);
> >       return count < 0 ? count : 0;
> > @@ -335,16 +553,12 @@ int symbol__disassemble_capstone(const char *file=
name __maybe_unused,
> >       }
> >       count =3D -1;
> >       goto out;
> > -#else
> > -     return -1;
> > -#endif
> >  }
> >
> >  int symbol__disassemble_capstone_powerpc(const char *filename __maybe_=
unused,
> >                                        struct symbol *sym __maybe_unuse=
d,
> >                                        struct annotate_args *args __may=
be_unused)
> >  {
> > -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> >       struct annotation *notes =3D symbol__annotation(sym);
> >       struct map *map =3D args->ms->map;
> >       struct dso *dso =3D map__dso(map);
> > @@ -458,7 +672,7 @@ int symbol__disassemble_capstone_powerpc(const char=
 *filename __maybe_unused,
> >
> >  out:
> >       if (needs_cs_close)
> > -             cs_close(&handle);
> > +             perf_cs_close(&handle);
> >       free(buf);
> >       return count < 0 ? count : 0;
> >
> > @@ -467,7 +681,4 @@ int symbol__disassemble_capstone_powerpc(const char=
 *filename __maybe_unused,
> >               close(fd);
> >       count =3D -1;
> >       goto out;
> > -#else
> > -     return -1;
> > -#endif
> >  }
> > --
> > 2.52.0.457.g6b5491de43-goog
> >
>
