Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA6317C21C;
	Wed,  5 Mar 2025 02:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141943; cv=none; b=UlAmhOekuLBAZ3rxrgmTgZR2c+5QYvu7K/3YYENyE56z6Nh5vknsyPdEtgEROTuUziZPGQ8VeNIQCBPcYFiwJ5ItphXEL0AFIiAlhnYm+Al4TN8PlvBUufyr669qcZQK7GXgOnWwwIuB02ihlH7EwYpP7ABL+InDH02H0l7AlNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141943; c=relaxed/simple;
	bh=gtY9+UCrKfBAYr3VbGghd4UuT5UYq3r4nfVQ+LcpLg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnUpQGyAnE0ZdIJg+OiJJTwJ+EJKDx2Pnh0gHzuQvq/IF0gulTaGs3kOv4ha2ZLdPBQPxf0aXXohHG61BD2b+Mpm/mgjLeXw5Z14+in4OpqWdwo74ScNPq3NSPjhoHeNHybB3UdUeOoUbpwV4GT3cmWr/Z3gzegHa9XkU65has8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=LlkwqTaV; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="LlkwqTaV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=XrjNBrn8ne791SZzERKUz4fcgRlN8A9ah5iqdRUk17Y=; b=LlkwqTaVMANh09bY
	tSioio6jmnt49G9pGnoJHNA0MlSxvXDKqlt8IQMJXz9Z4kuw0flxk9CiTKGrCQ7tiOwQvKNLhkUA2
	t7CT4kpAYQrY+goVI+8AEoJ32+gf9jM0iOnDAg75Xyq8+LM5V3KDq5ihG/63OR11Pvqemm6tgAVos
	Esu8ku3J5tz6SilYkKnr+fvLpEeOstyD9haWiPNlUpCo064J7ewjpZAtwntPn1LUAuYeXbfpFGs8W
	cP5ADL+72ib+AobPj2Utmt6TY6F+N+3WJu4WYlw3ubJVAKIsLiUFsIc1vy+VkyDq+itW2Q8VHUIhz
	LLvkQ/Niaf01PKJxCg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tpeXl-002ic7-0t;
	Wed, 05 Mar 2025 02:31:33 +0000
From: linux@treblig.org
To: irogers@google.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	namhyung@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 5/6] perf util: Remove unused perf_pmus__default_pmu_name
Date: Wed,  5 Mar 2025 02:31:19 +0000
Message-ID: <20250305023120.155420-6-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305023120.155420-1-linux@treblig.org>
References: <20250305023120.155420-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

perf_pmus__default_pmu_name() last use was removed by 2023's
commit e3edd6cf6399 ("perf pmu-events: Reduce processed events by passing
PMU")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 tools/perf/util/pmus.c | 29 -----------------------------
 tools/perf/util/pmus.h |  1 -
 2 files changed, 30 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index dd7c2ffdab38..9b5a63ecb249 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -714,35 +714,6 @@ bool perf_pmus__supports_extended_type(void)
 	return perf_pmus__do_support_extended_type;
 }
 
-char *perf_pmus__default_pmu_name(void)
-{
-	int fd;
-	struct io_dir dir;
-	struct io_dirent64 *dent;
-	char *result = NULL;
-
-	if (!list_empty(&core_pmus))
-		return strdup(list_first_entry(&core_pmus, struct perf_pmu, list)->name);
-
-	fd = perf_pmu__event_source_devices_fd();
-	if (fd < 0)
-		return strdup("cpu");
-
-	io_dir__init(&dir, fd);
-
-	while ((dent = io_dir__readdir(&dir)) != NULL) {
-		if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
-			continue;
-		if (is_pmu_core(dent->d_name)) {
-			result = strdup(dent->d_name);
-			break;
-		}
-	}
-
-	close(fd);
-	return result ?: strdup("cpu");
-}
-
 struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 {
 	struct perf_pmu *pmu = evsel->pmu;
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index a0cb0eb2ff97..8def20e615ad 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -27,7 +27,6 @@ void perf_pmus__print_raw_pmu_events(const struct print_callbacks *print_cb, voi
 bool perf_pmus__have_event(const char *pname, const char *name);
 int perf_pmus__num_core_pmus(void);
 bool perf_pmus__supports_extended_type(void);
-char *perf_pmus__default_pmu_name(void);
 
 struct perf_pmu *perf_pmus__add_test_pmu(int test_sysfs_dirfd, const char *name);
 struct perf_pmu *perf_pmus__add_test_hwmon_pmu(int hwmon_dir,
-- 
2.48.1

