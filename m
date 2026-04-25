Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900D73921F0
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157143; cv=none; b=JaL+G36UJJghH6G/s/yl1ebqPH43nxpPPIVtvncTTLnlcbBKi4VRL2H6k7gWD4zDHn3tmzVCtY8V5EcFmHhVaOCr67d/TmW9SkboE5nH1Wdm7AirHJR3E2ONJQRzWkiRKQo8wgeSPIwWpy3AD+MS5D++ERWEfnjYz1StENV/UTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157143; c=relaxed/simple;
	bh=b8WChMU2GFjZaAMy6D9g7SBa1GQPwudhcSXhEV1GN7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QF0xIun2JT7Q81uB0TB3uH0TW3s/szGcARweiu0Z8xNquscr1U/ZzdVyx1p+wdEMvldsbIjNUd5Ph9z38Swk8vYU1u8ki8SUxRT9/L3TDf9h6H7rRM6rbaEv8tG/mTtk1uLHSr9f4w/1cHbFHuCRMIvYWOFTWv9++QwBoZEa/H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p6AUULad; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p6AUULad"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c20d5d7f4so43619187c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157141; x=1777761941; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OlWrNjVnLs3USTmPSqIGY0FmcUo+LUNpaODSh5R9ico=;
        b=p6AUULadNZRHGP9HIi1PWpgcfzRaH5TxIfzlilpKehIBq9NLmDwHOfLU66jDIqhAEy
         UaQKXu9jRtI3VExvOH2YMm/zwnJ1rtEtbKiPRF4J87hm/68/3qc8VT/ytMMIZMXzjhod
         WUGgag209r4xE6DXxRqtzTzIZd/ys6d0jrYW3OqJXIBdckN1KK9IiKQlV8wVTuTm9dkv
         SJydennjcTpCMxAGUrE6Wl95hK+cViByQbhBt4aZyhPTrZtiASF/sOd1Pt/XckBXPq9y
         T6wXZQkdDavHKUdHkoRC58Y7AvuKRnBldp0ruDFJcpSReIawnjtI1UI00urN9aHs3lWZ
         3P7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157141; x=1777761941;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OlWrNjVnLs3USTmPSqIGY0FmcUo+LUNpaODSh5R9ico=;
        b=MyZKI3D4NU71KYFvsHySeMW2z6x0UR/Y8Q+t5R8FVyK3rPimyHgf5lqqa4kKzJfogp
         RV3pXvr6KUDgAjx5f2hxH+HtqyKucY9MjwMbBIQZZ0h+66uXwNi9dsMKJRf5v6O5vP1I
         Du58RHsSxq9sWwXZvTdYP0utd3bp5NbOFSvTmohy3dK5+hmYLUKQQfXBVPXtWXxsaEib
         IwmM0H26el6qlu296YZcWUTF1h8VgD6/Qb4ZgjfKONJ0p23CivDflAnLLeKjmbkRBRmf
         rLJ4k8gpXYu7JBpk+oyj44HJMJNvcGFTqJeF6MMNetcJxFZpU+G4BaSE7G1SsJaND1u3
         OCLA==
X-Forwarded-Encrypted: i=1; AFNElJ+wRM4+r7YVXJVzurAv1vZ9uyoZ/c05aVqBmloHxQY4yCLpsqsGWDflnUh714S/0/oLY8D16AtnCkWzPFbeMxeT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ysOPSZ1ZP+k+FELbqIA2bIROF2tChJnLZWaXOUG9D/EJ/+Iy
	TOZE+JcGcFFHk2lNiO1j/uVtZGVQD58Oe6hmEa6Nfb1/YDjAtPDOfRXZHdR6urXX1q8PM6nfOJu
	UimxWNVfiPg==
X-Received: from dlbto5.prod.google.com ([2002:a05:7022:3b05:b0:12c:1f83:7b4c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:310:b0:12a:b39a:339f
 with SMTP id a92af1059eb24-12c73f95f4dmr20672644c88.21.1777157140384; Sat, 25
 Apr 2026 15:45:40 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:45:03 -0700
In-Reply-To: <20260425224503.170337-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224503.170337-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224503.170337-17-irogers@google.com>
Subject: [PATCH v7 59/59] perf sched stats: Fix segmentation faults in diff mode
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
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
 tools/perf/builtin-sched.c | 85 +++++++++++++++++++++++++++++++-------
 1 file changed, 69 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index d3fa9c70790f..f6c7d100729a 100644
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
@@ -4269,12 +4286,31 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
 		struct cpu_domain_map *cd_info1 = NULL, *cd_info2 = NULL;
 
 		cs1 = cptr1->cpu_data;
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
@@ -4303,9 +4339,17 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
 
 			ds1 = dptr1->domain_data;
 			dinfo1 = cd_info1->domains[ds1->domain];
+			if (!dinfo1) {
+				pr_err("Error: Domain %d info is missing for CPU %d in map 1.\n", ds1->domain, cs1->cpu);
+				return -1;
+			}
 			if (dptr2) {
 				ds2 = dptr2->domain_data;
 				dinfo2 = cd_info2->domains[ds2->domain];
+				if (!dinfo2) {
+					pr_err("Error: Domain %d info is missing for CPU %d in map 2.\n", ds2->domain, cs2->cpu);
+					return -1;
+				}
 			}
 
 			if (dinfo2 && dinfo1->domain != dinfo2->domain) {
@@ -4334,14 +4378,22 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
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
@@ -4523,7 +4575,7 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
 		}
 
 		cd_map = session->header.env.cpu_domain;
-		err = show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
+		err = show_schedstat_data(&cpu_head, cd_map, session->header.env.nr_cpus_avail, NULL, NULL, 0, false);
 	}
 
 out:
@@ -4538,7 +4590,7 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
 	struct cpu_domain_map **cd_map0 = NULL, **cd_map1 = NULL;
 	struct list_head cpu_head_ses0, cpu_head_ses1;
 	struct perf_session *session[2];
-	struct perf_data data[2];
+	struct perf_data data[2] = {0};
 	int ret = 0, err = 0;
 	static const char *defaults[] = {
 		"perf.data.old",
@@ -4610,7 +4662,8 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
 		goto out_delete_ses0;
 	}
 
-	show_schedstat_data(&cpu_head_ses0, cd_map0, &cpu_head_ses1, cd_map1, true);
+	show_schedstat_data(&cpu_head_ses0, cd_map0, session[0]->header.env.nr_cpus_avail,
+			    &cpu_head_ses1, cd_map1, session[1]->header.env.nr_cpus_avail, true);
 
 out_delete_ses1:
 	free_schedstat(&cpu_head_ses1);
@@ -4720,7 +4773,7 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
 		goto out;
 	}
 
-	show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
+	show_schedstat_data(&cpu_head, cd_map, nr, NULL, NULL, 0, false);
 	free_cpu_domain_info(cd_map, sv, nr);
 out:
 	free_schedstat(&cpu_head);
-- 
2.54.0.545.g6539524ca2-goog

