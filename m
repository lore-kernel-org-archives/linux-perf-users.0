Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2677B194AC5
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 20:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434225; cv=none; b=k+hZF/lEKIPdvm70Is6waMOeABKpZbWfGyL8mv57fiAani5FOjeHSu3+KB9kUQFPBfgUnpXvJAcjbtIY3jBwvf38/Z1M8XQbj/D/OJWHAQSCOmP3+9oEhr5vxn+F2ZIe1kxBdl/8kqWB+2MpNcmL3YKZLbyYcBcebg1uRZQEvhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434225; c=relaxed/simple;
	bh=4MeUin7pNU+7EH/vAMBdA4pzYBDobcDnylKN7J0QNiY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=I0lxMybRHMtUH76Z/PevjzydAppybMFPwGW8oX9YCpwSiOS9mdT2VLKQTCLSH9+ufIp3WwDAgXXDjDqe7Prj/byImLe8fYBbTvG6KtDZEifymK1bDw0WLfTbcbr1GDlaQfGeUXrGcbMNeUjsiJNLtkNDcfBVIwI4RwkQSG/JKJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Raq4/Ux7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Raq4/Ux7"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-646f73e4354so44114167b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434222; x=1720039022; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D7OMHNdMQjRxTIzl2tG5KSezF1r+KBWLgOtS9uud1dY=;
        b=Raq4/Ux7ZNXCNsuZ42LKzdxNgY8rmoUoztjk045aaGzxCQjuwZqOrd81fEyX9dvMBO
         iYNWQEUwT33/s0rq32z8ppuwOeO1ONtsge90n9NuZ2ULPQX68Lq3CRU7dD/tQ5TLDm4j
         /8pER6My/DIF0k7lKB/9SAvDNele+ws36ghoA5cvVpwbwmSj90IXOvidiaLr2SBGCcok
         fPTzuNMcCJ3DYMWkKrXKcp6lBcKNuErJfiXItEm7JXBS51ZmLWG0O7oZB0g/wFORgy6B
         WHxi0wCrAXJEHbnTZD6i8QkzKvtu7cibQ+1dy+SCTDbxcPkclVQn3jFsq2WJSIsGyjkS
         qy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434222; x=1720039022;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7OMHNdMQjRxTIzl2tG5KSezF1r+KBWLgOtS9uud1dY=;
        b=oV1kPrztzfpiTGZE57PYnGs+gtHMRRXWgOB1zbK40LuNwhjVCqhEFk1C1NsimPypBA
         jyzkcHLcwjVBw26j2fKZFZqBq1I+/2BRcGGny/MZIwgx68rCq7JJ7Px/x6vq9Ju9SpFW
         xgHmrAdkz6SSFQKRCGmN/sQmB2nsHioe7jJp611kSC4v0kJiLYxfwhdAAc0eHL7w65Yq
         pDG9gOrtbNJ/1KzGaAQIXkwZi5uw+Aou/OOc3GzVmNQUCQcc6QDSHmoioMpGb+o+Sv8Y
         YBkBkLTz/URMYLV39cqOrZ6tHxcXI915zWuCy++2LxOqRAh6e5ro9j+/WfXQal9REPc/
         URyw==
X-Forwarded-Encrypted: i=1; AJvYcCXJY9Eju/+wEWv6pfa7GERdtbDYBbK/3xBwWVRW9NOFSEguzgyraaxrmr2XxDm6unC5wPzlTMDXvdTvVlNufw8dQMcuaTyge08sCMUYVJMd3A==
X-Gm-Message-State: AOJu0YygGszpQLOM9swK50U5AhqhSpSLrRs5XXNd8O/GY8mrbEWrwGZ+
	sdAD5UwU5XXfaxd56cJiMVGjtjWcTKcoS4/fQemnbogfpOjADna8ejWE35ubzAkJ7tJVYkAsCGA
	t+/38VA==
X-Google-Smtp-Source: AGHT+IGZVnE+Fch70MEK4rYQnkRBHIJ52T6vwPjRKNsQDQ2mlZBvGgRLnTbFrcJmRq10ailgH9nGrqLTUmBR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a25:aa6b:0:b0:e02:c478:c8b9 with SMTP id
 3f1490d57ef6-e03010e732amr25868276.12.1719434221944; Wed, 26 Jun 2024
 13:37:01 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:12 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 10/27] perf evlist: Use perf_tool__init
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
 tools/perf/builtin-evlist.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
index 7117656939e7..818ab21c3f73 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -35,13 +35,13 @@ static int __cmd_evlist(const char *file_name, struct perf_attr_details *details
 		.mode      = PERF_DATA_MODE_READ,
 		.force     = details->force,
 	};
-	struct perf_tool tool = {
-		/* only needed for pipe mode */
-		.attr = perf_event__process_attr,
-		.feature = process_header_feature,
-	};
+	struct perf_tool tool;
 	bool has_tracepoint = false;
 
+	perf_tool__init(&tool, /*ordered_events=*/false);
+	/* only needed for pipe mode */
+	tool.attr = perf_event__process_attr;
+	tool.feature = process_header_feature;
 	session = perf_session__new(&data, &tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.45.2.741.gdbec12cfda-goog

