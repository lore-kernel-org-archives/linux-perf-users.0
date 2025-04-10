Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798401D89FD;
	Thu, 10 Apr 2025 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284688; cv=none; b=Oz1ml5Lv+Am/yMtpE4XbSB16GHN4WCtBnxJfO+HzGXm7o45C5xuaVbw9x2IIgI7WVolNMl8PP1WKknOJQCcZfQoptxBmJFxcBJHyvslQ6XUEaR3WpQklpjr31d+V5r/CUQsvZskDu2DaNzphHSsXUnRVgQxfwDYp/hQRvPA70Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284688; c=relaxed/simple;
	bh=YAbWMDqb6A/MktOyCsKaT7umT1NIMOnxoCuuD+8LUZw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=C9XaK6xxXseRXNHfyCtdl61v3R+3xkQHtGgqnLa1j4kG9qrLlCbfotXSyly+ZWNPU/YQEGW5CaboGQLAN3YcxIbVYTz8zWr4Zi926OSGnK01y8PPUTTxfJFVsymCcbi4ev2rsU+m/cylZh8UOPsC5lDAehSUsmQ6TxjxOG2EO6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FiMZpwon; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FiMZpwon"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A82lpA026359;
	Thu, 10 Apr 2025 11:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A0xZZt
	8lP25cShHGZagWIGb2cnCUIRRznY2e5ZGnV6c=; b=FiMZpwonG9z4SOQbI7ZD9R
	4020nGSpTxcA+hvIYVf1F67aXbn678iOqgeZDwSdXGZcnABxno8MnssQ357U1yKQ
	4PEimAMsOtqBhDR6KD/jMccfq5ac9e57rWEaGC46wLq7ebOI599HYoiA6iDchUqn
	bEAFmH/6622WkDR1Kl+R+boL23yBD7SPpIaz7g7r3A4zIrZalQ+2HsH6qtBQCEiC
	F0qeV1GpIizN4oPsB4B+Pzy54ubnj7SjYDdCSAQpzf1N+1C0e9LkAS+OIVxGGtan
	OGPGLyWKIFDzNMNODZMqFLkmkPzmJfT6D7gWdpHXI7aq3NuqYUBD4PTh/UtpLTIA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wtaq6m69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 11:31:20 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53ABTD3E003612;
	Thu, 10 Apr 2025 11:31:20 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wtaq6m64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 11:31:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53A85Fax011326;
	Thu, 10 Apr 2025 11:31:18 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45uf7ywwu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 11:31:18 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53ABVIw729295290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 11:31:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F2F258058;
	Thu, 10 Apr 2025 11:31:18 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E8945805B;
	Thu, 10 Apr 2025 11:31:15 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.204.204.179])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 10 Apr 2025 11:31:14 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCHSET 00/10] tools headers: Sync header files with the kernel
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20250410001125.391820-1-namhyung@kernel.org>
Date: Thu, 10 Apr 2025 17:01:01 +0530
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE96FD04-4396-4C34-A70D-2A592FD5F916@linux.ibm.com>
References: <20250410001125.391820-1-namhyung@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Mc4vQUsr0RQgJsWEEyU4UIUgEdOzbkff
X-Proofpoint-ORIG-GUID: bYxo1ZiWoHlXtOy6d9IPNd9829kldJMS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504100086



> On 10 Apr 2025, at 5:41=E2=80=AFAM, Namhyung Kim <namhyung@kernel.org> =
wrote:
>=20
> Hello,
>=20
> FYI I'm carrying these changes in the perf tools tree so make perf =
trace
> beautifiers get the recent changes in syscall, ioctl, and so on.  For =
the
> background, please see tools/include/uapi/README.
>=20
> Still there are some remaining items but it requires a bit more =
changes.
> So I'd like to leave them for the next cycle.
>=20
>  Warning: Kernel ABI header differences:
>    diff -u tools/include/uapi/linux/bits.h include/uapi/linux/bits.h
>    diff -u tools/include/linux/bits.h include/linux/bits.h
>    diff -u tools/arch/arm64/include/asm/cputype.h =
arch/arm64/include/asm/cputype.h
>=20
> Thanks,
> Namhyung
>=20
>=20
> Namhyung Kim (10):
>  tools headers: Update the KVM headers with the kernel sources
>  tools headers: Update the socket headers with the kernel sources
>  tools headers: Update the uapi/linux/perf_event.h copy with the =
kernel sources
>  tools headers: Update the VFS headers with the kernel sources
>  tools headers: Update the syscall table with the kernel sources
>  tools headers: Update the uapi/linux/prctl.h copy with the kernel =
sources
>  tools headers: Update the uapi/asm-generic/mman-common.h copy with =
the kernel sources
>  tools headers: Update the linux/unaligned.h copy with the kernel =
sources
>  tools headers: Update the x86 headers with the kernel sources
>  tools headers: Update the arch/x86/lib/memset_64.S copy with the =
kernel sources
>=20
> tools/arch/arm64/include/uapi/asm/kvm.h       |  5 +-
> tools/arch/arm64/include/uapi/asm/unistd.h    | 24 +----
> tools/arch/x86/include/asm/cpufeatures.h      | 28 ++++--
> tools/arch/x86/include/asm/msr-index.h        | 31 +++---
> tools/arch/x86/include/uapi/asm/kvm.h         |  4 +
> tools/arch/x86/include/uapi/asm/svm.h         |  2 +
> tools/arch/x86/lib/memset_64.S                |  3 +-
> tools/include/linux/cfi_types.h               | 45 +++++++++
> tools/include/uapi/asm-generic/mman-common.h  |  1 +
> tools/include/uapi/asm-generic/unistd.h       |  4 +-
> tools/include/uapi/linux/in.h                 |  2 +
> tools/include/uapi/linux/kvm.h                |  9 +-
> tools/include/uapi/linux/perf_event.h         |  2 +
> tools/include/uapi/linux/stat.h               | 99 ++++++++++++++-----
> .../perf/arch/arm/entry/syscalls/syscall.tbl  |  1 +
> .../arch/mips/entry/syscalls/syscall_n64.tbl  |  1 +
> .../arch/powerpc/entry/syscalls/syscall.tbl   |  1 +
> .../perf/arch/s390/entry/syscalls/syscall.tbl |  1 +
> tools/perf/arch/sh/entry/syscalls/syscall.tbl |  1 +
> .../arch/sparc/entry/syscalls/syscall.tbl     |  1 +
> .../arch/x86/entry/syscalls/syscall_32.tbl    |  3 +-
> .../arch/x86/entry/syscalls/syscall_64.tbl    |  1 +
> .../arch/xtensa/entry/syscalls/syscall.tbl    |  1 +
> tools/perf/check-headers.sh                   |  1 +
> .../perf/trace/beauty/include/linux/socket.h  |  2 +
> .../trace/beauty/include/uapi/linux/fcntl.h   |  4 +
> .../perf/trace/beauty/include/uapi/linux/fs.h | 21 +++-
> .../trace/beauty/include/uapi/linux/mount.h   | 10 +-
> .../trace/beauty/include/uapi/linux/prctl.h   | 11 +++
> .../trace/beauty/include/uapi/linux/stat.h    | 99 ++++++++++++++-----
> .../trace/beauty/include/uapi/sound/asound.h  |  8 +-
> tools/scripts/syscall.tbl                     |  1 +
> 32 files changed, 318 insertions(+), 109 deletions(-)

Tested this patch series by applying on the base commit: =
0af2f6be1b4281385b618cb86ad946eded089ac8 and it fixes the warnings.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>



Before this patch:

 make
  BUILD:   Doing 'make -j32' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/include/uapi/linux/bits.h include/uapi/linux/bits.h
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
  diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h
  diff -u tools/include/uapi/linux/perf_event.h =
include/uapi/linux/perf_event.h
  diff -u tools/include/uapi/linux/stat.h include/uapi/linux/stat.h
  diff -u tools/include/linux/bits.h include/linux/bits.h
  diff -u tools/arch/x86/include/asm/cpufeatures.h =
arch/x86/include/asm/cpufeatures.h
  diff -u tools/arch/x86/include/asm/msr-index.h =
arch/x86/include/asm/msr-index.h
  diff -u tools/arch/x86/include/uapi/asm/kvm.h =
arch/x86/include/uapi/asm/kvm.h
  diff -u tools/arch/x86/include/uapi/asm/svm.h =
arch/x86/include/uapi/asm/svm.h
  diff -u tools/arch/arm64/include/uapi/asm/kvm.h =
arch/arm64/include/uapi/asm/kvm.h
  diff -u tools/arch/arm64/include/uapi/asm/unistd.h =
arch/arm64/include/uapi/asm/unistd.h
  diff -u tools/include/uapi/asm-generic/mman-common.h =
include/uapi/asm-generic/mman-common.h
  diff -u tools/include/uapi/asm-generic/unistd.h =
include/uapi/asm-generic/unistd.h
  diff -u tools/scripts/syscall.tbl scripts/syscall.tbl
  diff -u tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_64.S
  diff -u tools/arch/arm64/include/asm/cputype.h =
arch/arm64/include/asm/cputype.h
  diff -u tools/perf/arch/x86/entry/syscalls/syscall_32.tbl =
arch/x86/entry/syscalls/syscall_32.tbl
  diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl =
arch/x86/entry/syscalls/syscall_64.tbl
  diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl =
arch/powerpc/kernel/syscalls/syscall.tbl
  diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl =
arch/s390/kernel/syscalls/syscall.tbl
  diff -u tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl =
arch/mips/kernel/syscalls/syscall_n64.tbl
  diff -u tools/perf/arch/arm/entry/syscalls/syscall.tbl =
arch/arm/tools/syscall.tbl
  diff -u tools/perf/arch/sh/entry/syscalls/syscall.tbl =
arch/sh/kernel/syscalls/syscall.tbl
  diff -u tools/perf/arch/sparc/entry/syscalls/syscall.tbl =
arch/sparc/kernel/syscalls/syscall.tbl
  diff -u tools/perf/arch/xtensa/entry/syscalls/syscall.tbl =
arch/xtensa/kernel/syscalls/syscall.tbl
  diff -u tools/perf/trace/beauty/include/linux/socket.h =
include/linux/socket.h
  diff -u tools/perf/trace/beauty/include/uapi/linux/fcntl.h =
include/uapi/linux/fcntl.h
  diff -u tools/perf/trace/beauty/include/uapi/linux/fs.h =
include/uapi/linux/fs.h
  diff -u tools/perf/trace/beauty/include/uapi/linux/mount.h =
include/uapi/linux/mount.h
  diff -u tools/perf/trace/beauty/include/uapi/linux/prctl.h =
include/uapi/linux/prctl.h
  diff -u tools/perf/trace/beauty/include/uapi/linux/stat.h =
include/uapi/linux/stat.h
  diff -u tools/perf/trace/beauty/include/uapi/sound/asound.h =
include/uapi/sound/asound.h
Makefile.config:1093: No libcapstone found, disables disasm engine =
support for 'perf script', please install libcapstone-dev/capstone-devel
Makefile.config:1155: libpfm4 not found, disables libpfm4 support. =
Please install libpfm4-dev

Auto-detecting system features:
...                                   libdw: [ on  ]
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
...                             libcapstone: [ OFF ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ OFF ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

  GEN     common-cmds.h
  GEN     =
/root/linux/tools/perf/arch/arm64/include/generated/asm/sysreg-defs.h
  PERF_VERSION =3D 6.15.rc1.g0af2f6be1b42
  GEN     perf-archive


After this patch:

 make
  BUILD:   Doing 'make -j32' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/include/uapi/linux/bits.h include/uapi/linux/bits.h
  diff -u tools/include/linux/bits.h include/linux/bits.h
  diff -u tools/arch/arm64/include/asm/cputype.h =
arch/arm64/include/asm/cputype.h
Makefile.config:1093: No libcapstone found, disables disasm engine =
support for 'perf script', please install libcapstone-dev/capstone-devel
Makefile.config:1155: libpfm4 not found, disables libpfm4 support. =
Please install libpfm4-dev

Auto-detecting system features:
...                                   libdw: [ on  ]
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
...                             libcapstone: [ OFF ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ OFF ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

  GEN     common-cmds.h
  GEN     =
/root/linux/tools/perf/arch/arm64/include/generated/asm/sysreg-defs.h
  PERF_VERSION =3D 6.15.rc1.g634c975b88f0
  GEN     perf-archive



>  create mode 100644 tools/include/linux/cfi_types.h
>=20
>=20
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> --=20
> 2.49.0.504.g3bcea36a83-goog
>=20
>=20

