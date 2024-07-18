Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DA539856
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 01:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264458; cv=none; b=SOZTZHvkotQ8WHN0hr1O3pkqXpq2LURNln3JRG/XeZvhtM0gs/VUUu/USxmrptgAwq9dWM3oA8St/y03H2ZLEBc1jNKiDkvbPmvBxHz8P3zgbRoW89lf6UxjxNpqJ+Pni69+u0+vzg9ObuMknX4/leelgUYxlFzzHYTSMuMEXIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264458; c=relaxed/simple;
	bh=paspNSWQHb6+z/1X51Qf6w7AhPpM2hKwGkk+VGJD374=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DUcdDb3jB0dQh7+A3ElQmpPeonTAMNE8uSczHHjSFr3kTatvbJC1nRfQYB3bHw6HdYClACPZzrVhqNsILh3YTNTOiRqjV2HcMqgx7AMgJfdymXPPkde4Z6+OdWN61aeqmeUe47gJoI0T2Vm434H31IVWjDFN5BFBPxYp39SCeDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VqP/vfWd; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqP/vfWd"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e05f9611400so631564276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 18:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264455; x=1721869255; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ai5lnf0BUO6/UnVTaHRIu7hu7sAuyoUd1EC+9E9ZCBs=;
        b=VqP/vfWdf3VRwNemq77UtD4xhYyvMfnVgxOro//I1dAsfOpB7/vidOxOA2RitD9Q7k
         qPL4ZCar7FphcqXNcVV6+tYkNSFNcl6vosBruSGyCG68rYOWejoTEWGPDJW+B+1f391X
         fqDdZ7/Vdilji7vhhh0w09cZfUjdR//RwLNbO+toNoZLQ+NpoSnRuOwlBrXdVx8CLn8z
         DTnU8YpuELP3V/mUFSaSGWyWOjLLdQOUE1XOS6WRMMamC3KmtM3emMeWiy2H0HA6tQeB
         bHGYhZOhlWlXfF13oS2r+H0JN03VlRW+8luC1LNBAPFtfoLUQP7OFH0aYXeJDNdcTYib
         spww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264455; x=1721869255;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ai5lnf0BUO6/UnVTaHRIu7hu7sAuyoUd1EC+9E9ZCBs=;
        b=Y6ezEi6gLzBV6oZPODpHPWy7lckNU3KzjpE2tiYXRzvU+fTWgJ8Q4RB6rD9O92naBL
         Kbooi8kYZhEIsKoOWbH2qG9MHCpmckhvH/QAbOAmuvSPdaPub/3+TH812oQifatvU4ta
         yN13a5HdaUn/HHzaQqwoAD8unOqbwcK7YO8nPwj8HAqNyVESUKBKUPG4+N48gdi2iQHH
         9AfMJT8uFIUSHZomuUSAT/uZGUs45Iw7DZeEVmVsA7USFsDf0JiOv3QEcfLqBhdjvxW3
         fLrNlgp1VPGye1UwWQUH19MVKddAoK8M+AJuDLon2Nj0283QrCbPvymF+6gS5pjKUaCN
         +Yjw==
X-Forwarded-Encrypted: i=1; AJvYcCWxRoVeBHPj3SMhBrkQG87Qh/a/1MjUdNoRE8yWbpVTIfDD2JUq7mL5Pn2Gkl4nMEIYr0cTMt+RMfIBdjy4ZnET4I9QieW2SpVJqAhP3KInOQ==
X-Gm-Message-State: AOJu0YwUT/pLazHWRbi0N4ezf0QL4sGRK81sFGmDwknvLFilkeVUUgWm
	i+vJhQw1FhvGB/0cfvdmLHUhHdENOeheCm9tLrOaInVhRnTLNDSYxPA8MMtUzaLGZUUfWrRgxXM
	uPrVlpQ==
X-Google-Smtp-Source: AGHT+IFez645P/F0hZdJQXU/7kuPyHdktbnSXSbfLcl/dMKl+NBTQzET3BcxRmAOKtpToRAendNoVwwOs114
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:102e:b0:e05:eb99:5f73 with SMTP
 id 3f1490d57ef6-e05fe83bae5mr2806276.0.1721264455354; Wed, 17 Jul 2024
 18:00:55 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:04 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 08/27] perf kvm: Use perf_tool__init
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
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
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
2.45.2.1089.g2a221341d9-goog

