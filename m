Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B2D8C0B
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 00:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112446; cv=none; b=gwA5emShBozjR595+KipMl7NkRizGq1Aq+wZQPltRYQ9TJ4fJOQBAPMKW9y5VNXGBhhQ06Q+Cmvh6w56yRRkoklaIDgY5BqqR3SCfJlkBY5Z3TaG14+9VhkSA39YW0W/EVR390LRSli47h8+F5wd3F0ekn58y8jD9ICHiC+VwOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112446; c=relaxed/simple;
	bh=JR2W9BY58B7KI+DPucllOVM9yijzERRopT+DlqMeLCU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BxBKh8m6cg+3Nu2j3/d314jVTkTmrqMENpUwI7w6IjjX2GZrAqmPd4dUr2QTTH1Pwi5Cs96/6NciqMoXOSZz3JnB0u+sxgN+UWjmiU7NGbePitoV1qFvWybl0r+qo1TlQoim/zHe5QLQqTIPn2DpFLlgiQuyfgb9W4sU070kCEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NN9g01zn; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NN9g01zn"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e338c1e8bcfso1473376276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 16:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731112444; x=1731717244; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SPWlc2lPTGFJEvFedKLB5LrjZb1UnFHbKvI0m+mSBo=;
        b=NN9g01znbIBzhADNo0L0gn6pbVE1FcOtPk+4Q3X5HAIYQq1JbvbR5nZaDUcUZ/syD9
         inpm8niVFmsc4Pwh2+V0cfbPRmyN8St4Qc9TCV9Kbq/iYVRjs0Ngfq+jZr7mFRHryRCU
         nw8r2BCMh80Ym8F9VDq+5d1ULDOixihVBJDwVqmyLBzllYCRWjjHCNxO/gTfmSNb5Q3P
         AKW3ABAdrmRXMTIVKfqW8OchobM/KMahRXKOGMWparefnJmzilV1Dg8dtJq/DgosMjJQ
         A/KPDtVwgJHzfcGFd+pP0as8tkG62umZej2qKmc6sUxzF+TTFitrip6l2AWYMK1c5WGa
         yGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731112444; x=1731717244;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SPWlc2lPTGFJEvFedKLB5LrjZb1UnFHbKvI0m+mSBo=;
        b=RgRljKSGhapQq2nrXSc1aCFzQ+Mf/lruXVkV3WwBaB0rS0hYj896+6PfRthPIwwS6r
         dfPptY3O7KRyLtTqRFb/POooI9eR8/2EPv56Y7xFEyVdkMH6F0wGwS67eUvxN38vPl/i
         J45tyKcl1ss0/hvvbsj6pR3vIA59fJtTTiWUsKKQ9ufl+fhH2pjP/wbS1Uxk7SqoBWcl
         +YCmmuu0Fhgshev519XHGeMGoipz5AUd3oR0HLTPR7S0UuqDDBRwc6YpEvtrpoISRYVt
         /VKB9Ka1mt4xPzDAUpGZCu5FbXBXPxv6WRIg2oenoOY/tBYVkkvZCi/bKBsf6YvMxYHQ
         +Esg==
X-Forwarded-Encrypted: i=1; AJvYcCWYSsIk1ZDHZgkDmF+XR90gCz4UtttmQmxMZhcrmpLrqm8bGP8HdhinDmZi3kHBQ+YpHZAakcT4ail0GTEnh1Uw@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx7DY1SHMZFbU9tcMPZkm2+sYGqIsd1i8TQiQSgRhVrJ5gFlRN
	A3ut6gORudeQzsjCMQGlJxNJcpwrse3ByzL18AxWGY/kWQgjFNbOnVBP3F/5T6Ds5fTvqWVMpNg
	sR05NQg==
X-Google-Smtp-Source: AGHT+IFPezKGEklr++nG5H/4/AeOE+yWUxDwLwnQft/snPRaDbCVYhzMwgPF847otz3H/KeF3sq9zCTHNjhL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:264d:0:b0:e25:d46a:a6b6 with SMTP id
 3f1490d57ef6-e337f8d405emr6111276.8.1731112444057; Fri, 08 Nov 2024 16:34:04
 -0800 (PST)
Date: Fri,  8 Nov 2024 16:33:52 -0800
In-Reply-To: <20241109003358.461437-1-irogers@google.com>
Message-Id: <20241109003358.461437-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109003358.461437-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v8 1/7] tools api io: Ensure line_len_out is always initialized
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	James Clark <james.clark@linaro.org>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ensure initialization to avoid compiler warnings about potential use
of uninitialized variables.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
index d3eb04d1bc89..1731996b2c32 100644
--- a/tools/lib/api/io.h
+++ b/tools/lib/api/io.h
@@ -189,6 +189,7 @@ static inline ssize_t io__getdelim(struct io *io, char **line_out, size_t *line_
 err_out:
 	free(line);
 	*line_out = NULL;
+	*line_len_out = 0;
 	return -ENOMEM;
 }
 
-- 
2.47.0.277.g8800431eea-goog

