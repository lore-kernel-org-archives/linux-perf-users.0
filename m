Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B97221F1C
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Nov 2025 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763766621; cv=none; b=dy/Hd5cNhOsCs847422Jiu39QEEiIP01D3mSRHXAqTcOhbdYx09wA/OJjz76cm9cD9i1G2QUr32sbwmWaHzeDqv3gqf7cyynQuXl3CpWMlU6XpJ2+7iyanetfRuqIYKdE6kmFV0Wz0aFxfJMNkXwURsjflqmQ+cHNMj0oRIDxVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763766621; c=relaxed/simple;
	bh=8bWhIzEE2kOCM2/P4siDh4lmVU3/GWQ9Z1Vge3A2ZaM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N2+eY3ZWPGfK5K9LUkaQxaSAh4ST/j4FUSp32Mxl+YmmyZh+W+CrcZiY9VaK/y7v7hSD1n5fuWkaoFSNS1gWivBHUzRjVR1FiVy4Nim3d6eyy7UzL5PjlxNA2YXAOdFrTyO8/3rvxQIgfgvGm+7I33edKPkkveCDQ8vCm2CpBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LDRbe6Gy; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDRbe6Gy"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b62da7602a0so2415696a12.2
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Nov 2025 15:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763766611; x=1764371411; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5b2DOngf45K4pr9iLY35IcW9cBrxBxPbnXC9KlOB26c=;
        b=LDRbe6GybRAOnGdkEO+zKAVLrXAOeH+v2MuxHZ2jmF+GdXnRzJu9NyzXfkQXOkIlm/
         jC/Z93rjNV+cdNBkFixN8/4//UdFNdDx0wU2RZwSgLlOz6uVh/CNzg+KEHtRanf6WSju
         AlqKhvsAV4L/Khb+YPM798GPEPAJJkJmgM+KRA/XjjM93+Nz+6lsjvPeBLCcorfRHRZM
         YI1rth0cq5uphZc0YYz79KAXFKW3aKrd89i7HQoNCjZUcHVfCigz1fu5ZxiJEhi6M+CI
         pba9HgHe5moO0xJAZ5rEH1IlaXi/0hDH1PEnWmCut07YLHaBVBxd/SRt6jCKuOMgdC+9
         rDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763766611; x=1764371411;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5b2DOngf45K4pr9iLY35IcW9cBrxBxPbnXC9KlOB26c=;
        b=n92IOeWAzRVTxgVhnBEvU9PvVMnIQ79gHCTGzOSMXqZfY6mZlTfWDvWeZPx85MJLLH
         BrVy0Pz0Nmqzo41sDOGTH6oPQ8aArl972HkRPenp7BMb0Vb3nARhDXx+xSLtDnz3VtuZ
         uhXh8e56cJI6imFPU13lFH1Op4sW7Iu18+LGqjFHlx6qfojHjeWutUHDLSXV6O15Z51Q
         XBN55jqkkE5PVfteF24O3Nx49uSjUHwz/DwbMPVYhHTWwJvbT2lJBEKd1MooOcRHSMq6
         K3mmoI4ykNdaqxLJaJOuQVCcul+rD83sP7zYpCR9ho1k/cRfmkICyHn/CWFg5RZOCewc
         ow4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXicpCdenDx1gPHspd4KT1P9r0GWzMxfx3N4xQ8ZWeGWgKslKxwm5fNEH1WwJxGyeTpo+nd+HtFNear5PFgyS3u@vger.kernel.org
X-Gm-Message-State: AOJu0YzS+1QYpUAaqyTcfI8aFVkyXUh8RGaDJbIx9S2l5c7u5w+QQcro
	yUVCC3NkQX3y700CvC7Jc7JJiyoZmZyvnDq7P8Dj/iDgXmQj2fOnq8RGSpMQCc0iz52DzVz4vUb
	UyXFiEA==
X-Google-Smtp-Source: AGHT+IGylgxQzgTzR8vCzvcryIe4d4Y+gnzkKFo3DXktMIlzTpkf5SRCaUVEZdGi/cXH+z3M3SolRzieAsk=
X-Received: from dyaa12.prod.google.com ([2002:a05:693c:40cc:b0:2a4:7453:cd4e])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3c1e:b0:2a4:3593:ddf0
 with SMTP id 5a478bee46e88-2a719fbd09bmr1625100eec.29.1763766610602; Fri, 21
 Nov 2025 15:10:10 -0800 (PST)
Date: Fri, 21 Nov 2025 15:09:12 -0800
In-Reply-To: <20251121230951.3240124-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121230951.3240124-1-ctshao@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121230951.3240124-2-ctshao@google.com>
Subject: [PATCH v5 2/2] perf evsel: Find process with busy PMUs for EBUSY
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Ian Rogers <irogers@google.com>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, thomas.falcon@intel.com, howardchu95@gmail.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It parses fdinfo with PMU type, comparing with the event which failed to
open, and report the processes causing EBUSY error.

Testing cycles and intel_pt//

  $ ./perf stat -e cycles &
  [1] 55569
  $ ./perf stat -e intel_pt// &
  [2] 55683
  $ ./perf stat -e intel_pt//
  Error:
  The PMU intel_pt counters are busy and in use by another process.
  Possible processes:
  55683 ./perf stat -e intel_pt//

Only perf with intel_pt was reported.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
v5:
  No change.

v4: lore.kernel.org/20250603181634.1362626-2-ctshao@google.com/
  Removed the first patch in v3 since it is merged.
  Retested to make sure the patch still work.

v3: lore.kernel.org/20241106003007.2112584-3-ctshao@google.com/

 tools/perf/util/evsel.c | 79 +++++++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index aee42666e882..059792a978a8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3732,7 +3732,8 @@ static bool find_process(const char *name)
 	return ret ? false : true;
 }

-static int dump_perf_event_processes(char *msg, size_t size)
+static int dump_perf_event_processes(const struct perf_event_attr *failed_attr,
+				     char *msg, size_t size)
 {
 	DIR *proc_dir;
 	struct dirent *proc_entry;
@@ -3773,29 +3774,61 @@ static int dump_perf_event_processes(char *msg, size_t size)
 				continue;
 			/* Take care as readlink doesn't null terminate the string. */
 			if (!strncmp(buf, "anon_inode:[perf_event]", link_size)) {
-				int cmdline_fd;
-				ssize_t cmdline_size;
-
-				scnprintf(buf, sizeof(buf), "%s/cmdline", proc_entry->d_name);
-				cmdline_fd = openat(dirfd(proc_dir), buf, O_RDONLY);
-				if (cmdline_fd == -1)
-					continue;
-				cmdline_size = read(cmdline_fd, buf, sizeof(buf) - 1);
-				close(cmdline_fd);
-				if (cmdline_size < 0)
+				int fdinfo_fd;
+				ssize_t fdinfo_size;
+				char *line;
+				u32 perf_event_type = UINT32_MAX;
+
+				/* Let's check the PMU type reserved by this process */
+				scnprintf(buf, sizeof(buf), "%s/fdinfo/%s",
+					  proc_entry->d_name, fd_entry->d_name);
+				fdinfo_fd = openat(dirfd(proc_dir), buf, O_RDONLY);
+				fdinfo_size = read(fdinfo_fd, buf, sizeof(buf) - 1);
+				if (fdinfo_size < 0)
 					continue;
-				buf[cmdline_size] = '\0';
-				for (ssize_t i = 0; i < cmdline_size; i++) {
-					if (buf[i] == '\0')
-						buf[i] = ' ';
+				buf[fdinfo_size] = '\0';
+
+				line = strtok(buf, "\n");
+				while (line != NULL) {
+					if (sscanf(line,
+						   "perf_event_attr.type:\t%u",
+						   &perf_event_type) == 1)
+						break;
+					line = strtok(NULL, "\n");
 				}

-				if (printed == 0)
-					printed += scnprintf(msg, size, "Possible processes:\n");
-
-				printed += scnprintf(msg + printed, size - printed,
-						"%s %s\n", proc_entry->d_name, buf);
-				break;
+				/* Report the process which reserves the conflicted PMU. */
+				/* If fdinfo does not contain PMU type, report it too. */
+				if (perf_event_type == failed_attr->type ||
+				    perf_event_type == UINT32_MAX) {
+					int cmdline_fd;
+					ssize_t cmdline_size;
+
+					scnprintf(buf, sizeof(buf),
+						  "%s/cmdline",
+						  proc_entry->d_name);
+					cmdline_fd = openat(dirfd(proc_dir), buf, O_RDONLY);
+					if (cmdline_fd == -1)
+						continue;
+					cmdline_size = read(cmdline_fd, buf, sizeof(buf) - 1);
+					close(cmdline_fd);
+					if (cmdline_size < 0)
+						continue;
+					buf[cmdline_size] = '\0';
+					for (ssize_t i = 0; i < cmdline_size; i++) {
+						if (buf[i] == '\0')
+							buf[i] = ' ';
+					}
+
+					if (printed == 0)
+						printed += scnprintf(
+							msg, size,
+							"Possible processes:\n");
+
+					printed += scnprintf(msg + printed, size - printed,
+							"%s %s\n", proc_entry->d_name, buf);
+					break;
+				}
 			}
 		}
 		closedir(fd_dir);
@@ -3914,7 +3947,9 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			msg, size,
 			"The PMU %s counters are busy and in use by another process.\n",
 			evsel->pmu ? evsel->pmu->name : "");
-		return printed + dump_perf_event_processes(msg + printed, size - printed);
+		return printed + dump_perf_event_processes(&evsel->core.attr,
+							   msg + printed,
+							   size - printed);
 		break;
 	case EINVAL:
 		if (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_SIZE && perf_missing_features.code_page_size)
--

2.52.0.rc2.455.g230fcf2819-goog

