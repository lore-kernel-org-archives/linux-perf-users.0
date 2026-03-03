Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5C73264FA
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Mar 2026 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563945; cv=none; b=u4teRoA50ovCuIPVZy+kCd2THLBswwYXFsLBtpR2Afr/o5f0DItxbmjDhGcJCFeyntMIgAwWZKZNCON6jM7iQeg9n9LAItqGnmZz8JK5gcIYL6ztt47ur6Asfa81OqIhQuy2fRsw6Ynwc6Rcw6WAETPMcXRA6ZrCWpj7TlLLXNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563945; c=relaxed/simple;
	bh=jujyNQhe35vEW8DfQ6ZvNvgsRBTq8IEp0gNEu52yk1o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=es5UFsHVclk2ExfY/Nu37+5FYxKvoMQLiYtV0J9LUdEu+muBGtLPg2UrpJ7hItJhUdISU237lplQBNzFO+cRIwrPY6pisllr9XTTB1fIHhI6z5B0wmgnEot+3RnzxvEUamuWHH52rbuloJrJQ7HkJSJrnk6e58LkSvlJyx97t0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YkUdtxPY; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YkUdtxPY"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1273886efc6so5830238c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2026 10:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772563941; x=1773168741; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lb2WNe2kvehO4G5MCS1us7ljbs0iGwZqyjdd2kiT00Y=;
        b=YkUdtxPY2gIpXwaaRZkDqqPSJX5CIcVr733ItjwzjsHCZ9EHmdiwbnH+jlU4Zye0Fl
         dRPf+TJlTZh2KQ+a0W6v00d4mN+dwvSdzmlQH/bHuVlYi1wL1Lc6y+M8adsbnerJHTaz
         6Y1wKvYLDrGV3DA6UcS6qaso2FkDnklXF/fdOiCajrk6wjBVfojp4XteUrMYmzERQVou
         fC9PO4UnCBEdqf6i2ipBW+ZiQ+R20sHloapkHE6GpOR/XnNs/eK/7zZj/K/zR0kLWhfj
         M2TBLfvtos1nSk1Gn3vpXTdfY+OojwLO9VC2OmLWdoAMOa1kdD1/yHbHoiYtFvKzlRko
         zT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772563941; x=1773168741;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lb2WNe2kvehO4G5MCS1us7ljbs0iGwZqyjdd2kiT00Y=;
        b=BLJDjmPLVg7Bv8UgnJILg2NotnJWqtmsf+Usra4lJoTfzObxoR/NYio6dp4kw6UNV+
         jBbTsaKsmQktRQ5O3fN9LNQwKjY2vIBUYRANQJ5ND7D8OULoa7vSasff6Hdu5rxnG18j
         BagptLM+p+q6iTo+HQCJ8OI3BX5bOgVg7VZyN5LOq8Q7ZL1IXwqD/9iOoTwYaoaO01Yh
         C/wWUITGmbUsN1EPupG0EnGsNbag1uCeHEid0xYtdi4HJu8n1Sr4Db126Degtd8rzPIp
         YsGAgLOOAOf8hzZxswD+zHSby2DkpYQl5BFQmDccFdJTpGNRWZezQcYi7DlT1UCCIsb5
         vRuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXynYCaSFjDvU6dfRdGmdFv/2hLAVQzXqyQLPbpgXBt0yeUXbPZnpyeuw/52gQq/kXsim3A8tTCGwKfW+k1J1M2@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh7VLV7NME84IW9qzCfXeXHVkK9TDld/YK6vSdxMLt5X0BSMuI
	Eu/DraaMJ2y0B4uhRHh4PTwBifWVCFD4uWQ1sIH7EOR0aaqpIMZXoig0rGrIyd4utLa8z+K6db4
	x8TzXOBj/Pw==
X-Received: from dlbcq13.prod.google.com ([2002:a05:7022:248d:b0:127:337f:890])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:a81:b0:123:3584:de4b
 with SMTP id a92af1059eb24-1278fc1f998mr6900450c88.29.1772563940902; Tue, 03
 Mar 2026 10:52:20 -0800 (PST)
Date: Tue,  3 Mar 2026 10:52:16 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303185216.897944-1-irogers@google.com>
Subject: [PATCH v1] perf pmu: Replace starts_with with strstarts
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	GuoHan Zhao <zhaoguohan@kylinos.cn>, Colin Ian King <colin.i.king@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

linux/string.h provides strstarts that matches the starts_with
function. For style and consistency reasons remove the starts_with
functions and use strstarts.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/pmu.c | 12 ++++--------
 tools/perf/util/drm_pmu.c      | 36 +++++++++++++++-------------------
 2 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index a3f96221758d..4ea4d022c9c3 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -5,6 +5,7 @@
 #include <dirent.h>
 #include <fcntl.h>
 #include <linux/stddef.h>
+#include <linux/string.h>
 #include <linux/perf_event.h>
 #include <linux/zalloc.h>
 #include <api/fs/fs.h>
@@ -71,11 +72,6 @@ static int snc_nodes_per_l3_cache(void)
 	return snc_nodes;
 }
 
-static bool starts_with(const char *str, const char *prefix)
-{
-	return !strncmp(prefix, str, strlen(prefix));
-}
-
 static int num_chas(void)
 {
 	static bool checked_chas;
@@ -93,7 +89,7 @@ static int num_chas(void)
 
 		while ((dent = io_dir__readdir(&dir)) != NULL) {
 			/* Note, dent->d_type will be DT_LNK and so isn't a useful filter. */
-			if (starts_with(dent->d_name, "uncore_cha_"))
+			if (strstarts(dent->d_name, "uncore_cha_"))
 				num_chas++;
 		}
 		close(fd);
@@ -305,9 +301,9 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
 			else
 				pmu->mem_events = perf_mem_events_intel;
 		} else if (x86__is_intel_graniterapids()) {
-			if (starts_with(pmu->name, "uncore_cha_"))
+			if (strstarts(pmu->name, "uncore_cha_"))
 				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
-			else if (starts_with(pmu->name, "uncore_imc_"))
+			else if (strstarts(pmu->name, "uncore_imc_"))
 				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
 		}
 	}
diff --git a/tools/perf/util/drm_pmu.c b/tools/perf/util/drm_pmu.c
index b48a375e4584..b8badae7015c 100644
--- a/tools/perf/util/drm_pmu.c
+++ b/tools/perf/util/drm_pmu.c
@@ -15,6 +15,7 @@
 #include <unistd.h>
 #include <linux/unistd.h>
 #include <linux/kcmp.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
@@ -129,11 +130,6 @@ static struct drm_pmu *add_drm_pmu(struct list_head *pmus, char *line, size_t li
 }
 
 
-static bool starts_with(const char *str, const char *prefix)
-{
-	return !strncmp(prefix, str, strlen(prefix));
-}
-
 static int add_event(struct drm_pmu_event **events, int *num_events,
 		     const char *line, enum drm_pmu_unit unit, const char *desc)
 {
@@ -174,7 +170,7 @@ static int read_drm_pmus_cb(void *args, int fdinfo_dir_fd, const char *fd_name)
 	}
 
 	while (io__getline(&io, &line, &line_len) > 0) {
-		if (starts_with(line, "drm-driver:")) {
+		if (strstarts(line, "drm-driver:")) {
 			drm = add_drm_pmu(pmus, line, line_len);
 			if (!drm)
 				break;
@@ -184,59 +180,59 @@ static int read_drm_pmus_cb(void *args, int fdinfo_dir_fd, const char *fd_name)
 		 * Note the string matching below is alphabetical, with more
 		 * specific matches appearing before less specific.
 		 */
-		if (starts_with(line, "drm-active-")) {
+		if (strstarts(line, "drm-active-")) {
 			add_event(&events, &num_events, line, DRM_PMU_UNIT_BYTES,
 				  "Total memory active in one or more engines");
 			continue;
 		}
-		if (starts_with(line, "drm-cycles-")) {
+		if (strstarts(line, "drm-cycles-")) {
 			add_event(&events, &num_events, line, DRM_PMU_UNIT_CYCLES,
 				"Busy cycles");
 			continue;
 		}
-		if (starts_with(line, "drm-engine-capacity-")) {
+		if (strstarts(line, "drm-engine-capacity-")) {
 			add_event(&events, &num_events, line, DRM_PMU_UNIT_CAPACITY,
 				"Engine capacity");
 			continue;
 		}
-		if (starts_with(line, "drm-engine-")) {
+		if (strstarts(line, "drm-engine-")) {
 			add_event(&events, &num_events, line, DRM_PMU_UNIT_NS,
 				  "Utilization in ns");
 			continue;
 		}
-		if (starts_with(line, "drm-maxfreq-")) {
+		if (strstarts(line, "drm-maxfreq-")) {
 			add_event(&events, &num_events, line, DRM_PMU_UNIT_HZ,
 				  "Maximum frequency");
 			continue;
 		}
-		if (starts_with(line, "drm-purgeable-")) {
+		if (strstarts(line, "drm-purgeable-")) {
 			add_event(&events, &num_events, line, DRM_PMU_UNIT_BYTES,
 				  "Size of resident and purgeable memory buffers");
 			continue;
 		}
-		if (starts_with(line, "drm-resident-")) {
+		if (strstarts(line, "drm-resident-")) {
 			add_event(&events, &num_events, line, DRM_PMU_UNIT_BYTES,
 				  "Size of resident memory buffers");
 			continue;
 		}
-		if (starts_with(line, "drm-shared-")) {
+		if (strstarts(line, "drm-shared-")) {
 			add_event(&events, &num_events, line, DRM_PMU_UNIT_BYTES,
 				  "Size of shared memory buffers");
 			continue;
 		}
-		if (starts_with(line, "drm-total-cycles-")) {
+		if (strstarts(line, "drm-total-cycles-")) {
 			add_event(&events, &num_events, line, DRM_PMU_UNIT_BYTES,
 				  "Total busy cycles");
 			continue;
 		}
-		if (starts_with(line, "drm-total-")) {
+		if (strstarts(line, "drm-total-")) {
 			add_event(&events, &num_events, line, DRM_PMU_UNIT_BYTES,
 				  "Size of shared and private memory");
 			continue;
 		}
-		if (verbose > 1 && starts_with(line, "drm-") &&
-		    !starts_with(line, "drm-client-id:") &&
-		    !starts_with(line, "drm-pdev:"))
+		if (verbose > 1 && strstarts(line, "drm-") &&
+		    !strstarts(line, "drm-client-id:") &&
+		    !strstarts(line, "drm-pdev:"))
 			pr_debug("Unhandled DRM PMU fdinfo line match '%s'\n", line);
 	}
 	if (drm) {
@@ -261,7 +257,7 @@ bool drm_pmu__have_event(const struct perf_pmu *pmu, const char *name)
 {
 	struct drm_pmu *drm = container_of(pmu, struct drm_pmu, pmu);
 
-	if (!starts_with(name, "drm-"))
+	if (!strstarts(name, "drm-"))
 		return false;
 
 	for (int i = 0; i < drm->num_events; i++) {
-- 
2.53.0.473.g4a7958ca14-goog

