Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D664A3C
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 00:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751069379; cv=none; b=OubRZn/2xRkpIyNlJbbu4FaRU4jt5a5/XN6dosquADsoM+GSUMBvU6hJNwwNTR5My5c+8IClSW59wPy8tIeaUGaadHbE0UG66xobSeM2fKD/eOWXJkS14lyEkEIr+qiS5Dt8j/jAmRMSYjwbW7oB8+mks3V4PcT8isOqcz3wQ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751069379; c=relaxed/simple;
	bh=2GC+gz3NU/TsQzR0IgAKnBmtJMBkRxMKJ10VQOb4VUE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NkBo7V5CDbGfWEnD+Z5K4YhcXBkTV06EZXLw96PmDkKltorURLrWUiqKV5eBubvt1cbF14UOTSQV3WzL7NK1fyOVZFD0R1pWRVdlSS/ddsHc+PW+szHhkV1llVzdQDmqIn+32kulJBEwFMzUjuB6gA0RHevZs3tSzzwVaIwwAno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IznjzVJb; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IznjzVJb"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3183193374so364238a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 17:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751069375; x=1751674175; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FeoLfxu6vl8iu0oh1ON8hijy8JrvEUox5uGVMnB9N0M=;
        b=IznjzVJb+I52tkmfFQVjuywt0wWpMz/91DTviwaAVxrbsFEfczg0gpTzJnBcaf8YN7
         X+P0OuiGI4K0ZtKLsMukwgE8I1pzPl4Qw96XeCNTJulgUHhd3yZIKUu0onfuU2ysVk41
         epcE/vYRJoCJBBOfQ3pJ63C+nRXbaP086r1sToOUL+HX7mhzZwENmaYE8LtjlqqByqF3
         IPqPeI963weO62ju0sMiW52y5lVVUALw2hb2Ggd9LzDwJFUWxDxJyga5vMREslQYBhKB
         JPyU6NLkrH8ATrZGENOt2OzcHUwr1OZVaXNfBCsecaMsyPfo6Q102PAEK7aEj9sl22+5
         nKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751069375; x=1751674175;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FeoLfxu6vl8iu0oh1ON8hijy8JrvEUox5uGVMnB9N0M=;
        b=nybgTA6nXjw+AdOtz0/PYP6iKhfxB4XYIkQ0IpOzFWFcIZZ27E+TrMvpJp/4cLdfTl
         1H0PgOX05wKfCMnESkFtbDzznHHv/pnGNfeR8BWawKKnFYwWSKqz3ukn79HFgIjU8OVu
         r2fnaxYEsQWB99VnzKK3bxeq5r9JpU44kHOpz3y1qdjaZdVLse6mR/63QRm5sVznUQoq
         2elZQFSpgn+eS6YAYpceB56RLpEtUXoTF+YZlMGgPywvV60pIe9hw/S64a8Dd+53ksd5
         KoXa2xn9jZfi1xv6NT/BuEsUKa6gJqBKLL0dmtjy2o2g6KKM1gnHNu/rcyohYSbRyM+9
         GQJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWcQcBwkB38csWCGIiPI0eROlVSZ5Z8Xs8tmuS6hj8XlssLCh1dI1RjMjb9Mu1+6Qo9wvzZ9/+0M8qQ3UIH+bN@vger.kernel.org
X-Gm-Message-State: AOJu0YwsXPVQDmQ1SqP922tUv6n0uB3O1AsbuqdigxBb/1BwrAlTZxz7
	42Pt6U2og1Ww1N2j3JKcL9oow8Pafp51+L5zo0gqk14jv5s03wMiQCfrIgoi6YS7/+MrguEqURE
	ui1d1fDlLhg==
X-Google-Smtp-Source: AGHT+IHjF3eVZ4rb+9Jd0Y0bCQYcJEukiIKzVekz1mGzbrQ6INpOqjJFImlq0ucLFt1Eu8t6Qi1Is8EUx6zl
X-Received: from pjn8.prod.google.com ([2002:a17:90b:5708:b0:312:151d:c818])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a67:b0:234:8a4a:adac
 with SMTP id d9443c01a7336-23ac3afda4emr57508945ad.20.1751069375191; Fri, 27
 Jun 2025 17:09:35 -0700 (PDT)
Date: Fri, 27 Jun 2025 17:09:15 -0700
In-Reply-To: <20250628000929.230406-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628000929.230406-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628000929.230406-2-irogers@google.com>
Subject: [PATCH v4 01/15] perf hwmon_pmu: Avoid shortening hwmon PMU name
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Long names like ucsi_source_psy_USBC000:001 when prefixed with hwmon_
exceed the buffer size and the last digit is lost. This causes
confusion with similar names like ucsi_source_psy_USBC000:002. Extend
the buffer size to avoid this.

Fixes: 53cc0b351ec9 ("perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hwmon_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index c25e7296f1c1..75683c543994 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -344,7 +344,7 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 
 struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, int hwmon_dir, const char *sysfs_name, const char *name)
 {
-	char buf[32];
+	char buf[64];
 	struct hwmon_pmu *hwm;
 	__u32 type = PERF_PMU_TYPE_HWMON_START + strtoul(sysfs_name + 5, NULL, 10);
 
-- 
2.50.0.727.gbf7dc18ff4-goog

