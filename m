Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17A31E481
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Oct 2024 22:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730414398; cv=none; b=kuNLTlAipySK4729OLsF2n8EWY0/NoYv3uAUbF1W/N0Md/oL9zw+8fpnt86dj9PbOij0INdWer0rJ1fdh1m+Ae/0FlfFuQO2E96DT8BT07aZMutO1i75ZeP+VC9a2aqyivhXH1h6eQ0RzcqiTUCIzMNxT483LQEkWprMShpNsgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730414398; c=relaxed/simple;
	bh=1K+1EzPZRuDuWAazdL34ULZOOR+K2+dU7Cnwhnj3bHc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tVEZNooc/gQoImEym5xaGNTymcp15i/DKAXwCcjA1JEa49diqdjyep1wAENRyV7QKgrTP4j7VNnlrs+ts7NoS1kVQwGFiHgodGpHQBD4kb2SKS/iqeeUln1c3zJx3ikJxrKeWIGZcnI3DGiWvLTRCUT3upeV3DTrgyJ8j2uNYtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tda9FmCH; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tda9FmCH"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e8641f2a7so1568471b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Oct 2024 15:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730414392; x=1731019192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oWSTQrojMVMrsYh9AlNbCklcB9qjvy1WDWZ7XTJeoJ8=;
        b=Tda9FmCHQADd+90H0/chEtVsoCbEAnKg0M0ML3FlySL7sj6BHFrw6u6i17kgxaCgQx
         9zjNA4Sa96hqSAn+sD97usKHwr64ffrq2BHpZpFClvIBqGxopbmXwK7x6IcAv7ENnasM
         gymEtNOcWtRJScPibe5Of44MB9wElXiy93/CUPh6YlQ9hA7KPSCII7adyaCkzOoxGBbz
         qb4BqPWg6d5ipRMGazmoc1uWc3fyNTIDhU35NVaJ3mBWkYtHu3gIhYecKr+nFiJPYJxa
         kBxbjZAxQlDuwj/BGzXChJ2BPg/yLdEVxKEzm+eLDa2OjjeTrO+iTWSdwJV00qW3VSiJ
         re7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730414392; x=1731019192;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oWSTQrojMVMrsYh9AlNbCklcB9qjvy1WDWZ7XTJeoJ8=;
        b=el9oasS0rKqxYbid5y4bHVKHwfhQ/FZqYwY42gboU+cPBL+xNPb4PgEa/J/VxtECKN
         bE9JUVgcbc8M8b2lo98YK/qGPDpSy32Xhri3+ji1TbQiyVZ5reByBEThuN8QLAGJhOXz
         Id1PpJdew5Es8+IwMrzycz+Ts8qj9k45tFKALnCdT/t6FoNdzwGOW1s3fxs0T02d2Eta
         citrvHGrlkDfXsCnwJPmJe80+AC8Mlry1Mcxj1GtfafCfw0iHZ/rBwH29oPchkPeZLJB
         CecVV2hS3NxWoz0c7WK+aj7UUptzqMfqa0W9RSbm1LaGmfsFn++MyzODqlZFTAsK0cDt
         pNXg==
X-Forwarded-Encrypted: i=1; AJvYcCUsMY1IT7/PDpAb3ofiNKgnnuMKrzb92pYPyUm+N15libDz0fALb0sTh0Yh/cVl7goRHkluAV+cUki7hAma1m+I@vger.kernel.org
X-Gm-Message-State: AOJu0YyMy6BXMEiHgICNfD5keTzxfddi55UDaW0TQqJuGVbYSkjdFdrM
	r/RdKbRxMsBCtm+2xutEHh35pE351Z0QSElPqCPy1HU4jkPk2Xz6XyqcRbecdchL/IbPNrHCnML
	2oQ==
X-Google-Smtp-Source: AGHT+IE1yDy5/ekyNCt0cQuTHC9rjP5gdZ1iZnN2zHSFuCpS1ZZd2YFR1tYEu2/RWRUTfDsD7/TNpoJ0RIA=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:ce7])
 (user=ctshao job=sendgmr) by 2002:aa7:8758:0:b0:71e:5261:b156 with SMTP id
 d2e1a72fcca58-720c98a1a74mr2554b3a.2.1730414391614; Thu, 31 Oct 2024 15:39:51
 -0700 (PDT)
Date: Thu, 31 Oct 2024 22:39:43 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241031223948.4179222-1-ctshao@google.com>
Subject: [PATCH 1/3] perf evsel: Improve the evsel__open_strerror for EBUSY
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

From: Ian Rogers <irogers@google.com>

The existing EBUSY strerror message is:
```
The sys_perf_event_open() syscall returned with 16 (Device or resource busy) for event (intel_bts//).
"dmesg | grep -i perf" may provide additional information.
```
The dmesg won't be useful. What is more useful is knowing what
processes are potentially using the PMU, which some procfs scanning can
reveal. When parallel testing tests/shell/stat_all_pmu.sh this yields:
```
Testing intel_bts//
Error:
The PMU intel_bts counters are busy and in use by another process.
Possible processes:
2585882 perf list
2585902 perf list -j -o /tmp/__perf_test.list_output.json.KF9MY
2585904 perf list
2585911 perf record -e task-clock --filter period > 1 -o /dev/null --quiet true
2585912 perf list
2585915 perf list
2586042 /tmp/perf/perf record -asdg -e cpu-clock -o /tmp/perftool-testsuite_report.dIF/perf_report/perf.data -- sleep 2
2589078 perf record -g -e task-clock:u -o - perf test -w noploop
2589148 /tmp/perf/perf record --control=fifo:control,ack -e cpu-clock -m 1 sleep 10
2589379 perf --buildid-dir /tmp/perf.debug.Umx record --buildid-all -o /tmp/perf.data.YBm /tmp/perf.ex.MD5.ZQW
2589568 perf record -o /tmp/__perf_test.program.mtcZH/perf.data --branch-filter any,save_type,u -- perf test -w brstack
2589649 perf record --per-thread -o /tmp/__perf_test.perf.data.5d3dc perf test -w thloop
2589898 perf record -o /tmp/perf-test-script.BX2b27Dcnj/pp-perf.data --sample-cpu uname
```
Which gets a little closer to finding the issue.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 79 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbf9c8cee3c56..9a5b6a6f8d2e5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3286,6 +3286,78 @@ static bool find_process(const char *name)
 	return ret ? false : true;
 }

+static int dump_perf_event_processes(char *msg, size_t size)
+{
+	DIR *proc_dir;
+	struct dirent *proc_entry;
+	int printed = 0;
+
+	proc_dir = opendir(procfs__mountpoint());
+	if (!proc_dir)
+		return 0;
+
+	/* Walk through the /proc directory. */
+	while ((proc_entry = readdir(proc_dir)) != NULL) {
+		char path[PATH_MAX];
+		DIR *fd_dir;
+		struct dirent *fd_entry;
+		int fd_dir_fd;
+
+		if ((proc_entry->d_type != DT_DIR) ||
+		     !strcmp(".", proc_entry->d_name) ||
+		     !strcmp("..", proc_entry->d_name))
+			continue;
+
+		scnprintf(path, sizeof(path), "%s/fd", proc_entry->d_name);
+		fd_dir_fd = openat(dirfd(proc_dir), path, O_DIRECTORY);
+		if (fd_dir_fd == -1)
+			continue;
+		fd_dir = fdopendir(fd_dir_fd);
+		if (!fd_dir) {
+			close(fd_dir_fd);
+			continue;
+		}
+		while ((fd_entry = readdir(fd_dir)) != NULL) {
+			ssize_t link_size;
+
+			if (fd_entry->d_type != DT_LNK)
+				continue;
+			link_size = readlinkat(fd_dir_fd, fd_entry->d_name, path, sizeof(path));
+			if (link_size < 0)
+				continue;
+			/* Take care as readlink doesn't null terminate the string. */
+			if (!strncmp(path, "anon_inode:[perf_event]", link_size)) {
+				int cmdline_fd;
+				ssize_t cmdline_size;
+
+				scnprintf(path, sizeof(path), "%s/cmdline", proc_entry->d_name);
+				cmdline_fd = openat(dirfd(proc_dir), path, O_RDONLY);
+				if (cmdline_fd == -1)
+					continue;
+				cmdline_size = read(cmdline_fd, path, sizeof(path) - 1);
+				close(cmdline_fd);
+				if (cmdline_size < 0)
+					continue;
+				path[cmdline_size] = '\0';
+				for (ssize_t i = 0; i < cmdline_size; i++) {
+					if (path[i] == '\0')
+						path[i] = ' ';
+				}
+
+				if (printed == 0)
+					printed += scnprintf(msg, size, "Possible processes:\n");
+
+				printed += scnprintf(msg + printed, size - printed,
+						"%s %s\n", proc_entry->d_name, path);
+				break;
+			}
+		}
+		closedir(fd_dir);
+	}
+	closedir(proc_dir);
+	return printed;
+}
+
 int __weak arch_evsel__open_strerror(struct evsel *evsel __maybe_unused,
 				     char *msg __maybe_unused,
 				     size_t size __maybe_unused)
@@ -3319,7 +3391,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			printed += scnprintf(msg, size,
 				"No permission to enable %s event.\n\n", evsel__name(evsel));

-		return scnprintf(msg + printed, size - printed,
+		return printed + scnprintf(msg + printed, size - printed,
 		 "Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open\n"
 		 "access to performance monitoring and observability operations for processes\n"
 		 "without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.\n"
@@ -3382,6 +3454,11 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size,
 	"The PMU counters are busy/taken by another profiler.\n"
 	"We found oprofile daemon running, please stop it and try again.");
+		printed += scnprintf(
+			msg, size,
+			"The PMU %s counters are busy and in use by another process.\n",
+			evsel->pmu ? evsel->pmu->name : "");
+		return printed + dump_perf_event_processes(msg + printed, size - printed);
 		break;
 	case EINVAL:
 		if (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_SIZE && perf_missing_features.code_page_size)
--
2.47.0.163.g1226f6d8fa-goog

