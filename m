Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F17F4A014F;
	Tue,  6 Oct 2026 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303228; cv=none; b=qD0rkm42GCjTSl2Ns9sHxCT2i8JOJMAiUT126bSOFREMQvJkhyGMgtZbSocJOfrS2O8+jrzKjIr6uN2kxLiVgPeiCwh9+hgGEDwBJ/NVdHkaDzin/tTPEGE6GyBI/fiP83LReUNPDhTJy/wnf07DpGoCL4Dr+IlPRq4XHCkB2Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303228; c=relaxed/simple;
	bh=Pyc8U91eHOUGhdP0KJh8FNAOGSWHUbXOZ3xGKMa31rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QK1ZhqMKsWv8T9GR0EzHsripca4HGEpYD0CrGzqVyy0oLDdjvh9I2YtUd1RhaRSQJ1WQZp+Le/h22IfLfEHcB8K5OT+VfVcreULORognS70LBUhLuJn9u9GvY3snpab3dTQV+c83KsigDrcJ6Ua2QKJ8L7Q4sXkGqQmaDNWmbgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPcKyWpw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPcKyWpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7F81F0089C;
	Tue,  6 Oct 2026 16:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303226;
	bh=j7xMSwkHWNJhMzEWl11rRgz614tprnUmmkyVpShapN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XPcKyWpwybggvbqexe7IBEQp+A04scK39Zfnx+4JnCFy4M40C42QsIRzJU3PHSwky
	 oRRXEZ9XnPjbSjwULjHuAVeZbZKxuUeXH+DGkeihbM8uyB/Vn5wiP/B7j1t2VZWdO2
	 EuyY9nGpgRohi5Z9bzdKcQWcf1BTfM2+WOqKOV3yAyeTfrySPXJLl3DoL6ZmTWHs9s
	 hizj3d8/OjWJn6RMfGofVlb60MV12hVe0L9VBEU86mIbS1VOQh5+DRRm3rOvWOay+h
	 1gKMSWBJDiAhhsG61zbUVArFbOYDEKEPtMzuc3Y5PiTrI94PslCSQrN2ZJM4zdKje/
	 5o4ii2VsePc1w==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5/6] perf test attr: Fix default stat metrics expectations
Date: Tue,  6 Oct 2026 18:13:08 +0200
Message-ID: <20261006161309.3078488-6-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006161309.3078488-1-acme@kernel.org>
References: <20261006161309.3078488-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since c7adeb0974f18da4 ("perf jevents: Add set of common metrics based
on default ones") and 2dfc0cab3da4a205 ("perf stat: Add detail -d,-dd,-ddd
metrics") the perf stat default metrics open their events in groups, so
group leaders and members have read_format=15 and members are enabled
without enable_on_exec, while standalone events keep read_format=3 and
are disabled until exec.

Also, since b1c5efbfd92eb84d ("perf parse-events: Remove hard coded
legacy hardware and cache parsing") bare hardware events resolve to the
core PMU sysfs/JSON events (type 4), so add the raw encodings seen on
Intel and AMD for instructions, branch-misses, cpu-cycles and
stalled-cycles-frontend/backend to test-stat-default and
test-stat-detailed-1/2/3.

Update base-stat to accept both the standalone and group variants of
read_format, disabled and enable_on_exec.

Fixes: b1c5efbfd92eb84d ("perf parse-events: Remove hard coded legacy hardware and cache parsing")
Fixes: c7adeb0974f18da4 ("perf jevents: Add set of common metrics based on default ones")
Fixes: 2dfc0cab3da4a205 ("perf stat: Add detail -d,-dd,-ddd metrics")
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/attr/base-stat         |  6 ++--
 tools/perf/tests/shell/attr/test-stat-default | 32 +++++++++++++++++--
 .../tests/shell/attr/test-stat-detailed-1     | 32 +++++++++++++++++--
 .../tests/shell/attr/test-stat-detailed-2     | 32 +++++++++++++++++--
 .../tests/shell/attr/test-stat-detailed-3     | 32 +++++++++++++++++--
 5 files changed, 123 insertions(+), 11 deletions(-)

diff --git a/tools/perf/tests/shell/attr/base-stat b/tools/perf/tests/shell/attr/base-stat
index 67d6eea8947034e1..dda41a626cbca64e 100644
--- a/tools/perf/tests/shell/attr/base-stat
+++ b/tools/perf/tests/shell/attr/base-stat
@@ -9,8 +9,8 @@ size=176
 config=0
 sample_period=0
 sample_type=65536
-read_format=3
-disabled=1
+read_format=3|15
+disabled=0|1
 inherit=1
 pinned=0
 exclusive=0
@@ -22,7 +22,7 @@ mmap=0
 comm=0
 freq=0
 inherit_stat=0
-enable_on_exec=1
+enable_on_exec=0|1
 task=0
 watermark=0
 precise_ip=0
diff --git a/tools/perf/tests/shell/attr/test-stat-default b/tools/perf/tests/shell/attr/test-stat-default
index 8dd27c1fb661fb77..e79bc56389fda180 100644
--- a/tools/perf/tests/shell/attr/test-stat-default
+++ b/tools/perf/tests/shell/attr/test-stat-default
@@ -179,11 +179,11 @@ type=4
 config=17039629
 optional=1
 
-# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
+# PERF_TYPE_RAW / cpu-cycles (core PMU sysfs event; Intel 0x3c, AMD 0x76)
 [event22:base-stat]
 fd=22
 type=4
-config=60
+config=60|118
 optional=1
 
 # PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
@@ -233,4 +233,32 @@ optional=1
 fd=29
 type=4
 config=4269
+optional=1
+
+# PERF_TYPE_RAW / instructions (core PMU sysfs event)
+[event30:base-stat]
+fd=30
+type=4
+config=192
+optional=1
+
+# PERF_TYPE_RAW / branch-misses (core PMU sysfs event; Intel 0xc5, AMD 0xc3)
+[event31:base-stat]
+fd=31
+type=4
+config=197|195
+optional=1
+
+# PERF_TYPE_RAW / stalled-cycles-frontend (core PMU sysfs event; AMD 0xd0/0x287/0xa9)
+[event32:base-stat]
+fd=32
+type=4
+config=208|647|169
+optional=1
+
+# PERF_TYPE_RAW / stalled-cycles-backend (core PMU sysfs event; AMD 0xd1/0x187)
+[event33:base-stat]
+fd=33
+type=4
+config=209|391
 optional=1
\ No newline at end of file
diff --git a/tools/perf/tests/shell/attr/test-stat-detailed-1 b/tools/perf/tests/shell/attr/test-stat-detailed-1
index 12a2ebf4e64a0077..cbd1041cd6c0430c 100644
--- a/tools/perf/tests/shell/attr/test-stat-detailed-1
+++ b/tools/perf/tests/shell/attr/test-stat-detailed-1
@@ -181,11 +181,11 @@ type=4
 config=17039629
 optional=1
 
-# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
+# PERF_TYPE_RAW / cpu-cycles (core PMU sysfs event; Intel 0x3c, AMD 0x76)
 [event22:base-stat]
 fd=22
 type=4
-config=60
+config=60|118
 optional=1
 
 # PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
@@ -275,4 +275,32 @@ optional=1
 fd=33
 type=4
 config=4269
+optional=1
+
+# PERF_TYPE_RAW / instructions (core PMU sysfs event)
+[event34:base-stat]
+fd=34
+type=4
+config=192
+optional=1
+
+# PERF_TYPE_RAW / branch-misses (core PMU sysfs event; Intel 0xc5, AMD 0xc3)
+[event35:base-stat]
+fd=35
+type=4
+config=197|195
+optional=1
+
+# PERF_TYPE_RAW / stalled-cycles-frontend (core PMU sysfs event; AMD 0xd0/0x287/0xa9)
+[event36:base-stat]
+fd=36
+type=4
+config=208|647|169
+optional=1
+
+# PERF_TYPE_RAW / stalled-cycles-backend (core PMU sysfs event; AMD 0xd1/0x187)
+[event37:base-stat]
+fd=37
+type=4
+config=209|391
 optional=1
\ No newline at end of file
diff --git a/tools/perf/tests/shell/attr/test-stat-detailed-2 b/tools/perf/tests/shell/attr/test-stat-detailed-2
index 66ea25b7d38f8d59..c47b22b4ec30259f 100644
--- a/tools/perf/tests/shell/attr/test-stat-detailed-2
+++ b/tools/perf/tests/shell/attr/test-stat-detailed-2
@@ -181,11 +181,11 @@ type=4
 config=17039629
 optional=1
 
-# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
+# PERF_TYPE_RAW / cpu-cycles (core PMU sysfs event; Intel 0x3c, AMD 0x76)
 [event22:base-stat]
 fd=22
 type=4
-config=60
+config=60|118
 optional=1
 
 # PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
@@ -335,4 +335,32 @@ optional=1
 fd=39
 type=4
 config=4269
+optional=1
+
+# PERF_TYPE_RAW / instructions (core PMU sysfs event)
+[event40:base-stat]
+fd=40
+type=4
+config=192
+optional=1
+
+# PERF_TYPE_RAW / branch-misses (core PMU sysfs event; Intel 0xc5, AMD 0xc3)
+[event41:base-stat]
+fd=41
+type=4
+config=197|195
+optional=1
+
+# PERF_TYPE_RAW / stalled-cycles-frontend (core PMU sysfs event; AMD 0xd0/0x287/0xa9)
+[event42:base-stat]
+fd=42
+type=4
+config=208|647|169
+optional=1
+
+# PERF_TYPE_RAW / stalled-cycles-backend (core PMU sysfs event; AMD 0xd1/0x187)
+[event43:base-stat]
+fd=43
+type=4
+config=209|391
 optional=1
\ No newline at end of file
diff --git a/tools/perf/tests/shell/attr/test-stat-detailed-3 b/tools/perf/tests/shell/attr/test-stat-detailed-3
index 4a27bbfb9f87a538..a6251005097a9639 100644
--- a/tools/perf/tests/shell/attr/test-stat-detailed-3
+++ b/tools/perf/tests/shell/attr/test-stat-detailed-3
@@ -181,11 +181,11 @@ type=4
 config=17039629
 optional=1
 
-# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
+# PERF_TYPE_RAW / cpu-cycles (core PMU sysfs event; Intel 0x3c, AMD 0x76)
 [event22:base-stat]
 fd=22
 type=4
-config=60
+config=60|118
 optional=1
 
 # PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
@@ -355,4 +355,32 @@ optional=1
 fd=41
 type=4
 config=4269
+optional=1
+
+# PERF_TYPE_RAW / instructions (core PMU sysfs event)
+[event42:base-stat]
+fd=42
+type=4
+config=192
+optional=1
+
+# PERF_TYPE_RAW / branch-misses (core PMU sysfs event; Intel 0xc5, AMD 0xc3)
+[event43:base-stat]
+fd=43
+type=4
+config=197|195
+optional=1
+
+# PERF_TYPE_RAW / stalled-cycles-frontend (core PMU sysfs event; AMD 0xd0/0x287/0xa9)
+[event44:base-stat]
+fd=44
+type=4
+config=208|647|169
+optional=1
+
+# PERF_TYPE_RAW / stalled-cycles-backend (core PMU sysfs event; AMD 0xd1/0x187)
+[event45:base-stat]
+fd=45
+type=4
+config=209|391
 optional=1
\ No newline at end of file
-- 
2.55.0

