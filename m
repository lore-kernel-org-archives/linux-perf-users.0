Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C08435200A
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424036; cv=none; b=ROxdEtrKtYRNlGI1TiQx09O+4KN7I48BEt7v4i2AbsKkzD4P0ABVYoHUbA3oMxdB3Cc7Fu+izN6uq0CTxe7L90DJkE8vamF8dNevldS1UpsdKDiW7/JNp3nUuOItr7TDdz9F19XFnLlb5l+gy/vGvz4rTE9Uj+6PSFdd3rCaTUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424036; c=relaxed/simple;
	bh=OWGigG9V2kGeVr7vN2xiPub948058F9bxugkK2AZkdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F1wLEDRFsXcadA6U6gQwyBQSjhEjmL88alc2GVui32/8zaPhJl2Zn7KqYth6qBVN3IdQneuqp3yqo1aO8vvoaGLLg6jhqgZu/mqE2OxVlqaeVkcovEknWo6xZnc+EibWcWF/WjUDyEEiWeCiRnWS7gJsw/6mNRAvujUBF+ydkQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TbnSCaV4; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TbnSCaV4"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8423efdbe6fso498181b3a.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 11:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780424033; x=1781028833; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NiAef6XtehDHMACdTszwMTuC9UasYLCkWZEW5SY0y0w=;
        b=TbnSCaV4IxobhJD52K+VEprJy/LUFgaVuA7IMMczno8aNiwfrkxoU1H3zeUS8j4RFc
         akNTDae/b/izAE9r8CHau0A0YAWCMgBNk5Njkn8HJEIhaO1OHxOwg3InuatP0Uwkq9fM
         B8m9jppKkAzxUXeUre/gTpwNuSTGkXdGPxnh2a7U2AZk/0OLCaO3qmZ2w7+Ca7qdWogz
         D9bGi4IlaLobBSftS/b/qy3xMLamwRdVVwQ53tg7IlbzjldwBWfjgUhHxqxsXL8KocAe
         XMl+NYqxqMj6KKlIApT4x2TlL6pNsRv770bAn23I77JNJwn3nQV9z/cXe+lLIEIWok6d
         WirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780424033; x=1781028833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NiAef6XtehDHMACdTszwMTuC9UasYLCkWZEW5SY0y0w=;
        b=bMaCutyIsGdgOC3KQOZ/tI6YObgt3cjQONW9s2T/T8B01MGazcnrOaPIy/JAaaiNyk
         Krqrp5KMzkSWeo0jgGgYZIMSW5ixFOIxMfE8pvelsclRqAkZtry3DiwiqTgpRvtUukiU
         dUi+/iYqLMML+k9eQZmwbwJRDP4mJ2/RFs+DczRnxkFDNfbQaaKjfIbWyoht0C9Ojilm
         1nnzt1QeJE33QlvHMGeVFP+FEPsPLO2Uh/ALFZ9qTjenKW6+x2zU6t2CpUETI4pGjc33
         GVqvkVSmxI91u/x5Yv7DDFTIkoKjZmIHwwV4ZHdr0TzYcyrjMmsw5eJERPosDyLN3iaP
         FfwQ==
X-Forwarded-Encrypted: i=1; AFNElJ9VT15rsWztkvXKNm5czgJJBuhbNxyYP0BiPzJeZVawhwbTkZqnsHnbS/lxq/ku9oBVYVEyrs1FQDDgX6gMyImt@vger.kernel.org
X-Gm-Message-State: AOJu0Yya6mHcRoHCDHdH1xklUlrMfUfZi1fe2GzHz9xCRKYK8bulCvmt
	wizU6Jg3GS2BsFw0yxGIZfv9t9vdvsL1t109G0mDVM95YJTOGo77mr0oILb4hwT0umUfR/CYHAP
	wYaLgpQ==
X-Received: from pfh39.prod.google.com ([2002:a05:6a00:12e7:b0:82f:b53f:40d7])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b85:b0:835:405a:7e72
 with SMTP id d2e1a72fcca58-84284df9099mr54960b3a.11.1780424033017; Tue, 02
 Jun 2026 11:13:53 -0700 (PDT)
Date: Tue,  2 Jun 2026 11:13:49 -0700
In-Reply-To: <20260602181349.3969429-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602181349.3969429-1-ctshao@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602181349.3969429-2-ctshao@google.com>
Subject: [PATCH v8 2/2] perf evsel: Find process with busy PMUs for EBUSY
From: Chun-Tse Shao <ctshao@google.com>
To: Chun-Tse Shao <ctshao@google.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
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
Assisted-by: Gemini:gemini-3.1-pro-preview
---
v8:
  - Fix a boundary mismatch bug in strncmp when matching anon_inode
    symlinks.
  - Switch to thread-safe strtok_r to prevent use-after-free or static
    state corruption.
  - Expand the stack-allocated fdinfo parsing buffer from 256 bytes to
    1024 bytes to completely prevent truncation before the PMU type is
    parsed.
  - Open proc files (fdinfo and cmdline) with O_NONBLOCK to prevent
    malicious or slow mounts from hanging the perf session indefinitely.
  - Match EBUSY conflicting processes using the physical PMU type
    (pmu_type) instead of the requested event type, ensuring legacy/raw
    events are correctly resolved.
---
 tools/perf/util/evsel.c | 99 ++++++++++++++++++++++++++++++++---------
 1 file changed, 77 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 34c03f47a913..a6b1005db5e8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -4104,8 +4104,11 @@ static bool find_process(const char *name)
 	return ret ? false : true;
 }

-static int dump_perf_event_processes(char *msg, size_t size)
+static int dump_perf_event_processes(const struct evsel *evsel,
+				     char *msg, size_t size)
 {
+	const struct perf_event_attr *failed_attr = &evsel->core.attr;
+	u32 target_pmu_type = evsel->pmu ? evsel->pmu->type : UINT32_MAX;
 	DIR *proc_dir;
 	struct dirent *proc_entry;
 	int printed = 0;
@@ -4136,6 +4139,8 @@ static int dump_perf_event_processes(char *msg, size_t size)
 			continue;
 		}
 		while ((fd_entry = readdir(fd_dir)) != NULL) {
+			const char *target_lnk = "anon_inode:[perf_event]";
+			size_t target_lnk_len = sizeof("anon_inode:[perf_event]") - 1;
 			ssize_t link_size;

 			if (fd_entry->d_type != DT_LNK)
@@ -4144,30 +4149,78 @@ static int dump_perf_event_processes(char *msg, size_t size)
 			if (link_size < 0)
 				continue;
 			/* Take care as readlink doesn't null terminate the string. */
-			if (!strncmp(buf, "anon_inode:[perf_event]", link_size)) {
-				int cmdline_fd;
-				ssize_t cmdline_size;
-
-				scnprintf(buf, sizeof(buf), "%s/cmdline", proc_entry->d_name);
-				cmdline_fd = openat(dirfd(proc_dir), buf, O_RDONLY);
-				if (cmdline_fd == -1)
+			if (link_size == (ssize_t)target_lnk_len &&
+			    !strncmp(buf, target_lnk, target_lnk_len)) {
+				char fdinfo_buf[1024];
+				int fdinfo_fd;
+				ssize_t fdinfo_size;
+				char *line;
+				char *saveptr;
+				u32 perf_event_type = UINT32_MAX;
+				u32 pmu_type = UINT32_MAX;
+
+				/* Let's check the PMU type reserved by this process */
+				scnprintf(buf, sizeof(buf), "%s/fdinfo/%s",
+					  proc_entry->d_name, fd_entry->d_name);
+				fdinfo_fd = openat(dirfd(proc_dir), buf, O_RDONLY);
+				if (fdinfo_fd == -1)
 					continue;
-				cmdline_size = read(cmdline_fd, buf, sizeof(buf) - 1);
-				close(cmdline_fd);
-				if (cmdline_size < 0)
+				fdinfo_size = read(fdinfo_fd, fdinfo_buf, sizeof(fdinfo_buf) - 1);
+				close(fdinfo_fd);
+				if (fdinfo_size < 0)
 					continue;
-				buf[cmdline_size] = '\0';
-				for (ssize_t i = 0; i < cmdline_size; i++) {
-					if (buf[i] == '\0')
-						buf[i] = ' ';
+				fdinfo_buf[fdinfo_size] = '\0';
+
+				line = strtok_r(fdinfo_buf, "\n", &saveptr);
+				while (line) {
+					if (sscanf(line,
+						   "perf_event_attr.type:\t%u",
+						   &perf_event_type) == 1) {
+						/* continue parsing */
+					} else if (sscanf(line,
+							  "pmu_type:\t%u",
+							  &pmu_type) == 1) {
+						/* continue parsing */
+					}
+					line = strtok_r(NULL, "\n", &saveptr);
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
+				    pmu_type == failed_attr->type ||
+				    (target_pmu_type != UINT32_MAX &&
+				     pmu_type == target_pmu_type) ||
+				    (perf_event_type == UINT32_MAX &&
+				     pmu_type == UINT32_MAX)) {
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
+						else if (!isprint((unsigned char)buf[i]))
+							buf[i] = '.';
+					}
+					if (printed == 0)
+						printed += scnprintf(msg, size,
+								     "Possible processes:\n");
+
+					printed += scnprintf(msg + printed, size - printed,
+							"%s %s\n", proc_entry->d_name, buf);
+					break;
+				}
 			}
 		}
 		closedir(fd_dir);
@@ -4285,7 +4338,9 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			msg, size,
 			"The PMU %s counters are busy and in use by another process.\n",
 			evsel->pmu ? evsel->pmu->name : "");
-		return printed + dump_perf_event_processes(msg + printed, size - printed);
+		return printed + dump_perf_event_processes(evsel,
+							   msg + printed,
+							   size - printed);
 		break;
 	case EINVAL:
 		if (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_SIZE && perf_missing_features.code_page_size)
--
2.54.0.1013.g208068f2d8-goog

