Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794762F0C43
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764948; cv=none; b=Ueirl3skteKUAhejJRyvKDpjIMVwIT3iNZJYUwFWIS6vI2tnpZhxE8tvQctxw6CQqZqmQW7Hj3AnRKdgzUgeUZRFCyf7EcGCexEesw36iBg87IP5I6aMNp/4+5oVVBRsw36kWs5MwCztyvy8aGI6Lnu4MzlZLUjzsfGyxCQ3V/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764948; c=relaxed/simple;
	bh=EiDVBW76tvLcvcxgrKHMClTLXcXHYkd8R9wEyzxQqCE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=tcpVRso7hKHzuwrU/bezj0WeK72FY/AcHYZ58wF9PNwdZ10NiMR0uoAW/2ZdiM19yI3R1WcFAOzC5QUQLUybyRtzZ/l24fsYGUy4RsFhKsD8D9rujJN4Qz7xgIdOa+GOOUkSjlHSJqn9t4ZWDn9YMOJhXI/RI+wIX+XK0miVQSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VNLDk0r9; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNLDk0r9"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3510c0cfc7so686834a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 08:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752764947; x=1753369747; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MIXUDuq7ovshxxSYABdfkB3392ffxtbOzDMl2+dJvEY=;
        b=VNLDk0r9FCqWv9fvO3zXgcTQhP8UOyAhz9oNz0xd6mBw6f2MhRUoEcyh9oXkvlG/ff
         K/ASBXBCZN6+LilCOZupZ3jnjfGR+tbEDt1EhSX8ZMgiCnZqB4hDWIwWDn0mQRgigT0L
         MgNbfp6aLtqyWb2+a2Dk0tVxEE8A5ZKqik7FpMIRqzPpwWvQc97Vcbb0Fw0u2Onx0cJz
         RULcBx3TYCCFWSfWMNZTOX6slsG7D+OuLhsnnKhowuqY+iBROjOezSyD8T8yhm961Qri
         q1NKfAVyU6qmhKqIUDy4xMhqL8Epv2nMDPdEMqR1Qz0EDJGfc2jplPiWwoM6HcsQyTOZ
         yfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752764947; x=1753369747;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MIXUDuq7ovshxxSYABdfkB3392ffxtbOzDMl2+dJvEY=;
        b=XPEOWcnL+d4OzUh6W+qiOve/02c56sXK8DBh51+08J1IQ0Di5XjBxZ7Xp0YNp+xqAx
         58R9pRLjyph66fYTdgkZWYGl/MB8P70kga4UaGaQZ5Z7+OtigLMXr7g91V5A6ccDu1jK
         3JOcs9BFzUFouLnIvLzqDWB3teJIO6t9kkKnHzb7Lbl137qdbzTswGdXVaD+coIeEdsk
         Vc54gxtoES6lODTdeV+wMEtwxBCstBjj8uPGWgIF3V9Gn49d59yJIoNxyB1EINSzurtu
         Rj1lnSlJf8YuoLYt9CPCzaAtDMMcETlqOUdTtD07plXM3ef8XX5+5S14B0XX1p7hN7jv
         mmXg==
X-Forwarded-Encrypted: i=1; AJvYcCXmD1928G7beKg2X0QrEt2hU0vBuIIAKIDOX9730TzqmkoOmte0UIpUCa2jiS6ceO3+UJ817Fi7pUSNLWwE1B9n@vger.kernel.org
X-Gm-Message-State: AOJu0YwO42Le6d6pWN/p1zTAdGL6vZZ0HRR8+4uDYOkX8tAJlJRQCn5n
	OvpCJzQvgbuCpgALnI2GGJsWzunc+uEnl6486zxiyD+sqlFVoYMOOEWFHaEvlHOyn1xkBKq8SOw
	qNFCWpAkHcA==
X-Google-Smtp-Source: AGHT+IFL73neqb2Qi4RrByaNIFT61LP8vi6nbcp4FuivM0fh4JTn/cRc9MN7woer2IIWixLA8PMuIsJuPgsE
X-Received: from pjbsp7.prod.google.com ([2002:a17:90b:52c7:b0:311:c197:70a4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5307:b0:311:b3e7:fb38
 with SMTP id 98e67ed59e1d1-31c9e76371bmr11205278a91.19.1752764946725; Thu, 17
 Jul 2025 08:09:06 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:08:53 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717150855.1032526-1-irogers@google.com>
Subject: [PATCH v2 1/3] tools subcmd: Tighten the filename size in check_if_command_finished
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

FILENAME_MAX is often PATH_MAX (4kb), far more than needed for the
/proc path. Make the buffer size sufficient for the maximum integer
plus "/proc/" and "/status" with a '\0' terminator.

Fixes: 5ce42b5de461 ("tools subcmd: Add non-waitpid check_if_command_finished()")
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2: Fix precedence issue reported by the kernel test robot.
---
 tools/lib/subcmd/run-command.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
index 0a764c25c384..b7510f83209a 100644
--- a/tools/lib/subcmd/run-command.c
+++ b/tools/lib/subcmd/run-command.c
@@ -5,6 +5,7 @@
 #include <ctype.h>
 #include <fcntl.h>
 #include <string.h>
+#include <linux/compiler.h>
 #include <linux/string.h>
 #include <errno.h>
 #include <sys/wait.h>
@@ -216,10 +217,20 @@ static int wait_or_whine(struct child_process *cmd, bool block)
 	return result;
 }
 
+/*
+ * Conservative estimate of number of characaters needed to hold an a decoded
+ * integer, assume each 3 bits needs a character byte and plus a possible sign
+ * character.
+ */
+#ifndef is_signed_type
+#define is_signed_type(type) (((type)(-1)) < (type)1)
+#endif
+#define MAX_STRLEN_TYPE(type) (sizeof(type) * 8 / 3 + (is_signed_type(type) ? 1 : 0))
+
 int check_if_command_finished(struct child_process *cmd)
 {
 #ifdef __linux__
-	char filename[FILENAME_MAX + 12];
+	char filename[6 + MAX_STRLEN_TYPE(typeof(cmd->pid)) + 7 + 1];
 	char status_line[256];
 	FILE *status_file;
 
@@ -227,7 +238,7 @@ int check_if_command_finished(struct child_process *cmd)
 	 * Check by reading /proc/<pid>/status as calling waitpid causes
 	 * stdout/stderr to be closed and data lost.
 	 */
-	sprintf(filename, "/proc/%d/status", cmd->pid);
+	sprintf(filename, "/proc/%u/status", cmd->pid);
 	status_file = fopen(filename, "r");
 	if (status_file == NULL) {
 		/* Open failed assume finish_command was called. */
-- 
2.50.0.727.gbf7dc18ff4-goog

