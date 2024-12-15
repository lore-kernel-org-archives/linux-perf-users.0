Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAF3149C41;
	Sun, 15 Dec 2024 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734286360; cv=none; b=J8Tw93Ghg5hpeKdnF/kT1gMy1s96t9AA/MCcYKobB0PZ53+WxQlJC3/bGaSuazLJR/qSSmFpYYoKk+vV+1CR4oWNyF5h191dtbxujih1nv4VZaOGvVwMafJsrXAM0igumvFtq358HJO5mCeBx9yFmuV3UHd6nUsB/f/NX4o2/3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734286360; c=relaxed/simple;
	bh=L/pLYwMbeoRQRd9+SvwZS29uLUby76c9EPlwh3l3AIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhAn1njMjWBYJCr9w/HoJ73JQacPisTCBWpeRQRYyb5GEOPTI18wLkjOaIPgZSlHF6l33rUJYuw0tgHm9GSKDAT6YlM5B3kTPq+RyvPes93xgBBRcRq3AQ7mVXxzS3ohZBxAEhHMC3z3838sztisGKjEObkY6kxT+V/rhRK2PJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcF0hBy+; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcF0hBy+"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-72764c995e5so1986538b3a.2;
        Sun, 15 Dec 2024 10:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734286358; x=1734891158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1n8aol4fFd1J8Jn704GnLxaE4etozmEifbq2ZMZVg0=;
        b=fcF0hBy+gVU03i6SRnbYNPdwovXHHA3qKGKK0vKulDxR+njR1mbT6QkWs/vYToL5n1
         S5MOt9rgsZjkerUPJbGknV9vhI64hmngQtGxzRcvta5eGn48SRtqbeBBdR1i0/o+4kb3
         5GDk0GkUxgQvUu8Wf3tAEfaPL43rGEQVLrQwio0xdHdOXYEds2jeX/b3AS1N9ILdIfIF
         m8Z1xzVyVOnRM2xUyizuVmuSggd5gk6cwFHrcc7CrWqqujV5kd4pD95W8LSmFnYRb988
         4Y7NDmdsAxbrwBGiiKiRMPfBJ2i2nXjsiY4v8v1osSfXgLNyAyBN1pkFt9Xzmw2b7Lwb
         tgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734286358; x=1734891158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1n8aol4fFd1J8Jn704GnLxaE4etozmEifbq2ZMZVg0=;
        b=YSN2sZz50FlkGaeplPbR8+O6Of2K0J8LPrYGZRHbA/2X3rURdjj3cqRAU8jpvARl+n
         tKrG1EzFGifPpTPIXLQUVBvkboz38qqMhvBNAte7AJJ6tuI+uHpRHzBTVF4uruQ0AVPT
         HZn92c9TQ+0vZ1GZrxTavjcT/qxq2pJhwBD+QOTZD+xpeEVFYDSk2XN2H+v4TEsbq+kD
         HlXEqFu4ZsdWFMSYL83E853ROHY7Zt1NBHE2a3v4U1eMqJm6HMkMVj+FBTbZE1cLUo5H
         dfP6MED6NAyj8HOBf/azyeJybeXUTYkWw6Fz74jfVYIBKEBiM2fBS0XDPNt2rsqBOEyf
         rRFg==
X-Forwarded-Encrypted: i=1; AJvYcCXlu71GNdoN85nQmmKTeeXO+hik84vn8eDKW02PCugjomf14oRU38eifTdjdf/RfbJZlk5+pb40ShDwzrM=@vger.kernel.org, AJvYcCXnRane/G+VXHNoGm3gM1fptL6Nw9bIn7cW4hQ9HEWTSeaEGzSSWprftUGrYSdB1wah0Zy3bb1MDS6QpL0BT9umXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwq8VLhGKx0mN8XChwyaNpVYkxU+OHzybXzyFcI+wcRtqgy0YL
	ELVn5V0Kzr53tuEgNaILUPFzhbKMxh1zbCLPSF7WztAha5+V/kxe
X-Gm-Gg: ASbGncubplEo42Ns+cv18QcMpu0WPa3p2PQEp5yh0WU6Z9sGCY8IBDnBg2t055NFmXx
	UI9KbaKqHYAvYFDPnIeT+ioMzu9WP+j1tl3UEkz2dGHo8sNypDahpyjVQAAYoAvzi0CmDp3c6rd
	xSjnE+E4GTihH7yaseCiW7oZm7QXsQWckxyHTTGmMhessjxtEds78wffeelVFgWGJVwIS2UDRfj
	AZMksYyICg/FS2eh4Olw1+bHqu7psveR2oxAn1xVR0WJcb4jmEUqIMkfOhbCqxF808mJA5sc2yC
	AM7pGaJHRlrQ
X-Google-Smtp-Source: AGHT+IHpSrlqrSP8HjQdDaP7RoJWB7L/J+VaQapQzhQJc4z10kagenH+Y4uQ2ELJGW1L6O8JmKBjcw==
X-Received: by 2002:a05:6a21:4988:b0:1e2:5c9:6791 with SMTP id adf61e73a8af0-1e205c98b45mr5549334637.15.1734286357863;
        Sun, 15 Dec 2024 10:12:37 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm2808120a12.16.2024.12.15.10.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 10:12:37 -0800 (PST)
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
Subject: [PATCH v14 01/10] perf evsel: Expose evsel__is_offcpu_event() for future use
Date: Sun, 15 Dec 2024 10:12:11 -0800
Message-ID: <20241215181220.754822-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215181220.754822-1-howardchu95@gmail.com>
References: <20241215181220.754822-1-howardchu95@gmail.com>
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
index c93311e502cf..94eb3dc034f7 100644
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

