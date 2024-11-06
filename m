Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954692E414
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Nov 2024 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853015; cv=none; b=BwQ2Eyxn1IGO7HgB3+W4L/DsCWgORIVLAeBFwXGDaOIL60Vl7yyaDjXRK1jhD4yWYByL3ANanv7OZIpuzg6E2S+i10Kz4vyV+cd3jjafK9SaEldE4dsxYev1FWrBwQVwwCedg1l4Qebk5HVsGJW1ZJlVwwnx1dzdvzXEHbXEVgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853015; c=relaxed/simple;
	bh=g5UOkC+QOKsPi8rYoWr9DxRcdSXdub4gIgnL6eCiAr8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UxF4C78rHu5OEqLWozeJ71Da9aTnkI1Jd+n8eyF0TEot9Z1F7c/KY+0lJkKQO5zXrj3A5+rSjUbCh59zDqQF5yY88PSqnwm/Q/DKILUEZL9AJtG51zmWnCeiNro1jmxy+6RfG5sOHa/P8VbbfwYgDRyUz/QGC7W274e5pXdY0IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4eUFfcqb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4eUFfcqb"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30cf48435fso10378712276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Nov 2024 16:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730853011; x=1731457811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xBr0xX9gpaT/nqSu7Tbbxob1cCNZEBjFx1fUb7xZh2Q=;
        b=4eUFfcqbutVnrb735XHkrJsIqq0esRfUliXrSPBSKg/wSe69vI4LLCEmkgQ15sO4cR
         sy4eBhEP/Fhab6eU0bQCUfE4qUyFUnMambr0hcgTOQM1/ktBumdXckXu/0SrJRicOpjX
         +McvVKsIRkw8qCGpyHXmGoOlze7RpPBkcvV7HsOQR9xENMJBDhVUeBiamERIfnTGKcuV
         wJGSUVeK5idYUXwyFvA7YKOSlmJVh8ZICWEO/vdiSsSwyC900EVvnR2yzA1xURGLys62
         akYNZH3EoxzNihsfC2v0bfxro31qXpNkcTmIEpICzsLEXYKMTL77U14BJ74VmpD8OuXP
         CciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730853011; x=1731457811;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xBr0xX9gpaT/nqSu7Tbbxob1cCNZEBjFx1fUb7xZh2Q=;
        b=TjaZZ2zH/QzNTchTL601bnhUwLVJn0MUBf09SNPo4/0A8HiOch/A5WRDYMZ/6AqH2t
         p0GJGtXzJbmtprikqTG9EAPiqcS35PcWaiziTE8hzVkvH4kCh+BUPK9pDD75tli8aaSc
         RnCaWzBm4TJII6wYUFtWOtz5IZu1l+kCkgoLkV3qgeo8yu4FHiC4SY47yF278FuQ0bSU
         Ldj/LScqPPlVbOQrc0g9unNc66FP+DiW6BXEoZodmUkOuUlTQJ0s8yozcDnXqJbQP6TY
         4FJcMV+DN1wdynT9bYCuJCoplgHSO/CfDGFW1qutVFK8dyCUpN25SnQxbxoLhvdIVJpo
         vDVA==
X-Forwarded-Encrypted: i=1; AJvYcCUc3kZeeo7rudC7eBMMiwQ8phpZekFr+U2WPgdOSp/CskjQqFIB/Z9YBAfLaMdqDSw4/DlXew04RwERJ9l6SGTV@vger.kernel.org
X-Gm-Message-State: AOJu0YzOw5jrE9D0IKMkgUOC/9XpyAC4gLhPS49UlzeX8oo46N/Qxf+b
	MvluDe7uEt0lQMhr4e0G4nKx/Cx8yHH/TqSoRHUSKZd1qu/NmeCwdZYEl/PeSiDOzJJLDasdGPP
	vSA==
X-Google-Smtp-Source: AGHT+IHEVYrnOIwcKVO6y2sG839Qj5Yb6EUo8qEZcIlOf4OqEj+odepl50hTuQFwpk2TRWJrgHlyArvnYOk=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:ce7])
 (user=ctshao job=sendgmr) by 2002:a25:aa66:0:b0:e29:6e61:3daf with SMTP id
 3f1490d57ef6-e30cf3e6ac7mr15820276.2.1730853010735; Tue, 05 Nov 2024 16:30:10
 -0800 (PST)
Date: Wed,  6 Nov 2024 00:30:05 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241106003007.2112584-1-ctshao@google.com>
Subject: [PATCH v3 1/3] perf evsel: Improve the evsel__open_strerror for EBUSY
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

From: Ian Rogers <irogers@google.com>

The existing EBUSY strerror message is:

  The sys_perf_event_open() syscall returned with 16 (Device or resource busy) for event (intel_bts//).
  "dmesg | grep -i perf" may provide additional information.

The dmesg won't be useful. What is more useful is knowing what
processes are potentially using the PMU, which some procfs scanning can
reveal. When parallel testing tests/shell/stat_all_pmu.sh this yields:

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

Which gets a little closer to finding the issue.

Signed-off-by: Ian Rogers <irogers@google.com>
Change-Id: Ie1ed8688286c44e8f44a35e98fed8be3e2a344df
---
 tools/perf/util/evsel.c | 79 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbf9c8cee3c56..d001ecfa26bf7 100644
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
+		char buf[256];
+		DIR *fd_dir;
+		struct dirent *fd_entry;
+		int fd_dir_fd;
+
+		if (proc_entry->d_type != DT_DIR ||
+		    !isdigit(proc_entry->d_name[0]) ||
+		    strlen(proc_entry->d_name) > sizeof(buf) - 4)
+			continue;
+
+		scnprintf(buf, sizeof(buf), "%s/fd", proc_entry->d_name);
+		fd_dir_fd = openat(dirfd(proc_dir), buf, O_DIRECTORY);
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
+			link_size = readlinkat(fd_dir_fd, fd_entry->d_name, buf, sizeof(buf));
+			if (link_size < 0)
+				continue;
+			/* Take care as readlink doesn't null terminate the string. */
+			if (!strncmp(buf, "anon_inode:[perf_event]", link_size)) {
+				int cmdline_fd;
+				ssize_t cmdline_size;
+
+				scnprintf(buf, sizeof(buf), "%s/cmdline", proc_entry->d_name);
+				cmdline_fd = openat(dirfd(proc_dir), buf, O_RDONLY);
+				if (cmdline_fd == -1)
+					continue;
+				cmdline_size = read(cmdline_fd, buf, sizeof(buf) - 1);
+				close(cmdline_fd);
+				if (cmdline_size < 0)
+					continue;
+				buf[cmdline_size] = '\0';
+				for (ssize_t i = 0; i < cmdline_size; i++) {
+					if (buf[i] == '\0')
+						buf[i] = ' ';
+				}
+
+				if (printed == 0)
+					printed += scnprintf(msg, size, "Possible processes:\n");
+
+				printed += scnprintf(msg + printed, size - printed,
+						"%s %s\n", proc_entry->d_name, buf);
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
2.47.0.199.ga7371fff76-goog

