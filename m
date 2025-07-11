Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43819A920;
	Fri, 11 Jul 2025 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752232239; cv=none; b=M2m9jnWJMcmATsdgoMlsimEPkZJZYhpZhK3eh0HL9dzorfNMSXv+2aEDVgDUddTBlgHe1K4g5V2iCr3EvObLrkhCRYx1FNAhRUSYhWExouir7KhZiSa7D/SIrVbUn++/ell/XMED49VqxrhaZ9iw06O2x08t65VZgSPH9Y8HcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752232239; c=relaxed/simple;
	bh=CgL1+6wjU/0sifUGCXKQs6R8RhsCYq3Lork5T6y6lc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t16gtbVWTYyrt6F/8DeRl5YjY+njIyjqcq+zxEqrgNq7XjQX9AYsK5NKuC3TJQcOVQbCb1HoePyNQO3EQlBgCw8PDJc/t5sb4P3OYxVeDvGzwRqnFre+My4V692qwzO8i2x8hvtn1cAPVTpHklEUAFgt0BeL8XNqaP5ZFyj4b9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F094E106F;
	Fri, 11 Jul 2025 04:10:23 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BCF83F6A8;
	Fri, 11 Jul 2025 04:10:33 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 11 Jul 2025 12:10:15 +0100
Subject: [PATCH] perf tests bp_account: Fix leaked file descriptor
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-perf_fix_breakpoint_accounting-v1-1-b314393023f9@arm.com>
X-B4-Tracking: v=1; b=H4sIABbxcGgC/x2NUQqDMBAFryL7bcCkSKVXKRJi+qKLsAkbWwri3
 Rv6OTDMnFShjEqP7iTFhytnaWD7juIWZIXhV2NygxuHu7WmQJNP/PWLIuwlsxw+xJjfcrCsBuG
 GaXGY0mipRYqiyf/Bc76uH+OITZtwAAAA
X-Change-ID: 20250711-perf_fix_breakpoint_accounting-ea3e8b2e8f51
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Aishwarya TCV <aishwarya.tcv@arm.com>, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752232233; l=1618;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=CgL1+6wjU/0sifUGCXKQs6R8RhsCYq3Lork5T6y6lc8=;
 b=eea71U+Try/OjsPsZvneLdaW7diAp6t5mn53j8K2jpssi5Q5ebRCxHzDNMzMX4c2i12KPWCkD
 8Oh572FW1siBZ2VfskWhkc5IdRCfS6XPh99g0eSOayIoTcsDv+cnQtv
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Since the commit e9846f5ead26 ("perf test: In forked mode add check that
fds aren't leaked"), the test "Breakpoint accounting" reports the error:

  # perf test -vvv "Breakpoint accounting"
  20: Breakpoint accounting:
  --- start ---
  test child forked, pid 373
  failed opening event 0
  failed opening event 0
  watchpoints count 4, breakpoints count 6, has_ioctl 1, share 0
  wp 0 created
  wp 1 created
  wp 2 created
  wp 3 created
  wp 0 modified to bp
  wp max created
  ---- end(0) ----
  Leak of file descriptor 7 that opened: 'anon_inode:[perf_event]'

A watchpoint's file descriptor was not properly released. This patch
fixes the leak.

Fixes: 032db28e5fa3 ("perf tests: Add breakpoint accounting/modify test")
Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/tests/bp_account.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 4cb7d486b5c178c622be4fc7e9c8c5a924df9d9b..047433c977bc9de4f8984268a2a9826d6bfa6f17 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -104,6 +104,7 @@ static int bp_accounting(int wp_cnt, int share)
 		fd_wp = wp_event((void *)&the_var, &attr_new);
 		TEST_ASSERT_VAL("failed to create max wp\n", fd_wp != -1);
 		pr_debug("wp max created\n");
+		close(fd_wp);
 	}
 
 	for (i = 0; i < wp_cnt; i++)

---
base-commit: a62b7a37e6fcf4a675b1548e7c168b96ec836442
change-id: 20250711-perf_fix_breakpoint_accounting-ea3e8b2e8f51

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

