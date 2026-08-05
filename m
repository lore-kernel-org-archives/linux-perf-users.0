Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288693F23A1;
	Wed,  5 Aug 2026 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965267; cv=none; b=hwZHHTdLP1tvmqqAT9giMzUyJ1yoMbrLK+siT8UhZy5LcVHEOU1ds8QjeWdhIAb/p1xGG/Tk5880IkVlEgDp+CUv+GB140LQ0xwulda2ohkYSi/YldXcPfVlbPFeWry+9BnQGn8rIuXqebzNt9dSOkPqLpaUxGk6BzfmfsjGPVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965267; c=relaxed/simple;
	bh=UEl4qGtMSIBxM2UhI/bQTBVn3hKSG5u+HYU4iIIhBK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQDLC6ii8WSqmZMRVrACVAxpDu8daSP3qGu8kThCMQHhceegUwbl6suPkSmmvqUQdhiLwAeUCC2rkzhdpiIz2d9bw4C9soDQotYCOOVyGRfLaihiiihLLgm/R6gcQTuZX/TakGwyS55DK4ZaX64OVWi70mjXHEdxIAukljkRZOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8766jPT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8766jPT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5405A1F000E9;
	Wed,  5 Aug 2026 21:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785965265;
	bh=vDRzKDjCW+8/V3sFcXtcw+mJHpo2LSPYRAWxzT3h8ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f8766jPTTLnDA8S6UwXMIon+n68BmwYiqZc9GQX4OFqerk8r5on0chCBDtDAkXQOy
	 uFfN5nxkVKGZvb405Nw61YVPWPqXbZOEjUn/So6IypwOTmxiH6XsYM4z5smwlLe2g4
	 Wm5XiAVp+XSVkkwcns+MdszeGWiUa3BoiYUkiiBHPjdQbxEARvCmWj7wjmkc6jNrB+
	 4276v+zB6q/LcfF67keHuFGEQH+jXQ9GAhYwDvDW7blHwqBpCSQ3wR17fQg0D/OvT4
	 B6EN2za9VxZ0tFWwMKpS3KRjuvxSoaMeg0UAq8aFq/3m6kWJLPPR+vwD/YaPxbi9dd
	 R1wWOA8KKMvog==
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
Subject: [PATCH 06/12] perf jitdump: Fix funlockfile on unlocked stream in jit_open() error path
Date: Wed,  5 Aug 2026 18:26:56 -0300
Message-ID: <20260805212704.267779-7-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805212704.267779-1-acme@kernel.org>
References: <20260805212704.267779-1-acme@kernel.org>
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
index d7e3dcfc63b78edb..e865a43f6ea8f884 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -155,7 +155,7 @@ jit_open(struct jit_buf_desc *jd, const char *name)
 
 	buf = malloc(bsz);
 	if (!buf)
-		goto error;
+		goto error_noflock;
 
 	/*
 	 * protect from writer modifying the file while we are reading it
@@ -244,8 +244,9 @@ jit_open(struct jit_buf_desc *jd, const char *name)
 
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

