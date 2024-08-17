Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FD413CFBD
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Aug 2024 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877106; cv=none; b=kZJKse+IklnXdCeqCimzJpFEs31V/kDSaLha7sT+tVNfszH3VN0vXL8kGt7vCnsgDByE4O8RxUoOc7R01Xc/OkINm8UCdHkzj5HjEPRqXHf63ZgWuMwWFNUgG2zpwDXb7eMCx6CSAf62BwGSA0NYJoWozr2+jh3tVbA2SaoUnYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877106; c=relaxed/simple;
	bh=8O1Y6scYhFyMobEhQv8IUwAJvsd4pajhjp1TTW88UH8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Qqi3yho+mjdQSUKuK5h42kLcJVTvp5liuR2gIRt7r4ZpGm8Cy/qciZlC6H85VkYJw6wF895e09fY7w8Mc6s63BO/NBZx+T0By2j/SYEioRiDg8b92pizH1fjYLqYLF4WL1MulxudwUfanBj8yDHgIrsTb0PNpqYD2biYy29uEVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FAj2ohnl; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FAj2ohnl"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b46a237b48so11848477b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 23:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723877104; x=1724481904; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqApkqpthfyxrYsLzWSBaC2fZccyqsDwIPuPbR5JMvQ=;
        b=FAj2ohnlzB9VygWL/EvZj2BLGj5zVsb9Mt+6+EaW4pFQ1z0X81CASUOwAwELKK28qB
         +s0brJ1CfCG9jneXcGPbnyhWgcpat11CImHsUPN14DmmOLNEHW18f6R1WjdIoiWJbnMO
         ZNptJ33p3+g/yM4h4Q+mzLK8D/IPWuIBTSR4JWepiVOBCZ6oJSvil7OBc5651rI52819
         iRbD8GXonWtz3cv13JAjgT6/pW5HiUCIrIBERDJyYrFnWMadqGYy3tjxdLc2nZTRyXkP
         V7Zy+LF1yad20MJaTvmz02Q39mUM/2c/9vviG2a7a5o0qYF4gdkAs9LX0ZoYRarXaHsP
         9BwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723877104; x=1724481904;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqApkqpthfyxrYsLzWSBaC2fZccyqsDwIPuPbR5JMvQ=;
        b=Vuoe9j9GWFoc6wWKZT7bBVw2Z7IMZ4BPPAYQTf2UGjoC/rDqp93h4OqtyvNJjQiHqj
         26AA4dz962qEVVyd2OXuoNcYxAbY5rdQUlp11GjPuat/7HbaLOke918S+61cPTxLcqqQ
         wTmtyxVEVa304U1wT2X0+dWf/LU4UM09tV8XNAOXQcPC+pci7A5intottizVrpL+Kj2K
         IjOqVgNX6BfJUJSBP4drOU7ytP/GhaIs+7Z/BE54aXM5aAEk1l41ba+5JnXSqG44rekU
         H519hPnP9Ne2geZVjXhan4XDawhkF/+7PEmV08PXL3QQ8ZqhXEGrhvKMQuerDFRacSYL
         DUkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD4v6W7nU+eOkNtL351V5vQi2r8v4xkuogTPyKzjOjI2b/r4dgfuUpEAKK0zmnHkgN6QbZ9ZChBI+TIDYqct/njHkxU6MfFtX9fRH4yc6I+Q==
X-Gm-Message-State: AOJu0Yx5cvQB2UA2Nn2yJu8M0HZn+0lyRI5sxuw9dbB2hoUvH7ZivU7W
	WrLmDvkXtD7dmkyST+Met3Ho6gAGBQD6NlV0DrEYfcDRBcoeJglQ32vueBz2Tl00LF09SFGEup1
	G2fvo6A==
X-Google-Smtp-Source: AGHT+IGg3LRJosB9auNcaghrQgueNTv/MMX58STgLkl4G0wV2VDI1N2aFQK4MBeoUYtE82hs2DHfVEmhWdmH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:78c9:5e58:734f:c59f])
 (user=irogers job=sendgmr) by 2002:a05:690c:4c82:b0:6b2:7ff8:ca3 with SMTP id
 00721157ae682-6b280074fafmr1410557b3.4.1723877103765; Fri, 16 Aug 2024
 23:45:03 -0700 (PDT)
Date: Fri, 16 Aug 2024 23:44:30 -0700
In-Reply-To: <20240817064442.2152089-1-irogers@google.com>
Message-Id: <20240817064442.2152089-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240817064442.2152089-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Subject: [PATCH v1 01/13] perf synthetic-events: Avoid unnecessary memset
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Casey Chen <cachen@purestorage.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yunseong Kim <yskelg@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Anne Macedo <retpolanne@posteo.net>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make sure the memset of a synthesized event only zeros the necessary
tracing data part of the event, as a full event can be over 4kb in
size.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 7f884d70de81..0a7f93ae76fb 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2200,7 +2200,7 @@ int perf_event__synthesize_tracing_data(const struct perf_tool *tool, int fd, st
 	if (!tdata)
 		return -1;
 
-	memset(&ev, 0, sizeof(ev));
+	memset(&ev, 0, sizeof(ev.tracing_data));
 
 	ev.tracing_data.header.type = PERF_RECORD_HEADER_TRACING_DATA;
 	size = tdata->size;
-- 
2.46.0.184.g6999bdac58-goog

