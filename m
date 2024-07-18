Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A79875816
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 01:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264480; cv=none; b=IBEooO1Q6l7SEddc8mbx7Ema85JGDNnfdkqNzhWNmn1llRhNQ5FqgmvmIUwVaDwHdxcDGTY8WnQjHHWCEiNRCJe8iOX324TfkcmzWZyXEnKm9q+Kan3+HIpPHPrY2+nIvJtR7fgtjC/3up+Di7xiVWHQejCHZUlBK4gebGuoXzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264480; c=relaxed/simple;
	bh=6n88zCXwG9bSPE66xVrogeJqWiH/mhJHqZDV/21qFRs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=k8YISckYJsSDAU+sHa0oCXMo9kOphbNqva+dmZXsZRA/oRlkoVuDjqIL4TtAPNq0Vd78yAWavZXSrpT6Zmhl0ADPVKxmjb1Xx7ePi/IceQGlyctqwoZgBpF2wPr+m2ngCdnWsiRPBFpehj+NeWorX3iw3OrD24+z1Mjw4PR+OhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WWZK5MFG; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WWZK5MFG"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02b7adfb95so689051276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 18:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264474; x=1721869274; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AE1o9GzylDTNU/tj+neWnduRfzORtFIhqRzpNenF16s=;
        b=WWZK5MFGOscimF/pHy7HO3SHDrp65DK2CYqUmZybdyIHSQRdUmNTKo7e1QcI35wveu
         3d95JicckjFaUAZzcJd2O8zhFW0Ql+HTMEYrvsuN3VfuXmwxUKYwnj0xOTqKR1Z3X+wb
         jlQAbS8gDD8IVecWbSoQi/MrYwNLx43i69Ni8FA2YV7FGhtw21zVCMwjPEtNf/ZDZlNI
         2FtZg8tbnDHRyfPidxqKuheIZsS010VDneP4HiUKOI6z4iNxFmk34Jjuljb3GIjCrUyJ
         YYnENLXzb7hBQzdswvLs+dmLktH2j51WS0CcCASrDoNY9DdVXn1RPWloG00MdLKpUMh5
         3+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264474; x=1721869274;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AE1o9GzylDTNU/tj+neWnduRfzORtFIhqRzpNenF16s=;
        b=F8hNOxGbKbJ2O9k1XJdMD4msYtbaWFseG7wQdX5SHqcZSULQLN8B+S2AQAXme7WnKI
         mAvVZm0aje0TAFMOXET4xROGJ99xJDH2RHDYTNf//NNClvGI5u87t71xTvlU2g6FamdD
         ldlGWaqDvDdCHNq2yeynpbfiPsaLdFEvz4FPVe+e7aYTwvHnYZ2cmT1x2qZIA3TXaN56
         mIfNkKdMG2svctqeZ43fbjiqi7fs+mXZed+LvCtP3+qDuU7inEYLF9AAA8YB41gVS7Ge
         ufOcJDJ0RR4QFT1ANgQ+0CdmLP6aP+PSrnmAatSfsc8Z+RjRvVaCu+KQXPtLV5sDnOuh
         sPQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuMarE4zCWEvBqCEJgyedt9oT+sTvlSO+HhSNkWFJr1CP+oo4ONEeSetK/FZT+KovCz2mBruis2jVglj6pAxT9CMCeOylQ7fFxeKxe0Hq8ww==
X-Gm-Message-State: AOJu0YzDeMdQGzdcmc7bSXVysQ79w9TwqVuUIB0FNk2jGxD/QkgvQjaE
	KqTuXMvC2eWyh8J7J3Q0PyY2r78Kn+v347GYAYy2/as6Qs0/dNnq2fjka3HyTeI9Ho/xg/zhmxL
	0Lvv3HA==
X-Google-Smtp-Source: AGHT+IGgBhJ/vZuBVSyFSptR6UrX0xinXo4sb/hBXkBYSLP3hMqMO6tKzBxK9aNEcm7jyYNyXiyoQrcO72E7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:1245:b0:e03:a0dd:43c1 with SMTP
 id 3f1490d57ef6-e05fe74c656mr10367276.0.1721264473975; Wed, 17 Jul 2024
 18:01:13 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:12 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 16/27] perf stat: Use perf_tool__init
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
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-stat.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d460c46f15fd..a3d77a55d17f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2271,15 +2271,6 @@ static const char * const stat_report_usage[] = {
 };
 
 static struct perf_stat perf_stat = {
-	.tool = {
-		.attr		= perf_event__process_attr,
-		.event_update	= perf_event__process_event_update,
-		.thread_map	= process_thread_map_event,
-		.cpu_map	= process_cpu_map_event,
-		.stat_config	= process_stat_config_event,
-		.stat		= perf_event__process_stat_event,
-		.stat_round	= process_stat_round_event,
-	},
 	.aggr_mode	= AGGR_UNSET,
 	.aggr_level	= 0,
 };
@@ -2322,6 +2313,15 @@ static int __cmd_report(int argc, const char **argv)
 	perf_stat.data.path = input_name;
 	perf_stat.data.mode = PERF_DATA_MODE_READ;
 
+	perf_tool__init(&perf_stat.tool, /*ordered_events=*/false);
+	perf_stat.tool.attr		= perf_event__process_attr;
+	perf_stat.tool.event_update	= perf_event__process_event_update;
+	perf_stat.tool.thread_map	= process_thread_map_event;
+	perf_stat.tool.cpu_map		= process_cpu_map_event;
+	perf_stat.tool.stat_config	= process_stat_config_event;
+	perf_stat.tool.stat		= perf_event__process_stat_event;
+	perf_stat.tool.stat_round	= process_stat_round_event;
+
 	session = perf_session__new(&perf_stat.data, &perf_stat.tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.45.2.1089.g2a221341d9-goog

