Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BBE216DF4
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884083; cv=none; b=MRRLv40z7HTYo0WeRq3lGZfBHOYZDXyY3k0PJ7XmRZfbIJdrHBze49RGt5SzdI1Orq5va3awVptCMB84va76EMeWXm8DhjHdHqLnspO14U8dKRfcFPYZS+3Jf46tKItykPpYu6K0TL+tiCN12ys0BPttVBCRu0ekIlYGVghk1LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884083; c=relaxed/simple;
	bh=bl0TwbExu4G349NNkk4dquZriD14f6vKBPjGiiViYyk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JEHDEKNCmeHE+5vR0Thws3SgrahI+Is9hVfcK8W23sf2jCMLt0KSMHmx1CYHiih8qQU+kHvt2C55AXdsAOPQYJYhJBXffMKPHSWy5/gPTRreFiYku4B0PAmgqZ8QwRIkUUlDDRUBLLtj/q25LqVo98Rq8g6YKZWav+9ZE3yGLlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bpjDkPiE; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bpjDkPiE"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35d1d8c82so47714097b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 12:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729884081; x=1730488881; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2yVnPqZ8RpP/8r+vCUjKwDzk1QDMtk4+iGqU5/U/LQI=;
        b=bpjDkPiEVbqldAK7qFtuGUmE/yqWjEGWL06+Z6X94otan2KK31U/gjgQ1987Mo2bHX
         MQ/WWUKm1MPk5BAWyBo7T4Py5lbcbKnF7FSHiSl+dyidozDaWKKjR7rXvPDjqR66qj73
         3ORiXnSrTQ+OLAuy6IFF2ob5TNZWi34wjqcAwKDkDhHEX7lhM3Rc1Mxypw0peR+jZZRy
         6o73/inlcaoIwSIl986YbE/qqLVFHagYhE6z0shTUH9xap9e1Tw5g9WjmEPKpsoNRzwW
         rZjJL+gvQRvb+oOBoIqLvyKDeA8cwYFnm4pmcXTqdDuO/q4dilSxW4rAVnUNw8s3gCUx
         OjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729884081; x=1730488881;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yVnPqZ8RpP/8r+vCUjKwDzk1QDMtk4+iGqU5/U/LQI=;
        b=O4MS86lnxQjhi2j8+5PIKa2w9HogMV3zLm3YXpwOIGYf4eRQ6Iw1jujyefvoehdoYR
         NPOWEwJwe0fG1llinHo654/QxlpqJpQ6dVt9bX/rigbSDpIUjB60T3Uf6qX40ghl0xVG
         c4RndqhVy7aO51t4rUeHZXXF495rn61AiLnUj7HU5zJVLcr1b09As2CPEmqUa4cUB58E
         LOIPPaBcf/MYLiYEAT872ujAvFtS+ClgoKjWEYLVHrBAaO46EdFgUgA+ZCnmGhGQUl4p
         m6ZPKWWFRMIvk6MHxYd5pD0Zft5Nv7reumdU+s7XHW1FQ1rou5Sh1BhoB5XC42QBLGoA
         YHTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkvfDP2AS6aAMDhCHpNSVqaleEWmPxca3oqJncpCSaq03F6qLRp4LyHujQXJ6wPGRwuwBPvaA3Y+cjhsNrb5ZN@vger.kernel.org
X-Gm-Message-State: AOJu0YzzqUXP5TGqvQJeFfdsNRX1D4Lxc+Xc0OWyuEMmz3lfud7t1L6Z
	2aXCYTBT54KNvzcmjLivSWVVitGGKHYOovjTJjFKi3U6uVQehDj9S1DMa66rSgCLvcLFlD8AlwR
	KvFwOog==
X-Google-Smtp-Source: AGHT+IGD95Dz7s4SY58TIPO1jaSqaYOrqZkpzNst4Ej+pMqlACgZPWYG4A3kUs+EkUUpEclRsAV7/bDATl4y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a81:be05:0:b0:6d4:30f0:3a74 with SMTP id
 00721157ae682-6e9d8b5ed4emr165137b3.6.1729884080901; Fri, 25 Oct 2024
 12:21:20 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:21:02 -0700
In-Reply-To: <20241025192109.132482-1-irogers@google.com>
Message-Id: <20241025192109.132482-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025192109.132482-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 03/10] perf test: Reduce scope of parallel variable
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The variable duplicates sequential but is only used for command line
argument processing. Reduce scope to make the behavior clearer.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 57d2e9e03fbc..0e8f877f4b1f 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -41,9 +41,6 @@
 static bool dont_fork;
 /* Don't fork the tests in parallel and wait for their completion. */
 static bool sequential = true;
-/* Do it in parallel, lacks infrastructure to avoid running tests that clash for resources,
- * So leave it as the developers choice to enable while working on the needed infra */
-static bool parallel;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
 
@@ -578,6 +575,12 @@ int cmd_test(int argc, const char **argv)
 	const char *skip = NULL;
 	const char *workload = NULL;
 	bool list_workloads = false;
+	/*
+	 * Run tests in parallel, lacks infrastructure to avoid running tests
+	 * that clash for resources, So leave it as the developers choice to
+	 * enable while working on the needed infra.
+	 */
+	bool parallel = false;
 	const struct option test_options[] = {
 	OPT_STRING('s', "skip", &skip, "tests", "tests to skip"),
 	OPT_INCR('v', "verbose", &verbose,
-- 
2.47.0.163.g1226f6d8fa-goog

