Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE7643A80
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 23:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AqNhgrFb"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B882218F
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 16:09:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d848694462aso1962828276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Oct 2023 16:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547366; x=1697152166; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uSqAvWdBbUtQxC7pnyJJtR4WVxr7hcg6OVnTaxh+F6M=;
        b=AqNhgrFbRKtUQdWQjxRR5EHYfMMb4DG7jZ19gCcE2xsMbDVRxvMRvV3uQm8kEO0/n9
         cvwinzb6BPcWY6ewNPjPyu2Sb6s5j+LsUrcuuv2i6JgKzd7GU0bayM6KhdV5l3nmfFY2
         Ox9N1RhODCo7vjmHbsW1t+5XX3riysjwC55idTsfAdcp7A84jggSp/2VzdvdyLzUl4Lb
         VUr5WIjeyZt91oKbAshQ3V85qHwFNlW4CMj6FVa1lzlSoqtkr+w+m1bB45g7OrQjD9t7
         368B3Xurb29JH/Z/asL0n7/I6bwqChboHNOJB2wqUtt22LskCAnRDoJPVGiOLMGSsytI
         h94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547366; x=1697152166;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSqAvWdBbUtQxC7pnyJJtR4WVxr7hcg6OVnTaxh+F6M=;
        b=wKmCLe53oO+ZNEtEDAbnou1f0DbkklQGcYQk1STMIUzvwVy5Q6VIm1oe1+sSGo2LIP
         tx/x7/VbpUfB2L6mjjCW51NNSGXTIzjsRYj/aqwMmrdnhVM5L+1q3QBJh2MzEtlxpJGN
         NIKh5oGfMZ3KWDevRKQqa9wZ8D4/pnt71ekdYoWGN5bIWI0XDkCWNa3GQEHcYhOr9SMf
         KvJwJR4GBSm0VMifrSq6lpfhGiCT3pocVm1+a4biwXHBDFePG5cN89J3PvRe/Z15OEeB
         SJBMlqUmEHi85beHMejIvNuspULFFd/MqzjJFkNjhDRXNVQdIgEq2pu0QDlWWSratZS7
         apqA==
X-Gm-Message-State: AOJu0YwSf3fVJr6iUivkAPZ+2DFGpILurBod4N7fCrYMca0LORIiYOCb
	7XTKj7jq/bGN2vsmv/zIqTuBjRVuuV22
X-Google-Smtp-Source: AGHT+IEYRgFM2NV2BQHADakfTQjBrB/7bt9C3vOnga95X2gYJqpyJ21VOHkHsl8QQL8bn7YhF9HuuYUts//N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a05:6902:181a:b0:d89:3ed5:6042 with SMTP
 id cf26-20020a056902181a00b00d893ed56042mr106147ybb.11.1696547365955; Thu, 05
 Oct 2023 16:09:25 -0700 (PDT)
Date: Thu,  5 Oct 2023 16:08:45 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 12/18] perf hists browser: Avoid potential NULL dereference
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ming Wang <wangming01@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yuan Can <yuancan@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On other code paths browser->he_selection is NULL checked, add a
missing case reported by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index f02ee605bbce..f4812b226818 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3302,7 +3302,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 							&options[nr_options],
 							&bi->to.ms,
 							bi->to.al_addr);
-		} else {
+		} else if (browser->he_selection) {
 			nr_options += add_annotate_opt(browser,
 						       &actions[nr_options],
 						       &options[nr_options],
-- 
2.42.0.609.gbb76f46606-goog

