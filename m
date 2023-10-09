Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A72637158
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rXsOoCOi"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A99A1B6
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 11:40:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a45e7e0f9so427660276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Oct 2023 11:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876799; x=1697481599; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=niI1DS8q+ZbexmAiDdLr0rnTr4377R73icOoozlTydQ=;
        b=rXsOoCOi9IoLNymI/T09YYIpQk2fwalh+/sjgLoOz68oak642mvan2IHzdQ4lFkG9C
         qTDkmTDdRFdiOi/tIuqRosf8PTUh4R/3RDUMvBsPVFwqKrcElx4eB4/KGcZ4ugGHhR4q
         6+UdrZ7knDyTRPrVQY5TysvxoGbDYKxYPyGtKLW7srpiDu8nTMdEH2p+ZHfgSkxck40k
         Q7QhWMoWIg1JlRT1FdvDOtxBJGgPOstnjpNtOD2cTbk8vRRZNFCw/x88Anev4FS7hmnI
         URIV8lpxbzse82ysu662VNHxzQnipW52Xfr2GyeANJmk93kdWXZjdBrMuq2jb91uxRjd
         g8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876799; x=1697481599;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niI1DS8q+ZbexmAiDdLr0rnTr4377R73icOoozlTydQ=;
        b=JqJCJj9Omdv5ThDWdtLbtEzItygMcjvqLzyn7wmdyNKrTw19Q/FBtrPGZtHDSQcBz+
         YjRU5s209S5/tKyyoAPQCUbMHxadw9k118Hj0GalcxyToaSjroyuo2WIdt1CPM1yCaOA
         LWhE1KIJoeTG1tStUN+0f+mHM5Bc2mb9VADytY0bdNR3xV04WseLcm9lywC2DpR1xdlm
         BsK0MTYVArBEhIK3m1uDGJF/qjgUW/vCDT2eHLIUqZxp7KnAF07+/i3XIi5LjLC+oahj
         BK+p0K17857JKR/G940iQ6Lml77DmZyX/hCgbax/ZMiASpno+DLa9jM+nbeev+v8aIcK
         KnhA==
X-Gm-Message-State: AOJu0YzjdsuXX/NgwfiocC7pEDbdWC3QNL22Amg1CA3xITzNPJQmPYR+
	WMmnUIzE8BjoSuSGTSjjhPSejSjG+eQj
X-Google-Smtp-Source: AGHT+IHVauHFJJ6dURYCURIsUyMaH8uHK9E3Vkz92KCp4HMULUMevSk/Te5SUgiu4nvqqGfnHApJa8igvKfI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a25:bcd:0:b0:d7f:2cb6:7d8c with SMTP id
 196-20020a250bcd000000b00d7f2cb67d8cmr247211ybl.13.1696876799415; Mon, 09 Oct
 2023 11:39:59 -0700 (PDT)
Date: Mon,  9 Oct 2023 11:39:15 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 13/18] perf lock: Fix a memory leak on an error path
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If a memory allocation fails then the strdup-ed string needs
freeing. Detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index fa7419978353..a3ff2f4edbaa 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2478,6 +2478,7 @@ static int parse_call_stack(const struct option *opt __maybe_unused, const char
 		entry = malloc(sizeof(*entry) + strlen(tok) + 1);
 		if (entry == NULL) {
 			pr_err("Memory allocation failure\n");
+			free(s);
 			return -1;
 		}
 
-- 
2.42.0.609.gbb76f46606-goog

