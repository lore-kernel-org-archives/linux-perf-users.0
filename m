Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6C37F47F
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 01:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264500; cv=none; b=P0t9txvWty3Yd2nSsNH9rJAU0kaJtsy9DzxSTek/WsNAXy7YDWr05wMbHT3f8BATmvAlQb0XY0/uZFV4wRr3E2stdcIGRFNkwF2ft8XxDleoMp8aEfFDCosxmKyI9iae0w4Q2on2oXaVFE04T8q236TbFqWevBXtqzcKjyVeN3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264500; c=relaxed/simple;
	bh=smgrs6vq+/EnN03NBWT8R6qmohPEAkYKFjCcTcvoAz8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XcGN5dSJfZdW2eBnqf3g8Y/R8LvjaJDAJsgRAe+QQNYDDyWApJKfhNdfm1dwpRjygWjIO9Z/fpZ6vufD92shdpCm9GIrX+eh0Op0w0287RKLTA1pNsnX0Gv9KuynqrPleIcJx6Ldd1+0zikWs6ttn2E3ofU83DkC76z/+OibTRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IvDvZhK1; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IvDvZhK1"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0360f8d773so677546276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 18:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264494; x=1721869294; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CK59PJHvthhN1XqhU8dM7HWi+8LWSLWxbFsmB17zlH0=;
        b=IvDvZhK1hu+SeitPWTOeYxi0QFNA9A3hGz9UQS9A3j+V90p8BPkxrb1o3g4oy4YGrq
         S6HJn6h4iEiNFhXd/yBsV3gdlNbGVRcgvsMg1RaTX01oLvAv4y5ByLhQOZqZDKdJyyi0
         L9n7p1uEFSfKaTIFQVxhG/qmJ1b2PZ6ULH5B8MHbqJY9DfsA89D6Fm+mDKwGY7BBkVie
         X3cuo9/dxXgE9oii7udIanE2Mb/kAMOZV6YUCzJBfIURe8YIoqvY5Adr5BxZL9Ry7F8t
         AM4xfs2ru+IOzXdTFeYGpBrQtbqvsAMfPpgks5eV/0oJbpoFD4bEWmYjNo01NyGhim+6
         zcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264494; x=1721869294;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CK59PJHvthhN1XqhU8dM7HWi+8LWSLWxbFsmB17zlH0=;
        b=S5dKVSBjtwvNEwua/07Gca4ngZsrIvJzWvOV7QKqrcy+s+IfH/w91UGEpWYzURK/WT
         jjpde1ErL1LdEi7prKhE8VE9cBZIlhL/jh0f3LTZdQ73nTAvWChIwTWqL49OEcJos+Nq
         TBXizJK0eHMeZRxjzmt0LFnCxOHi/JHBblbEiCvj7psf50fNnsaaGWeR+Qi3J+z0OjvE
         pvs5w9dU3G8MrT0/aJikc29tqqO/o7S8wRW1qGVr2aKaDU/eUZDffw0nbP+8oF72QSns
         eGEYQxsnSzaUjWwqL3527v4J9iyl2LJ44bV3UFeAIs1x/w9tjm58Q7pZbHBrg9n4m/65
         zm0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV63gd9EXzK2bofD1yzSUvSvw/qatEAWaHQEhdRLmFv2vAllH/9QGutbeGQGy1kl41PcrcysxVYPEE3JSI3dC8vGr70MPAOAADbiCzGympnNg==
X-Gm-Message-State: AOJu0YzUwDVMV8UCgp1EUbzDkibzKGIBdy5uKVmTj6a/hfGrSIoSwJJC
	KHPVNwF2XPwrxEWXKJ94zQlUqDDEJmGsOCm1tYAsHbmafV1LjAJJrvWCiDcnwSbdbfiB+P4zZRp
	vHSnPUw==
X-Google-Smtp-Source: AGHT+IF0zgfiI7337Gx4Yjc5WQ+vYPQsx4H9UggbKoSxg5u9Xfw8UkV6hdUgp0OEYyULUUoe/l5TQODhg0kQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a5b:8c5:0:b0:e05:b006:9e12 with SMTP id
 3f1490d57ef6-e05fed6ced8mr7959276.11.1721264494077; Wed, 17 Jul 2024 18:01:34
 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:21 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-26-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 25/27] perf kwork: Use perf_tool__init
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
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-kwork.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 8ffaa80a2d1d..6a4281b8fd10 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -2322,12 +2322,6 @@ int cmd_kwork(int argc, const char **argv)
 {
 	static struct perf_kwork kwork = {
 		.class_list          = LIST_HEAD_INIT(kwork.class_list),
-		.tool = {
-			.mmap		= perf_event__process_mmap,
-			.mmap2		= perf_event__process_mmap2,
-			.sample		= perf_kwork__process_tracepoint_sample,
-			.ordered_events = true,
-		},
 		.atom_page_list      = LIST_HEAD_INIT(kwork.atom_page_list),
 		.sort_list           = LIST_HEAD_INIT(kwork.sort_list),
 		.cmp_id              = LIST_HEAD_INIT(kwork.cmp_id),
@@ -2462,6 +2456,11 @@ int cmd_kwork(int argc, const char **argv)
 		"record", "report", "latency", "timehist", "top", NULL
 	};
 
+	perf_tool__init(&kwork.tool, /*ordered_events=*/true);
+	kwork.tool.mmap	  = perf_event__process_mmap;
+	kwork.tool.mmap2  = perf_event__process_mmap2;
+	kwork.tool.sample = perf_kwork__process_tracepoint_sample;
+
 	argc = parse_options_subcommand(argc, argv, kwork_options,
 					kwork_subcommands, kwork_usage,
 					PARSE_OPT_STOP_AT_NON_OPTION);
-- 
2.45.2.1089.g2a221341d9-goog

