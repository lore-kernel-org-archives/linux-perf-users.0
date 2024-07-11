Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B07817B438
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720868; cv=none; b=tPKI+1tCQGFXW+7BeTlJqEtJD+5vT5cKy8j9MrV1uBWgXqqYL5CWdy/GG9qhJ8HsaNYwPZu9zxKK2Ig2LwTz+7aMi2tbMZv6dx0v0uVzhCgW04FBSssI7BlCtxf2cDT4Nh+wRhwvGrp4YcmpYorAz9OWBD/kGwwanmU9i4pjwSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720868; c=relaxed/simple;
	bh=IiOUbHu6Xz1VISLL+B0ayGxLanWqPidsSe75Qtiw59I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=YRwG/c7vZw2RCfU+9oOSOYNk8WNH8Wxefh5ulQnm61j0aNBcEQ9vj09Ofe+iujV5dxCw/cy6KSpEuIHnmeSZyFatNOv2+Z1Auit39TGHjqyWJMom56emYf1plOj2jftA0xX6NKsbw4l2rv2G/zjBwSjz8+OMVT7K3XfJSrDHz8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sdSqoH2t; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sdSqoH2t"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64b5588bcafso19778597b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 11:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720866; x=1721325666; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I9Nrbi73tEJWZxPfyj1GxchBACZKBze8WVP6UfEoRnc=;
        b=sdSqoH2t81PvJ6GsUw+sMoNeUz1KocrBXJbalFJPr1epzjThDBfC3NpWsJle26W9iD
         0Y8YXEHQXAODcRMTxGr5OF/u9cl4tk5EdkTpBtk3bpDzctPHc5ku0cXVKz1Pp2g5RY26
         hAUaJwP/HbaBWSZVs+jxcTyxePfTZdrqKZkbXJV0rI8WECBNinanu6NqURV6X4S5LgN4
         WSewClM61kBjaO9eS82gdZZJgo2dTk+Wfghuadr+VsstrPTbIHifGknCv+JlL6P3yyUw
         6R+Lsa60xTqWOmHNQhDxg4mCfDA98Hy5yV7v0BEwseNtKf4y5aKMy8CkTskxXg0qOKNm
         3jZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720866; x=1721325666;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9Nrbi73tEJWZxPfyj1GxchBACZKBze8WVP6UfEoRnc=;
        b=cM6NsLZSCRS4DbEqkbbinmJHHdi6EAZiJjgKhjJ/7yKaGXUOATrPKmmBnmENpavlGW
         MXfpMqhJJa1vUX47x77KslnFpcMYBL0iCFajbgnQueRWi65z4G32H774mVILZPBgiHfi
         HqD0w1C5xiviQ8tHwpFhsDV+UZoA2r5r1RQmYke/A9Rbji0khP+0A8k/4XPuCbKwzo80
         27AJB9S2dE48vbEYe0SDWs0cKgxwVlcYgeS+MrRdPUvNyGbI+0x0Ci4haVEQ01gMbepX
         Cj0CFKe4KPApPQgXu+Inhpuw8zmSmVhJ+3VMEy9dRCEOP9dlUTKG5VrYsLgi6x2KGlLV
         Mn2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQ6fT6qs/X2nWDQ4qxDg5wCP66kZThQGDjkhGw4y1MGh44Lxfx0Txrc6O5Vx69PqtQd/sRLRManZI+6LeOaaHEmY7z37ZJBiMa7ocWDlJVCg==
X-Gm-Message-State: AOJu0Yz/E7iDAWrfA4kbF6F2pWirR1oD2RsORXftVJRt/ubIRzHI/tf7
	RuwLwj4bQyHQ8e99f4jj+8JwLrQNFbwf8KD7hE6EIZjYtYQYrjFOH7IiJ53Ji119ze2wRiSHOT8
	2Ms5MXA==
X-Google-Smtp-Source: AGHT+IGhziChfBYedmxyjnMHcf3Bobknr15gAzBmJdGEG+V/V+Zw+9Pj/8QUbWISbMzVlIJAKmFQYf39s2q6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:690c:d0b:b0:61b:ed85:5d3f with SMTP id
 00721157ae682-658f0cc859amr2392417b3.10.1720720866335; Thu, 11 Jul 2024
 11:01:06 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:00:04 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 24/28] perf data convert ctf: Use perf_tool__init
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
 tools/perf/util/data-convert-bt.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 9e2170604b66..021e9b1d5cc5 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1607,25 +1607,23 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 		.mode      = PERF_DATA_MODE_READ,
 		.force     = opts->force,
 	};
-	struct convert c = {
-		.tool = {
-			.sample          = process_sample_event,
-			.mmap            = perf_event__process_mmap,
-			.mmap2           = perf_event__process_mmap2,
-			.comm            = perf_event__process_comm,
-			.exit            = perf_event__process_exit,
-			.fork            = perf_event__process_fork,
-			.lost            = perf_event__process_lost,
-			.tracing_data    = perf_event__process_tracing_data,
-			.build_id        = perf_event__process_build_id,
-			.namespaces      = perf_event__process_namespaces,
-			.ordered_events  = true,
-			.ordering_requires_timestamps = true,
-		},
-	};
+	struct convert c = {};
 	struct ctf_writer *cw = &c.writer;
 	int err;
 
+	perf_tool__init(&c.tool, /*ordered_events=*/true);
+	c.tool.sample          = process_sample_event;
+	c.tool.mmap            = perf_event__process_mmap;
+	c.tool.mmap2           = perf_event__process_mmap2;
+	c.tool.comm            = perf_event__process_comm;
+	c.tool.exit            = perf_event__process_exit;
+	c.tool.fork            = perf_event__process_fork;
+	c.tool.lost            = perf_event__process_lost;
+	c.tool.tracing_data    = perf_event__process_tracing_data;
+	c.tool.build_id        = perf_event__process_build_id;
+	c.tool.namespaces      = perf_event__process_namespaces;
+	c.tool.ordering_requires_timestamps = true;
+
 	if (opts->all) {
 		c.tool.comm = process_comm_event;
 		c.tool.exit = process_exit_event;
-- 
2.45.2.993.g49e7a77208-goog

