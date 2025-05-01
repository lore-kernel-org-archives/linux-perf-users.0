Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CFC1CD0C;
	Thu,  1 May 2025 02:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746066496; cv=none; b=lKwLTdP8kH4losHoFgI9n23DvPpDPNcBj6+tATykRVHk7D9XrRf08vWuGamyGaPPrxnHN2CBaf5ZzzGnL/kxJrWEE0U2Fr9CTtop1R3gU1bCNmDf0WrufiR531sLGllNCGPCbzkEAS+nzM3fx2rWLSswhVg4uSlCwG1hKoIXqQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746066496; c=relaxed/simple;
	bh=WeNQ/P1lo7UWLgx5V8UqqLjs6z1+EhkpAyKNoReZE6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KerTW2+zgtjP2bLwaBryHHlDZaJBiUoo1C2tmMO0A+FPPdP81zr8Q3yhKsTQVHh4UtvfaBfn85w+syIorky5a8kJ6jmVd0mWrMykIm7PFCHRtAFtwv3yNqu/cTBw6fm1r61VapD745rNJgl3zJVIPybn7LPPLjTQI94wqYyob1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8YqzTC0; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8YqzTC0"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so569579b3a.0;
        Wed, 30 Apr 2025 19:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746066494; x=1746671294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12hNC2maesUW+julZVveceim9osLUhYsROQkLQc04oc=;
        b=R8YqzTC02oysUKbpALiol2XKmBhIOpV5zRMS8Nui2N9ErUilYQf1sMr8r3gBF4NrPp
         4GapoIVKZr+sb1OJVVXqjkpxLtJ0zj8D3YU4t3rds3JcZ5XnVj7brfPUSwGjzoHAzgXK
         9xsllY35Py69Lr4yYo4UFkvXy0h+V32oV01CGxJS+dhcPFqJkXTtHplpJMAeLP3H6TC+
         zjeiYbddsrfKhnjFHe0+WLLe7Hbe91WCnrPyofIpy90xZSz4ArtPiUfHHnyGZ7IJOO95
         rDDnCvshzsyHQ5h2ezlTGa3zuTcuMsOQtdGnov9sF4yPzfCGxDKC7AKt3Z9RCH88ooV9
         P+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746066494; x=1746671294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12hNC2maesUW+julZVveceim9osLUhYsROQkLQc04oc=;
        b=uDgiLZOYXFgj3el3cYl6Dd3sntU/AVf0qzQrrGbmRgpVP6TJpHMXztQDn2nTATuHtb
         9b2fSqQZIfz34wimUsDubjp/sm6GAvRHp9U2ElrRfMbrX0vgH30r6SwAW2/hYxGkrO3+
         A+dyXXiCHzT7tLTeWvRf58RxVIpSVF5slkvG/qzc7Azileg6fa7OnHTGCF4KN26JSUWm
         4ZJTOLQj0EdUyv82xIJFdoYnl6pSfonlPIk5DA1orflybzBG1+yifICp41VVzHo8l4jO
         IHRvLlubAMm9rjyYJeavCI77fg+l9FEM3bOBOnHSwSGvNKMKrtTiMi/gB1RF44dBORBL
         Z4lA==
X-Forwarded-Encrypted: i=1; AJvYcCV7QxjwBbD8GvCEpOTh7osQRXbdLHlanslzjJBnbsYJll+ui+ZRhbsTY61ia5SBoNS7SfjgI3vDpmyoPks=@vger.kernel.org, AJvYcCVPHLKNTqXs/+K733ELWT/sunkBCCSzc8/FtYX1xwBCV5UHsjT5Wq8PIXEYTGBt74h8CZ7GhR7FLyq6fRVFzIkl0w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8HRZcx8Pxg0HFDBHCIsbprZ0WelVvECf9Hfrf83Gk3sxOfhW8
	UZAEYXseUQ12AF91lmbaIhIntETuMHfKMsfaGh5MkR45Iwwjccsh
X-Gm-Gg: ASbGncufRq/pgQ8k0SZGPhgMf6Bx1uANIG5q6uSufPi64ceMt7uK+iPXZY2BTwgJBO8
	QMy07PfTykkqsIUtICfS1PPvjeKZ40s1V+V9haR3yYXWUmrvd62YkWWCbbbbW3EYIb20rVLXL1o
	dJVILKnJ/UxGQvbWtc1Wx5nlL3XghsI1Jk9gU/8AY2ZLjDijZ9fVD8141b4eVMMTfcZm/tHSzR2
	S4nD/GNG/5HVqQ2HqEfzzjDsEfFvT98F6T+f2w2CAx8HKPH2Uu7hJL0bb+FIne+kh7U4VQPA3u4
	FHWOfs9jhEmyvzmMdoMIIxravNLskKJ93+24f/yC1JeD+oFh8Cy7bwepTFS0qKRPewrz+biil7M
	AlklKlMH2Gg==
X-Google-Smtp-Source: AGHT+IGi7N5e90qJn3IHMOD45SIBkEJCakMr53jcFWv6tBFJxDpiqJFsA1JKY1ksJ4eRMmmXznH/Qw==
X-Received: by 2002:aa7:888c:0:b0:73d:ff02:8d83 with SMTP id d2e1a72fcca58-74038959430mr8855574b3a.3.1746066493942;
        Wed, 30 Apr 2025 19:28:13 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a8fbe7sm2459599b3a.160.2025.04.30.19.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 19:28:13 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gautam@linux.ibm.com,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v16 01/10] perf evsel: Expose evsel__is_offcpu_event() for future use
Date: Wed, 30 Apr 2025 19:27:59 -0700
Message-ID: <20250501022809.449767-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250501022809.449767-1-howardchu95@gmail.com>
References: <20250501022809.449767-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose evsel__is_offcpu_event() so it can be used in
off_cpu_config(), evsel__parse_sample(), and perf script.

Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
index 1d79ffecd41f..2559943d199e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1275,7 +1275,7 @@ static void evsel__set_default_freq_period(struct record_opts *opts,
 	}
 }
 
-static bool evsel__is_offcpu_event(struct evsel *evsel)
+bool evsel__is_offcpu_event(struct evsel *evsel)
 {
 	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT);
 }
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 42dcadfef8ce..3d47d9318d92 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -563,4 +563,6 @@ u64 evsel__bitfield_swap_branch_flags(u64 value);
 void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 				const char *config_name, u64 val);
 
+bool evsel__is_offcpu_event(struct evsel *evsel);
+
 #endif /* __PERF_EVSEL_H */
-- 
2.45.2

