Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EBB43A93
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 23:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fhhJXZD5"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A390ED6F
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 16:09:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f67676065so22245547b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Oct 2023 16:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547373; x=1697152173; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XtYWHIWRia4V/bq2E7J5Z+6HzWlGjlCMeDuedPRX49U=;
        b=fhhJXZD5Qj8zrrUspUuhy8saP1dXx/3nv6YL2dXlA1f2iAakZNuIR/xEVBscrK3sfz
         rmgoHL5VgHkbnUbzYapkAALFe1d5GTLZb8rXeuwpdu4Ir9ouDmeXmJNxhAy9hdRtVceM
         t/XVFFrVt5cWNsY7aPfPM5XMYaDP7inSDgFhwNDG13XCG5OCC4UVyx+5jRblmOxj6zLt
         L/FBG1pR074VxvJBtmn1Sq3jDWGHnPu/VTX0n4OdC9ZfCrmwaiIYAiLPIicQzlf4Tz8V
         bsquTprunvD+/E9gxjFh+e33nLpdjeFPmv4hdefepxouwwiQgYr19D3ZpwrsVHJabY77
         93hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547373; x=1697152173;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtYWHIWRia4V/bq2E7J5Z+6HzWlGjlCMeDuedPRX49U=;
        b=TE54ezmcWEQv1dcevDIVrS0GvCx8HwhCNXXS3t2SDS58mIwkZHx2RjwDn8hiqgpO8b
         3Ok39+Xdkk8RUSzHaq9oqdpU/yTzuwpwQ3RUNgXGjEpQ+mMF1aWgBsgqFLaAWXvA5VY3
         Vz2T/RF2QtbAnTmndlujr2yeFVDVNE8yCKh2s0zwLxEKaakUf99eNXSRComtyr3AYaJZ
         jVrcBFMi+OOQqbV0gLZ/RtOc6z/9QeEkeA82uWUG7Xam4epHXHIGXui6fr9JrQTSqFUS
         ckknm1Mk3Jj8OFwAyDkqKQA+LN7uCGOLc/nIuJswhUnVoF1ruSnVUWWQepZIoh3rNNIm
         84mw==
X-Gm-Message-State: AOJu0YyjgZzjHymKIPVoQosLfFZVNuKDGWbZHbAANAL7Su4X9JYAwwz5
	8PJPbvFHbhw3bpFPzmhgKFimlWwQR6g/
X-Google-Smtp-Source: AGHT+IGYGvZnkG9pZnldPftjX0X/I/7GYYCZctlrfJO2uLsaOS59cFuWhBo7VZbssurDfKkKblBviKnfkqu4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a81:4325:0:b0:59b:eace:d46f with SMTP id
 q37-20020a814325000000b0059beaced46fmr114023ywa.8.1696547372891; Thu, 05 Oct
 2023 16:09:32 -0700 (PDT)
Date: Thu,  5 Oct 2023 16:08:48 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 15/18] tools api: Avoid potential double free
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
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

io__getline will free the line on error but it doesn't clear the out
argument. This may lead to the line being freed twice, like in
tools/perf/util/srcline.c as detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
index 9fc429d2852d..a77b74c5fb65 100644
--- a/tools/lib/api/io.h
+++ b/tools/lib/api/io.h
@@ -180,6 +180,7 @@ static inline ssize_t io__getline(struct io *io, char **line_out, size_t *line_l
 	return line_len;
 err_out:
 	free(line);
+	*line_out = NULL;
 	return -ENOMEM;
 }
 
-- 
2.42.0.609.gbb76f46606-goog

