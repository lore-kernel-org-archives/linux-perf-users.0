Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C75BE58
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Oct 2023 00:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ktmI7q1W"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908E5D43
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 17:32:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a828bdcfbaso2890207b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 17:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698280352; x=1698885152; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J7OBreGJUzqAMOgAvVj/rwBcf5+fRvTFtfbDZAV5mtY=;
        b=ktmI7q1W3GD9oui9MNevESqh4QInA71eIpOiDDKZdio57uS5vPsiEsa4+mobobtSO5
         wN0LD8gbxhlH2igYjvcZfPxvnTgvSjqVr/sg4sIDmun9YqgVLqpJOQziB8s/j9rbg4k/
         qNhVZiHR7AVbxbVP6sLGmTlCclrL94Rvc0u6dHLn6Kip/eNNloPNcO226TTkvenz9z5i
         dEj1yFLaaraflt5yQ94Fzkc5kqLW/pRQPDs1ra4R+cT5f6mnU91JlSNlLz67xAhL1Xgm
         UP4EFGHNplA01ZYwKN6TaKm26NpsH8owxL4ExfulD8RbuTZfViIQxqM9YM8IQTKHwR79
         zkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698280352; x=1698885152;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J7OBreGJUzqAMOgAvVj/rwBcf5+fRvTFtfbDZAV5mtY=;
        b=wXUZO0ovHikCJvi66da50ixC/KIRR40SZjU4obT25R4Syf3v23ymzv9AejLBwksG9/
         gLPG+E9GfjN58JVEltLbmMlP8EDhGo7YLnY+rmY/Yc10zcAQQnctc0WzjDRsZu5IOEzd
         Ov3f5s24/aLzKN+wrmOA7jT9VAfePwHBw3PpugCDGFYfpXVzqhM6vl8AsCevpQOYJ5n+
         19K7A41GAf3SrghVduhYxWzs8cTLYFpb57KMpIR/0/9rIqOoJxW9P6WdtrShe7wC2RiS
         mRd7nsNm7qff0ot11Ggy2DzbxQfsvzMumc5xRr8mXrBaIp/ZvEd3NiQnWd0bonbsEQzT
         gZVQ==
X-Gm-Message-State: AOJu0YylE8iL61wsHjOrNCop6IOx8BfEi4yZbX9USUPJESYbhms8BBb5
	quek7XMpLuK+jLVs+cgMSUi5qGXSOvD4
X-Google-Smtp-Source: AGHT+IFDI9AFGQLlpSOOnrNi7Sz1UkkS4mcp+siEs/Ec9A0S0Op47syUrqdx7urODzP3eQWNa11IIZHIOLlu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:19cd:8b4f:c0f5:e803])
 (user=irogers job=sendgmr) by 2002:a05:6902:105:b0:da0:3da9:ce08 with SMTP id
 o5-20020a056902010500b00da03da9ce08mr137173ybh.10.1698280352413; Wed, 25 Oct
 2023 17:32:32 -0700 (PDT)
Date: Wed, 25 Oct 2023 17:31:48 -0700
In-Reply-To: <20231026003149.3287633-1-irogers@google.com>
Message-Id: <20231026003149.3287633-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231026003149.3287633-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v1 8/9] perf vendor events intel: Update bonnell version
 number to v5
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Zhengjun Xing <zhengjun.xing@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

Spelling fixes were already incorporated in the Linux perf tree,
update the version number to reflect this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 0dee3de3187c..e571683f59f3 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,7 +1,7 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.23,alderlake,core
 GenuineIntel-6-BE,v1.23,alderlaken,core
-GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
+GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v28,broadwell,core
 GenuineIntel-6-56,v11,broadwellde,core
 GenuineIntel-6-4F,v22,broadwellx,core
-- 
2.42.0.758.gaed0368e0e-goog

