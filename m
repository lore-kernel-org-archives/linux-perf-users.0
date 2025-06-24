Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639BD2EB5D9
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750791822; cv=none; b=Gak0ni0QdtfGE3T2iy3bGIX21jP5DIWg8Hxtfea40tK184y4gPAY3R9qHfVTgA23dGpNH0WHyFEGyC3XMxEMubGMfMKQZii52rZDktw2L1zsrX5Dc58vAmMkk0nkXZENOlMU/Qd1KMpVEmi9yuekZHUqk5o0fxU8/0Vpul/V5c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750791822; c=relaxed/simple;
	bh=Wblp0ohl6IRm7lIeNpyX4alondQblEImOX1Lca1Vayc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PXlONfVQ+/RuK2fhBATAV2RJUF8kaynQClc6ke1ZYdjzilw/x78GNSoDRP01pk+GukmRyNkMTSKGzl4pU2qRHkP95JnfwQl3ok61TvcCVzIJ8dKGSImxhCo8xLRB4RegjXBK5j+6nRY4saE5s2JMx+zgb7kQky9Oo5LrI3VXspU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iWlf1Ghi; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iWlf1Ghi"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748b4d5c045so4450050b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 12:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750791820; x=1751396620; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OvhUhEpt8Wtn+apdV1pw7/FGDr2NOUshwP9osdCowcg=;
        b=iWlf1GhikkN/gqhpMG42XhbqD5VdiEqwvCiIlCDzjt4zMOIp7SeE++xYptoefqX0VI
         mKHC/JzgJs9XyyZY5O5eu1GtwaQRigiD6yKXx/t7+gszNLNzDsSFwpHLEqzBKQPpO3Mj
         62GnZmJzWHIeY6uFudeem9pOil99BXJXlTxrlF6WYYt50mdjOH6M8RE9FXjHXDF3tL7z
         yi6g1hxYkYeDrvWurQ86QeEIjvFCkClAq412RSwB1tx4wvNksRQukM1YSci9I5aza9vI
         3IxqiqUd0fjQ91DrRoiAA8j2X7HhVXr4xyH0aKjzz3awSss/x/aQvr3CSR9nTt2M9AjC
         U9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750791820; x=1751396620;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvhUhEpt8Wtn+apdV1pw7/FGDr2NOUshwP9osdCowcg=;
        b=X0te0eS+6di50DRvrmVrzV+haUSUs7I8sZHqJzHjRUXJtnkmGBb4uDzWXTzwroiS0+
         IxdDOFGw/p2eplBnFhth61X29tvFIA3ZCP6ZYnpJerN3zfWe26TWPHkF+f6Mex5lNJYv
         DE3BIgTOS37BP5upxUSnl+Re192FAepXbHKpGQdXwx/V3pwhwb9c9kQG9ysP3uRmz5mh
         1hPREUblv2gDoRE7YnI8hpNTBVFXsiRo3P319k67p0xhYCrHZOEVLuX6gPsmf/mZYQpY
         m+nAJApRKQIh18fGhl2mcRd9oSkWcKxIc9rZfy8eM2AELApp17qMqTSTIV3knWZ3ycX2
         r3cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVR4NkvT/xZwwf7tBEIXgfq8ebOEnO6F5nWOdagodH3+G4ta6g4MVZyIp/gpkK01EHEd1Zy8486fI6ZK1Bu2RC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+/CROEsnLOOcCQSxPT5WhsOPj139jsAz3W2h9NFKLzsEZUiXx
	HDltXD41riSun9IXzyCX3Mw7N90LVbgOHOgFGwFaPoZ6I7n/JYFswo4o5dUrZbRTMaYv3PlyGct
	VmUvwwab4fQ==
X-Google-Smtp-Source: AGHT+IHXRzxwI/vxMtdvnFS97/XuZM4ViICM7CB3vtBrkVTBTbh4ijqkM8zAUt69HZBcWf2I334trVSs07qB
X-Received: from pfuv1.prod.google.com ([2002:a05:6a00:1481:b0:746:2862:2a2f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:170b:b0:748:f74f:6d27
 with SMTP id d2e1a72fcca58-74ad45e0092mr388115b3a.24.1750791820499; Tue, 24
 Jun 2025 12:03:40 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:03:25 -0700
In-Reply-To: <20250624190326.2038704-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250624190326.2038704-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250624190326.2038704-6-irogers@google.com>
Subject: [PATCH v1 5/5] perf test: In forked mode add check that fds aren't leaked
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a test is forked no file descriptors should be open, however,
parent ones may have been inherited - in particular those of the pipes
of other forked child test processes. Add a loop to clean-up/close
those file descriptors prior to running the test. At the end of the
test assert that no additional file descriptors are present as this
would indicate a file descriptor leak.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 69 +++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 45d3d8b3317a..4061d5d969aa 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -4,6 +4,7 @@
  *
  * Builtin regression testing command: ever growing number of sanity tests
  */
+#include <ctype.h>
 #include <fcntl.h>
 #include <errno.h>
 #include <poll.h>
@@ -155,6 +156,71 @@ static struct test_workload *workloads[] = {
 #define test_suite__for_each_test_case(suite, idx)			\
 	for (idx = 0; (suite)->test_cases && (suite)->test_cases[idx].name != NULL; idx++)
 
+static void close_parent_fds(void)
+{
+	DIR *dir = opendir("/proc/self/fd");
+	struct dirent *ent;
+
+	while ((ent = readdir(dir))) {
+		char *end;
+		long fd;
+
+		if (ent->d_type != DT_LNK)
+			continue;
+
+		if (!isdigit(ent->d_name[0]))
+			continue;
+
+		fd = strtol(ent->d_name, &end, 10);
+		if (*end)
+			continue;
+
+		if (fd <= 3 || fd == dirfd(dir))
+			continue;
+
+		close(fd);
+	}
+	closedir(dir);
+}
+
+static void check_leaks(void)
+{
+	DIR *dir = opendir("/proc/self/fd");
+	struct dirent *ent;
+	int leaks = 0;
+
+	while ((ent = readdir(dir))) {
+		char path[PATH_MAX];
+		char *end;
+		long fd;
+		ssize_t len;
+
+		if (ent->d_type != DT_LNK)
+			continue;
+
+		if (!isdigit(ent->d_name[0]))
+			continue;
+
+		fd = strtol(ent->d_name, &end, 10);
+		if (*end)
+			continue;
+
+		if (fd <= 3 || fd == dirfd(dir))
+			continue;
+
+		leaks++;
+		len = readlinkat(dirfd(dir), ent->d_name, path, sizeof(path));
+		if (len > 0 && (size_t)len < sizeof(path))
+			path[len] = '\0';
+		else
+			strncpy(path, ent->d_name, sizeof(path));
+		pr_err("Leak of file descriptor %s that opened: '%s'\n", ent->d_name, path);
+	}
+	closedir(dir);
+	if (leaks)
+		abort();
+}
+
 static int test_suite__num_test_cases(const struct test_suite *t)
 {
 	int num;
@@ -242,6 +308,8 @@ static int run_test_child(struct child_process *process)
 	struct child_test *child = container_of(process, struct child_test, process);
 	int err;
 
+	close_parent_fds();
+
 	err = sigsetjmp(run_test_jmp_buf, 1);
 	if (err) {
 		fprintf(stderr, "\n---- unexpected signal (%d) ----\n", err);
@@ -257,6 +325,7 @@ static int run_test_child(struct child_process *process)
 	err = test_function(child->test, child->test_case_num)(child->test, child->test_case_num);
 	pr_debug("---- end(%d) ----\n", err);
 
+	check_leaks();
 err_out:
 	fflush(NULL);
 	for (size_t i = 0; i < ARRAY_SIZE(signals); i++)
-- 
2.50.0.714.g196bf9f422-goog

