Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1788C259CBD
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779145923; cv=none; b=hJgS9NgToEimVLhA/1egwk1GkTxtCuMIEJdwt9ipEkbrLNn1fMesu73AkXm3mX20t8EOS3Y3Saqioq/N7TTJydZ6zkVg12U/znqM4DZx9liFttctfZk1klQxpQv8GAbGbSbioTfG8aBEjI7mw1qy5lRKH3v+1RdmhuRjS8/AfcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779145923; c=relaxed/simple;
	bh=37pWV75xwxCZRuxck3GG4Qk3pk7xQdd7WWjsZvdBp2o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KAhvsAuo8d1N9f6sSZ/bvJuIWeYYeTyZYz/FEyBZPAvIRMds81hNK5TGwdFk71KWIUleoDLnY72RUb6w3mxJac73XI9wbmNUXow+eNNZ4dRMibv+Q8Rxu+vaOsNh0rNbjjJeyCHral3kchChyLxwtLRkV7of/SS9+tVVmYBdR3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nCK7n5bU; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nCK7n5bU"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1353ac304f3so5202813c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 16:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779145921; x=1779750721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=484+LBDmFYyjmS1QZ8UO0N0Y8++tVhi0RvQ5mEJUoYc=;
        b=nCK7n5bUvY32m2yUpF82IbkPvcD2WEDSR0YqvuQEQ4wB5EXv23t1Hute0/CBibgmLI
         V09IKVzGxN+aV9Dwgn8uyaGKcb0Uh+Zq9UtSDw5hfSk0yq0vG8tGPApR4vl6ses8QiOp
         BFbAX3sOky56mLtJhWuWANXvCe6jXgdCWM2RirCwjrebur1VutJ/y7y/0+Xe9zKZXu/e
         uSjUAx+j1R0Qp8SoojRjmtnDVtrvo8/GeDdUn+Hchac/ufBotf1SebwZJ5WUdGIkXWbR
         XGOUElWCp2nU5AJm1zn7QCpM1x4XB0sexE9E09tyt7Mkp7y8qqYsdP3d0ZlLkc9gXwkc
         fDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779145921; x=1779750721;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=484+LBDmFYyjmS1QZ8UO0N0Y8++tVhi0RvQ5mEJUoYc=;
        b=Yu3HZnShtiNHlwuMQQze1EXMjF7jOUsLetYCZlA2tD1Dly/cEI+f1m3VinU61gKCyx
         ZLAAOw5RK1imjtB4CKxpf6op8WvNKnrzXBpXW7mMiP5iqsMwkLmjtE9HeAOymYaJlojx
         03tbde5v8kgHh4Bll1HyY7lAKwn876VH+WONzv8UjWPZjwFVtJddMHlfO8FpUDaiZ/FI
         jLO2UucoxkDYdDOZuHJFVgW5C5b1pJ20hnIhDqXuetqfYV2k7GCVQfywEqNlckZz/Pym
         9ZN/zR60ElroDzg8EG5VySRtVrNgMPtECRJlxz5lBOydlxXrgNSkLvLcet1GDzHUgpEz
         coPA==
X-Forwarded-Encrypted: i=1; AFNElJ/QcUgWfr2kOdsT4EaZQreeS0g4YNhw28YVwuYpombLhpC2QyO8LKE8u9+2zx5qpxYERP4jFucaPgH8ZCFdcSEF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy92tB5QpaE0en8L0dc4/TcHMtKMlXlwCmw5SFE36yX9vgLCYvi
	hcrIH2YkI9M05wBunbdtFbwgS8D7UrOtvUvyHgqDq5mbdZPcJ34Jcxc4w8+GERKgyqPulyVXOXu
	pleTCwg==
X-Received: from dlboy14.prod.google.com ([2002:a05:7022:128e:b0:12d:bf5c:266])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:505:b0:128:d7a7:5271
 with SMTP id a92af1059eb24-1350483f3b9mr7134341c88.28.1779145920806; Mon, 18
 May 2026 16:12:00 -0700 (PDT)
Date: Mon, 18 May 2026 16:11:30 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260518231150.1252420-1-ctshao@google.com>
Subject: [PATCH] perf stat: Fix uncore metric scaling bug across sockets and nodes
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, yang.lee@linux.alibaba.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In multi-socket or Sub-NUMA Clustering (SNC) configurations, uncore
metrics (such as lpm_miss_lat) calculate incorrect values because they
divide by a static socket CHA count rather than the aggregation target.

Fix this by dynamically utilizing the aggregation count (`aggr->nr`) on
the metric's leader event. In standard aggregation modes, `aggr->nr` is
already automatically populated with the correct number of active
hardware units contributing to that stats bucket.

Before the fix:
  perf stat -M lpm_miss_lat --per-socket --metric-only -a -j -- sleep 1
  {"socket" : "S0", "counters" : 28, "ns  lpm_miss_lat_rem" : "163.4", "ns  lpm_miss_lat_loc" : "27.5"}
  {"socket" : "S1", "counters" : 28, "ns  lpm_miss_lat_rem" : "170.5", "ns  lpm_miss_lat_loc" : "25.5"}
  perf stat -M lpm_miss_lat --metric-only -a -j -- sleep 1
  {"ns  lpm_miss_lat_rem" : "90.4", "ns  lpm_miss_lat_loc" : "12.6"}
`lpm_miss_lat` on global aggr is 0.5x the actual value.

After the fix:
  perf stat -M lpm_miss_lat --per-socket --metric-only -a -j -- sleep 1
  {"socket" : "S0", "counters" : 28, "ns  lpm_miss_lat_rem" : "174.8", "ns  lpm_miss_lat_loc" : "34.8"}
  {"socket" : "S1", "counters" : 28, "ns  lpm_miss_lat_rem" : "170.4", "ns  lpm_miss_lat_loc" : "23.9"}
  perf stat -M lpm_miss_lat --metric-only -a -j -- sleep 1
  {"ns  lpm_miss_lat_rem" : "174.5", "ns  lpm_miss_lat_loc" : "26.2"}

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/util/stat-shadow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index bc2d44df7baf..60fdf26c5bb0 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -103,7 +103,7 @@ static int prepare_metric(struct perf_stat_config *config,
 					val *= 1e-9;
 				}
 				if (!source_count)
-					source_count = evsel__source_count(metric_events[i]);
+					source_count = aggr->nr;
 			}
 		}
 		n = strdup(evsel__metric_id(metric_events[i]));
-- 
2.54.0.746.g67dd491aae-goog

