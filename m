Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2214F16DED4
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720852; cv=none; b=pUizZRLYIooXL9XBG7b3r8W73nz3cCsN5/g/teU2KGFzeyhYtgttcwZXHcLMdoOfOii07eFNHTVo/QtTOshwO7Xbep+RIp2C6P3P5xtYgabKmQHp9r33Kwg/syl4Oahn8I3Me+aKk2yll01CZNsY2T/F3qKT0TCGS8mArx0mV5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720852; c=relaxed/simple;
	bh=Oatp9vP9864WSMM6h8L2eaSDz2osyW3W6s5tTUlCsXc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=m3U7P5iTiSSD/iDuAoYosM9a74WfvnCxMyT6nOazZ9MG4kdI6Z9U+buwJNJmCuj0uvJLnPPQfsL8OpVqE7dgHGs59D9YgbMBmkA1pWKGxSw4Q1jocIENpyCWW/cvrZUZ3mSpuCjYkCFOFCWCLo/HkIyR/TcDXDqbVzfWCynLbUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQ+EHzBs; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQ+EHzBs"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e037c3d20a6so2006032276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 11:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720850; x=1721325650; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GhKzAhRYOz6Ff/7gM3raH2p2+7D3XZwc5l/hw9g7Qeo=;
        b=XQ+EHzBsqiEcyC1OLV/z6kbr3tYYMGObVGtYoVNXSJEn4JGBMNUHFolsOsa/v6O/Ao
         pJmhk/BUYUpkU/Gi/iDDK+X/ucQjHaYCUSFv2D6Xwct/nlvxemA0gXNp3PyJ8cBQRbHa
         viJAcHRsoTwea0jNxa6sEIKZqvrArsxfgHSRMMXOM34WIiPfM07IqqImHpaQOoxBDLUM
         C/iwqzlSCKpHoy/3fDMe9N6SFTL8fas3dMPfBsVfm6WE9l8HODMhwHKRhbWlTO0ER++O
         4zNg11iOSNNYZShnbvXEVyI+scqGKb0wUuEgMl/nz2jIriYnu2yZ5peGmN6612U7estA
         w83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720850; x=1721325650;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhKzAhRYOz6Ff/7gM3raH2p2+7D3XZwc5l/hw9g7Qeo=;
        b=Es8KxVINqFHOf7/LJ8Tp838cNSB67mt8kQGWBmYoxfYmdbtkI38LUEH6cxG85BSsUW
         4bRJfEZ01y81ehlx1a/zQP9fmbZFUn8WI4TX1LDE0biZc89+vSOvELti+apGzx3soJ5V
         rV4XXeHpLFZzXwmjHTkbAiMgnN01wTqmjw2q5xDgfFqKokHP/h/KUQjC0ZdfjUhrkU/I
         KzigV5CgCQDoofPDNrUNXpRjd8lMnN0tvgDixir6LMs1hs+/J6Y5ZMOkCQqnxRXPxfEE
         pWP1PEJ2v9knUfxT5UPWvKs2BPp80vI8CXeJvn+yJDD+jbNHIF0YPH4MMTd/bCFNEi+N
         gpKg==
X-Forwarded-Encrypted: i=1; AJvYcCXifSywIbdYHrune6hbfA5n06KgMtYrge5yaAgpu94nns8OJ24ZBLqvOOxd6AquINiSQ/MzCrncpgWpp2E7B1iz57Zp4hXAvmZO9p08Qddp5w==
X-Gm-Message-State: AOJu0YyDTmcb4ys9tytO77MTLa1Yew5rDjKvMGs5eJyWuelfZv80AtHU
	0tgnYymzIIOPAap9ChY6Ck9ievJzEe+Rf8f3INed5aKVVqc0HfRB30rWN2ztT/sViIVFkX7ZCNo
	vs/HzUA==
X-Google-Smtp-Source: AGHT+IFqVvherAEk1x3Ir8n4fHhcFmi1xD/c2UbKwwjpP39A7XPMyOqoevAXhv8slX5yfHAkD3bxc1fO1Qwh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:274a:b0:e03:2f8e:9d81 with SMTP
 id 3f1490d57ef6-e041af3b67amr47129276.0.1720720850095; Thu, 11 Jul 2024
 11:00:50 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:59:57 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 17/28] perf stat: Use perf_tool__init
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
 tools/perf/builtin-stat.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d460c46f15fd..a3d77a55d17f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2271,15 +2271,6 @@ static const char * const stat_report_usage[] = {
 };
 
 static struct perf_stat perf_stat = {
-	.tool = {
-		.attr		= perf_event__process_attr,
-		.event_update	= perf_event__process_event_update,
-		.thread_map	= process_thread_map_event,
-		.cpu_map	= process_cpu_map_event,
-		.stat_config	= process_stat_config_event,
-		.stat		= perf_event__process_stat_event,
-		.stat_round	= process_stat_round_event,
-	},
 	.aggr_mode	= AGGR_UNSET,
 	.aggr_level	= 0,
 };
@@ -2322,6 +2313,15 @@ static int __cmd_report(int argc, const char **argv)
 	perf_stat.data.path = input_name;
 	perf_stat.data.mode = PERF_DATA_MODE_READ;
 
+	perf_tool__init(&perf_stat.tool, /*ordered_events=*/false);
+	perf_stat.tool.attr		= perf_event__process_attr;
+	perf_stat.tool.event_update	= perf_event__process_event_update;
+	perf_stat.tool.thread_map	= process_thread_map_event;
+	perf_stat.tool.cpu_map		= process_cpu_map_event;
+	perf_stat.tool.stat_config	= process_stat_config_event;
+	perf_stat.tool.stat		= perf_event__process_stat_event;
+	perf_stat.tool.stat_round	= process_stat_round_event;
+
 	session = perf_session__new(&perf_stat.data, &perf_stat.tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.45.2.993.g49e7a77208-goog

