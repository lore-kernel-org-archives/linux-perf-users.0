Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B402132AAD6;
	Sun,  7 Jun 2026 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780875040; cv=none; b=ToT7PoyWXXAAUEn/DuPE3q5amdSD9EfcRZ+C2YqYwkPqHuRnXbVLrCFSgcMMNDebm9PjsYbVj98pIQlgx3t97ZZjGWDwm/GM9yQQBdHXVwsWH5W2/qvEMijehGFwFIwBedaWtmSe4flvWkzAl9SSYz4ZLShhKKgyopiCWg/n9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780875040; c=relaxed/simple;
	bh=pztbD3iX3pd/KugXnN4XjAccZtUYB6eLIx5zr1pj1X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZ6z57JjGWbVpCRuZsIxiz58yKbx/Km7R7OAJxWgEZwf8icf78dTuzSaJPh9LpUJBl0DMNRFqOmzXLVywH5IP2KbBcVQh6YfVkQp03oZB+syANZQMlhx62LzWtt0aPWG9ytvl/nRoI8IW/kybfrum95QiWv79FvNju17V+mXGqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ou75w9xr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ou75w9xr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F581F00898;
	Sun,  7 Jun 2026 23:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780875038;
	bh=vJrjz18WP9YOQVzzuYUbzW7bbrjWzAs6Y8JS41ckrzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ou75w9xrcRaZu+vfcHblcxVDahUDpQA+kd+rXQKly8h0uJjzb+8AKSN5xC7agqouY
	 QxMFd+HGiN4g7eaoE0MtedHuUERhfFOw34QcqCnLdO70WnycjjfJdPf+GOkSAEmbEm
	 tUUHdUklFF83jLejCFPusLamsu2UVwNnQZWkgSjNb4RchppLatIG0ldChu2D7hZ6Ca
	 oaTwammCJPVjp7e8+tOMkoSZ7zHLsqChdzk/KQqsHwjMozYRSLYVYnQ/aX5w/6+ET/
	 mmIoR2+ZCWBz/9BFyAs0isa/66KgL1Tih5gGRa2M8d6BFXlbOHAkfla7uSM9armHjY
	 hkEt7/DJHb5Qg==
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
Subject: [PATCH 11/11] perf tools: Use scnprintf() in build_id__snprintf() and hwmon read_events()
Date: Sun,  7 Jun 2026 20:29:24 -0300
Message-ID: <20260607232925.1935819-12-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607232925.1935819-1-acme@kernel.org>
References: <20260607232925.1935819-1-acme@kernel.org>
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

Fixes: fccaaf6fbbc59910 ("perf build-id: Change sprintf functions to snprintf")
Fixes: 53cc0b351ec99278 ("perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/build-id.c  |  2 +-
 tools/perf/util/hwmon_pmu.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 8c0a9ae932aa5798..a3b92108f96263c6 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -94,7 +94,7 @@ int build_id__snprintf(const struct build_id *build_id, char *bf, size_t bf_size
 	}
 
 	for (size_t i = 0; i < build_id->size && offs < bf_size; ++i)
-		offs += snprintf(bf + offs, bf_size - offs, "%02x", build_id->data[i]);
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

