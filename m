Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88CC14265
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jan 2024 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="cEViNrQl"
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E5E2D20748;
	Mon,  8 Jan 2024 11:57:19 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jofO8htoX1wG; Mon,  8 Jan 2024 11:57:16 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 4A96D2006C;
	Mon,  8 Jan 2024 11:57:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4A96D2006C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1704711436;
	bh=evyZcUMTU6KYRZgoy87BGtaexxUdX5vkDnBXCbHjnQM=;
	h=To:CC:From:Subject:Date:From;
	b=cEViNrQlP6reVjkpiO0orXKEQO0Q8SdvH+jVXrF2ucAhxjUexHqQW5itpCGbPrGKn
	 ovdk3Ru3TfDehE6sb7AilJYNT9N6KPHygzE7N0PBeYn00sMySAJtWFwIW/hak065/C
	 bSjYnKRsS6to00ZoC3Dl2nDON6LIHxMqqGi79uDtF3/J5lymoawlop+ZbNgU4sJ4LR
	 4REodYjxV3sCJlNe3mg23lOlVOrnqZmOjBwBWgy11x0BzbpptwbKmEj4Bezp66a8wp
	 zUz4bGm/Ngmr2G69/kNfEAiiJK5qmg/wGJLKVQvQVbHZ21wWvZVFze/klMiOXberGs
	 sT58rKo7/8NgQ==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 3EDA780004A;
	Mon,  8 Jan 2024 11:57:16 +0100 (CET)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 11:57:16 +0100
Received: from [10.36.110.53] (10.36.110.53) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 11:57:15 +0100
To: Oliver Upton <oliver.upton@linux.dev>
CC: <linux-perf-users@vger.kernel.org>
From: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Autocrypt: addr=torsten.hilbrich@secunet.com; prefer-encrypt=mutual; keydata=
 mQENBFs5uIIBCAD4qbEieyT7sBmcro1VrCE1sSnV29a9ub8c0Xj0yw0Cz2N7LalBn4a+YeJN
 OMfL1MQvEiTxZNIzb1I0bRYcfhkhjN4+vAoPJ3q1OpSY+WUgphUbzseUk/Bq3gwvfa6/U+Hm
 o2lvEfN2dewBGptQ+DrWz+SPM1TQiwShKjowY/avaVgrABBGen3LgB0XZXEH8Q720kjP7htK
 tCGRt1T+qNIj3tZDZfPkqEVb8lTRcyn1hI3/FbDTysletRrCmkHSVbnxNzO6lw2G1H61wQhw
 YVbIVNohY61ieSJFhNLL6/UTGHtUE2IAicnsUAUKR8GiI1+3cTf233O5HaWYeOjBmTCLABEB
 AAG0L1RvcnN0ZW4gSGlsYnJpY2ggPHRvcnN0ZW4uaGlsYnJpY2hAc2VjdW5ldC5jb20+iQE3
 BBMBCAAhBQJbObiCAhsDBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEJ7rXZh78/h8+tIH
 +QFYRQH4qh3WagcmjbG/zCe2RmZZePO8bmut2fAxY04aqJZGYUBxb5lfaWaHkstqM5sFD8Jo
 k1j5E7f1cnfwB21azdUO8fzYL889kdVOzatdT/uTjR7OjR59gpJMd4lx7fwFuZUg8z6rfWJ3
 ImjxxBgaJRL6pqaZ9lOst82O0qJKEFBR+HDUVvgh4n8TTOfKNv/dGPQhaed+2or98asdYRWo
 S/zc4ltTh4SxZjLd98pDxjlUyOJoMJeWdlMmLgWV3h1qjy4DxgQzvgATEaKjOuwtkCOcwHn7
 Unf0F2V9p4O7NFOuoVyqTBRX+5xKgzSM7VP1RlTT4FA9/7wkhhG+FEK5AQ0EWzm4ggEIAL9F
 IIPQYMx5x+zMjm8lDsmh12zoqCtMfn9QWrERd2gDS3GsORbe/i6DhYvzsulH8vsviPle4ocU
 +PaTwadfnEqm0FS7xCONYookDGfAiPS4cHWX7WrTNBP7mK3Gl1KaAOJJsMbCVAA9q4d8WL+A
 e+XrfOAetZq5gxLxDMYySNI1pIMJVrGECiboLa/LPPh2yw4jieAedW96CPuZs7rUY/5uIVt0
 Dn4/aSzV+Ixr52Z2McvNmH/VxDt59Z6jBztZIJBXpX3BC/UyH7rJOJTaqEF+EVWEpOmSoZ6u
 i1DWyqOBKnQrbUa0fpNd3aaOl2KnlgTH9upm70XZGpeJik/pQGcAEQEAAYkBHwQYAQgACQUC
 Wzm4ggIbDAAKCRCe612Ye/P4fEzqB/9gcM/bODO8o9YR86BLp0S8bF73lwIJyDHg5brjqAnz
 CtCdb4I+evI4iyU9zuN1x4V+Te5ej+mUu5CbIte8gQbo4cc9sbe/AEDoOh0lGoXKZiwtHqoh
 RZ4jOFrZJsEjOSUCLE8E8VR1afPf0SkFXLXWZfZDU28K80JWeV1BCtxutZ39bz6ybMbcCvMS
 UfwCTY0IJOiDga1K4H2HzHAqlvfzCurqe616S4S1ax+erg3KTEXylxmzcFjJU8AUZURy/lQt
 VElzs4Km1p3v6GUciCAb+Uhd12sQG2mL05jmEems9uRe3Wfke/RKp8A+Yq+p6E0A0ZOP+Okm
 LXB2q+ckPvZG
Subject: v6.7: Regressions trying to install perf tool
Message-ID: <489365ba-20ce-230a-05e6-939637e3896c@secunet.com>
Date: Mon, 8 Jan 2024 11:57:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hello,

I'm currently trying to update to kernel v6.7 and the installation of the perf tool fails. It seems that the output directory is somehow set to
tools/perf/perf which is the name of the perf binary.


----- cut ------------------------------------------
[DEVSHELL(linux-tools):tools]$ make   NO_LIBPERL=1 NO_LIBPYTHON=1 NO_GTK2=1 NO_LIBTRACEEVENT=1 DESTDIR=$PWD/foo perf_install
make[1]: Entering directory '/build/client/devel/linux-tools/work/linux-2.6/tools'
mkdir -p perf && make  subdir=perf  -C perf install
make[2]: Entering directory '/build/client/devel/linux-tools/work/linux-2.6/tools/perf'
  BUILD:   Doing 'make -j64' parallel build
make -C /build/client/devel/linux-tools/work/linux-2.6/tools/build CFLAGS= LDFLAGS= fixdep
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=. obj=fixdep
Warning: Kernel ABI header differences:
  diff -u tools/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h
  diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
  diff -u tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_64.S
make FIXDEP=1 -f Makefile.perf install
Makefile.config:607: No sys/sdt.h found, no SDT events are defined, please install systemtap-sdt-devel or systemtap-sdt-dev
Makefile.config:655: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR
Makefile.config:879: Python support disabled by user
Makefile.config:992: No liblzma found, disables xz kernel module decompression, please install xz-devel/liblzma-dev
Makefile.config:1005: No libzstd found, disables trace compression, please install libzstd-dev[el] and/or set LIBZSTD_DIR
Makefile.config:1029: No numa.h found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev
Makefile.config:1088: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:1153: libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev

Auto-detecting system features:
...                                   dwarf: [ on  ]
...                      dwarf_getlocations: [ on  ]
...                                   glibc: [ on  ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libcap: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ OFF ]
...                  numa_num_possible_cpus: [ OFF ]
...                                 libperl: [ OFF ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ OFF ]
...                      libdw-dwarf-unwind: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ OFF ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ OFF ]

$(:)
make -C /build/client/devel/linux-tools/work/linux-2.6/tools/lib/api/ O=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libapi \
	DESTDIR=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libapi prefix= subdir= \
	/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libapi/libapi.a install_headers
make -C /build/client/devel/linux-tools/work/linux-2.6/tools/lib/perf/ O=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libperf \
	DESTDIR=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libperf prefix= subdir= \
	/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libperf/libperf.a install_headers
make -C /build/client/devel/linux-tools/work/linux-2.6/tools/lib/subcmd/ O=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libsubcmd \
	DESTDIR=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libsubcmd prefix= subdir= \
	/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libsubcmd/libsubcmd.a install_headers
make -C /build/client/devel/linux-tools/work/linux-2.6/tools/lib/symbol/ O=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libsymbol \
	DESTDIR=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libsymbol prefix= subdir= \
	/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libsymbol/libsymbol.a install_headers
make -C /build/client/devel/linux-tools/work/linux-2.6/tools/lib/bpf/ FEATURES_DUMP=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/FEATURE-DUMP \
	O= OUTPUT=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libbpf/ DESTDIR=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libbpf prefix= subdir= \
	/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libbpf/libbpf.a install_headers
/bin/sh util/PERF-VERSION-GEN 
make -C /build/client/devel/linux-tools/work/linux-2.6/tools/arch/arm64/tools O=/build/client/devel/linux-tools/work/linux-2.6/tools/perf
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=jvmti obj=jvmti
make -C /build/client/devel/linux-tools/work/linux-2.6/tools/perf/tests/shell/coresight
make -C /build/client/devel/linux-tools/work/linux-2.6/tools/perf/Documentation/ O= try-install-man ASCIIDOC_EXTRA=
/bin/sh: 1: cd: can't cd to /build/client/devel/linux-tools/work/linux-2.6/tools/perf/perf/
/build/client/devel/linux-tools/work/linux-2.6/tools/scripts/Makefile.include:17: *** output directory "/build/client/devel/linux-tools/work/linux-2.6/tools/perf/perf/" does not exist.  Stop.
make[4]: *** [Makefile.perf:445: arm64-sysreg-defs] Error 2
make[4]: *** Waiting for unfinished jobs....
make[5]: 'install_headers' is up to date.
make[5]: 'install_headers' is up to date.
Makefile:210: Please install asciidoc to have the man pages installed
make[5]: Nothing to be done for 'try-install-man'.
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=./fd obj=libapi
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=./fs obj=libapi
make[5]: 'install_headers' is up to date.
make[5]: 'install_headers' is up to date.
make[5]: 'install_headers' is up to date.
make[3]: *** [Makefile.perf:242: sub-make] Error 2
make[2]: *** [Makefile:113: install] Error 2
make[2]: Leaving directory '/build/client/devel/linux-tools/work/linux-2.6/tools/perf'
make[1]: *** [Makefile:132: perf_install] Error 2
make[1]: Leaving directory '/build/client/devel/linux-tools/work/linux-2.6/tools'
----- cut ------------------------------------------

When I revert the following commit:

commit a29ee6aea7030786a63fde0d6d83a8f477b060fb
Author: Oliver Upton <oliver.upton@linux.dev>
Date:   Tue Nov 21 19:29:56 2023 +0000

    perf build: Ensure sysreg-defs Makefile respects output dir
    
    Currently the sysreg-defs are written out to the source tree
    unconditionally, ignoring the specified output directory. Correct the
    build rule to emit the header to the output directory. Opportunistically
    reorganize the rules to avoid interleaving with the set of beauty make
    rules.

(after fixing some conflicts in tools/testing/selftests/kvm/Makefile) the installation worked fine:

----- cut ------------------------------------------
[DEVSHELL(linux-tools):tools]$ make   NO_LIBPERL=1 NO_LIBPYTHON=1 NO_GTK2=1 NO_LIBTRACEEVENT=1 DESTDIR=$PWD/foo perf_install
make[1]: Entering directory '/build/client/devel/linux-tools/work/linux-2.6/tools'
mkdir -p perf && make  subdir=perf  -C perf install
make[2]: Entering directory '/build/client/devel/linux-tools/work/linux-2.6/tools/perf'
  BUILD:   Doing 'make -j64' parallel build
make -C /build/client/devel/linux-tools/work/linux-2.6/tools/build CFLAGS= LDFLAGS= fixdep
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=. obj=fixdep
Warning: Kernel ABI header differences:
  diff -u tools/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h
  diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
  diff -u tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_64.S
make FIXDEP=1 -f Makefile.perf install
Makefile.config:607: No sys/sdt.h found, no SDT events are defined, please install systemtap-sdt-devel or systemtap-sdt-dev
Makefile.config:655: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR
Makefile.config:879: Python support disabled by user
Makefile.config:992: No liblzma found, disables xz kernel module decompression, please install xz-devel/liblzma-dev
Makefile.config:1005: No libzstd found, disables trace compression, please install libzstd-dev[el] and/or set LIBZSTD_DIR
Makefile.config:1029: No numa.h found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev
Makefile.config:1088: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:1153: libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev

Auto-detecting system features:
...                                   dwarf: [ on  ]
...                      dwarf_getlocations: [ on  ]
...                                   glibc: [ on  ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libcap: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ OFF ]
...                  numa_num_possible_cpus: [ OFF ]
...                                 libperl: [ OFF ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ OFF ]
...                      libdw-dwarf-unwind: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ OFF ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ OFF ]

$(:)
make -C /build/client/devel/linux-tools/work/linux-2.6/tools/lib/api/ O=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libapi \
	DESTDIR=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libapi prefix= subdir= \
	/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libapi/libapi.a install_headers
make -C /build/client/devel/linux-tools/work/linux-2.6/tools/lib/perf/ O=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libperf \
	DESTDIR=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libperf prefix= subdir= \
	/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libperf/libperf.a install_headers
make -C /build/client/devel/linux-tools/work/linux-2.6/tools/lib/subcmd/ O=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libsubcmd \
	DESTDIR=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libsubcmd prefix= subdir= \
	/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libsubcmd/libsubcmd.a install_headers
make -C /build/client/devel/linux-tools/work/linux-2.6/tools/lib/symbol/ O=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libsymbol \
	DESTDIR=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libsymbol prefix= subdir= \
	/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libsymbol/libsymbol.a install_headers
make -C /build/client/devel/linux-tools/work/linux-2.6/tools/lib/bpf/ FEATURES_DUMP=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/FEATURE-DUMP \
	O= OUTPUT=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libbpf/ DESTDIR=/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libbpf prefix= subdir= \
	/build/client/devel/linux-tools/work/linux-2.6/tools/perf/libbpf/libbpf.a install_headers
/bin/sh util/PERF-VERSION-GEN 
make -C /build/client/devel/linux-tools/work/linux-2.6/tools/arch/arm64/tools
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=jvmti obj=jvmti
make -C /build/client/devel/linux-tools/work/linux-2.6/tools/perf/tests/shell/coresight
make -C /build/client/devel/linux-tools/work/linux-2.6/tools/perf/Documentation/ O= try-install-man ASCIIDOC_EXTRA=
make[5]: 'install_headers' is up to date.
make[5]: 'install_headers' is up to date.
make[5]: 'install_headers' is up to date.
Makefile:210: Please install asciidoc to have the man pages installed
make[5]: Nothing to be done for 'try-install-man'.
make[5]: 'install_headers' is up to date.
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=./fd obj=libapi
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=./fs obj=libapi
make[5]: 'install_headers' is up to date.
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=. obj=perf
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=pmu-events obj=pmu-events
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=./bench obj=perf
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=./tests obj=perf
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=./util obj=perf
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=./arch obj=perf
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=./ui obj=perf
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=./scripts obj=perf
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=./arch/x86 obj=perf
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=./arch/x86/util obj=perf
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=./arch/x86/tests obj=perf
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=./ui/browsers obj=perf
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=./ui/tui obj=perf
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=./tests/workloads obj=perf
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=./util/perf-regs-arch obj=perf
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=./util/intel-pt-decoder obj=perf
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=./util/arm-spe-decoder obj=perf
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=./util/hisi-ptt-decoder obj=perf
make -f /build/client/devel/linux-tools/work/linux-2.6/tools/build/Makefile.build dir=./util/scripting-engines obj=perf
\
	install -d -m 755 '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/bin'; \
	install perf '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/bin'; \
	ln -f '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/bin/perf' '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/bin/trace'; \
	install -d -m 755 '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/include/perf'; \
	install -m 644 include/perf/perf_dlfilter.h -t '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/include/perf'
\
	install -d -m 755 '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/libexec/perf-core/tests'; \
	install tests/attr.py -m 644 '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/libexec/perf-core/tests'; \
	install tests/pe-file.exe* '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/libexec/perf-core/tests'; \
	install -d -m 755 '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/libexec/perf-core/tests/attr'; \
	install tests/attr/* -m 644 '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/libexec/perf-core/tests/attr'; \
	install -d -m 755 '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/libexec/perf-core/tests/shell'; \
	install tests/shell/*.sh '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/libexec/perf-core/tests/shell'; \
	install -d -m 755 '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/libexec/perf-core/tests/shell/lib'; \
	install tests/shell/lib/*.sh -m 644 '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/libexec/perf-core/tests/shell/lib'; \
	install tests/shell/lib/*.py -m 644 '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/libexec/perf-core/tests/shell/lib'; \
	install -d -m 755 '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/libexec/perf-core/tests/shell/coresight' ; \
	install tests/shell/coresight/*.sh '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/libexec/perf-core/tests/shell/coresight'
\
	install perf-read-vdso32 '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/bin';
\
	install perf-read-vdsox32 '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/bin';
\
	install -d -m 755 '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/lib64'; \
	install libperf-jvmti.so '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/lib64';
make -C tests/shell/coresight install-tests
\
	install -d -m 755 '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/libexec/perf-core'
\
	install perf-archive -t '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/libexec/perf-core'
\
	install perf-iostat -t '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/libexec/perf-core'
\
	install -d -m 755 '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/share/perf-core/strace/groups'; \
	install trace/strace/groups/* -m 644 -t '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/share/perf-core/strace/groups'
\
	install -d -m 755 '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/libexec/perf-core/dlfilters'; \
	install dlfilters/dlfilter-test-api-v0.so dlfilters/dlfilter-test-api-v2.so dlfilters/dlfilter-show-cycles.so '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/libexec/perf-core/dlfilters';
\
	install -d -m 755 '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/etc/bash_completion.d'; \
	install perf-completion.sh -m 644 '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/etc/bash_completion.d/perf'
\
	install -d -m 755 '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/share/doc/perf-tip'; \
	install Documentation/tips.txt -m 644 -t '/build/client/devel/linux-tools/work/linux-2.6/tools/foo/share/doc/perf-tip'
make[2]: Leaving directory '/build/client/devel/linux-tools/work/linux-2.6/tools/perf'
make[1]: Leaving directory '/build/client/devel/linux-tools/work/linux-2.6/tools'
----- cut ------------------------------------------

Is there a better solution to this problem?

Thanks,

	Torsten


