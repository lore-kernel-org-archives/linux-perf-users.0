Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2DE3C5823
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 23:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713512; cv=none; b=RLRSEEWGcbJKS7PpqaqAd6FXr81gPxEK4nhk0ZavIaBV5/AKC8WbgCPXNqBqHXGKMacQPIHFLqEJW7xH99rGzhef1gCxVn+YllfBmm+1bM7nK3YaM8n0Tc3VDgTW6+KUfm+5qkskCdklSOl/vexlr2GPXV63mNUK/xE1RewTmkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713512; c=relaxed/simple;
	bh=bWChlgQf4f4BwTHMXNaa/t8wf4NpMTe6O5JeS3KVbnE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GonkS3Jhjakxs200zam11G9tYRCWjR1CBJBI0wKG4fpKzSTR67n55jsdi1Vo33OCLcJNZlZ9IoyTUH8f2zLF/IwME6wFFXr4V/tLQH34Rvp9HrgL3yDdbg2RN3xIvsp9qlo9Cm73dFF/6V81p6iDAi1PPGBUlzq5uuGLeFNtIlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hMICLA9+; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hMICLA9+"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso7435924eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778713510; x=1779318310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOM186MA413sPqwCdIz6BnRQNidG3sxEQ8H7HX8kFvE=;
        b=hMICLA9+gLwaqGz0bZSPePUeLEfNVB4h5+OksDpQyF2J9IKCG342sI2fU+EF6wCmHs
         IKLHpseqnfQ9d6bvUYy5KDMlFUrklB94u1Cl0n8spDmBdQK6kXsQs8EQ33MKfkWkT/vI
         tKcK86dbIx6TUsu4g39ytQZ4uMvvYrkglDuGDCDEm7kalKRTJxyzwdUCHlaY7/vW4UeN
         keKj1idNqfQWeErotMXzKunXEbG6ky/7KjQC3YnM9qZys8qwfKFIYuWzSPZTmb/6tdNG
         bcLYVPc2BKwbuHvzgl/Va/8jec947RXDgsUEDgWvhW5BLzOxtfO0uzEwcuyQneQKZsly
         2D4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778713510; x=1779318310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOM186MA413sPqwCdIz6BnRQNidG3sxEQ8H7HX8kFvE=;
        b=WSIUa3aLMiEYYBae8fd4fNCrohK0T0Hb91HTEiRB2i53ZewFLCzZIr2og2G/+XOiws
         zmrm89jfy4cIkCWTUOMiO5+IZXZVKomhvLnoGEU4itbfqIpuh7UqRfTRkXGpxy7lUNED
         zNL611/S3QnkJXbJyNqAnP/49RWXKqGBOW0zjri2n9jwPj3noZhvV2hh8v5r2kqaYOvp
         XbfkWUL0J2TkKF5RDKxVaRjpgTdMjcn7Sdi5utISkQaitCDjLVTe7L/9arxABc+oCMLA
         Uw8Pu1f87wFbSTrBVE3Q4+dd+V9tp3sp330k1Wtu8bekkd1QWQHleE66/kZVnuUr/TG5
         fZiA==
X-Forwarded-Encrypted: i=1; AFNElJ8P2b88qSAp4FXxEEbM557WApPC6RPW1hB70HPSDoxCkfZ5+9maoaaWj6jznIcfaHvzDhGVN85/lGYZqDkz4m69@vger.kernel.org
X-Gm-Message-State: AOJu0YyXXEAgOzAEyv4PXoXYlrnoQ6hmG5GKzAIH2Bw//BJXJjMtVBRC
	xRFWTA5mzHkzl/lTbN9LfBPqo/JE5kFUnAHdm2BhaIyoPoVu95Yq2T+0rvFGbflxBE5tFqNAC8v
	jiUhxjpVWng==
X-Received: from dycai19.prod.google.com ([2002:a05:7300:fb13:b0:2da:55db:5766])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:7c0c:b0:2c5:60d0:702e
 with SMTP id 5a478bee46e88-3011996d245mr3079149eec.18.1778713509976; Wed, 13
 May 2026 16:05:09 -0700 (PDT)
Date: Wed, 13 May 2026 16:04:39 -0700
In-Reply-To: <20260513230450.529380-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513230450.529380-4-irogers@google.com>
Subject: [PATCH v1 03/14] perf test: Drain pipe after child finishes to avoid
 losing output
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

When running tests in parallel, the parent process reads output from
the child's pipe. However, it might exit the loop as soon as the
child is detected as finished, potentially missing data that arrived
in the pipe just after the last poll or before the loop terminated.

Address this by draining the pipe after the main loop in finish_test.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 06507066213b..e88a5f72faed 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -482,6 +482,16 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 		if (err_done)
 			err_done = check_if_command_finished(&child_test->process);
 	}
+	/* Drain any remaining data from the pipe. */
+	if (err > 0) {
+		char buf[512];
+		ssize_t len;
+
+		while ((len = read(err, buf, sizeof(buf) - 1)) > 0) {
+			buf[len] = '\0';
+			strbuf_addstr(&err_output, buf);
+		}
+	}
 	if (perf_use_color_default && last_running != -1) {
 		/* Erase "Running (.. active)" line printed before poll/sleep. */
 		fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
-- 
2.54.0.563.g4f69b47b94-goog

