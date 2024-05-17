Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B085787B;
	Fri, 17 May 2024 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955284; cv=none; b=c16VgV/Cy7iZG+O+9C2dGryarU5JaYEGR5EnSwDyslKuXjjm479+yQhAUG6gvZT1jeTMV1coWDtxqw8EMw3dQ9DSpFnqJTST9k95JboVJ2c+qCJomDStGnVz/TiduX/uDFXcY5dIenRVv1UJ0XSUa7KtRrlZW1B1rieOrc+u35k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955284; c=relaxed/simple;
	bh=t7TPOZcH88piEkHq3EwlPueXhbXs0lNxI+Jfxed7YiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BxjfTQ5hPaUc3IUgMeBP7uhcaRtB3t9GVFpTMxlleHLdVeEFnrg4KDrK2WhK90yPGEHpF28C8T5WYJlpndIiweiDnXfYMWFCkFWiuEIvS0boJSTgz38/q1SRyhWTs1wN4xKLln7DVONxLtpE/189yG3GPrNmc/IS2CNtEr9pujQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-574ea5184abso5459421a12.3;
        Fri, 17 May 2024 07:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715955281; x=1716560081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTiT+5csVtpVWTO/kiliCCsPmMNHf5p3YMe8QI/zwMI=;
        b=eT6tdj3fNWHFaG+yFzDCeNtbipEnLQLUpSj8k8IMhZjjrjGLCBIvfXKK2Mq1wSqlus
         Ut5egTU3QocNi9J2tUJu4OkBAoVM6om7d4TFg5Uk5a4//Lro5rpqfdcTC9VYzFVpkjDW
         svNB0BzhrRa6snABDb5f/6F7nwwjJ517RqXzqwXhVsSKb18YdLQDA69WVOYLut12OhGB
         B6FdtP9aqMXVjm6rjQ3kq2kOBTRV2MmymUrAgfWsDMiKYt8cOV8v7MUPsa1quPU7hx+v
         J6XlZli8lo1sYxgCBJ05MtPwyDT4zspPDOkUBJLJU8YhWPGglt1pbD9v1XjWxqgT8UaK
         Sh3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCg6a4nD/2cK6Ky3ya7hJE2oPQ7RUNSyssZGxbmUbIxGlJTm6k5h7+MuPj7W0RsQwJ6gRGOpcoop18/WQ9PLF68DrH3+BC62mlZxm8nhNjH75uG8ThmEpEUyRwez9Xw4HMCLb17LKdOtYN+3i2uQ==
X-Gm-Message-State: AOJu0YyUIgr4+tuRc2sYAFX18CoequeJrs2VYp3DT/vgiBhVbZY1FDzE
	tVXivlQ3tqqENF6Ew8UFWqZ3cqcQlfILj43tlkuS2lpJgzNyR7/8
X-Google-Smtp-Source: AGHT+IHJnqTwTompMNRqA/4ufYRk/mTDXpf6660tS8lercswA94/IdhNMOyogBfvkRHJgcQeQMnEaw==
X-Received: by 2002:a17:907:3595:b0:a5a:8bde:8300 with SMTP id a640c23a62f3a-a5a8bde992cmr702572966b.30.1715955281235;
        Fri, 17 May 2024 07:14:41 -0700 (PDT)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b18110sm1125842466b.225.2024.05.17.07.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 07:14:39 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: irogers@google.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: leit@meta.com,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH v4] perf list: Fix the --no-desc option
Date: Fri, 17 May 2024 07:14:26 -0700
Message-ID: <20240517141427.1905691-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the --no-desc option in perf list isn't functioning as
intended.

This issue arises from the overwriting of struct option->desc with the
opposite value of struct option->long_desc. Consequently, whatever
parse_options() returns at struct option->desc gets overridden later,
rendering the --desc or --no-desc arguments ineffective.

To resolve this, set ->desc as true by default and allow parse_options()
to adjust it accordingly. This adjustment will fix the --no-desc
option while preserving the functionality of the other parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changelog:

v4:
	* Revert the change in json_print_event() from v3.
v3:
       	* Applied the same logic to default_print_metric() and
          json_print_event() functions, as identified by Ian Rogers.
v2:
       	* Do not print desc if long_desc is being printed, as identified
          by Ian Rogers.
---
 tools/perf/builtin-list.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 02bf608d585e..24a136ea015e 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -149,7 +149,11 @@ static void default_print_event(void *ps, const char *pmu_name, const char *topi
 	} else
 		fputc('\n', fp);
 
-	if (desc && print_state->desc) {
+	if (long_desc && print_state->long_desc) {
+		fprintf(fp, "%*s", 8, "[");
+		wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
+		fprintf(fp, "]\n");
+	} else if (desc && print_state->desc) {
 		char *desc_with_unit = NULL;
 		int desc_len = -1;
 
@@ -165,12 +169,6 @@ static void default_print_event(void *ps, const char *pmu_name, const char *topi
 		fprintf(fp, "]\n");
 		free(desc_with_unit);
 	}
-	long_desc = long_desc ?: desc;
-	if (long_desc && print_state->long_desc) {
-		fprintf(fp, "%*s", 8, "[");
-		wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
-		fprintf(fp, "]\n");
-	}
 
 	if (print_state->detailed && encoding_desc) {
 		fprintf(fp, "%*s", 8, "");
@@ -243,15 +241,14 @@ static void default_print_metric(void *ps,
 	}
 	fprintf(fp, "  %s\n", name);
 
-	if (desc && print_state->desc) {
-		fprintf(fp, "%*s", 8, "[");
-		wordwrap(fp, desc, 8, pager_get_columns(), 0);
-		fprintf(fp, "]\n");
-	}
 	if (long_desc && print_state->long_desc) {
 		fprintf(fp, "%*s", 8, "[");
 		wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
 		fprintf(fp, "]\n");
+	} else if (desc && print_state->desc) {
+		fprintf(fp, "%*s", 8, "[");
+		wordwrap(fp, desc, 8, pager_get_columns(), 0);
+		fprintf(fp, "]\n");
 	}
 	if (expr && print_state->detailed) {
 		fprintf(fp, "%*s", 8, "[");
@@ -491,6 +488,7 @@ int cmd_list(int argc, const char **argv)
 	int i, ret = 0;
 	struct print_state default_ps = {
 		.fp = stdout,
+		.desc = true,
 	};
 	struct print_state json_ps = {
 		.fp = stdout,
@@ -563,7 +561,6 @@ int cmd_list(int argc, const char **argv)
 		};
 		ps = &json_ps;
 	} else {
-		default_ps.desc = !default_ps.long_desc;
 		default_ps.last_topic = strdup("");
 		assert(default_ps.last_topic);
 		default_ps.visited_metrics = strlist__new(NULL, NULL);
-- 
2.43.0

