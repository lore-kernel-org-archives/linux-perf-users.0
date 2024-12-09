Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C547F14A60F
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Dec 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764367; cv=none; b=V0qvrcMUta186Nni8r7lK7O6iy0zQsepAY82rstHedCJYqSYBDuiTsJmod0NoIKQhCdOduKdEntaaTkqvSy99V2sOQQ11qJgFON0LhnRypXHtN3UNW9iLQ/w3sAWSaK+s7KbkflLKs/c2VTckyed8x/t6helvjU1pWL8Xl1guQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764367; c=relaxed/simple;
	bh=u1pZFNB4IkXAp3g1I5XpeCyNXZT64f/PRCeyjr73mNI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z0qtpyULbWMocKNAi1A3dGQWWWlXE4a6gEgTus0sYNhuXo4/mCmGqS3nS03rM4B81D1P/B1bM2Mos0JoTCkXgfG3wObJViaIhe1Pfauec0q1qDA5NlAfNhO8Az1uqXFVSQaLGWRWEojSScSuVZybLY+fq8kIlJfYUIppClqk7Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aCr4t+Aa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCr4t+Aa"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434fac2996fso10027065e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Dec 2024 09:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733764364; x=1734369164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=99R/pS+JOAF2fBIm3Oge6FcYNKCOWKCH/F0YLLRaqtY=;
        b=aCr4t+Aa81gz4opEH8+D79V4EACBWlFTBLxEPiMCDI15AyPVQGKWA6YEm14yZrUYhz
         eRMep7z3KhSuIFl3uwQnByYw5nGHJ4GJCB/DRtqw3fbmiY+JMevAhQRKJRc0pJIKNOnQ
         lMUrlYRuHWHejL8iFQkhk/Kr/vNkvKX7fGF5zz78Dy6qSutWOzMOKuH3CmC91ca45XDs
         bn/skrDh46J7E99mBV/NNOv6Wsaqg0uskrtBoQUEgvQPjKfE6udagP0d/aQxX9HYaKji
         ElqlDk15/Hb7fzQyQrdtZCVCJbh1tDelq5BO4x99jse3XilpFJtgJd4t0ztQ6E20gE4w
         uiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733764364; x=1734369164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99R/pS+JOAF2fBIm3Oge6FcYNKCOWKCH/F0YLLRaqtY=;
        b=h8NFWWDXLZMYaBrcC4pru1AhBwdxNuGLqyYaUXMkXH7/MoKt7FkgPGZSJCbjjtl6lc
         vB9/A2WWp/uwpW0QoYFtwJ//L6dndNtQFoRb61M3fTGdglIdU9YimPvfIcmuSE3xKPvl
         O1xCyrU32laPvyEsApptm+as7Y+GsAxqnXhDHq95ZubBtg3e4YyWpQfIdDBN3j103AZr
         shX6w0RE7zttp2hvmhRXn7GHvPZbRF9oTTk9FkBGWrTSIGDm2qWghHNxzkAk/0V2WhGu
         FASUxXH8lSQPPltMRaTCJRZJMJpgQ140LU7L298WKUGj0eAtG3hPhsVfFlo1/UGY0HwE
         keCg==
X-Gm-Message-State: AOJu0YzWaOdS7k6jLOqwXnXi9J9ape+XYtOu19DaoLbQc70ZyrMpECqt
	HPFjhDIbq6cZqgzvi+BHr8eryOjL0vt07zXxOHcigHg1eKQxbslk9iTZ/Wt9uCarw5YRaX7cPZR
	8
X-Gm-Gg: ASbGncuQWEyimfbeLLoLncm2lk/F9iZLaQvsbtAmEVofRuxNXlsp6mdgC/e+jrHBteS
	7Z5Simr7g0fTGb4CocstZu/sKmbB0fhJFGgS0W43G0umn3i2qpEqXtwhkNyKsWRY9xvglXOLKbo
	jS1nnKx5wb5dhjV34kYZXIIIDJKxshCoWgveLRUFjip7xpBb3sJQsLvSqTaazWwGMhWFx6RARXm
	LdUFqJiCinYwbKIhZjRvoX6P04gRS+ZmGikq4v1xGfz5dmHsXY=
X-Google-Smtp-Source: AGHT+IFkm7jj1FED7ocAfVBJOa37YQ3hoNzBuxeY7ZjjgdEVyxL+f/RC6F5mPiRea/S8HR4ulr5jcg==
X-Received: by 2002:a05:6000:184d:b0:385:f89a:402e with SMTP id ffacd0b85a97d-3862b34e4cdmr8876460f8f.14.1733764364117;
        Mon, 09 Dec 2024 09:12:44 -0800 (PST)
Received: from pop-os.. ([209.198.129.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862d7158c4sm10530816f8f.54.2024.12.09.09.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 09:12:43 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	namhyung@kernel.org,
	acme@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Leo Yan <leo.yan@arm.com>,
	Dima Kogan <dima@secretsauce.net>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf probe: Fix uninitialized variable
Date: Mon,  9 Dec 2024 17:12:21 +0000
Message-Id: <20241209171222.1422577-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the linked fixes: commit, err is returned uninitialized due to the
removal of "return 0". Initialize err to fix it, and rename err to out
to avoid confusion because buf is still supposed to be freed in non
error cases.

This fixes the following intermittent test failure on release builds:

 $ perf test "testsuite_probe"
 ...
 -- [ FAIL ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -V bar (output regexp parsing)
 Regexp not found: \"Error: switch .+ cannot be used with switch .+\"
 ...

Fixes: 080e47b2a237 ("perf probe: Introduce quotation marks support")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/probe-event.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 6d51a4c98ad7..35af6570cf9b 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1370,7 +1370,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 {
 	char *buf = strdup(arg);
 	char *p;
-	int err;
+	int err = 0;
 
 	if (!buf)
 		return -ENOMEM;
@@ -1383,20 +1383,20 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 		if (p == buf) {
 			semantic_error("No file/function name in '%s'.\n", p);
 			err = -EINVAL;
-			goto err;
+			goto out;
 		}
 		*(p++) = '\0';
 
 		err = parse_line_num(&p, &lr->start, "start line");
 		if (err)
-			goto err;
+			goto out;
 
 		if (*p == '+' || *p == '-') {
 			const char c = *(p++);
 
 			err = parse_line_num(&p, &lr->end, "end line");
 			if (err)
-				goto err;
+				goto out;
 
 			if (c == '+') {
 				lr->end += lr->start;
@@ -1416,11 +1416,11 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 		if (lr->start > lr->end) {
 			semantic_error("Start line must be smaller"
 				       " than end line.\n");
-			goto err;
+			goto out;
 		}
 		if (*p != '\0') {
 			semantic_error("Tailing with invalid str '%s'.\n", p);
-			goto err;
+			goto out;
 		}
 	}
 
@@ -1431,7 +1431,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 			lr->file = strdup_esq(p);
 			if (lr->file == NULL) {
 				err = -ENOMEM;
-				goto err;
+				goto out;
 			}
 		}
 		if (*buf != '\0')
@@ -1439,7 +1439,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 		if (!lr->function && !lr->file) {
 			semantic_error("Only '@*' is not allowed.\n");
 			err = -EINVAL;
-			goto err;
+			goto out;
 		}
 	} else if (strpbrk_esq(buf, "/."))
 		lr->file = strdup_esq(buf);
@@ -1448,10 +1448,10 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 	else {	/* Invalid name */
 		semantic_error("'%s' is not a valid function name.\n", buf);
 		err = -EINVAL;
-		goto err;
+		goto out;
 	}
 
-err:
+out:
 	free(buf);
 	return err;
 }
-- 
2.34.1

