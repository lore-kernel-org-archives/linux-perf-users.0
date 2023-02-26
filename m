Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BACC6FA8E
	for <linux-perf-users@archiver.kernel.org>; Sun, 26 Feb 2023 17:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBZRaL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 26 Feb 2023 12:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZRaK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 26 Feb 2023 12:30:10 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1CD9EDA;
        Sun, 26 Feb 2023 09:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1677432549; bh=VQmwNmVrAERV0zN52XhLlnOd5K9FjwrR9MXapkDvdkk=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=ST3Bq0j8flgBd6CLSpBJaJp821SJDlonXvm4MC3a9b5kCdeDdGGqsZyPo2YFtTyl9
         30VynAylFQYXRwNiwIRGE0VNjTVtsIpkecjPZXnvrTGkJiuGbOUqVkH4Vypld06aaF
         lOIKLjMJD+PfNxsvS7h8clsJjzHHea1WQ/MviJwA=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 26 Feb 2023 18:29:09 +0100 (CET)
X-EA-Auth: fkael2mfZj+SFGnPYpQJxaRTFt8nbZgb0FI/WJuBiFNB4gmTZwi2/c/B3LBGMFgQsEyabOWooddcVQlQ9viqwd06bM7POPOh
Date:   Sun, 26 Feb 2023 22:59:03 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH v3 0/3] perf/x86: Use sysfs_emit() in show() callback function
Message-ID: <cover.1677431992.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The patch set proposes to replace use of sprintf family function usage for
formatting data to be returned to the user space using show callback functions.

The modified files have the same maintainer list though they correspond to
different drivers. Since its the same, I clubbed these into a patch set. If this
is not correct, I can send in individual driver specific patches.

Changes in v3:
   - For patch 1, an erroneous change proposed was removed.
     Feedback provided by Peter Zijlstra <peterz@infradead.org>
   - No changes for Patch 2 and 3 of the series.

Changes in v2:
   1. Update the patch log message to provide details on the problem associated
      with current implementation and how the proposal is a better solution.
      Feedback provided by Peter Zijlstra <peterz@infradead.org>


Deepak R Varma (3):
  perf/x86/core: Use sysfs_emit() in show() callback function
  perf/x86/intel/pt: Use sysfs_emit() in show() callback function
  perf/x86/intel: Use sysfs_emit() in show() callback function

 arch/x86/events/core.c       | 4 ++--
 arch/x86/events/intel/core.c | 6 +++---
 arch/x86/events/intel/pt.c   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.34.1



