Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE3C17E8E3
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807983; cv=none; b=Xl7kgHNwMbiXwkexCvieA2SdHnuOESgScaKmwVm3iIewrBm204vM5FxGgI0o1ozLhQpnJCyqyEgcqMjC3p803sN4k29tixyxInNsY9aTBfeg/YcObfbuOUWG3MBU3Xr7DlKwiLksfIUa0sDnwy7CdoIgCPGg7JeZ4sXvfxYmJb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807983; c=relaxed/simple;
	bh=IiOUbHu6Xz1VISLL+B0ayGxLanWqPidsSe75Qtiw59I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=U8Dn2/Ay0N28QMjd4FONDp0UBAKOMOfLbuAnGM5DjnpCms915SytTeHh5hCLGfEki+KuUlwaYVwN4BW6Lw2JCnHiyG19F6Tqagd+kFPkez1VFdCiKjICiwjjKEp95EPTF0gfuvfk6yBPXhEBuUwPH656L5HFalYzR9kuEsfFTiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rlrBGB07; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rlrBGB07"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-650fccfd373so36224767b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 11:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807981; x=1721412781; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I9Nrbi73tEJWZxPfyj1GxchBACZKBze8WVP6UfEoRnc=;
        b=rlrBGB07ulbu38xgl3cGaQeG9QqD1iHSJBKuxu1e6/yw9E+xSDkoP3McAA+VD3sFFP
         3sT7TDEisyHiglyNfTGNzMc3HEnKEokO/FiJSj1gB+j5LVbNs2pCVMU/m9N6phRqqU2R
         sPADzogBaXBnk2yqY+l5tZarWHR8uOZilBqy50DPbWSDs4Hn5GhBmfI6okx8PEjljbnh
         6894QmX/uUN/o6IDh5Udp5AN/eZEdcioEwp2d4n7ersmdfgYGk1YEKeumtsHPKXAWvA9
         CTT54B98ulcuyrkZum3m7hvVtjK7AkiCRyd1EVkkCsS6tYupLm0kW9m5Flg6T1lGOe/R
         cpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807981; x=1721412781;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9Nrbi73tEJWZxPfyj1GxchBACZKBze8WVP6UfEoRnc=;
        b=apvehUXqr2sWD2vn5baeJxBkc4C+BIRnPFbfP+E00WhXdsoa8a1QuQn2f1Z+qWslCv
         g8NmKzj8unIwPvpuHN8nlpLwzGATUnsko1V3NJOvve/vKETm+KeDF13LzVCbWZKQEqf3
         QFIcFap2YPJHgqOVrpgYGQ2hm40pVE1VJHnqJxZwyJDAJt3RlIsFMZzXuF0zer+o290i
         rmNw5FU3DVdjvDC07hAUNfZfjf4wMdjSoJJJo0rJwgbCkbEmYuc7Zjokk/M7Znu9UeDD
         dy2EMKfGbQKZPbFQe9vOy2NgR5aBmJGpDOjpSGJd0JGOQbisqkD9kD+gE32M7KI8KvY4
         IKtg==
X-Forwarded-Encrypted: i=1; AJvYcCVDYw7fywx4K9bsbmYHnKlauyp+iBalgVL1PtbXzvDvZrArSf9p3u2hc+kdvAOdMRSm0SGJEwNftdBeTGets0FalRpmWU7NTvXl+ieuD6RMtg==
X-Gm-Message-State: AOJu0YymKi6e39AzcjRwgvJ5Uql9aKaAAjhAhqVRDmbqJf0l3KIbl9u0
	kLq2qhnLYRzK0cF0jd8yfVr9/5LvmDhIKDdWimXFppKvfIew597rDedqX/fewsLZI/+uv8yIKNk
	tM4Ym6A==
X-Google-Smtp-Source: AGHT+IHbbwHCzdchAfHj2SPmGVg9X+8SLDnkVDWoP3VU6MRCDTDk07UDfpwPw7rKkSi8K/BWJzAXGMd4QWb8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b0d:b0:dda:d7cf:5c2c with SMTP
 id 3f1490d57ef6-e041b17798cmr23901276.13.1720807981253; Fri, 12 Jul 2024
 11:13:01 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:11:04 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-24-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 23/27] perf data convert ctf: Use perf_tool__init
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

