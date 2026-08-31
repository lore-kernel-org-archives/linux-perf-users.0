Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DE933987E;
	Mon, 31 Aug 2026 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181916; cv=none; b=LdDC+AMD8K6/WI83iG1kgMZBGzflWWUWI4FZo9vCaB6F7olRvaTHoHyZvn+Ikm055sy3S+JNokjvJZqHpTqa1jFpfkOf0iRurqsQGe6ce6e56O40q/qeUG6u4/EVDl6fnrueFeng19MoeePOWiztasVu9fRE0z8cYgU3OPtp6ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181916; c=relaxed/simple;
	bh=f+dIgZvTJAI+DW2DcuXBuQJqX95T1WBuYORqoWZy2HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkjHR+UHURX0phxv2lzfEaxVGbkvjye95834xNbq0BMTwRQuXOs1FlvZA4ZlBBg54s4lU5QxGx8DEvah6OSnnLN7p4VYwlau28p/j7jj2EWv8ftwluHTTD783tn/x4BEdLOoCIKIfS4oLgTbuuICUy9ANuDVexcdoRN2XUvCz4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xe//guqN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xe//guqN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2761F00A3D;
	Mon, 31 Aug 2026 13:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788181915;
	bh=aCPqOgghbr9UQeN7pOVRlMO6+bGSdt8wqV7LX59H+ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xe//guqN6YzhifgQpSlPSVnXvI4Ra9dSgzioZKJiIJe4TMRTDjgAAoP7oXeqDsysK
	 6h3rPUTtVfHg60wE6olvtGK5r0gG01RIKntypj2bI1eLO34FD3VM+Q0cwOdzt/ZYSh
	 5j5ZHwz9CcFUwqg2RxEwIhYx7Ye4Aq1WSLc6SotYd2jZJSnS9Q2hGfo+t2VoDAnsAp
	 s+vmlAdKfL36IwTYXH9dYmJVzU9la5a3aZWbI2MlXPE4zjeCvWd0nugVqWAwNILbP/
	 2cL/uJVwe+jo/4z3Mnde5mhW5Gh9wWTYmjQLNSXpK3/msECfboz1bP8ovteOhKdSFc
	 n6G8yXP1Sv3Pw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 07/12] perf jitdump: Fix funlockfile on unlocked stream in jit_open() error path
Date: Mon, 31 Aug 2026 10:11:03 -0300
Message-ID: <20260831131110.4681-8-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831131110.4681-1-acme@kernel.org>
References: <20260831131110.4681-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

If the malloc() for the initial read buffer fails, jit_open() jumps to
the error label which calls funlockfile(jd->in).  However, flockfile()
is called later in the function, so at this point the stream was never
locked.  Calling funlockfile() on an unlocked stream is undefined
behavior per POSIX.

Split the error path into two labels: 'error' (after flockfile) calls
funlockfile before cleanup, 'error_noflock' (before flockfile) skips
the unlock.

Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 45f0e21b0e780cb6..ae63366b86c6d765 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -157,7 +157,7 @@ jit_open(struct jit_buf_desc *jd, const char *name)
 
 	buf = malloc(bsz);
 	if (!buf)
-		goto error;
+		goto error_noflock;
 
 	/*
 	 * protect from writer modifying the file while we are reading it
@@ -246,8 +246,9 @@ jit_open(struct jit_buf_desc *jd, const char *name)
 
 	return 0;
 error:
-	free(buf);
 	funlockfile(jd->in);
+error_noflock:
+	free(buf);
 	fclose(jd->in);
 	return retval;
 }
-- 
2.55.0

