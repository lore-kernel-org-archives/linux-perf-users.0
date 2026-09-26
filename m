Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257DB39C637
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790449502; cv=none; b=p2vwblWyB2Vp7LDU3/mF3pbKaxg9OaXUUbrR4IfcBWYU5vbeO2mDYBuVLjCZDhswHAedV+hNOhC5YdwhkhtH6lf7yVRGKNl1IWkl4oA5zEkVWiA/vBTIyT4so5Yi+LfAvKBcBTMxo2hQrhh4LJWC+LO4v9FxyvpbahDl0ACQ+jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790449502; c=relaxed/simple;
	bh=5efpR+DiNzg66dM4qSO5vb38UBEV8l7bHBV08xctCYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmjccZs2ub6uZl61n6MZMKpYd9AzuVO4RJCT0i3fWj9t064OkYysmAs7Zrm45cX5ckeWx5LjxQ4Q+ujESjSBIZ+Wm9OICTNACxzlgvnOjow3DnlYDKtl3A3U2tFweR6NQEiOXbrM//HXZNqnCFa0OPqCv5NpDPsDQLuiFIS9k2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ppTOzT/S; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppTOzT/S"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887f6cf16bso1045843f8f.0
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 12:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790449498; x=1791054298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TVcPhX9Ogu0tKMjXQYOW4Gg0BvTVbjbny677ydMNzu8=;
        b=ppTOzT/SbhgIMj4VXPebUsrORQsmQZMDWyP4RZTg7OcGwuCqf8pkipZGYDUf2BTHh8
         GRp18nmx+KJghkSArdeYW2TiCjzjyYvy0ZB/aL7TzuAhr2MBq53HryAXyKFUP26niUML
         vtmnJprVb7CI2Z+9sZVPXA1rE2u4AVnaXvLpI/fmPZHyAfwd2Ig+idsdczw/2kaZiVGT
         cvmE6aUV/1TUrqYoPL1sr4CvRwA8abg6+jV1Ef2sPBHDwU78a+YAtWXBvMHboRTaEVCW
         /3o6oSmIw6axJs0pDQzXEShz6waR/txrIj9NOi7/WaODtaphk1oX4AIj5eal1vFbkuPJ
         UH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790449498; x=1791054298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TVcPhX9Ogu0tKMjXQYOW4Gg0BvTVbjbny677ydMNzu8=;
        b=fGGHCl8cIBR6+w5km8zDZ6FwnT5UCSkRtyXc5AiZN6mKjq+R0MMxECmCWDTYBWIN0s
         PEKRmCdzcIz4r+qiiTIvzbfR+EZ2CCouomvAfaySfmvXzTr+1Xg25TNeD6XW+fqpgoXY
         QtOA8naQEa71q/EYkJam6PeZ/PgbSbHfcvZQ5MiTzxyxgQQaKhg7WeyZc6C3nuTCCd8B
         RhiMZ19y84IfEbb46fGbeWW2AZrUDgB9Nh1KsZ2Lr9yiei5IrlNrVr5xOdT+j/yNXd7U
         aj7XclN9FinZ7zHcG8IyWSF2uUtBr/qOyEo/dcc8nQFdrZFL3fGRkfRGJvni3zIj3aZN
         XZWg==
X-Forwarded-Encrypted: i=1; AKwUvBwTt0dWqIbyw0+6I1kmlSr8kkXwuxHDftKXWOy5dMtP9XSj+wl5SR6EmKBTt7BmtIg9toXvbCelTDGUvVZcYFDk@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7cwox87X5gVZrCKRXds1xBoPaTM5nuDiiETmZcABN4v/Y2Dth
	GZONx5DlEsVL8RmVdlue4HPsrmQrxKg58AYCPHtMnKDt4EE/fxt1stgg
X-Gm-Gg: AYBFou0McgLBqNyH81KibXF9S/SsFSQ8UHrOf3kYonynMe9NEfotmogjdPmH81lwecd
	oJgUwhQ6UEg+sJA7jPx7E4Tm61WQlG8D3HKbSQ8JxLW9ISqg2Re/ylbZZRkr303ZjFrOHcn4o6h
	P/1mK3ZMVEiyMsUGe1xtnek1T4+Ltpj5a9UJWExwNTqZeov0Snn9K+65F8RSyZi5143yCtcmpln
	3ECv19Kpkn4nDpNhzclgTjWVVq73RtST+2ZsiCjCAsMqEFXEurfDV8Wgwchi85tR3NICmFEdMpN
	79KBi8wdLHdA35zgHAnqlxMwBKoQZzH9N/Ivi7XjiFVu0WTwKOd7dAN8h9IZBF/zU+42IGQVrOU
	o0Y7+W0GmO85hbKPfKgqtxWpMJIcuAbItxMOjz3oq1L8sP/WtlCrXO62OCU+IU4KE/flQrBr56G
	KDIcNrhedBSD5VS5nQFsZXccqTsihpdcpOlVnHwygTv0LMEueiCDB+0qXFh2uyw2VZ+6y3hBGcu
	GS3Jodelk6ZRMnUvRQXtps1c1Tde9wrhHxJgdT3xuIMKjW5D/n2YVRVsY6ahVNI/Pjk12ziae79
	rwWEQRQPI9Icn2jnhI1kJ2YqmY5mAAsTxzrChiovW+7x1Wfi5rs=
X-Received: by 2002:a5d:5f81:0:b0:486:fcfd:45d4 with SMTP id ffacd0b85a97d-4887da07064mr11018629f8f.17.1790449498535;
        Sat, 26 Sep 2026 12:04:58 -0700 (PDT)
Received: from mikebook.tail5724d6.ts.net (83-244-142-114.cust-83.exponential-e.net. [83.244.142.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm15216880f8f.9.2026.09.26.12.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 12:04:58 -0700 (PDT)
From: Michal Pluta <michalpl2003@gmail.com>
To: acme@kernel.org,
	namhyung@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 8/8] perf bench futex: Fix wording in futex bench messages
Date: Sat, 26 Sep 2026 20:04:07 +0100
Message-ID: <20260926190407.1106421-9-michalpl2003@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926190407.1106421-1-michalpl2003@gmail.com>
References: <20260926190407.1106421-1-michalpl2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the kernel is using a different number of hash buckets than
requested with -b, the message printed is ungrammatical, and it ends
with a stale errno even though nothing failed:

  Requested number of hash buckets does not currently used.
  Requested: 3 in usage: 64
  perf: prctl(PR_FUTEX_HASH): No such file or directory

Fix the wording and use errx(), so that no errno text is printed:

  Requested number of buckets differs from the number in use.
  Requested: 3, in use: 64
  perf: prctl(PR_FUTEX_HASH)

Also fix "Wokeup" in the 'futex wake' output, which should be "Woke up".

Fixes: 60035a3981a7 ("tools/perf: Allow to select the number of hash buckets")
Assisted-by: LLM
Signed-off-by: Michal Pluta <michalpl2003@gmail.com>
---
 tools/perf/bench/futex-wake.c | 4 ++--
 tools/perf/bench/futex.c      | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 7674622639ca..2cbf31e121d5 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -89,7 +89,7 @@ static void print_summary(void)
 	double waketime_stddev = stddev_stats(&waketime_stats);
 	unsigned int wakeup_avg = avg_stats(&wakeup_stats);
 
-	printf("Wokeup %d of %d threads in %.4f ms (+-%.2f%%)\n",
+	printf("Woke up %d of %d threads in %.4f ms (+-%.2f%%)\n",
 	       wakeup_avg,
 	       params.nthreads,
 	       waketime_avg / USEC_PER_MSEC,
@@ -223,7 +223,7 @@ int bench_futex_wake(int argc, const char **argv)
 		update_stats(&waketime_stats, runtime_us);
 
 		if (!params.silent) {
-			printf("[Run %d]: Wokeup %d of %d threads in %.4f ms\n",
+			printf("[Run %d]: Woke up %d of %d threads in %.4f ms\n",
 			       j + 1, nwoken, params.nthreads,
 			       runtime_us / (double)USEC_PER_MSEC);
 		}
diff --git a/tools/perf/bench/futex.c b/tools/perf/bench/futex.c
index 5757d47f8f7c..be0cbc03682c 100644
--- a/tools/perf/bench/futex.c
+++ b/tools/perf/bench/futex.c
@@ -43,9 +43,9 @@ void futex_print_nbuckets(struct bench_futex_parameters *params)
 				printf("Can't query number of buckets: %m\n");
 				err(EXIT_FAILURE, "prctl(PR_FUTEX_HASH)");
 			}
-			printf("Requested number of hash buckets does not currently used.\n");
-			printf("Requested: %d in usage: %d\n", params->nbuckets, ret);
-			err(EXIT_FAILURE, "prctl(PR_FUTEX_HASH)");
+			printf("Requested number of buckets differs from the number in use.\n");
+			printf("Requested: %d, in use: %d\n", params->nbuckets, ret);
+			errx(EXIT_FAILURE, "prctl(PR_FUTEX_HASH)");
 		}
 		if (params->nbuckets == 0)
 			ret = asprintf(&futex_hash_mode, "Futex hashing: global hash");
-- 
2.43.0

