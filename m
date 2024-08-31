Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD7916D4FF
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Aug 2024 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725087870; cv=none; b=g2jvkdnte/sssbz64NxcbsTuRJXRHn9iq1wH2t/XuhEzH1sTe3JSdC4+wx/+BcPjKw2xVzjOWIGgsbsyr+jBkf1oydouzVlOQH1Dxs/493FjjrNU+hRUq+JPJJM/cGNuwD36rSpjaZdGkMDRxpRo8AAysINX9oUqj5BpUGRzdu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725087870; c=relaxed/simple;
	bh=e7twF7D4RZxswFbYZbFUFk/hv4Xp6qmoMYXmywlWvMQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=LhLrgj6g2ldnXb4/9/O7601yvjBIN2ZxBBNzLSlqoUfDyo05W+4ushulluYi6HTULfLKNr1uR2cz6j/93cQBGJ1I/nsLGOiH436FRoJg1NWBE/Gg/QKbwI7vgdT4vlcA1wrC5ZGsLb9JvXgPv7ooyhNJIxeWrTsUMXLDOk9bja4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LO55cXUg; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LO55cXUg"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1a8de19f5fso905236276.3
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Aug 2024 00:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725087868; x=1725692668; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5JYnw2dXbPbmg3NZBXlioPl/0JNNRzqtalz3T5B9FgQ=;
        b=LO55cXUgFO9f58d+MRZBv35n+pVpR4useOAwGWcn4XVMrfJ8WO68IMzmTp/mwhEQ1j
         DVJnHRgINOkZzRHLj3/vZMrvyehKlklGgM6RM51XfUZYgueanx3MH8RUvta3/4VznHMW
         Xi6u4vt8Z9VK68MQz9VB7N5Mey01XmlxOA1tlYUNQBcE0tzzypC9hh3zULKpB26GRvfJ
         vdifa/S9P1AT8nCiIsLZJkwuqqtWzmzxvTNciNxHYICCf9W+/PyyIWUBgJZ8Cryqb5ZG
         I7P3fsSkwIlU9Qe+vKbhMPYHV1BGVoIW0skCWEFXkTs7HjNJPwxnmZQQxw64enOVfGqI
         Ulmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725087868; x=1725692668;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JYnw2dXbPbmg3NZBXlioPl/0JNNRzqtalz3T5B9FgQ=;
        b=YQ4zdGVMRzMJsktck/nXpw0r5keqthuyIdfek0DxIRCto8BciIGVLI5nJk535l/K1l
         7MPI35ssLwwouNH9bKgdwpSMzJH4Ukym4nuGlIHTpUDIBPwCcdwfe9c4pcNQVT/Giqoi
         yL69MmjYXhU5kYrXmb1rXQysSSoqwCWrbzhRRyvUuotYc6lboFJyiDJEgRxvr/wR512f
         PuzWLlhx9ctRnfXGi8hMHj1oGQyI93F5zljQuCrBN7GriHqlZnAxzuK/SzSwvVq2T9aq
         vUnvh0kuoTF2+cbWoOq8xCu0GZaoC7+OhLik2+2DYgYPKN3VJeN9G0FcilhP9/xwXpYT
         KZnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPHPV45U3FB1JnaQgtSagkS/crOHPBewD9TOQX3P8soqiuSWEyWTdmW6cGyIkUhUOuQKRgqkjSBVM16Pz/w679@vger.kernel.org
X-Gm-Message-State: AOJu0YwLd0s2NbHnIvZbLr382BgjXc5jWs4WG7Q2UWShFBEowe2U8lfU
	9oL6Ymtat+CryRecjOjYP+GuIY4BRBVTORGpPoQsMS7QygQFQDkLPieBauswuqVmysakgidMKC4
	Q7mA34A==
X-Google-Smtp-Source: AGHT+IGdUhZFJPlK/Qxv//Vm6pYoy9bw5mKZTru8Hmeo9HYUH5eUEev/E5gQd0OB4l5BuG8DCERNpBMJv/70
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4974:82ff:2f9:edb6])
 (user=irogers job=sendgmr) by 2002:a25:6883:0:b0:e17:c4c5:bcb2 with SMTP id
 3f1490d57ef6-e1a7a1a6710mr228774276.7.1725087868388; Sat, 31 Aug 2024
 00:04:28 -0700 (PDT)
Date: Sat, 31 Aug 2024 00:04:10 -0700
In-Reply-To: <20240831070415.506194-1-irogers@google.com>
Message-Id: <20240831070415.506194-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831070415.506194-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 1/6] perf pmus: Fix name comparisons on 32-bit systems
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
	David Ahern <dsa@cumulusnetworks.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The hex PMU suffix maybe 64-bit but the comparisons were "unsigned
long" or 32-bit on 32-bit systems. This was causing the "PMU name
comparison" test to fail in a 32-bit build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 3fcabfd8fca1..769b920d9250 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -69,7 +69,7 @@ size_t pmu_name_len_no_suffix(const char *str)
 
 int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name)
 {
-	unsigned long lhs_num = 0, rhs_num = 0;
+	unsigned long long lhs_num = 0, rhs_num = 0;
 	size_t lhs_pmu_name_len = pmu_name_len_no_suffix(lhs_pmu_name);
 	size_t rhs_pmu_name_len = pmu_name_len_no_suffix(rhs_pmu_name);
 	int ret = strncmp(lhs_pmu_name, rhs_pmu_name,
@@ -79,9 +79,9 @@ int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name)
 		return ret;
 
 	if (lhs_pmu_name_len + 1 < strlen(lhs_pmu_name))
-		lhs_num = strtoul(&lhs_pmu_name[lhs_pmu_name_len + 1], NULL, 16);
+		lhs_num = strtoull(&lhs_pmu_name[lhs_pmu_name_len + 1], NULL, 16);
 	if (rhs_pmu_name_len + 1 < strlen(rhs_pmu_name))
-		rhs_num = strtoul(&rhs_pmu_name[rhs_pmu_name_len + 1], NULL, 16);
+		rhs_num = strtoull(&rhs_pmu_name[rhs_pmu_name_len + 1], NULL, 16);
 
 	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
 }
-- 
2.46.0.469.g59c65b2a67-goog

