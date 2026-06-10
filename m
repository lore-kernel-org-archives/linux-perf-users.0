Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7EF375F9E;
	Wed, 10 Jun 2026 19:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121173; cv=none; b=baDKluGa4vtXSiLL1O52QVhJ8FWumL+vjQ3lQUIwEADa3Z5DLNlotbtl6Sg9wWVkIZIqd+4ELl+N8lq2pCxl02FfzzMeWTrAyqzo70vjnEM2nJJwfXT2iEVwpybUE+tp8mhuzr0eNXFx0Idq/fq+IDhYUlOEdVingp12LYPC0cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121173; c=relaxed/simple;
	bh=IU+ezwazzSXKiMX4W7YZJvFUX44hgOpFhQlwM61NsW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gw6s2c359bAj+bcaSgxpxGAou1tsq6SV8gGQYFPaBzzeSARYERWTq6ofZSxWp+wjeja96t84zhpKHu3lp1zuQJnMN+LRQNGjAkUKwILDsYg6vf6hNoigzPw2RLmonM7TSIGPkabiJLXy/PLY4Qp87A6hgGYn/IasTXYSAM9H0k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsKPg7FC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsKPg7FC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4401F00898;
	Wed, 10 Jun 2026 19:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121171;
	bh=1k2laDadMfW77x6Kr2jVszozrwycuXOW10MwBasYa9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HsKPg7FCAI5z5pxiTgb5eo9z/BVSs7eXKjQkLxqRBN0ys+j1THinqk5AzGdlQhpTp
	 f8H8aZNpHHJaFQbgMU5YiUe5RWZfBMVlcxhHmLS79UhPg62y3DrBaeAb8NZlRAYNxh
	 813gS0SvLKtPBplh0/526wEZD0ld+6VBEAlTvb9OXuXmuG6CS2oAcufHZ74gj8BRiO
	 y9vv6rCDi0W1ndqe0PRQFvtKdr1CzwAbLNVQ8XVKaZFD10JNifvnELiToT4g8ZDt0u
	 GckjgZwyJENyjqhZlunYMUP4BHWv5HjT1r/AzyjTVe8ZhcX2IxTIBYq3tqH+MEiry5
	 iHXAq9k5ASB0g==
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
Subject: [PATCH 09/23] perf hwmon: Fix off-by-one null termination on sysfs reads
Date: Wed, 10 Jun 2026 16:51:42 -0300
Message-ID: <20260610195157.2091137-10-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610195157.2091137-1-acme@kernel.org>
References: <20260610195157.2091137-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Three functions read sysfs files into fixed-size stack buffers using
the full buffer size, then null-terminate at buf[read_len].  If the
read fills the buffer exactly, read_len equals sizeof(buf) and the
null byte writes one past the array, corrupting an adjacent stack
variable.

Fix all three by reading sizeof(buf) - 1 bytes, reserving space for
the null terminator:

  - hwmon_pmu__read_events(): buf[128]
  - hwmon_pmu__describe_items(): buf[64]
  - evsel__hwmon_pmu_read(): buf[32]

Fixes: 53cc0b351ec99278 ("perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hwmon_pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index dbf6a71af47f9a42..d895cd74f2a05f9d 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -289,7 +289,7 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 			if (fd < 0)
 				continue;
 
-			read_len = read(fd, buf, sizeof(buf));
+			read_len = read(fd, buf, sizeof(buf) - 1);
 
 			while (read_len > 0 && buf[read_len - 1] == '\n')
 				read_len--;
@@ -432,7 +432,7 @@ static size_t hwmon_pmu__describe_items(struct hwmon_pmu *hwm, char *out_buf, si
 			is_alarm ? "_alarm" : "");
 		fd = openat(dir, buf, O_RDONLY);
 		if (fd > 0) {
-			ssize_t read_len = read(fd, buf, sizeof(buf));
+			ssize_t read_len = read(fd, buf, sizeof(buf) - 1);
 
 			while (read_len > 0 && buf[read_len - 1] == '\n')
 				read_len--;
@@ -816,7 +816,7 @@ int evsel__hwmon_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 
 	count = perf_counts(evsel->counts, cpu_map_idx, thread);
 	fd = FD(evsel, cpu_map_idx, thread);
-	len = pread(fd, buf, sizeof(buf), 0);
+	len = pread(fd, buf, sizeof(buf) - 1, 0);
 	if (len <= 0) {
 		count->lost++;
 		return -EINVAL;
-- 
2.54.0

