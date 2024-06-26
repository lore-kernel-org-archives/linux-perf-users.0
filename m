Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBAD19599C
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434240; cv=none; b=TRWAcgxlM2mbQh0FKHTkyIOY/I7YPqHTPCojX1IMEN3r73BVc9BDM8lIJv3T+AH7ciCW+4nPU0xcs1xTTxKYlHx8+1Js/jUoOp6eePR99AizA+x2fVc3Tf794yOfhQASDBv63D14p8I7TW+FcOvF3T0aNNIpeYsrgyhwTGcR0rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434240; c=relaxed/simple;
	bh=wSv42CwTUPplQ6+JVwWJj7o3S2bpL4SvoCmSnIcCAeg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HvO4M7qjhyuJVu7kYZ9FybKaI9bIPt/r1P55hKczaXKmDu/YnkSAEqdM0yIdLyZN7meP1lD9MmupzkyYtN+BiWrlXlDHo65Gzg0WZ6k6AeLu+8GW6vnZSKeUqdYrpFaJ5ajZWYI9IhzHqn0PLBDoDAAPZ1RBARxlFaL7igPU8ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AoHPqL/8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AoHPqL/8"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03356970faso1734267276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434238; x=1720039038; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7raeEbJAcH5XWE73572v5WMgPlRiFhcFGuQbVqprDZI=;
        b=AoHPqL/8fm3NwalY7Kkw101jIP/Q5dCJk6mrqd492P7ST9lI6Q6t9wJ5AGeGtHg9r0
         1xHIuEnuxfnkTMdvXt9x/zBFX+vmfhPTqP3pTA9jR5T8dKbr3hvpbyl22xQHbP6MIEQy
         vQKDtEUR5ojyW2g2c+b8sdzLKIrJO+6s7gMHwMh51adyaHeP2Hr9BGL/tnkWv4kWIi4U
         qssS75OCQOpMsjH2YySezakUQ078Fcsu4X0b0P/FhgBZVeVfnUGqkAKNMXM8sb3Bj2Ic
         /mralXV5q6BMD8a2wrqY8K8THuHDaugXV7gXC+kOY2y39lBy4WyzofxIUikAIK8pb86R
         fXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434238; x=1720039038;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7raeEbJAcH5XWE73572v5WMgPlRiFhcFGuQbVqprDZI=;
        b=JXlSC8DaZ3gfYdtR4A6ShJ9fjcbf3Tc3usiDCRvrUKSY49hOtknJ1cbqi40bAXJFWl
         sPS3DNEGvEKv4hAbG0ZrTCyhENhvutjSDRiqhjHnguhz/8CFI/8LVsOL4Re/CGECHpAv
         X4RUCkQtEN4f5NsRepyQDMC/QotZ1m49M4IHQmoCr7QTlKAf8q+8fkU/Rn1leCS/7ap1
         hpYbLsvXZaOQhZW4D+LMDDiwR9lPUp5IVsvKpby8O5evd66BIvJRvvsuOTHV2XmqZv0I
         UOm5kjyk3pKZf522X0nyjsLPWBqY5poG1CXMs9U5AnqpErOe7i2gzkCAlC4fXlFnH34c
         9iWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpBQIOwXkHJP0etMrnsC3nXSHUX97smr6aNzpBl+BZibSXOF2lwgBLj7O963avh+kkgPVAGHEf5d20Y2e+OGcTXbkSZQaLf+jLaseMVtqGZw==
X-Gm-Message-State: AOJu0YyIa5YbbvVTDjSb4eQtn9jXejO+44Zx2CIN12HtvIJc+3Kzu1W/
	H7+IyJeJeafBxsFHIEvNfC6SYKzdkeQg4bbqIf+yScVC9Svx8B74bH/iH9dkHG5jQZIyolTXnYX
	sy/56rg==
X-Google-Smtp-Source: AGHT+IEQSHEY7tmOfYdN6cXOmdDpH3I6AavNANwL4+37KcCIjJ1LiHApcro3TXfK+Qrz2MPoCkZdH20IlOBc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a25:b110:0:b0:dff:3c7f:ea9a with SMTP id
 3f1490d57ef6-e03040084ebmr30925276.13.1719434238238; Wed, 26 Jun 2024
 13:37:18 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:19 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 17/27] perf annotate: Use perf_tool__init
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
 tools/perf/builtin-annotate.c | 42 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index c0685d2c8de1..598ab854b9f3 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -686,28 +686,7 @@ static const char * const annotate_usage[] = {
 
 int cmd_annotate(int argc, const char **argv)
 {
-	struct perf_annotate annotate = {
-		.tool = {
-			.sample	= process_sample_event,
-			.mmap	= perf_event__process_mmap,
-			.mmap2	= perf_event__process_mmap2,
-			.comm	= perf_event__process_comm,
-			.exit	= perf_event__process_exit,
-			.fork	= perf_event__process_fork,
-			.namespaces = perf_event__process_namespaces,
-			.attr	= perf_event__process_attr,
-			.build_id = perf_event__process_build_id,
-#ifdef HAVE_LIBTRACEEVENT
-			.tracing_data   = perf_event__process_tracing_data,
-#endif
-			.id_index	= perf_event__process_id_index,
-			.auxtrace_info	= perf_event__process_auxtrace_info,
-			.auxtrace	= perf_event__process_auxtrace,
-			.feature	= process_feature_event,
-			.ordered_events = true,
-			.ordering_requires_timestamps = true,
-		},
-	};
+	struct perf_annotate annotate = {};
 	struct perf_data data = {
 		.mode  = PERF_DATA_MODE_READ,
 	};
@@ -864,6 +843,25 @@ int cmd_annotate(int argc, const char **argv)
 
 	data.path = input_name;
 
+	perf_tool__init(&annotate.tool, /*ordered_events=*/true);
+	annotate.tool.sample	= process_sample_event;
+	annotate.tool.mmap	= perf_event__process_mmap;
+	annotate.tool.mmap2	= perf_event__process_mmap2;
+	annotate.tool.comm	= perf_event__process_comm;
+	annotate.tool.exit	= perf_event__process_exit;
+	annotate.tool.fork	= perf_event__process_fork;
+	annotate.tool.namespaces = perf_event__process_namespaces;
+	annotate.tool.attr	= perf_event__process_attr;
+	annotate.tool.build_id = perf_event__process_build_id;
+#ifdef HAVE_LIBTRACEEVENT
+	annotate.tool.tracing_data   = perf_event__process_tracing_data;
+#endif
+	annotate.tool.id_index	= perf_event__process_id_index;
+	annotate.tool.auxtrace_info	= perf_event__process_auxtrace_info;
+	annotate.tool.auxtrace	= perf_event__process_auxtrace;
+	annotate.tool.feature	= process_feature_event;
+	annotate.tool.ordering_requires_timestamps = true;
+
 	annotate.session = perf_session__new(&data, &annotate.tool);
 	if (IS_ERR(annotate.session))
 		return PTR_ERR(annotate.session);
-- 
2.45.2.741.gdbec12cfda-goog

