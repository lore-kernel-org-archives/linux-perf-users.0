Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF870243951
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Jul 2025 21:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097241; cv=none; b=jOG5NV9ec/cwPNn0xOFU9jRAjNBARwcv+OXmAfHxgBBaIaS2RrC1pEBEGpZ6FoK+XAqMFn2FiNwgL9LLSsgp0CfDSG08I2PsLO8EE4PkJK96F+LK9TNV9h5P+12/gG1xDqA5rh1/jsiRzzMBtBOJvJBv1PM8AHY042m9l8aOKRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097241; c=relaxed/simple;
	bh=SCSVRXj5DB/cfKYLIvAW2+qqqcd9DzSoDst4X0cpuZc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HVAOu3c+dTQkGXb9KK4kM939HSe3giVmCRKmtwQXXNPVe2pmDptopJtnkmJ4IHfVp2hdYarFb5P2uVZfMGTQGooGP0Nm6fJ9l1c9WCOqwikm/a5iDEJpZFMTs4CnLK7Z3rhDUDMd4OeMJFpPVOajDIGSOXzWJ+/fpAjxLi2EW2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SmK7oVt9; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SmK7oVt9"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b31cc625817so1154506a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jul 2025 14:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097237; x=1752702037; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uM9b0q174RElAGAUOsRC1+X9nDdEI4t5lPgRji4c5mk=;
        b=SmK7oVt9XOHbt+8Iu3CuSN4KVNBp9Lfqh1n+AKXwDqT4YSBTQH5cNQuV0MNVNbUaT7
         j1TY7YTtPlK3R3xxI2y5mRMVZkzb36amtCJBybo3IJeBikCOjR1cE449zxJn2BKweEeB
         cYtyb1cKBIAxeP6GCDdDYXWwsbQ95scp2kceXjZFbpv876YI7HRqmjPbX0I/ot9Ti/K9
         GBFhLiti7lIo2x321LCgku81wu+Tsczj+oSPKNMK5KsYpHYrMN6zxPgiXITUX/xleaJC
         j17MDKhwG1EA1URQJbXo8L8hLkRx0QKuq9sM+4N0oE+sbvKfNgnhm2uEyVb3Tks3q0b2
         FXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097237; x=1752702037;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uM9b0q174RElAGAUOsRC1+X9nDdEI4t5lPgRji4c5mk=;
        b=cU2Mxp3djznP8/v3VcEUUAY28B2a2Vb/q8cZAaCQZL7S1+1exSZPIY+8RMJSYLZf4Z
         nLVYsCili4MZKQTryuEMzBsTMBCl1QwsPTGMyHoG0XRDiEyMzYj6YByR3Ss/ayohFLSX
         tNWcP5o9BK4EgTTbPDv7VkscjMb2eY8AMmcNqh5D/pwOcrFQIyxfL+jn1Lq0hzehdOuG
         6rAwpcMeqGvr42umfSctQkoDBDXe/owcT/2+txXUcHnNsgvNVNSpt2G7mOoiH+/EOHro
         RlJfkGBb7VMjn8wf52kgMro/T2DhbPTdNro6FNmEBnksJBqNjwLPJo+Iq+bRyPH4hDSv
         z/2w==
X-Forwarded-Encrypted: i=1; AJvYcCU3Ekco5ey/oS2TRgy0vq71O3gwHc75a1yy+ONRcMUwDmFwVrf/DagrIQBBEzy+CrCpQCbvhzMcX2Ts4wswLyP3@vger.kernel.org
X-Gm-Message-State: AOJu0YxFoE8JfcEQ/ccbRAwdaAlu6PXYHSNOnML0XnJ8d+JguZOs+iuK
	8uDJIc8+C60pIPpKNRYXX87GNKBBo0kKrN1vv4/GGGw6enipdWbDB5D8NQviyy31UF0GSe/3fJC
	8D8mdjgkBqg==
X-Google-Smtp-Source: AGHT+IFltfmQBS7U87C0TdDrtf1ntKrR6/OIw7n3Wyza61DuU6qTE108cX1iKXZNifSy30Gaf+LTVp5Ftm1u
X-Received: from pjqq12.prod.google.com ([2002:a17:90b:584c:b0:314:3438:8e79])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d40c:b0:313:d361:73d7
 with SMTP id 98e67ed59e1d1-31c3cf9aaffmr1475713a91.13.1752097237503; Wed, 09
 Jul 2025 14:40:37 -0700 (PDT)
Date: Wed,  9 Jul 2025 14:40:19 -0700
In-Reply-To: <20250709214029.1769089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709214029.1769089-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709214029.1769089-3-irogers@google.com>
Subject: [PATCH v1 02/12] perf parse-events: Minor tidy up of event_type helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add missing breakpoint and raw types. Avoid a switch, just use a
lookup array. Switch the type to unsigned to avoid checking negative
values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 31 +++++++++++++------------------
 tools/perf/util/parse-events.h |  2 +-
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 4cd64ffa4fcd..a59ae5ca0f89 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -135,26 +135,21 @@ const struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
 	},
 };
 
-const char *event_type(int type)
-{
-	switch (type) {
-	case PERF_TYPE_HARDWARE:
-		return "hardware";
-
-	case PERF_TYPE_SOFTWARE:
-		return "software";
-
-	case PERF_TYPE_TRACEPOINT:
-		return "tracepoint";
-
-	case PERF_TYPE_HW_CACHE:
-		return "hardware-cache";
+static const char *const event_types[] = {
+	[PERF_TYPE_HARDWARE]	= "hardware",
+	[PERF_TYPE_SOFTWARE]	= "software",
+	[PERF_TYPE_TRACEPOINT]	= "tracepoint",
+	[PERF_TYPE_HW_CACHE]	= "hardware-cache",
+	[PERF_TYPE_RAW]		= "raw",
+	[PERF_TYPE_BREAKPOINT]	= "breakpoint",
+};
 
-	default:
-		break;
-	}
+const char *event_type(size_t type)
+{
+	if (type >= PERF_TYPE_MAX)
+		return "unknown";
 
-	return "unknown";
+	return event_types[type];
 }
 
 static char *get_config_str(const struct parse_events_terms *head_terms,
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 1c20ed0879aa..b47bf2810112 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -21,7 +21,7 @@ struct option;
 struct perf_pmu;
 struct strbuf;
 
-const char *event_type(int type);
+const char *event_type(size_t type);
 
 /* Arguments encoded in opt->value. */
 struct parse_events_option_args {
-- 
2.50.0.727.gbf7dc18ff4-goog

