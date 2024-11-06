Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CA71E522
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Nov 2024 00:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853018; cv=none; b=o5LeC4aeJTrU+baujxL+88jLJ9deQGKfYGsKD0pUdf6WF9H5gH7WtlJf+OGCxNIG3NE60RIgYrXpBNVR5TYZaJAOw+RqY2tjpWG5igNbiIRcpEWpKvWSweRrwJgF9NDeW360GLngu1AohWILnrN6HPDwdfNvRqyMRsnRpuDyRjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853018; c=relaxed/simple;
	bh=uT/40/EBqDqfLgoIbjW9uBYXBkgTJTPPMZyIyOz02kc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t+OElU3kF86QFu5nqQzOqV9O2ZZJ+2wxSlV0Ml7GlAfXpg85dEmwwyF2AL2TWY+CJ+iPKRTvMA/9XcHtgyq3/5sQULwQFL5662Rx7YrvdIf/xPJfKJ84IYTlhhIyY75xB5YSkDIcofgtIEwCwUlnwrxDmdToJ17J8c5zsU7ofXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zIA3Y3kN; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zIA3Y3kN"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e38fabff35so108555847b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Nov 2024 16:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730853014; x=1731457814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jm74lkunM0McejxLs8UxnlGUjVbMmOuJgHz4tp8ZHD8=;
        b=zIA3Y3kNu30SNdpK4bBcoBfTOo08zJQ9gtaVFZL/1qYq3tGrZdw5NPhxtrq4z2Cdbr
         rcOvHMtFmeRKV0UD01WvFETkeJwXC3ugqnQofHETxXlOzOfHdbTWRjVqIM+JMWO018lP
         p7z8p4k6iyGmzHk2JaqZj1+VpdUj0FC/EM1eI8OGxMCWhl11CD+9vcNj55rCM2aotLu4
         dWJ/8TEIgw67tZNI0FYj89ensCrE4rEQTfGSmQdPbQLkuDTeTJw7BrJSqrDMasnEcRx0
         R03N9mEeKCmVvTRewwSiSw4jIt7qgwAHImvZO+7rXjZYijt/DC8aWwPxaZ6ItVU0IEl9
         nr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730853014; x=1731457814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jm74lkunM0McejxLs8UxnlGUjVbMmOuJgHz4tp8ZHD8=;
        b=UCyV36isaDP34TaMh6pXOqzSBhhTdF+z4fS/e/q5kyKzDhx/GunH14o7rBdatq9IBf
         RDbxeGxFnGZ2Wzyy5ycYKgt+hsQDuvZgBhqXNETn7H9CME/7puPoBHGJ5GXEDiGOw2aL
         2fdVE1Ye7owiYj4Fw88+ivk3E6eCiS95k6zJqycST9X4D0bgZLlj95N+rWkMmiSd4CaL
         1MBJgYCjhkEhsQUXLme+zSfCZYgMv3z7STET/3plDFYdRNk7tnToHho2YY5VSmpZH4sV
         llr+Zc/3zu1gVm48z9KFGLxIt9dzxJadWiyHtlDZ7PDSzoHpQVP5uw1jSck3Ri0FsyiR
         9h+A==
X-Forwarded-Encrypted: i=1; AJvYcCV4EgiG3MrBBUuk0jGABPpg7a7xdg5XXqCFSGmH0OHwWl5lEI3CsE58uqzgldFcUwoEMnDKje3nMslghWWBhPzP@vger.kernel.org
X-Gm-Message-State: AOJu0YxrCsQd577FKz0tZtke46FeGYddV7j1UtBvjh1IFbhQ+IlSe/zg
	FHuXkJq/vuiotTfeHZdrvGZosCvZo+7VjIdM5Eyp57Ty4bSsfD2ydO7KQuFGZ/36wMFImZH4Hk5
	4cQ==
X-Google-Smtp-Source: AGHT+IHJw19EAT3fH2hse0vzDO7YAOn3IAzv9cqlkkiB9xs4+PiCuMXW1b7GUEoKvh0Z8dhm8aEbiORgcx0=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:ce7])
 (user=ctshao job=sendgmr) by 2002:a05:690c:f:b0:6e3:6414:80c5 with SMTP id
 00721157ae682-6e9d87b4522mr11536017b3.0.1730853013813; Tue, 05 Nov 2024
 16:30:13 -0800 (PST)
Date: Wed,  6 Nov 2024 00:30:07 +0000
In-Reply-To: <20241106003007.2112584-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241106003007.2112584-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241106003007.2112584-3-ctshao@google.com>
Subject: [PATCH v3 3/3] perf evsel: Find process with busy PMUs for EBUSY
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Chun-Tse Shao <ctshao@google.com>, Weilin Wang <weilin.wang@intel.com>, 
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

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Change-Id: Ic51a36ea3b2fd245663d7db78f35496bb4199d73
---
 tools/perf/util/evsel.c | 79 +++++++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d001ecfa26bf7..5400b795d9233 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3286,7 +3286,8 @@ static bool find_process(const char *name)
 	return ret ? false : true;
 }
 
-static int dump_perf_event_processes(char *msg, size_t size)
+static int dump_perf_event_processes(const struct perf_event_attr *failed_attr,
+				     char *msg, size_t size)
 {
 	DIR *proc_dir;
 	struct dirent *proc_entry;
@@ -3327,29 +3328,61 @@ static int dump_perf_event_processes(char *msg, size_t size)
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
@@ -3458,7 +3491,9 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
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
2.47.0.199.ga7371fff76-goog

