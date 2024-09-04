Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07782126C0A
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 05:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426383; cv=none; b=VwWBrIyeoCCU9XQYRRFCToCoRWaB7UL6VpvZHwUsz7mn1F0OBA1OGkr1oIZZl2TVdM5KmmZu3CQ29ZpH7pA8/gHbIHsfuqNFGhgde6GTzzYkl74S+o9A4ZvHLm2ENt8y8Xrvae8+kgHJT6efkEOamtcVlSn8TuFBAy1gDRba2rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426383; c=relaxed/simple;
	bh=Q1I8/KqNd+IgmzvG/JiTn5xSY7RsyeGAbkFJILM1hHU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dovRvICtREFpBor5xTu3qzTID2I/qoWJ0yxyNTI81lrDa4+mfi87tQl08ManY8naXDdwO65RFVA4nH8oX1kgs2IeUw5y5EL2bFtuEMxixL1rNz/3Dec90irTIcaAB4puu/Vsr3rSR56qBA2hlW0qK3lsAO7SeYH/QQBOo1cvUBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EirMHyH1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EirMHyH1"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b47ff8a5c4so119807277b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Sep 2024 22:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725426381; x=1726031181; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4q+ikrn4FGFI9cUwKwk1kBRcs/+UO6jVCe5+l0RzwM=;
        b=EirMHyH1EWu5Quwl+7LjdTUuVcJSYsTVF229UqS7nV7l66dv/Wa+jL+iQ1di1hsI9f
         vBgaoYxUa2ut+GfLVpmxcE95FXRuNNCWjw6mk0qroTGFt76xApg3+ILWoorISXH5dV8Y
         gDE7l9YzyCNXpgVT3ybVefKE335cMWBY+Vamu6RZ3cP9Q0C2ht7JwDF9hOr3bJwfiB+i
         lzbM2heJ3qK6hsyitVhakGV2myiP31ZxThRRvrL+Dsq2743J83U2ehdT4NaMXnoTu29k
         7wyvQ5mqIGrmM5TYH4VhKEoHBMfI3g+WAtemjcXqzssArIaXMOvOh3Em6pdIp0ZElu2H
         zGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725426381; x=1726031181;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4q+ikrn4FGFI9cUwKwk1kBRcs/+UO6jVCe5+l0RzwM=;
        b=qtBpH24FvS+QpOZOFbgX7QInykSEvwQCpJOZFDLZL9UlIY+c9BZR4KGPYAGo6MI3ni
         33CwM7YgYVjSelkMYcVS87lNvgSz4QBoA661lJQ9ubdZlm3xIxxSQSKA6zFTYg9H6XHl
         M/4ph+rUffaQ0fKn3W90VEYfVRtrBiH5OJ0/3SGJ4nDjBviB0/BgQp7LaBHLXNMRmdXo
         Eu0uNL5N5NZMI8Ufr6iHztxLy/Sj62WJUPXpI40D3oVK5xHuSANTHIRwB2Mn5b3/Wbxf
         njUcPEBW++NMzf2mqh+kPtEHSnE/0+YRkI5UWaekQs9z/Ec+GYFso0aXnh+cO+Hgymhl
         lloA==
X-Forwarded-Encrypted: i=1; AJvYcCUOwJqByS/+Myf7Om3Aj7EYCfZl0qDl6Qxczo2SiEZLDrkMD/mtMBwXJs+H22jZ4RsJrZohjd2x2PQyy6/ddxyu@vger.kernel.org
X-Gm-Message-State: AOJu0YyjzcbGbWe3TxYBm1l9furV0ISLMa8n78sTaInhUoLWzMN4rcln
	9ATDKoLXQAJGTVEyWxKwzz6vKO8H49W5pEosKDRCDUztIeksQc/mVfmv7VToibn7V3adCeH2OTc
	CUbWWEg==
X-Google-Smtp-Source: AGHT+IGrkNY4sZtaoI7gmxjOo9z6gRU0ekufh63mJP4BdzVqe1BLQYZom+5S68Fh+5ysoSl/ZPzbZeIsT3ia
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c48b:5e3:a63c:2d09])
 (user=irogers job=sendgmr) by 2002:a05:690c:3193:b0:690:8ad7:55f9 with SMTP
 id 00721157ae682-6d40d984611mr404937b3.2.1725426380808; Tue, 03 Sep 2024
 22:06:20 -0700 (PDT)
Date: Tue,  3 Sep 2024 22:06:05 -0700
In-Reply-To: <20240904050606.752788-1-irogers@google.com>
Message-Id: <20240904050606.752788-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904050606.752788-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v2 5/6] perf parse-events: Vary default_breakpoint_len on i386
 and arm64
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On arm64 the breakpoint length should be 4-bytes but 8-bytes is
tolerated as perf passes that as sizeof(long). Just pass the correct
value.

On i386 the sizeof(long) check in the kernel needs to match the
kernel's long size. Check using an environment (uname checks) whether
4 or 8 bytes needs to be passed. Cache the value in a static.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 792e5ed94870..fa71f7f1d8d3 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -8,6 +8,7 @@
 #include <sys/ioctl.h>
 #include <sys/param.h>
 #include "term.h"
+#include "env.h"
 #include "evlist.h"
 #include "evsel.h"
 #include <subcmd/parse-options.h>
@@ -672,7 +673,22 @@ static int add_tracepoint_multi_sys(struct parse_events_state *parse_state,
 
 size_t default_breakpoint_len(void)
 {
+#if defined(__i386__)
+	static int len;
+
+	if (len == 0) {
+		struct perf_env env = {};
+
+		perf_env__init(&env);
+		len = perf_env__kernel_is_64_bit(&env) ? sizeof(u64) : sizeof(long);
+		perf_env__exit(&env);
+	}
+	return len;
+#elif defined(__aarch64__)
+	return 4;
+#else
 	return sizeof(long);
+#endif
 }
 
 static int
-- 
2.46.0.469.g59c65b2a67-goog

