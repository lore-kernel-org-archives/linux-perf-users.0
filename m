Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC2D389119
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777484383; cv=none; b=hUU8G5TlKRt/ed4qfJZoIF0YaE90IeBZeML8sy51EAzWfNukuzV+RueVA8A3EQYuhZGtQYtZhNI94FzHSQJKcONfEnw4D3RIVLiufYllfFzcY2bXpi0q2SnB/BIvAUFLkoj/gpZDbUuKABv6pVA8sdSjX/aYrD5pFPCx38uTHzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777484383; c=relaxed/simple;
	bh=Cxfs6BrKbk8Hmj2NCwcNIHEx+PxcQPb6YSZJ6SLDqOw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jBdOrHtPc/14BVkVhlD2QJ74jqxDbh6DrMq7P6Fx+ie1daB/ZH3I/sK0/Bgar3pZI4N4c9Az7Rf7GJvTkAhTe/rHIPn5b52/9uxaVXJJInzBWSfq4WRdQhVH/KShl2DwlbP3eztqTwWj7EGEu7P51+oqmwgUwo9Yt2RalHt/0c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dufkokAd; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dufkokAd"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so109053eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 10:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777484381; x=1778089181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zLqmLZ4d7fUh/CVhR3o18ChsxBByPqQtRNWEPoYBylo=;
        b=dufkokAdrkTBUWOoUpCmACVz1fGXVfbxY6ypZUbb61+ykHuDIDhOY/wLhK+t4izb0o
         /ozLaR1DH7V7h4U7YFUUuJkWqOy/+2FnaOjnIyXevDSC3M7um0diZur2Raf2kLbbStJt
         +TTX4zgR5hOZKTLmaEhwt64HmYDjdOj9L762ZqjWxyuApmKtvJUvCkTsB3jIhDhoimia
         tWxPiRGqffyJFBlY7UT9p2sauxeDbAkE6WRWn245xkUCFDQjzRiyJ+EbFQzJEMdoX2/X
         3RumHsKkFn3Fh9LV6WLXVmH4R0KrUjxChFNQOCUa8KlU8sb3mHgy8N9BzrfcuvTTY+Zl
         IWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777484381; x=1778089181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zLqmLZ4d7fUh/CVhR3o18ChsxBByPqQtRNWEPoYBylo=;
        b=T+5dIK6hTAPAK85MMEyYPi6UXcK0u0WX8iApCK+DiXDKbWfP97Dfh474ioBKUF0oGa
         hmGg/TNSKQpIr+BsmyDmUgvC11TxyHje6LvHpBLO9JUmRRvhWVd64UDeHbsVqH8JB3Zs
         S6T1s1ijHeYylfkGUWQPQuhRvFAcJJtG3pfH4J6toXxf7AbvL0Y01kqOOwFD4SPsLaJP
         +Qdun+wyCxmfZCF8Z1MMIRmapmQIlBnro2KC2IXt1vG6g8oSFUJXxJgqdpG53Bkum+tH
         wDGY/7cvRUpFblGPlftcAvBWq8xiTfTNTUDCgC6kJZlY9LT12oL03ML6hOF5GwVtwQ/h
         or/A==
X-Forwarded-Encrypted: i=1; AFNElJ97U4mebYzl7y0qyvrGwPQ1oyOXYy3gdsPd7fHw+ZF2br8CHHl6hUqKMAsTWGpbOmDjiEmcQsGZrXAmZ4e5lluf@vger.kernel.org
X-Gm-Message-State: AOJu0YyhB0X8L2CowMGRniHPfRPvBITyJwH15SU3ABiBOSURSOEOG/sN
	s8+CJLZZHpLbGcLX1YKA25W1y217gVRVfZMBAJ5cnYyANps0UQdf0NXpYsbueM9A/s94SHefLT9
	/IuWEWKu6vA==
X-Received: from dyjf18.prod.google.com ([2002:a05:7300:6812:b0:2e6:1dc6:691e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:40c4:b0:2ed:e14:7f5f
 with SMTP id 5a478bee46e88-2ed0e148557mr2749979eec.35.1777484380515; Wed, 29
 Apr 2026 10:39:40 -0700 (PDT)
Date: Wed, 29 Apr 2026 10:39:31 -0700
In-Reply-To: <20260428070811.1883202-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428070811.1883202-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260429173931.2700115-1-irogers@google.com>
Subject: [PATCH v2] perf sched stats: Fix segmentation faults in diff mode
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, atrajeev@linux.ibm.com, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	venkat88@linux.ibm.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Address several segmentation fault vectors in `perf sched stats diff`:

1. In `get_all_cpu_stats()`, added `assert(!list_empty(head))` to prevent
   unsafe `list_first_entry()` calls on empty lists, fixed uninitialized
   variable `ret`, and added `list_is_last` check when iterating domains to
   prevent out-of-bounds reads during parallel list traversal.

2. In `show_schedstat_data()`, added NULL checks for `cd_map1` and `cd_map2`
   to gracefully handle invalid or empty data files.

3. Added parallel iteration termination checks using `list_is_last()` in
   `show_schedstat_data()` for both domain and CPU lists to safely terminate
   at the end of each list when files contain a different number of CPUs
   or domains.

4. Added CPU bounds checks (`cs1->cpu >= nr1` and `cs2->cpu >= nr2`) in
   `show_schedstat_data()` to prevent out-of-bounds reads from `cd_map1` and
   `cd_map2` when comparing files from machines with different CPU counts.

5. Added NULL checks for `cd_info1` and `cd_info2` to prevent crashes when
   a CPU has data samples but no corresponding domain info in the header.

6. Added domain bounds checks (`ds1->domain >= cd_info1->nr_domains` and
   `ds2->domain >= cd_info2->nr_domains`) to prevent out-of-bounds array
   accesses in the domains array.

7. Added NULL checks for `dinfo1` and `dinfo2` in `show_schedstat_data()`
   to prevent crashes when a domain has no corresponding domain info.

8. Zero-initialized the `perf_data` array in `perf_sched__schedstat_diff()`
   to prevent stack garbage from causing `perf_data_file__fd()` to attempt
   to use a NULL `fptr` when `use_stdio` happened to be non-zero.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2: Reduce indentation and variable scopes. Hopefully address feedback
    from James Clark.

Previously this patch was part of a large perf script refactor:
https://lore.kernel.org/lkml/20260425224951.174663-1-irogers@google.com/
---
 tools/perf/builtin-sched.c | 144 +++++++++++++++++++++++++++----------
 1 file changed, 106 insertions(+), 38 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 555247568e7a..e67241415255 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4170,40 +4170,40 @@ static void summarize_schedstat_domain(struct schedstat_domain *summary_domain,
  */
 static int get_all_cpu_stats(struct list_head *head)
 {
-	struct schedstat_cpu *cptr = list_first_entry(head, struct schedstat_cpu, cpu_list);
-	struct schedstat_cpu *summary_head = NULL;
-	struct perf_record_schedstat_domain *ds;
-	struct perf_record_schedstat_cpu *cs;
-	struct schedstat_domain *dptr, *tdptr;
+	struct schedstat_cpu *cptr, *summary_head;
+	struct schedstat_domain *dptr;
 	bool is_last = false;
 	int cnt = 1;
-	int ret = 0;
 
-	if (cptr) {
-		summary_head = zalloc(sizeof(*summary_head));
-		if (!summary_head)
-			return -ENOMEM;
+	assert(!list_empty(head));
+	cptr = list_first_entry(head, struct schedstat_cpu, cpu_list);
 
-		summary_head->cpu_data = zalloc(sizeof(*cs));
-		memcpy(summary_head->cpu_data, cptr->cpu_data, sizeof(*cs));
+	summary_head = zalloc(sizeof(*summary_head));
+	if (!summary_head)
+		return -ENOMEM;
 
-		INIT_LIST_HEAD(&summary_head->domain_head);
+	summary_head->cpu_data = zalloc(sizeof(*summary_head->cpu_data));
+	memcpy(summary_head->cpu_data, cptr->cpu_data, sizeof(*summary_head->cpu_data));
 
-		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
-			tdptr = zalloc(sizeof(*tdptr));
-			if (!tdptr)
-				return -ENOMEM;
+	INIT_LIST_HEAD(&summary_head->domain_head);
 
-			tdptr->domain_data = zalloc(sizeof(*ds));
-			if (!tdptr->domain_data)
-				return -ENOMEM;
+	list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
+		struct schedstat_domain *tdptr = zalloc(sizeof(*tdptr));
 
-			memcpy(tdptr->domain_data, dptr->domain_data, sizeof(*ds));
-			list_add_tail(&tdptr->domain_list, &summary_head->domain_head);
-		}
+		if (!tdptr)
+			return -ENOMEM;
+
+		tdptr->domain_data = zalloc(sizeof(*tdptr->domain_data));
+		if (!tdptr->domain_data)
+			return -ENOMEM;
+
+		memcpy(tdptr->domain_data, dptr->domain_data, sizeof(*tdptr->domain_data));
+		list_add_tail(&tdptr->domain_list, &summary_head->domain_head);
 	}
 
 	list_for_each_entry(cptr, head, cpu_list) {
+		struct schedstat_domain *tdptr;
+
 		if (list_is_first(&cptr->cpu_list, head))
 			continue;
 
@@ -4212,32 +4212,47 @@ static int get_all_cpu_stats(struct list_head *head)
 
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
 
 	list_add(&summary_head->cpu_list, head);
-	return ret;
+	return 0;
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
@@ -4267,14 +4282,36 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
 
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
@@ -4302,10 +4339,30 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
 			struct domain_info *dinfo1 = NULL, *dinfo2 = NULL;
 
 			ds1 = dptr1->domain_data;
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
@@ -4334,14 +4391,22 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
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
@@ -4523,7 +4588,9 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
 		}
 
 		cd_map = session->header.env.cpu_domain;
-		err = show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
+		err = show_schedstat_data(&cpu_head, cd_map,
+					  session->header.env.nr_cpus_avail,
+					  NULL, NULL, 0, false);
 	}
 
 out:
@@ -4538,7 +4605,7 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
 	struct cpu_domain_map **cd_map0 = NULL, **cd_map1 = NULL;
 	struct list_head cpu_head_ses0, cpu_head_ses1;
 	struct perf_session *session[2];
-	struct perf_data data[2];
+	struct perf_data data[2] = {0};
 	int ret = 0, err = 0;
 	static const char *defaults[] = {
 		"perf.data.old",
@@ -4610,7 +4677,8 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
 		goto out_delete_ses0;
 	}
 
-	show_schedstat_data(&cpu_head_ses0, cd_map0, &cpu_head_ses1, cd_map1, true);
+	show_schedstat_data(&cpu_head_ses0, cd_map0, session[0]->header.env.nr_cpus_avail,
+			    &cpu_head_ses1, cd_map1, session[1]->header.env.nr_cpus_avail, true);
 
 out_delete_ses1:
 	free_schedstat(&cpu_head_ses1);
@@ -4720,7 +4788,7 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
 		goto out;
 	}
 
-	show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
+	show_schedstat_data(&cpu_head, cd_map, nr, NULL, NULL, 0, false);
 	free_cpu_domain_info(cd_map, sv, nr);
 out:
 	free_schedstat(&cpu_head);
-- 
2.54.0.545.g6539524ca2-goog

