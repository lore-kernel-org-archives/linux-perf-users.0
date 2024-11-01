Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49DC1E766A
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Nov 2024 21:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730495896; cv=none; b=rdqv2oIIRcPG8h9Y2/h7vrDp3VpwF/FSzJbkNwFauU5jlddqMjcXxAPDoTYzyyVUPkSNyRZMcVcZGTXwIjyoJeF9crqkbYTiSmYo7+h6D1DCSR1CWG2FyDqTc2gVRixdP6U8kupU0MHjR391R93Uy5NJNlCGd+chs7KgqNs8GK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730495896; c=relaxed/simple;
	bh=IjlLFEUYu2zjf+fcVluS0a24eBoaE0MG36505ysGUqk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JrwW4aJPjbBMdniutQHFM34DZMbUQQFjt/1BgEa7s7ZMStuAXmNaz8mftb0uO5aOKKmhqbFMvB8bC5VFJdWj/lmGbaWYN6/gXBUZ7vYbgzAa89Ix8salhmQ80BGalQ5TZzLl57mRjEoBAv1xoTUSIyAw0wyJV4Nczp4fGj5OEa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4IG2Lsf; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4IG2Lsf"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20c94f450c7so31022185ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Nov 2024 14:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730495894; x=1731100694; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZTH0w/ifPPJsyd/kMb3fQD+p1V9r2cvzE6mOf+DuGg=;
        b=d4IG2LsfbsrmJG+3ThkXP2uhwrRlRQPF/hi4yeBN/U2miggx6AODiRzuYsDTaS3lID
         UvSZ3auf4V3cLtii1TB8RKgEIiDzwQbfHxEDsRS9UyBzH0rVCeGapgK/l0FMJFq+t/Gx
         0EY9LaSJqt6O3M5+wBlAe0WQkibaqnhB4WKajc0Aq7kV4tiBeJb5s11QDzYWjT3Cz5ge
         w69evJGrD5YsGN4nZdtX+5khZZUkbKAaMJ+3CQ0waK38R/hHKTE4/nSVMXvdQvp1m9HG
         WgIWmV6FLFTV0f86sPKmQpRxt/m12Gdwg7odT2dPJ/Xj/uEBIPxzFja9Pdl655kbILib
         hCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730495894; x=1731100694;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZTH0w/ifPPJsyd/kMb3fQD+p1V9r2cvzE6mOf+DuGg=;
        b=q7jSiC8z9ggic1BfCD/iZplWxOIrVUhQpjkBT79/QlePVgrM1Yxx9g9hF4h5JKgE2/
         WWRbsJasO7gYtTKmbrRv9TRTNxZMEpK7MRVRFTMZpjBFySbAD123wmoCmEAVDmm/8hI6
         gyqHAv0dZ/cUbkJaWNteZwOfldD0SGHLFrOuB8iWoGnAYhEJIxktTkYR7IgSVpYZ3YFZ
         2sR0710ftPVyFh9OedaEH4ojj/Aa/aLiEb5OcQmJF+o2YU5zWtxq5McZ7BUK267VCj0F
         Ffd1xQ019fY1buhlyAPXhU/VtBc8lX1oKB29HQzsVILmpOUm4nD9Ewa3Cyf+KjAAJheT
         wqFw==
X-Forwarded-Encrypted: i=1; AJvYcCW6BlCWfl2d6xoGDUk3gjHplEgTnvH923VTOhgYUUkynQqMloqvadYsZQEbZA+dvE6b1C29Viq0DBItzhQLxgCD@vger.kernel.org
X-Gm-Message-State: AOJu0YwwzL8VIlLCi6TNx1hKF0W3DhiyHmoyl/a/MXtJzUct7DFvKPyI
	Ng5AqoAtsRJN7AMcjl3aWbchbI059rqM/K9NbbC13VfjKm1ncpiSPVSjhzptBglsjkC4zxY8rHp
	Avg==
X-Google-Smtp-Source: AGHT+IH8SMMRpwqDbQyjVHL8zK9hCyMKiVkv6uc/MEaeZSiljJNEqIYG7jaEu4cPgFY0YzqebjIY2XPUD1E=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:ce7])
 (user=ctshao job=sendgmr) by 2002:a17:902:f681:b0:20c:6f7e:2cb4 with SMTP id
 d9443c01a7336-210f748d4e6mr1813385ad.1.1730495893790; Fri, 01 Nov 2024
 14:18:13 -0700 (PDT)
Date: Fri,  1 Nov 2024 21:17:57 +0000
In-Reply-To: <20241101211757.824743-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101211757.824743-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101211757.824743-3-ctshao@google.com>
Subject: [PATCH v2 3/3] perf evsel: Find process with busy PMUs for EBUSY
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Chun-Tse Shao <ctshao@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It parses fdinfo with PMU type, comparing with the event which failed to
open, and report the processes causing EBUSY error.

```
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
```
Only perf with intel_pt was reported.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/util/evsel.c | 79 +++++++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9a5b6a6f8d2e5..dfcb801d8921a 100644
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
 			if (!strncmp(path, "anon_inode:[perf_event]", link_size)) {
-				int cmdline_fd;
-				ssize_t cmdline_size;
-
-				scnprintf(path, sizeof(path), "%s/cmdline", proc_entry->d_name);
-				cmdline_fd = openat(dirfd(proc_dir), path, O_RDONLY);
-				if (cmdline_fd == -1)
-					continue;
-				cmdline_size = read(cmdline_fd, path, sizeof(path) - 1);
-				close(cmdline_fd);
-				if (cmdline_size < 0)
+				int fdinfo_fd;
+				ssize_t fdinfo_size;
+				char *line;
+				u32 perf_event_type = INT_MAX;
+
+				/* Let's check the PMU type reserved by this process */
+				scnprintf(path, sizeof(path), "%s/fdinfo/%s",
+					  proc_entry->d_name, fd_entry->d_name);
+				fdinfo_fd = openat(dirfd(proc_dir), path, O_RDONLY);
+				fdinfo_size = read(fdinfo_fd, path, sizeof(path) - 1);
+				if (fdinfo_size < 0)
 					continue;
-				path[cmdline_size] = '\0';
-				for (ssize_t i = 0; i < cmdline_size; i++) {
-					if (path[i] == '\0')
-						path[i] = ' ';
+				path[fdinfo_size] = '\0';
+
+				line = strtok(path, "\n");
+				while (line != NULL) {
+					if (sscanf(line,
+						   "perf_event-attr.type:\t%u",
+						   &perf_event_type) == 1)
+						break;
+					line = strtok(NULL, "\n");
 				}

-				if (printed == 0)
-					printed += scnprintf(msg, size, "Possible processes:\n");
-
-				printed += scnprintf(msg + printed, size - printed,
-						"%s %s\n", proc_entry->d_name, path);
-				break;
+				/* Report the process which reserves the conflicted PMU. */
+				/* If fdinfo does not contain PMU type, report it too. */
+				if (perf_event_type == failed_attr->type ||
+				    perf_event_type == INT_MAX) {
+					int cmdline_fd;
+					ssize_t cmdline_size;
+
+					scnprintf(path, sizeof(path),
+						  "%s/cmdline",
+						  proc_entry->d_name);
+					cmdline_fd = openat(dirfd(proc_dir), path, O_RDONLY);
+					if (cmdline_fd == -1)
+						continue;
+					cmdline_size = read(cmdline_fd, path, sizeof(path) - 1);
+					close(cmdline_fd);
+					if (cmdline_size < 0)
+						continue;
+					path[cmdline_size] = '\0';
+					for (ssize_t i = 0; i < cmdline_size; i++) {
+						if (path[i] == '\0')
+							path[i] = ' ';
+					}
+
+					if (printed == 0)
+						printed += scnprintf(
+							msg, size,
+							"Possible processes:\n");
+
+					printed += scnprintf(msg + printed, size - printed,
+							"%s %s\n", proc_entry->d_name, path);
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
2.47.0.163.g1226f6d8fa-goog

