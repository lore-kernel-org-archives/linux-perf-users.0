Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A8A2DF152
	for <linux-perf-users@vger.kernel.org>; Wed,  6 May 2026 04:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778040610; cv=none; b=AXfGmENMd4Tv2/cU9pXUozKEpNkWiZT8hbs9ZY6AxPbUGzTGBznJHKzNoaHD46UNnfCqDDyovYoC7a45ZF+HgM8HoHblJa6hAJqDDPcYhXJ9wBWZ5GR+GW269B4MGnfIPdnLKErT6uJACFEM9eOp/SC5s10iAkaQ/paO4t0N8Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778040610; c=relaxed/simple;
	bh=KgEtxFMSFBgGDBgup+ObBtF08VVuo0dTb2HL+cUx/TA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j4VwhtaCm71JdK15lZKtKpI1lvQVyl2M3gy/oV7VgU3kvmSY7AbY9xDDUisnoLT62Qr2fVF8wuUcAMHNcZy+jJbvwHl2BIjCyacjBdSHim0o+HBV65Aevkt5udlLKabJPhaqzzkXiw7uo6+gEXihO9uTDO+SE6xNdO694Kypjs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MsEfnW26; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MsEfnW26"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2f485961555so1891699eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 05 May 2026 21:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778040608; x=1778645408; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FM9y4y6LSFMdzuT0tn43vdAANf+GzZWjwbVrNcc7tMQ=;
        b=MsEfnW26OfN9/B+L5PObnP1onW3V+s+RpqJs/9ktpzzfl3vkGPDzvKPDJH4OjPt2oG
         G2+CbyVtpsOMsfgk/5mfEEXuEyYXblVydoEHyjD7K95HvKkS71BVv/3jkEXW8aMJbhaF
         6jKHIjgMRuvA7yRoUPvWLRNmoQCwYk5MMexbCi85Ulewd6mq9Pb6qmWdOA4PyJ+6Wy3W
         LkcClJL6rr7qrtdnQn//GB71AbsRbpcDS+YyM4CZ1Ovpq8eR4FoSFKG9wp0Gi1YwOy7c
         gB0WZeYyRiXfaAfTUe1CI6S41dqX+tN4xIZEf7+QqfnDJ8SUo9zjphLQ36Qwrjczf50K
         J2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778040608; x=1778645408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FM9y4y6LSFMdzuT0tn43vdAANf+GzZWjwbVrNcc7tMQ=;
        b=G4vzTpWIL32BaqY9/K+YhY0vN9DUwKHFllU+QHO9IoKIAzRzDAszHNyltS94zEAhFu
         srsV4Sof8sewRReHBpfN4tpXtI6YXKwy09ZWYqClDwkN91hDtd9ruYSzb0/aoZh3rBnT
         85LdJvndzsD/R9NlzqXaByONYgPkh/nJ7uHLecnO2Uz8WnRzJNeouPqg3WEknkQHboTF
         SEACTebk/QDSIHZCUQjZsVNYaB5EsvidhGKZpMUq+cr8wa3HOd038QC/PN/eGpB3zA19
         gJhL9CDOUvQvK2/QnK2cbkIos1WvH4iZot2wcIuGC5ptQbg547TWnVBBjs/d1oAYjVdW
         LxSQ==
X-Forwarded-Encrypted: i=1; AFNElJ+2fSX7K1BavpeD2AgdN60aG9xih1X12Im8MYRPcj0cUpCY8V06BAe+QKeq5XxXUicMyFtYfcR4OfT4wIQXYv+Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5zZ7LqUnjP97p/5jEoPnU4S8zq9VGrxuy7NXXwjw40UPQU86m
	856gwtC+TWNqpF8mnMezqC46PMuzs5frfPHE/tHXjnB9ZU6GETgGYXrhestaySVJeSq0qSoTL09
	HcfNrxlL8ag==
X-Received: from dybmd36.prod.google.com ([2002:a05:7301:1824:b0:2dd:d9db:eac0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:9f03:b0:2ee:ade0:e0bf
 with SMTP id 5a478bee46e88-2f54aa78296mr962822eec.30.1778040607600; Tue, 05
 May 2026 21:10:07 -0700 (PDT)
Date: Tue,  5 May 2026 21:10:04 -0700
In-Reply-To: <20260506000018.3113599-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506000018.3113599-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506041004.3196084-1-irogers@google.com>
Subject: [PATCH v4] perf sched stats: Fix segmentation faults, memory leaks,
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
v4:
Address further sashiko feedback:
 - Fix memory leaks of global cpu_head list when perf_session__process_events() fails.
 - Fix resource leak of second session by correcting cleanup order when first session's data is empty.

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
 tools/perf/builtin-sched.c | 175 +++++++++++++++++++++++++++++--------
 1 file changed, 138 insertions(+), 37 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 555247568e7a..fd679b106582 100644
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
+
+	list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
+		tdptr = zalloc(sizeof(*tdptr));
+		if (!tdptr) {
+			ret = -ENOMEM;
+			goto out_cleanup;
+		}
+		INIT_LIST_HEAD(&tdptr->domain_list);
 
-			memcpy(tdptr->domain_data, dptr->domain_data, sizeof(*ds));
-			list_add_tail(&tdptr->domain_list, &summary_head->domain_head);
+		tdptr->domain_data = zalloc(sizeof(*tdptr->domain_data));
+		if (!tdptr->domain_data) {
+			free(tdptr);
+			ret = -ENOMEM;
+			goto out_cleanup;
 		}
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
@@ -4573,8 +4667,10 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
 	}
 
 	err = perf_session__process_events(session[0]);
-	if (err)
+	if (err) {
+		free_schedstat(&cpu_head);
 		goto out_delete_ses0;
+	}
 
 	cd_map0 = session[0]->header.env.cpu_domain;
 	list_replace_init(&cpu_head, &cpu_head_ses0);
@@ -4590,8 +4686,10 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
 	}
 
 	err = perf_session__process_events(session[1]);
-	if (err)
+	if (err) {
+		free_schedstat(&cpu_head);
 		goto out_delete_ses1;
+	}
 
 	cd_map1 = session[1]->header.env.cpu_domain;
 	list_replace_init(&cpu_head, &cpu_head_ses1);
@@ -4607,10 +4705,13 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
 	if (list_empty(&cpu_head_ses0)) {
 		pr_err("Data is not available\n");
 		ret = -1;
-		goto out_delete_ses0;
+		goto out_delete_ses1;
 	}
 
-	show_schedstat_data(&cpu_head_ses0, cd_map0, &cpu_head_ses1, cd_map1, true);
+	ret = show_schedstat_data(&cpu_head_ses0, cd_map0, session[0]->header.env.nr_cpus_avail,
+				  &cpu_head_ses1, cd_map1, session[1]->header.env.nr_cpus_avail, true);
+	if (ret)
+		goto out_delete_ses1;
 
 out_delete_ses1:
 	free_schedstat(&cpu_head_ses1);
@@ -4720,7 +4821,7 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
 		goto out;
 	}
 
-	show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
+	err = show_schedstat_data(&cpu_head, cd_map, nr, NULL, NULL, 0, false);
 	free_cpu_domain_info(cd_map, sv, nr);
 out:
 	free_schedstat(&cpu_head);
-- 
2.54.0.545.g6539524ca2-goog

