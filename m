Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AC917DE3A
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807981; cv=none; b=C+x/czboAmrYyuEdviBzTgJ82dDoCyND9i1uG3zFRJtQCLvkA1HsG66EpI+0F8cU6GcbCzUGOXH4ry6QuKnqVtDrS1BklmSocCrdrHzG0L7YBiqBCzALwlr/w7eR/uORNjjfhXTeVJ+YCTXWrg+6Z76ZH/dSIRwGukgr7dRbPiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807981; c=relaxed/simple;
	bh=Zg5U84S1ofRY2jiFZPVeAVTNxheJYumCpecsmhgwjUo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gLTMI7tWrXfu5EUvbntgoktZntxw+NqZbwVhcexHM3G32WsJOwEb/RoG1eG9aFsxPOxjUV0mCf1XPXerxNv5ZBCzF6OCM8pcrSF9K6HirvEaXB9Tba4L0ezMXI9pK5ssR7NyNJb5k6g6PFH2clt9oXk4zoDgZ233JDKGCgecpdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bOD/Bbt9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bOD/Bbt9"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e033e353528so3404133276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 11:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807979; x=1721412779; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QqtdDMsD55pEoQfMNz6zeYZQAoeVSzSneBvTBBwc7VY=;
        b=bOD/Bbt9p0oq+UIlI6yQUt/3spsVvCQJ45K8QxXKMW+tF/zvIdPBb34i+2VMJy0Gl8
         2RFtgNNDXFTZb048q++osDhntcY833jldIYkcECeAn0iP8agOxhP/8D8AdTYsHoZ+/QT
         IA4TY6qYRo1am7amPf0sOP2I+WC5jIWaqkUTTy46mGkW0y0G96BLvdaVCcGBS8FwhRYo
         F69fXKDa4pOmNVvEHxRuZR+JvTHUZ+s8DjD4wWMbmIZq7gsxb2fUJzW02bmPMkOopS7k
         /Hrc6TMetBU/d3Vao7HD3M60SXQZeDOkbQr8BFUoyN4QyoKYNVESbmY7QM7lymbtmUxH
         rvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807979; x=1721412779;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QqtdDMsD55pEoQfMNz6zeYZQAoeVSzSneBvTBBwc7VY=;
        b=v1sHZgiPrluy2nmdtIZPpLG1ERqss/dXm1502Lf2Wg6G1kA9T1giv9GLXyBHqWdWBy
         14hj0LiHScyDayM1mooICbdxHUh03gnOHJ8BJDL2CNbj8po9G+PE2f4zMccVbPuNgb4A
         rMZvMoN+m+bIkQcIQ96o0GK/ZqLVgvAaGRZIbpD22Lvloy0pCI47UzZBJxd27sKEMuOl
         ofJmcKTwXI9uLDmQ/N4gd/eHIaJgEVx40IAaVpcY2RsOZmWM6eKHZ24o45WXtqmj/J4H
         OL292vPrg6j5C3JqlFbdEHcFN02IxHmgDDcnfSmFIvBg+Q4dYiul3XQ/OnGEs451GHS2
         cCJA==
X-Forwarded-Encrypted: i=1; AJvYcCWzOwJixA4Xk7R6AVgtwHxm1yTeZkzkK/RXBadV85JlvtE0o9LPbGmSP8CHyJiUNhS+W5JEDOlPGBAyGULuxYwLk7dkMt0Z6jtKDjnAjKWCnQ==
X-Gm-Message-State: AOJu0Yw2xa05kG62i/8i4Wxffyi7be1FTEoTWFSoo8RNWEIqTMLvlxsb
	IDvBkDuwHI0jlCYXCpW+iwn4R1bZxaMKLlQPs6vHTiN1vNlX4oZLcxrqBbRhVYJ9hD0q36VIEc0
	3Il/MJA==
X-Google-Smtp-Source: AGHT+IEnchojDdZ76Vxn9f7h4DhTLRV8huHLPOkuO6TlwqAevAk9P1WjzXQqv38Bbw3agIDos4xIMuc27TcD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:6902:1208:b0:dfa:48f9:186a with SMTP
 id 3f1490d57ef6-e041b0370bbmr26212276.3.1720807978826; Fri, 12 Jul 2024
 11:12:58 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:11:03 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 22/27] perf data convert json: Use perf_tool__init
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
 tools/perf/util/data-convert-json.c | 43 ++++++++++++++---------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 905ea9823f9d..20bfb0884e9e 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -316,39 +316,36 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
 	struct perf_session *session;
 	int fd;
 	int ret = -1;
-
 	struct convert_json c = {
-		.tool = {
-			.sample         = process_sample_event,
-			.mmap           = perf_event__process_mmap,
-			.mmap2          = perf_event__process_mmap2,
-			.comm           = perf_event__process_comm,
-			.namespaces     = perf_event__process_namespaces,
-			.cgroup         = perf_event__process_cgroup,
-			.exit           = perf_event__process_exit,
-			.fork           = perf_event__process_fork,
-			.lost           = perf_event__process_lost,
-#ifdef HAVE_LIBTRACEEVENT
-			.tracing_data   = perf_event__process_tracing_data,
-#endif
-			.build_id       = perf_event__process_build_id,
-			.id_index       = perf_event__process_id_index,
-			.auxtrace_info  = perf_event__process_auxtrace_info,
-			.auxtrace       = perf_event__process_auxtrace,
-			.event_update   = perf_event__process_event_update,
-			.ordered_events = true,
-			.ordering_requires_timestamps = true,
-		},
 		.first = true,
 		.events_count = 0,
 	};
-
 	struct perf_data data = {
 		.mode = PERF_DATA_MODE_READ,
 		.path = input_name,
 		.force = opts->force,
 	};
 
+	perf_tool__init(&c.tool, /*ordered_events=*/true);
+	c.tool.sample         = process_sample_event;
+	c.tool.mmap           = perf_event__process_mmap;
+	c.tool.mmap2          = perf_event__process_mmap2;
+	c.tool.comm           = perf_event__process_comm;
+	c.tool.namespaces     = perf_event__process_namespaces;
+	c.tool.cgroup         = perf_event__process_cgroup;
+	c.tool.exit           = perf_event__process_exit;
+	c.tool.fork           = perf_event__process_fork;
+	c.tool.lost           = perf_event__process_lost;
+#ifdef HAVE_LIBTRACEEVENT
+	c.tool.tracing_data   = perf_event__process_tracing_data;
+#endif
+	c.tool.build_id       = perf_event__process_build_id;
+	c.tool.id_index       = perf_event__process_id_index;
+	c.tool.auxtrace_info  = perf_event__process_auxtrace_info;
+	c.tool.auxtrace       = perf_event__process_auxtrace;
+	c.tool.event_update   = perf_event__process_event_update;
+	c.tool.ordering_requires_timestamps = true;
+
 	if (opts->all) {
 		pr_err("--all is currently unsupported for JSON output.\n");
 		goto err;
-- 
2.45.2.993.g49e7a77208-goog

