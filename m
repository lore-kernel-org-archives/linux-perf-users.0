Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B09A2236E0;
	Fri, 26 Dec 2025 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766776178; cv=none; b=Zah4GsG6bn7C8fiHY/Il+4jT/sIKmNzKlWexmJ1Wzg/ag2M9X/hpwAjdfbYaUOm+cTI7r3HYCXryT66TizfG3kyII/AWEx7T1G7IyVYD5mv3Hreb1wl/Qc0yfwBjURwdyFJaHNDSbCgK4U4FaQ0MtxD05eN3YfIIlxYk+WTEnaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766776178; c=relaxed/simple;
	bh=8Z12f+nl7Uk9tytWl9zpCVLu0gopO24gvKuSuuwaiz0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=msuK3cSPqJpFINXLrttoDhfWd8meRrNtpzJ+1ITVMtWXA0k8S+V045FHPwa11EILCW2Zdrzu4hXc+fz6GQ8Nn21ZNhxY30j29a0n3SetMCTtNaUqWqLmZnJG1pp3RylDrQFxy5pIh8z775XsYuuWYRxU0KfM2+W+KUJ10Bmwdjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+ayIlBh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+ayIlBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6794AC4CEF7;
	Fri, 26 Dec 2025 19:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766776178;
	bh=8Z12f+nl7Uk9tytWl9zpCVLu0gopO24gvKuSuuwaiz0=;
	h=Date:From:To:Cc:Subject:From;
	b=U+ayIlBh0jt/Lfn85V1i5pOM4LHMJv4c/dfsaOTD5mkoMMeahAq+LPc7yzFkFfLCx
	 Ql8MYWqI4z4opdRyu1FqIitXcWMMNrnqioHk/PBk8oRVxekI9U7e4DmY6zMcz7Mt8C
	 NCCJWN8cmHC0bmowwiwklslWEHcfDD70WLw0nH8V8qrXJB3BPLJFFAQGrIHskkuQhj
	 rZV5XT8NpGBbLY9cR3mrYA0KMjv693ar9NsHY7WHBGpIKNdrRxKwcDnBAFYt40XY7z
	 eCkjN/jn9EkY79MfsNQYNG8mD14550tmqc5B67jOmTLEzWp4jdN/qgy2bvQA4RMsEr
	 0VE7IvejA7vBw==
Date: Fri, 26 Dec 2025 16:09:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 v6.19-rc] tools build: Fix the common set of features
 test wrt libopenssl
Message-ID: <aU7dbmP5_opzLPb6@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The recent introduction of the libopenssl feature test forgot to add the
-lssl to the test-all.o target, which made it always fail, fix it.

Noticed by looking at this file after building:

  $ cat /tmp/build/perf-tools/feature/test-all.make.output
  /usr/bin/ld: /tmp/ccBhO8WH.ltrans0.ltrans.o: in function `main':
  /home/acme/git/perf-tools/tools/build/feature/test-libopenssl.c:6:(.text.startup+0x2ed): undefined reference to `OPENSSL_init_ssl'
  collect2: error: ld returned 1 exit status
  $

It was added only to the individual ssl test, that works:

  $ cat /tmp/build/perf-tools/feature/test-libopenssl.make.output
  $ ldd /tmp/build/perf-tools/feature/test-libopenssl.bin | grep ssl
	libssl.so.3 => /usr/lib64/libssl.so.3 (0x00007fb81eda8000)
  $

Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 7678523109d1d9ee ("tools/build: Add a feature test for libopenssl")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index c699d4f4c6d935d0..0d5a15654b17b20a 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -107,7 +107,7 @@ all: $(FILES)
 __BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
   BUILD = $(__BUILD) > $(@:.bin=.make.output) 2>&1
   BUILD_BFD = $(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
-  BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -ldl -lz -llzma -lzstd
+  BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -ldl -lz -llzma -lzstd -lssl
 
 __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
   BUILDXX = $(__BUILDXX) > $(@:.bin=.make.output) 2>&1
-- 
2.52.0

