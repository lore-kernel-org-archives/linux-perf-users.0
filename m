Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6221F26738D;
	Thu,  6 Aug 2026 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019811; cv=none; b=ZKMBLRXXldcnvlO8m9hhw7lA2wip1z/6KTbwexaGjpumvDPjbUGjjgdwEpZaDaWUGgiFQ8rCatTn8AbXgcKuTMSzxCyOJynFNOe8CXZssC7yE5xm1zrCTRIUlLRdyaIZuOvWQOAhucwiGBFVJh8bvWzLrHGoU9GTWDIMICGmkt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019811; c=relaxed/simple;
	bh=Y7qE4d/zcx6zywiShfuPhfsAQaXh59POJvtoif4LMe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKAuHJy8e/02uFeqHIn7cENbIqFaFtGvf8Lm8BNnBXiGtI0O6r/34o1iOyRB4MYlRHXNjSQ9ksDySRNyBf87LVPNoHfjkHmKAEOLVkqjm36x/MwBnP/H50B+iATu7TzSqbic2hLckJLw9F2aIqkXU7c1IT5A167tK45xqpbcSow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3woAotn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3woAotn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2E51F00A3A;
	Thu,  6 Aug 2026 12:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786019810;
	bh=kKy50RliKU/qsCAJenQgHACMcOw9d+wUOZ+IfaGHPKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c3woAotnVfIvEHARjxGIgG1TxHGoItVYJ2vJJ4pG848kBWAZAIZtrsbYcxF17+1HF
	 n//Nn4MCml5at4W67hOPjUdG2xZDJKtBMnbGgYDdfQZshg5kXW4+8Z3OPEbzdzh+yo
	 G/VZEA+iiK2mEJGveolnFW4MH0dkNSalx+zsR4PBxUa4TILnZevW8lo2EtNyB1iqCT
	 lO/bUOOzN4QKVMpa7LYEF2voAzeVRMRFYghYr/s4EXRelCyZqPDTmCnekebbY8wOj6
	 G2D5kuj6mBVftQ4XRgZE4Bzk52G1Xrpqeruv5qzNQmEeyIr5uTsGgckUZRtF0wyCjq
	 jq5UpmFdIaQ/A==
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
Date: Thu,  6 Aug 2026 09:35:58 -0300
Message-ID: <20260806123604.271277-8-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806123604.271277-1-acme@kernel.org>
References: <20260806123604.271277-1-acme@kernel.org>
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
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Ian Rogers <irogers@google.com>
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

