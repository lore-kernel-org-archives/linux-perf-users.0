Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF661C69E;
	Mon, 13 May 2024 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715635235; cv=none; b=EhPHx3Cn9CCtYb5kCMzTvHXt3wS9HZvQbUvIqFt92up5YcvHsoLjldMheC8TG0qx2OcLiBv/0q/pV7KcwnKp4w/zBHwSgNjkOHhfKCofLCTYXEDR3mynUcwgiR2XWExYcZaSkmeJ9lw5Yylma5Wgz9qCeDE8SzmUogLjV2wrlWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715635235; c=relaxed/simple;
	bh=ucWjXhSyGbfuZr1q/BsMWuF8rahJgRIU2N9PLbeWXgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H7J/Y4nn1ZIjf8wGu1RchyrM0GrTynySH9MXl3DeYJ7CerHNoGtuzUKlJcDmKz5k6bYXqjHAfEAcGJh9mZuIAT++nAv5WJ2befa2oNdRXWjI8umEE7tUEv5P9uFGsG48cFBsnQGO/2EZf+AYKHMVI39lEpbrBLkFYANu2NysG8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f4551f2725so4255428b3a.1;
        Mon, 13 May 2024 14:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715635233; x=1716240033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9Y3Elyav6skmCVK+ppxn+2ksjfTwPWHHlUZiLbOxUw=;
        b=s+mm8R2E9/Pj66kumm3iEkGwJPgOEYxLyAOOeqMCr9zdVlPNsWxy3SqlXLvuL9ezC3
         JimRF0+n76zULZDA2KrFiJ0oV/UryLcuIhetbpjbxEfbc9rXSvvVS7/9NylNaTiuVY6h
         N/YHJyvacylBGlg+WODprod1HKlySg7Nxsl4nnClCxZeVoY3BtdTTxZ0f1y4V3zCjag1
         +MaqpSW4toC69sRKz2whKV/2qZL5RDnBEuW8qSrsb5ZEXRIW3z0wZoQcBHExUDOXDUky
         TtDOKMsDHy8LByaUB5um/l+EUA6MYhIgN6TjFc7d5+TT0VutZghmPtdAjWdrsyx6JgsL
         7hyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXjoasLmr+xRAP/c0JJboqLmvw95ryDLJX2qNRMMTMUjHOAL8q1ccGgMgzJQwdZ+9quiyNbVv4Aubox2i3sG4BY9jGSHN52Z115pUt7xL5pqK9nXJOlEhj5lReGNCgmd8hk+jjLPMEqawCgunyfg==
X-Gm-Message-State: AOJu0Yxokf3wAb6oNhgBUDYMYKhOGWw87wMRNeS5bONkZGJbvrZ6qRIY
	UG4s74qywZDTvsjuyGIqlKq7jnfk0ZgFT2U7MLCWi1ACy4Dc5vzB
X-Google-Smtp-Source: AGHT+IFAfpEU3C7pTpwAnDdzX1CZYzOEyoJJ6zCRbHo4XrKJobunwkyCHg28z71Dz0Qr+PvSYhz8jw==
X-Received: by 2002:a05:6a20:c707:b0:1af:ff1d:f3f6 with SMTP id adf61e73a8af0-1afff1df4admr2578187637.48.1715635233487;
        Mon, 13 May 2024 14:20:33 -0700 (PDT)
Received: from localhost ([50.204.89.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a632608sm7169931a12.5.2024.05.13.14.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 14:20:33 -0700 (PDT)
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
Subject: [PATCH v2] perf list: Fix the --no-desc option
Date: Mon, 13 May 2024 22:20:05 +0100
Message-ID: <20240513212007.62904-1-leitao@debian.org>
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

v2:
	* Do not print desc if long_desc is being printed, as identified
	  by Ian Rogers.
---
 tools/perf/builtin-list.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index e27a1b1288c2..16186acdd301 100644
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
@@ -484,6 +482,7 @@ int cmd_list(int argc, const char **argv)
 	int i, ret = 0;
 	struct print_state default_ps = {
 		.fp = stdout,
+		.desc = true,
 	};
 	struct print_state json_ps = {
 		.fp = stdout,
@@ -556,7 +555,6 @@ int cmd_list(int argc, const char **argv)
 		};
 		ps = &json_ps;
 	} else {
-		default_ps.desc = !default_ps.long_desc;
 		default_ps.last_topic = strdup("");
 		assert(default_ps.last_topic);
 		default_ps.visited_metrics = strlist__new(NULL, NULL);
-- 
2.43.0

