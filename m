Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43F83B27ED;
	Tue, 26 May 2026 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812437; cv=none; b=G2Km17ieyjdUBI/tbErd1nfKv6qYkfjeDWX6+5dPL8cIKKRp64N7e+cO8WN8JYEcTKnSLvwyMAVrqLH6vMtP8HTgVttXT/++LhiqeY6YFMCAfm3NyrD3/ttijLQHvlRjJtXqCegv7z+BbCRA0jxpgCt82WRI6jngFcNQzLNkcn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812437; c=relaxed/simple;
	bh=JIwenFn39+s0zOk8exBeX0ykt/e3W7wH8MUBtlSx6Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECMsZ/yoluGEP1/EqNEZzdVBN7SyD69xw74CQ+hGYKu/zmogDBMoUVY1/G61peWgECTqsCI1KfmK+0jD9emp+Sujy286kiDDv3zVlcVsfmY1afFY+2mXWvu5j4MiHpMoeVz6UjdIKF75zmUoVZLETjSIq7J/jJif9Ngl4t5ekMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m5KeUQtW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m5KeUQtW"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QBb2Lh2014728;
	Tue, 26 May 2026 16:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DF4ICk
	aNCWATbM2qNzHQgaMuXH6zydLY+ateas//Voo=; b=m5KeUQtWKjqpdhORCabrxJ
	7JtNJrobVDLL9OpcoUK4j6CkJRIyHfYfzf/NVI+JKO2NkGq1A+Jb+0J/pVrrNwX5
	iPwAf9C6YLVisRZxlUNdHANJfKvP9qKQvYOFS2tIxeUNDQxOZw3rAkaqw2KS9qkX
	CzfflrdgVPlTvk1Nrkl7fKv7Wk9XIQqyi1pbnni0Z6Sl7I9+8LGeOJFN/pbT4yXc
	XUimV6j87WW+lSZ5AMti2UGRSgOyksIHDD/p74SWKaqWPeCYfExEMsPMuconmcOX
	3zJWPTTT7E6WMSiws66geYVf7mxFENdBx4HZvAH6bABwWO19xSW3/nzbEzAqIzCQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4qbw4d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 16:20:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64QGABDv006108;
	Tue, 26 May 2026 16:20:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ebrsga0u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 16:20:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64QGKUVe59703610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 16:20:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 833B320049;
	Tue, 26 May 2026 16:20:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1965A20040;
	Tue, 26 May 2026 16:20:30 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.87.150.50])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 26 May 2026 16:20:30 +0000 (GMT)
Date: Tue, 26 May 2026 18:20:28 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jens Remus <jremus@linux.ibm.com>, sashiko-reviews@lists.linux.dev,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf build: Fix Python extension build with GCC 16
 hardening
Message-ID: <ahXITNt0Z-n4NCaj@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260520125637.105681-1-japo@linux.ibm.com>
 <20260520130905.9C85D1F000E9@smtp.kernel.org>
 <ahJnMnOr4i9urrRk@x1>
 <ahV2XGx_6h7upuc3@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CAP-5=fXGG5PR8neTkozvOUOH83m8_EyZXZ_A7Zyrsock5EqAiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXGG5PR8neTkozvOUOH83m8_EyZXZ_A7Zyrsock5EqAiQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEzOSBTYWx0ZWRfX60uT69s2GGTi
 R4bqNXiry6BIjiQc13aMFo1xks5LBk2+JIhP7joUvfHUHKGilXIPsSbs5ckd9oZwokAyU4IHGb3
 EmTz7eWIAlhpAJtHxyIgvZpCYnDrnObvT7lFEusAkQfNR2DtG6mljF31bh/DyildzhX53JqHupM
 HIM6xj1z5K2CT4VF273vhQd1t7nOynqzeyBsQsVRcZGNWA0UNoCgcvWPW42CYOe8fRY266DPf2P
 Cj9VjqgMCN+WFinJ2g2wvHTur+hlSBK4fsBII0wAOilbEmM6WUmbVUMPq9/T80z7wCn4zMwcDLK
 rIAN22h59pOxXSZNu+QAiBy3Wn9eIKV0HwnxH428+HIIgM8G5vFJ0fsFwsxvaF7Cye/fucBr1bu
 rHs3e5y9+bvZN0j4iS+0Vbrfn0wSTPUIIxlwXENRzVIR3QgEknWW0iJtc45HSOIF+0W91jTdF29
 5IvaXkdZBDGq1mw2RgQ==
X-Authority-Analysis: v=2.4 cv=KItqylFo c=1 sm=1 tr=0 ts=6a15c851 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=hVbuahvrImoDIjt2CRcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: yM41FLLfUTiHRiSBaGd0X9_VpkTN9csb
X-Proofpoint-GUID: hprOyXaRvXnYD2H8A9Z2E1zOjVIm8Dgn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260139

On Tue, May 26, 2026 at 08:23:28AM -0700, Ian Rogers wrote:
> On Tue, May 26, 2026 at 3:35 AM Jan Polensky <japo@linux.ibm.com> wrote:
> >
> > On Sat, May 23, 2026 at 11:49:22PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Wed, May 20, 2026 at 01:09:05PM +0000, sashiko-bot@kernel.org wrote:
> > > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > > - [Medium] The patch explicitly allows text relocations in the Python extension shared object (`perf.so`) by adding `-Wl,-z,notext`, masking the root cause of missing `-fPIC` flags and breaking W^X (Write XOR Execute) security protections.
> > > > --
> > > >
> > > > commit f3832fb0ad0d1f9c2e69039b2a5110f77d220d5e
> > > > Author: Jan Polensky <japo@linux.ibm.com>
> > > >
> > > > perf build: Fix Python extension build with GCC 16 hardening
> > > >
> > > > This commit addresses a build failure in the Python extension caused by GCC 16
> > > > stricter security policies regarding dynamic relocations in read-only segments.
> > > > It adds the -Wl,-z,notext flag to the linker to explicitly allow text
> > > > relocations in the Python extension shared object.
> > > >
> > > > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > > > index 76b35ac19acbf..eea170d6576db 100644
> > > > > --- a/tools/perf/Makefile.perf
> > > > > +++ b/tools/perf/Makefile.perf
> > > > > @@ -749,7 +749,7 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
> > > > >  $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
> > > > >
> > > > >  $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup.py $(PERFLIBS_PY)
> > > > > - $(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
> > > > > + $(QUIET_GEN)LDSHARED="$(CC) -pthread -shared -Wl,-z,notext" \
> > > >
> > > > [Severity: Medium]
> > > > Does adding -Wl,-z,notext mask the root cause of the GCC 16 linker error?
> > > >
> > > > The error regarding dynamic relocations in a read-only segment usually
> > > > indicates that non-position-independent code from the static libraries
> > > > is being linked into the shared library.
> > > >
> > > > Using -Wl,-z,notext suppresses this error by allowing text relocations, which
> > > > forces the dynamic linker to map the executable text segment as writable at
> > > > load time. This breaks W^X security protections and weakens the security of
> > > > any Python process loading the extension.
> > > >
> > > > Should the required object files be compiled with -fPIC instead to properly
> > > > resolve the linker error without compromising security?
> > >
> > > So I asked Claude about this and he suggests doing like other parts of
> > > perf and using -fPIC, can you try to do that?
> > >
> > > ---------------------------------------
> > >
> > > ● Sashiko is right. -Wl,-z,notext is a band-aid that weakens security —
> > >   it makes the text segment writable at load time, defeating W^X.
> > >
> > >   The root cause is that PERFLIBS_PY (the static libraries linked into
> > >   the Python .so) are compiled without -fPIC. When you link non-PIC .a
> > >   archives into a shared library, the linker needs text relocations. GCC
> > >   16 correctly rejects this by default.
> > >
> > >   The proper fix is to build the static libraries that go into the
> > >   Python extension with -fPIC. The perf build system already has
> > >   precedent for this — look for how libperf and libsubcmd handle PIC
> > >   builds. The Python extension's dependencies need a parallel -fPIC
> > >   build, or the existing objects need to be compiled with -fPIC when the
> > >   Python binding is enabled.
> > >
> > >   The -Wl,-z,notext approach would also cause issues on distros that
> > >   enforce RELRO + BIND_NOW hardening, and some package builders would
> > >   reject the resulting .so outright.
> > >
> > > - Arnaldo
> >
> > Hi Arnaldo,
> >
> > thanks for the pointer. I double-checked this on s390x and did some reduced-link
> > testing for the ET_DYN / Python-extension case.
> >
> > The failure is not triggered by the perf Python binding object alone.
> >
> > A reduced reproducer succeeds when linking:
> >   python.o
> >   + libapi.a
> >   + libperf.a
> >   + libsubcmd.a
> >   + libsymbol.a
> >   + libbpf.a
> >   + libperf-ui.a
> >
> > The link starts to fail with:
> >   /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
> >
> > as soon as libperf-util.a is added.
> >
> > In my tree, libperf-util.a currently contains only perf-util-in.o, and replacing
> > the archive with that single object still reproduces the same failure.
> >
> > Reduced reproducer:
> >
> >   gcc -pthread -shared \
> >     -Wl,-z,noexecstack \
> >     -o /tmp/try-perf-util-only.so \
> >     /root/linux/tools/perf/python_ext_build/tmp/root/linux/tools/perf/util/python.o \
> >     -Wl,--whole-archive \
> >       /root/linux/tools/perf/libapi/libapi.a \
> >       /root/linux/tools/perf/libperf/libperf.a \
> >       /root/linux/tools/perf/libsubcmd/libsubcmd.a \
> >       /root/linux/tools/perf/libsymbol/libsymbol.a \
> >       /root/linux/tools/perf/libbpf/libbpf.a \
> >       /root/linux/tools/perf/libperf-ui.a \
> >     -Wl,--no-whole-archive \
> >     /root/perf-util-one/perf-util-in.o \
> >     -lpython3.14 -lpthread -ldl -lm -lutil
> >
> > Inspection of perf-util-in.o on s390x shows many direct R_390_PC32DBL
> > relocations from .text against .data.rel.ro, .data.rel.ro.local,
> > .data.rel.local, .bss, and .rodata.
> >
> > Representative examples include:
> >
> >   arm64__associate_instruction_ops:
> >     larl %r6  -> R_390_PC32DBL .data.rel.ro+0x2
> >
> >   loongarch__associate_ins_ops:
> >     larl %r9  -> R_390_PC32DBL .data.rel.ro+0x22
> >     larl %r9  -> R_390_PC32DBL .data.rel.ro+0x42
> >
> >   check_ppc_insn:
> >     larl %r4  -> R_390_PC32DBL .data.rel.local+0x4c2
> >     larl %r2  -> R_390_PC32DBL .data.rel.ro.local+0x22
> >     larl %r1  -> R_390_PC32DBL .data.rel.local+0x2
> >     larl %r2  -> R_390_PC32DBL .data.rel.ro.local+0x2
> >
> >   s390__associate_ins_ops:
> >     larl %r10 -> R_390_PC32DBL .data.rel.ro+0x732
> >     larl %r10 -> R_390_PC32DBL .data.rel.ro+0x752
> >
> > So from my reproducer, I don't think we can describe this simply as
> > "all Python-extension dependency archives are missing -fPIC".
> >
> > The issue narrows down much more specifically to perf-util-in.o in the ET_DYN
> > link of the Python extension, and the direct text-to-data section relocations
> > above look like the most relevant candidates.
> >
> > So I agree that -Wl,-z,notext is only a workaround. I'd prefer to understand
> > and fix the underlying relocation pattern in perf-util-in.o rather than merge
> > that as-is.
> >
> > If useful, I can send the relevant readelf/objdump snippets in a follow-up.
>
> Hi Jan,
>
> I wonder about two tests:
> 1) adding V=1 JOBS=1 to your make command to switch on single
> threading and build verbosity. This may make it possible to identify
> the gcc command that is missing -fPIC. For example, I see -fPIC on
> x86:
>   gcc -Wp,-MD,/tmp/perf4/util/annotate-arch/.annotate-arm64.o.d
> -Wp,-MT,/tmp/perf4/util/annotate-arch/annotate -arm64.o
> -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security
> -Wformat-y2k -Winit-self -Wmissin g-declarations -Wmissing-prototypes
> -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls
> -Wst rict-prototypes -Wswitch-default -Wswitch-enum -Wundef
> -Wwrite-strings -Wformat -Wno-type-limits -Wstrict-alia sing=3
> -Wshadow -fno-strict-aliasing -I/tmp/perf4/arch/x86/include/generated
> -DHAVE_ARCH_X86_64_SUPPORT -Werro r -g -fno-omit-frame-pointer -Wall
> -Wextra -std=gnu11 -funsigned-char -fstack-protector-all
> -D_LARGEFILE64_SOU RCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
> -I~/linux/tools/perf/util/include
> -I~/linux/tools/perf/arch/x86/include
> -I/usr/local/google/home/irogers/re pos/linux4/tools/include/
> -I~/linux/tools/arch/x86/include/uapi -I/usr/loc
> al/google/home/irogers/repos/linux4/tools/include/uapi
> -I~/linux/tools/arc h/x86/include/ -I~/linux/tools/arch/x86/
> -I/tmp/perf4//util -I/tmp/perf4/ -I~/linux/tools/perf/util
> -I~/linux/to ols/perf -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP
> -DHAVE_PTHREAD_BARRIER -DHAVE_EVENTFD_SUPPORT -DHAVE_GETTID -DHAVE
> _FILE_HANDLE -DHAVE_AIO_SUPPORT -DHAVE_SCANDIRAT_SUPPORT
> -DHAVE_SCHED_GETCPU_SUPPORT -DHAVE_SETNS_SUPPORT -DHA VE_ZLIB_SUPPORT
> -DHAVE_LIBELF_SUPPORT -DHAVE_ELF_GETPHDRNUM_SUPPORT
> -DHAVE_GELF_GETNOTE_SUPPORT -DHAVE_ELF_GET SHDRSTRNDX_SUPPORT
> -DHAVE_DEBUGINFOD_SUPPORT -DHAVE_LIBDW_SUPPORT -DHAVE_LIBBPF_SUPPORT
> -DHAVE_SDT_EVENT -DHAV E_JITDUMP -DHAVE_LIBOPENSSL_SUPPORT
> -DHAVE_BPF_SKEL -DHAVE_DWARF_UNWIND_SUPPORT -DHAVE_SLANG_SUPPORT
> -DHAVE_TI MERFD_SUPPORT -fPIC -DHAVE_LIBLLVM_SUPPORT
> -I/usr/lib/llvm-19/include -D_GNU_SOURCE -D__STDC_CONSTANT_MACROS
> -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS
> -DHAVE_CXA_DEMANGLE_SUPPORT -DHAVE_LZMA_SUPPORT -DHAVE_ZSTD_SUPPORT
> -DHAVE_BACKTRACE_SUPPORT -DHAVE_LIBNUMA_SUPPORT
> -DHAVE_PERF_READ_VDSO32 -DHAVE_LIBBABELTRACE_SUPPORT -DHAVE_
> LIBCAPSTONE_SUPPORT -DHAVE_JVMTI_CMLR -DHAVE_LIBPFM
> -DHAVE_LIBTRACEEVENT -I/usr/include/traceevent -DLIBTRACEE
> VENT_VERSION=67072 -DHAVE_RUST_SUPPORT -I/tmp/perf4/libapi/include
> -I/tmp/perf4/libbpf/include -I/tmp/perf4/li bsubcmd/include
> -I/tmp/perf4/libsymbol/include -I/tmp/perf4/libperf/include
> -I/tmp/perf4/ -D"BUILD_STR(s)=#s" -c -o
> /tmp/perf4/util/annotate-arch/annotate-arm64.o
> util/annotate-arch/annotate-arm64.c
>
> 2) adding EXTRA_CFLAGS="-fPIC" to your make command. This should force
> this option wherever it might be missing.
>
> Thanks,
> Ian
>
> > Best regards,
> > Jan
> >
Hi Ian,

I tested both suggestions the second in the beginning of my research:

EXTRA_CFLAGS="-fPIC" - Does NOT work. Same error:

/usr/bin/ld.bfd: error: read-only segment has dynamic relocations
collect2: error: ld returned 1 exit status

The issue is s390x-specific R_390_PC32DBL relocations in perf-util-in.o
(from `larl` instructions) that persist even with -fPIC.

Current options:
1. Use -Wl,-z,notext (security issue)
2. Refactor code to avoid these relocations
3. Disable Python extension on s390x (not an option)

Thoughts?

Best regards,
Jan
