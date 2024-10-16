Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E68216A13
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101254; cv=none; b=Wy9wjyQx+OR/sYMm8RLp2cQ6+sZsAtZGEo6wlA3kM0tG5MxuUGc+1AnoZ0jfEsiCWoX2AxB1hB1gX3EL2BXCcKG/9f4sr1HQ5cDFYwQZA4lWHF4aCgyOJTl9GHZgu14+Eee9iyJk6xAnTh3dC9k47sLhACMOxGu4YfEHL3oJZLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101254; c=relaxed/simple;
	bh=fee7TAq/eP5tzXna+g+K/Sx9L8xSc4L9m1SCV2eHqNc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hed/04vo+HjNOT+0oAAS2REuRxJuBvMCyUHzftkuIzWhUn0Go2WR9FzH9DKrKSWEFj9gNBcAPmCulqQw3ohCHijbZNtaiaBmg6MN0CSUWgqMrgXNL0LkDBGyMcOlOLo0+4P438odZME4E55wM2y7RMUrmo5eTjJvBA1g4ZR1hAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yxf9k3vJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yxf9k3vJ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28edea9af6so85144276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 10:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729101252; x=1729706052; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vsMWssyTOvP1WMheCN0DpJ+nfzBtD5CMizHYReN/aDk=;
        b=yxf9k3vJeI89kk2mvr1QoC68znsICyXQbdgq4uYwVWntBuvmuJFvi0LrAfQhlB9aCa
         Xa1+qB1UeFMsfRykBb8jq0vnFBFp9T7VDKxOk67ZvwGMx51XYfflJKeIh6YZ90JyLuBt
         tJX38ulotvqeL3gRkDWkg+gVM8ObLXXQ+hkEeoHF2R5vrtNRuHOEz4FqO7eF3Em08KPc
         fArljDBAiqF0Ce89RFkms11f2fisiYnIUbddwEt5naQw5NzpGWmFf7wwwgn4aQR57d1e
         2KAsBRRyVsr2tpNui2GVSrbZvjccyDROog2xgY12XMtFAs9PuyVbtT9EBEIJRPJQy9Nr
         O8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729101252; x=1729706052;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vsMWssyTOvP1WMheCN0DpJ+nfzBtD5CMizHYReN/aDk=;
        b=c/Rx5WREnbHKDtLklA7HpF5W5YYPQ2IbMNI+DXOd6rr1TFqa0jnZ5De+rjSiwGhdWS
         vj8CgNlSSm+rfrBVzHTHZSE5Wc/S36zJ8hWHflpEBb0nSoNcZpYQ+wBh/Gt5J19fCVyo
         ovu8Mp5qg5tR+napMCUWQL3HHMBBJ0UbgRnovTdEaCVLi6EJkm3cOIavFryKYq7r+0O3
         48JcsQ7NwLY4BtPN/gyyTynhv9jcLLIBK/yLE9MgD3Y3QcA5YfnSOghEC5XKqcY8SYqD
         R2yodyFUYweXYPBeh7NY59NVWHdu9TY6Jx9O5AHmASCgeySl5x4xAWJwczMx7qj3CPq2
         qX7w==
X-Forwarded-Encrypted: i=1; AJvYcCWg7ckE2AUauP0Rebi+PJf7qalWVwQASp0QF6hbIXbxFrTA0CkGG3jLWG+vhGASMPbyf3fU6d26cfUVi4B8bUgD@vger.kernel.org
X-Gm-Message-State: AOJu0YwmhDyBMM29H49ZLe/aSPYBKRH6cMA2+LyXAuQbqWs3GfvLfeYn
	5TFtbNNZ6KNS+fyk1IYsv4Oc/4fQVSbGtYwjaYN9Yo+kfkbBYGRQ7EFOUjICU/UuaOXm0yn3Aqz
	gXLE95g==
X-Google-Smtp-Source: AGHT+IGwzJ8F80Se119mAueQ7bqO735E4nJLUizxWDlBOxLr87KBzIrWBt25r2jhZ9ZswgpsimkIQAxCJR04
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:a2c4:0:b0:e25:caa3:9c2e with SMTP id
 3f1490d57ef6-e297858905emr5272276.11.1729101251943; Wed, 16 Oct 2024 10:54:11
 -0700 (PDT)
Date: Wed, 16 Oct 2024 10:53:50 -0700
In-Reply-To: <20241016175350.116227-1-irogers@google.com>
Message-Id: <20241016175350.116227-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016175350.116227-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 8/8] perf stat: Disable metric thresholds for CSV/JSON
 metric-only mode
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

These modes don't use the threshold, so don't compute it saving time
and potentially reducing events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b5e18853982c..60d747c2e0e3 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2561,6 +2561,14 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
+	if (stat_config.metric_only && (stat_config.csv_output || stat_config.json_output)) {
+		/*
+		 * Current metric-only CSV and JSON output doesn't display the
+		 * metric threshold so don't compute it.
+		 */
+		stat_config.metric_no_threshold = true;
+	}
+
 	if (stat_config.walltime_run_table && stat_config.run_count <= 1) {
 		fprintf(stderr, "--table is only supported with -r\n");
 		parse_options_usage(stat_usage, stat_options, "r", 1);
-- 
2.47.0.105.g07ac214952-goog

