Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A2D19D064
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495693; cv=none; b=KYpHlXbLHYXarlhbnvsLCfeFZW23HB/24t5kXyb/uFCip6Vuguqn8jC6/qrKaLW93gtcb4Evaw2HAGw+mAd66uJoG/NaWwVMIXuta8c64TB/+ygjED5kZCNS7ykiVolEsIUTLY9wesPbuupkEOKE3pAK8SSzkAZ5C6C2syfKyec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495693; c=relaxed/simple;
	bh=EF3CSRbw8wohrlKxG5cVw1i7yQXdasw3Q6RXbwQPcDY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Ukgllqkhz4PhQLb3j8QJKIzkGF/67wyaYsB2IuM+EisjGcsjIkQH5Wpxy3KSSsb8UzjW/N4uBPNv6kpCkZ0+OAaC23YDIykJk8ZdmptkwcpJy+54nImXyloldxNIkmRavvlmfToSCT1iICqQPhk490Nj+Ms0YaKF5Xb374EQKGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0oKisYM1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0oKisYM1"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-664916e5b40so68397887b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495691; x=1724100491; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TBLmjv6eSiS+LVg3S2PV1+TUybOzhv0kGBRJg6B19ug=;
        b=0oKisYM1dDvebnjAyfZ78b6xbnyAYu0gawWX18AJ0bMWni7NtFm09wIF8YTOIZe4wh
         8XpW2lkY2KmXwkqpDaxwmDY748AEjXwkcvIh7hBuF0+B4O03cI33y8bxo4urerd+9DnM
         9vNimum3p0j4lKZnpYfsKN3HWUXjQ3c9zjhENu+FNkiPcYFgJuu29YcawDTifTV/7qCV
         yrTTbPhRlJOyG46iUJmHXLiaM4cKBzzxdQGtWM7VNFyhVZUjgvyHS0VsHrI+a+LGKRUA
         /IhRpWqlvhQEPsYgBti8DQOpjsfOR4FNqtOBvebV0HDP4U2py36H5DOcpgjntuwL4/pS
         GDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495691; x=1724100491;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBLmjv6eSiS+LVg3S2PV1+TUybOzhv0kGBRJg6B19ug=;
        b=NpLrxvUKn0uRuPDHTBOHwvfUL09IHlTfsfCeYlXFtvBZoAhvkVQaABC7Vtg6VylAIU
         mAFFvMibp5XPReUwBo3I3TAOS4IA6g6hWgKHzfTIms9i6G1pXwbBeVo0mzFiisF4QZhp
         hCYGsRyXzmYeckVyb48Gr6mHMe1P2PnR99oBsNuPNlsnfdsqjD1+Y0gaC8vF21x9N5x8
         TlQtCMl5Ty5IvGlPmvBVWwCTvmrj5ePIYJXbVat9KLsmsntAqpuWN4tvlS6rWDUHRn4/
         jX3Nc8J0l7+VWMkPWdNd4tLij9WOMniExFlIxZW9xDwsdUE3TPLdK094dICZB6raGBXO
         mDbw==
X-Forwarded-Encrypted: i=1; AJvYcCV2IFm3oeXaLECCb6MaBQXFLo00QvDCU2mEa8IR5VTNoADBmjJz7QYNNArEFohLJq8ifFGnoXrz0C5xEXllVVPt@vger.kernel.org
X-Gm-Message-State: AOJu0YxaCB8tobdvgSyhg2BEQ3hDR5qzn/5Z/F2kVrNnzLOdmHj95CWe
	iuO533CRYmOlwElkCB4U/juUVwAUaqvMQlUuVicPtZCkQl6/DSsLMA1PscRqtWJDaDwwkuAc4hN
	eEkjKlw==
X-Google-Smtp-Source: AGHT+IEascsmAbLnMnqwNwXuztrEwJNeZPYC78oqAvFDGFQpaT3AICojo24NJLf0dEcSdbHI+4hFkDNL2o4u
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a0d:d006:0:b0:665:7b0d:ed27 with SMTP id
 00721157ae682-6a9e565a222mr104757b3.2.1723495690833; Mon, 12 Aug 2024
 13:48:10 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:12 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 20/27] perf timechart: Use perf_tool__init
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
 tools/perf/builtin-timechart.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 5bf818baa662..218c8b44d7be 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1606,10 +1606,16 @@ static int __cmd_timechart(struct timechart *tchart, const char *output_name)
 		.mode  = PERF_DATA_MODE_READ,
 		.force = tchart->force,
 	};
-
-	struct perf_session *session = perf_session__new(&data, &tchart->tool);
+	struct perf_session *session;
 	int ret = -EINVAL;
 
+	perf_tool__init(&tchart->tool, /*ordered_events=*/true);
+	tchart->tool.comm		 = process_comm_event;
+	tchart->tool.fork		 = process_fork_event;
+	tchart->tool.exit		 = process_exit_event;
+	tchart->tool.sample		 = process_sample_event;
+
+	session = perf_session__new(&data, &tchart->tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
@@ -1924,13 +1930,6 @@ parse_time(const struct option *opt, const char *arg, int __maybe_unused unset)
 int cmd_timechart(int argc, const char **argv)
 {
 	struct timechart tchart = {
-		.tool = {
-			.comm		 = process_comm_event,
-			.fork		 = process_fork_event,
-			.exit		 = process_exit_event,
-			.sample		 = process_sample_event,
-			.ordered_events	 = true,
-		},
 		.proc_num = 15,
 		.min_time = NSEC_PER_MSEC,
 		.merge_dist = 1000,
-- 
2.46.0.76.ge559c4bf1a-goog

