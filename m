Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B3625DAF0
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328745; cv=none; b=OkdVVAGJAyk7brX3q+7L8LdMPZoZbMCaYzvoeoEVkbGxoO1qkKVao7cMdnrAXvya96SuYORbh0O/i9MnaiBiiWys4bf3GZHYMf6kk5c9lP/h8iEE3BpalWvI2hv9kHLKgoZlj14oZhfTyS+mlQRjQk9xAyOkHhbAb7qCojKigJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328745; c=relaxed/simple;
	bh=6nMA14P6Qbyeexp3WnkGdWEw8fvqzdlcMJ8tkdNQ/+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MZ0DLekBXayLqlV//S6tYXWXQxlK4J9kyUMMIbZZSSnY399iN/CXoI1C93UJko0Qx3QREy5r3/HZFuw/pQI6fzwQkHV30wJmcHobFrDlT2G28G6ryS68vkQtPT+Vd7ATDjQ8sZtri1GqVOu1PTSMzn7eXlAv4rO/ZojxJBr4KhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ubZl06AY; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ubZl06AY"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so1854500a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 10:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328742; x=1761933542; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TbMR3wgxv/2o2pYwh/5JL78UktKAGHt4o5fQQRcTvk0=;
        b=ubZl06AYWKCcecnNa+f+OIfmu9cJHDMcYhHefMYbQS1vTjOXNsuLUjnxvxcxFtA64K
         7IyC1yNTcV317sz27u91BtdyfjseG6GcAEx/yLtS5Uu9WwMvn4bn9MB3ihAEISOd246V
         qJYZzj4JdKO4GnS9z/Iq8DBcfiS/QAI5jrwqzHLLj5Ny28oHX/HuUZGyNI54cyJPL0Au
         5d2jd83v8bC25XFQdzUzHrsa1OfQCzpYLWoiD/QWxL98H9rs4tBAIkaj1e/wYCpxLf2n
         L6NxDfWSQwRC0mw+m9ZuagCLzWKpwP6Hh5rpIdJJ/Zsi1T7+h1xc15w3eTW0WezrteMB
         HwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328742; x=1761933542;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TbMR3wgxv/2o2pYwh/5JL78UktKAGHt4o5fQQRcTvk0=;
        b=Ux7AkfZThUmbyZXo9gKfK0BE76wKXTllwxMT7Hd1zm0qep0pEU/91Ym057SbHsVP5X
         KXRM2B4whEkjWHciJfUOZj8UDt/dTM8EsKGhqyt7R5QWL7EORzxIWqo8wXOO7e8D8w0R
         cRx4dp/Z/uVXkp/vjK2tsdM9CI8oPKXNy3KaVl0LNsBGsl0Z1q7Y9QyjFUzpqFAEmGI8
         Dvd9k07luk32Oqk0lKzayJ8r0MOsdLKSkYr0FLGQGpig+ve8L9yfnMuxqO0sgxgd8Qgh
         +eqrMLMQrjvkiaO4+e5lkWOcJ4lnT+LXiHg2rA+HD13cdi/6dQXUiLgoy3+du/tCKlUD
         Fmkw==
X-Forwarded-Encrypted: i=1; AJvYcCWw3m051uihcwNTV6fvGdGAYGm7h8+Nc6CnGBXMEljNriSG7jxrK4WsGIqvM0SnJ8lPveGlzRMOih+NF++2fPSq@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw1Uql2cpTyQRQEo+b/adUr3NcVFpdfZhRROcM9mnAulm5X4w5
	ZYuI1paTIdAZiMqh3qK6R40/J7lITaQBb8LjZ1qLsfi3AIr5lawph5v6WNkEkTSAcgLnUM45kyc
	3U/tFMa+T5w==
X-Google-Smtp-Source: AGHT+IGpCt51qhaTx579ZsbwdfKtQa8stTm7ZlEnQVHPsQ32n9Rb5o/ubQYxcXG1X+7Sp4X8w5b20JtYjRD7
X-Received: from pjob9.prod.google.com ([2002:a17:90a:8c89:b0:33b:8aa1:75ed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2412:b0:33e:1ed8:334d
 with SMTP id 98e67ed59e1d1-33e1ed835a8mr11420778a91.16.1761328742289; Fri, 24
 Oct 2025 10:59:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:36 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-2-irogers@google.com>
Subject: [PATCH v1 01/22] perf evsel: Remove unused metric_events variable
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The metric_events exist in the metric_expr list and so this variable
has been unused for a while.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 2 --
 tools/perf/util/evsel.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ad11cbfcbff1..67a898cda86a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -402,7 +402,6 @@ void evsel__init(struct evsel *evsel,
 	evsel->sample_size = __evsel__sample_size(attr->sample_type);
 	evsel__calc_id_pos(evsel);
 	evsel->cmdline_group_boundary = false;
-	evsel->metric_events = NULL;
 	evsel->per_pkg_mask  = NULL;
 	evsel->collect_stat  = false;
 	evsel->group_pmu_name = NULL;
@@ -1754,7 +1753,6 @@ void evsel__exit(struct evsel *evsel)
 	evsel__zero_per_pkg(evsel);
 	hashmap__free(evsel->per_pkg_mask);
 	evsel->per_pkg_mask = NULL;
-	zfree(&evsel->metric_events);
 	if (evsel__priv_destructor)
 		evsel__priv_destructor(evsel->priv);
 	perf_evsel__object.fini(evsel);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index f8de0f9a719b..71f74c7036ef 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -100,7 +100,6 @@ struct evsel {
 	 * metric fields are similar, but needs more care as they can have
 	 * references to other metric (evsel).
 	 */
-	struct evsel		**metric_events;
 	struct evsel		*metric_leader;
 
 	void			*handler;
-- 
2.51.1.821.gb6fe4d2222-goog

