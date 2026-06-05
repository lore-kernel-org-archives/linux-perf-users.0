Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B37421F0D;
	Fri,  5 Jun 2026 06:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642182; cv=none; b=Fz5VlBcph1XCEl1XXCgzzq/zqBjc7JcziUZUx9CTeG5zL+hoItYqmyyneaZoWE0mlXFVR59YFFRDjvULVGg1zQcjQUt2HPlCHrZq0+dI4cGJRqfy5nyc+db+bLISWdC0R6Izanp2iyuazzwiY99VOMnvBKNJZD/xRtDPvHamf2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642182; c=relaxed/simple;
	bh=JbOjN+5s8vqL6zy3PUgHQ5CBh//ucUve2OmTRELYBII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GqMX4RebcuDz4ePe6gtypggqGyfXfH3tC1Mf5vV05+RS4Gk8ALehcBbdwPRLcUK7DpcYupJlurcG7ewu+m8M9my8f3QomrgcWD9uz9EEcCb1AUsKpvPpTGOkmMzApmMJKzB7D9CyVhE8ezCwEkriwUQSUsDcJptuo90+LCrqywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzwvIEth; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzwvIEth"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89ACB1F00893;
	Fri,  5 Jun 2026 06:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780642178;
	bh=HB4QLHHnX0cD6nJm4H5FiXccxNqI9MICIMNcBtOoZQE=;
	h=From:To:Cc:Subject:Date;
	b=JzwvIEth00voi1zPhwgmXzn6GKyxyVOYtYQm+YbmU4j1yLkxX4KT6/CcuPdSPPQwq
	 u7iDXeaSxTUab1Rn9coK8iVLFUjlPfFPZtuSVg6LMl+mg6OXKajnwaHu2DeGX3sz+6
	 smbdW19D9q+Lta6HX7te+PX4eSreXxgQeYxvnsaP0V++2HEzGupmaEuVF8rE4eZZVa
	 d+9rdNC8mt+bTXQnXaNSyjcP/ZznJHBTl0zBN885PanG7HpHBOTV5JyJAxR4/JpsL3
	 Lhu7mAmEP0jgHVU1lt0Y+67AP9vCcOFzpx7UBXPn9i83sv5q4mxU5/8w6JogttX0/j
	 DyAvEeZ78b6nw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf jitdump: Fix a build error with ASAN
Date: Thu,  4 Jun 2026 23:49:32 -0700
Message-ID: <20260605064932.34316-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I found this error when I pass EXTRA_CFLAGS=-fsanitize=address on Fedora
44 with GCC 16.  Fix it by copying one less byte.

    CC      util/jitdump.o
  util/jitdump.c: In function ‘jit_process’:
  util/jitdump.c:237:9: error: ‘__builtin_strncpy’ specified bound 4096 equals destination size
                               [-Werror=stringop-truncation]
    237 |         strncpy(jd->dir, name, PATH_MAX);
        |         ^
  cc1: all warnings being treated as errors
  make[4]: *** [tools/build/Makefile.build:95: util/jitdump.o] Error 1
  make[4]: *** Waiting for unfinished jobs....
  make[3]: *** [tools/build/Makefile.build:158: util] Error 2
  make[2]: *** [Makefile.perf:578: perf-util-in.o] Error 2
  make[1]: *** [Makefile.perf:288: sub-make] Error 2
  make: *** [Makefile:76: all] Error 2

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/jitdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 18fd84a82153c2ab..83005b30b9bf3fd7 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -234,7 +234,7 @@ jit_open(struct jit_buf_desc *jd, const char *name)
 	/*
 	 * keep dirname for generating files and mmap records
 	 */
-	strncpy(jd->dir, name, PATH_MAX);
+	strncpy(jd->dir, name, PATH_MAX - 1);
 	jd->dir[PATH_MAX - 1] = '\0';
 	dirname(jd->dir);
 	free(buf);
-- 
2.54.0

