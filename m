Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3FD179956
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336404; cv=none; b=ilRGssCY4HtPVBFnylcrSMxWVZmRCb1HGCBhqiAuyZsKFFD6T+o/TsFXrJadjEYoXA+PLHxjZyhd312M1LM57bKPt7URnqGrk4MHw21rx0+0jndPNRfp31125DY6SSfyW5shieiNEIx4RADIkjun5VXiw1H7Y0X3elf6ABPFiQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336404; c=relaxed/simple;
	bh=4w87sKvNwVN1XhdwrvqeSGrSkFFASpDkmJtJS5HZHW4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=rKR2Syn7TZ5v6V5E6vJN1M3io/QlwRfIeulgfuY6SB4SgXXQIxrEXGvWTcr24ywYmCqDZCt8S85oE6ZW1xS+BG2gCtZNBJSfLt2wfidFlnohp9jwblHQI3mCZgP17+7fqEMGoajlSAT00Db6qTcdSk6/fU3B3PxuL9NjDVgJlrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h0ab1/0C; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h0ab1/0C"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-63bf23f8fbcso131890897b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 10:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336401; x=1719941201; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m0zVM37WL2jQNln7xrBKCslp+8pFTT04OTNtW91i/Qc=;
        b=h0ab1/0CrMSfJqJVKSvn6/LSFYaay6Y8ghZmI1QnywaP8z/5pzMnE1d5OM8+kFFqJ0
         d/gs55ycP57N4FSTG4fUiXPSzkiF5beNEg7/RHcfX7a+ixFMGJuZDO4Z+B7vhqBaeRB8
         NMyda2Rn+nnwL0XpHJzt2qSbIaUDABy3MQduLoVnX1vEsYXZnJNboxPhQVd9kE28zqSB
         l6MVSfnfXw7YWCMDtfsn9V/hRxn0N8DVbTqKamTNBuWFtt233qLX5LVr0wOKJfx/AiiU
         AiePTG602uJ25nEf5UEo3uoEMs2m9I8hgXW/5059/UypNdm6YgFJ2ANb6cJrAv+WTgkR
         ngKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336401; x=1719941201;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0zVM37WL2jQNln7xrBKCslp+8pFTT04OTNtW91i/Qc=;
        b=oRTVGCDJCuG+w+clPfuB201cfEcQ2slWdly9mfDT5SpT+ppYQ/Pa0D0fLq0/XLQh93
         7fnuu7z9CMLbnXT0AQ5QNJ5I8G6aXcbTyL06UgZRdEy0nbZjbYeb/Su8cfCIupm8n26A
         X86Wcy2puVTE6jvdyGwN/totjztbdJjnFpwebhW2ID8pkLgqJfPA6c1QVnrcm9Rg7Xv4
         wff1puXN8uCC1IR9rCbCmDZxaAscPWOdxAnqsXE4LlWjdLVC6rLS1TlWfti2yRk77VHj
         NR6tC5vOQyRTk0mbajGHrjC1amathFcizO5nz23USxHN9KBs6x7aJBLX9bSaL7GVytNS
         42Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUrHYuaVR/KCmqkNCBhcJPbThv9gIuv/07530pihvpFrKYVJLSH0tiTMaNJSEcbDaBTEMRA4pGyN3eaCT9of1d/2l7prcQtzHEpmYFVygNBDg==
X-Gm-Message-State: AOJu0Yzu+mAd5WPJsz21Ghiamq5K9lFBT9CIEw/wwbaC+ZFRm5PqoE80
	S+eBepXsd4IShPUiP3oOfwLO/atWxQ6ssbfuptkEtn3J5U9D2XpHB3OxUOrAtvN0JY03pK+1X0K
	uXw8yuQ==
X-Google-Smtp-Source: AGHT+IFvDkg7Os7n6xpJOjx9/jstK5lqUN/rfGvGweJEa9x1d/tx4A52g63ZVLlFVQ0ULV4tujWDGTNgrxUA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:690c:6e0d:b0:62c:67f4:4f5 with SMTP id
 00721157ae682-643ae44f5e5mr4148627b3.9.1719336401598; Tue, 25 Jun 2024
 10:26:41 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:51 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 14/26] perf stat: Use perf_tool__init
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
2.45.2.741.gdbec12cfda-goog

