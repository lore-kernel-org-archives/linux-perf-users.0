Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317C736B0E
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPZgNN8l"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4154FA
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 11:39:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7b53a48e5so4704977b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Oct 2023 11:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876787; x=1697481587; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JGGlE54ge9XxgsvPeqIZ7isbDlHsMUv/MJYLVA09opo=;
        b=HPZgNN8loVefaOMfnRHnLVQVv2af1+7RIMbdemt0ihqTnrd+eC09lwm75mFfpYfoK8
         VuM7z5hvPEqcV4xKoabEexIrQXkuMOBoXOzdovVPUOYM7Co1+/FnIRdDj13p3os/Rw7s
         NI8p7mPr7mM5ZF4uZ1mpG8YUhvyXuFinhqEKXJ+MQu3lrzW6kz4bJP3lMkttN6Hqxorz
         mHe7KnritTalDR6fFTBGMfrTMXulwEzrUJ6mji+Y2of/4EV33s2AeShAbwxSMRJ+d02t
         dZitQgZz34BI/Fy+TBjVTcAzYr64CsOm6jp1TlVN3L0JNxAf97JGub/g2KK4QBxJEYCZ
         lAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876787; x=1697481587;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGGlE54ge9XxgsvPeqIZ7isbDlHsMUv/MJYLVA09opo=;
        b=EErIhoRvIr1I2qlIlHei9mrHUOEwAvoB4/lGPZIr7YVkAkGSDq8TnCB6h/GgJWukD1
         5ZwYHs2CyI5OSoSQJOSoct59MJEfKZFsS5dgwPnrQW/1o0TNPbe2nq9qF01UhP29w54p
         sUBtHGJPPZ3CgZDlY4Z5xWXL2wpusqWhlvGxxfN0BbVqhNEMlDtaVQ9fumBl09063wLn
         IKE0eZquXWWQCayr8n3XoGDNa2oxGApaKTizrUf+hjD5LlTD/yFX5TtqMe8kVmhR3oql
         uo8neUx9rC52ohCZT757p57rDwDSk3t/GfrL2GCXFEDHzKhXGb58UbTriVoetDEOQTpd
         4N/A==
X-Gm-Message-State: AOJu0YwzpqgG/ViHoA8RmAC3pgdCPAucnd0eOMOFacKezXBsWsJcFXHx
	4BkKhwBKB5COeQua1//Fewt8SFvpd98D
X-Google-Smtp-Source: AGHT+IGpysIorYdi8kbri+eoNngVpsBmCut1uHA899pI7BzlPq5MUUHT7YyMhz0NTaD8xsX1mPms8KyxGvsu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a25:c243:0:b0:d89:4d2c:d846 with SMTP id
 s64-20020a25c243000000b00d894d2cd846mr246744ybf.12.1696876787012; Mon, 09 Oct
 2023 11:39:47 -0700 (PDT)
Date: Mon,  9 Oct 2023 11:39:10 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 08/18] perf mem-events: Avoid uninitialized read
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Ming Wang <wangming01@loongson.cn>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

pmu should be initialized to NULL before perf_pmus__scan loop. Fix and
shrink the scope of pmu at the same time. Issue detected by clang-tidy.

Fixes: 5752c20f3787 ("perf mem: Scan all PMUs instead of just core ones")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/mem-events.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 39ffe8ceb380..954b235e12e5 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -185,7 +185,6 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 {
 	int i = *argv_nr, k = 0;
 	struct perf_mem_event *e;
-	struct perf_pmu *pmu;
 
 	for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
 		e = perf_mem_events__ptr(j);
@@ -202,6 +201,8 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 			rec_argv[i++] = "-e";
 			rec_argv[i++] = perf_mem_events__name(j, NULL);
 		} else {
+			struct perf_pmu *pmu = NULL;
+
 			if (!e->supported) {
 				perf_mem_events__print_unsupport_hybrid(e, j);
 				return -1;
-- 
2.42.0.609.gbb76f46606-goog

