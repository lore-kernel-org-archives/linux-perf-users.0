Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECE17F9
	for <linux-perf-users@vger.kernel.org>; Sat, 23 Sep 2023 05:36:27 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919CA171C
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Sep 2023 22:36:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d852a6749baso4571137276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Sep 2023 22:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447368; x=1696052168; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U3pdNCB2LsormKDmRgRav6emuDoIUkf2JUNU+RA747k=;
        b=w9HGH3d1H4ueLvkTYf/V9zbKX8Yc6tSYtDN5zllmhvEKeshrQTVkvtl/b7xy+XuVNa
         EJCvipKcLdQkPyDrotUG0VTu1ggww/WhaQipU9ZZZ8Bz/EV9+D2iZW+6jReCjjnbvx9f
         UA0ocNNVEnxrHnOyE9w/BOVyR6+1BNAtmLFIFOvUX+9Qm3g+EyoEhl6xBnvzR369qaxL
         FHm5ahOwiFYaBAn83VQGLZDqsKTmPwgKFd4sfxQK88SedFMU+g03ND7S2fvbHqSBuzNx
         GnrH54bhndTuHF0X2zlooC/fb63utPwq6EPUXgeanq/bi104A4q4bobpPQkgwMYWxeX0
         0goQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447368; x=1696052168;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3pdNCB2LsormKDmRgRav6emuDoIUkf2JUNU+RA747k=;
        b=UDskPR6gntOOe86ipKN4A52Acwl1heipmZDE3FPqNlahBInzqbPhlm9WTTUinSnUJD
         hc99RwBHqWgfqGLjmdDi3vh7yRPU9A0M2NmUcjVkQ7BlRDBTNSBtCMJT1zT23cv65hNg
         wk/n214ZGrqEO8Krw00NI9Xc15IFkYjxtu0DQMPZFtUltncMxCYKoK/AfsGtqrKKvcf3
         CiSG/AocpxX4YTMILMA5otuiu4aDmChTM4fxuyyKkE1CGM1O87i3n+F1NGHG5jzfhBon
         umq95k83KCNiijfp9zSDw1r4SLr9XxVm5/FRTs1WxZmtA7XKo/anpGbSyfowExtQCz/p
         V0kg==
X-Gm-Message-State: AOJu0YwwIUSqeFGHqsAXTSz7U1rjzZIAIhCvBDgiFHt8CfOqwc7Tsqwp
	itucR7bTWXPVrCbuRdS1fP8LAgdhS3YT
X-Google-Smtp-Source: AGHT+IHCnNmAl4FHX9SRP9LKagjgjeFuwIZsOgArdKHwnwaZmzbMv4PHYCjxCbJouwmMwwuksIiI1+0lADIr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a25:238d:0:b0:d78:3c2e:b186 with SMTP id
 j135-20020a25238d000000b00d783c2eb186mr10894ybj.5.1695447368466; Fri, 22 Sep
 2023 22:36:08 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:35:11 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 14/18] perf parse-events: Fix unlikely memory leak when
 cloning terms
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
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add missing free on an error path as detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c56e07bd7dd6..23c027cf20ae 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2549,8 +2549,10 @@ int parse_events_term__clone(struct parse_events_term **new,
 		return new_term(new, &temp, /*str=*/NULL, term->val.num);
 
 	str = strdup(term->val.str);
-	if (!str)
+	if (!str) {
+		zfree(&temp.config);
 		return -ENOMEM;
+	}
 	return new_term(new, &temp, str, /*num=*/0);
 }
 
-- 
2.42.0.515.g380fc7ccd1-goog

