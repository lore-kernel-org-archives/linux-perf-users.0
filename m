Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE8B2FFFB1
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 05:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716073; cv=none; b=sKJESthZcop4fZ5QKxqKSlxhmi/ofknB4JFW8p68CAhHESzMg8gw4e37YyoaPvzUYCyXiMMu8NePg2RBo7xn5Fg+6VK4qwNUfzpfjIFDwmxuN1cOipXx6jv5eTgxuOWetqYJaNeWc/CjGC0X3twreKiol5OX6AOIa36unflFdJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716073; c=relaxed/simple;
	bh=nxogn7CzCOcaoMnM/yWVx3HVxrL+JJuNtx6lpItOEXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ScenFU4ulTzLjRNZY88XGb5IcZ+QGqIBzIk/MCDoI+pZ9YdPSn7g23AvtNaFISgE5Gjsm+cu+GIRSoFbNpliHqiR3O5C7A7kpHt6zdW0eRtr6cEes/wO9WPqIudHwHZ2h6gpMYzLHvciokyQq43YGxQwMPXCcZYTCuFq4J06gb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XJmP08vb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XJmP08vb"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-290da17197eso109180575ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Oct 2025 22:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761716071; x=1762320871; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/m+GGJEX4XS9igs9SnnZKBVhxyHpjFasFgfyaBk6K8=;
        b=XJmP08vbE3WlHd+L5ja0CmJMQii/AfjZfocrQ1yI9wgTjYH0ZPYK03M3ICiW47+wXN
         ySdQ+jNn4mTDsIkQBFWlghZ+R8nhnjyZrMOh+BBAJRICO61opn65ZLXDSv9eqAN8NT/K
         m1m9QU7Il1Nxsc3k2Y7c7vj2B7z7twG6cAV5rRrwDt5jOm2KgZ5giZ/1P6z2SJmAet31
         QqONK1zGG1j9PPRVQwlx3+Jadg9dDwxORxh4tyOPGxLYGLAk/iRLSMMR8ijW1+hZZpc0
         hOyWqlJP3ZvfRJrSmQJNyFYgs6xVZuZWjB3ZpwuuDxCVIjZG9DHpjjjYcHTgdB41viP9
         VCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716071; x=1762320871;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/m+GGJEX4XS9igs9SnnZKBVhxyHpjFasFgfyaBk6K8=;
        b=L2T9cNB3D/CR6KhnhrGQU6JMedm/O9YQ8MhXD0WvAaHVKIdJMCfbKoASShj3CsR6dX
         sYMIxVohMwMu7IumkjEVugx/8fz8U7TsYr8EJwZbjVVFcidLDIATXZuKDyfwPwmGSHmz
         pmoPEWyynOXIVwS2b1DVChBLAsuU6iiIE3GcwEpPwgUf/ldcsscqThD8gTKPmN/dK9ut
         djWhpW5/WJMHx3cGU3XYIINebeigz/kkfABn9itDWLK6idTJgsqCvcy8iPbTpUuwTPxr
         kbObo1QeWotpOFLm2x4IExkBtxacnkMSCaC0QeHSIWURV0oAquHC/rukEI1cESL5mYdA
         VB9w==
X-Forwarded-Encrypted: i=1; AJvYcCUuVkEgW+0BSzg5Ib5rw81oe7ZaNQgZJFM1Ecj6BHH5ni96qcZDqYkSFTXx8jVyL9OqGZYFmAWiFhOFu4m+jiLF@vger.kernel.org
X-Gm-Message-State: AOJu0YzaRBwU7yHJWoI6mYMB5AQFjmG8c+m8nl1z45T0eygeC8zu1h1/
	Yi/ILsHX2BhSbKDOdTZqQO6RGaN1hKWXpfjbmZE7Z6HGCyKNQ1T2tv9nhOXodGQIVN78obXf3A7
	+mu8RcRE4Eg==
X-Google-Smtp-Source: AGHT+IFa/+7mOOLGV31OTSxrEinUSkkcBJPH0/NM79JpffezlY8J1bwcb9IheSMk05AgTiw07XZTVKFycJDn
X-Received: from plhc9.prod.google.com ([2002:a17:903:2349:b0:288:e43f:73ce])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2348:b0:25d:37fc:32df
 with SMTP id d9443c01a7336-294deedb5c6mr21426035ad.47.1761716070749; Tue, 28
 Oct 2025 22:34:30 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:34:05 -0700
In-Reply-To: <20251029053413.355154-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029053413.355154-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029053413.355154-8-irogers@google.com>
Subject: [RFC PATCH v1 07/15] perf evsel/evlist: Avoid unnecessary #includes
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Song Liu <song@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Blake Jones <blakejones@google.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Use forward declarations and remove unnecessary #includes in evsel.h
and evlist.h. Sort the forward declaration.s

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.h | 16 +++++++++-------
 tools/perf/util/evsel.h  | 19 ++++++++++---------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 5e71e3dc6042..61acbb10d9a5 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -2,28 +2,30 @@
 #ifndef __PERF_EVLIST_H
 #define __PERF_EVLIST_H 1
 
+#include <pthread.h>
+#include <signal.h>
+#include <unistd.h>
+
 #include <linux/compiler.h>
 #include <linux/kernel.h>
-#include <linux/refcount.h>
 #include <linux/list.h>
+#include <linux/refcount.h>
 #include <api/fd/array.h>
 #include <internal/evlist.h>
-#include <internal/evsel.h>
 #include <perf/evlist.h>
+
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
index f8de0f9a719b..f4540920604e 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -2,28 +2,29 @@
 #ifndef __PERF_EVSEL_H
 #define __PERF_EVSEL_H 1
 
-#include <linux/list.h>
 #include <stdbool.h>
 #include <sys/types.h>
+
+#include <internal/evsel.h>
+#include <linux/list.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
-#include <internal/evsel.h>
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
2.51.1.851.g4ebd6896fd-goog

