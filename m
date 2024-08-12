Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F26419D8B4
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495700; cv=none; b=u0ILn4PO1E7yr2k4TjjpN8poCa/dU0jcaFACn8v421yUKLwvkt018P7kYv/vkV03hmsLrk0m2hFu3ZHyLvm7NyxY4xxvKmL3sbg2FYm+ntYRBSzVfQMX/OLe7pQepp/ZNlbMsTc0acitssZQ+DET65GMQmqEn9z/6sq1YB9iPEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495700; c=relaxed/simple;
	bh=6SbW11s05Qr4nY+NcFpPuE26rfIGtkku1+1qcEZhCNk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=tr0s1xUl/yCHTTxsFiGdoYqvL48W071KB/Rljk3i85UT9h5CgC+i2Md/Amnqg5KlmLPQN2euSkBFgGVzp4tHWj6zwO9KKe8WxEYXMq2WJ125IMAkryajCZ1nJLsGIDPdHN2jNoPEDbI6k1/sEt0qABzCvWxjGxuYW4h7sDMo3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s+usMIjz; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s+usMIjz"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-672bea19dd3so107609087b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495697; x=1724100497; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uJSUXUdYfftsnAfnEFDlpk8Nwh4UnwypAJ8imZ20tFs=;
        b=s+usMIjzcsQnsgE07MYsXgNkxiqv65LimFEuYV60+BgJYUjHWkOulyBACPChTHHfmn
         iDoGJldM5ZnpOSWeLnQVbYpIuWaMBnyc1UmJCOnrE7tsTUH1Y4UlM5YJA8vqQZxlAoQV
         xjiD0FKzkpNCmRVe+OeOjtZytnrQqDe5kJjGfw5hRZbCKMDxLE83ylsjQ9ajdStWK6pr
         RZrWAr5biFfeLv8R3q2f+2oe+ZiXYhxACbFbNy2i2Tq5BSJTQVQ7b37ZhN3AEgeQ4Xpb
         49s7qbU093aDyNQVrC5A+HzP9tTjEviAson159DwYuS29FJi0bUOALB5yaY+A+Lsquy6
         K9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495697; x=1724100497;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJSUXUdYfftsnAfnEFDlpk8Nwh4UnwypAJ8imZ20tFs=;
        b=NI1iqzHs/sZwznHqy+LfGC06HRYQRbKmtL78/FW1xdej/vlyBG9emhMx5alOrg8XhK
         RjGsN8echLM9b/PcWPATfl1zcj0R4yQuHTPgPFsAE461aw5QreOb9F+kLGiopsg/gABa
         GlcAfKkElpYgrbp0cBoyIsWvHgDyVb6CZuCCN9K6ki6/QqJFMH3wtpql7lEDyUIVBdmB
         1eXLdouKWZmRZlJ8dH0mjs9qMLS9x6kZh2mogVdDKfXrBPf/1aFzeBdMFih0wCniyoan
         4ZGpSODbu/LWEBpAMpA7ofIiYkC0G7cMukjJuCBbaLsH9mX6sNiEOKsfZ7DQipAudNkk
         340w==
X-Forwarded-Encrypted: i=1; AJvYcCWI0BtUsjW0843q6JzujO8oHvu8vg6dWHNnw1TKZsEeyBqx19OeZjmjOs6rqQL3LnrlAvmhj9GowKvo7knHvD8lW8qLLmoVRDUdOgt14hUS+Q==
X-Gm-Message-State: AOJu0Yy1zpOWEySPtKalJmoUh5VTFaJwImajbSXXlqXiQb7BQywB9qk8
	uOwii+L5ALRNXIhaGKVu9sffe7G1hI9dtM31MwxBE+em0bOFpBhHprQRHOE98hJUMHPRAE0DbEn
	8vAO7cw==
X-Google-Smtp-Source: AGHT+IE2pK0wYfiv8oc0VZSUE7OVPqkqcX9EbQm/feBFKAubLZ6JT4aH+pOipQ5xDduOtnnesoVffuXHgpL+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a25:8d89:0:b0:e0b:c0a5:71e2 with SMTP id
 3f1490d57ef6-e113d2c1aa5mr27234276.11.1723495697319; Mon, 12 Aug 2024
 13:48:17 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:15 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-24-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 23/27] perf data convert ctf: Use perf_tool__init
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
2.46.0.76.ge559c4bf1a-goog

