Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324572367B5
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786167; cv=none; b=jMTJRyvu8lHEBc1L4h6dft4UedxUwI87PlJZnbEoUpE8keFBpZn4qIYXLZyq/1VcP0pXJkbtPPZTLZlreI916Mra/Np/HVEwQU7Wr94klXypOnlebsP2fIs4UPY04xRzVpcttdKVlZMwVjQMlP4uSG/NQJFiDpLsri7w9HzIyT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786167; c=relaxed/simple;
	bh=3iqPS74Vm3U8TVu2LqxzGlONC7F3fEEx0C3HxO9oOX8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=gJ1uu1Vn5o8/Dot6iziRUqDfVb+g3A5o96qB9VSwvk58vx8Kykcmp0q11mZWyjRD3DHLBxTDfNjfS41GnswTL7pOY6COHCg1BZLCUVc2AvhyrBIJXTD068zThm9qB/ClhYnFQMxLPkaKe+BCDjjxYoQ4L15fl/G0Ng1Mzw/NAjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iLmY1Eg5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iLmY1Eg5"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-236725af87fso19718695ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 14:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752786165; x=1753390965; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TDJzHa5Jjh3EgodtOKHDgfY+ccZxVF0sXpFhOe3DuRk=;
        b=iLmY1Eg59iQ404M3s+t6O8sv7Pehl8V4yM24wXCEf0Gn+rYKic9f3HWwHkOXHKTJ4l
         VS4Ps/4EQ03OSuPpECW9QadFob8RIU8+O542c3T54ZtP6rgTD5G3wZQwfwg59vDYB4FQ
         X1jhFY5LbPrHYxfTv8J7OqThUROz/+xTy68yFxhkZbVTLwbI8+bVbUZ5UacIhNyExLe7
         WqxD0KUVQQSwT7LumFaGLH90D+oJKAxXcESmCFMFOhFpdILRBbKueriTNB8epQKppwxa
         i5fgOxIxSotQuO3BB2YFVzQfaOpi1eL61lPj44iICzL4zdjftzFsF8Jmy6OEnxw2Q5zg
         D6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752786165; x=1753390965;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDJzHa5Jjh3EgodtOKHDgfY+ccZxVF0sXpFhOe3DuRk=;
        b=Ih9Hqdn6uR8LqSUxkNpt19+Kg0ZB6x3Qm9s5GSjHHmvqbJC9/IpvLG0Ytq0QtZf5TG
         EBtSuIA6IzSk30uhVscIcSpiDlAJoLqP/28eBUGVSWWcmZjNLJBXMTKornXBVNLisuqJ
         GRba5mSgWi41SFk2yOJrDDEncI484ep7QoL1kPhT9S/yuDXxUp03QOrBCbgTeFHXgDyM
         sWa93+ANt+/eVFundT0ej/JJWzFdMSiSjuWwunK0tAI8LtyuQEND9hTrJpvod/P5Fcl9
         e+BI0SGq2H/fRqIeI8xr5IXstUKcTy9c6Jbj8LIZbvtwsANwLCvzoZQ/I2MNhMJqDfsD
         Z6nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq3wgXaIXNGSPv73hgDpAqKhRmswI/g+7RliEmykYN582DMC8J/kOxG6RhOrVH/N5RDyTCy5Ea1Kf8yEM8ze7L@vger.kernel.org
X-Gm-Message-State: AOJu0Yw18zJ/XpqzEd5ehUF124115SdYGzWdvghXDKOxlAneUEnAecwR
	+fQr4UiVBW8ZK0k11ujt3TaidM9UutzrLccNsXwhMFD4w6U0EsBKIzjAnFB3INThKkA/wmo6Hp0
	5Asej2rSMiA==
X-Google-Smtp-Source: AGHT+IFT0swixNXm9qdjS7EOMnt4hM5uFE2a5kg8QJcjgZGnBz12S1+iF2upqqz1KJ2dctapi//tVG7rYgTV
X-Received: from plgy14.prod.google.com ([2002:a17:903:22ce:b0:237:ca39:8d92])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c2c:b0:234:c8f6:1b17
 with SMTP id d9443c01a7336-23e3035f29bmr77170915ad.38.1752786165430; Thu, 17
 Jul 2025 14:02:45 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:02:25 -0700
In-Reply-To: <20250717210233.1143622-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717210233.1143622-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717210233.1143622-5-irogers@google.com>
Subject: [PATCH v2 04/12] perf parse-events: Allow the cpu term to be a PMU or
 CPU range
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

On hybrid systems, events like msr/tsc/ will aggregate counts across
all CPUs. Often metrics only want a value like msr/tsc/ for the cores
on which the metric is being computed. Listing each CPU with terms
cpu=0,cpu=1.. is laborious and would need to be encoded for all
variations of a CPU model.

Allow the cpumask from a PMU to be an argument to the cpu term. For
example in the following the cpumask of the cstate_pkg PMU selects the
CPUs to count msr/tsc/ counter upon:
```
$ cat /sys/bus/event_source/devices/cstate_pkg/cpumask
0
$ perf stat -A -e 'msr/tsc,cpu=cstate_pkg/' -a sleep 0.1

 Performance counter stats for 'system wide':

CPU0          252,621,253      msr/tsc,cpu=cstate_pkg/

       0.101184092 seconds time elapsed
```

As the cpu term is now also allowed to be a string, allow it to encode
a range of CPUs (a list can't be supported as ',' is already a special
token).

The "event qualifiers" section of the `perf list` man page is updated
to detail the additional behavior.  The man page formatting is tidied
up in this section, as it was incorrectly appearing within the
"parameterized events" section.

Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt | 25 +++++++++-----
 tools/perf/util/parse-events.c         | 47 +++++++++++++++++++++-----
 2 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index ce0735021473..28215306a78a 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -278,26 +278,33 @@ also be supplied. For example:
 
   perf stat -C 0 -e 'hv_gpci/dtbp_ptitc,phys_processor_idx=0x2/' ...
 
-EVENT QUALIFIERS:
+EVENT QUALIFIERS
+----------------
 
 It is also possible to add extra qualifiers to an event:
 
 percore:
 
-Sums up the event counts for all hardware threads in a core, e.g.:
-
-
-  perf stat -e cpu/event=0,umask=0x3,percore=1/
+  Sums up the event counts for all hardware threads in a core, e.g.:
+    perf stat -e cpu/event=0,umask=0x3,percore=1/
 
 cpu:
 
-Specifies the CPU to open the event upon. The value may be repeated to
-specify opening the event on multiple CPUs:
+  Specifies a CPU or a range of CPUs to open the event upon. It may
+  also reference a PMU to copy the CPU mask from. The value may be
+  repeated to specify opening the event on multiple CPUs.
 
+  Example 1: to open the instructions event on CPUs 0 and 2, the
+  cycles event on CPUs 1 and 2:
+    perf stat -e instructions/cpu=0,cpu=2/,cycles/cpu=1-2/ -a sleep 1
 
-  perf stat -e instructions/cpu=0,cpu=2/,cycles/cpu=1,cpu=2/ -a sleep 1
-  perf stat -e data_read/cpu=0/,data_write/cpu=1/ -a sleep 1
+  Example 2: to open the data_read uncore event on CPU 0 and the
+  data_write uncore event on CPU 1:
+    perf stat -e data_read/cpu=0/,data_write/cpu=1/ -a sleep 1
 
+  Example 3: to open the software msr/tsc/ event only on the CPUs
+  matching those from the cpu_core PMU:
+    perf stat -e msr/tsc,cpu=cpu_core/ -a sleep 1
 
 EVENT GROUPS
 ------------
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 3fd6cc0c2794..a337e4d22ff2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -187,10 +187,22 @@ static struct perf_cpu_map *get_config_cpu(const struct parse_events_terms *head
 
 	list_for_each_entry(term, &head_terms->terms, list) {
 		if (term->type_term == PARSE_EVENTS__TERM_TYPE_CPU) {
-			struct perf_cpu_map *cpu = perf_cpu_map__new_int(term->val.num);
-
-			perf_cpu_map__merge(&cpus, cpu);
-			perf_cpu_map__put(cpu);
+			struct perf_cpu_map *term_cpus;
+
+			if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM) {
+				term_cpus = perf_cpu_map__new_int(term->val.num);
+			} else {
+				struct perf_pmu *pmu = perf_pmus__find(term->val.str);
+
+				if (pmu && perf_cpu_map__is_empty(pmu->cpus))
+					term_cpus = pmu->is_core ? cpu_map__online() : NULL;
+				else if (pmu)
+					term_cpus = perf_cpu_map__get(pmu->cpus);
+				else
+					term_cpus = perf_cpu_map__new(term->val.str);
+			}
+			perf_cpu_map__merge(&cpus, term_cpus);
+			perf_cpu_map__put(term_cpus);
 		}
 	}
 
@@ -1048,15 +1060,32 @@ do {									   \
 			return -EINVAL;
 		}
 		break;
-	case PARSE_EVENTS__TERM_TYPE_CPU:
-		CHECK_TYPE_VAL(NUM);
-		if (term->val.num >= (u64)cpu__max_present_cpu().cpu) {
+	case PARSE_EVENTS__TERM_TYPE_CPU: {
+		struct perf_cpu_map *map;
+
+		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM) {
+			if (term->val.num >= (u64)cpu__max_present_cpu().cpu) {
+				parse_events_error__handle(err, term->err_val,
+							strdup("too big"),
+							/*help=*/NULL);
+				return -EINVAL;
+			}
+			break;
+		}
+		assert(term->type_val == PARSE_EVENTS__TERM_TYPE_STR);
+		if (perf_pmus__find(term->val.str) != NULL)
+			break;
+
+		map = perf_cpu_map__new(term->val.str);
+		if (!map) {
 			parse_events_error__handle(err, term->err_val,
-						strdup("too big"),
-						NULL);
+						   strdup("not a valid PMU or CPU number"),
+						   /*help=*/NULL);
 			return -EINVAL;
 		}
+		perf_cpu_map__put(map);
 		break;
+	}
 	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
-- 
2.50.0.727.gbf7dc18ff4-goog

