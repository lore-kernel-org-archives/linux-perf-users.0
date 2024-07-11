Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87933171658
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720844; cv=none; b=UsHbUVHELgbGNK/ZyK0J4IHID4spNIfCO2wcaop0ClhhDLwyjWr2Dk2OKL8HyRqFIpzyXRXv+tAnZ35Ko2YRzo04/6MTn+vRZOjtQcSe67QjYSaNewwvSaKqVPDinbTEXn+RNrvh/t9LwJOMdw4NCWwLOEiaP1kpleK7n4gyPBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720844; c=relaxed/simple;
	bh=QyWrdcj/7yIk1kCDwEAAgyYccYi84Zy4FDV3Stu0DB8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=X5dO4VwWjwPgPlgDGi+EOU0Kh+i8ZxGGfs8jVgr3UMgJfvW5i6mRG+b0AhML4lvO54E/460fB2lohCKzA2EKxHREdTJuHW/CSqBuFM8BtSjE4tWbkupCKTFcNc22JQD64tcanflJw6/KScrg945+Zcf6lvnLqbp2J4NpBgF6rJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H7O3BIg9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H7O3BIg9"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e057ae54529so1922738276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 11:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720841; x=1721325641; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GLiukIuXpfj1RuwI+7tVJ3j4buaKUCfjcNd2gIIAnuE=;
        b=H7O3BIg9EW/dJ0u/busmn7NpWus7l0GijjU0R0gwba+m4eDXw7Z2zMF4b19Po9ZugM
         oy+1efnnPasdK09ERK3DhDd+fkAM059cX5tNtb4lBAwz0gALVRqjh/UptNeQqJ/CPrVC
         scnhkEvxSvfrJV+S16MBaqS6iktvClO9n3SrqpZiC0J5rxT7KuVFx50puXIP148KbXEC
         qbyDmGmXgEcHaJfP+Sn449jqgeSA9pz5ZGmL7qLzafQBTwOnjqj1+6ZSRE9YznWKlxTC
         YU3MeSmIfnh4tT6mefKoQ06sOXKDnGaejGhxyXHLPWVF9lcLhgaIVjn4BXkLP+EQYTMn
         EkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720841; x=1721325641;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GLiukIuXpfj1RuwI+7tVJ3j4buaKUCfjcNd2gIIAnuE=;
        b=huYmiDMUmG4GJ+TrzjEXKXCPwgwzKcU0ssSDs5TvjTVUPjxyNIlSUQXpq+4THxS2xk
         sqeXUpLaPVG4hLtquvpfTNuo+j+Em9Oi2n8hvYUkDjCy31CYj6Fyb3jleChmQj01epo9
         LwGkceOGAKr/xWr06YF4repS72PhFb6GYOOv0KzB8noqtrraSHq9A2NJZWSiLOSdtEo4
         I3Np+PjcxtLxQ5c6R4fLEc1DpSDwKOX/7Ei9lF3AgpEN5LvDvkt9rUIBJvhDxW5OlHW3
         3EHw9podePwIIIq7HbSGliAicPrcUnIGuwHTtduW9pzBWZ+K2S9AdJ8KDdkq1yFZrSP+
         VL5w==
X-Forwarded-Encrypted: i=1; AJvYcCW/OixyThPdXaPuqdADvlVprDkV7D+Y230/zo6pun75LSzLFeq3h3OmbBUEPaDweWEiptsE7IGLHTTu0F9k3TAQhBP8yxleYsmDxzH2X+ZpjA==
X-Gm-Message-State: AOJu0YyRdCPfVmgeSEKoQfK2APnZ2KnkOJrJx+3Fdy7bm+QaYz8dg5UL
	4tEv66cP+q490ANn3ITLdh6jT5sYL2YFu/B7DJht+CxU50yxvWqa59+Q0c4mLGLwsSiBh3AtY7y
	nPwLnzw==
X-Google-Smtp-Source: AGHT+IEXF5wj8ayTVT9jirmz9sHwimvl3fY+5kUcaEScOacOHrr5WKsgjJfB+7NPgApJ3Zze2HXsuC0tMBh0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:1002:b0:e02:b51f:ceac with SMTP
 id 3f1490d57ef6-e041b1415d3mr391043276.9.1720720841581; Thu, 11 Jul 2024
 11:00:41 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:59:53 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 13/28] perf c2c: Use perf_tool__init
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
2.45.2.993.g49e7a77208-goog

