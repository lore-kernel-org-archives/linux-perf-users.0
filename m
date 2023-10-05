Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC3343AAC
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 23:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TUOafyNy"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D509318F
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 16:09:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a21e8ee1b7so21774377b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Oct 2023 16:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547375; x=1697152175; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oxVOZd3C3ppqYjNmukwrdUncP0WHK7JyRq4ciQhpawI=;
        b=TUOafyNyFpkw5HlqfYRfZ2KDifTOAdVmsiDbHfjG/tZN/K8MzsmB/ZyW5kBRpV2Vxy
         de74SPcO2Y7bY63zeRo9X8qRZb4HqiJdZ5erMNkRGnn2RLShlYln8bQWo9Tr1me2ePok
         FQI67umDKydZoQghwfHdaV8hDbSXJh9GRZgQ1CsKGmFkPlmL5MO7j/icse3vDywordTm
         8W/sjG/pfzMWKZR3cNINtiHol7zEsm3s0i4AxMwLJqVdmUaG8VVo0nQtuiSl5ljNeFF9
         URw4OS+6wvbgPA8PFEREKVzNQQeBUu89MH+A/ukCoDC3jrHzJDnR1x+stOZJBTl/VL/k
         YAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547375; x=1697152175;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxVOZd3C3ppqYjNmukwrdUncP0WHK7JyRq4ciQhpawI=;
        b=wsOWNhJA+MHnBbbR18kr5+LmyIuq+rO6dtiFOG7N0pBvsEE+HkFpfediSC0cCQeuMP
         3/gSsTnest/b4BhnB4vtVDzodimaY239H7/mgXkyqf93p8nFzvi3iZPTgOKi1jIgVGZd
         R0nfZ9WAmZ3DppNj5Tk2enFYrpp6uOfqIP433Pf1YNAJnQerldxK6m1uWOdOxZHPZWdX
         Zn8AT8srdOGtlKUODHng6zEG7gMfg32sH7fwKdqoP6vvdKU7I5bsLbcfMmamDnG6Dpuo
         b4PuSSXtdy46dVOuoA9DvOClqPONNqw7F33LdpFFkva6UUJjJvK5Grh5pSqB+/zQZ51e
         wZVw==
X-Gm-Message-State: AOJu0YzwaK/qPEyUjhlIQ9jGxHiyZ51maSMHbFOBl2Q06tUErvICCn7P
	hVFO5p4gA37ow9toMz51ytc91U39U4p+
X-Google-Smtp-Source: AGHT+IGhoEJjFH3ZasD0vN2aSL1BJQWA509hpCLmPH3Yh8OO4E14fhwoU9hhQx/jEj6F0UZsTT+z8Dsn07pZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a25:6a04:0:b0:d89:42d7:e72d with SMTP id
 f4-20020a256a04000000b00d8942d7e72dmr57696ybc.3.1696547375084; Thu, 05 Oct
 2023 16:09:35 -0700 (PDT)
Date: Thu,  5 Oct 2023 16:08:49 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 16/18] perf trace-event-info: Avoid passing NULL value to closedir
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
	James Clark <james.clark@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
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
2.42.0.609.gbb76f46606-goog

