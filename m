Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533E81AED35;
	Wed, 14 Aug 2024 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723643061; cv=none; b=j71ohJ5xFehO4oWo1VvdxoFNCJ6aZjb2trCHRrqmsh4vEmEbkHXH9gHq42puReR06Rf2PVVavPZ/fWhxFblce3RVScZf/WTWZvUu8vcOWIvhWZNqgPwRSdRQXhz2UZJALox9Yz+gvy3OTmDf+0f1zW3qrSki2RoGkiG7RJbMIUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723643061; c=relaxed/simple;
	bh=m0jWcwhf/ttXSLSNTt2fI6PUHZ4JnxkkMYY2ImFmzLY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mNK9jvSCCwdAqdsc3/hwKL48gl5g5ae259mEHdkTggu+B3L4oCYK/0MZTUltmKv+QJ29CcP7TwFMR1/4OfY6pOkzTTPuc6jWZhg1ByPW/581wFqZRkraHJpDtSah7t6F83Ntr7xKrPqfn5Rr4Gbswq4xzcvkNwjwY/bAZrQ/2do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1XhUo1w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1XhUo1w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CF5C32786;
	Wed, 14 Aug 2024 13:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723643060;
	bh=m0jWcwhf/ttXSLSNTt2fI6PUHZ4JnxkkMYY2ImFmzLY=;
	h=Date:From:To:Cc:Subject:From;
	b=Z1XhUo1wPGq4uuQe8OwOOlb0gc/VQDrtr6L0G38QI5uOmYjd0VqCvcNgq6Y7R3aDo
	 ce43k00MSK8L4yBusJyamQkLooAUcUtjSHmLVsQnvjW6cAYIS1kNvybXf0AXaEWzn9
	 /XxSkkK2uY85x25rCDh+LNv3s+FVOmcUhFcgLSn9aV7+9L+dFqxYXPXJ1y2LBrBd9S
	 WQaj5yRni4IwZHoMdYRiGROvEBoP7A/PiZSVxF6estqH+tzSM++mrIgB9qP6j8VyWj
	 JQMwbUkC8BxVT2F5V+anRPfJj7roGPBGzRBW1SzRkerXaZ4RDbaK2EUerPfa/GgzDd
	 2Ddinb5EFkD4w==
Date: Wed, 14 Aug 2024 10:44:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Changbin Du <changbin.du@huawei.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andi Kleen <andi@firstfloor.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf build: Fix up broken capstone feature detection
 fast path
Message-ID: <Zry0sepD5Ppa5YKP@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The capstone devel headers define 'struct bpf_insn' in a way that clashes with
what is in the libbpf devel headers, so we so far need to avoid including both.

This is happening on the tools/build/feature/test-all.c file, where we try
building all the expected set of libraries to be normally available on a
system:

  ⬢[acme@toolbox perf-tools-next]$ cat /tmp/build/perf-tools-next/feature/test-all.make.output
  In file included from test-bpf.c:3,
                   from test-all.c:150:
  /home/acme/git/perf-tools-next/tools/include/uapi/linux/bpf.h:77:8: error: ‘bpf_insn’ defined as wrong kind of tag
     77 | struct bpf_insn {
        |        ^~~~~~~~
  ⬢[acme@toolbox perf-tools-next]$ cat /tmp/build/perf-tools-next/feature/test-all.make.output

When doing so there is a trick where we define main to be
main_test_libcapstone, then include the individual
tools/build/feture/test-libcapstone.c capability query test, and then we undef
'main' because we'll do it all over again with the next expected library to
be tested (at this time 'lzma').

To complete this mechanism we need to, in test-all.c 'main' routine, to
call main_test_libcapstone(), which isn't being done, so the effect of
adding references to capstone in test-all.c are not achieved.

The only thing that is happening is that test-all.c is failing to build and thus
all the tests will have to be done individually, which nullifies the test-all.c
single build speedup.

So lets remove references to capstone from test-all.c to see if this makes it
build again so that we get faster builds or go on fixing up whatever is
preventing us to get that benefit.

Nothing: after this fix we get a clean test-all.c build and get the build speedup back:

  ⬢[acme@toolbox perf-tools-next]$ cat /tmp/build/perf-tools-next/feature/test-all.make.output
  ⬢[acme@toolbox perf-tools-next]$ cat /tmp/build/perf-tools-next/feature/test-all.
  test-all.bin          test-all.d            test-all.make.output
  ⬢[acme@toolbox perf-tools-next]$ cat /tmp/build/perf-tools-next/feature/test-all.make.output
  ⬢[acme@toolbox perf-tools-next]$ ldd /tmp/build/perf-tools-next/feature/test-all.bin
  	linux-vdso.so.1 (0x00007f13277a1000)
  	libpython3.12.so.1.0 => /lib64/libpython3.12.so.1.0 (0x00007f1326e00000)
  	libm.so.6 => /lib64/libm.so.6 (0x00007f13274be000)
  	libtraceevent.so.1 => /lib64/libtraceevent.so.1 (0x00007f1327496000)
  	libtracefs.so.1 => /lib64/libtracefs.so.1 (0x00007f132746f000)
  	libcrypto.so.3 => /lib64/libcrypto.so.3 (0x00007f1326800000)
  	libunwind-x86_64.so.8 => /lib64/libunwind-x86_64.so.8 (0x00007f1327452000)
  	libunwind.so.8 => /lib64/libunwind.so.8 (0x00007f1327436000)
  	liblzma.so.5 => /lib64/liblzma.so.5 (0x00007f1327403000)
  	libdw.so.1 => /lib64/libdw.so.1 (0x00007f1326d6f000)
  	libz.so.1 => /lib64/libz.so.1 (0x00007f13273e2000)
  	libelf.so.1 => /lib64/libelf.so.1 (0x00007f1326d53000)
  	libnuma.so.1 => /lib64/libnuma.so.1 (0x00007f13273d4000)
  	libslang.so.2 => /lib64/libslang.so.2 (0x00007f1326400000)
  	libperl.so.5.38 => /lib64/libperl.so.5.38 (0x00007f1326000000)
  	libc.so.6 => /lib64/libc.so.6 (0x00007f1325e0f000)
  	libzstd.so.1 => /lib64/libzstd.so.1 (0x00007f1326741000)
  	/lib64/ld-linux-x86-64.so.2 (0x00007f13277a3000)
  	libbz2.so.1 => /lib64/libbz2.so.1 (0x00007f1326d3f000)
  	libcrypt.so.2 => /lib64/libcrypt.so.2 (0x00007f1326d07000)
  ⬢[acme@toolbox perf-tools-next]$

And when having capstone-devel installed we get it detected and linked with
perf, allowing us to benefit from the features that it enables:

  ⬢[acme@toolbox perf-tools-next]$ rpm -q capstone-devel
  capstone-devel-5.0.1-3.fc40.x86_64
  ⬢[acme@toolbox perf-tools-next]$ ldd /tmp/build/perf-tools-next/perf | grep capstone
  	libcapstone.so.5 => /lib64/libcapstone.so.5 (0x00007fe6a5c00000)
  ⬢[acme@toolbox perf-tools-next]$ /tmp/build/perf-tools-next/perf -vv | grep cap
             libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
  ⬢[acme@toolbox perf-tools-next]$

Fixes: 8b767db3309595a2 ("perf: build: introduce the libcapstone")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Changbin Du <changbin.du@huawei.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-all.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index dd0a18c2ef8fc080..6f4bf386a3b5c4b0 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -134,10 +134,6 @@
 #undef main
 #endif
 
-#define main main_test_libcapstone
-# include "test-libcapstone.c"
-#undef main
-
 #define main main_test_lzma
 # include "test-lzma.c"
 #undef main
-- 
2.45.2

