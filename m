Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1E2F2910;
	Fri, 13 Mar 2026 07:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773386705; cv=none; b=mDPGkysnGYKG9nNyc53rIEEGE2TULv4ZfZ340OudM6M9TJjYng9H0aCYIqZaS96q1CLbdire67hvK19xcxJtAYD3MI1V4Xy8qwniZg5CqvA53B0kGCx9Ked2UtjCYnAl2eBUZ8IXRytLVkT4nzZwKe3vWFpxZJBKROKJCMw7joA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773386705; c=relaxed/simple;
	bh=qouxEiswCBlnkXnxKpo27QXTLnwlm+Y09KDiZGno91A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRTxcMlCbdJjSzyBpdfRVXVaAzO4aao17h4hSXWdmIYTeTHmXh/jYVAmVz1X5Vrl4hXjhozW+nTxyqRQRFkiQGBA5D6utN7EaH+dfrGPsF1z4j3UxDeAC4EKr3sPT30Wz2wgSEsITwraxgd0/+SdbKUdjvrmMJZaCSfORuUoVs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Q9lLWbgg; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Q9lLWbgg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773386695; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SFNGqMAcVEb6zBedf1eJyk9gX4L0aK/UkDtXrxLmc1I=;
	b=Q9lLWbggUiikxzYQSEb/H5ETrnS2v1vFWuwUtRpe1Tj3KN3hSXI59+Z7+R3TLm/gyH8OcnocJbb6SvB8hahNpELUJxX5QPnQJXwGfr2zFVBddox6cJSDOK5js5R6y8i7WWmnFAV8zqibQmV/xsuZCj27WY+cE8ICqpzpFJos7gw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X-rVy-C_1773386686;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X-rVy-C_1773386686 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Mar 2026 15:24:55 +0800
From: cp0613@linux.alibaba.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	guoren@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH] perf build: Avoid argument list too long in orphan pruning
Date: Fri, 13 Mar 2026 15:24:31 +0800
Message-ID: <20260313072431.584-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

When the output directory contains a large number of orphaned files with
deep file paths, directly passing the entire ORPHAN_FILES list to the
execve command will exceed the system's parameter length limit (it should
be MAX_ARG_STRLEN), causing "argument list too long" error during build.
See below:

  make[6]: execvp: /bin/sh: Argument list too long
  make[6]: *** [pmu-events/Build:217: prune_orphans] Error 127
  make[6]: *** Waiting for unfinished jobs....

Fix this by using GNU Make's $(file ...) function to write the orphan file
list to a temporary file, then use xargs to read from the file and remove
the orphan files. The temporary file is deleted after pruning completes.

This method avoids the argument length limitation since $(file ...) writes
directly without spawning a shell process with command-line arguments.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 tools/perf/pmu-events/Build | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 63c65788d442..ec5bf89ddfe1 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -209,12 +209,17 @@ endif
 ifneq ($(strip $(ORPHAN_FILES)),)
 .PHONY: prune_orphans
 
+# Store ORPHAN_FILES in a file to avoid argument list too long errors
+ORPHAN_LIST_FILE := $(OUTPUT)pmu-events/.orphan_list
+$(file >$(ORPHAN_LIST_FILE),$(ORPHAN_FILES))
+
 # Message for $(call echo-cmd,rm). Generally cleaning files isn't part
 # of a build step.
 quiet_cmd_rm  = RM      $^
 
-prune_orphans: $(ORPHAN_FILES)
-	$(Q)$(call echo-cmd,rm)rm -f $^
+prune_orphans: $(ORPHAN_LIST_FILE)
+	$(Q)$(call echo-cmd,rm)cat $^ | xargs rm -f
+	$(Q)rm -f $(ORPHAN_LIST_FILE)
 
 JEVENTS_DEPS += prune_orphans
 endif
-- 
2.50.1

