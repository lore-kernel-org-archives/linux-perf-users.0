Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB035C121
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Oct 2024 00:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518858; cv=none; b=XhP/uZlhcpV5qbXELAkaEJRBlT8hYtncfstNYLL0DMUHN9Yo8UZaWlgnZ2M5jfQPNb6iR0WE6+wxjMzQn44YCmSSiT72AVRp0D6IiIwzBqnij+hy6CdcF4GHHNbYCh6qTQUnenyERYaoG0IrE3bHnLW0pGKFP/zDZNt5YpzwQeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518858; c=relaxed/simple;
	bh=K+iLRNmPq7pFFzgCwk+WDV1uDJdmXtPtLhF5jSJiB/Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gP3VrkxThRKIeQrH1wGmKTbV5n60XEAc5hTHqk7KL0SSTUdL4c0Gs1jmFvHxDS8c3GPu/CLb4LxaucX9g43nP66iFrkn8ed7acUOQKuKJ1kROdnby5OR51wwK8xfB35fQEV91umCKgysOUaVsgS8rLSxiYBaf47kONEVLHg2Ds4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WAQAq5oZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WAQAq5oZ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e260d4dfc8aso517361276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Oct 2024 17:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728518856; x=1729123656; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJ1kKijNUBB3h6Uf74qin1j8xVsGkQayF3LcGNTjFTk=;
        b=WAQAq5oZCyO7hWacEC/7mn5ZacuSdg9Zig8nRvRxVjCNe+kV5vWwyZ97V32YrHAtco
         7u7M46azElih1JIlZjCf0QElMNBfUkmGpSARdm53RbmWoodudXDu26x03ILP4/aX3iBK
         LNQcdyzSYQt09X0wx96cp5s18GkIlnFRKbTKfcDi7KiIgcVDaBYcXSMpOI8BAQD/yYnc
         fj/DSQqWHcSGTCS6MxarP8e+Jb/D1sd+SbGW8VYGKfmTDxtTHDl8zCD6hQ/l31lISSzT
         YG5GFj7a2V1aes++oAuIHIo0e/scaqa0XpKkPnl3P3GPrx2oi0aLvfq2ON29aDEfQu0Y
         Exvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728518856; x=1729123656;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJ1kKijNUBB3h6Uf74qin1j8xVsGkQayF3LcGNTjFTk=;
        b=w/Cps8RpQRgvg5dra/O0uVo5TDe4iOgjzrT6jVwpe+2urnAtVWH+LtkslqpWmTRfhb
         SDRPC1Abf4HAdYal6C/qSi2YZufKih4SlapoVQcigDps2IXbVwhLXjxdxnEh72/ZnpYl
         NZCj+1EqqKiiggIbRiGyzklRAVRXXD88VuHjZTXFNKPNX+dSg04aI+FnZdqO8nP7WKbd
         9xxPw8YNRydJve2GQNMnSiGgHtaKjprOmu4PcBfDBv9TQzduhC6MrQZr9S4QOquH1WPF
         +sSnjYwTi8bwbbkRap1gr8+e5pJ6wDVXCCfwK8jCfCEnFshtmSbfo3qaZcK9LOdJH+ak
         n6TQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+8kdD98cYZCNR548+ojfBc+9lQ/kswhOPkkv7Q9qSfAVDszQXHfiplGfIaruCr2h3PH4M4Dr1C2VP5/cOLp0l@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1UOY57ZBiKNwCJ+a5C+6tls0HawjTVON0oEwUV6s/S/GXsJY5
	gz+WpqJNXA3W1JHGHBBja1D1qpM4gocZGwaqSHpBRMkxA7Pr7ugo86eYKdDrpT5+YDdsSDRVR1L
	7uWI/7A==
X-Google-Smtp-Source: AGHT+IHx3Ynu+Oqel4f9252US0nARFbYn+s9ow2CKxcLbOTRBCP4mRrAv5FdwoP4Z/8QfG07G6R8y1dmR4UQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6c8b:1170:a0ca:9d72])
 (user=irogers job=sendgmr) by 2002:a25:d30a:0:b0:e28:fe07:9cc1 with SMTP id
 3f1490d57ef6-e28fe4a3a81mr36274276.3.1728518855878; Wed, 09 Oct 2024 17:07:35
 -0700 (PDT)
Date: Wed,  9 Oct 2024 17:07:16 -0700
In-Reply-To: <20241010000719.1172854-1-irogers@google.com>
Message-Id: <20241010000719.1172854-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010000719.1172854-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 3/6] perf stat: Display "none" for NaN with metric only json
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Return earlier for an empty unit case. If snprintf of the fmt doesn't
produce digits between vals and ends, as happens with NaN, make the
value "none" as happens in print_metric_end.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 5402998881c4..e392ee5efb45 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -609,19 +609,22 @@ static void print_metric_only_json(struct perf_stat_config *config __maybe_unuse
 {
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
-	char buf[64], *vals, *ends;
+	char buf[64], *ends;
 	char tbuf[1024];
+	const char *vals;
 
 	if (!valid_only_metric(unit))
 		return;
 	unit = fixunit(tbuf, os->evsel, unit);
+	if (!unit[0])
+		return;
 	snprintf(buf, sizeof(buf), fmt ?: "", val);
-	ends = vals = skip_spaces(buf);
+	vals = ends = skip_spaces(buf);
 	while (isdigit(*ends) || *ends == '.')
 		ends++;
 	*ends = 0;
-	if (!unit[0] || !vals[0])
-		return;
+	if (!vals[0])
+		vals = "none";
 	fprintf(out, "%s\"%s\" : \"%s\"", os->first ? "" : ", ", unit, vals);
 	os->first = false;
 }
-- 
2.47.0.rc1.288.g06298d1525-goog

