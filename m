Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA2C176ADE;
	Wed, 11 Sep 2024 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057465; cv=none; b=NMpON23gLIqr/KoLITAtzPyvtUhzlSQ2IH5vTqc4wHMktP0vGnNzecFOHQIw+RhAsKRf5knncm/HE603AvWVyzUb/p8vMUwekmqx3m8HQYqml4lXz/V5EAW/i2whtGGijtJDGVIvoMC3i7beUegRsinaiMt33P/Y3iqAZ4B9oEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057465; c=relaxed/simple;
	bh=JIcm/bK+B+iIDJKC8qj0BdktGrx7MNafVncb3B0pjfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mSxPWFs+O2Kk9apyJlp+y6fXPQge1PBVzErTpxTAJH5WjoVJiX4uxOEWPe3B6D9MWWgCV5BPDurMA7IU6t/Z76pE8fyhq2/+RQITTUPN2sW51nwVKKtZhHnmOBXMu5vRNAFjxOtAYvrH9NUYqVwsZS023kAHorKmLSpzEattDF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLIsHKu+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLIsHKu+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDD4C4CEC6;
	Wed, 11 Sep 2024 12:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726057465;
	bh=JIcm/bK+B+iIDJKC8qj0BdktGrx7MNafVncb3B0pjfQ=;
	h=Date:From:To:Cc:Subject:From;
	b=jLIsHKu+sj17uREhsiX5iQu8YDuYHzcBNY2bIZDkoLDVIbmqLgiKQEKMT09XzXnDv
	 oZfUx1AX3VZv1JO0dgoqsFp31dkvKl83fj/cDMRc1DRemUpNvL4Pv/dqZlV2JKAAF0
	 6UmSZR4apS+tE3LGMgouSpTGeewrqju2saYfEoT1dPilQ5JhzDLVEsxQhx52lR7F7R
	 qlkQNBvhHBUu0obq3YqBt0jg0hBNpF4qBH6OP9C3Li5Uv5oskYlt4LIioumG0JPYBx
	 b/LEFHJ6YP/bKQqjdjed69feusNt0MjMtCDYv24zkz+1j+Zu/AKJK3psh7N7XFoUho
	 2mn8Tm35wlY7A==
Date: Wed, 11 Sep 2024 09:24:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf build: Require at least clang 16.0.6 to build BPF
 skeletons
Message-ID: <ZuGL9ROeTV2uXoSp@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Howard reported problems using perf features that use BPF:

  perf $ clang -v
  Debian clang version 15.0.6
  Target: x86_64-pc-linux-gnu
  Thread model: posix
  InstalledDir: /bin
  Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
  Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
  Candidate multilib: .;@m64
  Selected multilib: .;@m64
  perf $ ./perf trace -e write --max-events=1
  libbpf: prog 'sys_enter_rename': BPF program load failed: Permission denied
  libbpf: prog 'sys_enter_rename': -- BEGIN PROG LOAD LOG --
  0: R1=ctx() R10=fp0

But it works with:

  perf $ clang -v
  Debian clang version 16.0.6 (15~deb12u1)
  Target: x86_64-pc-linux-gnu
  Thread model: posix
  InstalledDir: /bin
  Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
  Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
  Candidate multilib: .;@m64
  Selected multilib: .;@m64
  perf $ ./perf trace -e write --max-events=1
       0.000 ( 0.009 ms): gmain/1448 write(fd: 4, buf: \1\0\0\0\0\0\0\0, count: 8)                         = 8 (kworker/0:0-eve)
  perf $

So lets make that the required version, if you happen to have a slightly
older version where this work, please report so that we can adjust the
minimum required version.

Reported-by: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 37e3eee2986e580a..4c1f75e326e2c1d2 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -705,8 +705,8 @@ ifeq ($(BUILD_BPF_SKEL),1)
     BUILD_BPF_SKEL := 0
   else
     CLANG_VERSION := $(shell $(CLANG) --version | head -1 | sed 's/.*clang version \([[:digit:]]\+.[[:digit:]]\+.[[:digit:]]\+\).*/\1/g')
-    ifeq ($(call version-lt3,$(CLANG_VERSION),12.0.1),1)
-      $(warning Warning: Disabled BPF skeletons as reliable BTF generation needs at least $(CLANG) version 12.0.1)
+    ifeq ($(call version-lt3,$(CLANG_VERSION),16.0.6),1)
+      $(warning Warning: Disabled BPF skeletons as at least $(CLANG) version 16.0.6 is reported to be a working setup with the current of BPF based perf features)
       BUILD_BPF_SKEL := 0
     endif
   endif
-- 
2.46.0

