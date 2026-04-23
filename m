Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C85B39A04C
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962075; cv=none; b=K8rPKyqdTglkQJRQAHYfssIM0xDW23LYVclxWR9Wcfg3i2yCdzoizLwFdJhkyigQ+jKNiVus/W76Pfs7BbxmkEG2jSiT064twLPOIP/gwfUqUiMpwrgz1yZdDF9Oa1xH0JNdnhrNsgstOzwOmk+tmvlZeVO0KU6BQm3hbvc5DxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962075; c=relaxed/simple;
	bh=9QVIDwFrRipr23FnuY9aTJD6UPXAMm6bbw3zj19BRdQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dRnSuwEjU92uTFMxY26VTUf7AfXvUww+V8y/7KHDo0/cc8c9PwACKLaclb/0/oSZHB4MytFhPjgx80N2w+cT6KKOCTP4ZKYpr9LbI61nMjUW5wp8HwHXjgZF8xJWWPyFsVBshqeo1YmV8OubdNC7n2heqIWMyAn2dFSMXPMDC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yg9Q5ZNj; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yg9Q5ZNj"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b24af7ca99so93670455ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776962073; x=1777566873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NWeBiWGpevte4iUvIVtyBuQo4qdnnAREZFJd51szFgM=;
        b=Yg9Q5ZNj1pJ1PC89wxJPtllr46MUBpt2Qj7ME+u0cKyUSaAlLIJlgDHzzMhlJefI3I
         v452fMEUuyobqkQLUeDzDeVjgH6sWjTD5Cvse9yzzfQ5j1AfvP9L+bE/4t6N/vyjbuwR
         iADQzCNFLk+Zudu7KJWJI32PCvtD2iZGtpQTNvECjB+Rrc/a6Ouadx3aGauH3TgFDkAG
         r0sC1sumJngOAHhURwQ/yUOZbtAcqXcLZRtoKOI1qAYCyc5SandoFCBqcl0761EJxKsJ
         rytXq7fheftML5IqqcWDgDRjPPkT9+UL7ZYNsVcIy2ao2d2cUk8hyMkiS09khdy6p4I2
         1xmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776962073; x=1777566873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWeBiWGpevte4iUvIVtyBuQo4qdnnAREZFJd51szFgM=;
        b=OERJgrFUm4gpQj4TmkH9xvqcokn1DsPP1RWRtWhef9OXkL54rl+jvrgKtsFpehfE+2
         wKomYVy1cr0MKnmHiWuagBNLF0zAMPIu/zqu3bN5ttJtYPwxJMjDA2pp9L9pHpk1R1cm
         DHF9slSXaqftYekI4gyUq1GIQQRgsMwavav9pojFY98j1RgGdrQIfOLYtx4JiQeKWxed
         mIsj/Q+jQxjOMWV0ik8RP261sdv8i25cPvPN0vFrh0YF6grhaZWdMx9bDXzWc8+iOfiN
         zW5VdHddtFlKWamd2AYXxOppB2P1P8Ki1zJQkdp/L71aosPhBPNdCmQC/XsJegVMDq1/
         3yKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9bQjj4BViKDhIJO+CKxn5MVlx0O+2zcIC3eINUtuzyOkodX5ACeS6/NzXOcTIHLjKr09hCnf9YY2DItfJSW0ND@vger.kernel.org
X-Gm-Message-State: AOJu0YwpETgLwVoFazqKMHDa9LRYwnh/YziULllo3ytxiTQlZoIgK/vr
	jPoMBWUqckdNMMrlSl0LotdUE3/Y8M70SfZYTw/CpT1mEiZv1LCUiAzS8XC4tPwMX7V/1Zg/Sv4
	vXNegODYH6Q==
X-Received: from plof8.prod.google.com ([2002:a17:902:8608:b0:2b2:ec1e:c943])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1212:b0:2b4:6608:41dd
 with SMTP id d9443c01a7336-2b5f9edec67mr272464445ad.17.1776962073160; Thu, 23
 Apr 2026 09:34:33 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:33:16 -0700
In-Reply-To: <20260423163406.1779809-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423161006.1762700-1-irogers@google.com> <20260423163406.1779809-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423163406.1779809-9-irogers@google.com>
Subject: [PATCH v4 08/58] perf evsel/evlist: Avoid unnecessary #includes
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

