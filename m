Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8232E143
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 23:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643181; cv=none; b=B+G2SEA+Rij8AkmD9MppJiBOOl41CIAcB0Vpzaz/fGCycUs8dy2Ynnr2pgM/iRJgqiNfX7gc8ovSxCm+gnJGU7901ff8NG2I3M2hPHEJEI9OKIHIZz3khHtVXDqmihHYsFnLmOYuDxPz5ZTwPIeVww5qtx28cNt4LdpnDYTFfWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643181; c=relaxed/simple;
	bh=6E58m9InAH+DCu+ZA8PnRuDlU1ObuG7EazqtVs5Nr4Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hvbZVbgPgT+F7KtJKWKHPVsG9EQebk2KMUXN6XVqcoyWrfWHBviBssrRYCVMbzbwPctIbS7DlLFxk0zjs404VizpMEWa4hqQvNW4pca/4hISRblmKWAyK1vmXV1um1iDxwkbk/vFBxVHDB/9zDkupeArxR34g9VCSjLj124ZBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ctKWoCCo; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ctKWoCCo"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c16233ee11so3408972eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 16:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643179; x=1777247979; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3yAm7useIIj3mEDGXFjVTF11+L984iEVD8BtVUzQIp8=;
        b=ctKWoCCoADJ6/0kCx3FAGUpARqd3R5wxElXx554h2k+mbPrEWfmuUE6dB0At/ZvDfZ
         Nl2RqsIWVpBWzpexwXuK1ldgiGn4LYBmrLfvfyS+09mF9Apf6JbrDVyfKP+h2Ix3Gam2
         qhAJUPKXyMTi27hOdHXr7ULJdn90jGlWj8jd5gFWDEu/N1mks9lraZzKviltruKBOu+c
         ylemSyiu8BsmfmwwAiZiAaUvVZZRFiRjLScChOnj+sowGxvpTPqatyIl8PR3KqxinwhN
         Ng9LjBXL8uI8g/5g/HSs/boqFLoe2msdPb3PIAprZ5j5NHWOTZoctnyzXclOpsrSir0g
         n1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643179; x=1777247979;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3yAm7useIIj3mEDGXFjVTF11+L984iEVD8BtVUzQIp8=;
        b=SrjPSa/l+o41LSWJWYzv8W47fJJIboMgirNKwPo68mIRr/5ijDXWpy/ml3JbNHOprs
         xGjOuDQ2MioN4foFYkjFrpMnUBEiLzJ8gMSSmaKiklt33u7uNPRu3hI4FJeHoZQfx82Y
         3ZVsFvjkpT3jazUjDstfC9IjnbStXeIWE6TUTM7FrEcsayQZl7XBCn5p4/Of+jpTcLHZ
         IaGLwG9M+sqloyovmHVAHTE0+n4Ykn1kavt+qv5dfPuS5+vRwUILHplmWxoL5oq9cxbp
         QctpgUIx1ct2kxihyeDUQdggv0VLsTbICO1PB5f8aE5fnxuXclLjQKnZ7tu+cqxPIlPy
         k/yg==
X-Forwarded-Encrypted: i=1; AFNElJ9J5U4c+iGUIhz8rqsyryxyYN81inPSFXR9Vo2zq+6nQoTgMgSPl4NTmP/zY3kIcliSLwd2FLFK3q6E/y4qWD9V@vger.kernel.org
X-Gm-Message-State: AOJu0YywMHUd5SRREbZ4cDpCQ1xesuLTvDYlXdL6mR0YQV2hd/XGsxgX
	Q3ZaxsehTdcWsZ/B7GFhk6mDUZK58bXnYce9Q/waGRnuzCN1JHV96BoCJaInS1DHQabZ69mn0ow
	AvzLaoxuVuA==
X-Received: from dybb17.prod.google.com ([2002:a05:693c:6091:b0:2d6:2fd7:91f8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4083:b0:2d8:b1ce:d3d8
 with SMTP id 5a478bee46e88-2e4526dd448mr4946565eec.0.1776643178791; Sun, 19
 Apr 2026 16:59:38 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:20 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-9-irogers@google.com>
Subject: [PATCH v1 08/58] perf evsel/evlist: Avoid unnecessary #includes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Pan Deng <pan.deng@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Zecheng Li <zli94@ncsu.edu>, tanze <tanze@kylinos.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"Tycho Andersen (AMD)" <tycho@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Aditya Bodkhe <adityab1@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Use forward declarations and remove unnecessary #includes in evsel.h
and evlist.h. Sort the forward declaration.s

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.h | 16 ++++++++++------
 tools/perf/util/evsel.h  | 20 +++++++++++---------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index e507f5f20ef6..69784787da48 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -2,29 +2,33 @@
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
+struct evsel;
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
2.54.0.rc1.513.gad8abe7a5a-goog

