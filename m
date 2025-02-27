Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8DB1FECC3
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 05:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740634742; cv=none; b=AEPvwPazKZ2GyYmqWBA4CXGk13rvKw7zXHniWoUJWVC1Svo4TH2K77pf5KywcrmuO4nKim5pWaBfRU82GFmHEYg/QtK8Cf+tjwXNT9x16Nj/rpeVYcAfb6DZ4OfdEgV+hzCF2a8LUDgbSEHLyudsCLG5NifxuC8E4HHmKD3SIf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740634742; c=relaxed/simple;
	bh=DEuvCIslRxxKZ/FKUxXpjIuiKOQKihAOFte4f/C4jNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MxnLvgTbbPPFxNHpPvbEjCGzxoJFpQATREd4z4Fw/6mmnfz515qZG/bvv/DnNeHa8lIlNvziKo5RI/5zPu84bw8JktrvgWB9bwWgnmFVSTM9oSOjucrZgSRJ/qfS0CS+BTFTxghKhDFikIYv59ymA8DxBlHAAJkP1Y8cKvSOTx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4P5Iaiy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4P5Iaiy"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1c7c8396so1415332a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 21:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740634740; x=1741239540; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pghRppAKQix00kejEXNfKBFBvnS4forjjInAnQO9KcI=;
        b=d4P5IaiyfnUKm7dlOoqOr8LgEyFzYd5Wi6VZUM3T/Stt0+0c3VODsZEwe9DUUZz83O
         WZjyCsbY3cA4cn/BcUapB14t2Q9gLQMtZ5LpdVLBG1v/z/Ark+WEmjX0WgE1xESmz13M
         2qs+/vpKoYLY6dSj9tmL5se6HCQyQ3ew1i2UXAPZdqvyDNw+0R+tU+P5XEW7nBR0f4AY
         ip7ZPWpVnR661dXgdQpqXGTW95h8kESDzhRfxJCOrhIUenaXNztTz7Wu+TQwqX/bWGxP
         KL8BsLHRi5svNWoDnQrMfGfWbAqbyY1b7dlhAIYcXcGhk1OJrUR5TVqpYE2dC9jXzB4w
         3SQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740634740; x=1741239540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pghRppAKQix00kejEXNfKBFBvnS4forjjInAnQO9KcI=;
        b=VIjac9NTGYU0kEJ1vnM9DcxzRS8pKtAU6QY+DFAnmvYeKDGm7uKt9KTFl/Qu7bkl3O
         x7fbZOg5Bc3DjcIXnq1d8UA+5Db03qJI3FMPQ4wJyfNlvhMryk4HdeNwXqdJbPJ3tQNd
         +qRCa5P10gtNOfD3FZ8iJRUQvhdDMd/JZfz+RthAZamq/sS5Wq7+Dn7jARZ8NRYilG3u
         xu3KtYFSDlePpg1zzJxjGO7vtryMejMtoe3Pejw3vLJcyA1TgXh9MG4BWX3E/W16fZHU
         cQOnxvpjqfkMTXQmYKiue7PliR4s0Ydv1Kt1bq+C1ztQ24TlH65RyK3EenDm/iStvP42
         Htng==
X-Forwarded-Encrypted: i=1; AJvYcCXUm68RWT+JNnJ4lGtaJ5kspaIsv2jm+NkDn50hSqdQzWYZDFMMkn/Khg6a9r/f8IUXmiMV80MeUTvhm8KLhE5k@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl7xU2icej4sl+FsKkkwty8PY86qu1aYp8zekSo9KLSliAQ7/k
	5yzkQmev1oqBe0Vf0jKRB3Ek2Tffjag2agqnx/WQqUpQrYF2sAJ49bEAXue0nUU7wzcCA5TSsn8
	95A==
X-Google-Smtp-Source: AGHT+IGDNLiy4TmeTGBNX6d6KMAvnzJaCLBPWpNTSqo5m1Hz1oPdH0VFfPvKZiXe8OoS4KZFmsQmJatgscQ=
X-Received: from pjuw3.prod.google.com ([2002:a17:90a:d603:b0:2fc:2b27:9d35])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:100f:b0:2fe:8c08:88c6
 with SMTP id 98e67ed59e1d1-2fe8c088e3amr6768145a91.7.1740634739885; Wed, 26
 Feb 2025 21:38:59 -0800 (PST)
Date: Wed, 26 Feb 2025 21:34:07 -0800
In-Reply-To: <20250227053738.788153-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227053738.788153-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227053738.788153-2-ctshao@google.com>
Subject: [PATCH v1 2/2] perf record: Fix a asan runtime error in util/maps.c
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, terrelln@fb.com, 
	leo.yan@arm.com, dvyukov@google.com, ak@linux.intel.com, 
	james.clark@linaro.org, christophe.leroy@csgroup.eu, ben.gainey@arm.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If I build perf with asan and run Zstd test:

  $ make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame-pointer -fsanitize=undefined"
  $ /tmp/perf/perf test "Zstd perf.data compression/decompression" -vv
   83: Zstd perf.data compression/decompression:
  ...
  util/maps.c:1046:5: runtime error: null pointer passed as argument 2, which is declared to never be null
  ...

The issue was caused by `bsearch`. The patch adds a check to ensure
argument 2 and 3 are not NULL and 0.

Testing with the commands above confirms that the runtime error is
resolved.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/util/maps.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 09c9cc326c08..41a99e1f4b50 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -1042,10 +1042,13 @@ struct map *maps__find(struct maps *maps, u64 ip)
 	while (!done) {
 		down_read(maps__lock(maps));
 		if (maps__maps_by_address_sorted(maps)) {
-			struct map **mapp =
-				bsearch(&ip, maps__maps_by_address(maps), maps__nr_maps(maps),
-					sizeof(*mapp), map__addr_cmp);
+			struct map **mapp = NULL;
+			struct map **maps_by_address = maps__maps_by_address(maps);
+			unsigned int nr_maps = maps__nr_maps(maps);
 
+			if (maps_by_address && nr_maps)
+				mapp = bsearch(&ip, maps_by_address, nr_maps, sizeof(*mapp),
+					       map__addr_cmp);
 			if (mapp)
 				result = map__get(*mapp);
 			done = true;
-- 
2.48.1.658.g4767266eb4-goog

