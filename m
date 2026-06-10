Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2CD346784;
	Wed, 10 Jun 2026 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110391; cv=none; b=H4GCkCtYOCJgYNLRbeXyekKQNp2phb6+E7l2uHI+qdrYDvmBVzRZtnLktbvSV5JGm+B5/NKIqOwY+PvT8ujDuQ0YS/LN2JrLmA9AaQQjiOegYdtvogYMj9ynMb+CIYhs4Dn/K6YE0ACIb1iaTraSqvzLM+3W4w7RfvC1+pOh2xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110391; c=relaxed/simple;
	bh=4SguA8Ny2p++3uPgBM0X7q02tqLWqv9iRtYhwCJP6QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7vNH2BldyKb/EWHl4nwCVfk0qDmkxHWF9N7wqS9ZgAobx1FdTVuCrXWDj/SFZ58LbBW2xXC1CjI6t8von5k2NHfI1g1GyQ+wZNJSRRBpzee9ogUHZOYUvtZuajZAWK+aC9pKoj1DLKZG7ZWKUklHzP/KUQ1FbectP+eMS3KRJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nt87A4b7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nt87A4b7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D8A1F00893;
	Wed, 10 Jun 2026 16:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781110390;
	bh=ShhRyTxBectfJ6K9wTi0v17IdF7h8yiTR8h/Ofl/l0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nt87A4b77uR9Gezz7ObCqAhGOkJHd8CM/y0dSS1eD9vxOc+4F4upumZrQUAs59f3t
	 lG2QSgas6Lqhwpj9qWh1VfAUAa/Lh5J4RcPGXeRhUh3u5q+6O4xY5Oc+VzACUai9sC
	 JP6snDoC6bXV0QISuCzAOooQiDncU0qet/twSIuXTGOMFwwTkYzeyGww9blAC5QaXC
	 3cx4ljmkuOht1U6xQhC8kT7dBcBjYgrInEQnxx6cu3J2qhZ1XT/L20Jd464cE9sbZ/
	 WOhBvEG+GX66c/xB5X5jG11z5qz4TOlT8cyhOqIzrWyYY2KrVwT9W5RfdhGqR/2c5/
	 hNnRhewn9FIgw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 10/11] perf tools: Use scnprintf() in build_id__snprintf() and hwmon read_events()
Date: Wed, 10 Jun 2026 13:52:04 -0300
Message-ID: <20260610165207.2077258-11-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610165207.2077258-1-acme@kernel.org>
References: <20260610165207.2077258-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

build_id__snprintf() and hwmon_pmu__read_events() accumulate formatted
output via snprintf(), which returns the would-have-been-written count
on truncation.  In build_id__snprintf(), this inflates the return
value beyond the buffer size.  In hwmon_pmu__read_events(), len
overshoots out_buf_len and the next 'out_buf_len - len' underflows.

Switch both to scnprintf() which returns actual bytes written.

In build_id__snprintf(), also tighten the loop guard from
'offs < bf_size' to 'offs + 1 < bf_size': since scnprintf() returns
at most size-1, offs never reaches bf_size, and the original condition
would spin doing zero-byte writes once the buffer fills.

Fixes: fccaaf6fbbc59910 ("perf build-id: Change sprintf functions to snprintf")
Fixes: 53cc0b351ec99278 ("perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/build-id.c  |  7 +++++--
 tools/perf/util/hwmon_pmu.c | 12 ++++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 8c0a9ae932aa5798..eb95ab90f9741d5f 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -93,8 +93,11 @@ int build_id__snprintf(const struct build_id *build_id, char *bf, size_t bf_size
 		return 0;
 	}
 
-	for (size_t i = 0; i < build_id->size && offs < bf_size; ++i)
-		offs += snprintf(bf + offs, bf_size - offs, "%02x", build_id->data[i]);
+	if (bf_size > 0)
+		bf[0] = '\0';
+
+	for (size_t i = 0; i < build_id->size && offs + 1 < bf_size; ++i)
+		offs += scnprintf(bf + offs, bf_size - offs, "%02x", build_id->data[i]);
 
 	return offs;
 }
diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index fb3ffa8d32ad2a93..dbf6a71af47f9a42 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -442,12 +442,12 @@ static size_t hwmon_pmu__describe_items(struct hwmon_pmu *hwm, char *out_buf, si
 
 				buf[read_len] = '\0';
 				val = strtoll(buf, /*endptr=*/NULL, 10);
-				len += snprintf(out_buf + len, out_buf_len - len, "%s%s%s=%g%s",
-						len == 0 ? " " : ", ",
-						hwmon_item_strs[bit],
-						is_alarm ? "_alarm" : "",
-						(double)val / 1000.0,
-						hwmon_units[key.type]);
+				len += scnprintf(out_buf + len, out_buf_len - len, "%s%s%s=%g%s",
+						 len == 0 ? " " : ", ",
+						 hwmon_item_strs[bit],
+						 is_alarm ? "_alarm" : "",
+						 (double)val / 1000.0,
+						 hwmon_units[key.type]);
 			}
 			close(fd);
 		}
-- 
2.54.0

