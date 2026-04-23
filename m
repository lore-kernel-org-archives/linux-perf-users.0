Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06FE386567
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960627; cv=none; b=asrD/nV0TlOMoDViGgOD0UYccU2JkxJkeVtQXljT5iTl3cQkgVokS/lUqQExkeveZlHMQjwxdu1s+0KnFrvcJ4adyhh8XJxdmMyE6MCdk2YPq0iyYwOUxJmaY+fp1z7dWGeJGEOB3/J9ibjREpQHxGWy2C4WMdExNT89UKSVH2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960627; c=relaxed/simple;
	bh=9QVIDwFrRipr23FnuY9aTJD6UPXAMm6bbw3zj19BRdQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZCiBIh8kxbkrOb0Tc8bAEBIUXG5paVVDD0rsKfGHT6hgRhw4SotQ0yWZSaJ09i8ui/BJqjuSqtSeRmWqHFG+3+pGEzUN6E99vRW/9U8GXm4oxZfxNfV8PEefezcHclnOp2Lvn2ay9TdZ9iwpSffbG7MAbzy54RTPZo9KpeOk47Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pApeDFdx; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pApeDFdx"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d9da2559aeso17525724eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960624; x=1777565424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NWeBiWGpevte4iUvIVtyBuQo4qdnnAREZFJd51szFgM=;
        b=pApeDFdxm+BXQj9YC8UL2q7vockc3mFFUgmjKVSXp4hWcizKAZlYPLG0dVrxmBw9xL
         WjmTwNGFGXJy4VrmY4IjN39BQPHDD3szjSMxWGIWU3jmPpi9u3QhM4UE34uPrutxY4h6
         Igxvoo+JOrnzF5/PY1Q5/f45GmI2bqd4F6piAI5N0LeNk6OHrNVHqqPgbRxntxnGGM2I
         ZCvAUbz0ayuDPsWKy/wRTSlfFXGiwP3DxT1cC/QwR4nYrZbX6E5nzqV6iV4Csm8yaCgf
         DPpZ5uJsR7vTuPPSW990fHEYhDp3TZ/0bzxv6nn0EZhjUszwpDDz19VNjfZc5QoOf1vg
         3+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960624; x=1777565424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWeBiWGpevte4iUvIVtyBuQo4qdnnAREZFJd51szFgM=;
        b=pQJZqV9qPDu2XsVaLuTHSuHjRLCYzht36mZnsJ4Ny3oUJm8HV8j7gdqSh3nnWh5gfQ
         laxjcSUGDa2Ed3ecDzCiUSSNBC3K1TfMFAHzfxhgTgSrvYf5vtmkvxQf6T2c+OFjHMKv
         bPhKKHuLg6r6gX0eg23psBZ4B4ZCVbyF8m80o7IRYKKmb4O+1HtwfkqlM8y2CyhKoPV3
         UpSJrJIYSUPNRclbnacFqnLySRzc7/Pbagkp/9UyOs60/Y6k0m2YmKECZzXD1F36ucaI
         aKnykH+qCHhhxFeiKhOCOzYwEhPZHxOBrD69BSfA4LMx+iLLS3kqe84UbeFG5wxhlxIN
         Nt0g==
X-Forwarded-Encrypted: i=1; AFNElJ9D0f7T+AqWWhxhKLzMLxX7Yy4vSnGEc8dO4gng81CQSb8wHJlLZKVkMoW79V0h61CxPA0t0CJH63UsJ349Z/fl@vger.kernel.org
X-Gm-Message-State: AOJu0YxBQ9Mdb5D2oPIVXPyWQPGkdO4hyP7bMYBu/XsIE6TBY3/5uL1b
	tR2XVb2SiznNQIFTFax9h5+vfXTfreGbVGZXjqpdzbVUTuARHW46uiesLt9OO4RJIWQOcwWs8hX
	Hy9GPUIsxLA==
X-Received: from dybuz22.prod.google.com ([2002:a05:7301:5096:b0:2df:70c6:196b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:1351:b0:2da:4216:7ea3
 with SMTP id 5a478bee46e88-2e478a2f09dmr14789810eec.14.1776960623537; Thu, 23
 Apr 2026 09:10:23 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:14 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-8-irogers@google.com>
Subject: [PATCH v3 07/58] perf evsel/evlist: Avoid unnecessary #includes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
Content-Type: text/plain; charset="UTF-8"

Use forward declarations and remove unnecessary #includes in
evsel.h. Sort the forward declarations in evsel.h and evlist.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.h | 15 +++++++++------
 tools/perf/util/evsel.h  | 20 +++++++++++---------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index e507f5f20ef6..e54761c670b6 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -2,29 +2,32 @@
 #ifndef __PERF_EVLIST_H
 #define __PERF_EVLIST_H 1
 
+#include <signal.h>
+
 #include <linux/compiler.h>
 #include <linux/kernel.h>
-#include <linux/refcount.h>
 #include <linux/list.h>
+#include <linux/refcount.h>
+#include <pthread.h>
+#include <unistd.h>
+
 #include <api/fd/array.h>
 #include <internal/evlist.h>
 #include <internal/evsel.h>
 #include <perf/evlist.h>
+
 #include "affinity.h"
 #include "events_stats.h"
 #include "evsel.h"
 #include "rblist.h"
-#include <pthread.h>
-#include <signal.h>
-#include <unistd.h>
 
-struct pollfd;
-struct thread_map;
 struct perf_cpu_map;
 struct perf_stat_config;
+struct pollfd;
 struct record_opts;
 struct strbuf;
 struct target;
+struct thread_map;
 
 /*
  * State machine of bkw_mmap_state:
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 339b5c08a33d..b099c8e5dd86 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -2,28 +2,30 @@
 #ifndef __PERF_EVSEL_H
 #define __PERF_EVSEL_H 1
 
-#include <linux/list.h>
 #include <stdbool.h>
-#include <sys/types.h>
+
+#include <linux/list.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
+#include <sys/types.h>
+
 #include <internal/evsel.h>
 #include <perf/evsel.h>
+
 #include "symbol_conf.h"
-#include "pmus.h"
-#include "pmu.h"
 
+struct bperf_follower_bpf;
+struct bperf_leader_bpf;
+struct bpf_counter_ops;
 struct bpf_object;
 struct cgroup;
+struct hashmap;
 struct perf_counts;
+struct perf_pmu;
 struct perf_stat_config;
 struct perf_stat_evsel;
-union perf_event;
-struct bpf_counter_ops;
 struct target;
-struct hashmap;
-struct bperf_leader_bpf;
-struct bperf_follower_bpf;
+union perf_event;
 
 typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
 
-- 
2.54.0.rc2.533.g4f5dca5207-goog

