Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524AA2263A
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727748877; cv=none; b=AdRpITmwyKL+rPyP3hpcJ3LVdYoaNDH93ECN5Yc3pPwPP3DUDTrnhWHjkV5B++6SR2679YCYNacZaq9Jtsh3RYa4BcQnIkOhwRWMdZVtaaF+oL0Vkg1Jas85Q/l28T8TuDAXpJ9p3TCYeR0H8QSQ76JN8Iic5vfwITjfE+gOj5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727748877; c=relaxed/simple;
	bh=l+flFfM/KbyOgTc9fnV+HhzGf4o2l8+SC7hq4UxNAas=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=NMvRX9ivqfmKkzwmKksmWAb/MnvigElV7u+Kh02qXA9b0y3T2y2HOLFaCkrQ8PatSJgodVnSwGK1FoVaZa06Ha85bWPbcljdTCuOzMH47LMGaj0uTUPUsZ9wxZUNfLTl89y3eJQ4VlQC+zIbNu/h3AQu0gXaAqcqXftwmtmbI8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V074sKH8; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V074sKH8"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e25b39871fso42600497b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Sep 2024 19:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727748875; x=1728353675; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0yMU1wfb0/uE6U3t/pe/RSQWfLwvXagbck6Bkw2MJhY=;
        b=V074sKH8vsM7V/jZzkMItdN8QQh05AzhCiigbPjH+Xni2EeGT4eBThPJ3z7xK1dJiL
         zwrqCxVf69ZRwOIdQGnHdeoR3OPlJSUuAlnTMJAUazrnPzd544pRSEZYXRgIYUvFagFT
         Sr1KmKq2XgdpemUXoFrvS0XxRMSxrQt17aukbmdOkxb4EehxUOf5m3Q/GUZfS7xg7ItC
         7cmmzPoOs89cchnlBV+QMUtRRFjdTpLpNoZXMVvAboId9MCTaPtZjeVhF4vDdPAQAF8V
         xGCesEFaxXUgwfLiF8jTTb9rxpEH/ck2WWC/iKjQ31duUif30N2LJdNXyMI5jlROmdM+
         pvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727748875; x=1728353675;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0yMU1wfb0/uE6U3t/pe/RSQWfLwvXagbck6Bkw2MJhY=;
        b=ReVk2nMc1z8Mz0sVss+0BcdXx/tCGj/q5rH/gLSGZi2+6xV2apPXQcvGQowAgpt4Ex
         TllmB4Ab42nIVlEsifKR2SpOYZKYfuUNvvTy8DoeVrqS2ttdVqkc/shPO2Db316ftThE
         M2pkvycAaa2DxB51M4v2w0QvwGrTJJbc55AJcrhKZhhYTybMY5Wf/2uObjYWu6TkZqss
         JlEcByFBWlgHezDYB+1qxZ/1uOalw5uxpkpuA+71yquYTgHhRy2QATyF5i47hz3LqBJI
         88kbzXDQ/F5/QDYlRASNFcao/uRSKBa5iss+Gu1wHszFbQqK3j6QfC9B81B+tLTzyR+w
         I2Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUVSlTlyWv3f+L3Du9ukbLepLbm8ev6Ac/H+MA7Jhb0ZTNMA1ULWR3xS8QfLnBPEIYNRV5wA5a7o8vNUiqS8R4H@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3SucnrH1oSBHJcaYwc6lTf3NIVjffKJSxcMDUHsKTAPSBHttR
	TGEljKxCGCU54N1hzcuz4lTMrwk39fDRG6Og7rE/7bkRjWkcXd5pcq23SoZOfjkGTxdtQq39bh+
	T+NnbYg==
X-Google-Smtp-Source: AGHT+IF7fGZiKE0sXEkufH0KVb4ii0sxfKeXhomG0wvcPAdiAENqDcfAcPECGQOY51UluYVfJKGasvlYea/i
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f420:67c7:1eea:bb12])
 (user=irogers job=sendgmr) by 2002:a81:ad20:0:b0:6db:321e:9bd2 with SMTP id
 00721157ae682-6e24754e2dbmr1326807b3.1.1727748875156; Mon, 30 Sep 2024
 19:14:35 -0700 (PDT)
Date: Mon, 30 Sep 2024 19:14:31 -0700
Message-Id: <20241001021431.814811-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v2] perf jevents: Don't stop at the first matched pmu when
 searching a events table
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Kan Liang <kan.liang@linux.intel.com>

The "perf all PMU test" fails on a Coffee Lake machine.

The failure is caused by the below change in the commit e2641db83f18
("perf vendor events: Add/update skylake events/metrics").

+    {
+        "BriefDescription": "This 48-bit fixed counter counts the UCLK cycles",
+        "Counter": "FIXED",
+        "EventCode": "0xff",
+        "EventName": "UNC_CLOCK.SOCKET",
+        "PerPkg": "1",
+        "PublicDescription": "This 48-bit fixed counter counts the UCLK cycles.",
+        "Unit": "cbox_0"
     }

The other cbox events have the unit name "CBOX", while the fixed counter
has a unit name "cbox_0". So the events_table will maintain separate
entries for cbox and cbox_0.

The perf_pmus__print_pmu_events() calculates the total number of events,
allocate an aliases buffer, store all the events into the buffer, sort,
and print all the aliases one by one.

The problem is that the calculated total number of events doesn't match
the stored events in the aliases buffer.

The perf_pmu__num_events() is used to calculate the number of events. It
invokes the pmu_events_table__num_events() to go through the entire
events_table to find all events. Because of the
pmu_uncore_alias_match(), the suffix of uncore PMU will be ignored. So
the events for cbox and cbox_0 are all counted.

When storing events into the aliases buffer, the
perf_pmu__for_each_event() only process the events for cbox.

Since a bigger buffer was allocated, the last entry are all 0.
When printing all the aliases, null will be outputted, and trigger the
failure.

The mismatch was introduced from the commit e3edd6cf6399 ("perf
pmu-events: Reduce processed events by passing PMU"). The
pmu_events_table__for_each_event() stops immediately once a pmu is set.
But for uncore, especially this case, the method is wrong and mismatch
what perf does in the perf_pmu__num_events().

With the patch,
$ perf list pmu | grep -A 1 clock.socket
   unc_clock.socket
        [This 48-bit fixed counter counts the UCLK cycles. Unit: uncore_cbox_0
$ perf test "perf all PMU test"
  107: perf all PMU test                                               : Ok

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/all/202407101021.2c8baddb-oliver.sang@intel.com/
Fixes: e3edd6cf6399 ("perf pmu-events: Reduce processed events by passing PMU")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
Also pushed to:
https://github.com/googleprodkernel/linux-perf/commit/dbbd6e40c7fb249a030d47d7de8f048b0c30c607
---
 tools/perf/pmu-events/empty-pmu-events.c | 2 +-
 tools/perf/pmu-events/jevents.py         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index c592079982fb..873e9fb2041f 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -380,7 +380,7 @@ int pmu_events_table__for_each_event(const struct pmu_events_table *table,
                         continue;
 
                 ret = pmu_events_table__for_each_event_pmu(table, table_pmu, fn, data);
-                if (pmu || ret)
+                if (ret)
                         return ret;
         }
         return 0;
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index bb0a5d92df4a..d46a22fb5573 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -930,7 +930,7 @@ int pmu_events_table__for_each_event(const struct pmu_events_table *table,
                         continue;
 
                 ret = pmu_events_table__for_each_event_pmu(table, table_pmu, fn, data);
-                if (pmu || ret)
+                if (ret)
                         return ret;
         }
         return 0;
-- 
2.46.1.824.gd892dcdcdd-goog

