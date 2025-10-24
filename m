Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CC8346E59
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328747; cv=none; b=W86suU7oU1tw78aX4py/Ydkix9qaRs21EnU2f+ZLqCn/K2AxdXeagTflc3VncyUdSXF+HbOEOmktziMPn0KbGH9mOcRHELRgB43jV2RtyCSnR9rJoTbKNJI9UixalUoqpl8GNFq5zkNbfjYmagPaY9Dnwd/Cd21qyEDjxgN1tEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328747; c=relaxed/simple;
	bh=bTV8txl6J+Uqsxr3Xc3JLKdUKdNRKaAH612k7TJHs/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DzvBRn0i5ioMWeG4MEhu8QUiCNhjFS2ModnEiMTG9IRsdM/XTjg1xofDSGb5eFWTUrRxQljbJmdfBpKDIP1nJyjUYwL/j1Vdr3UxvNxFXxdd4vwbtXZqmT0EA89YumY4cQ1ZcPXJIEoWSatSveHn2Q58qGbbygpq0IXOWy9v+nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wViwiQsQ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wViwiQsQ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33bcb779733so2124264a91.3
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328745; x=1761933545; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BhTEfwSMW0ADFSj2x343ckUKGAB1lcE1/wiXOsdLtZw=;
        b=wViwiQsQnWUV1L6fbFyuNquccX9W0oDNZmDAhX2IFkaAVmVY1kx3DOYllvHKcVDRZp
         oDyubkrcO3kr/Cqk8WJHNOb45FhvInfaw/N011Z3Lc2t0imSPyW1SS8/T9FbcdXy5GG3
         syxtJNEwra/LQNbiqlzFf9Z1RWS2uwfExmb/v3uXHRIVF2Z5KugdrRPatcBaGEtwriKe
         twYMkZtpGub+gwQ25hSNobFPnjMzU09VgqMDGoPXjgBjmv7mOoPR6uaK+5zha/feyeHK
         sS0aOnEI69t6sIL9I+YU4cIbZCfGy92DkEYPBsnvQyl/D8i07PKM6O4ca/r+wkYB5+5p
         QrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328745; x=1761933545;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BhTEfwSMW0ADFSj2x343ckUKGAB1lcE1/wiXOsdLtZw=;
        b=oxd3KgMXJs3k2OTTJoAZzBfn6JjVq4eVC8Cqox/NzrRYUdMMLZAqui03eaYhTp1jvC
         OkYbZI9xg95TYkKZZXYH5Tn3sOfu9KB1Ngq1IniIJVMltCPheB6vHiMmH4WRN3qlyNF7
         iQGB1B+EkhDKtE3eXMXDzpMIPGt6/5hmftoEAA6MqQFUZ+J/v1vDRh6v4rCexYYWIsFO
         lOjxvv2GEqvLxFVk1aMa1jhQj/+iqORhb2VLsmEDmVskUvsroWU3fxsLu6PJhRHoxnQx
         Hf/5cCfQDIhdUw3fQOnKoQ65OMk9XGRvzmdprQh+ATtqW5sj5c2a/2uxH7PnalDI4Lnc
         VmSg==
X-Forwarded-Encrypted: i=1; AJvYcCX8iO59GhEp0bSg26vHfVchj6wX5j4uDKeEZN6Af9cF8nEqPDZP0Zt2dRM/1vDP0o/sIw/2aWhVs90S13b9it7S@vger.kernel.org
X-Gm-Message-State: AOJu0YyBlJE5iKsoKelsiMPwTpT0Fch1e4lWamTBAINyWoOBaeGAzw17
	cM1nYwSibabQg0hiUmSgP965dGB+HZZLTLzRpizx3jrzF70eWzy3o39BXmZmLnrWF/6M0t2af7R
	FYkz8x5zwVw==
X-Google-Smtp-Source: AGHT+IHhe/p4ofHfb6dV7KY04MrvRtZ5D4pIUmxw/S7DTlnlaUGxskNegeWjkD65dN526PJYlpWhKk1+pJ7s
X-Received: from pjvh14.prod.google.com ([2002:a17:90a:db8e:b0:33e:32fc:fc4f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5111:b0:33b:c5ce:3cb0
 with SMTP id 98e67ed59e1d1-33bcf8e4560mr39920784a91.20.1761328744649; Fri, 24
 Oct 2025 10:59:04 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:37 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-3-irogers@google.com>
Subject: [PATCH v1 02/22] perf metricgroup: Update comment on location of
 metric_event list
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

Update comment as the stat_config no longer holds all metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
Fixes: faebee18d720 ("perf stat: Move metric list from config to evlist")
---
 tools/perf/util/metricgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 324880b2ed8f..4be6bfc13c46 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -16,7 +16,7 @@ struct cgroup;
 
 /**
  * A node in a rblist keyed by the evsel. The global rblist of metric events
- * generally exists in perf_stat_config. The evsel is looked up in the rblist
+ * generally exists in evlist. The evsel is looked up in the rblist
  * yielding a list of metric_expr.
  */
 struct metric_event {
-- 
2.51.1.821.gb6fe4d2222-goog

