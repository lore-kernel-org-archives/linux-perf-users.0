Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FB01BD027
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 23:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737676781; cv=none; b=FIBWCzGiNjdusvfDcS6yrgjaBOMRR2XLqIVp7avug6irdfrHjd/iIj1+xYvmjhdappwlE29as8Cv3mQV5Sxb6/+nC9gFg7yqf+/pe3oamZ7i7p57EvqPnADeimE9CVFrXM4NR7RQnWgWNZTjreh9e0i9uAseSb3zF10kTbilAi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737676781; c=relaxed/simple;
	bh=bWgQLBpkfpxIT34/8Wx/CNRUEQDQg1V7I+bbzIQI6f4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kkRrf8JkdzWBUJU3+SU9DtOjBmBsQ6zJ23oB9HYmoEYzkIsoxTzZRaQDELD9eiPZ24T4xjQ/PDTXHUrx7bsRl+IvFdv5ORWRgV1jg2GDc/qgylsxERpPOTuV0Ta66uveMu47hubNwvzJwyGJQ0BOf3Xb0+zOXEuFNPlZA5YPCyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=CQC5+NwF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="CQC5+NwF"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-216728b1836so24773095ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 15:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1737676778; x=1738281578; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5m/RuW26VeXb+ulCBQUP9Ev9ewcGepBG0IbXPJOeedk=;
        b=CQC5+NwFnIVAxPa4QQcXIKu2R9oQILuYVs5c+kpCeQOPgVmUASXdEuzDGx8ay5wfcj
         HiUnyJoz/TWnAEjo4gIdr2/p5biZcV3dwRIw4MM5YU9JFiGPUGnQOUOZ4u4wO+Gp5JC7
         J9UE5L01Wcai/oWz2ozP+hl2gHMJR8hoU5Sxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737676778; x=1738281578;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5m/RuW26VeXb+ulCBQUP9Ev9ewcGepBG0IbXPJOeedk=;
        b=HLqvCwhD9XKlMJm0frPEc/yjOhxVjEKChs+BRHLoES3yB8cxHjff2C20xDq56Un9cN
         GSwzBjr26wvW8qYCYlCO2OsYmRbfJTQF75QZW3UnJtlVt7Mrl/6V1i32er++mz93whDp
         4nMfnhh8ZtUpTYLeKQPTj7ZyGq3grc1OiuRSDBaKtcG99zH0lZh2ZbBiHwCqEOvtUbHp
         h0228SOAbXW98UQdR+0kKqdFRW/eRhlomXnS5CdEVdSqyeFxFCZ/9S64xcfF4e+sRpYK
         Q6cqOGOT5uHoXx9Dpq3iZuDV3enxiq3YfYZsaRNbetizevscuE6HxsPfnRCbK9enLTvC
         xyZQ==
X-Gm-Message-State: AOJu0Yy4hahPRthRx4+DGfQo+UqGy8THDV8d5AeMzAfho49afwYjNOy8
	S0gqmYfos8bMdYZWgKsrFFHom/AiUE6pNUB/U9JCtXi/aHToAeLT8MdrZuRDp7w=
X-Gm-Gg: ASbGncsRwjihRsKclkJkd/copvyDtTcd8WM1pQZwjQHFAQf1SQ5RFi11IkE7OhB0Vvy
	5H0FwmS9hbb67Q3GlCws+ezoJUjTmozwc+cNrHUNfV51xKHd5GrguCcavsuMu9uRWsqnJ/PooXp
	WLDj1tC+yHqA8RkfrMhtYZdDXJ79nl7a/6MK63e+yrDf4TwvClbKgrpI9CQU428XrisghOr7hsC
	ezOqFJr1wmezBPisF7RpLaB4GdTUFw0DvTrWeAJ87Kuc5wnlK/aF/8ucqR2oczjoqjJIXmNMESj
	UgX5xCC1/n68lymTpx0/bcfg3gmIkrT2R8MikPTTsJuJsA==
X-Google-Smtp-Source: AGHT+IEPqjhQVpFd3DogTe/CckCCbHZwhWa9F5A94jY7ve5wDBGv7zqqz1Lb0T8ZhKtstlj1bQqa4w==
X-Received: by 2002:a17:902:ef11:b0:216:3dc5:1240 with SMTP id d9443c01a7336-21c355ef44bmr393632985ad.45.1737676778206;
        Thu, 23 Jan 2025 15:59:38 -0800 (PST)
Received: from [127.0.1.1] (158-247-70-44.PUBLIC.monkeybrains.net. [158.247.70.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141d41sm4656375ad.126.2025.01.23.15.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 15:59:37 -0800 (PST)
From: Benjamin Peterson <benjamin@engflow.com>
Date: Thu, 23 Jan 2025 15:59:35 -0800
Subject: [PATCH v2] perf trace: Fix return value of
 trace__fprintf_tp_fields
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-void-fprintf_tp_fields-v2-1-6038f8224987@engflow.com>
X-B4-Tracking: v=1; b=H4sIAObXkmcC/4WNQQqDMBBFryKzboqZGihd9R5FJI0zOmATSSS2i
 Hdv6gW6fA/++xskikIJbtUGkbIkCb4Anipwo/UDKekLA9bYaNSocpBe8RzFL9wtc8dCU5/U1Vp
 LyMagYSjjORLL+wg/2sKjpCXEz/GT9c/+TWattHrWDi/M3DjT3MkPPIX17MIL2n3fv3551vK+A
 AAA
X-Change-ID: 20241212-void-fprintf_tp_fields-8aaae2f5525f
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Peterson <benjamin@engflow.com>
X-Mailer: b4 0.14.2

This function formerly returned twice the number of bytes printed.

Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
---
This is a small followup cleanup to my earlier commit 5fb8e56542a3 ("perf
trace: avoid garbage when not printing a trace event's arguments").

To: 
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6a1a128fe645014d0347ad4ec3e0c9e77ec59aee..c2e8ff48682bdc86a0a21f54f5163eb82d4cc17d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3088,7 +3088,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		printed += syscall_arg_fmt__scnprintf_val(arg, bf + printed, size - printed, &syscall_arg, val);
 	}
 
-	return printed + fprintf(trace->output, "%.*s", (int)printed, bf);
+	return fprintf(trace->output, "%.*s", (int)printed, bf);
 }
 
 static int trace__event_handler(struct trace *trace, struct evsel *evsel,

---
base-commit: 8883957b3c9de2087fb6cf9691c1188cccf1ac9c
change-id: 20241212-void-fprintf_tp_fields-8aaae2f5525f

Best regards,
-- 
Benjamin Peterson <benjamin@engflow.com>

