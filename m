Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003A022D7A0;
	Thu, 13 Feb 2025 23:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487616; cv=none; b=ixa9q3nGjF6guhrML9Uo3/UmIJkZR8ZP/KFOXxJISPCgIKM8ea9xU3B2S8zZbkYfVKd7J3vEW8n4RF4ceEfKg7q06thk24RMNFWSvwP4cglC7pmV4YUeoFFuM72Q33r7icQEhcFHZixpHl3MinnmdtKPfHvqFcrwTW2ZcULAZVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487616; c=relaxed/simple;
	bh=xud1vkpx5QBShBiEAnxqUAouFYf1iqY9potr05uwQ48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzbHYLICHPeyFuGitOK49mlsZz+3KKpHawlM61pOzRjjZPiIOXPoPLIWDuzZr9emFhLCcOipdTJj7kjAUKZlzEuRjLwOnqHSajv9kgQDLJAkTCfnzmmRd5s43vOeH7APZ+YircINk0rC+qlacQACgJNSGhX13lV8dYbM5fmBxMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B964/z8H; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B964/z8H"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220d39a5627so20179235ad.1;
        Thu, 13 Feb 2025 15:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739487614; x=1740092414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHmbob/EuNLj2y3XD/x7wmk2Skfmv18lfRqvGZo51aQ=;
        b=B964/z8HDPGTsOgWLIIpmlXxhbpzHfWpueNxf6/sGL+Sudr71lG06Q45FqcLGbkUiw
         HJF7JbwotMk7a78F05zpvlk3XhAwJS093gHYVfi3jmmY33wbxTLFyVimq2KXS1WeqehA
         +PopZQQ/noNrhi1P+xMEppE99ehtSdJ7J4dULz2UTdnQTSJMEWuCf2bNe410Yy/cCQ3f
         eBPDz4Ry8nPAmmrWwy9Bat6zYfmoaQaq2EmQPHXaEE+B6hD1wKDJnjm5KMt8QFkvAPyW
         QJ98MW2VzR0Ywm4uxghsF7FZ5CuXj5CUWtNMT7Rub8/fq8lYBh2GK0sPmsGPB+0x81AO
         iVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487614; x=1740092414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHmbob/EuNLj2y3XD/x7wmk2Skfmv18lfRqvGZo51aQ=;
        b=sdFiAjdvuNYiA6mD4Yuq6tcLCszUaxjfyTY0E9SdqsJ/lE8HhtdHWl/GY9Ukpekoct
         QmdwdPtCuqc/Nd69Otr2/gaKansscYgoWySKADncMapqapGyanMqQ+/axn6fUCyBpvRd
         /2q9ztaFCN2IxSsYXHA8LseQM3oaxThCsnC6Vly9NLfPjiiWIzWh9PpoZDv40wAAGkwp
         tkBnUXEk+y2XTOm7b+W5j5zO8puTSskFdXIiV2s3TExaP/b9PP4txKpsJdDmJSWFTock
         5C5L9rRGg5VrPKbE5XFeDYiHt5ZA9pTI0HKIxRC2oZkWWxVwelhDz/tm/rgbYYu5yttv
         xO4w==
X-Forwarded-Encrypted: i=1; AJvYcCVP6Qe0a7zBcCwITMJSe1+nBCFdzdHC593NeeIVeLdf+QHHjNeIm/wn6PB+EIEMGUfOXqEPgeWWKSM/cN8JfeU6qQ==@vger.kernel.org, AJvYcCXl4Yz7KkFv5SHjftffE1qI9wWiUj9GnDIfWZYskqFSpMl5ARkoo9r4GWNoqPV56+OaOW7CXevZxp+XYYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypC9WjxuoR91shRQiuietnMjlbJUtuXLejjvC0c8MrenV2FYdt
	+C672B3bhx5wZfgtFo2qhJvzmt85U8CrW+JNkZ0volfdrH3zNAIt
X-Gm-Gg: ASbGncvfkv1cjNZTkebx24uqc/pdQbdSxx8vN1B/pXKI/7b5vjeNSRAEVyK9JghnVrD
	80UqxfwgLUS1Txj4GxC0a2yGTCy5CpvsALMCnejDD15EIauEnDNw1w1L7UgLmxoex4dty4siZga
	bBlkSORlyZWCS2Xs7onyP3CvJ2BEJupnMvrCPp2CIwTLeB5J83mWS1NObNFgSHdbKFrHmDWWPTm
	7X5lQRm+Mttf50lMyudV/liC7Nbf7Mv0c0TAakX6c57mnRzafB86md7+Gc6x1hJ3gwLjtS8zyt1
	jfNuEBHmJ1Bb3enF4NEICwRxhWpJ/e0LvkLG9NQNZ3629TU=
X-Google-Smtp-Source: AGHT+IE6kXadUoKzU/LoFKYjA6Imroxpr8JrHoRV6BPSzyCVoPVGQjJmiB9t+qktmg9gyHdRNzCbxQ==
X-Received: by 2002:a17:903:124e:b0:212:996:3536 with SMTP id d9443c01a7336-220bdedcf55mr148246935ad.10.1739487614257;
        Thu, 13 Feb 2025 15:00:14 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349210sm17641735ad.11.2025.02.13.15.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 15:00:14 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v15 01/10] perf evsel: Expose evsel__is_offcpu_event() for future use
Date: Thu, 13 Feb 2025 15:00:00 -0800
Message-ID: <20250213230009.1450907-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250213230009.1450907-1-howardchu95@gmail.com>
References: <20250213230009.1450907-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose evsel__is_offcpu_event() so it can be used in
off_cpu_config(), evsel__parse_sample(), and perf script.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-3-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 2 +-
 tools/perf/util/evsel.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4a0ef095db92..d5519ab25996 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1261,7 +1261,7 @@ static void evsel__set_default_freq_period(struct record_opts *opts,
 	}
 }
 
-static bool evsel__is_offcpu_event(struct evsel *evsel)
+bool evsel__is_offcpu_event(struct evsel *evsel)
 {
 	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT);
 }
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index aae431d63d64..e58de60210a4 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -557,4 +557,6 @@ u64 evsel__bitfield_swap_branch_flags(u64 value);
 void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 				const char *config_name, u64 val);
 
+bool evsel__is_offcpu_event(struct evsel *evsel);
+
 #endif /* __PERF_EVSEL_H */
-- 
2.45.2

