Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704E241E49
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HTGENdZB"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B41EA6
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 14:41:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a4ae873edso501852276.3
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Oct 2023 14:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696887714; x=1697492514; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ym33VVd2BajpUroKBZvd3tTL/sMIOEowMFesXhruLGo=;
        b=HTGENdZBPKlywpeRZTnkFxadASq9or7mh1T7skYYVLOrqDM4xcUWynpi/Xb1L3yEO4
         xODj1nK7ply4KRs8VM4C711ZDgbXpHqvyDgh8+7gPwKtw1qcBzCvgjhnBRh8q/y7DEAm
         mIJTIjd7cTe3N231oYhgntTvXrasZahcMmhC6N4oluqih0C8S7/jBmrnVZFXIuA4hVtf
         /8DpBw9aaobz4ejmKCiZoyJmMJ5kwWRlwCO+kYvw3/TGPyxVh2/5b2VqMfIpQJfY1haz
         pvr8oPQ+mNLYASxBfyX6szbVawfozhiR5z4lXSPbnXlH+NQIyAul+D1uJEvHqoq4VNB0
         n4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696887714; x=1697492514;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ym33VVd2BajpUroKBZvd3tTL/sMIOEowMFesXhruLGo=;
        b=pUbIFyUADcb9DoOpeqIywdU7Xh0mzXZT4PKvGLzBFLR0kzrI6iegoUct9XPTfdxNbS
         FA8vMfh9RPDLKJTY9hJQfohnl0fCQ1hh8pAbjX3s4Wt6+/a0J5eCtqD4rNQeCH++0QT+
         VoolTE9E8Frc1pW+WKunZL4QmiBnqmxvA/K+yxm1SHejt3qrFMoqLYar8sDe/1mK59G7
         g/mH/DQJ1iD75s7FdU3oFwWFUxFOjUrhLPOADSSgwoa5saN6VH6tOYKvlYFtkzsASLHB
         xIIzZ6EnjR7fWjDVu7ejNFw3NfLBZ0lOFNzaNb+mQS3eBvsWEtA/6qvBHqRWcwi8aS8A
         Lnjg==
X-Gm-Message-State: AOJu0YzKmetZdK9JEZDgUWN62QFHcnicXrAkl1LiSHXYnLZxep0t07Zx
	RNU08kM9p66TyMMIkbsEqciNbrg3R4Ye
X-Google-Smtp-Source: AGHT+IHnxhKG34IioS36StlETcBwWpm7R+pkHJp4TsAXkkYCJP5Z2X/3faXasm0mt0NAqHj/TMNCjm2I+IU2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a25:694b:0:b0:d7b:8d0c:43f0 with SMTP id
 e72-20020a25694b000000b00d7b8d0c43f0mr262206ybc.11.1696887713827; Mon, 09 Oct
 2023 14:41:53 -0700 (PDT)
Date: Mon,  9 Oct 2023 14:41:43 -0700
In-Reply-To: <20231009214143.349978-1-irogers@google.com>
Message-Id: <20231009214143.349978-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009214143.349978-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v1 3/3] perf hist: Add missing puts to hist__account_cycles
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Artem Savkov <asavkov@redhat.com>, Andi Kleen <ak@linux.intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Caught using reference count checking on perf top with
"--call-graph=lbr". After this no memory leaks were detected.

Fixes: 57849998e2cd ("perf report: Add processing for cycle histograms")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hist.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 3dc8a4968beb..ac8c0ef48a7f 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2676,8 +2676,6 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 
 	/* If we have branch cycles always annotate them. */
 	if (bs && bs->nr && entries[0].flags.cycles) {
-		int i;
-
 		bi = sample__resolve_bstack(sample, al);
 		if (bi) {
 			struct addr_map_symbol *prev = NULL;
@@ -2692,7 +2690,7 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			 * Note that perf stores branches reversed from
 			 * program order!
 			 */
-			for (i = bs->nr - 1; i >= 0; i--) {
+			for (int i = bs->nr - 1; i >= 0; i--) {
 				addr_map_symbol__account_cycles(&bi[i].from,
 					nonany_branch_mode ? NULL : prev,
 					bi[i].flags.cycles);
@@ -2701,6 +2699,12 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 				if (total_cycles)
 					*total_cycles += bi[i].flags.cycles;
 			}
+			for (unsigned int i = 0; i < bs->nr; i++) {
+				map__put(bi[i].to.ms.map);
+				maps__put(bi[i].to.ms.maps);
+				map__put(bi[i].from.ms.map);
+				maps__put(bi[i].from.ms.maps);
+			}
 			free(bi);
 		}
 	}
-- 
2.42.0.609.gbb76f46606-goog

