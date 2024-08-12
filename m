Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F72199E84
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495675; cv=none; b=VBvUQFxHVhH5To79oCkWem578xhuiBvr+Y5gR/S58m9EIiIE0raIsov2/KulNr/uXI8/JLl7wsYuMdvDE4HsiXhgEHdoaZzVYBXWSy9VTyfMshKVxCc7YuMW82Y1DDxvZRkx3GsxelwJiWtG6ez80UuyPzvSE8GC+PA4dcaMmx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495675; c=relaxed/simple;
	bh=O2wXFqQ+3i7p2uR5HW2+BZ8trUJDzqZbOysNOuAqUiM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Y4c7bMhDfeuc4UL2VPkKE960dc4H758TC++wWnrM+RqQIL6cAmvs4PYdXW2EnR7OvIzm8adK/H9b55uWsO56SodKtBtZC5Vq9dTm1HVfFPplrmU5q5T/UTGvREJ6tq9XVVwYROtMGpMaLdNLCW/0ZiyDcMUDkM/mBNXbvZISbMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uJ9Rbbzc; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJ9Rbbzc"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc691f1f83aso2881483276.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495673; x=1724100473; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H+nsPHTHHGayzU+LXZk3pnh3l+7HMNM65zEgwyXyMdU=;
        b=uJ9RbbzcWOl4PzM0nRRHB2ReelQJxvNxEeRqax/eIKJBRsppEGMiBmJCreHVwb22uI
         sKGMb96HnHVm2ObKPu0ym/gw+1H4g7XetHnODGck2aUWMTq5awDXg5QoOD/NgN4TfoP6
         qPcrgcX7l1bkhU/gMEDLpWV7zkhZYB4aFUl/2AltKxLwfQXnn6G778x693HY8rWnNRpz
         v1THtJiSsumGSlgPC9QsJNpBdz2XEWBN1EUU5mFCbXmpSt9+2CQJCCZVlapvsIjS6D/k
         Fb+TvOBXiXNBkyCqbYZlRPJ2gXZDec5NcKLhg4xVvewubicODmuY9qWqOZDVx66LTTC0
         TINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495673; x=1724100473;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+nsPHTHHGayzU+LXZk3pnh3l+7HMNM65zEgwyXyMdU=;
        b=XgQT3V+g6Bwbv05bcFLLsed2S+xJo15cwPdK3F8c6iRftfbdgvnAgesCgDse4t75lK
         d60S2e5Z3/8um2DWHoRcZOZOMR0H3TpQNk2rfbIXYkQGeaiVdbD3QGAo/0/oHaSnLQ/F
         c/DuGthZzEmcpeYtdh1H1XI8a2yEiX28iVoTEz7Fl63wlO328Gw4mp3ESjDDM1/XQCdE
         TEAsaUNNFtvwe7o96ubTmPU5c3ljAgx6EsKsLBBt8CeQnJoooUJnlxmcVyxh+rWzWv8c
         sgvRU63s7/jTkmKi6KKVOyDHh301uceUzKL2jZu+eWZmNQz+tvwcNd1tABBfnGZxhPBY
         7fZA==
X-Forwarded-Encrypted: i=1; AJvYcCVxoL+PtM+8kob0pv0z/DKUiKnUueGeB9xfa3uqHFz7go1IDmqTKRf0RK01yb7j8Hnstp4ggEO9DJX9Nv6aoGJZ8DQMHjUpOY7sHE4OZCNILA==
X-Gm-Message-State: AOJu0YwBxAguT4j+C5FDILfy0GcPLYxK3HSwVeYWagN3IiJrzOx/49oD
	bnmQgMOKii6R9nN+CMV/I7qYRlDQBMWWSqV5f41r50fxBolgjKOStz9u5IKySgtWOMaXAgcQALu
	BclMsTA==
X-Google-Smtp-Source: AGHT+IHaVCmGUqBY7uxyQBoBTmxx2l15/jbG59J06sz/NFX3hwioeaXKnIwZ4mNQYTPD7YuKY1X5NozY0ofL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a25:ce90:0:b0:e0e:ce2e:abfd with SMTP id
 3f1490d57ef6-e11408842ebmr14655276.0.1723495672523; Mon, 12 Aug 2024 13:47:52
 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:04 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 12/27] perf c2c: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 88c131d05186..cd2bd573bfc3 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -385,24 +385,6 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	goto out;
 }
 
-static struct perf_c2c c2c = {
-	.tool = {
-		.sample		= process_sample_event,
-		.mmap		= perf_event__process_mmap,
-		.mmap2		= perf_event__process_mmap2,
-		.comm		= perf_event__process_comm,
-		.exit		= perf_event__process_exit,
-		.fork		= perf_event__process_fork,
-		.lost		= perf_event__process_lost,
-		.attr		= perf_event__process_attr,
-		.auxtrace_info  = perf_event__process_auxtrace_info,
-		.auxtrace       = perf_event__process_auxtrace,
-		.auxtrace_error = perf_event__process_auxtrace_error,
-		.ordered_events	= true,
-		.ordering_requires_timestamps = true,
-	},
-};
-
 static const char * const c2c_usage[] = {
 	"perf c2c {record|report}",
 	NULL
@@ -3070,6 +3052,19 @@ static int perf_c2c__report(int argc, const char **argv)
 	data.path  = input_name;
 	data.force = symbol_conf.force;
 
+	perf_tool__init(&c2c.tool, /*ordered_events=*/true);
+	c2c.tool.sample		= process_sample_event;
+	c2c.tool.mmap		= perf_event__process_mmap;
+	c2c.tool.mmap2		= perf_event__process_mmap2;
+	c2c.tool.comm		= perf_event__process_comm;
+	c2c.tool.exit		= perf_event__process_exit;
+	c2c.tool.fork		= perf_event__process_fork;
+	c2c.tool.lost		= perf_event__process_lost;
+	c2c.tool.attr		= perf_event__process_attr;
+	c2c.tool.auxtrace_info  = perf_event__process_auxtrace_info;
+	c2c.tool.auxtrace       = perf_event__process_auxtrace;
+	c2c.tool.auxtrace_error = perf_event__process_auxtrace_error;
+	c2c.tool.ordering_requires_timestamps = true;
 	session = perf_session__new(&data, &c2c.tool);
 	if (IS_ERR(session)) {
 		err = PTR_ERR(session);
-- 
2.46.0.76.ge559c4bf1a-goog

