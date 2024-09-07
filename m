Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE86C1487D1
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Sep 2024 05:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725685733; cv=none; b=biO14FAtFZiFXmIxarsqRlW1gPBZBnpyZscxrm80U9+ouOg2aoKP8mYMmBft6XaDht6oFgbCrZshaWCf2U0EYhQ8GZN+8kiCiPrE5xo7sM9vuI9n9yJcYbOuyrPEVgl7YM1zzTNSdtKFI4/05h6GqLcKaw6p3b9G+flTQsVg314=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725685733; c=relaxed/simple;
	bh=HkKh04X8D6J+bMpYJGXztyOf9L9ngWoa7v1G2rn5Oi8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=e8kZuifR9ZaHcyNLw14xiqep1uX3z74MIs+QW+DL9EyMmPOTyWWkY9sCVSAzxaYiImU1Ru6uJP3HCO2W0PqZODlkF6W1/vzjjoZ98YsiYzvp7Y6hSfYzYKMKQVKpopdWDrk82hW8dzV/h0uPDmyenOQoTPgcuqb6mlOD0q+Tz80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CLCa+Nip; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLCa+Nip"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02fff66a83so6487903276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Sep 2024 22:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725685730; x=1726290530; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QKvA61WwO8WManIDEry3xBPvYjCmgFaen6iyvj8dmS0=;
        b=CLCa+NipwramntTlpL4SbzoTMVP8F8LgejlnIN3w5Ju9hGCndXTEvx9os8Q11ia926
         H8HRkKH7yqOUr3C0zh/I5MTr3nZ/SRsNhWncqq1SQ/uD8Oo5bdLz8LGCv8ptPpogN8qy
         Hm2LD+7OEYSB9hSdG25tMhDKgnqjvj5d0vU5o4gga4AVgakBuAhWIY4gfFL/X+V7tjxh
         ktWJQihx41SZIZcXDcaxUhWI/tXCVqTjwilLdNAy17a68wSFEKPTxCKOhYvPB+MNb6HR
         /GH2BvpVDP4/f4RA0TxEa53nDlEG1M16sJ1By3ivSLTevEitf+qdh18OoHof0sR1iVMz
         3h8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725685730; x=1726290530;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKvA61WwO8WManIDEry3xBPvYjCmgFaen6iyvj8dmS0=;
        b=Ys7bRwt+D0dZ89Hq7pUKzWngrO9RUc9twF1BCyUJ6UGzRDN9wJuxO2XGCY7No6D8v6
         nFMONEkS7znCTqLN4BxOc0CHG7QpJuFnUx4Hx5x3q+zbRyeZKYing8yeP2X6xEr5bABa
         aU2iAOn0WdGzRSXv6rBnqA7SeLn/gNlLoVk3X7J59bnAgqf1My9xBsb4y+Rgq9lTDLAt
         roP6hEvS9pPT6esveAzO+UITGrq+fOe6JDHslKEE/sxITWH3ng/a2cXb2iwNZ2C5U/CY
         UeBapMvy4I0PEVZPOTqY5NEeK95dVuLK1MIac41fM0wXArzU+kyWK7147Y7e2B29zY9c
         MeKw==
X-Forwarded-Encrypted: i=1; AJvYcCV1HNaO0bD+R+WwiVHnU4CznnRAIKarycF00lQ8niLuV9Ds1dARu1QfOMWyqPP4D5IzOmzNACyNjNICKvQ+Km6P@vger.kernel.org
X-Gm-Message-State: AOJu0YzoZ7aNGGX730gPcWGWZQMmyi9mOuGOGQvfMLUCQZ89saPg9siq
	1JubS8e4TWKYu6q8oHpUgIm1mDXNXIyc6QStBFJ+WOXkMTdZwmqQYAP6vtc+o/rPkRLjZOf3xay
	mnP0yKw==
X-Google-Smtp-Source: AGHT+IF7UBKTi9sJI18dojLizpBg3DhTO/Azd5rIjyDI4e7nelFwAEZSFGGcydoCgyKhtL3urTmxhEGBxaKF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:90e5:a813:c3d3:daed])
 (user=irogers job=sendgmr) by 2002:a5b:6c6:0:b0:e1a:9a4d:a500 with SMTP id
 3f1490d57ef6-e1d34a1461cmr7217276.11.1725685729619; Fri, 06 Sep 2024 22:08:49
 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:08:19 -0700
In-Reply-To: <20240907050830.6752-1-irogers@google.com>
Message-Id: <20240907050830.6752-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240907050830.6752-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 04/15] perf pmu: To info add event_type_desc
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

All PMU events are assumed to be "Kernel PMU event", however, this
isn't true for fake PMUs and won't be true with the addition of more
software PMUs. Make the PMU's type description name configurable -
largely for printing callbacks.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c  | 1 +
 tools/perf/util/pmu.h  | 1 +
 tools/perf/util/pmus.c | 5 ++++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 50e2e7abffab..72bfc321e4b3 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1857,6 +1857,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	struct perf_pmu_alias *event;
 	struct pmu_event_info info = {
 		.pmu = pmu,
+		.event_type_desc = "Kernel PMU event",
 	};
 	int ret = 0;
 	struct strbuf sb;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index d6f702e55a05..4397c48ad569 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -194,6 +194,7 @@ struct pmu_event_info {
 	const char *encoding_desc;
 	const char *topic;
 	const char *pmu_name;
+	const char *event_type_desc;
 	const char *str;
 	bool deprecated;
 };
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 864cbfa1f960..93e5c0435ee0 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -371,6 +371,7 @@ struct sevent {
 	const char *encoding_desc;
 	const char *topic;
 	const char *pmu_name;
+	const char *event_type_desc;
 	bool deprecated;
 };
 
@@ -444,6 +445,7 @@ static int perf_pmus__print_pmu_events__callback(void *vstate,
 	COPY_STR(encoding_desc);
 	COPY_STR(topic);
 	COPY_STR(pmu_name);
+	COPY_STR(event_type_desc);
 #undef COPY_STR
 	s->deprecated = info->deprecated;
 	state->index++;
@@ -498,7 +500,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 				aliases[j].alias,
 				aliases[j].scale_unit,
 				aliases[j].deprecated,
-				"Kernel PMU event",
+				aliases[j].event_type_desc,
 				aliases[j].desc,
 				aliases[j].long_desc,
 				aliases[j].encoding_desc);
@@ -511,6 +513,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 		zfree(&aliases[j].encoding_desc);
 		zfree(&aliases[j].topic);
 		zfree(&aliases[j].pmu_name);
+		zfree(&aliases[j].event_type_desc);
 	}
 	if (printed && pager_in_use())
 		printf("\n");
-- 
2.46.0.469.g59c65b2a67-goog

