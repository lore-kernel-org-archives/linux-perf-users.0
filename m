Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30768283FD6;
	Wed,  4 Feb 2026 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215192; cv=none; b=bh3DGAXZg65OuHOLB6Q9uW7Vc0LYq7AJLmrTFMXBlJ66UGJMFXNsgoBi5knbKX4/qnE0oitQf7D0KBviCleW0u7fEEt17v/kzWZXvu0Ko+Q3HUQLtWLTwpaPVwiUP9aI1fzYeaCE9xCesJDuw2e+f43sGdjoRAuN0x6m2f77XnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215192; c=relaxed/simple;
	bh=w6UbffRzifiC6MpckU5knQqr5nJFUuLLtaP4NpFrZuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mgET7+0godE8B8JhDBArSPI5a5NKkNZRcdDjG2A++Vd7Z5JIm9fvYTV5A3xFJJdv6XObvrW4hQQlJgmoa3sxf3RFbq5XOz0Lu41oQCFIo+5vjX6ig6VSo7WL6WhV28R/dD2e+9Do+Koo0GWyltN6kKPDDrb12XRvIH3ETweD5hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB9C7339;
	Wed,  4 Feb 2026 06:26:23 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C73A3F632;
	Wed,  4 Feb 2026 06:26:28 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 04 Feb 2026 14:26:15 +0000
Subject: [PATCH] perf record: Make logs more readable for event open
 failures
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-perf_improve_log_for_open_event_failures-v1-1-150245792810@arm.com>
X-B4-Tracking: v=1; b=H4sIAAZXg2kC/x3NQQrCMBBG4auUWRtIoxT0KiJDbP7UgZqESQ1C6
 d0NLr/NeztVqKDSbdhJ0aRKTh3jaaD55dMCI6GbnHWTdfZiCjSyvIvmBl7zwjEr54LEaEgbRy/
 rR1FNQPBunsbn9Ryo54oiyve/uj+O4weZ3h7begAAAA==
X-Change-ID: 20260204-perf_improve_log_for_open_event_failures-deda2c61b93d
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770215188; l=3693;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=w6UbffRzifiC6MpckU5knQqr5nJFUuLLtaP4NpFrZuk=;
 b=GSnIHo6n6xbLWN4mxEjQzII9bmv0l0EgbUVn8YMV+WNjmGEht2BRtvhiAVgayoGENMjbfyaXx
 JkznAPjwIe3Bs6Alsl46n1HCF1mbQKVEieRgjGTWNBOmz6rqGmSkn6v
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Since commit ee27476fa300 ("perf record: Skip don't fail for events that
don't open"), if a user does not have permission to access a PMU event,
perf reports:

  perf record -e cs_etm// -C 3 -- ls
  Error:
  Failure to open event 'cs_etm//u' on PMU 'cs_etm' which will be removed.
  No fallback found for 'cs_etm//u' for error 13
  Error:
  Failure to open event 'dummy:u' on PMU 'software' which will be removed.
  No fallback found for 'dummy:u' for error 13
  Error:
  Failure to open any events for recording.

The log is not very helpful, as no clear indication of what "error 13"
means or how to address the issue.

This commit restores evsel__open_strerror() to generate a readable error
message and print it out:

  perf record -e cs_etm// -C 3 -- ls
  Error:
  Failure to open event 'cs_etm//' on PMU 'cs_etm' which will be removed.
  Access to performance monitoring and observability operations is limited.
  Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
  access to performance monitoring and observability operations for processes
  without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
  More information can be found at 'Perf events and tool security' document:
  https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
  perf_event_paranoid setting is 1:
    -1: Allow use of (almost) all events by all users
        Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
  >= 0: Disallow raw and ftrace function tracepoint access
  >= 1: Disallow CPU event access
  >= 2: Disallow kernel profiling
  To make the adjusted perf_event_paranoid setting permanent preserve it
  in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
  Error:
  Failure to open event 'dummy:u' on PMU 'software' which will be removed.
  Access to performance monitoring and observability operations is limited.
  Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
  access to performance monitoring and observability operations for processes
  without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
  More information can be found at 'Perf events and tool security' document:
  https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
  perf_event_paranoid setting is 1:
    -1: Allow use of (almost) all events by all users
        Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
  >= 0: Disallow raw and ftrace function tracepoint access
  >= 1: Disallow CPU event access
  >= 2: Disallow kernel profiling
  To make the adjusted perf_event_paranoid setting permanent preserve it
  in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
  Error:
  Failure to open any events for recording.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/builtin-record.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2584d0d8bc820676da60bdf5f59d41371d85a93a..aa8dc3e18190dd7db1ed5e3c7673fde8d5785a26 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1404,6 +1404,7 @@ static int record__open(struct record *rec)
 			}
 #endif
 			if (report_error || verbose > 0) {
+				evsel__open_strerror(pos, &opts->target, errno, msg, sizeof(msg));
 				ui__error("Failure to open event '%s' on PMU '%s' which will be "
 					  "removed.\n%s\n",
 					  evsel__name(pos), evsel__pmu_name(pos), msg);

---
base-commit: 5fd0a1df5d05ad066e5618ccdd3d0fa6cb686c27
change-id: 20260204-perf_improve_log_for_open_event_failures-deda2c61b93d

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

