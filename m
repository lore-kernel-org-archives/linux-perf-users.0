Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C628346A13
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328755; cv=none; b=u9t4rN9pI0QkRfTZrxiSLx4xfHgY41i1wz3KDyH62QNfdRue7Lhdo+KYDFbwIFjNJIbIDUaevKCHnFdJuAdAPNcPseMe3AiknpWoKbK4yGpZF4Mo1/kh4fKL2gCQXU5RfTKjqxW9pP0IkG3nBppeuEdBAM2ReAUAradnFzAVa9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328755; c=relaxed/simple;
	bh=e4R6AVkXL/b1gApEzWYidv1J/iqwS7GQ4hazLe6UCLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uD27Crape8fs8/yHDNw3ht0KnUtkmQ9AknIsf3ZS87fNQh3NWAs/V/c3fqAwZao1TZ7Pb1ptOu5nJfe8WaaMHblBVjZXRYR+9YxZtT0T2BZPN+eRjVW2yqM4mcxbOndAD4lmlmTd/iRIiJfWhdHje+CjyEHjjvtN5w5WjH+zFvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qZii0vf4; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qZii0vf4"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b522037281bso1442454a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 10:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328753; x=1761933553; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nG2hV1s5ki9YDnz6tl1mLOAmUldYkmEMzzCVZ1F8mHU=;
        b=qZii0vf4cZqcISjkB2gZFbGRrAdyCZ7zFWbRFMLAMfhLowyYGD5v92Hha0wQpzFLzq
         olGjzLv8Km6yYuh1bKkk4j5NaQVCo1NYUf1Eyss0L3jL8QZvnKkqTVfdiyxjt6PN6okI
         Vb2ZKPGjb9MYujb73/CrHhgOMu94FljpYLK9i+y8v+3lOScwYyf96i0faoc38iuY0mxU
         GaMcfs80S7kQUi/XFeFT8vayWIANUvGAAvkEfD0lXmFj3hRqO61bx+8qU5sqh+93pfiB
         +ecpFhYKaBon3zLpdC1V7EeH8YAfmJOaKO1KekK+DveSw78gvYycgaNwAcUPCnl6fCdN
         59AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328753; x=1761933553;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nG2hV1s5ki9YDnz6tl1mLOAmUldYkmEMzzCVZ1F8mHU=;
        b=ej/nGpwYF0odY7eOysBzkBD7V56dhuKgQOn4lVslZwP+u1c6kZzWa0P7W13PQ1c6sc
         QJRQA/5AK9AFF1DX/SqgVaC5nhlmeJpaoDKSNxKNU+Ytfk9dmRr3HR4IJAamfsvs/fAQ
         Sfwvyf5AAG4lZdToCSZq61kW/R3+lu2yoGNCQ1Wrp0//KduRIW6BlWmDZcusb+2YEG2l
         UkuhH8T1WiPFYgieu6w/tsebaaIdo9sDtFTleuggjATImXx+VGCxNQr6gxGyFIGgQNJf
         16urcvzN+IEr6OLduA5sBMU1bQB08o/t6wbZSiW2YowPnl77L1EJkmI8ugQ5SNel5+I5
         GVjw==
X-Forwarded-Encrypted: i=1; AJvYcCVfo5rfqy04M5VrkTX/I4wrwcv2sPS33B4kXdfbZvntNbgFOdoKSpkWVz5oKKWav/3RoA2K1HJH3Y7pJ7KQN49z@vger.kernel.org
X-Gm-Message-State: AOJu0YzQBQf6ccAQM0gdVMi/lRuD2r/TGUn494hBwD411SxiaO0frMB9
	VBYJDuisFCnxl3zmfyxzEFdkEQF+kpnrzj+0ox9DXdLJCyt8pBuGOVp46Jgw6CKFh3aB7J38mCp
	Xaii8ExKQXA==
X-Google-Smtp-Source: AGHT+IErrc3a+M+Y7idOuC3m/1xAORwpqR28MnITxE1vZU6cFGOIA0Krct48wBGfAWPzIT+JWfWUg52NODQo
X-Received: from pltf1.prod.google.com ([2002:a17:902:74c1:b0:267:ddd1:bc97])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d506:b0:290:c5c8:9412
 with SMTP id d9443c01a7336-290c9cf37demr393918065ad.5.1761328753299; Fri, 24
 Oct 2025 10:59:13 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:41 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-7-irogers@google.com>
Subject: [PATCH v1 06/22] perf jevents: Make all tables static
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The tables created by jevents.py are only used within the pmu-events.c
file. Change the declarations of those global variables to be static
to encapsulate this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 10 +++++-----
 tools/perf/pmu-events/jevents.py         |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 336e3924ce84..5120fb93690e 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -2585,7 +2585,7 @@ static const struct compact_pmu_event pmu_events__common_tool[] = {
 
 };
 
-const struct pmu_table_entry pmu_events__common[] = {
+static const struct pmu_table_entry pmu_events__common[] = {
 {
      .entries = pmu_events__common_default_core,
      .num_entries = ARRAY_SIZE(pmu_events__common_default_core),
@@ -2630,7 +2630,7 @@ static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc_free_r
 
 };
 
-const struct pmu_table_entry pmu_events__test_soc_cpu[] = {
+static const struct pmu_table_entry pmu_events__test_soc_cpu[] = {
 {
      .entries = pmu_events__test_soc_cpu_default_core,
      .num_entries = ARRAY_SIZE(pmu_events__test_soc_cpu_default_core),
@@ -2682,7 +2682,7 @@ static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_core[] =
 
 };
 
-const struct pmu_table_entry pmu_metrics__test_soc_cpu[] = {
+static const struct pmu_table_entry pmu_metrics__test_soc_cpu[] = {
 {
      .entries = pmu_metrics__test_soc_cpu_default_core,
      .num_entries = ARRAY_SIZE(pmu_metrics__test_soc_cpu_default_core),
@@ -2701,7 +2701,7 @@ static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_ddr_pm
 
 };
 
-const struct pmu_table_entry pmu_events__test_soc_sys[] = {
+static const struct pmu_table_entry pmu_events__test_soc_sys[] = {
 {
      .entries = pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
      .num_entries = ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ccn_pmu),
@@ -2751,7 +2751,7 @@ struct pmu_events_map {
  * Global table mapping each known CPU for the architecture to its
  * table of PMU events.
  */
-const struct pmu_events_map pmu_events_map[] = {
+static const struct pmu_events_map pmu_events_map[] = {
 {
 	.arch = "common",
 	.cpuid = "common",
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 1f3917cbff87..786a7049363f 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -550,7 +550,7 @@ def print_pending_events() -> None:
   _args.output_file.write(f"""
 }};
 
-const struct pmu_table_entry {_pending_events_tblname}[] = {{
+static const struct pmu_table_entry {_pending_events_tblname}[] = {{
 """)
   for (pmu, tbl_pmu) in sorted(pmus):
     pmu_name = f"{pmu}\\000"
@@ -605,7 +605,7 @@ def print_pending_metrics() -> None:
   _args.output_file.write(f"""
 }};
 
-const struct pmu_table_entry {_pending_metrics_tblname}[] = {{
+static const struct pmu_table_entry {_pending_metrics_tblname}[] = {{
 """)
   for (pmu, tbl_pmu) in sorted(pmus):
     pmu_name = f"{pmu}\\000"
@@ -730,7 +730,7 @@ struct pmu_events_map {
  * Global table mapping each known CPU for the architecture to its
  * table of PMU events.
  */
-const struct pmu_events_map pmu_events_map[] = {
+static const struct pmu_events_map pmu_events_map[] = {
 """)
   for arch in archs:
     if arch == 'test':
-- 
2.51.1.821.gb6fe4d2222-goog

