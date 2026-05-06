Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE4319539F
	for <linux-perf-users@vger.kernel.org>; Wed,  6 May 2026 00:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778025644; cv=none; b=pGewDVFCfWFp85LTyHzYurRoGBr/f/pQkJHG0/f7wX/l8Y11P9ZIOKsCmWniVwQ7ZAykkk2c+C91S/BikdUODOs+KZAb78xxRb0k25UoZ9Mm7pnQb8hTdErcmtjyuR/OflUcfYCfczYUpKWOcsXTcJXNVRxhKSROQkpfjK4SAf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778025644; c=relaxed/simple;
	bh=7Or3s0O7UThYxhQqCr3otQTvLco4LK4d2/9dlfOvRIA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=te4I8Dzkc0l1TIb9hKwx88ZVs87S3rfrgX8e/Y3kZleE6RFXciPMt6gpNUyORcpeJjVszZjOCmBPf4//gP8/S7wtzE1GjlV5EgE0s6DaxjQQakP015jlqMob7v+8mgflaNKzVQqxxltDZPIrHEeBZyX07yRDVNrY5B13fE1lAVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UM0EpFTS; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UM0EpFTS"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c8ccc7593so7600648c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 05 May 2026 17:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778025642; x=1778630442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V9kyZA4cH46+4uvTcVRvO0oz4btiQG2cEL+vBA8ua6w=;
        b=UM0EpFTS9F57qAsfy4BaGp8x2uDudTNcQLiSz+J/odDJqbxlS6pRWWeY7WnXLJwM7Z
         fH8xEyi+6R0/WJ1vxAXb+XUsRhmjdGIOnOgq+VmexsIaCyxoNfo8ke40edGER+RvF49j
         qJ8D8FtUZRs7LI23HNun1t0whke2iNOiZLLyUPf7zThbw1r/WCqU4iBDqQ5RsW0wKTYD
         TFlV60usob8I/+Dwy2ao+Hj4c+RCwBSSATTj98wMBbmfzAAc3HJbXRCAB1rgJ9uohDi2
         I6YRaiUGklQKZVSZ/svxBOsa3Ds00KaQo3GNeyitOwzw5/ZbIj471jN4SYOrM+poCgUc
         hC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778025642; x=1778630442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9kyZA4cH46+4uvTcVRvO0oz4btiQG2cEL+vBA8ua6w=;
        b=AWnX5elz8XcW1EQCP0ac7gjl6DyEXKxoKNSCzraStbhJXRkAsIKUAf0nKCLK3aEBFH
         E7o8p7Jnx99ZYynUhLgk1UANxa1PFn92R618rH5jKZenCPWcMuRXXjxEYjET/OH+Qk6o
         /JshLcIJvvaL+MJ3AL9KpYE6fSlhZK/9MGdoFgbjui5SYWzAKNSia0/JAZ+AY8elA7lg
         o0JKDEHGxFIwjYklLNaCgbKm9AVAP5Q9jJ1XJIBQdlge5DdEuWVslExpalnkw5K8PGsd
         8jd/cjgfGaQCWPWJ7/amt4ZQsUSNwtTAQ48z6p2quzxcqToD8DYO5R23ZGpNI/TmVV/B
         1jyA==
X-Forwarded-Encrypted: i=1; AFNElJ8Mt7HjMXXoLsWqb2CS4VPXjyeMGX1GglA3e57OCNCHvQbRU62k1rVWKWYC9bOjWwzyY6uMon5h0R/Re/rntnMK@vger.kernel.org
X-Gm-Message-State: AOJu0YxPU3KpvFfkmQ9ZaivAQ6ZVZOpG+RABMFJzuTuMojmcGE4wirXj
	4Uvj2mEYF+cIgvhJGN0VUUMkdepv6pdSksI0SSwa6O0nPpRJ6lzTo9Q/miWr207abjgI15EyVfi
	akJcoaya4XQ==
X-Received: from dlbbs31.prod.google.com ([2002:a05:7022:91f:b0:12d:bc33:4ee3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:62b:b0:130:6977:fe51
 with SMTP id a92af1059eb24-131854f6c41mr742671c88.15.1778025626782; Tue, 05
 May 2026 17:00:26 -0700 (PDT)
Date: Tue,  5 May 2026 17:00:18 -0700
In-Reply-To: <20260429173931.2700115-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260429173931.2700115-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506000018.3113599-1-irogers@google.com>
Subject: [PATCH v3] perf sched stats: Fix segmentation faults, memory leaks,
 and stale pointers in diff mode
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, atrajeev@linux.ibm.com, 
	james.clark@linaro.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	venkat88@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The patch addresses multiple segmentation fault vectors, out-of-bounds
reads, and memory leaks in perf sched stats by adding bounds checks,
NULL checks, proper error propagation, and robust memory cleanup.

1. In get_all_cpu_stats(), added assert(!list_empty(head)) to prevent
   unsafe list_first_entry() calls on empty lists, added a missing NULL
   check for summary_head->cpu_data allocation, and implemented a cleanup
   ladder using a temporary list to prevent memory leaks on error paths.
2. In free_schedstat(), fixed memory leaks by ensuring internal domain_data
   and cpu_data pointers are freed.
3. In show_schedstat_data(), fixed a stale pointer issue where ds2 retained
   its value from a previous iteration when dptr2 became NULL, and added
   proper propagation of errors from get_all_cpu_stats().
4. Propagated show_schedstat_data() errors up to perf_sched__schedstat_diff()
   and perf_sched__schedstat_live() to prevent output corruption on failure.
5. In show_schedstat_data(), added NULL checks for cd_map1 and cd_map2
   to gracefully handle invalid or empty data files.
6. Added parallel iteration termination checks using list_is_last() in
   show_schedstat_data() for both domain and CPU lists to safely terminate
   at the end of each list when files contain a different number of CPUs
   or domains.
7. Added CPU bounds checks (cs1->cpu >= nr1 and cs2->cpu >= nr2) in
   show_schedstat_data() to prevent out-of-bounds reads from cd_map1 and
   cd_map2 when comparing files from machines with different CPU counts.
8. Added NULL checks for cd_info1 and cd_info2 to prevent crashes when
   a CPU has data samples but no corresponding domain info in the header.
9. Added domain bounds checks (ds1->domain >= cd_info1->nr_domains and
   ds2->domain >= cd_info2->nr_domains) to prevent out-of-bounds array
   accesses in the domains array.
10. Added NULL checks for dinfo1 and dinfo2 in show_schedstat_data()
    to prevent crashes when a domain has no corresponding domain info.
11. Zero-initialized the perf_data array in perf_sched__schedstat_diff()
    to prevent stack garbage from causing perf_data_file__fd() to attempt
    to use a NULL fptr when use_stdio happened to be non-zero.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>

---
v3:
Address sashiko feedback:
 - Fix memory leaks in free_schedstat() by freeing internal data.
 - Fix missing NULL check for summary_head->cpu_data in get_all_cpu_stats().
 - Fix memory leaks in get_all_cpu_stats() on error paths using a temporary cleanup list.
 - Fix stale ds2 pointer comparison in show_schedstat_data() by resetting it to NULL.
 - Add error propagation from get_all_cpu_stats() and show_schedstat_data().
 - Correct commit message to remove inaccurate claim about uninitialized variable 'ret'.
 - Add forward declaration for free_schedstat() to fix compilation error.

v2: Had tested-by Athira Rajeev and reviewed-by James Clark, removed
    from v3 given the number of changes.
https://lore.kernel.org/linux-perf-users/20260429173931.2700115-1-irogers@google.com/
---
 tools/perf/builtin-sched.c | 165 +++++++++++++++++++++++++++++--------
 1 file changed, 131 insertions(+), 34 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 555247568e7a..e39a30056dc5 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3947,6 +3947,8 @@ static struct schedstat_domain *domain_second_pass;
 static bool after_workload_flag;
 static bool verbose_field;
 
+static void free_schedstat(struct list_head *head);
+
 static void store_schedstat_cpu_diff(struct schedstat_cpu *after_workload)
 {
 	struct perf_record_schedstat_cpu *before = cpu_second_pass->cpu_data;
@@ -4170,37 +4172,50 @@ static void summarize_schedstat_domain(struct schedstat_domain *summary_domain,
  */
 static int get_all_cpu_stats(struct list_head *head)
 {
-	struct schedstat_cpu *cptr = list_first_entry(head, struct schedstat_cpu, cpu_list);
-	struct schedstat_cpu *summary_head = NULL;
-	struct perf_record_schedstat_domain *ds;
-	struct perf_record_schedstat_cpu *cs;
+	struct schedstat_cpu *cptr, *summary_head = NULL;
 	struct schedstat_domain *dptr, *tdptr;
 	bool is_last = false;
 	int cnt = 1;
 	int ret = 0;
+	struct list_head tmp_cleanup_list;
 
-	if (cptr) {
-		summary_head = zalloc(sizeof(*summary_head));
-		if (!summary_head)
-			return -ENOMEM;
+	assert(!list_empty(head));
+	cptr = list_first_entry(head, struct schedstat_cpu, cpu_list);
 
-		summary_head->cpu_data = zalloc(sizeof(*cs));
-		memcpy(summary_head->cpu_data, cptr->cpu_data, sizeof(*cs));
+	INIT_LIST_HEAD(&tmp_cleanup_list);
 
-		INIT_LIST_HEAD(&summary_head->domain_head);
+	summary_head = zalloc(sizeof(*summary_head));
+	if (!summary_head)
+		return -ENOMEM;
 
-		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
-			tdptr = zalloc(sizeof(*tdptr));
-			if (!tdptr)
-				return -ENOMEM;
+	INIT_LIST_HEAD(&summary_head->domain_head);
+	INIT_LIST_HEAD(&summary_head->cpu_list);
+	list_add(&summary_head->cpu_list, &tmp_cleanup_list);
 
-			tdptr->domain_data = zalloc(sizeof(*ds));
-			if (!tdptr->domain_data)
-				return -ENOMEM;
+	summary_head->cpu_data = zalloc(sizeof(*summary_head->cpu_data));
+	if (!summary_head->cpu_data) {
+		ret = -ENOMEM;
+		goto out_cleanup;
+	}
+	memcpy(summary_head->cpu_data, cptr->cpu_data, sizeof(*summary_head->cpu_data));
 
-			memcpy(tdptr->domain_data, dptr->domain_data, sizeof(*ds));
-			list_add_tail(&tdptr->domain_list, &summary_head->domain_head);
+	list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
+		tdptr = zalloc(sizeof(*tdptr));
+		if (!tdptr) {
+			ret = -ENOMEM;
+			goto out_cleanup;
 		}
+		INIT_LIST_HEAD(&tdptr->domain_list);
+
+		tdptr->domain_data = zalloc(sizeof(*tdptr->domain_data));
+		if (!tdptr->domain_data) {
+			free(tdptr);
+			ret = -ENOMEM;
+			goto out_cleanup;
+		}
+
+		memcpy(tdptr->domain_data, dptr->domain_data, sizeof(*tdptr->domain_data));
+		list_add_tail(&tdptr->domain_list, &summary_head->domain_head);
 	}
 
 	list_for_each_entry(cptr, head, cpu_list) {
@@ -4212,32 +4227,52 @@ static int get_all_cpu_stats(struct list_head *head)
 
 		cnt++;
 		summarize_schedstat_cpu(summary_head, cptr, cnt, is_last);
+		if (list_empty(&summary_head->domain_head))
+			continue;
+
 		tdptr = list_first_entry(&summary_head->domain_head, struct schedstat_domain,
 					 domain_list);
 
 		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
 			summarize_schedstat_domain(tdptr, dptr, cnt, is_last);
+			if (list_is_last(&tdptr->domain_list, &summary_head->domain_head)) {
+				tdptr = NULL;
+				break;
+			}
 			tdptr = list_next_entry(tdptr, domain_list);
 		}
 	}
 
+	list_del_init(&summary_head->cpu_list);
 	list_add(&summary_head->cpu_list, head);
+	return 0;
+
+out_cleanup:
+	free_schedstat(&tmp_cleanup_list);
 	return ret;
 }
 
-static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **cd_map1,
-			       struct list_head *head2, struct cpu_domain_map **cd_map2,
+static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **cd_map1, int nr1,
+			       struct list_head *head2, struct cpu_domain_map **cd_map2, int nr2,
 			       bool summary_only)
 {
 	struct schedstat_cpu *cptr1 = list_first_entry(head1, struct schedstat_cpu, cpu_list);
 	struct perf_record_schedstat_domain *ds1 = NULL, *ds2 = NULL;
-	struct perf_record_schedstat_cpu *cs1 = NULL, *cs2 = NULL;
 	struct schedstat_domain *dptr1 = NULL, *dptr2 = NULL;
 	struct schedstat_cpu *cptr2 = NULL;
 	__u64 jiffies1 = 0, jiffies2 = 0;
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
@@ -4260,21 +4295,47 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
 	printf("\n");
 
 	ret = get_all_cpu_stats(head1);
+	if (ret)
+		return ret;
 	if (cptr2) {
 		ret = get_all_cpu_stats(head2);
+		if (ret)
+			return ret;
 		cptr2 = list_first_entry(head2, struct schedstat_cpu, cpu_list);
 	}
 
 	list_for_each_entry(cptr1, head1, cpu_list) {
 		struct cpu_domain_map *cd_info1 = NULL, *cd_info2 = NULL;
+		struct perf_record_schedstat_cpu *cs1 = cptr1->cpu_data;
+		struct perf_record_schedstat_cpu *cs2 = NULL;
 
-		cs1 = cptr1->cpu_data;
+		dptr2 = NULL;
+		if (cs1->cpu >= (u32)nr1) {
+			pr_err("Error: CPU %d exceeds domain map size %d\n", cs1->cpu, nr1);
+			return -1;
+		}
 		cd_info1 = cd_map1[cs1->cpu];
+		if (!cd_info1) {
+			pr_err("Error: CPU %d domain info is missing in map 1.\n",
+			       cs1->cpu);
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
+				pr_err("Error: CPU %d domain info is missing in map 2.\n",
+				       cs2->cpu);
+				return -1;
+			}
+			if (!list_empty(&cptr2->domain_head))
+				dptr2 = list_first_entry(&cptr2->domain_head,
+							 struct schedstat_domain,
+							 domain_list);
 		}
 
 		if (cs2 && cs1->cpu != cs2->cpu) {
@@ -4302,10 +4363,31 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
 			struct domain_info *dinfo1 = NULL, *dinfo2 = NULL;
 
 			ds1 = dptr1->domain_data;
+			ds2 = NULL;
+			if (ds1->domain >= cd_info1->nr_domains) {
+				pr_err("Error: Domain %d exceeds max domains %d for CPU %d in map 1.\n",
+				       ds1->domain, cd_info1->nr_domains, cs1->cpu);
+				return -1;
+			}
 			dinfo1 = cd_info1->domains[ds1->domain];
+			if (!dinfo1) {
+				pr_err("Error: Domain %d info is missing for CPU %d in map 1.\n",
+				       ds1->domain, cs1->cpu);
+				return -1;
+			}
 			if (dptr2) {
 				ds2 = dptr2->domain_data;
+				if (ds2->domain >= cd_info2->nr_domains) {
+					pr_err("Error: Domain %d exceeds max domains %d for CPU %d in map 2.\n",
+					       ds2->domain, cd_info2->nr_domains, cs2->cpu);
+					return -1;
+				}
 				dinfo2 = cd_info2->domains[ds2->domain];
+				if (!dinfo2) {
+					pr_err("Error: Domain %d info is missing for CPU %d in map 2.\n",
+					       ds2->domain, cs2->cpu);
+					return -1;
+				}
 			}
 
 			if (dinfo2 && dinfo1->domain != dinfo2->domain) {
@@ -4334,14 +4416,22 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
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
@@ -4473,9 +4563,11 @@ static void free_schedstat(struct list_head *head)
 	list_for_each_entry_safe(cptr, n2, head, cpu_list) {
 		list_for_each_entry_safe(dptr, n1, &cptr->domain_head, domain_list) {
 			list_del_init(&dptr->domain_list);
+			free(dptr->domain_data);
 			free(dptr);
 		}
 		list_del_init(&cptr->cpu_list);
+		free(cptr->cpu_data);
 		free(cptr);
 	}
 }
@@ -4523,7 +4615,9 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
 		}
 
 		cd_map = session->header.env.cpu_domain;
-		err = show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
+		err = show_schedstat_data(&cpu_head, cd_map,
+					  session->header.env.nr_cpus_avail,
+					  NULL, NULL, 0, false);
 	}
 
 out:
@@ -4538,7 +4632,7 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
 	struct cpu_domain_map **cd_map0 = NULL, **cd_map1 = NULL;
 	struct list_head cpu_head_ses0, cpu_head_ses1;
 	struct perf_session *session[2];
-	struct perf_data data[2];
+	struct perf_data data[2] = {0};
 	int ret = 0, err = 0;
 	static const char *defaults[] = {
 		"perf.data.old",
@@ -4610,7 +4704,10 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
 		goto out_delete_ses0;
 	}
 
-	show_schedstat_data(&cpu_head_ses0, cd_map0, &cpu_head_ses1, cd_map1, true);
+	ret = show_schedstat_data(&cpu_head_ses0, cd_map0, session[0]->header.env.nr_cpus_avail,
+				  &cpu_head_ses1, cd_map1, session[1]->header.env.nr_cpus_avail, true);
+	if (ret)
+		goto out_delete_ses1;
 
 out_delete_ses1:
 	free_schedstat(&cpu_head_ses1);
@@ -4720,7 +4817,7 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
 		goto out;
 	}
 
-	show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
+	err = show_schedstat_data(&cpu_head, cd_map, nr, NULL, NULL, 0, false);
 	free_cpu_domain_info(cd_map, sv, nr);
 out:
 	free_schedstat(&cpu_head);
-- 
2.54.0.545.g6539524ca2-goog

