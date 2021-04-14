Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD60DC43460
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Apr 2021 13:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FDBB611B0
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Apr 2021 13:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351196AbhDNNRJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Apr 2021 09:17:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232172AbhDNNRH (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Apr 2021 09:17:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 731B16120E;
        Wed, 14 Apr 2021 13:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618406204;
        bh=7x4SG3KAg2iNOLgXlb3WD0iJVO26sPoNWb3W/yuCPoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PlZOvKrCymTlL3fS+ogEYa1bt2KQXL4YJnTHkuVpdkJLw4+YFuLVr80T59sezRzIJ
         uvk7AehhU7hXiwwDm68QHEa+Nwzqp3TxQUnbv9+19GahRdBezNCS9uVAH7WKFmODTB
         XeAdzFthMKStnu8LvYDvJZcRbK1I7HDzUBpL1NWorTd283DYo5KGgG0zNVoo5q/gBs
         8xWbJU+4lV1akEYUGzXLl6tyD7TxgQa0gfxNuCSDyU7kilhrcSTfQT/aVHN4C9AA76
         va95z5kHVCF7Rq58Mw+hyxVn6bHCUpMtt+SzlkK/3SFPabS94/TP4q/U2S8eWXK6b2
         wskrQMb+30zgw==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 2/2] perf record: Improve 'Workload failed' message printing events + what was exec'ed
Date:   Wed, 14 Apr 2021 10:16:28 -0300
Message-Id: <20210414131628.2064862-3-acme@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210414131628.2064862-1-acme@kernel.org>
References: <20210414131628.2064862-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Before:

  # perf record -a cycles,instructions,cache-misses
  Workload failed: No such file or directory
  #

After:

  # perf record -a cycles,instructions,cache-misses
  Failed to collect 'cycles' for the 'cycles,instructions,cache-misses' workload: No such file or directory
  #

Helps disambiguating other error scenarios:

  # perf record -a -e cycles,instructions,cache-misses bla
  Failed to collect 'cycles,instructions,cache-misses' for the 'bla' workload: No such file or directory
  # perf record -a cycles,instructions,cache-misses sleep 1
  Failed to collect 'cycles' for the 'cycles,instructions,cache-misses' workload: No such file or directory
  #

When all goes well we're back to the usual:

  # perf record -a -e cycles,instructions,cache-misses sleep 1
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 3.151 MB perf.data (21242 samples) ]
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 35465d1db6dda3ae..5fb9665a2ec27dde 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1977,9 +1977,13 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		record__auxtrace_snapshot_exit(rec);
 
 	if (forks && workload_exec_errno) {
-		char msg[STRERR_BUFSIZE];
+		char msg[STRERR_BUFSIZE], strevsels[2048];
 		const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
-		pr_err("Workload failed: %s\n", emsg);
+
+		evlist__scnprintf_evsels(rec->evlist, sizeof(strevsels), strevsels);
+
+		pr_err("Failed to collect '%s' for the '%s' workload: %s\n",
+			strevsels, argv[0], emsg);
 		err = -1;
 		goto out_child;
 	}
-- 
2.26.2

