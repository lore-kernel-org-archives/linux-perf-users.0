Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF9B30DD11
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360100; cv=none; b=N7Ut6JDYzzOIa9XPvw0R9tJCRoDT2fTN1kJEPMoBtg9OGsj/O7U8GzLvNw9wBd3ZdivkFECBAkVgsQYA77oqru/KeaRRbV+OfCHUCws2qnTlVMp9b35MtadK88vvQIYtJIgF0UfHRrsdvmDKfm5ho6lYvqFdBUoOh/PzgUXS/r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360100; c=relaxed/simple;
	bh=lwSe0v5VMQA/q4l2K41R3YbjFIm0BVxGfkMd9sCIUK0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dsHnFLpq6OLg+e1qkIL1St5MSA41oNKNPS5Y2XK/6zhXPrevpHhgIYkZbEJ4LKVdZ5cSv2AMPnf3PdxYZn4uQAzxYo06W4hEy1jevE3gmU4f2lVga9YAw3HaGgjWz4F6BoGBfM49IZBJAsoF7mw/wpu7kWXlonBUP7yNwXNbI1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SSiSt5qd; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SSiSt5qd"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2eaed3d96d7so3075594eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360098; x=1777964898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2bzJvPtK1P88XUPGA/hN3V39U0Dy3SavNOwq3ZmuojA=;
        b=SSiSt5qdhsgTsdUPiwzZG1u1AMRdgsUV2YqVBZbfKb/ZRWI3SAcAV7lIgDFs+JBAk7
         Evm/azdL3TKKgLVDXHGBgK+PptYBv6C1n+KCyIQQ4yCaql3St4fVHY3Mibci8wkmrtCq
         QxOZLujImQK1GVTG1CzFb2CN1AKqfsMkp2S8buCHOjsmxKFj6rGp6+gHNHUo0EbwxlPY
         FdN9JCjrwpypQAMo+Xgc7CA6ANV+yLDHxhP0dyBkEUNROfPyoQia5Z7MEj4EgSkGmxob
         f1com5I1m24Ilz4lLma157EEbDGRJgcXmNEzGSkxWNLt/S7ZhVAQuNB63QrA1A+IPHsZ
         1r4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360098; x=1777964898;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2bzJvPtK1P88XUPGA/hN3V39U0Dy3SavNOwq3ZmuojA=;
        b=Ti8mYral+M7o8jmHrszYlOsyu7b27VGCtuGU/rAvnc7Nx+bekrH/2vIqxROk1HXzfd
         nykqPXAvaGiVC2/ae5QHqFUJXL4Qiq9NtFHfzLoyT4PiXh9lZySAtj97MlcFGED3Eaj6
         hzDVJiemtA3iekSqv3TG5NxuHZ9mDIHTb02T1V/uadeN0cvfZ77GBfWHgVQSrWPICFFG
         2VlNHK61I+Mm209JLtCVFPbDpjsYvfiUnTCd5ze0HX6nUtoSi65PyWmNdyUWT4WvLbTC
         95+gIawrZMkV14ATAftFdfXxr698lCxR6mCjLtMCLjva4d6KvUo+AiRlS+7Rnte8Lyme
         gKSA==
X-Forwarded-Encrypted: i=1; AFNElJ/r/G+ZFc18ZnClkHUsuRONFpNYyS7rzG/GBQY0UuyB8KBW6wR97RRd1ulmsn3ioungPzT/495zoRVh615CKJRG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5BiTWnxlfaCxViRwwQFl90kbFstQ4Hl3tuOhRK9DMladAiLvW
	LBfyamxJaFT74y6A3PpRGl7wiyHW3mJa2i4JAtO/jAFJvrjo0GEOIl5aviU4Fq2bTrOZxIFsd2r
	iUMOT18FDAQ==
X-Received: from dybmd11.prod.google.com ([2002:a05:7301:180b:b0:2d8:d251:f7ba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:dc98:b0:2d3:f3fc:bb6b
 with SMTP id 5a478bee46e88-2ed09fde238mr924698eec.1.1777360098047; Tue, 28
 Apr 2026 00:08:18 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:08:11 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428070811.1883202-1-irogers@google.com>
Subject: [PATCH v1] perf sched stats: Fix segmentation faults in diff mode
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Venkat <venkat88@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Address several segmentation fault vectors in `perf sched stats diff`:

1. When processing invalid or empty data files, the CPU domain maps may
   be NULL. Added NULL checks for `cd_map1` and `cd_map2` in
   `show_schedstat_data()` to fail gracefully.

2. When files contain a different number of CPUs or domains, the parallel
   list iteration in `show_schedstat_data()` could wrap around the list
   heads and dereference invalid memory. Added `list_is_last` checks
   to safely terminate iteration at the end of each list.

3. When summarizing CPU statistics in `get_all_cpu_stats()`, parallel list
   iteration over domains could similarly wrap around if a CPU has more
   domains than the first CPU. Added `list_is_last` check to prevent this.

4. Added bounds checks for `cs1->cpu` and `cs2->cpu` against `nr1` and
   `nr2` (passed from `env->nr_cpus_avail`) to prevent out-of-bounds
   reads from `cd_map1` and `cd_map2` when processing data from machines
   with different CPU configurations.

5. Added NULL checks for `cd_info1` and `cd_info2` in `show_schedstat_data()`
   to prevent crashes when a CPU has samples in the data file but no
   corresponding domain info in the header (which leaves the map entry NULL).

6. Added NULL checks for `dinfo1` and `dinfo2` in `show_schedstat_data()`
   to prevent crashes when a domain is present in the list but has no
   corresponding info in the CPU domain map (which leaves the entry NULL).

7. Zero-initialized the `perf_data` array in `perf_sched__schedstat_diff()`
   to prevent stack garbage from causing `perf_data_file__fd()` to attempt
   to use a NULL `fptr` when `use_stdio` happened to be non-zero.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
Previously this patch was part of a large perf script refactor:
https://lore.kernel.org/lkml/20260425224951.174663-1-irogers@google.com/
---
 tools/perf/builtin-sched.c | 95 +++++++++++++++++++++++++++++++-------
 1 file changed, 79 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 555247568e7a..9ecda631b3ab 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4212,12 +4212,20 @@ static int get_all_cpu_stats(struct list_head *head)
 
 		cnt++;
 		summarize_schedstat_cpu(summary_head, cptr, cnt, is_last);
-		tdptr = list_first_entry(&summary_head->domain_head, struct schedstat_domain,
-					 domain_list);
+		if (!list_empty(&summary_head->domain_head))
+			tdptr = list_first_entry(&summary_head->domain_head, struct schedstat_domain,
+						 domain_list);
+		else
+			tdptr = NULL;
 
 		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
-			summarize_schedstat_domain(tdptr, dptr, cnt, is_last);
-			tdptr = list_next_entry(tdptr, domain_list);
+			if (tdptr) {
+				summarize_schedstat_domain(tdptr, dptr, cnt, is_last);
+				if (list_is_last(&tdptr->domain_list, &summary_head->domain_head))
+					tdptr = NULL;
+				else
+					tdptr = list_next_entry(tdptr, domain_list);
+			}
 		}
 	}
 
@@ -4225,8 +4233,8 @@ static int get_all_cpu_stats(struct list_head *head)
 	return ret;
 }
 
-static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **cd_map1,
-			       struct list_head *head2, struct cpu_domain_map **cd_map2,
+static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **cd_map1, int nr1,
+			       struct list_head *head2, struct cpu_domain_map **cd_map2, int nr2,
 			       bool summary_only)
 {
 	struct schedstat_cpu *cptr1 = list_first_entry(head1, struct schedstat_cpu, cpu_list);
@@ -4238,6 +4246,15 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
 	bool is_summary = true;
 	int ret = 0;
 
+	if (!cd_map1) {
+		pr_err("Error: CPU domain map 1 is missing.\n");
+		return -1;
+	}
+	if (head2 && !cd_map2) {
+		pr_err("Error: CPU domain map 2 is missing.\n");
+		return -1;
+	}
+
 	printf("Description\n");
 	print_separator2(SEP_LEN, "", 0);
 	printf("%-30s-> %s\n", "DESC", "Description of the field");
@@ -4269,12 +4286,33 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
 		struct cpu_domain_map *cd_info1 = NULL, *cd_info2 = NULL;
 
 		cs1 = cptr1->cpu_data;
+		cs2 = NULL;
+		dptr2 = NULL;
+		if (cs1->cpu >= (u32)nr1) {
+			pr_err("Error: CPU %d exceeds domain map size %d\n", cs1->cpu, nr1);
+			return -1;
+		}
 		cd_info1 = cd_map1[cs1->cpu];
+		if (!cd_info1) {
+			pr_err("Error: CPU %d domain info is missing in map 1.\n", cs1->cpu);
+			return -1;
+		}
 		if (cptr2) {
 			cs2 = cptr2->cpu_data;
+			if (cs2->cpu >= (u32)nr2) {
+				pr_err("Error: CPU %d exceeds domain map size %d\n", cs2->cpu, nr2);
+				return -1;
+			}
 			cd_info2 = cd_map2[cs2->cpu];
-			dptr2 = list_first_entry(&cptr2->domain_head, struct schedstat_domain,
-						 domain_list);
+			if (!cd_info2) {
+				pr_err("Error: CPU %d domain info is missing in map 2.\n", cs2->cpu);
+				return -1;
+			}
+			if (!list_empty(&cptr2->domain_head))
+				dptr2 = list_first_entry(&cptr2->domain_head, struct schedstat_domain,
+							 domain_list);
+			else
+				dptr2 = NULL;
 		}
 
 		if (cs2 && cs1->cpu != cs2->cpu) {
@@ -4302,10 +4340,26 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
 			struct domain_info *dinfo1 = NULL, *dinfo2 = NULL;
 
 			ds1 = dptr1->domain_data;
+			if (ds1->domain >= cd_info1->nr_domains) {
+				pr_err("Error: Domain %d exceeds max domains %d for CPU %d in map 1.\n", ds1->domain, cd_info1->nr_domains, cs1->cpu);
+				return -1;
+			}
 			dinfo1 = cd_info1->domains[ds1->domain];
+			if (!dinfo1) {
+				pr_err("Error: Domain %d info is missing for CPU %d in map 1.\n", ds1->domain, cs1->cpu);
+				return -1;
+			}
 			if (dptr2) {
 				ds2 = dptr2->domain_data;
+				if (ds2->domain >= cd_info2->nr_domains) {
+					pr_err("Error: Domain %d exceeds max domains %d for CPU %d in map 2.\n", ds2->domain, cd_info2->nr_domains, cs2->cpu);
+					return -1;
+				}
 				dinfo2 = cd_info2->domains[ds2->domain];
+				if (!dinfo2) {
+					pr_err("Error: Domain %d info is missing for CPU %d in map 2.\n", ds2->domain, cs2->cpu);
+					return -1;
+				}
 			}
 
 			if (dinfo2 && dinfo1->domain != dinfo2->domain) {
@@ -4334,14 +4388,22 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
 			print_domain_stats(ds1, ds2, jiffies1, jiffies2);
 			print_separator2(SEP_LEN, "", 0);
 
-			if (dptr2)
-				dptr2 = list_next_entry(dptr2, domain_list);
+			if (dptr2) {
+				if (list_is_last(&dptr2->domain_list, &cptr2->domain_head))
+					dptr2 = NULL;
+				else
+					dptr2 = list_next_entry(dptr2, domain_list);
+			}
 		}
 		if (summary_only)
 			break;
 
-		if (cptr2)
-			cptr2 = list_next_entry(cptr2, cpu_list);
+		if (cptr2) {
+			if (list_is_last(&cptr2->cpu_list, head2))
+				cptr2 = NULL;
+			else
+				cptr2 = list_next_entry(cptr2, cpu_list);
+		}
 
 		is_summary = false;
 	}
@@ -4523,7 +4585,7 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
 		}
 
 		cd_map = session->header.env.cpu_domain;
-		err = show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
+		err = show_schedstat_data(&cpu_head, cd_map, session->header.env.nr_cpus_avail, NULL, NULL, 0, false);
 	}
 
 out:
@@ -4538,7 +4600,7 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
 	struct cpu_domain_map **cd_map0 = NULL, **cd_map1 = NULL;
 	struct list_head cpu_head_ses0, cpu_head_ses1;
 	struct perf_session *session[2];
-	struct perf_data data[2];
+	struct perf_data data[2] = {0};
 	int ret = 0, err = 0;
 	static const char *defaults[] = {
 		"perf.data.old",
@@ -4610,7 +4672,8 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
 		goto out_delete_ses0;
 	}
 
-	show_schedstat_data(&cpu_head_ses0, cd_map0, &cpu_head_ses1, cd_map1, true);
+	show_schedstat_data(&cpu_head_ses0, cd_map0, session[0]->header.env.nr_cpus_avail,
+			    &cpu_head_ses1, cd_map1, session[1]->header.env.nr_cpus_avail, true);
 
 out_delete_ses1:
 	free_schedstat(&cpu_head_ses1);
@@ -4720,7 +4783,7 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
 		goto out;
 	}
 
-	show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
+	show_schedstat_data(&cpu_head, cd_map, nr, NULL, NULL, 0, false);
 	free_cpu_domain_info(cd_map, sv, nr);
 out:
 	free_schedstat(&cpu_head);
-- 
2.54.0.545.g6539524ca2-goog

