Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474197F9
	for <linux-perf-users@vger.kernel.org>; Sat, 23 Sep 2023 05:37:36 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BBF199F
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Sep 2023 22:36:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c081a44afso54153737b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Sep 2023 22:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447373; x=1696052173; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yUz0aBRZdXV/HoyCWN8uhHLmcq/r3toZQGl1fsyAqS4=;
        b=OkXbC3XLL2fncEKVJfpjTFy736KtharUkMy6ukL593J21+rL5OaMLbdMbdnnKTnyDn
         ogUHpB+aqf+M6lcW7BtzlFyyjLWUxHlOOHuc2s5ZGH+v+SYF/hqraalOEx40Ur8g0XTM
         XCsW2qdqSRQH7IUbQp+L3oz7vtlgtxPx5HNWLR8dotRkwVrT+++AR/JC/JDB854fR6uC
         yw3/OustjyAh3SJeGo/+8KR7i6o5YFmRllDrN8tQOQGROryy7nfEQ9k8V18JRHZe+99M
         qhGS9s6onDyFnq0shMQINInk2p2WN4V/2Lu0Unei2OJGkfeGMfz2TBBB8LTAPeyge9sr
         Da5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447373; x=1696052173;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUz0aBRZdXV/HoyCWN8uhHLmcq/r3toZQGl1fsyAqS4=;
        b=rifOjrNVjelaMEGm4BtZPtVAIevQ/F/iIeDhwgOOYLgF0KiWXaB5SH9VY1I8qtbW1K
         5xoCgsLOvknXzXfjbLsSCnTcc/p+g1Yfjkh51M7aLKaobXmGkvYZGMe80/DIn+iKbo7m
         2XV7s3dV/ZtLokg4qv1wFbSKFs/4H6T5pRReEnO3KO1zgvr7GPt40tk76EExnbtaUq/F
         RcIs/DbOEoz0USEINPW40tE45FsPXfaYq/I9Z/G8v+93SIxXPBqxDU+VS8iHXt6f3Df5
         lAHiugBwd+RYvurDxSt7kxCCEyOEz+C5iBuPprrtbED22QW/hL+6UQEjVeYlgZhCkjom
         Dh4A==
X-Gm-Message-State: AOJu0YxOL6d7Qj25H9aN6X8KE/AYtljFrpy9uDtsuiey4uHWvNyQmdXt
	yp0pUTcvMXJ18BwnEcQx6wVYVkz1fRgC
X-Google-Smtp-Source: AGHT+IGBnACIcG/dQO74ULFKTr6l4nsrfL6I5S655YMfy6NLsr0dzVgpJAVXl+mmfzsp/SPWCJX2H8Efcow9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a81:451d:0:b0:592:7a39:e4b4 with SMTP id
 s29-20020a81451d000000b005927a39e4b4mr18996ywa.6.1695447372993; Fri, 22 Sep
 2023 22:36:12 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:35:13 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 16/18] perf trace-event-info: Avoid passing NULL value to closedir
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If opendir failed then closedir was passed NULL which is
erroneous. Caught by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/trace-event-info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index 319ccf09a435..c8755679281e 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -313,7 +313,8 @@ static int record_event_files(struct tracepoint_path *tps)
 	}
 	err = 0;
 out:
-	closedir(dir);
+	if (dir)
+		closedir(dir);
 	put_tracing_file(path);
 
 	return err;
-- 
2.42.0.515.g380fc7ccd1-goog

