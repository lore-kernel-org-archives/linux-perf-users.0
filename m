Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20F11F0E38;
	Wed, 11 Dec 2024 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954429; cv=none; b=Rx042fr6luNWWMDxMZzXRCcM5DS+exJ+wYLA04GMc433T0u83+Gt//4ILFp5hBgIuE+V7/3WNWJAB9XGofTdFqk2TUCyqBpxv2WRSTiNhE2ib0vZIyuizk77DstrsOubuPxDAw0UyGVWDxz++KmRfUWQMloy7JaXYP6Q7OK+vHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954429; c=relaxed/simple;
	bh=5zwcrkCXWGsnxL/5mROAo6TlhYsXoTqe91xEFV/fnQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2vvnhhL//65lztt/h/eXJ3KG8rMoz6ylN1HffckTOpnEw3JmXiR24LvLEhmFSYEoLqKczr9ZFV+aWZugIEOaKABFbfn0dFFAQlBYdKh4eSstxdWqnK3Hu5VFp3Rp6D5jbC0XABPmsDB5BIzaYG+KMQkGppWG9ZmUOZp0H+cMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+FCCph/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+FCCph/"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so6458902a91.2;
        Wed, 11 Dec 2024 14:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733954425; x=1734559225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wABlX+oSl9ibR4U3vdXkWwVEy/La7xWsUaZ6DFvspKw=;
        b=J+FCCph/q+I19c42/vq9WNgTBVMV0UX0Go6hrAt/ikBHjULNJ2cs68BlBxn472VwzN
         Pny5tWJVvZOIVQfCzaEFYpD4W8IF9jjDPhvtPDbR6DVrdxco4Bp081FgtBYYag5TlVW6
         JfmYH3s7vnaN7KG1u9FPAusazUMwTaY7WO46XnsiIVYCuYH6ABVmAGAy9K5pbH3NpRDR
         NZLzDZfTMKVu5ozuCsF5nsSy+PH1ce7fMHLx9qlBTNtlscas3bj7v15PUWscQLAWjaha
         k6JWwQW/OlUp4Ehl9iTzZ7G0aoSQ6FhBOmE7T5WkZTqlnjDITgW0S1RxBOm5jBILO+x4
         Fcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733954425; x=1734559225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wABlX+oSl9ibR4U3vdXkWwVEy/La7xWsUaZ6DFvspKw=;
        b=QnajtwKgQiIC+DGSmr+4vW2R03W0LY53/cvZME/EIj5tShPDzkduO5B7REHLp5KjK/
         NNFk01L3e1JGBuIhzXUQrge+dTREg4M+yEIGluni6huSLiL2gleVncNaCCd3qe7S7tby
         +Vt+aHVMdVHDMln8isJQZZnOu3lR1UPf+lHRIF+5edFh64jsJDVVoGQt1LdHJV5m1VeQ
         ZVp0dx+zO02B8bofq9qCQw8hdBi62bCQ6dQj2qhOeoLP5m0Bxsd5YSEd6DBgM+x5P/r4
         JApgChdIoMyqAnNlPmg7dcgfeXHd34IRb9vea8jrOYUOazHZZ4RiK/3lYL8zqUfiWpXR
         mIAg==
X-Forwarded-Encrypted: i=1; AJvYcCV0ANj0mehCHAk8zk3NF6yNRyWByVnRDKlLHeCsJv2LGCROopiO+JB7jJW61QUixJJg5WwaUjMnG5CwSm/myciE0w==@vger.kernel.org, AJvYcCWwPl46zMlm7VuG6TqUF7wUXnSEb/sUZMTvohkBDDt8tznA3rLOEFqtiT5AgaKStKJ/AhXnqw7zdaIL5lA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKAIiguX9bMV/3q8eMUiCPK5zr8k8r39dUKohB6f6PvAVnrcKm
	4WLaqG00IkkZrFEQR3aFXvdkXHJJ85rs/TDZBqb7le61O+oUd4Nf
X-Gm-Gg: ASbGncvdXlt9DVuPz35h51eaH3uLL8V79T6xg9kQMjNnmllrA6yrlRQrFRsrsoNkGxl
	QVy3RbLiV3KSjmn7XdoUaPOrnXKUypn8+CQkA5MphCBq42vuMCctcEvCuzKWmRf3fzeXvQu5OGz
	Svi9/1dvv3iSuIAKMeFv+Z15don7FJdss7BgGaClZOe2ZURtOLVJzxB6X6tBrr8A197Hvz6dhsr
	EFzfBmYvgrmBvCUhRnysTEMyP2bx2EVinXa4h6G/s3JUgqwTBijZJR4sXLLpB4+WpyUtgSaeaYL
	B0F4juPJRA==
X-Google-Smtp-Source: AGHT+IGW1olFgrsbQA3hNizzmjvjXTfDBsfMOxMvF6cfacYAeRtwZf6z2IUusMfdvJVBl+sOrQyA9g==
X-Received: by 2002:a17:90b:2dc7:b0:2ee:c291:765a with SMTP id 98e67ed59e1d1-2f13925b1a7mr2447114a91.8.1733954424984;
        Wed, 11 Dec 2024 14:00:24 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2700cccasm13912665a91.22.2024.12.11.14.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:00:24 -0800 (PST)
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
Subject: [PATCH v10 01/10] perf evsel: Expose evsel__is_offcpu_event() for future use
Date: Wed, 11 Dec 2024 14:00:05 -0800
Message-ID: <20241211220014.931479-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211220014.931479-1-howardchu95@gmail.com>
References: <20241211220014.931479-1-howardchu95@gmail.com>
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

