Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65AB3E1716;
	Wed, 10 Jun 2026 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092064; cv=none; b=E3DAjg/kYwTR7zmgTLDQtwvRK+J0IFDuG67pvEjzoFxOYzLPEMRlD5HAD1oY8rIZBZIYhYoiPKdXQeOPSvXQ3SQbJ+Vaf/q69dz9xvlUDEN5IumSIEAKJTPdHayXQoQWVJy39Ieojkn3dRlWkoveKGH9dtx9KqeCCRtEKRlGM3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092064; c=relaxed/simple;
	bh=mz2XZgkqHhahUDWxu7eMxcbax4iC6I7c1xKO++Y6qhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J2I922S5kTEFrmglR80zrw+yEZ6aqxbLNHCXsCS5FlWzbc1NH1G9e3SxOdeECyvCiO65ddHxtZPD0ltppRYkyVdovuoPixbvg5q6xitCDm4oWmyHhGGMLnnEqwFN9/1gvSIO++ZEn1u8CewW0jBZIB+/kRil5Rd9Xx7AeICt9z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L/rYqHKU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L/rYqHKU"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659NNP141029990;
	Wed, 10 Jun 2026 11:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2slaiA
	6D+XI4wg5R93fsJMsFzU6iRd0/kisNk3LqyDA=; b=L/rYqHKUGkGVjETKbDzVJp
	ZwhmCrFMB8HQhUcCPmxDcHRHjNbIbOhuEOquo9pCNz9MSXJp+pTS5sHP6dCvvoPz
	aM0t812wUt2vjTCa06Srgrnqi6VoB+ul/dhwCdVpH1YVqica0L6BNiaxQHvjFqEr
	sHo88xJTEly+J6d/ivlVb3vqUI7BELtRcnKHr/yY8bJDzU/Y5CbxEjvtyHsLudun
	7fvsWTmJY99zY/V9ZGe7oEN5nKoS61krwjgml23vrwmfqEHT6QUGwtwKhzSFzBOo
	9Jdi9hXXEL99PDqU56mNXT2G4AMo9AtPuhlbqsTqPJoogrIUi+vsqVD+3vLwDlag
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb95gv0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 11:47:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ABYcPB004405;
	Wed, 10 Jun 2026 11:47:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjxejs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 11:47:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65ABlaxt26345780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 11:47:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65FF42004B;
	Wed, 10 Jun 2026 11:47:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E65E20043;
	Wed, 10 Jun 2026 11:47:36 +0000 (GMT)
Received: from [9.224.91.136] (unknown [9.224.91.136])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 11:47:36 +0000 (GMT)
Message-ID: <e3e8fd9f-3da5-4b03-b2a6-bacd521ec1a8@linux.ibm.com>
Date: Wed, 10 Jun 2026 13:47:35 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf build: Fix Python extension build with GCC 16
 hardening
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jan Polensky <japo@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
References: <20260520125637.105681-1-japo@linux.ibm.com>
 <20260520130905.9C85D1F000E9@smtp.kernel.org> <ahJnMnOr4i9urrRk@x1>
 <ahV2XGx_6h7upuc3@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CAP-5=fXGG5PR8neTkozvOUOH83m8_EyZXZ_A7Zyrsock5EqAiQ@mail.gmail.com>
 <ahXITNt0Z-n4NCaj@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CAP-5=fXcpoXMsezy1FNBX7mhKmRgw+97QmKTg5Fr6G-cY+wGpg@mail.gmail.com>
 <ahddRWPBk46HiR6x@google.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <ahddRWPBk46HiR6x@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a294edc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=RmN1yAzgj0a4Wfzp4gMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2Dkcx7Moxf9uRQY-KRHxkkRwuZGGYebX
X-Proofpoint-GUID: i7xuE7Jk_rvw5yLEw9kza2YKOZW_DqvX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDExMSBTYWx0ZWRfXwAsIxR0lDNi5
 VMdrhT4LducCWx6GbafH6ip8pqr57S42dslLbNCWOfaRGum3aVG/4nIexJuQKSDtkGrEQJyivDz
 BFkkC+IA8vJ0ZSpAYqoBIj4uRdbviVm7/DVj1QSebzcq4Z6vGLicxuNBkjoAytFSYtJzZCo01pb
 pfc4hnMeXvjjJwjT7nT35mBuUfwxmEY9U4+rtkZHEOy3/RfCf8ipgl1O8r+E9inXNJo5KRyB2tg
 WtZF4H2ON/3flsIpq1KuaD4C5bcM8353zJxYl4tM6geBn/XNhFCwYzTvuv6lPiWwH1vx6Iw4yC4
 uxA8ew1n/qR0hR5GLlXxnaNT0/KeZXcqomHjniRqTmbK00b+f2Fagj2Nyh7yY68q8xjMTfiI4Hm
 gsNsRyQ2DB2CPPBaainurf20bEKccYUzWRoz8sRYYb8jy0sVx53u7tm4moynUkq4BGZTnfKyFf6
 82aBDMSwX+Z60zW+zjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100111

On 5/27/2026 11:08 PM, Namhyung Kim wrote:
> On Tue, May 26, 2026 at 09:59:41AM -0700, Ian Rogers wrote:
>> On Tue, May 26, 2026 at 9:20 AM Jan Polensky <japo@linux.ibm.com> wrote:
>>> On Tue, May 26, 2026 at 08:23:28AM -0700, Ian Rogers wrote:
>>>> On Tue, May 26, 2026 at 3:35 AM Jan Polensky <japo@linux.ibm.com> wrote:
>>>>> On Sat, May 23, 2026 at 11:49:22PM -0300, Arnaldo Carvalho de Melo wrote:
>>>>>> On Wed, May 20, 2026 at 01:09:05PM +0000, sashiko-bot@kernel.org wrote:
>>>>>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>>>>>> - [Medium] The patch explicitly allows text relocations in the Python extension shared object (`perf.so`) by adding `-Wl,-z,notext`, masking the root cause of missing `-fPIC` flags and breaking W^X (Write XOR Execute) security protections.
>>>>>>> --
>>>>>>>
>>>>>>> commit f3832fb0ad0d1f9c2e69039b2a5110f77d220d5e
>>>>>>> Author: Jan Polensky <japo@linux.ibm.com>
>>>>>>>
>>>>>>> perf build: Fix Python extension build with GCC 16 hardening
>>>>>>>
>>>>>>> This commit addresses a build failure in the Python extension caused by GCC 16
>>>>>>> stricter security policies regarding dynamic relocations in read-only segments.
>>>>>>> It adds the -Wl,-z,notext flag to the linker to explicitly allow text
>>>>>>> relocations in the Python extension shared object.
>>>>>>>
>>>>>>>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>>>>>>>> index 76b35ac19acbf..eea170d6576db 100644
>>>>>>>> --- a/tools/perf/Makefile.perf
>>>>>>>> +++ b/tools/perf/Makefile.perf
>>>>>>>> @@ -749,7 +749,7 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
>>>>>>>>  $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
>>>>>>>>
>>>>>>>>  $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup.py $(PERFLIBS_PY)
>>>>>>>> - $(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
>>>>>>>> + $(QUIET_GEN)LDSHARED="$(CC) -pthread -shared -Wl,-z,notext" \
>>>>>>>
>>>>>>> [Severity: Medium]
>>>>>>> Does adding -Wl,-z,notext mask the root cause of the GCC 16 linker error?
>>>>>>>
>>>>>>> The error regarding dynamic relocations in a read-only segment usually
>>>>>>> indicates that non-position-independent code from the static libraries
>>>>>>> is being linked into the shared library.
>>>>>>>
>>>>>>> Using -Wl,-z,notext suppresses this error by allowing text relocations, which
>>>>>>> forces the dynamic linker to map the executable text segment as writable at
>>>>>>> load time. This breaks W^X security protections and weakens the security of
>>>>>>> any Python process loading the extension.
>>>>>>>
>>>>>>> Should the required object files be compiled with -fPIC instead to properly
>>>>>>> resolve the linker error without compromising security?
>>>>>>
>>>>>> So I asked Claude about this and he suggests doing like other parts of
>>>>>> perf and using -fPIC, can you try to do that?
>>>>>>
>>>>>> ---------------------------------------
>>>>>>
>>>>>> ● Sashiko is right. -Wl,-z,notext is a band-aid that weakens security —
>>>>>>   it makes the text segment writable at load time, defeating W^X.
>>>>>>
>>>>>>   The root cause is that PERFLIBS_PY (the static libraries linked into
>>>>>>   the Python .so) are compiled without -fPIC. When you link non-PIC .a
>>>>>>   archives into a shared library, the linker needs text relocations. GCC
>>>>>>   16 correctly rejects this by default.
>>>>>>
>>>>>>   The proper fix is to build the static libraries that go into the
>>>>>>   Python extension with -fPIC. The perf build system already has
>>>>>>   precedent for this — look for how libperf and libsubcmd handle PIC
>>>>>>   builds. The Python extension's dependencies need a parallel -fPIC
>>>>>>   build, or the existing objects need to be compiled with -fPIC when the
>>>>>>   Python binding is enabled.
>>>>>>
>>>>>>   The -Wl,-z,notext approach would also cause issues on distros that
>>>>>>   enforce RELRO + BIND_NOW hardening, and some package builders would
>>>>>>   reject the resulting .so outright.
>>>>>>
>>>>>> - Arnaldo
>>>>>
>>>>> Hi Arnaldo,
>>>>>
>>>>> thanks for the pointer. I double-checked this on s390x and did some reduced-link
>>>>> testing for the ET_DYN / Python-extension case.
>>>>>
>>>>> The failure is not triggered by the perf Python binding object alone.
>>>>>
>>>>> A reduced reproducer succeeds when linking:
>>>>>   python.o
>>>>>   + libapi.a
>>>>>   + libperf.a
>>>>>   + libsubcmd.a
>>>>>   + libsymbol.a
>>>>>   + libbpf.a
>>>>>   + libperf-ui.a
>>>>>
>>>>> The link starts to fail with:
>>>>>   /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
>>>>>
>>>>> as soon as libperf-util.a is added.
>>>>>
>>>>> In my tree, libperf-util.a currently contains only perf-util-in.o, and replacing
>>>>> the archive with that single object still reproduces the same failure.
>>>>>
>>>>> Reduced reproducer:
>>>>>
>>>>>   gcc -pthread -shared \
>>>>>     -Wl,-z,noexecstack \
>>>>>     -o /tmp/try-perf-util-only.so \
>>>>>     /root/linux/tools/perf/python_ext_build/tmp/root/linux/tools/perf/util/python.o \
>>>>>     -Wl,--whole-archive \
>>>>>       /root/linux/tools/perf/libapi/libapi.a \
>>>>>       /root/linux/tools/perf/libperf/libperf.a \
>>>>>       /root/linux/tools/perf/libsubcmd/libsubcmd.a \
>>>>>       /root/linux/tools/perf/libsymbol/libsymbol.a \
>>>>>       /root/linux/tools/perf/libbpf/libbpf.a \
>>>>>       /root/linux/tools/perf/libperf-ui.a \
>>>>>     -Wl,--no-whole-archive \
>>>>>     /root/perf-util-one/perf-util-in.o \
>>>>>     -lpython3.14 -lpthread -ldl -lm -lutil
>>>>>
>>>>> Inspection of perf-util-in.o on s390x shows many direct R_390_PC32DBL
>>>>> relocations from .text against .data.rel.ro, .data.rel.ro.local,
>>>>> .data.rel.local, .bss, and .rodata.

R_390_PC32DBL are PC-relative relocations that usually get resolved by
the linker during final link of the shared library.

>>>>>
>>>>> Representative examples include:
>>>>>
>>>>>   arm64__associate_instruction_ops:
>>>>>     larl %r6  -> R_390_PC32DBL .data.rel.ro+0x2
>>>>>
>>>>>   loongarch__associate_ins_ops:
>>>>>     larl %r9  -> R_390_PC32DBL .data.rel.ro+0x22
>>>>>     larl %r9  -> R_390_PC32DBL .data.rel.ro+0x42
>>>>>
>>>>>   check_ppc_insn:
>>>>>     larl %r4  -> R_390_PC32DBL .data.rel.local+0x4c2
>>>>>     larl %r2  -> R_390_PC32DBL .data.rel.ro.local+0x22
>>>>>     larl %r1  -> R_390_PC32DBL .data.rel.local+0x2
>>>>>     larl %r2  -> R_390_PC32DBL .data.rel.ro.local+0x2
>>>>>
>>>>>   s390__associate_ins_ops:
>>>>>     larl %r10 -> R_390_PC32DBL .data.rel.ro+0x732
>>>>>     larl %r10 -> R_390_PC32DBL .data.rel.ro+0x752
>>>>>
>>>>> So from my reproducer, I don't think we can describe this simply as
>>>>> "all Python-extension dependency archives are missing -fPIC".
>>>>>
>>>>> The issue narrows down much more specifically to perf-util-in.o in the ET_DYN
>>>>> link of the Python extension, and the direct text-to-data section relocations
>>>>> above look like the most relevant candidates.
>>>>>
>>>>> So I agree that -Wl,-z,notext is only a workaround. I'd prefer to understand
>>>>> and fix the underlying relocation pattern in perf-util-in.o rather than merge
>>>>> that as-is.
>>>>>
>>>>> If useful, I can send the relevant readelf/objdump snippets in a follow-up.
>>>>
>>>> Hi Jan,
>>>>
>>>> I wonder about two tests:
>>>> 1) adding V=1 JOBS=1 to your make command to switch on single
>>>> threading and build verbosity. This may make it possible to identify
>>>> the gcc command that is missing -fPIC. For example, I see -fPIC on
>>>> x86:
>>>>   gcc -Wp,-MD,/tmp/perf4/util/annotate-arch/.annotate-arm64.o.d
>>>> -Wp,-MT,/tmp/perf4/util/annotate-arch/annotate -arm64.o
>>>> -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security
>>>> -Wformat-y2k -Winit-self -Wmissin g-declarations -Wmissing-prototypes
>>>> -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls
>>>> -Wst rict-prototypes -Wswitch-default -Wswitch-enum -Wundef
>>>> -Wwrite-strings -Wformat -Wno-type-limits -Wstrict-alia sing=3
>>>> -Wshadow -fno-strict-aliasing -I/tmp/perf4/arch/x86/include/generated
>>>> -DHAVE_ARCH_X86_64_SUPPORT -Werro r -g -fno-omit-frame-pointer -Wall
>>>> -Wextra -std=gnu11 -funsigned-char -fstack-protector-all
>>>> -D_LARGEFILE64_SOU RCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
>>>> -I~/linux/tools/perf/util/include
>>>> -I~/linux/tools/perf/arch/x86/include
>>>> -I/usr/local/google/home/irogers/re pos/linux4/tools/include/
>>>> -I~/linux/tools/arch/x86/include/uapi -I/usr/loc
>>>> al/google/home/irogers/repos/linux4/tools/include/uapi
>>>> -I~/linux/tools/arc h/x86/include/ -I~/linux/tools/arch/x86/
>>>> -I/tmp/perf4//util -I/tmp/perf4/ -I~/linux/tools/perf/util
>>>> -I~/linux/to ols/perf -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP
>>>> -DHAVE_PTHREAD_BARRIER -DHAVE_EVENTFD_SUPPORT -DHAVE_GETTID -DHAVE
>>>> _FILE_HANDLE -DHAVE_AIO_SUPPORT -DHAVE_SCANDIRAT_SUPPORT
>>>> -DHAVE_SCHED_GETCPU_SUPPORT -DHAVE_SETNS_SUPPORT -DHA VE_ZLIB_SUPPORT
>>>> -DHAVE_LIBELF_SUPPORT -DHAVE_ELF_GETPHDRNUM_SUPPORT
>>>> -DHAVE_GELF_GETNOTE_SUPPORT -DHAVE_ELF_GET SHDRSTRNDX_SUPPORT
>>>> -DHAVE_DEBUGINFOD_SUPPORT -DHAVE_LIBDW_SUPPORT -DHAVE_LIBBPF_SUPPORT
>>>> -DHAVE_SDT_EVENT -DHAV E_JITDUMP -DHAVE_LIBOPENSSL_SUPPORT
>>>> -DHAVE_BPF_SKEL -DHAVE_DWARF_UNWIND_SUPPORT -DHAVE_SLANG_SUPPORT
>>>> -DHAVE_TI MERFD_SUPPORT -fPIC -DHAVE_LIBLLVM_SUPPORT
>>>> -I/usr/lib/llvm-19/include -D_GNU_SOURCE -D__STDC_CONSTANT_MACROS
>>>> -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS
>>>> -DHAVE_CXA_DEMANGLE_SUPPORT -DHAVE_LZMA_SUPPORT -DHAVE_ZSTD_SUPPORT
>>>> -DHAVE_BACKTRACE_SUPPORT -DHAVE_LIBNUMA_SUPPORT
>>>> -DHAVE_PERF_READ_VDSO32 -DHAVE_LIBBABELTRACE_SUPPORT -DHAVE_
>>>> LIBCAPSTONE_SUPPORT -DHAVE_JVMTI_CMLR -DHAVE_LIBPFM
>>>> -DHAVE_LIBTRACEEVENT -I/usr/include/traceevent -DLIBTRACEE
>>>> VENT_VERSION=67072 -DHAVE_RUST_SUPPORT -I/tmp/perf4/libapi/include
>>>> -I/tmp/perf4/libbpf/include -I/tmp/perf4/li bsubcmd/include
>>>> -I/tmp/perf4/libsymbol/include -I/tmp/perf4/libperf/include
>>>> -I/tmp/perf4/ -D"BUILD_STR(s)=#s" -c -o
>>>> /tmp/perf4/util/annotate-arch/annotate-arm64.o
>>>> util/annotate-arch/annotate-arm64.c
>>>>
>>>> 2) adding EXTRA_CFLAGS="-fPIC" to your make command. This should force
>>>> this option wherever it might be missing.
>>>>
>>>> Thanks,
>>>> Ian
>>>>
>>>>> Best regards,
>>>>> Jan
>>>>>
>>> Hi Ian,
>>>
>>> I tested both suggestions the second in the beginning of my research:
>>>
>>> EXTRA_CFLAGS="-fPIC" - Does NOT work. Same error:
>>>
>>> /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
>>> collect2: error: ld returned 1 exit status

This did not work because EXTRA_CLFAGS do not get appended to CXXFLAGS
(see below).

>>>
>>> The issue is s390x-specific R_390_PC32DBL relocations in perf-util-in.o
>>> (from `larl` instructions) that persist even with -fPIC.
>>>
>>> Current options:
>>> 1. Use -Wl,-z,notext (security issue)
>>> 2. Refactor code to avoid these relocations
>>> 3. Disable Python extension on s390x (not an option)
>>>
>>> Thoughts?
>>
>> So it appears that part of the problem is declaring arrays and structs
>> to be const. Making things non-const I think is also not an option.
>> Would  EXTRA_CFLAGS="-fvisibility=hidden" help?
>>
>> It would we interesting to build with -Wl,-z,notext and then look for
>> the symbol the linker is fighting with:
>>   eu-findtextrel perf.cpython....so

Thanks for the hint!

$ eu-findtextrel python_ext_build/lib/perf.cpython-314-s390x-linux-gnu.so
either the file containing the function '_ZN4llvm7hashing6detailL2k3E' or the file containing the function '_ZN4llvm7numbersL7inv_pisE' is not compiled with -fpic/-fPIC
either the file containing the function '_ZN4llvm7numbersL3pisE' or the file containing the function '_ZN4llvmL18BitReverseTable256E' is not compiled with -fpic/-fPIC

Inspecting the objdump -wDzR output shows that the issue is caused by a
few R_390_RELATIVE relocations in .rodata:

$ objdump -wDzR tools/perf/python/perf.cpython-314-s390x-linux-gnu.so
...
Disassembly of section .rodata:
...
000000000034efc8 <_ZN4llvm7hashing6detailL2k3E>:
  34efc8:       c9 49 d7 c7             .long   0xc949d7c7
  34efcc:       50 9e 65 57             st      %r9,1367(%r14,%r6)
  34efd0:       33 2e                   lcer    %f2,%f14
...
  34eff4:       38 34                   ler     %f3,%f4
  34eff6:       00 00           .long   0x00000000      34eff8: R_390_RELATIVE  *ABS*+0x34efd0

000000000034eff8 <_ZN4llvm7numbersL3pisE>:
  34eff8:       00 00 00 00             .long   0x00000000      34eff8: R_390_RELATIVE  *ABS*+0x34efd0
  34effc:       00 34 ef d0             .long   0x0034efd0
  34f000:       30 2e                   lper    %f2,%f14
...
  34f024:       32 34                   lter    %f3,%f4
  34f026:       00 00           .long   0x00000000      34f028: R_390_RELATIVE  *ABS*+0x34f000

000000000034f028 <_ZN4llvm7numbersL7inv_pisE>:
  34f028:       00 00 00 00             .long   0x00000000      34f028: R_390_RELATIVE  *ABS*+0x34f000
  34f02c:       00 34 f0 00             .long   0x0034f000

000000000034f030 <_ZN4llvmL18BitReverseTable256E>:
  34f030:       00 80 40 c0             .long   0x008040c0
...

They originate from util/llvm-c-helpers.o, which gets linked into
util/perf-util-in.o, which gets linked into perf-util-in.o, which gets
copied into archive libperf-util.a, which finally gets linked into the
shared library:

$ find . -type f -name "*.o" -print0 | xargs -0 nm -A | grep "_ZN4llvm7numbersL7inv_pisE"
nm: ./tools/perf/arch/perf-test-in.o: no symbols
./tools/perf/perf-util-in.o:000000000006e240 r _ZN4llvm7numbersL7inv_pisE
./tools/perf/util/llvm-c-helpers.o:0000000000000080 r _ZN4llvm7numbersL7inv_pisE
./tools/perf/util/perf-util-in.o:000000000006e240 r _ZN4llvm7numbersL7inv_pisE

util/llvm-c-helpers.o is built from util/llvm-c-helpers.cc.  The cause
is that CXXFLAGS for s390 is missing -fPIC.  Commit a9a3f1d18a6c ("perf
s390: Always build with -fPIC") added compiler option -fPIC to CFLAGS
for s390.  I have sent a new patch to resolve this issue:

[PATCH] perf s390: Fix TEXTREL in Python extension by compiling as PIC
https://lore.kernel.org/all/20260610112451.1553054-1-jremus@linux.ibm.com/

>> or
>>   readelf -d perf.so | grep TEXTREL
>>   readelf -r perf.so
> 
> I'm curious if it's s390 specific.  I don't know what code patterns make
> it relocatable.  Is taking an address of struct ins_ops variable a
> problem?  Does it matter being a static variable?
I did not investigate why other architectures do not (need to) add -fPIC
to CFLAGS/CXXFLAGS in tools/perf/Makefile.config although a shared
library is built.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

