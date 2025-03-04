Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6462046B6
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Mar 2025 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096220; cv=none; b=Z8LrN6XhiR37tHYkwC2sHPYfejgKFbMhPt5sxCVF02cOw2ht4mMEfODxsapiXwmAuiF+5MGQ3D90mGWwZYIfV+6R16tbNndLBfQefqcAS6h0m1EQLjPut46yVx3nPuKLWBGdzGgas86nJCf8y+z9fAYC4XUqr8sidOU+x6zTaTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096220; c=relaxed/simple;
	bh=ssO3CwRUgUXsweDnMWczi+OJMu2AOFJlyUIqu9OXdXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KrsECc2Fn76H8xAcVioUkrka7fviedYfxfKNyGl+pqkVWRLNGrvnaru4rN3+6/RDHU8NAtPN9X+b10CZ3rCZ0kiYX75Jorapm40l6dTMOpx000/iYR++32gYZOPltg0LDj9mQdQCRjpV3KjaOhoik1Dhx++OGVsWBdnFjmAnRME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cjW5e4K4; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjW5e4K4"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390f69e71c8so2387162f8f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Mar 2025 05:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741096217; x=1741701017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrYsuIKVD+UTjXvBv+IWgOdWlxYNByPEbenQuMjAbWM=;
        b=cjW5e4K4qHWbxahFdrg805LT9v8V+jiap37SYD95fThhKysS7exu922aN4N3bXOvCC
         NfJAfzR9aAJcmzKu1nazg731HbdknNfQeWjpzcqwEnHqbN6b7jxgukqJQicmd5LKwZmY
         sDP0pmQezXzAEOv6WK222nxgWvvGEo7lsffQkFI1YqD58ft1FbtKzxo2Nh+/F8NyhVFi
         sEAz/3iDcB27Mz/ugVXeOGmzWXYGto2erKfvbqYbH+YWAT2GoDjYMjcfCR76HyXtw1+L
         NhlXV06677j+ciwTrIudePnxXDRkVKRDYLY9+/N7t9kdftJ6crsIWHyoz7cYndMvMFMW
         zXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741096217; x=1741701017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrYsuIKVD+UTjXvBv+IWgOdWlxYNByPEbenQuMjAbWM=;
        b=ZWxgwlSqEexjQYgEGyBYV2S7625v0vdl7+flgH96437dOXXtiLJ5/Y/CQjz+hgjKtQ
         nA6r5NomI+OKug9yFNzmQnJo5Uh5s2lB8Hb+Ubim87TaCNpT4NsQi7QMYdCMg1BRPLdj
         9QC7xOk0FW046awSEjxoJZkI/+Ke2gAVFNhs4ACI3KqO4mbbBYe4+ZFYQTneWTANmUKU
         0tLtOrhb4ldSELWw4kr2E0qVElxGLqjqrEUWK/tvIGMahhP2JTbz6DAXTZxGP6MYwBqm
         7YhwES51bzI0ae4qnVKve/Zwvy3/vWz6KQTz9WPhMVcxOQ+X1C40TwYAzElY4x4XbREb
         WIDA==
X-Gm-Message-State: AOJu0Ywk5rw2SAtGcYaWb8rPPFbbydTddbqm0r6OYk+s6XT52pCnF37K
	y9tIoyNDZLIfQU9XwEL6Id+DkaWIbR+CLU7b0UF3bXp3wZhcsWnQAruO1xkjlWsW0rFpQ7R19jH
	gM5A=
X-Gm-Gg: ASbGncvZd1QU4RyGMk6wXnw/v6iI1kLpxLmiIW1+TKCy8aHf40fOjK5aiZFqEqqCht4
	ynfi1cRiQWiASuyEKvt9zkiu7gxS/s4rLTV/c7sqH/ljfkhlLQYxEDyKMZ+ydYEMiewjWgIsPFx
	6jKbzJsKeSaTt8ACwQw3GKZ8W7kBEh+pgfZuSSOOKCdqYPcl/DKbQbEilxpgTzcF3lYY3rwC9ER
	5pGmc5Fcbd/uBAGoIkD3UTIj1YPZxGr3W9qVpa46yeF4os++j8lFO6sPm/RphZDmXIMiSTK73Xn
	7t3kx/0s1EH2O7Kdkhw7nsQ4Sk95osIc3lafqYJ1Gw+v0dYo
X-Google-Smtp-Source: AGHT+IGTOmyI1imsf8X1i3V3hRuDOKpDTP2yjLY6x/1Jn/E2a1PbaLnwVOa+4QCsl76xxoNWGtPb1g==
X-Received: by 2002:a5d:5f8b:0:b0:38d:e3da:8b4f with SMTP id ffacd0b85a97d-391154cc7fcmr2698737f8f.0.1741096216709;
        Tue, 04 Mar 2025 05:50:16 -0800 (PST)
Received: from pop-os.lan ([209.198.129.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7cf2sm18096697f8f.59.2025.03.04.05.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:50:16 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Tue, 04 Mar 2025 13:49:14 +0000
Subject: [PATCH 2/3] perf list: Collapse similar events across PMUs
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-james-perf-hybrid-list-v1-2-a363ffac283c@linaro.org>
References: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>
In-Reply-To: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Robin Murphy <robin.murphy@arm.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Instead of showing multiple line items with the same event name and
description, show a single line and concatenate all PMUs that this
event can belong to.

Don't do it for json output. Machine readable output doesn't need to be
minimized, and changing the "Unit" field to a list type would break
backwards compatibility.

Before:
 $ perf list -v
 ...
 br_indirect_spec
       [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a53]
 br_indirect_spec
       [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a57]

After:

 $ perf list -v
 ...
 br_indirect_spec
       [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a53,armv8_cortex_a57]

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/builtin-list.c      |  2 ++
 tools/perf/util/pmus.c         | 75 +++++++++++++++++++++++++++++++++++++-----
 tools/perf/util/print-events.h |  1 +
 3 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index fed482adb039..aacd7beae2a0 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -516,6 +516,7 @@ int cmd_list(int argc, const char **argv)
 		.print_event = default_print_event,
 		.print_metric = default_print_metric,
 		.skip_duplicate_pmus = default_skip_duplicate_pmus,
+		.collapse_events = true
 	};
 	const char *cputype = NULL;
 	const char *unit_name = NULL;
@@ -574,6 +575,7 @@ int cmd_list(int argc, const char **argv)
 			.print_event = json_print_event,
 			.print_metric = json_print_metric,
 			.skip_duplicate_pmus = json_skip_duplicate_pmus,
+			.collapse_events = false
 		};
 		ps = &json_ps;
 	} else {
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 4d60bac2d2b9..cb1b14ade25b 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -453,17 +453,50 @@ static int cmp_sevent(const void *a, const void *b)
 	/* Order by PMU name. */
 	if (as->pmu == bs->pmu)
 		return 0;
-	return strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
+	ret = strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
+	if (ret)
+		return ret;
+
+	/* Order by remaining displayed fields for purposes of deduplication later */
+	ret = strcmp(as->scale_unit ?: "", bs->scale_unit ?: "");
+	if (ret)
+		return ret;
+	ret = !!as->deprecated - !!bs->deprecated;
+	if (ret)
+		return ret;
+	ret = strcmp(as->desc ?: "", bs->desc ?: "");
+	if (ret)
+		return ret;
+	return strcmp(as->long_desc ?: "", bs->long_desc ?: "");
 }
 
-static bool pmu_alias_is_duplicate(struct sevent *a, struct sevent *b)
+enum dup_type {
+	UNIQUE,
+	DUPLICATE,
+	SAME_TEXT
+};
+
+static enum dup_type pmu_alias_duplicate_type(struct sevent *a, struct sevent *b)
 {
 	/* Different names -> never duplicates */
 	if (strcmp(a->name ?: "//", b->name ?: "//"))
-		return false;
+		return UNIQUE;
+
+	/* Duplicate PMU name and event name -> hide completely */
+	if (strcmp(a->pmu_name, b->pmu_name) == 0)
+		return DUPLICATE;
+
+	/* Any other different display text -> not duplicate */
+	if (strcmp(a->topic ?: "", b->topic ?: "") ||
+	    strcmp(a->scale_unit ?: "", b->scale_unit ?: "") ||
+	    a->deprecated != b->deprecated ||
+	    strcmp(a->desc ?: "", b->desc ?: "") ||
+	    strcmp(a->long_desc ?: "", b->long_desc ?: "")) {
+		return UNIQUE;
+	}
 
-	/* Don't remove duplicates for different PMUs */
-	return strcmp(a->pmu_name, b->pmu_name) == 0;
+	/* Same display text but different PMU -> collapse */
+	return SAME_TEXT;
 }
 
 struct events_callback_state {
@@ -501,6 +534,21 @@ static int perf_pmus__print_pmu_events__callback(void *vstate,
 	return 0;
 }
 
+static void concat_pmu_names(char *pmu_names, size_t size, const char *a, const char *b)
+{
+	size_t len = strlen(pmu_names);
+	size_t added;
+
+	if (len)
+		added = snprintf(pmu_names + len, size - len, ",%s", b);
+	else
+		added = snprintf(pmu_names, size, "%s,%s", a, b);
+
+	/* Truncate with ... */
+	if (added > 0 && added + len >= size)
+		sprintf(pmu_names + size - 4, "...");
+}
+
 void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *print_state)
 {
 	struct perf_pmu *pmu;
@@ -510,6 +558,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 	struct events_callback_state state;
 	bool skip_duplicate_pmus = print_cb->skip_duplicate_pmus(print_state);
 	struct perf_pmu *(*scan_fn)(struct perf_pmu *);
+	char pmu_names[128] = {0};
 
 	if (skip_duplicate_pmus)
 		scan_fn = perf_pmus__scan_skip_duplicates;
@@ -539,12 +588,21 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 	qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
 	for (int j = 0; j < len; j++) {
 		/* Skip duplicates */
-		if (j < len - 1 && pmu_alias_is_duplicate(&aliases[j], &aliases[j + 1]))
-			goto free;
+		if (j < len - 1) {
+			enum dup_type dt = pmu_alias_duplicate_type(&aliases[j], &aliases[j + 1]);
+
+			if (dt == DUPLICATE) {
+				goto free;
+			} else if (print_cb->collapse_events && dt == SAME_TEXT) {
+				concat_pmu_names(pmu_names, sizeof(pmu_names),
+						 aliases[j].pmu_name, aliases[j+1].pmu_name);
+				goto free;
+			}
+		}
 
 		print_cb->print_event(print_state,
 				aliases[j].topic,
-				aliases[j].pmu_name,
+				pmu_names[0] ? pmu_names : aliases[j].pmu_name,
 				aliases[j].name,
 				aliases[j].alias,
 				aliases[j].scale_unit,
@@ -553,6 +611,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 				aliases[j].desc,
 				aliases[j].long_desc,
 				aliases[j].encoding_desc);
+		pmu_names[0] = '\0';
 free:
 		zfree(&aliases[j].name);
 		zfree(&aliases[j].alias);
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index 445efa1636c1..e91f9f830a2a 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -27,6 +27,7 @@ struct print_callbacks {
 			const char *threshold,
 			const char *unit);
 	bool (*skip_duplicate_pmus)(void *print_state);
+	bool collapse_events;
 };
 
 /** Print all events, the default when no options are specified. */

-- 
2.34.1

