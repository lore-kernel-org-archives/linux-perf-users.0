Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F56017CA0B
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336389; cv=none; b=Dy2RcmlEvs2Uol+wvFW51XlsVw60VeuMEcujMhrPSv7vcITP7S2Icm1764foZRXRBSmhox67vhSq5cDb557NH5bb0Fhs4yzfMO5wY2H9SNsF59YCmOQQB8P33AhTHiL1SpF6JNlEN0Sz06zHMgD8dAlkM/1N5eVubRd4izmeteA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336389; c=relaxed/simple;
	bh=4MeUin7pNU+7EH/vAMBdA4pzYBDobcDnylKN7J0QNiY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aITShZiL4dM2gio9LVKRPEppf7ZlG7b07T/92YSC2b1MMnf5ok4uWc3qu2zpoIfFt4AobPFxOj3ku2FgFPAtqev6xGcmDrGJSyPtEitTP6EunSOFLDuvHPsT11hSWjJHC2W73BxOptpSNl3ntSeecWdixV7q4QZXBJyNLZuPKxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tBFpHSP4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tBFpHSP4"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02726920d8so10459022276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 10:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336387; x=1719941187; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D7OMHNdMQjRxTIzl2tG5KSezF1r+KBWLgOtS9uud1dY=;
        b=tBFpHSP4pXvPS5Sd4ZExU2eMmznpZ0liiMHE5rqF8eUmrI1rg/VzH7WCEQfAsSIJvV
         dEAu3GbWpjNmIjEJqGP4qakUyKamzmZ3DhE4A5ziX9jcftxNMM4ManTcv87XnyvbhI7+
         3VxQ4dEE26tuawk1EAnOYSOQlBNV8OWnm1yCbCrGAlIo1j0nr8eAIhg6JcvmuskROC7M
         GsDoh6BFAHsXDTeexBzsWw5oJBfQtlJ0fBbG5oyxWEy+3m7C4tbftZbUPsD9DuFR4aoa
         IN31PkfEQPOiqBgLcLcne3NZgURtUsj0i3YzgnwBRLzCP2sui2EZhv44Hl/SAPicQR6C
         VKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336387; x=1719941187;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7OMHNdMQjRxTIzl2tG5KSezF1r+KBWLgOtS9uud1dY=;
        b=SDlJGOomMQWIU/GlI2JTrzXfubxMMRHOrpR7sCSNvRjQ7sjnuzCY6w3mPLNZkZJlmG
         XeGvtRvGiCf+4spizvG629LFD9G4SKkhZAq1S0wH53VWLN5n3OEVIpSMWbXHVllgw2Ub
         9lehS2WMPS4XJlVI9bBwoQp/EgyrrKjTiMlSdF1U9TJehYvehmpQgqrHcYAItp4DnUKj
         uwuo8EFATq0+TvpQfvu9D/AO7HPWbWoKoA8b7SP5qodX5T9cnU/ZClIwJQmMABweAtKO
         tOn+lPwgbNToClzps+kKKxDadol3YT8LGqxJdP8b8ACLVeHgHcx9THN8mria+M7+u6lM
         aJ1w==
X-Forwarded-Encrypted: i=1; AJvYcCXrEvAR+keQiP9omVazqJBdfUKX8g7AAyguOtNj9whN8hRdCK0DyYI0tQeFKoj4DXqsoM0yGOg/d5C9v6q1naNgvqTC8rHFaXQo01w7mdngnQ==
X-Gm-Message-State: AOJu0YwgQX1LSDws3Z4OnQlHgECEtZ2hsx5femYBlxeaz08oABbaIa+m
	fxPc/AG3lTpS9N4THMRNozSFGYEaLyWzV3dtqHxtdVkA1spaxjvOhuh4rtnca+uRShjJS9YoLPf
	LYckAjA==
X-Google-Smtp-Source: AGHT+IH5h+dU+rx5/EzkOoL79J/aVaZxf4gqHCwS5PQ8xku91EOiUh0yDtxvx/LFGnUXXUyGm4vqfn586d+V
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a25:2d10:0:b0:e02:7b18:fd6b with SMTP id
 3f1490d57ef6-e0300f19e7bmr58675276.4.1719336387272; Tue, 25 Jun 2024 10:26:27
 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:45 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 08/26] perf evlist: Use perf_tool__init
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

