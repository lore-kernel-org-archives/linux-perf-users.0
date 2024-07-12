Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A118217C211
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807969; cv=none; b=pgjE5sWhdDwKhSyqJhUi8H3plb6yf24wm2jU5qQFZb69wzYoTHGbRdAaiFcljVazIE/OlAZYS71G/esJnNgbjja3C7qwNl2wRLdy/QA02gsL0j7fMJB7ZHKsGH7Mj+i5sbzY3Zs7X0I5KW+XUwaMLKikiGPiOL8wFA0a93+OaLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807969; c=relaxed/simple;
	bh=Oatp9vP9864WSMM6h8L2eaSDz2osyW3W6s5tTUlCsXc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VIr/bXA0Eaos37rJS8fZqP1DfiZIetisjX5J7tEyMzoKQ4tzWD3TUZt/2BKIt6sUNw4EUUNSB/AE5Vb2aBDwH3nNdGKsHOS/GPqpDeg9LWQzDf9Cimb9r34Okm49p/Rz99GefgMir4rpKT+S4czU/hkBYm1dKyXuiyJ6K3TcOXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sJevOxMw; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sJevOxMw"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-653b4b01872so40231147b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 11:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807965; x=1721412765; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GhKzAhRYOz6Ff/7gM3raH2p2+7D3XZwc5l/hw9g7Qeo=;
        b=sJevOxMw3gvebegY6KUhx5Yc7gmhNzCyc4XsuZY52Axk8uInIYgcFstMGW5Qm59unI
         HWsZHLFJ8POlHw1NhHDhww9V10tiuu9P6Oz6fBSvIr7ziEwFDnW9QjjOp9YG2MEMUIlJ
         Zw6kQcwh3xkWHaxinH4jaGorIV/fioX42IWmApxmLxq9uMEnQAexsliEAl70EPkO1tKP
         dDC0kPKhlglkq64s5ODFEZtpx+lD0E6mAujEny03OIAssxqY6nlI1kXrBMY/TjyGoA8d
         CBIRAO5JgaFr28/bfXSgEQKA91FSV9gGhGzNFsud3bTtLMtrKfrq1AD+qV8YNFKHgPJr
         yABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807965; x=1721412765;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhKzAhRYOz6Ff/7gM3raH2p2+7D3XZwc5l/hw9g7Qeo=;
        b=c2bTWOK3ppKFmhS4VrqZWtJIH6GwQtH6vsZUwEXVJxtMWmB2JHeiFaf0WnzIYKBIrs
         RNJIf9X5DjrQW9mAF9ipf6SWxxMbDguHvybdWKmDWYvxWo5HI2PDP1dwIRcep55Dz8oc
         R2c9eok8PilSVDRzLA+EpAOIs1LexhlHH07xgyd7zakeNX9vpALMoyI5d9fakcNTRrrl
         JnTcFH/tG5iDZKJFbWQozZpfQzGwtrfBN8hryz4e5PWl70IPzuecSkO4iKGxnp3klyf1
         iID/sOJHMC4sGuhBCDXVu0IvmTcPJHRhrd33EZ6vFH10nAWYW8EdjgmD5yBvJG/XHpEq
         aWdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp3rQpFc9VbRe3kUCUy3TUPfmb6nu9Q8oA9ZTn3HWgPfUQgYhiMCafiOG53U16bRqYoS4HvPoc3iixGBO4mBEPJpBHczlvZvBaTiPpq/cDpA==
X-Gm-Message-State: AOJu0YwJBqSCgxrO/Z3/dL4QwMyOizCPQfTcMVWabs+oLWTSxRv5sCDM
	zJ3bLirAdXXtFZgsa9otogKwsASa7GLyp4+3dmiUCE3MBY/OzAfHA6Qf+OB27Y9gYqoYreAldeM
	8JHxmvg==
X-Google-Smtp-Source: AGHT+IFhYPk2jTBuMlhB8gOtTxMBnApQKnxVWvq+XTICOK0WnJmqAo1AkbwwG2wHV+rrMbesLDOHGcXiSffq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:6902:114b:b0:e05:74ca:70ce with SMTP
 id 3f1490d57ef6-e0574ca77fbmr459024276.4.1720807965562; Fri, 12 Jul 2024
 11:12:45 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:10:57 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 16/27] perf stat: Use perf_tool__init
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

