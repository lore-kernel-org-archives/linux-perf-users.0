Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5A026FA6A;
	Thu, 13 Feb 2025 23:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487625; cv=none; b=CjXdViQC3oc1lheocqH/zakpDvOrJFiRPwxe72GWUgyUMiuDLrcVe46izHCNZpO4EUqQp0B95wixYTWV5wVA8XUks+o+UnAh5KzVAQlWfA8Fk/DDrTRhkn2XZ6F5tDxxZnzMeZ2rBNqE9Uj3unB36TlwCZ4pId6zn1lqX6uWnE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487625; c=relaxed/simple;
	bh=Pqez/aGnMBPJahMHse06GPvbqP7rG0cCe15F1SQqc0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEgAIzGyc9605wJOTH9yLN/o6Ac4qxiDOrwUmkKTnoNUoVDATV6SrHfsXfo/vNeUmDz4wy5qOk7WUjVpqporPV5IU+UlJgB0CDR9dLNXNNRZen/9ESsjgw3gRWfTO63rWjxtKqfzFOhx7yS30NWbiclHa7QjFXmloYGstLcMxKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcDBNVg+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcDBNVg+"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fa1fb3c445so2148532a91.2;
        Thu, 13 Feb 2025 15:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739487622; x=1740092422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrDkT78AbLp193RSVHymTnt8PVvEiWM3gXo16d10Ee8=;
        b=NcDBNVg+GfwxOmVPnC6oLo5x/etqWs6gSf981lAl3Z4XdA8ntvyviVpsRdsLfYUctY
         JkXuoM1Jqn7kKnGm+Epbu7UCUGChULjLdhp8mEQnl4aRxB/8L84t8jnUns6/Jgl5HTeE
         QhhTzJtuyQL6XdA5xOq2W0ZbCfkgTAFddAbJ5T1Zuac/TxWzxVqALdEOOgEAJXryd3uN
         sePv3QGu3S8MBoAw4QqJ+OBHzAHaYcMIaFeZYiABjuqB3TM7L/PU2iPEbKddIjHSfzxa
         IjmZOYpR4cWyzemRSYBjcubVTU0CeTvHnROxDbiju6WiBNKzXmpoGYA/pPvQUppRUwj6
         sTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487622; x=1740092422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrDkT78AbLp193RSVHymTnt8PVvEiWM3gXo16d10Ee8=;
        b=t+rAzntDMez9dR2L/Mhkjt57a6dSuczUYJz+EsgurNxFcaaf4oxaPO4igsBVdxUsQO
         cOjXot0ZDUR3ZPqJX5WgpYC9rKmMrocgh8SpufjrSg0lf6T/yMjxsjifqzA5Mougv9Q4
         NORP1AH2QDdBfjEN7xp0duxJ5J49ndsR3ZzH8oZ04deax5g3qlXQnJwm1I+hTbBzhI+F
         xz1v1uDRwvlpaMyhttaAJsHJCFsDPkJY8am2i3vaqzM6NApFk5kLmV87gLf0FkoPh03/
         S1pD7QTgGZkyvO6IPbFpYcxstyM/bSZt5Yb6AMj73nrLiSn+UbnFt9tbKQtfFdn5xHwm
         Lsag==
X-Forwarded-Encrypted: i=1; AJvYcCVBO2mLiDTnNUHMjBFy5l0UDAQ16uNHZYos96AUwPTq+M0OWDfaf7LThTIYJXmfyAR8DBLFUYLzd+jYqyE=@vger.kernel.org, AJvYcCVPU/ki0r2L8QH7+Amy/mGRzOquUiGdTwrF+1wVHpd1tQ/whwUZ2KCfntj/bGODejvLbx5DGXZTbn53M7otJwfjew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGVbNOk5STEynEBjNtj6KCxN+8GHJsh3pREpoXX2NJ3MhWOUzX
	WY3suXYTlZmrbhwJLpkOvPziFQHvy9/eVyqtG6nMzmAr/JyWJHiK
X-Gm-Gg: ASbGncvxmV6T7OYJ6Aut2GpNWaHQC+hQYRI2CcoMaJu2DA8U06Swbn3bUTm/U31VGoO
	QzlfyqPtSRF28aO7+8n8fH/gD/LcZXjvX4ldecr72fVA8BB04a0SH+2sR7YqbarXTEBQ8Mfd3D/
	5LqfK46K+0LYlfY8dOEwXoIhp+hFZ8njdEPvCHjcj8WEYNlDW+oSZzPczI6uMzUPm6YldjT8EyX
	PlvQj35/RcF37ZMwiwemTxZ2OGWbGOzjuCXsjpsVTHoqt7KoBYWNXWJ/TSAdOY3rda/0EjZBdMZ
	ZpsIW6rc7nxgFEOApaQY5wbtaqZVXkdrM0JY1PX2TxQVZyk=
X-Google-Smtp-Source: AGHT+IGVG4jPUE2Vy3GKr7ThKUQyZply+qxvizrvUmFRuNzLEG7JPuoxpuF3oziSYxBhOn3eRPUBwg==
X-Received: by 2002:a17:90b:4a10:b0:2ee:b66d:6576 with SMTP id 98e67ed59e1d1-2fbf9134584mr11216916a91.30.1739487621585;
        Thu, 13 Feb 2025 15:00:21 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349210sm17641735ad.11.2025.02.13.15.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 15:00:21 -0800 (PST)
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
Subject: [PATCH v15 06/10] perf record --off-cpu: Disable perf_event's callchain collection
Date: Thu, 13 Feb 2025 15:00:05 -0800
Message-ID: <20250213230009.1450907-7-howardchu95@gmail.com>
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
2.45.2

