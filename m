Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52945473C;
	Wed, 13 Nov 2024 00:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457714; cv=none; b=OSTQPtmTtdDl+h4eY8BJrzVAt0/Am+gAbKIk/4vqyOFUelRmnV1SIkGKMPdnycygJVxflWxVyu1Ezg4VfnKXEAyf+yfJ20VKPq2pKnKd7j2dnL09F+QAmIL5F68+lECSxrZ3NHSsWjNCN69MrR8TiO3Q+hLoM7B/ml3gzSFpXmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457714; c=relaxed/simple;
	bh=zCl0xnl89SvnrshuskE96re8cOP94+xKShT4NmxSfSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkopoF6UPX6gI1jBu7saAyibpve8kP12IFknl2UM4mBPsVHz9Nvfr49TacVXaHw/hFyoHWNYXrleCUyZbg/AQEcfDkshVu/LiOkdDd9N6ObNGVxsVcgGu5MVdeXP6qZnvO9/nYMplDQZJiPQT9noRoKi+sZorqOsD53QSbXK6hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c58sxkHN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c58sxkHN"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c714cd9c8so64657805ad.0;
        Tue, 12 Nov 2024 16:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731457712; x=1732062512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGntfCGquRPrSkUE9BoFC9ltLxK8sMXbqjMOtZuSP1w=;
        b=c58sxkHNbztmVmQR6XJ8WrV97wFP/rLQyC43WK5oa9qO0J3fo+RVWTuZCM2KC5tgX2
         jXk+/Yliy65wvih9B6uIkyJ8HU5XQnOrDCHIZRDRT2I5AQlAhyGMy1VhnjihnN9RGts5
         3FeO9aDAU5whYzSc5t81vLQRJ2tfMBKDSB0wqNT3vzLHcf2QxKAM5tjkHqUQ6MGt988X
         6KXo6sU+8HiJ8MB+S/LJFErTJU0UtyfQIH5XXREg9GmPdRtRfK99+Vh4cZRjzESjxupk
         fGaSz+ozhLXiWlkwBVloYUIhWUC3A+GKteguDYMXP0fdS5TAfSsZEWIlLUZjfV1nzRwy
         mvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731457712; x=1732062512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGntfCGquRPrSkUE9BoFC9ltLxK8sMXbqjMOtZuSP1w=;
        b=wb7ickdanAogMewLLEES/8/EiNumxaaUXuDraASt5YFjA/iVbMreWzTlpP9FKtvM8A
         YBBwCOfaYKYq2xR8cQhkzbmemocSHzqz+Ff+6gqXg/gNaamf7l7JUqEOeIALomKa/APY
         9lVXQ/5FXTa980I8QYyyLhnvJCdz7bEFH3ZctLOsCNGItrFH9ZFU4m/esRaMjDHdAkru
         5ZheSr0SMypXNYzHsLiJH4OXSuRLrcD0dsn/vqbI7OSLqCElvNvrG3+I4V3xI1J5g3SG
         hjHLofwnl1GQx9JUKbKq2OSCQ2Vs/TwklPV1onuQY8irSFY3ulhJKl8fvV5wHgmvIfjc
         Eaqw==
X-Forwarded-Encrypted: i=1; AJvYcCW0CbDXxPeKi23OSNi6rwvOC0QUA9xItQXz7gpP+nOdpDkn64g16eo3gQpUT3hUyBirHI7lYqDGeFss5Bzqho8kUQ==@vger.kernel.org, AJvYcCWZ1UMth3IcuXSykdiWWWvyVPmTLbmNSq4GdNWeloF7chsFpfmvV8l43lNhhd8l2Uwub3Ys4naK0o5LVwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0x008jawjGjKtND1m/k7qsLyoHo5f4NEC5uTVtKPuh2IbIadT
	CV5Np/5Dg3EzQf6tPh+AdCGQ2YqBxjqTwALVc4G8NREb21SzTbSx
X-Google-Smtp-Source: AGHT+IGq42LbyfeKhm5l3kMgRH4KezRUf2lapAMDVAc86sftYZ+f18bQal2lOEtwuZdx3aUI7gP2Kw==
X-Received: by 2002:a17:902:cf12:b0:20c:528d:7063 with SMTP id d9443c01a7336-21183d4baa1mr270807775ad.19.1731457710719;
        Tue, 12 Nov 2024 16:28:30 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e458bdsm100158425ad.133.2024.11.12.16.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 16:28:30 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org,
	peterz@infradead.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mingo@redhat.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v8 06/10] perf evsel: Assemble offcpu samples
Date: Tue, 12 Nov 2024 16:28:14 -0800
Message-ID: <20241113002818.3578645-7-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241113002818.3578645-1-howardchu95@gmail.com>
References: <20241113002818.3578645-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the data in bpf-output samples, to assemble offcpu samples.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-7-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8d0308f62484..654fb5196ecf 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2792,6 +2792,35 @@ static inline bool evsel__has_branch_counters(const struct evsel *evsel)
 	return false;
 }
 
+static int __set_offcpu_sample(struct perf_sample *data)
+{
+	u64 *array = data->raw_data;
+	u32 max_size = data->raw_size, *p32;
+	const void *endp = (void *)array + max_size;
+
+	if (array == NULL)
+		return -EFAULT;
+
+	OVERFLOW_CHECK_u64(array);
+	p32 = (void *)array++;
+	data->pid = p32[0];
+	data->tid = p32[1];
+
+	OVERFLOW_CHECK_u64(array);
+	data->period = *array++;
+
+	OVERFLOW_CHECK_u64(array);
+	data->callchain = (struct ip_callchain *)array++;
+	OVERFLOW_CHECK(array, data->callchain->nr * sizeof(u64), max_size);
+	data->ip = data->callchain->ips[1];
+	array += data->callchain->nr;
+
+	OVERFLOW_CHECK_u64(array);
+	data->cgroup = *array;
+
+	return 0;
+}
+
 int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			struct perf_sample *data)
 {
@@ -3143,6 +3172,9 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array = (void *)array + sz;
 	}
 
+	if (evsel__is_offcpu_event(evsel))
+		return __set_offcpu_sample(data);
+
 	return 0;
 }
 
-- 
2.43.0

