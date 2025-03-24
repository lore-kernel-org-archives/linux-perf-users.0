Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F441F4176
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855722; cv=none; b=RpS+KWagJrnw4svvYBjCZaGGkxP1U7lCiB9/87CALiSy978S4Mt5gDnLNTg7FArcy14E/AhUGebra3HV1USc+E5jzrY3semBgPBWK7ono7/k5hp4cB/NOYyTn0rE/WR7/ws35THpaaNEujErlAZ1I25g1QhP61cFsdcQzhhj9OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855722; c=relaxed/simple;
	bh=01JMQWMyaAKM/J1u47irZKwxTPCpRuPzr2nvkfArrYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PKH61qPzK/t/NFQBOWNA32FHx5Jtcpqb3P21TKbamnMVhCirTDl60dq0UGyi4QCs7qtJScvSrhVBFCoy4qqB/ncCVmx5sJnl9DwBZXPym+fXVNSO/vaRBBb+zeutJzO5FsAfEi/4IZxLw1bKSA2MKV85mBcyt0UXWxnD02r9h+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XNsscKms; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XNsscKms"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff55176edcso8254528a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 15:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742855720; x=1743460520; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0wcJAbivJu1k/AjUyHUQjxQAmzqPSg8uRDSrH0bdtXw=;
        b=XNsscKmsxoRA9fj12uz3rKXeiyoVNYrUF6aZ4+uvwkOUuiXQ4tXqfa4TH66utJLfnQ
         UfPfht5nuBYJTEqnU9q6QDEV5PUyBaFr5O4oMQnaVLgzBghJnpQ9Zx1lf9R6rFi/GC2U
         s84O9MN5HBRlo7GC3mexmodsni4HT7hOQILcdXfhl2F0P1AnyGYFVFDaVLz8FY1FDSx+
         ZwYtSH3S1lRcZsC3EEdeggVI5VDgtb8JQ50X3jd7uql3/hpPIGOkb6fjjc7GDOFcbW5n
         zh47rixcBjLmeOi07uqOEw9FKN7WB1rZba+8bEmIrB6BPuFNftEhlR8MQQCskPdVxXNr
         YMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855720; x=1743460520;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wcJAbivJu1k/AjUyHUQjxQAmzqPSg8uRDSrH0bdtXw=;
        b=POZupK7Hd3xRpBDS8OcTfgQXOtbOcN+uHFU3Wp1t54lUc82Ib01TlwTok/XC+4lScO
         WwAyeZ5mcao+NTOVT5z8k8BkShcm1susiYeDARbaexN474r5AfMJXtNBXEZSlRRRLiYd
         uoyyQu0q+gVAOyOvfVKoHwOQp1UQJ+TTEine+C+0BfHTs9LSOQZHxR6NRCMUQejdZYBS
         75bb6vUaGksZWa49crKAhD0sEhikz7XWp6/SaOvIND/YHWV4ol1XP6zGjBmRDRRXDrfH
         LTS2le/O+XZTK5lY/UTJuKVNEFy/W6yIwn3+t/THnjtIPBR6KJkdIpmSm1UUVX5DuznN
         z70Q==
X-Forwarded-Encrypted: i=1; AJvYcCXl4lchr1TJyi6/iSz/CwcFYXyYGF9G5CNubCCWIaVtaJQCl1Clc2IYpTKQM8SiWdHuWS2+eJN56AoRrePh5li5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6E8y6QvIj02iSWZ37D8qoLyFZKKNiJxHYeosoe5EY29VhCMkA
	/4RiKErh4hS/hOL2VfdoCIlA5xjn+gFMbX70axFiiTLcDXThjhdMQqPPJJEBo9nsTY1JSZPxExk
	vN8DxuA==
X-Google-Smtp-Source: AGHT+IFYuCJ9A2bIFu0gRLO3Foa6xQQF8TLQYdnDE54OfHdgTTAnAgbtY0BgiO0AmrNp+D7M4pcI1WvbmHID
X-Received: from pgbdp8.prod.google.com ([2002:a05:6a02:f08:b0:adf:4827:b70e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4d8b:b0:1f3:194b:30ae
 with SMTP id adf61e73a8af0-1fe42f090d1mr23333406637.1.1742855720436; Mon, 24
 Mar 2025 15:35:20 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:34:50 -0700
In-Reply-To: <20250324223452.208081-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324223452.208081-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324223452.208081-13-irogers@google.com>
Subject: [PATCH v1 12/14] perf intel-tpebs: Use stats for retirement latency statistics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

struct stats provides access to mean, min and max. It also provides
uniformity with statistics code used elsewhere in perf.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 4d51dc8f74ea..0def3419b1e5 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -18,6 +18,7 @@
 #include "evsel.h"
 #include "mutex.h"
 #include "session.h"
+#include "stat.h"
 #include "tool.h"
 #include "cpumap.h"
 #include "metricgroup.h"
@@ -41,12 +42,8 @@ struct tpebs_retire_lat {
 	struct evsel *evsel;
 	/** @event: Event passed to perf record. */
 	char *event;
-	/* Count of retire_latency values found in sample data */
-	size_t count;
-	/* Sum of all the retire_latency values in sample data */
-	int sum;
-	/* Average of retire_latency, val = sum / count */
-	double val;
+	/** @stats: Recorded retirement latency stats. */
+	struct stats stats;
 	/* Has the event been sent to perf record? */
 	bool started;
 };
@@ -144,9 +141,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	 * latency value will be used. Save the number of samples and the sum of
 	 * retire latency value for each event.
 	 */
-	t->count += 1;
-	t->sum += sample->retire_lat;
-	t->val = (double) t->sum / t->count;
+	update_stats(&t->stats, sample->retire_lat);
 	mutex_unlock(tpebs_mtx_get());
 	return 0;
 }
@@ -516,7 +511,7 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
 			return ret;
 		mutex_lock(tpebs_mtx_get());
 	}
-	val = rint(t->val);
+	val = rint(t->stats.mean);
 	mutex_unlock(tpebs_mtx_get());
 
 	if (old_count) {
-- 
2.49.0.395.g12beb8f557-goog

