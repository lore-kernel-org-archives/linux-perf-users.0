Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4274B17A59F
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807950; cv=none; b=pWl5K7yaazAxAhNpxzjmozTVI+FZD3JZeCtXMnckbRIHqcIXsQxUL2e9SXBB8O0hFzujXL5LQnrwlIwBphLdMrWIrCQ1SqXXaEEx8Sip99WtRxOQt3rS/XBf5NGsLQO/l329yfRsS7LYHb15cUJyZzMQYWupd833khGPjF0TsAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807950; c=relaxed/simple;
	bh=R2cr19QUh/0PZGh9ohFFVIVNT0Cp0G9UBlrYuAQOwdI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HaZpATrsNGP2ur2HtzY6suNKlskzGEOui+cbUUovoJbl3B0TVL+I6k/iHia6iqzUk13J/yL7JVGEhGxA2V5muPJJt//dsTtuCa9o/VaedHy7lqXplphBxYHP0NwhxJ+DRPIeE+trZ5RrerCc3Fk8m7H7hsVFEeuwtRL2dZXfOUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EK/OhTau; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EK/OhTau"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e039fe0346eso4189854276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 11:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807948; x=1721412748; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=byfF1KS0n4MzwFOMTsFSRoLAA/Zhxt2Mi8AKEzVn+O0=;
        b=EK/OhTauSZzIU5BMw+rGHnwzVqGOZT8XBr/FhjavtEZrs4Y2do5ngoe4iJVa3Jthmy
         OUBxUl553RvmKiAuuvxapLOx5/1oGoJxeWoDLTJ+OeIpHBXPziUN9tjpg4ql2Vg4DzL3
         4FkBHSoN5KQnzJvHqN3OK7NdBrg7vw3Wv1VVrtSnciRrm+zRrrJ6EYyS7pmDXF3bGc5j
         854PgRC4EzbKeEWzjB978lA7oJmeHJS3R8Gkac0AQq5LU02oYdnLorFy1N/++6s7j8WW
         DtVCskyWra+FEXXbGlO9bymFtbGcchOO9ZjbpIfixD7h2uwA+UDHiM+ImGC53E4S4grS
         6C/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807948; x=1721412748;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=byfF1KS0n4MzwFOMTsFSRoLAA/Zhxt2Mi8AKEzVn+O0=;
        b=u/4lWIIJpqDQY0NjPy7IzNCqPgh6S6tuwhAElxvFkK+yPABi7JUhvqTg8QAQ6jJENp
         3xtFGCevFJipWJp92PjMe2ZQ6XD2H7LKy+CaSEVhOpRObkJWNo0EoU/bqIJx4Q5QCG//
         3J4mgEe32LbiJ1//3Zc14SOMnEQj7fwIQPI1FvGvFH8vsuixNElB+CXvIfMpJC0CLCit
         Dk6N6syzHHeQLek9fE5Cj72HqlOesJswxVivijKTaxNon2pkXUGc7LN27P3LhkbCdXAI
         SxaSC+hUpjaCxMgxU1b/x4Jrvcpy6+7ouZatIo9kO2EPWaoKcjyfJO+1SR3OvM7/FnsF
         Myxg==
X-Forwarded-Encrypted: i=1; AJvYcCVsypVVHAOW0lPna7hv4zHpypRIXEluKENT+Zb8aSJERLyKIOCjGaga4cioBAWSpbZfYNylbelt3JszAqJYSA80Qb6gRY9k+IJIZkOwq3VmRw==
X-Gm-Message-State: AOJu0Yx+LSd9fyvDqRvK+4oNNuFTdIGK1IFUy20Lk5HyFnGcPfoJw3cv
	Rd1J4P4b4YxlF0R4MaS+dp8Haye3kjftD5TOlg4F+4gPSSuYKLTD7zds4/645NwScTFJDY2WpLO
	4MQlqlg==
X-Google-Smtp-Source: AGHT+IEDxd6QeNUvZWRQqBsrbT8Osq0gxiaqUBWAnKcNrHvP+zbFleqnJBw9O4ojwhJ+vbzxebyogc6l9y+y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:6902:228e:b0:e02:c06f:1db8 with SMTP
 id 3f1490d57ef6-e041b051473mr24667276.4.1720807948405; Fri, 12 Jul 2024
 11:12:28 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:10:49 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 08/27] perf kvm: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kvm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index a3b903cf4311..692267b1b7e8 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1603,19 +1603,17 @@ static int read_events(struct perf_kvm_stat *kvm)
 {
 	int ret;
 
-	struct perf_tool eops = {
-		.sample			= process_sample_event,
-		.comm			= perf_event__process_comm,
-		.namespaces		= perf_event__process_namespaces,
-		.ordered_events		= true,
-	};
 	struct perf_data file = {
 		.path  = kvm->file_name,
 		.mode  = PERF_DATA_MODE_READ,
 		.force = kvm->force,
 	};
 
-	kvm->tool = eops;
+	perf_tool__init(&kvm->tool, /*ordered_events=*/true);
+	kvm->tool.sample	= process_sample_event;
+	kvm->tool.comm		= perf_event__process_comm;
+	kvm->tool.namespaces	= perf_event__process_namespaces;
+
 	kvm->session = perf_session__new(&file, &kvm->tool);
 	if (IS_ERR(kvm->session)) {
 		pr_err("Initializing perf session failed\n");
@@ -1919,14 +1917,13 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 
 
 	/* event handling */
+	perf_tool__init(&kvm->tool, /*ordered_events=*/true);
 	kvm->tool.sample = process_sample_event;
 	kvm->tool.comm   = perf_event__process_comm;
 	kvm->tool.exit   = perf_event__process_exit;
 	kvm->tool.fork   = perf_event__process_fork;
 	kvm->tool.lost   = process_lost_event;
 	kvm->tool.namespaces  = perf_event__process_namespaces;
-	kvm->tool.ordered_events = true;
-	perf_tool__fill_defaults(&kvm->tool);
 
 	/* set defaults */
 	kvm->display_time = 1;
-- 
2.45.2.993.g49e7a77208-goog

