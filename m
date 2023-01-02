Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57883C3DA7A
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Jan 2023 13:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjABNP7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 2 Jan 2023 08:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABNP7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 2 Jan 2023 08:15:59 -0500
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A5E329
        for <linux-perf-users@vger.kernel.org>; Mon,  2 Jan 2023 05:15:56 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id DC12A20512;
        Mon,  2 Jan 2023 14:15:54 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vIXClcE8QzmZ; Mon,  2 Jan 2023 14:15:54 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 1B1F82049B;
        Mon,  2 Jan 2023 14:15:54 +0100 (CET)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
        by mailout1.secunet.com (Postfix) with ESMTP id 159C580004A;
        Mon,  2 Jan 2023 14:15:54 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 2 Jan 2023 14:15:31 +0100
Received: from [10.36.110.53] (10.36.110.53) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 2 Jan
 2023 14:15:31 +0100
To:     Ian Rogers <irogers@google.com>
CC:     <linux-perf-users@vger.kernel.org>
From:   Torsten Hilbrich <torsten.hilbrich@secunet.com>
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
Subject: [v6.2-rc1] Regression with installing perf tool
Message-ID: <fa4b3115-d555-3d7f-54d1-018002e99350@secunet.com>
Date:   Mon, 2 Jan 2023 14:16:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------A1EE5D9F069779FEFDD462BB"
Content-Language: en-US
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

--------------A1EE5D9F069779FEFDD462BB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello,

I recently tried a kernel build based on v6.2-rc2 and had some regression when trying to install the perf command. It seems that the commit:

commit 746bd29e348f99b44c14cb2b2a57f1d3efb66538
Author: Ian Rogers <irogers@google.com>
Date:   Tue Nov 15 23:22:11 2022 -0800

    perf build: Use tools/lib headers from install path
    
    Switch -I from tools/lib to the install path for the tools/lib
    libraries. Add the include_headers build targets to prepare target, as
    well as pmu-events.c compilation that dependes on libperf.
    
Causes the the following command to fail: "make -C tools/ perf_install"

Full logs are attached as file.

The basic error is that the adding of $(LIBAPI), $(LIBSYMBOLS) and others to the prepare target seems to has problems when the subdir variable is set by the tools/Makefile.

The call chains seems to include

- "make -C tools perf_install" which calls:
- "make  subdir=perf --no-print-directory -C perf install" which then fails

The beginning of tools/scripts/Makfile.include then seems to construct a name like /build/git/linux/tools/perf/libapi/perf/ (when building in /build/git/linux) and this directory does not exist.

We only need the perf tool in this case, so we don't care much about the optional features which are missing.

Thanks,

	Torsten


--------------A1EE5D9F069779FEFDD462BB
Content-Type: text/x-log; charset="UTF-8"; name="install.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="install.log"

bullseye+x86_64@ws-3:~/git/linux ((v6.2-rc2))$ make -C tools/ perf_instal=
l
make: Entering directory '/build/git/linux/tools'
  DESCEND perf
make[1]: Entering directory '/build/git/linux/tools/perf'
  BUILD:   Doing 'make -j64' parallel build
Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs fr=
om latest version at 'include/uapi/linux/kvm.h'
diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/perf_reg=
s.h' differs from latest version at 'arch/arm64/include/uapi/asm/perf_reg=
s.h'
diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/include/=
uapi/asm/perf_regs.h
Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/kvm.h' dif=
fers from latest version at 'arch/x86/include/uapi/asm/kvm.h'
diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/k=
vm.h
Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h' d=
iffers from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/a=
sm/kvm.h
Warning: Kernel ABI header at 'tools/arch/arm64/include/asm/cputype.h' di=
ffers from latest version at 'arch/arm64/include/asm/cputype.h'
diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cpu=
type.h
Warning: Kernel ABI header at 'tools/include/linux/build_bug.h' differs f=
rom latest version at 'include/linux/build_bug.h'
diff -u tools/include/linux/build_bug.h include/linux/build_bug.h
Warning: Kernel ABI header at 'tools/perf/trace/beauty/include/linux/sock=
et.h' differs from latest version at 'include/linux/socket.h'
diff -u tools/perf/trace/beauty/include/linux/socket.h include/linux/sock=
et.h
Makefile.config:460: No libdw DWARF unwind found, Please install elfutils=
-devel/libdw-dev >=3D 0.158 and/or set LIBDW_DIR
Makefile.config:465: No libdw.h found or old libdw.h found or elfutils is=
 older than 0.138, disables dwarf support. Please install new elfutils-de=
vel/libdw-dev
Makefile.config:623: DWARF support is off, BPF prologue is disabled
Makefile.config:631: No sys/sdt.h found, no SDT events are defined, pleas=
e install systemtap-sdt-devel or systemtap-sdt-dev
Makefile.config:679: No libunwind found. Please install libunwind-dev[el]=
 >=3D 1.1 and/or set LIBUNWIND_DIR
Makefile.config:718: Disabling post unwind, no support found.
Makefile.config:802: slang not found, disables TUI support. Please instal=
l slang-devel, libslang-dev or libslang2-dev
Makefile.config:849: Missing perl devel files. Disabling perl scripting s=
upport, please install perl-ExtUtils-Embed/libperl-dev
Makefile.config:880: No python interpreter was found: disables Python sup=
port - please install python-devel/python-dev
Makefile.config:915: No python interpreter disabling jevent generation
Makefile.config:953: Old version of libbfd/binutils things like PE execut=
able profiling will not be available
Makefile.config:971: No bfd.h/libbfd found, please install binutils-dev[e=
l]/zlib-static/libiberty-dev to gain symbol demangling
Makefile.config:1002: No liblzma found, disables xz kernel module decompr=
ession, please install xz-devel/liblzma-dev
Makefile.config:1015: No libzstd found, disables trace compression, pleas=
e install libzstd-dev[el] and/or set LIBZSTD_DIR
Makefile.config:1026: No libcap found, disables capability support, pleas=
e install libcap-devel/libcap-dev
Makefile.config:1039: No numa.h found, disables 'perf bench numa mem' ben=
chmark, please install numactl-devel/libnuma-devel/libnuma-dev
Makefile.config:1098: No libbabeltrace found, disables 'perf data' CTF fo=
rmat support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:1212: Warning: libtraceevent is missing limiting function=
ality, please install libtraceevent-dev/libtraceevent-devel

Auto-detecting system features:
=2E..                                   dwarf: [ OFF ]
=2E..                      dwarf_getlocations: [ OFF ]
=2E..                                   glibc: [ on  ]
=2E..                                  libbfd: [ OFF ]
=2E..                          libbfd-buildid: [ OFF ]
=2E..                                  libcap: [ OFF ]
=2E..                                  libelf: [ on  ]
=2E..                                 libnuma: [ OFF ]
=2E..                  numa_num_possible_cpus: [ OFF ]
=2E..                                 libperl: [ OFF ]
=2E..                               libpython: [ OFF ]
=2E..                               libcrypto: [ on  ]
=2E..                               libunwind: [ OFF ]
=2E..                      libdw-dwarf-unwind: [ OFF ]
=2E..                                    zlib: [ on  ]
=2E..                                    lzma: [ OFF ]
=2E..                               get_cpuid: [ on  ]
=2E..                                     bpf: [ on  ]
=2E..                                  libaio: [ on  ]
=2E..                                 libzstd: [ OFF ]

/bin/sh: 1: cd: can't cd to /build/git/linux/tools/perf/libperf/perf/
/build/git/linux/tools/scripts/Makefile.include:17: *** output directory =
"/build/git/linux/tools/perf/libperf/perf/" does not exist.  Stop.
make[3]: *** [Makefile.perf:839: /build/git/linux/tools/perf/libperf/libp=
erf.a] Error 2
make[3]: *** Waiting for unfinished jobs....
/bin/sh: 1: cd: can't cd to /build/git/linux/tools/perf/libapi/perf/
=2E./../scripts/Makefile.include:17: *** output directory "/build/git/lin=
ux/tools/perf/libapi/perf/" does not exist.  Stop.
make[3]: *** [Makefile.perf:821: /build/git/linux/tools/perf/libapi/libap=
i.a] Error 2
/bin/sh: 1: cd: can't cd to /build/git/linux/tools/perf/libsymbol/perf/
=2E./../scripts/Makefile.include:17: *** output directory "/build/git/lin=
ux/tools/perf/libsymbol/perf/" does not exist.  Stop.
make[3]: *** [Makefile.perf:857: /build/git/linux/tools/perf/libsymbol/li=
bsymbol.a] Error 2
/bin/sh: 1: cd: can't cd to /build/git/linux/tools/perf/libsubcmd/perf/
=2E./../scripts/Makefile.include:17: *** output directory "/build/git/lin=
ux/tools/perf/libsubcmd/perf/" does not exist.  Stop.
make[3]: *** [Makefile.perf:848: /build/git/linux/tools/perf/libsubcmd/li=
bsubcmd.a] Error 2
  CC      jvmti/libjvmti.o
  CC      jvmti/jvmti_agent.o
  CC      jvmti/libstring.o
  CC      jvmti/libctype.o
  INSTALL libbpf_headers
  PERF_VERSION =3D 6.2.rc2.g88603b6dc419
  LD      jvmti/jvmti-in.o
make[2]: *** [Makefile.perf:236: sub-make] Error 2
make[1]: *** [Makefile:113: install] Error 2
make[1]: Leaving directory '/build/git/linux/tools/perf'
make: *** [Makefile:132: perf_install] Error 2
make: Leaving directory '/build/git/linux/tools'

--------------A1EE5D9F069779FEFDD462BB--
