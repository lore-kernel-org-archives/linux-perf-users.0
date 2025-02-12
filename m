Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9D1211A12
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378367; cv=none; b=qvsGo0HaEUKI9Fv7KKWdZQ+NnU96W/Bk2uT837U+hFt7WR/F/j2cuzc1sdu8qtcLS1TG9+h3M4u10uNBIhnEJdlVmZZzVSiljZZ9Y7YKWMoRx6fEYAzguLJX14xyyGnnIMpMhgvWqcDtTWTwZxqezbatX3VIXBk1eXkhnPaXYLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378367; c=relaxed/simple;
	bh=+eMDq7a1WASW1tK78E/Cqn+dmwMKWRI9Ii6VvIFaW+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FmQqlKae+QYUafHunfzZqwZKIjW+Pq28HhvtKuXJmqhhDwObrmHCYE+Q5boKfiMvNVjfGkxmFo9Ci6sltX3/2904b4xhS7NAdtmKKcRCb/8BJA7l/29Wr9D8pRbt4WYsKTrozPvtDQ9ZWOK1eWe69S4kRhXoSc6FrEr4UFPATJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YUYlGpuP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YUYlGpuP"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so49424515e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 08:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739378363; x=1739983163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HuH5juQfbtVrRriQ2swAO0bGkJ18n/NWAw2oombbKL4=;
        b=YUYlGpuPIZoMa36IxXhXz7EFjODz9mylITVi9/gj5QVb5wBPTUbpyfzwZ9T8lewvoW
         ZSTY3ecZ71JOZID9OsE+SL3wybQ6yOnvAK8yhdp/d/OGTUQWDg38NMiDaIE0xZzlCVez
         xQYaSJXSEtn8gPCtIqZsCh/apTIs0ldo0Tl90yHgO0yNxoEMFe/+HQUC3cJKVRle4Bpf
         kRU2J1Ba4ik2w3UalQagxXj/wk32tW5gi/vbnDm7elWX8uWapcGHO0VGwS/xP0BLogGZ
         RxZofNEnpjFL/PguH1MyqRrV5lb35ghT3ZuSI5LMcKFV3Wd0WeTGDvlIsQEJOPM3rx8m
         yr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378363; x=1739983163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HuH5juQfbtVrRriQ2swAO0bGkJ18n/NWAw2oombbKL4=;
        b=gUAumFnZ/+5dRVjDtpzueMb4nDWFfwPGtlkhuFNspZ2MtKPzwUUNt6SlPv1o5Zdep+
         A+HZpLqQ7xUt/lKlBLLUmFRHrM1mLPhr4AO9ezt1jyPeUOG5/ZJh8bCnzjM4dT64DMSW
         BcE/+zhQBLHV7tAJ2Blkz7FvpssCr9FQXf8N/VYZ/8Q+VssNa+3YRICXJJwpv1yY9SHc
         /10a/RkndYldQl9WPBcGxYJ4Gyb/TL3NsZDhzlr5EIb48LC3McSVNslvEA2q38d5/4pI
         tVHIzqgl/DM535lz7eEbjVcsKxiNMnxqsQ+VG7nrJjSZkYEG7+NyScMsKKTI8TxLbmIY
         guVA==
X-Gm-Message-State: AOJu0YzpDktgGTdvpiKoDLQdU5NbrOdDQ7pmFALDZ2A0Z9zoN348Igp5
	qsOsSuXISzvx+AQOvzN275gEKUdRVSGX9cdbEfr1ywKKIcnfm8kUOgDwvveq0LD2cybeO5qxnRi
	IZYg=
X-Gm-Gg: ASbGncsP/3p8G9f0hI4zZLERWJFDHGSw6hiYF+Tl6210irmcemo7I8689NeVG/pSOiA
	mgRVReSeqNFYCilJIfUFpUztGehLXIiWWbiBfSoci2KyRzueV0WTNs42WPndZWmQpSNhpG1a/jt
	amBVcZNw9VGPY+guTQaxfsNinMf3fsTuKo7XHtscnAOrNKl8wh3n4DlApphkj6Qbh41WagdFKPr
	EiBFsKpzmpd50XFbUXc3YtKznJBBdBtHx3qpDRpfoifNIJkR9QQHjQAfD4aqb2P9+VRbqwTS1DL
	RYUnz8A2w69W5f0=
X-Google-Smtp-Source: AGHT+IFQkNgSgj+b+OY+U68LNI2iDcNuJlSGY5kCTa6FX0VTYZQH0d+xekmaicVjKu0OmPPm3D2EZA==
X-Received: by 2002:a05:600c:3b92:b0:439:35d2:ed1 with SMTP id 5b1f17b1804b1-43958173d7cmr41389945e9.7.1739378363549;
        Wed, 12 Feb 2025 08:39:23 -0800 (PST)
Received: from pop-os.. ([145.224.90.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a05392csm24519645e9.10.2025.02.12.08.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:39:23 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf tests: Fix Tool PMU test segfault
Date: Wed, 12 Feb 2025 16:38:56 +0000
Message-Id: <20250212163859.1489916-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tool_pmu__event_to_str() now handles skipped events by returning NULL,
so it's wrong to re-check for a skip on the resulting string. Calling
tool_pmu__skip_event() with a NULL string results in a segfault so
remove the unnecessary skip to fix it:

  $ perf test -vv "parsing with PMU name"

  12.2: Parsing with PMU name:
  ...
  ---- unexpected signal (11) ----
  12.2: Parsing with PMU name         : FAILED!

Fixes: ee8aef2d2321 ("perf tools: Add skip check in tool_pmu__event_to_str()")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/tool_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
index 187942b749b7..1e900ef92e37 100644
--- a/tools/perf/tests/tool_pmu.c
+++ b/tools/perf/tests/tool_pmu.c
@@ -27,7 +27,7 @@ static int do_test(enum tool_pmu_event ev, bool with_pmu)
 	parse_events_error__init(&err);
 	ret = parse_events(evlist, str, &err);
 	if (ret) {
-		if (tool_pmu__skip_event(tool_pmu__event_to_str(ev))) {
+		if (!tool_pmu__event_to_str(ev)) {
 			ret = TEST_OK;
 			goto out;
 		}
@@ -59,7 +59,7 @@ static int do_test(enum tool_pmu_event ev, bool with_pmu)
 		}
 	}
 
-	if (!found && !tool_pmu__skip_event(tool_pmu__event_to_str(ev))) {
+	if (!found && tool_pmu__event_to_str(ev)) {
 		pr_debug("FAILED %s:%d Didn't find tool event '%s' in parsed evsels\n",
 			 __FILE__, __LINE__, str);
 		ret = TEST_FAIL;
-- 
2.34.1

