Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DC82309B2
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786164; cv=none; b=eOzSLrK9NTYLAq+Fi8TbXVpwkNvTnsBvaKPo+WIdG2ForBKuxA5bKFqaQ4PO1iyDLWUe179SdSYR+4RyW0w5dxzwMZeg8J3uGHTjfPFSjV6gPJXc/gs/ZELDnBjm6ed3GTRNA4pZdn/ea6S9+pmkLRd6KEzz1I+vG5LRh0NTZxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786164; c=relaxed/simple;
	bh=zejmlYNwgS/OQpMHacoEnWFRqhftHB8onU2Qvy6vpsU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qTjSqSiQZbOPut/LSrAxxkAWB3ughdgsqMfwiDdLoeAPnDwb12oBv1f/v+tl7HiPXpGncF/HaD9xHqmRIteKeQMqAMqel33GcuKQa3GgiAsKX/dSZq/q2XcZ5BW9AziBmF5ZzA7ZccNQuEwZ4FC4j/Ewdww+ynPGGYRqgsXJDOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j9ilSaMP; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9ilSaMP"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2eb887a2109so1427255fac.2
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 14:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752786162; x=1753390962; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5dVZGHVi7sQRXRzVKkfTNIiUhn/WdB0GHZb62bnQe1c=;
        b=j9ilSaMPRHB+DZzYb/SMuDIF0UULb6BkWSNUdI+EdT8bPPRKWBXvNbWvzPTCava9C4
         QNWUtVeR7De9Ve/ymmBjvyicp6SLLYSidVcz4SH+HtBAFxO8fK9ubvn3n0b7bZ5D70oU
         o6d0dw6jYk9xsQ4AcBWeoMx9cXuILOulqrARA/3K/krD8eNDFhxwaKd0bzmCnUjbK82u
         Q+SmIvGfWkXi85+SPqnQBjykb+7m4xm9NXwScZ4XdIcQwX3BZb16J4ZoSheQnY2ahtbR
         uNdm5UeRXMkjhM6wuzngNJ1A451VztnwfAe0w0GJt0kYSNZAGd+Qxl6zvON+d4vVT9ob
         sQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752786162; x=1753390962;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dVZGHVi7sQRXRzVKkfTNIiUhn/WdB0GHZb62bnQe1c=;
        b=tqSpkz5sz/Q2OEjscW+ESJLoB9gTz+U1CO+Y3RwTfPgBySknb/XSJ/+EWWyS3XWjg0
         fGmYmAEv/URSPr8Fwb8PL/yxEeOZmrzaO+L2WrbnC520R+6z5LIplegcKTINJxnsrBK9
         aoiZ+aohLim+x1xuOoQvILl9MAtzGOO2IFsRCpCsU3WqopE2AoXPs9FEvl3RGPkkIIIK
         cPIoVEYsL50Zd52opBOQ4ne8/jCICH6r7n53VGGAej5gfHL7THnYB0U9GRqGTkrKx8pH
         ueu5ySbaeYx7NNwDNg7r+qs8hSZ/xKHcvySDO3paUHLkkUU6Dy9ZA/wUrPZMNlgoXdFl
         8+KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJYWPtzsoKerId0R8F3mMX5Gtap+b87z3Ip0PGqfXS230NjSKHsyYpDD8KkprYmiP5tcxntW/DnPBC4pQ5QouV@vger.kernel.org
X-Gm-Message-State: AOJu0YzjCfEhdTp8A61B7iP6hnyZt1uQCOBcwqNkPNutinkSC1874Yeh
	1ZBZ7MeZWH7rVB+TQ6I8coQi48Y42aHbAHlL8/wPX+Tz+jeenTcUYXfgcmdd4XrQ1KhTUG6pF1Q
	1D3hZF116/Q==
X-Google-Smtp-Source: AGHT+IEf3wLginiuFgPMj/KhLeA3Fl3A4TQMyoFRYUZgHRewuT2Nl/mXUfU8dUFzGBWTIush9hwAag7yKgmI
X-Received: from oabna16.prod.google.com ([2002:a05:6870:6c10:b0:2b8:e735:4798])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:3048:b0:2d5:2955:aa58
 with SMTP id 586e51a60fabf-2ffb1eafd4amr5810811fac.0.1752786161596; Thu, 17
 Jul 2025 14:02:41 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:02:23 -0700
In-Reply-To: <20250717210233.1143622-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717210233.1143622-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717210233.1143622-3-irogers@google.com>
Subject: [PATCH v2 02/12] perf stat: Avoid buffer overflow to the aggregation map
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

CPUs may be created and passed to perf_stat__get_aggr (via
config->aggr_get_id), such as in the stat display
should_skip_zero_counter. There may be no such aggr_id, for example,
if running with a thread. Add a missing bound check and just create
IDs for these cases.

Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 77e2248fa7fc..73b4521ab8af 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1365,7 +1365,7 @@ static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
 	struct aggr_cpu_id id;
 
 	/* per-process mode - should use global aggr mode */
-	if (cpu.cpu == -1)
+	if (cpu.cpu == -1 || cpu.cpu >= config->cpus_aggr_map->nr)
 		return get_id(config, cpu);
 
 	if (aggr_cpu_id__is_empty(&config->cpus_aggr_map->map[cpu.cpu]))
-- 
2.50.0.727.gbf7dc18ff4-goog

