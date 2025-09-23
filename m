Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2E73128D4
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 22:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666818; cv=none; b=lhQohY+NSQjjjQgby9Nfkn6+WuWjzbNiIc6RbYsTl6HUFdUdV+rihxVh5aYutY4PH7hZyoCNmiQCFH/nh+ruuN2tmnsSC8KzH6xvPdbEV+5eOKDfpNa6uefxCV/gI+m04CxnnF3tvgjAF9L2kWMNefGS0fSGpVXIp/wpz1Y/U4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666818; c=relaxed/simple;
	bh=A7ME6lBRxNDqwUqz8g1s1XDCmohN7azXW8DlDooqfI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m7kzAOe6jLJTkBBNBe/WZRCLp8/JZSb4Vp9EHVtDkEq1a2aUZtCZv3wnLefoceSXrP3BHh6+yX320pm+2haDdcjs1WCymrPDMUTgn0AuI4OwyaKsm1w6PbW5OZ8SMmnoypZ9cazKqObIBhsrl7pAz+T8c+elNw4wK1+DigE/PW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1X7V9YfZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1X7V9YfZ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-329b750757aso5067028a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 15:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666816; x=1759271616; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SmM+YDTHkakrcbqR3dL1OE9HXiYEwJsKu0xmPObyyj0=;
        b=1X7V9YfZAxUSCBojWm3RhVL6Z2mjqC6TVAlJAnzEzKlb/xMVOxen5gRMTjKKmT5X9f
         fiAo4WaNYQdeUh3x1Lu6Esr90GRvWY3k9dbP6snGwC9IB4si46WSAYk9Wg2MqnjlV5NG
         QtfKQiSfbMQDLL4xn+3QkXe8Ht/c8YI0/41g4nbXCsjQm4TJY74xaqG/9sPlUqEhiTey
         qCWjaa5vl6PV0Sx/ZTYJuSMiVsmfcMElljlx452ZyOPP8mb03T2kHSEvhTcmsO41luNU
         NO6n5ji/bZQKrIOBbF0fRG/1ooCCwd5rOpEPeoZ2t+XBE+U7KhydnEAaLfV8sYRPrQoD
         t8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666816; x=1759271616;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmM+YDTHkakrcbqR3dL1OE9HXiYEwJsKu0xmPObyyj0=;
        b=ILzyBIoNHBFxBSmr7zaEHLof5qOYSdg7OhXUuJ9qB/TXLmY3o4HcB0Cgy4i8Ll3AQ8
         yeDOVQU17yu1qpY834RNPFKrTQe21XMa0rN5OV4Q+2wm+TM64qfSBcceDaOmH44FkbH0
         Sehn807ugV8np+AK4wmXjh0jmU+wjgIY4uI0eAPsHHUHdisN8CIo4kY+Ka4aP+vvD1Ev
         a9rnL0NxuIZCRzqbNzYztim24Y8f8zbFcwotgr4wwCkwWgK3myN0WYtjAsNcs8Jb3dhI
         zc3bwLIyeR4TxOUnmb8E6aJQtDOZX21IpG2TO0a0RyfXCB9EePCR5eQHMUGEVDMMqUOX
         8LWA==
X-Forwarded-Encrypted: i=1; AJvYcCUHrD7Py21v/myRvbVm2VIoATSlbOv3KhzE1CrceCGQw+xibjkeRudTpjVyQTpe7UaLDpip08xL4vQUMjglXEOV@vger.kernel.org
X-Gm-Message-State: AOJu0YzUP53z8TxHBHO+1ZJxX+5hERcw6Q9MdUaVBLTiwsDbtTt1t+B6
	Ado9ne/FvD+wNZKsQJXBds/W/ExoAnuBNT53j6hAG1uLV7y89sMWrHW0PcgpDjcpYCGhtAIrPqW
	/Zq8lhm8C5w==
X-Google-Smtp-Source: AGHT+IG0COSZ3a5sBu8GOJzXw2yHAl6mHwdtLPNIi8LEBQFAdkm1etcd193pLMMaqAcLZLLG1z7tFI7ahSVh
X-Received: from pjbsp15.prod.google.com ([2002:a17:90b:52cf:b0:329:ec3d:72ad])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:384e:b0:32e:6019:5d19
 with SMTP id 98e67ed59e1d1-332a95dc7a2mr4067888a91.34.1758666815636; Tue, 23
 Sep 2025 15:33:35 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:32:53 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-10-irogers@google.com>
Subject: [PATCH v6 09/28] perf pmu: Use fd rather than FILE from new_alias
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

The FILE argument was necessary for the scanner but now that
functionality is not being used we can switch to just using
io__getline which should cut down on stdio buffer usage.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b44dfe4c73fc..818be59db2c6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -563,7 +563,7 @@ static int update_alias(const struct pmu_event *pe,
 }
 
 static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
-				const char *desc, const char *val, FILE *val_fd,
+				const char *desc, const char *val, int val_fd,
 			        const struct pmu_event *pe, enum event_source src)
 {
 	struct perf_pmu_alias *alias, *old_alias;
@@ -614,12 +614,15 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 	if (ret)
 		return ret;
 
-	if (!val_fd) {
+	if (val_fd < 0) {
 		alias->terms = strdup(val);
 	} else {
+		char buf[256];
+		struct io io;
 		size_t line_len;
 
-		ret = getline(&alias->terms, &line_len, val_fd) < 0 ? -errno : 0;
+		io__init(&io, val_fd, buf, sizeof(buf));
+		ret = io__getline(&io, &alias->terms, &line_len) < 0 ? -errno : 0;
 		if (ret) {
 			pr_err("Failed to read alias %s\n", name);
 			return ret;
@@ -698,7 +701,6 @@ static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
 	while ((evt_ent = io_dir__readdir(&event_dir))) {
 		char *name = evt_ent->d_name;
 		int fd;
-		FILE *file;
 
 		if (!strcmp(name, ".") || !strcmp(name, ".."))
 			continue;
@@ -714,17 +716,12 @@ static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
 			pr_debug("Cannot open %s\n", name);
 			continue;
 		}
-		file = fdopen(fd, "r");
-		if (!file) {
-			close(fd);
-			continue;
-		}
 
 		if (perf_pmu__new_alias(pmu, name, /*desc=*/ NULL,
-					/*val=*/ NULL, file, /*pe=*/ NULL,
+					/*val=*/ NULL, fd, /*pe=*/ NULL,
 					EVENT_SRC_SYSFS) < 0)
 			pr_debug("Cannot set up %s\n", name);
-		fclose(file);
+		close(fd);
 	}
 
 	pmu->sysfs_aliases_loaded = true;
@@ -1041,7 +1038,7 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
 {
 	struct perf_pmu *pmu = vdata;
 
-	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ NULL,
+	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ -1,
 			    pe, EVENT_SRC_CPU_JSON);
 	return 0;
 }
@@ -1090,7 +1087,7 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
 				pe->name,
 				pe->desc,
 				pe->event,
-				/*val_fd=*/ NULL,
+				/*val_fd=*/ -1,
 				pe,
 				EVENT_SRC_SYS_JSON);
 	}
-- 
2.51.0.534.gc79095c0ca-goog

