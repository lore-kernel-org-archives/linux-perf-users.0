Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD141DFD94;
	Thu, 12 Dec 2024 23:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046053; cv=none; b=BD70Z8HMnlk2sySb6y3XN/QkiCBalbEKBcssPQpwkw51kgz6WbAA6Efxyw3gXxGLB4gEIzjSCAytXA10FYvUwWqfMfkGQ3SfR8V9VHKIpDMhFajuGLwzWH75wj/N/YFys5/8uhH2eWn3M1AZPwA+l6UA2XGWR9ZhcigQxxUY06E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046053; c=relaxed/simple;
	bh=e6fI2ZVl4IzPXnFdTWlY97syscDRQIiFgkHg3JcX4HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syLQX5OCFL6uqMpNEtgXjrUcbfvZ9Bt9DdcIb5qEssFSznwh02o2Kc+yZAtyZnMd28cwCHRblCRm20uXHosL7CUcVHBBSctWPWZeFvpCf8NutCOG/EX83a0QCpgncjTj8UoXBut1vIjOR/ocyGAFhbOOiTF/341EAUv/Ql/7B40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGf0SYA0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGf0SYA0"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-725ee27e905so1491249b3a.2;
        Thu, 12 Dec 2024 15:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734046051; x=1734650851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfGyJy7AZeOLJsFch884GnYaUHhnZ6+BK2uA6O0m4MI=;
        b=nGf0SYA0r11NH7tSl30VpVq0T0FARohybQNgz9nRNn49ymR3dn4Rs5V642Rl9Awgcf
         t2fdWJwSVwhno4EfOFa26a3TVYkDSdc4+VxFqp1TNwzxJ7SIMYPwdI6PM+tYyM7BKmLK
         HawdycqhQ8gVbQOo6aX58tRFCtYR9ujfsV3XUPAjSMOQVrxhizFl9TcZwhZwAF4Pwpq0
         Ik/N3VXCWlWyxnbx/wfKe6nCSrKbDqXHIgTQYo8QL63mojSav4hHFFDUn8ETZgmgd4G8
         ycWTVsPhZ7na4/8a+P1FPwONVlfdiHIhKJZfOoywUfrFmZaSCFBbU1DCSoLo6M+XvSR6
         pkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046051; x=1734650851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfGyJy7AZeOLJsFch884GnYaUHhnZ6+BK2uA6O0m4MI=;
        b=McE3Layh/245d1wbiOAK00Z1quX/so+voFUIeXs34M3rbAoowB+SDKXMTGEUSb1yPF
         p+RCBHPlKh/wnDVwX86MiHkQVhvCWgOIboBZ58KnImE/VMUfLRbj8XWlEtQ7CzUAKxcG
         2B0kHfrwz/efW9J1Qce3awFmURVdeVsKAHZqk1haneV+kOICG7xE5rwkz1Kau6XH3fEq
         TsG5Bk/YJdzVwQsGK/0HDkxKpdqepIl0LlYJcQ31xB9ukeZrhsq4KTQgqO83I9bO1Dzb
         Urhkz3kAx+17UsYA4d0ZYuz98hGb8CMt7KZx6irUJbGWbmnIEh9tyQpyWK9ianWF0260
         A99g==
X-Forwarded-Encrypted: i=1; AJvYcCUD3L09It7fMJ2d8hewZmZs1fHYNoQqFwY76+nU9753ZEx9MaAMTh1p88Rzsw5o22Do3eYrPs7lfuctAypGGO67+w==@vger.kernel.org, AJvYcCXNgxiBEwRuRfa0bdk03a5WxjAufZFSFGjQ3e+KtXQkHLESXxqo6n5dGSJmJnpwDBI39qEQa1LGJm31LEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsi+noJ78I4idgmc7VlOk6GyH3OMPiV97uMDSfXOsaGjNnRjwO
	YM2UwYEmutNdqJhEIgq7dBW+3XYxQ1+NuVS6Rcld7FE3MPoFYqt8
X-Gm-Gg: ASbGncuJnvqbvWs0naKSP4/uEmJ4bz7CtZ/N8TC6oxQAGAhx++vjPkzSdyqqUb22VdE
	lfIc7KSZmVYU5Q2T9YRBbSW+xy3gS46+fKBQdu+qO5zwp6GmcDiMQYMQjOaDmQMtL0jM/8emSPd
	LO2qYPZrUaWIscjsb9bKLoA4d2BSxG26vIpqSpgSrKNjlDbwfZOlowTliIsI17SPg/mUnztSq1T
	xqdTg8uxxirpLv0zIXhNfGefon5T881uwuuly0oZh4EsIHpRT36RReOxGp6IpPgPEaVyt2ZNMDX
	r0KWdW1hoJyr
X-Google-Smtp-Source: AGHT+IHn0yxYnXxJoyiQhqbBWY571ljeVb1LkMlS4qdlT6g34S2uq+QTwMFlMnAJT84nVes1tPPW6Q==
X-Received: by 2002:a05:6a20:734b:b0:1e1:9bea:659e with SMTP id adf61e73a8af0-1e1dfdda18emr720491637.35.1734046050821;
        Thu, 12 Dec 2024 15:27:30 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4e202e9asm7324674a12.72.2024.12.12.15.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 15:27:30 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v13 06/10] perf record --off-cpu: Disable perf_event's callchain collection
Date: Thu, 12 Dec 2024 15:27:13 -0800
Message-ID: <20241212232717.232507-7-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212232717.232507-1-howardchu95@gmail.com>
References: <20241212232717.232507-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a check in evsel.c that does this:

if (evsel__is_offcpu_event(evsel))
	evsel->core.attr.sample_type &= OFFCPU_SAMPLE_TYPES;

This along with:

 #define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP | \
			      PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
			      PERF_SAMPLE_ID | PERF_SAMPLE_CPU | \
			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN | \
			      PERF_SAMPLE_CGROUP)

will tell perf_event to collect callchain.

We don't need the callchain from perf_event when collecting off-cpu
samples, because it's prev's callchain, not next's callchain.

   (perf_event)     (task_storage) (needed)
   prev             next
   |                  |
   ---sched_switch---->

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-8-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/off_cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
index 2dd67c60f211..2a4b7f9b2c4c 100644
--- a/tools/perf/util/off_cpu.h
+++ b/tools/perf/util/off_cpu.h
@@ -13,7 +13,7 @@ struct record_opts;
 #define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP | \
 			      PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
 			      PERF_SAMPLE_ID | PERF_SAMPLE_CPU | \
-			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN | \
+			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_RAW | \
 			      PERF_SAMPLE_CGROUP)
 
 
-- 
2.43.0

