Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42782D311
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 06:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HXoEglfz"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A2FDC
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Oct 2023 23:24:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7b53a48e5so10345047b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Oct 2023 23:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697091857; x=1697696657; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n22HctTeNabjvu+detFMoBE23ee2ZNJEYKUzOJUpCFY=;
        b=HXoEglfzw+KwzhCEAFNDf4mqZlbE8tAGIMFRp7swMbFlWFhUHWTJDA1+Fbeo1kW3U5
         kVOVtIBUXXtIpZs+Tdib7mDnhulG2AyUdxFCFUeHLvtf5SrxhYwBN6nQb8k+yq3IW2Au
         J5PvYGoww0AgGz0cVoQQFlNsneoJ8L2W1MEG0/km7lMezsb/6nD+7K4DbeamiUXnnbJx
         F5mQk08VtBjjfIJb19lvS0QkMObyiLZ1rkG9/ppT/L07aNxl5aNfmgWwrhXb7woiN785
         iW4D9oWg5eoPPuZYDAk6ddTsOkEIZESU6MBdwlD0KgDd5mQnAf8ilcFIighszbsuZcSe
         W1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091857; x=1697696657;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n22HctTeNabjvu+detFMoBE23ee2ZNJEYKUzOJUpCFY=;
        b=RPhr+ymYZb3sHzFCrft6kmyQEe2YS9Mb6lhhIF2dMPdFutTd9AaUNaz+y2gq8McPjS
         AbSEqJ+n2DYXHEiQm9LmE/6aBUSXSRHTRuDvhnd2exz/KC+nbNllQlm/PLFYrNJXBOGZ
         XIOqLEWlyhLAFRtzeuS1xYyDEm/9aQLPRihWSW4K7HFqOSNl6+JHKjN47YHw+/VV2LJz
         ALrrgGbVt/dSBIH8z0r0VY9pKzYATfo6HCQale+Rbt1E1iXrOkgEoly5j/0DjmcJ2f33
         h9kkz475SI4PuhUyF5HWQYH7MaT6phBOQSpCAyGk3pa7FUfru2trxKA6XsfaJzHdQfDr
         H0UQ==
X-Gm-Message-State: AOJu0YxDsPvGq3oebuju535aj/4v/4oDhJXCxVLmyWmwCl/luf0fcftF
	byIkpbNea/Lroz3Q/6O+Hgd9D5NjJC//
X-Google-Smtp-Source: AGHT+IG/18zLXHA3wgR1PYyBUsgstJKB/GDiTcsayNrXCC9eMZZGNYjTQA68IsiN6zxDEk1bGSJuRu2Y5J5N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7be5:14d2:880b:c5c9])
 (user=irogers job=sendgmr) by 2002:a81:a8c8:0:b0:592:7bc7:b304 with SMTP id
 f191-20020a81a8c8000000b005927bc7b304mr446341ywh.8.1697091856969; Wed, 11 Oct
 2023 23:24:16 -0700 (PDT)
Date: Wed, 11 Oct 2023 23:23:51 -0700
In-Reply-To: <20231012062359.1616786-1-irogers@google.com>
Message-Id: <20231012062359.1616786-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 05/13] perf offcpu: Add missed btf_free
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	James Clark <james.clark@arm.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>, 
	German Gomez <german.gomez@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Caught by address/leak sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_off_cpu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 21f4d9ba023d..6af36142dc5a 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -98,22 +98,22 @@ static void off_cpu_finish(void *arg __maybe_unused)
 /* v5.18 kernel added prev_state arg, so it needs to check the signature */
 static void check_sched_switch_args(void)
 {
-	const struct btf *btf = btf__load_vmlinux_btf();
+	struct btf *btf = btf__load_vmlinux_btf();
 	const struct btf_type *t1, *t2, *t3;
 	u32 type_id;
 
 	type_id = btf__find_by_name_kind(btf, "btf_trace_sched_switch",
 					 BTF_KIND_TYPEDEF);
 	if ((s32)type_id < 0)
-		return;
+		goto cleanup;
 
 	t1 = btf__type_by_id(btf, type_id);
 	if (t1 == NULL)
-		return;
+		goto cleanup;
 
 	t2 = btf__type_by_id(btf, t1->type);
 	if (t2 == NULL || !btf_is_ptr(t2))
-		return;
+		goto cleanup;
 
 	t3 = btf__type_by_id(btf, t2->type);
 	/* btf_trace func proto has one more argument for the context */
@@ -121,6 +121,8 @@ static void check_sched_switch_args(void)
 		/* new format: pass prev_state as 4th arg */
 		skel->rodata->has_prev_state = true;
 	}
+cleanup:
+	btf__free(btf);
 }
 
 int off_cpu_prepare(struct evlist *evlist, struct target *target,
-- 
2.42.0.609.gbb76f46606-goog

