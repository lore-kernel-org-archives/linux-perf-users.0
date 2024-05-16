Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366B5143862;
	Thu, 16 May 2024 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865527; cv=none; b=iI0oQT4ucw19HB+h0VETRBAcJt0A48Gsr0HYCfOYdDRz7S94NZoHa4reECKt2zGDAIIBVcZo2z28fY0RyHlGIkUDr+zf1NOYNv4XAO23MjJ5uV8I9Ij+aixK+0pHf+9EOSzBpO0j2vpl8zDPu8YNyoDlDv/KTl2K1uaq1Mnj/sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865527; c=relaxed/simple;
	bh=IwDcXBrM7FxrzumjpWEBXxVI/Sjr7Q8mo1aSkT0G6Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P7NffrFNLaPphIILmjjOSq/aQpRQoU9svECn/59jNh1csX/RffDwtF1P/+sVR3bM9NaIkAocXZLDBT0ZWw2F/7kG3tB/GTrWO/UUHK1Z+gQIFv2J3njiqgBRf3qVNprM/F4KPo7tb9l+BgWHMaf4r1rBI6wnZhgItvRCe4RPAj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5ce2f0deffso105140366b.3;
        Thu, 16 May 2024 06:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715865523; x=1716470323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KdGWxoXF3gHnPOdYFh5gyCjeUx8D+oDKEyOSzHQOiAA=;
        b=HPodG0Dx5rerUOwXaeKOwUywuAVuf5sQnLIOEo1jMZpSgpVoD+xilhx3NQKwsTUYCK
         kwjgejwxjX8AF2QS9K2h++x1mstGPaQSR3KsHy7kbXOxKtwyfM9AmqT/L/hJPJ/5ux/o
         5qppnrbnXdUXLNZH6Nf0LrF/C48wIS57f8P3GvXSGav7tbH7H5Y01unZIjtUFqxsPh2+
         jb5z4Y1mBCN7Vp1WGjJCLi/swemP7JKNitQ/cVm1c7cvyJ84z1gE07Z3ZIALzBh+0ZDZ
         P6QXy29EgBpZq5Hv2YX7c8Q7PNioMUQd4BDAvWcJADXKjTclSWb+hzvhQKMu4gTS/NNZ
         MRog==
X-Forwarded-Encrypted: i=1; AJvYcCVkprhqgFWgktACURSFEFLgEo3y7PP6JbXsJ4kOWzwWQ6qZprW5Zw55+i2aDFKOLBUf61EQQIBQyT6J+ZT/E9HjVRlkWw8kVfSaft4NJ11YW1op2wMzrnJdr+nRwheni2l4aCudVu11mpWsQNk1sQ==
X-Gm-Message-State: AOJu0Yw1SrZ/0hRRok25b/FXe6q/tSN0pC6VDAC+GvwR9KZ/GqxyGlP6
	g6YRn2Uf7VK09QsXBWp2/XG3ToAd/4zEs30cCXRSlyTcRPrfcIEa
X-Google-Smtp-Source: AGHT+IE2d8F0VoqvvpDcSpf30NsfMeCjcYrMF4Tuu+HjVBfDa1U+6aaHYWXjrnML45ynkiykx7Dkrw==
X-Received: by 2002:a17:906:aa4d:b0:a59:c23d:85d8 with SMTP id a640c23a62f3a-a5a2d6653f4mr1274823266b.51.1715865523323;
        Thu, 16 May 2024 06:18:43 -0700 (PDT)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17870sm976435666b.216.2024.05.16.06.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 06:18:42 -0700 (PDT)
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
Subject: [PATCH v3] perf list: Fix the --no-desc option
Date: Thu, 16 May 2024 06:15:43 -0700
Message-ID: <20240516131544.2885917-1-leitao@debian.org>
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

v3:
	* Applied the same logic to default_print_metric() and
	  json_print_event() functions, as identified by Ian Rogers. 
v2:
        * Do not print desc if long_desc is being printed, as identified
          by Ian Rogers.

---
 tools/perf/builtin-list.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 02bf608d585e..8a0e123587f3 100644
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
@@ -395,17 +392,16 @@ static void json_print_event(void *ps, const char *pmu_name, const char *topic,
 				   deprecated ? "1" : "0");
 		need_sep = true;
 	}
-	if (desc) {
-		fix_escape_fprintf(fp, &buf, "%s\t\"BriefDescription\": \"%S\"",
-				   need_sep ? ",\n" : "",
-				   desc);
-		need_sep = true;
-	}
 	if (long_desc) {
 		fix_escape_fprintf(fp, &buf, "%s\t\"PublicDescription\": \"%S\"",
 				   need_sep ? ",\n" : "",
 				   long_desc);
 		need_sep = true;
+	} else if (desc) {
+		fix_escape_fprintf(fp, &buf, "%s\t\"BriefDescription\": \"%S\"",
+				   need_sep ? ",\n" : "",
+				   desc);
+		need_sep = true;
 	}
 	if (encoding_desc) {
 		fix_escape_fprintf(fp, &buf, "%s\t\"Encoding\": \"%S\"",
@@ -491,6 +487,7 @@ int cmd_list(int argc, const char **argv)
 	int i, ret = 0;
 	struct print_state default_ps = {
 		.fp = stdout,
+		.desc = true,
 	};
 	struct print_state json_ps = {
 		.fp = stdout,
@@ -563,7 +560,6 @@ int cmd_list(int argc, const char **argv)
 		};
 		ps = &json_ps;
 	} else {
-		default_ps.desc = !default_ps.long_desc;
 		default_ps.last_topic = strdup("");
 		assert(default_ps.last_topic);
 		default_ps.visited_metrics = strlist__new(NULL, NULL);
-- 
2.43.0

