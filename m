Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248BB19922E
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Oct 2024 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730414401; cv=none; b=YjKPSFsR2u5fu5LP4T879HrQhjd12hdemKtOM9cqx29b+dXmval/YLW9Sde/VngYCYChKg3nHqVPCxgd6RU1l6lXSPe1b4ys9/Y1f6sdXDn08hpMEB5Ti4/95gwAv8UairBwcdOoQqr9RDAClGoIRYw8YOEI2ZyxKLHBYO7xlpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730414401; c=relaxed/simple;
	bh=GUzGbrHWB5mVpuujsPRSEUbl4D4r8eQq3oJIcZ5G0OY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lIM6VmGy2disaHazNHcBlij8cBliKCcTK/56UTW+dIJr8fPTUDtBeNHj6SLmBJ2A80K1FmsEGZsFMRD2FHh33mBX3CTjLQzFZTdJ/thg54i0Ve6FtBX+z8kl1Z9wrSjQJmAhZtChKcjKGCuUtm44aJ9/lCv9mX0whU51VGBy5ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j73wEks+; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j73wEks+"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7cbe272efa6so1606749a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Oct 2024 15:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730414395; x=1731019195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VmHPXqbr+V94Cj75rx8E20Ytlg71UGBeuyaaieI1cEM=;
        b=j73wEks+qscxPko56LJSfLJBVYQbhfAK0TMiK9K6ayQLHaut7TvZ6kD+/J5N2Jn7JM
         XnGVaR81DzLg+BOYLTxhCZvptddLndHKi/nrBbRKgaqTt0gMQOwB2bT46/N4XCYFg0cX
         HRSEBRQVtTdr9kElbHy4tF50m/Hv4GaNwmGcTPNRJomlwk2kAveqZBijC82qbnhVa9rC
         TSbpFe8s1V4xXu3D9FRnTWUyKuy7Jov4zmBsBmh2MQ95RMyJ9UU60mBXtB/NyVoFJknB
         2yTVG75kJd9dLOz74fmoqSsaE6g/39Zk4ptrA5RZ7ybJkxmRFE4C0QUcnv0t7Vnec7xC
         EPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730414395; x=1731019195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VmHPXqbr+V94Cj75rx8E20Ytlg71UGBeuyaaieI1cEM=;
        b=vPPBdQ85VMeCYMqLrQQc9CqMxk/5DRCabDwsyg72AuqbXaNOolfbc1QDWUsn+2KcNt
         urXZ8+JUzx932MrjSiD2hA/0I6S4cokWr3XNL+kw7L/KWkDNW0gD6XpAA7BIsWwz5rhC
         TCy7lYweA/1x/KLtxwm20cny8BmqSAYg3IY0jSSleif5FWLKck7r+tqWtkXlSQpOnZKF
         c0nD/p0JXR8NpsBUi8nj/+XbCVoGwHbqXLmFwmB7+BRt1mE/w6yGz9izH71pR65Dg3qJ
         6soqjR888ovoPquvkE7nRvnu97gYZEKF7wakM/zMHGJFRg7FDnL0leM4V2tTZTcdK4s4
         G3/g==
X-Forwarded-Encrypted: i=1; AJvYcCWUlTUpJJ5DTkoNX9qGBKd9W/+vHeZYjL6sKehXJ2V4tBu2G04wbFs/hEsY9BE+qPAIFAE8OQ3fVChUx9GPoJzK@vger.kernel.org
X-Gm-Message-State: AOJu0YwS31MzxMDzlrQb+NF3zoK0QC4THoi3Fqr5B6Un5fYWNK2jph6v
	TrXT8BL5pWl6uU6mYZiXtSuJ/xgBR2d5Jj0iYbeycXrZEblCliGSCnBsypI5jAEPi9U50RHk/eQ
	OgQ==
X-Google-Smtp-Source: AGHT+IHcwCE9yLFtMhUPOaOa7htLJB9lwLWpIrFC+ZH3Cz7gR1rZQXoHcrxLR5iE/JVP7KGgtKOn1yVdytQ=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:ce7])
 (user=ctshao job=sendgmr) by 2002:a17:902:fa07:b0:20c:8dff:b4f9 with SMTP id
 d9443c01a7336-210f74d6e36mr398135ad.4.1730414395507; Thu, 31 Oct 2024
 15:39:55 -0700 (PDT)
Date: Thu, 31 Oct 2024 22:39:45 +0000
In-Reply-To: <20241031223948.4179222-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031223948.4179222-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241031223948.4179222-3-ctshao@google.com>
Subject: [PATCH 3/3] perf evsel: Find process with busy PMUs for EBUSY
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
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
index 9a5b6a6f8d2e5..d2f7c19e023ec 100644
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
+				u32 perf_event_type = PERF_TYPE_MAX;
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
+				    perf_event_type == PERF_TYPE_MAX) {
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

