Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9A01991AD
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495665; cv=none; b=MGSpes9Lt97hYDmx3YF176Rit423n/2xiO2ZCk+gPsxpQU9AKjZAbVsA5INY0CQiOgU72Evz3XIx59Wn4JrU7U8gADo3QyD4V5AMH4kzHQoPLYPoHOBzo5bDH6vytPppNHPinpdzhByfiq6IxGcSBhasGfDjSO/pzo9mhESMbZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495665; c=relaxed/simple;
	bh=4ncXrGc1Au04Ko4PXQputCjfxFfaB5t1gf5Cq17G4fQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=S0SHQtKxeII2J4CM0AAPcOHvbzx4bT5A4epd8R6SB8Nu3KpHvmcjs94RnuPZprXaJbKp3Tuufh/GkN5ZcgPah5ynBiW8/W3EG+BltiOlSaqKFDPEOaGwLaegBmNgc/nGJ3Gsa1+tiOlX1WfTl0hAdQpnSQ/Ur81rkqHDjHnezkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qmf96BCn; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmf96BCn"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-672bea19c63so116320427b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495663; x=1724100463; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+ZE4hGaGGR3pP4ZqeWSlnNcqmSzC0PMM/ghgc3Fa7Q=;
        b=qmf96BCnoJNr1es71K9IvY84wXpSu7ENbUEjWhgtrOE0+A/oxuXY1e7PKFn5vSZY7F
         MSej6VGdvIA5zw6+oKOGSecu8PDlmNvLiPl98aG99WAd0IyIZLyuRtdG8OMwWpt2jkQ0
         cC3ognT1bHGbLUHv94in0I0yRwjmgvPUY+Gp83eJu0ipDgEYRJ7dxq/WpVHHx2lTeUY8
         HlOUikl71Xwjb+IXVl+sZllFsMHJ0WEVNoxWI2BPNKy2fAzv3GFQ9rKlhor3PzWMvAxq
         QC/X6UbFqOJ+3JxHMguoMc4yJMmqNFJ1ZreVhK7qi35nsQngKC2HdCKJJ6dFjg/Uqc7y
         Xzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495663; x=1724100463;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+ZE4hGaGGR3pP4ZqeWSlnNcqmSzC0PMM/ghgc3Fa7Q=;
        b=o2Zeu3kq9ziTPpJmdWiwQJQKyWLsxiR0rtTF12twuBZ1GlWFFyA3WN2fJ2ENw7EbAH
         JCD/QatuZo/Ran5ZGAV/UWiJHhEBzOAxp0KcN7w8pAgyevOqIqGS4vQDOqvCWGvagSVi
         gycB2quIjsHgFz2AFKj9MUNDQtlMVQUOz1C8gT45wy3RoRPj7guyGKXyqXVv52BkwwoM
         cUkdO6lNSCIvCAdCLnzex8oesmMFcyYIRMrBg/yPd2S3RDMlQqtStAek9UIkBUWgtJXA
         GHwE7UAZ00DGaqmc4ycQsr+5dQ2+dMwH+46rLJnDkyI7cwK4kpEh1i6aTriP4zQNgayF
         DKYg==
X-Forwarded-Encrypted: i=1; AJvYcCVIG3AMh9RYFe39cOXFe7JKjxnsbAjspaKLtLNRuMExArVhIf+iS03XINIcEzFj8wMq9AbSM+v+yk8EFEkv+Q7+VLXMnExq1w/qKJk2JTyC0g==
X-Gm-Message-State: AOJu0Yx1J09kEqfeBWT/iUfm/r70LruSayjqUDB5hFDPN4U6q597CrH6
	J/jFS8uyRb7gw81JjFLxD5W0J8g7kmoI38LfRFs/nMK3/dEzdvfXnDNbSaBEzI+TWsrlfyRM9OH
	NK/ACJA==
X-Google-Smtp-Source: AGHT+IEerIYYJMTu/WL1AAclxKU7AxacYY9i7Q1kNURomiSUM/HLMAaiSiuWQSgOAjqMtefBIzHzejkjQcGm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a0d:fc03:0:b0:646:3ef4:6ad2 with SMTP id
 00721157ae682-6a978785122mr109817b3.9.1723495663340; Mon, 12 Aug 2024
 13:47:43 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:00 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 08/27] perf kvm: Use perf_tool__init
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
2.46.0.76.ge559c4bf1a-goog

