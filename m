Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787DD2C326F;
	Tue, 26 May 2026 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791462; cv=none; b=oNmQ1THJcP4z7XvJN0Fs8P8g7E0Xjd9S2uUCCj5EcYBr7pKZZLUEmvmlWUDnVgM7P75oS5JszWC0fgBV7TxqFoRXht0l0qB/6AO2xLxJvJ7jG6M8NVKpF/d1ecOStw03AcvJKpEKnKTjYrAva3J1OuxEsb4aSMY4wQ66woQyrMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791462; c=relaxed/simple;
	bh=9nI/XZXWx0TRJY53v1ueqo3AtordZ7Q+StNAST4h1Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ne0pV8YaqaggEFNRJcg75ioB/8RK8A/ZE6vYHgOXA5YKPq66AZv/iUNO1obV9U6bLAXCS0QKMVcinEwzouLurio4QEDztC39R8DGGv5G1WDnZJXLkBG/3BLM+UatM5mnB2aDuptyvg2OUx1p1QtDBcWvB0lIuVRjW4I9lSAgaXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TTE9TRb4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TTE9TRb4"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q9cwoO3034174;
	Tue, 26 May 2026 10:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RUMLh3
	hrCrad4s6AFjrGCGgdTQpgoSnw812imxo8H94=; b=TTE9TRb4v0mX/LbfZ1AxkK
	VocqoVUq0NXwoSCg59re9SQe1lQnl8o2pND4XhpDbjIlh6uoDrPHfNoMOaNqdgNB
	80D3HdGJzpzITVNVarL0qpBiFVEWtnF9Oxv81eH5CXkX/ldVyzt3fUoxEoiNyUUR
	BObmUVOtf6dwBABo+UQQqP08WBiOc+MZFM4hFAjbCWQSgzy5oyyCow5MpKVM7HFI
	ZprcYQlZdUMOSod8ymgsTd/7xKZ3xNLtzRwsQ2Lqv4meRi+vX0MX31cfFatcvLP2
	itqhSgzeoix7OvVuynYZfPEDU8E+Y4J52jP/wkIvTrnpmtinPXIDEverbFQ1YXAw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nc2kxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 10:30:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64QAOAsC031853;
	Tue, 26 May 2026 10:30:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebr2h0t84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 10:30:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64QAUsml13107682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 10:30:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E7022004F;
	Tue, 26 May 2026 10:30:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B2AA2004B;
	Tue, 26 May 2026 10:30:54 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.87.150.50])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 26 May 2026 10:30:54 +0000 (GMT)
Date: Tue, 26 May 2026 12:30:52 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jens Remus <jremus@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf build: Fix Python extension build with GCC 16
 hardening
Message-ID: <ahV2XGx_6h7upuc3@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260520125637.105681-1-japo@linux.ibm.com>
 <20260520130905.9C85D1F000E9@smtp.kernel.org>
 <ahJnMnOr4i9urrRk@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahJnMnOr4i9urrRk@x1>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=VvYTxe2n c=1 sm=1 tr=0 ts=6a157661 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=4Z9HsFBe0V0Fvg4R7qgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: j4N9mQ1Ze3luG7q_TyQggw0yHsV5xmFK
X-Proofpoint-GUID: j4N9mQ1Ze3luG7q_TyQggw0yHsV5xmFK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA4OCBTYWx0ZWRfXxiBZxKRwjxB3
 rjw+Jbjn9X5bOAHXg0l4ME5pAtER1Ytb9z4tvGwCDjhkgoFPa4K4eormnESpkgf6iGFQN3LLfW2
 /6oP/76sgGX1qN0wiHvGdlFBGjEmbOVcKFsRNhkGB3Y0Y0jme3Ia6gLzuRRKLs1qXzkJNwFw3Ou
 qyRsUkD0D3Q21IvBiCuZnzBrg7Y0BaOWqGMuHYDM0rmOGO0qnzCFqhdxAixujdv3aOP+wam7oxG
 lkRdO+BC3f4V+XjzZCYnfXOk1BnYJuHoeFSla0p/Q1IrM0LK/SFtmqPUmXwqYONZHydxcOjMaUO
 cseo1i9Qzoz6SFNciv2kLXvtVp8OdYsW6+vURJWduBbyyIT0TtvlvjAVBJneGbXk3pX7SavKZ1k
 JiJYQpJjczemQ0zBwQ54J27be3zMNVa3V9N+wzHMOFiq8PQ1FHO7x889VcAsHjbdsw4uxMY1WKF
 U54LxsaHwwY036NeWGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260088

On Sat, May 23, 2026 at 11:49:22PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, May 20, 2026 at 01:09:05PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] The patch explicitly allows text relocations in the Python extension shared object (`perf.so`) by adding `-Wl,-z,notext`, masking the root cause of missing `-fPIC` flags and breaking W^X (Write XOR Execute) security protections.
> > --
> >
> > commit f3832fb0ad0d1f9c2e69039b2a5110f77d220d5e
> > Author: Jan Polensky <japo@linux.ibm.com>
> >
> > perf build: Fix Python extension build with GCC 16 hardening
> >
> > This commit addresses a build failure in the Python extension caused by GCC 16
> > stricter security policies regarding dynamic relocations in read-only segments.
> > It adds the -Wl,-z,notext flag to the linker to explicitly allow text
> > relocations in the Python extension shared object.
> >
> > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > index 76b35ac19acbf..eea170d6576db 100644
> > > --- a/tools/perf/Makefile.perf
> > > +++ b/tools/perf/Makefile.perf
> > > @@ -749,7 +749,7 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
> > >  $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
> > >
> > >  $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup.py $(PERFLIBS_PY)
> > > -	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
> > > +	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared -Wl,-z,notext" \
> >
> > [Severity: Medium]
> > Does adding -Wl,-z,notext mask the root cause of the GCC 16 linker error?
> >
> > The error regarding dynamic relocations in a read-only segment usually
> > indicates that non-position-independent code from the static libraries
> > is being linked into the shared library.
> >
> > Using -Wl,-z,notext suppresses this error by allowing text relocations, which
> > forces the dynamic linker to map the executable text segment as writable at
> > load time. This breaks W^X security protections and weakens the security of
> > any Python process loading the extension.
> >
> > Should the required object files be compiled with -fPIC instead to properly
> > resolve the linker error without compromising security?
>
> So I asked Claude about this and he suggests doing like other parts of
> perf and using -fPIC, can you try to do that?
>
> ---------------------------------------
>
> ● Sashiko is right. -Wl,-z,notext is a band-aid that weakens security —
>   it makes the text segment writable at load time, defeating W^X.
>
>   The root cause is that PERFLIBS_PY (the static libraries linked into
>   the Python .so) are compiled without -fPIC. When you link non-PIC .a
>   archives into a shared library, the linker needs text relocations. GCC
>   16 correctly rejects this by default.
>
>   The proper fix is to build the static libraries that go into the
>   Python extension with -fPIC. The perf build system already has
>   precedent for this — look for how libperf and libsubcmd handle PIC
>   builds. The Python extension's dependencies need a parallel -fPIC
>   build, or the existing objects need to be compiled with -fPIC when the
>   Python binding is enabled.
>
>   The -Wl,-z,notext approach would also cause issues on distros that
>   enforce RELRO + BIND_NOW hardening, and some package builders would
>   reject the resulting .so outright.
>
> - Arnaldo

Hi Arnaldo,

thanks for the pointer. I double-checked this on s390x and did some reduced-link
testing for the ET_DYN / Python-extension case.

The failure is not triggered by the perf Python binding object alone.

A reduced reproducer succeeds when linking:
  python.o
  + libapi.a
  + libperf.a
  + libsubcmd.a
  + libsymbol.a
  + libbpf.a
  + libperf-ui.a

The link starts to fail with:
  /usr/bin/ld.bfd: error: read-only segment has dynamic relocations

as soon as libperf-util.a is added.

In my tree, libperf-util.a currently contains only perf-util-in.o, and replacing
the archive with that single object still reproduces the same failure.

Reduced reproducer:

  gcc -pthread -shared \
    -Wl,-z,noexecstack \
    -o /tmp/try-perf-util-only.so \
    /root/linux/tools/perf/python_ext_build/tmp/root/linux/tools/perf/util/python.o \
    -Wl,--whole-archive \
      /root/linux/tools/perf/libapi/libapi.a \
      /root/linux/tools/perf/libperf/libperf.a \
      /root/linux/tools/perf/libsubcmd/libsubcmd.a \
      /root/linux/tools/perf/libsymbol/libsymbol.a \
      /root/linux/tools/perf/libbpf/libbpf.a \
      /root/linux/tools/perf/libperf-ui.a \
    -Wl,--no-whole-archive \
    /root/perf-util-one/perf-util-in.o \
    -lpython3.14 -lpthread -ldl -lm -lutil

Inspection of perf-util-in.o on s390x shows many direct R_390_PC32DBL
relocations from .text against .data.rel.ro, .data.rel.ro.local,
.data.rel.local, .bss, and .rodata.

Representative examples include:

  arm64__associate_instruction_ops:
    larl %r6  -> R_390_PC32DBL .data.rel.ro+0x2

  loongarch__associate_ins_ops:
    larl %r9  -> R_390_PC32DBL .data.rel.ro+0x22
    larl %r9  -> R_390_PC32DBL .data.rel.ro+0x42

  check_ppc_insn:
    larl %r4  -> R_390_PC32DBL .data.rel.local+0x4c2
    larl %r2  -> R_390_PC32DBL .data.rel.ro.local+0x22
    larl %r1  -> R_390_PC32DBL .data.rel.local+0x2
    larl %r2  -> R_390_PC32DBL .data.rel.ro.local+0x2

  s390__associate_ins_ops:
    larl %r10 -> R_390_PC32DBL .data.rel.ro+0x732
    larl %r10 -> R_390_PC32DBL .data.rel.ro+0x752

So from my reproducer, I don't think we can describe this simply as
"all Python-extension dependency archives are missing -fPIC".

The issue narrows down much more specifically to perf-util-in.o in the ET_DYN
link of the Python extension, and the direct text-to-data section relocations
above look like the most relevant candidates.

So I agree that -Wl,-z,notext is only a workaround. I'd prefer to understand
and fix the underlying relocation pattern in perf-util-in.o rather than merge
that as-is.

If useful, I can send the relevant readelf/objdump snippets in a follow-up.

Best regards,
Jan
