Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722697FBA2;
	Sat, 10 May 2025 01:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746841368; cv=none; b=qELDXG22+Mz8kdkV+Osnwg/o9n557WPONoGtY7/rs4RXWap6YSe6REL6Bgv3VgV8mGiJOIoyl39685hLSQVmIl2l1KhjaXdhpZjLbyipOJ6k3rOAVNh1lThjgeYSu3uwFEiYtm4KSH4npGmXo7TNiQpLwtN5PrcqmEmK5UFrsXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746841368; c=relaxed/simple;
	bh=dUUQMmWR7Jy1/aAsU/wZxQjB+U//saDUPDcTRXqcbmw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qU3uRQ4a5q5GcCVqt6prSQNL16gtmOxjZcNY4lzkDTZIwVY1d/xwX9MO3BBcm5qeunT/ZqjaCCCt7TypUMd47vNUArroEOYmfpN9GgllNU2d7IowJlC5NzZ5hVgQMDTyPOsmBdJm3evPDiJ7GH9JWZRNp4xeKVdd61N9ZZnKRLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APX+pI7n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APX+pI7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4D0C4CEE4;
	Sat, 10 May 2025 01:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746841367;
	bh=dUUQMmWR7Jy1/aAsU/wZxQjB+U//saDUPDcTRXqcbmw=;
	h=Date:From:To:Cc:Subject:From;
	b=APX+pI7ndkDqi3osqafP2nlyI+lXBAV9pWoDEvdcnWFa5xvaFPMjaEOfXDD+nPS/5
	 R2Vaz3Nc6agcjQgMUbdil52eWTRZfzWRgctPLur9worcFUk/QoSLqqb789NzxA9Zsw
	 p3ueZSnXTOCoIes+tOCz8x+AqtnXRbNaV+cLQotmQioeHKMcaS3UGDOo6QrAnRxnGB
	 z2XW8m54reAg0QzPPtJf6uDJx5MpdeFfJFhC1BHi/RQcjgLHbJouRfovmt8Dlp5Ejo
	 AiOwpjqfFU8AgXCNxtueb/fEj4xj8aJ7wjZX8gklXXqteiw+xPzISNgBAutIIjuf7/
	 Df1eiQrWgRjSA==
Date: Fri, 9 May 2025 22:42:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: make -C tools/perf build-test failing on aarch64
Message-ID: <aB6vFFcRErPVt7p9@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

	I noticed that upstream is failing on aarch64:

acme@raspberrypi:~/git/perf-tools-next $ uname -a
Linux raspberrypi 6.12.25+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.12.25-1+rpt1 (2025-04-30) aarch64 GNU/Linux
acme@raspberrypi:~/git/perf-tools-next $ grep -m1 Model /proc/cpuinfo 
Model		: Raspberry Pi 5 Model B Rev 1.1
acme@raspberrypi:~/git/perf-tools-next $ 
acme@raspberrypi:~/git/perf-tools-next $ git log --oneline -1 ; time make -C tools/perf build-test
cd17a9b1a779 (HEAD -> perf-tools-next, number/perf-tools-next, number/HEAD) perf test demangle-ocaml: Switch to using dso__demangle_sym()
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
- tarpkg: ./tests/perf-targz-src-pkg .
make[1]: *** [tests/make:351: tarpkg] Error 2
make: *** [Makefile:109: build-test] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'

real	0m12.130s
user	0m12.653s
sys	0m2.091s
acme@raspberrypi:~/git/perf-tools-next $ 

I noticed that it is using some files from outside tools/, i.e. kernel
files, so I tried adding those (and its dependencies) to the
tools/perf/MANIFEST, but stumbled at this point:

acme@raspberrypi:~/git/perf-tools-next $ git diff
diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index 364b55b00b48..3fe627c4b599 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -28,3 +28,6 @@ scripts/bpf_doc.py
 tools/bpf/bpftool
 kernel/bpf/disasm.c
 kernel/bpf/disasm.h
+scripts/Kbuild.include
+scripts/Makefile.asm-headers
+include/uapi/asm-generic/Kbuild
acme@raspberrypi:~/git/perf-tools-next $

To test it directly:

acme@raspberrypi:~/git/perf-tools-next $ sh -x tools/perf/tests/perf-targz-src-pkg tools/perf 
+ set -e
+ PERF=tools/perf
+ cd tools/perf/../..
+ make perf-targz-src-pkg
  ARCHIVE perf-6.15.0-rc5.tar.gz
+ ls -rt perf-6.15.0-rc5.tar.gz
+ TARBALL=perf-6.15.0-rc5.tar.gz
+ mktemp -d
+ TMP_DEST=/tmp/tmp.wzVpK2Gmvw
+ tar xf perf-6.15.0-rc5.tar.gz -C /tmp/tmp.wzVpK2Gmvw
+ rm -f perf-6.15.0-rc5.tar.gz
+ cd -
+ make -C /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf
make: Entering directory '/tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf'
  BUILD:   Doing 'make -j4' parallel build

Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ OFF ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

  PERF_VERSION = 6.15.rc5.gcd17a9b1a779
  GEN     common-cmds.h
  GEN     /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/arch/arm64/include/generated/asm/sysreg-defs.h
  CC      jvmti/libjvmti.o
  GEN     perf-archive
  GEN     perf-iostat
  CC      dlfilters/dlfilter-test-api-v0.o
  CC      dlfilters/dlfilter-test-api-v2.o
  CC      dlfilters/dlfilter-show-cycles.o
  CC      jvmti/jvmti_agent.o
  CC      jvmti/libstring.o
  CC      jvmti/libctype.o
  MKDIR   /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/fd/
  CC      /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/fd/array.o
make[4]: *** No rule to make target '/tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libperf/arch/arm64/include/generated/uapi/asm/unistd_64.h'.  Stop.
make[3]: *** [Makefile:108: uapi-asm-generic] Error 2
make[2]: *** [Makefile.perf:973: /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libperf/libperf.a] Error 2
make[2]: *** Waiting for unfinished jobs....
  INSTALL /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/include/api/cpu.h
  MKDIR   /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/fs/
  MKDIR   /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/fs/
  CC      /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/fs/fs.o
  CC      /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/fs/tracing_path.o
  LD      jvmti/jvmti-in.o
  CC      /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/cpu.o
  LD      /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/fd/libapi-in.o
  CC      /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/debug.o
  INSTALL /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/include/api/debug.h
  INSTALL /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/include/api/io.h
  INSTALL /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/include/api/io_dir.h
  MKDIR   /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/fs/
  CC      /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/fs/cgroup.o
  CC      /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/str_error_r.o
  INSTALL /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/include/api/fd/array.h
  INSTALL /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/include/api/fs/fs.h
  INSTALL /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/include/api/fs/tracing_path.h
  INSTALL libapi_headers
  LD      /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/fs/libapi-in.o
  LD      /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/libapi-in.o
  AR      /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/libapi.a
make[1]: *** [Makefile.perf:290: sub-make] Error 2
make: *** [Makefile:76: all] Error 2
make: Leaving directory '/tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf'
acme@raspberrypi:~/git/perf-tools-next $

I think this is related to:

commit bfb713ea53c746b07ae69fe97fa9b5388e4f34f9 (perf-tools)
Author: James Clark <james.clark@linaro.org>
Date:   Thu Apr 17 14:55:50 2025 +0100

    perf tools: Fix arm64 build by generating unistd_64.h

Can you please take a look?

Thanks a lot,

- Arnaldo
