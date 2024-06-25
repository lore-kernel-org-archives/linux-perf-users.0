Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BACF17C7A4
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336384; cv=none; b=NqHJcIBmjeZm98L2peT8/cIqq5N3pynz5lY1/IHY2P2kDRrs/Mph5qsv4UPpftQhTDWpyt0CHCgyqWTDs8O/Q3U1KOgXjhnLALRQcjGjkpfb5btDvR26BjpKkm/2S55W/HbfDwD8h/oH/xn/InjAUId/4NikuytpwOMSotbhHpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336384; c=relaxed/simple;
	bh=4f3xu/fTKlsZKLAxp35O5+huY8NAWRnMLMbKlqWg7eI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=UiIhUgu2m9mmLbEtTGaxqnEzcvRln1pVLn5K+jMnndq1UfdhO3WUWp8ceqfhhZpMjfs5wU8E429zIBNI+XGH4ToYgQsHopuAW1Tr+NNQtXnoQ/5LhDlJeGxo5OSy/4BLU/RYjvktG3C3lzhJnn+ZpkUnAFJpE3kLngQGrii96yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dvDEkXGo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvDEkXGo"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-63bf44b87d4so65856217b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 10:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336382; x=1719941182; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0D3Ll4YJxFSzRg0DxL5KKZwtYxMwAkaxOfW7jAWfCz0=;
        b=dvDEkXGoJFB/3MouB5XDJ7dgmWHHS/tz9iRyILDKwObsk40Xj8GPw/oz/JtiUCkuY/
         YHAi6BUChX5pIHWlijdX+PFC/sTcVCqIXc3Oro0F9Ne0Khxgo57pwnukyX/HKCVvUclp
         hKpVV4oJQCcC4YeCG9ov5EvAjPQSch6RINkuyRJ8VbUcT0uYyfj/aoAnwBU/98CrTm3i
         LTYdMgBF/c2fKlw6f+U7STc6Ahk3DCAEJVFqnXJOREcxmQGubzive2YNPbwytyZXZXYX
         XyAK0J0zWL2iA+Dmw77AT/7U7tNirxP9br0sDqh7stxfwEnANpefGqvOrX4SMsWTcRkF
         jWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336382; x=1719941182;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0D3Ll4YJxFSzRg0DxL5KKZwtYxMwAkaxOfW7jAWfCz0=;
        b=tg8r9QFG3Wt4QJX2HdGC85Z2kGZJaXzb+GN/8GFTsotyiHwfP2xWtdS0F7rixziE0S
         oCBX2y66QRUW9WcdhvhHxj6BTioYLs5f9W/OXAkkMTIVoZc7cl3Q9LNKnUHrEZWyfmBO
         0XEsG/eMstidMyGbEJsXK+LZleUPYhFrUWhKQfXXviCZZTtgUqxIuMzN/BGJ9z7/uSWH
         nIzXmfujwTiWXt4BxKIZ2Fa8gB8rsWTQezOMzw0QawaKPwQI4ddB619l0nbqayRa4Q33
         BdKUGEj8KEmgY1NvXnvH5ZhzRsR6WonqytmUbbfiAQByy6aQLkweJ+tZZm68MtYeEljh
         AhFw==
X-Forwarded-Encrypted: i=1; AJvYcCXKtVzZIAwfGv0zY5PplX0eng/MONVHx1YnAzb4E4VeMJHoScTrXmvVgWM87PRtTmp44o/3IeDlFZtAt5Il9VIekPpefGob6Jq+Ofl48NMTMg==
X-Gm-Message-State: AOJu0YyIgqNe22/s5NTTXv9/A/NRYo647c8vF/+Dk8aiv8TEA0Q4ULh+
	il8DwwEQE8Jdz8tCN7Ty/wtwg+UrTaXurKsXLZqCTIjeJPqwndlfm8EpIF/TvWnBQF1d++iqQ7y
	ccf9jew==
X-Google-Smtp-Source: AGHT+IHTa5kZKd9h8ifXYMe2T99DgFi/uV4x8OfhUXLRdl9AjprPNPjesq9BkyxfvYvf643IgrcWtu2wbIrp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:690c:f09:b0:62f:1f93:939e with SMTP id
 00721157ae682-642544fa2a5mr2623767b3.2.1719336381892; Tue, 25 Jun 2024
 10:26:21 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:43 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 06/26] perf kvm: Use perf_tool__init
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
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
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
2.45.2.741.gdbec12cfda-goog

