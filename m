Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292E41B4F27
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Oct 2024 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085304; cv=none; b=hYMa2H/cbldwBkiYiDSx5Tns/O/AoUiu+bL6Yp0CXykfOTP0LQSTp9pdHbWPiwcpEJzT5ZIWnQw/qn718rnL5pliixSd3iSZAWTQlXXXpstcPe6ukI7jXWKCD9YIWJ4lgamkpPFmv5JR2i3eQPaVkuLwK3uxq/pBdMLSyDUl/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085304; c=relaxed/simple;
	bh=/EG7+O6Y5sI1sqJ9JCrlN0rHuPRE3RnaTN8M5JC+X/s=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=C3rPc5ADRpdSeZG4Y0h7tgoADvbBsEUwcQAta8sqHQmFS+pzrsSwy/69SrTrMV+TMK6MNJEUzt3qPiiINGzH/8WG/YGqKtVDayJNh6G71kpsz2SYl0OL0IWGioyQcebzgVh/wTGZQcN6rw8VTwaPLBh1P2STVFBBf5gGdN9naJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OK1547E9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OK1547E9"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2b049b64aso46323817b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Oct 2024 16:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728085302; x=1728690102; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Htru2Ya5IP3NbTe9LfBJEaUggdoz7+W4SDsNaFUqUv8=;
        b=OK1547E95ij7pBJQiVeOvbylIS5wdJ3gDamK+V9oHSZ9rsXDvm+vcanYufpFkD7TlY
         vN0T9syH7IfR1R9+WcchNtV/oXuPodZE1nD4SjUE8EJh6NZNiPNnaVqdwcC1n5nEzkhM
         lnMv5yE9+33Yi3z57ClA+Q7SMrOfB3vEl2WSQe1tNDFz66i7FN6GZKHTq/Z9o8L/ggEw
         Yd3nPe/zh58KB9kDzXh92HTLn6XaV05H2Km9Ru3VSdqOLAtaa+lkpLNh9/D3EBKg32bD
         emSznUT6EJ0EColU8b81O37g4qa5q0+LX1qC3z/KSW8UluU9ptNigAefstA6Sbfrrf5N
         HsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728085302; x=1728690102;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Htru2Ya5IP3NbTe9LfBJEaUggdoz7+W4SDsNaFUqUv8=;
        b=qiDg67GZ9l2reSPDm3a8Dg0CGfYDr6b5pEBptdEQJ7gZIwIjC3uI7AWK4vwiLbHoeA
         kRPSr9ySxhZeaekyzZ6BNq8ca0hU1e9dIyqwhyKlW3OkBaGfKLbFnBrvCDiajirFxtqA
         bGCvZXRr+Qzqukbqeq/jjfgA9VaEnC4HjJbr5vBP5OrNJGn6JChAjP1W+96RWTxsUrK7
         fpMhtF+f9EgSHxbK0Au3ziSSbbfWQ/AByPW21C8/EPdVYn5unRzTn2LhqnnQfX7cWggL
         y56M0Nd3JFrUWCAihWiWbcSn3BMnhXZzk7CO1m0J03NXNhLRXKw+Va918aZFN6fRjGTZ
         9ZuA==
X-Forwarded-Encrypted: i=1; AJvYcCXwJD0NYFMpfJyZmoZSXdsdLBhFMdKCU3SG3mqoUgUcDLeQ06c0I+VWVBVbjXQY7r8CIakDCbX1LlGewuuBrfzZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwWuOuRwZnIp+CtnF8lZcC/PNyX252AOHfn7j95Se4zYf+GRQUh
	GrSDoTQZvRll3Sr4NCCBjc1q1Lrwgsgc2ZeGEJQgTs996b8IdoGh5+xihwllT3MoOzxCqin+R0v
	oqKJ2NA==
X-Google-Smtp-Source: AGHT+IGn6EqBSWKYjPESqwVXd7FRY2h0IBlixSFdyZwjmp6nCTeyU5aGOeNbDZK2kjK0BzmIwzspzqBUa+VL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8d23:e3c7:679f:19df])
 (user=irogers job=sendgmr) by 2002:a05:690c:2d83:b0:6e0:1ad:b197 with SMTP id
 00721157ae682-6e2c728ffa8mr430617b3.3.1728085302109; Fri, 04 Oct 2024
 16:41:42 -0700 (PDT)
Date: Fri,  4 Oct 2024 16:41:20 -0700
In-Reply-To: <20241004234120.1495209-1-irogers@google.com>
Message-Id: <20241004234120.1495209-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004234120.1495209-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v1 8/8] perf stat: Disable metric thresholds for CSV/JSON
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
index 3e6b9f216e80..936800c01c72 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2560,6 +2560,14 @@ int cmd_stat(int argc, const char **argv)
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
2.47.0.rc0.187.ge670bccf7e-goog

