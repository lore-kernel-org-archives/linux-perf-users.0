Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06C31D8A14;
	Thu, 12 Dec 2024 23:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046045; cv=none; b=py8AxHhZf6gPdB7YG0wWf6XefTLG6DodAxaaT045IhAf7f0WdsbpSiQ4qN9Sa/Io1921qhh1C+z0VmUNvOI0RBuCS3bOOy8T68tJCh5onHOM4XTVVJwpawuGxacfzFxckyypScV46TGMmE0ELAMDohoMipR4oVI2zh/WzNwBO1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046045; c=relaxed/simple;
	bh=5zwcrkCXWGsnxL/5mROAo6TlhYsXoTqe91xEFV/fnQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+Yp09c82EvV6RgyFHB3fL5S0Cl+1vNweHQC08zf4dwBUNtNvzCxMNz1VE9JrFy/+CvyYpUuQGNr6RdbOFn+OKPYmIeAO8Zh4jBDMYN/Llvj3/FDv34eu45tUQJDG45Ih2zCUAhgo/GTGpdPJlDPTIuClHMi5CINFzUY7u8WXPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZM4JxHEG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZM4JxHEG"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725ee27e905so1491149b3a.2;
        Thu, 12 Dec 2024 15:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734046043; x=1734650843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wABlX+oSl9ibR4U3vdXkWwVEy/La7xWsUaZ6DFvspKw=;
        b=ZM4JxHEGlYZQJWmIaDl3gR99BMZeQ94u6wLyMp5Dwy1lW69uHX9OJvqA9zTtbASuKS
         vbf5ef9GVuuCUirk9sFEXml6/sES6xXV4IbPY79k0/d7zZ06V/CFLS0cl7iVW3sCEVLw
         2EQLbQy4a6evg5mzW39GwHnC/euTN2rjeK69hADZz90EeWhwC1oKYpdNxqvaLQyXJN6p
         LgDyWQ1XlkwkbmkK5ZVhdgeXv9Pa/PLxTGxZg1P7niVYjeGwQkMKEAWUCCZjI7Kzv934
         3b8jF6WSheJCQauR2+wCtwGpEJVYWsZmepZuW2KLEqbouC+DRC+zo3ahfH45fNF8m4vK
         kLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046043; x=1734650843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wABlX+oSl9ibR4U3vdXkWwVEy/La7xWsUaZ6DFvspKw=;
        b=B5CyFZ5d8M5Be4Ac55W9w0loUFpUGF8imo+At8mw0Xv0FdfN0tENOt8Jq0rcBsIYG4
         Ktj/Qa1scsHw2DnxlOkCrYkxFXKaV8zVXPnwR4Ei8kCivhEaBQPTgdazg7UnZzoCw8Nd
         akpQb0s/Wzglq4IkGcRVtbEMPu5XBUhUwVtuokEL3Q3+W6+ZKDNz29IA33lGyzaixL8t
         Bk2rvEGQDQmFfpwuP7lm0gQMlDVC5E6i1DUSPHSPtxNsUZP6Wz8nl6KGKw9rbhHbAj15
         82WMS/CuG5pFt3lVVaRMSeBbklgfz/z/Ro4qjDs5xmC+OvbA5eQvIf7bNUmZkBF2Y66D
         fg8A==
X-Forwarded-Encrypted: i=1; AJvYcCV9oGVxR+Vf3uhGhfJLrIEHTRjUklc6xBgb/wgr9vM8sLwWEpOzge05fluAQeEz4aQsuIE8KGgw3Iyjxfc=@vger.kernel.org, AJvYcCXbyD/NRfWQdRGEVapCoSBaBrOb/xlL4wywlvKJqnjUr16WSKpsLbeA9ESXoG1+v4ltSTVYtxYg5f/z2wtE8H4BTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz/8JYzXSNW94bs+CHJop5uHWMwSgzpCFAI77dyp62E4potcj9
	WrYTprpp/317jtDFGr+YX5NYZ05bMYNUmX97T+jo6pI80jsBwP2MKzuO2nuc
X-Gm-Gg: ASbGncuMuc2QxYH6r49dzOPnorI+m2GmfwvaDkA7E6J+JyB8eQlDIMyu5hE6cPU7T8b
	eDhUJHBQuc3GwYqry9ct/F4BixPWyXhmS7QKBDcmrldmKy6xJhIENa3Tza9b83usJ/Wa7YIpcYY
	k9Txu4e9GCTWG9Le6IP+Ns2kkPAnGrgPVrPsdCJYhAtK4MRfSz8pmE5Z0Uec4/TT4Xo8cQyg4yw
	Qi+mu8ZTKuKWHRz1tIxj5w5fLio36ZsT4yWK+A7zmK1H0PDFWaRW25N5+PliBa5vUd9a1I2aVY/
	qF+eP5IyOt5I
X-Google-Smtp-Source: AGHT+IFomYMUsTk5vraP3j6BMcwABo2ugwSt1BaqR/pLFGLm4HLoPFIf9AP3Zf8BvwgpRoVwmuFzPA==
X-Received: by 2002:a05:6a20:9f05:b0:1e1:b1e4:e750 with SMTP id adf61e73a8af0-1e1dfd543bcmr760042637.18.1734046043121;
        Thu, 12 Dec 2024 15:27:23 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4e202e9asm7324674a12.72.2024.12.12.15.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 15:27:22 -0800 (PST)
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
Subject: [PATCH v13 01/10] perf evsel: Expose evsel__is_offcpu_event() for future use
Date: Thu, 12 Dec 2024 15:27:08 -0800
Message-ID: <20241212232717.232507-2-howardchu95@gmail.com>
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
index 6cffba96477e..867da727a486 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1242,7 +1242,7 @@ static void evsel__set_default_freq_period(struct record_opts *opts,
 	}
 }
 
-static bool evsel__is_offcpu_event(struct evsel *evsel)
+bool evsel__is_offcpu_event(struct evsel *evsel)
 {
 	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT);
 }
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 93b6244ec302..f5004f92f0c8 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -553,4 +553,6 @@ u64 evsel__bitfield_swap_branch_flags(u64 value);
 void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 				const char *config_name, u64 val);
 
+bool evsel__is_offcpu_event(struct evsel *evsel);
+
 #endif /* __PERF_EVSEL_H */
-- 
2.43.0

