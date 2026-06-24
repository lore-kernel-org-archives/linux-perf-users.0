Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB01C3E3166;
	Wed, 24 Jun 2026 20:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334746; cv=none; b=RoXiUV/v51pngcFMY6nNVPj7/AawTKp2PiQwHr2BTKAm/ITYHGy1DOQtOTCZMdMEANkBAEaAAz7tQn0H4fJ+dfUMLmz9CvLVR5g1GB3y8ZJulgnBI+rIsvgrL8FkNLSGFw+1/SLnffXzw11CkmE8ZUFG0lEl+mjaryVjbccYZJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334746; c=relaxed/simple;
	bh=WM8LXdIzWgBiD1wFM3CcmS4f3OdhhdRtvQV5TR5staU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7kUjw/7pv1cvGBTRRbNKgHk8ibS21FyLBiIYpDYL6BLtsYl+r764r+V76SndK2gDlzorIeWw/GVHaiwDGq99LD5VhgTBIq/4RGAJltCuktCw0646rgWnXUE4dYk261neAZkWy0ZJYSN8m1qXs5Wl0KIpYb4fcK3VvtXZ00PbYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3Kok59t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3Kok59t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA341F000E9;
	Wed, 24 Jun 2026 20:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782334745;
	bh=paV4I5MQw2l+GE85HVOmhBVUrf6nWZr2qIl2UsX9X+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h3Kok59t9knx7BCB0KXslyOYYPXC38Cp6a3P0vmdiQ5YBi4Rcl3Lq+CbecoLhY6fo
	 zKJjBj+FiB5ZQ9aMLK3Uc5plKq1UvEYZf1y7IU6+awWZdy/IcYBUThOu4m06MYghFH
	 f/RGMl2hE801mWX8102Z+ODrugKXQBOAQ3/Q0RIFOMXoKbnav9sCpQwNr/1KxCnZLm
	 pnk7IqxVv4/9gEFFRbC7qcclnb39IsF7RTdSkvrdwkTC5zvwMFAVrugTyzkGv3L0fR
	 Rt9lfJpEZvsg6rLyAdGXlnISOOk6vdgRW7XuVdjz9l595vaPZBKA7hiAdTbS5WhHTZ
	 tFS7FVDlK+sYA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 6/8] perf timechart: Fix memory leaks during record
Date: Wed, 24 Jun 2026 13:58:32 -0700
Message-ID: <20260624205852.3864874-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260624205852.3864874-1-namhyung@kernel.org>
References: <20260624205852.3864874-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The command line options can be passed without copy as their lifetime is
limited within the same function.

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-timechart.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 27d17268395ed760..a73f0ab22fd64241 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1834,6 +1834,7 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
 		"syscalls:sys_exit_select",
 	};
 	unsigned int poll_events_nr = ARRAY_SIZE(poll_events);
+	int ret;
 
 	rec_argc = common_args_nr +
 		disk_events_nr * 4 +
@@ -1852,7 +1853,7 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
 
 	p = rec_argv;
 	for (i = 0; i < common_args_nr; i++)
-		*p++ = strdup(common_args[i]);
+		*p++ = common_args[i];
 
 	for (i = 0; i < disk_events_nr; i++) {
 		if (!is_valid_tracepoint(disk_events[i])) {
@@ -1861,7 +1862,7 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
 		}
 
 		*p++ = "-e";
-		*p++ = strdup(disk_events[i]);
+		*p++ = disk_events[i];
 		*p++ = "--filter";
 		*p++ = filter;
 	}
@@ -1872,7 +1873,7 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
 		}
 
 		*p++ = "-e";
-		*p++ = strdup(net_events[i]);
+		*p++ = net_events[i];
 		*p++ = "--filter";
 		*p++ = filter;
 	}
@@ -1883,7 +1884,7 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
 		}
 
 		*p++ = "-e";
-		*p++ = strdup(poll_events[i]);
+		*p++ = poll_events[i];
 		*p++ = "--filter";
 		*p++ = filter;
 	}
@@ -1891,7 +1892,11 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
 	for (i = 0; i < (unsigned int)argc; i++)
 		*p++ = argv[i];
 
-	return cmd_record(rec_argc, rec_argv);
+	ret = cmd_record(rec_argc, rec_argv);
+
+	free(rec_argv);
+	free(filter);
+	return ret;
 }
 
 
@@ -1902,6 +1907,7 @@ static int timechart__record(struct timechart *tchart, int argc, const char **ar
 	const char **rec_argv;
 	const char **p;
 	unsigned int record_elems;
+	int ret;
 
 	const char * const common_args[] = {
 		"record", "-a", "-R", "-c", "1", "-o", output_data,
@@ -1966,24 +1972,27 @@ static int timechart__record(struct timechart *tchart, int argc, const char **ar
 
 	p = rec_argv;
 	for (i = 0; i < common_args_nr; i++)
-		*p++ = strdup(common_args[i]);
+		*p++ = common_args[i];
 
 	for (i = 0; i < backtrace_args_no; i++)
-		*p++ = strdup(backtrace_args[i]);
+		*p++ = backtrace_args[i];
 
 	for (i = 0; i < tasks_args_nr; i++)
-		*p++ = strdup(tasks_args[i]);
+		*p++ = tasks_args[i];
 
 	for (i = 0; i < power_args_nr; i++)
-		*p++ = strdup(power_args[i]);
+		*p++ = power_args[i];
 
 	for (i = 0; i < old_power_args_nr; i++)
-		*p++ = strdup(old_power_args[i]);
+		*p++ = old_power_args[i];
 
 	for (j = 0; j < (unsigned int)argc; j++)
 		*p++ = argv[j];
 
-	return cmd_record(rec_argc, rec_argv);
+	ret = cmd_record(rec_argc, rec_argv);
+
+	free(rec_argv);
+	return ret;
 }
 
 static int
-- 
2.55.0.rc0.799.gd6f94ed593-goog

