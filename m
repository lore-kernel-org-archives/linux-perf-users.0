Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E0F1411E7
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420963; cv=none; b=grzFhT+ajnpW8tnrZ2XoMROJgGa5wnq54r9QoivHxkFVgz33a8wNlf5lg7yCZNWcDgTGECvuSK18JV9q1Gv6fiYvm5hRVJGEH65DbWVnF88dcb7dfONJe0qxLPh+So6iyJdqzFrQFKT0RrEh5DVhu46cD1RHQzMjlV5kqq3LuXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420963; c=relaxed/simple;
	bh=BSADm/2St2RzD/ArABRW7n8F/sOX5AJupKxZq1RwerQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=szPssrJU+eEQE2OVFQrc9d51C1PXc95v82+Y71HVrqicIhubZ062IfY1JTa7EqpHZ3DOzWaOSQNMOQ/712gbUzjTm0lXwFasxzvZ9i8zSKcIMDI9NIfqGsJhZDpn+xbvgGKTmjpKR4nwdaYmtf/Gor8cFHFFNJHM3Eks/+nc6a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZPQgllPT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZPQgllPT"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61ab7fc5651so80163607b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 13:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714420960; x=1715025760; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=guh8O4YIfp8ysMStU/pCY+FOTLUwi/avvI0eH709Ct4=;
        b=ZPQgllPTC/vbo1pVkLD4y00ol4uFZnbh5Em2UtlY/ze3LdVrouLU5YCzzsceDGsj2h
         mkjYO+h2FXSMMMceXEXlXRh1T7P7Q/186F846yl+o8ES7c1VMYgH2us8uhBjc1iqK9x4
         mpwgdbrMEE2GoVtPAf8Yzzd6CzvJeZh2zdih2iNnXrwYvGoeXJeouMLcypw7BQwCed6x
         h2jBG2q2BkWE6shYN0rteXgSYScH0IfduRwLqqUScB6gY2MHdFVHXvlZS1lc0Aosm2Qv
         dx+/CNxw8W2pYyCqaJfdku7egmjMUmFpLDVh9jTa+EwzmQ0zw0a1uhZMXeCCg06yAOuY
         Mwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420960; x=1715025760;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guh8O4YIfp8ysMStU/pCY+FOTLUwi/avvI0eH709Ct4=;
        b=uShEvX67+jyZcaewi4dRuBPRD7opZZqmATzrFnQRTrTMVPXSggMPkMf1BoJqJwF/Hq
         vkMofyGiXnRtxeL+REo4aRS28mg8FzpcUD/yUDW6dQQE2b7LlO2tBp91NedajpihilLz
         ItqXCCViTRzhb2Ei5DRn3CK+11JFgbYfKAggnoG4GtmbIRkV2tDXXJc4WSQl1MCDp43X
         rrlMblk9rdSYQx6Infj5MELdzsAL48SFLGhSUftExpAEZTrxsyCA7PwzhX/TnhkRPxm/
         zH/rlfoaY+N2lg9CN1iudjVaiyNMonZ+VN5g81nHCDVuNh2EVyIxdjpgyhPMSJAdIbdu
         Ow8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxvsjzu37M+PCSXamer0FKHEauf2siV8PcGur7pN02gbpvvZY+Rz7fBvsCpJ2pGRekrT4VsUuGo+Se7LNJu0K3PEl/cexfsdXwYdsxnJn7+w==
X-Gm-Message-State: AOJu0YzdnzkbsCngHzU60ytUx4pdbhQ0Vmq08z3frTYsQuiewpuNv467
	CYbkpVusx5OrH2mQRRxp9Hir/2iua/pUPFTX6vUjOjvUux3/mrkS/pdfaNditLDaduhv4KEQWt5
	vZwKbAQ==
X-Google-Smtp-Source: AGHT+IHsWxlUWy6g/QWt0+iDzcjMhkg6SD3jd20yeYftef7GWrhyIwD1a8Pu4G93AtwEugDgPe8iE8WWE4kS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c137:aa10:25e1:8f1e])
 (user=irogers job=sendgmr) by 2002:a81:91d5:0:b0:61b:7dd6:1b24 with SMTP id
 i204-20020a8191d5000000b0061b7dd61b24mr3035436ywg.8.1714420960342; Mon, 29
 Apr 2024 13:02:40 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:02:20 -0700
In-Reply-To: <20240429200225.1271876-1-irogers@google.com>
Message-Id: <20240429200225.1271876-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429200225.1271876-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v3 1/6] perf test pmu-events: Make it clearer that pmu-events
 tests json events
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add json to the test name.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 47a7c3277540..7b2c34462fcb 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -1105,6 +1105,6 @@ static struct test_case pmu_events_tests[] = {
 };
 
 struct test_suite suite__pmu_events = {
-	.desc = "PMU events",
+	.desc = "PMU json event tests",
 	.test_cases = pmu_events_tests,
 };
-- 
2.44.0.769.g3c40516874-goog

