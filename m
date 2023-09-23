Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B961C2D
	for <linux-perf-users@vger.kernel.org>; Sat, 23 Sep 2023 05:36:15 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D6510C7
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Sep 2023 22:36:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8660e23801so828081276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Sep 2023 22:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447361; x=1696052161; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KS6/0u50No3rQJjH5fZIjyCOWL67f6naMZwh43hSjoQ=;
        b=1cvJSG2D4zjG+nEiyFOhhr9uXalDS6UQkYMUKbK51HR7DxnH983zpiM3pheR+NTgj0
         3G77+KayBqt4kYsFEFxxzaXtFpJGhwwsmbfSJwnycGRFRJVPZokpYTjGCsTBJKh7zfyW
         e7u+G9O1RvKddrcNbO4nFc3LhEwSQpwKrYFWnU0ujSh9GQbLyRGqgHtneDdtpRestn5W
         k6Lpq2h1BM+2OucES/2Szki9Vq/cquG3SsnM6QUhsvH5IUL/v7iFbuPhVrEkuPrmsi9a
         CuqvZd9O2s2ZutPu4VWdWCSP8BIKML4jlg/S337z6YOWtvNlXAl15EVONKGfRyCgIj+v
         l0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447361; x=1696052161;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KS6/0u50No3rQJjH5fZIjyCOWL67f6naMZwh43hSjoQ=;
        b=e9YHsworWh5tto2LhFESa5BN+n2L3N836WRyPjDbzq74JJcU0vndIquPh7iQtNeZUk
         UrdtTzV1fs1bR5MNPUIyFraok0dY7AfLe3NJFic1Rl/06GBp7ezCSL6WDvZnRUIAV4Qb
         7pHI72W056QPEROLdHgqwvildMbeRuyXpcSver6OQ/kp7oZzP+WeIlw3LljH/0GtV10T
         +W0Ui0PKM2ZQ/HGGY0Gtyau72Ct+977PUKEq/8/KkZbTO4MV/08N5KZ/MDdjH8FSLgle
         4by+nMIlH8F++MOgczutJfitqRRlOvVdFmQLdw416u2wSuwIh6ZeKAy7Lw4TthN9qbAf
         nAUQ==
X-Gm-Message-State: AOJu0YzwHSJzuxjq1rwARpkygGlYrYThvapJ7rm69IiCg+pHUZeymf7U
	pCeuCDYdKCbL2I/cfej1UDNH78yzNLea
X-Google-Smtp-Source: AGHT+IECwTxHbmPoI1K04GORCbxem+8maRhSeJmf/Mja5259t/O6+9DbPUULMmgIJZReDHjnxiFQ+xTHxGuS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a05:6902:1105:b0:d81:6637:b5b2 with SMTP
 id o5-20020a056902110500b00d816637b5b2mr14388ybu.0.1695447361524; Fri, 22 Sep
 2023 22:36:01 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:35:08 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 11/18] perf hists browser: Reorder variables to reduce padding
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ming Wang <wangming01@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yuan Can <yuancan@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Address clang-tidy warning:
```
tools/perf/ui/browsers/hists.c:2416:8: warning: Excessive padding in 'struct popup_action' (8 padding bytes, where 0 is optimal).
Optimal fields order:
time,
thread,
evsel,
fn,
ms,
socket,
rstype,
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 70db5a717905..f02ee605bbce 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2416,12 +2416,12 @@ static int switch_data_file(void)
 struct popup_action {
 	unsigned long		time;
 	struct thread 		*thread;
+	struct evsel	*evsel;
+	int (*fn)(struct hist_browser *browser, struct popup_action *act);
 	struct map_symbol 	ms;
 	int			socket;
-	struct evsel	*evsel;
 	enum rstype		rstype;
 
-	int (*fn)(struct hist_browser *browser, struct popup_action *act);
 };
 
 static int
-- 
2.42.0.515.g380fc7ccd1-goog

