Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B985C636D7
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Feb 2023 14:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbjBUOHU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Feb 2023 09:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbjBUOHN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Feb 2023 09:07:13 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423A82A6E9;
        Tue, 21 Feb 2023 06:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676988377; bh=Y+XUERfWbYvdyrJk7Q/GnRbFZoY0tQf2LzvIHzC3ksw=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=F17RF+dA56Zv3bEUkJHxAE9Wosv4z4A8vYxzUx/W+WjqrnPdl6v/XQxbs9aa/vqj+
         TiJRoX+hC1bVBbXY9NZy3fv+JO0LgiH6B6lI4LHmQK+KtyGvyAe5IBdwoP0hqjMZFP
         0l2BQ9sPWZiLUgZ+fozEBTDVTam3OtNtMQuV9cew=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue, 21 Feb 2023 15:06:17 +0100 (CET)
X-EA-Auth: 95DtqBesPNbKd/UFYwNt3POXip0FA5AK5PntGkqZtIczCGt05/c6pRtMPqXs2vqAWFmQxIyOke3sqQheAG3bRVAQoY/z9TZH
Date:   Tue, 21 Feb 2023 19:36:12 +0530
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
Subject: [PATCH v2 1/3] perf/x86/core: Use sysfs_emit() in show() callback
 function
Message-ID: <719558b8a435a6f942b2cc3f5c0431212be76bc6.1676987821.git.drv@mailo.com>
References: <cover.1676987821.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1676987821.git.drv@mailo.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

As per C99 standard, snprintf() returns the number of bytes that would
be encoded in the destination buffer when it is sufficiently large. This
return value may be different from what the caller is expecting and hence
may lead to potential errors in the program.
Kernel release 2.6.2 introduced scnprintf() & vscnprintf() which precisely
return the actual bytes encoded into the destination buffer.

For the sysfs attribute show() callback functions, which returns the number
of bytes to the user space, a more recent recommendation is to use
sysfs_emit() or sysfs_emit_at() instead of sprintf() family of functions.
This is recorded in the Documentation/filesystems/sysfs.rst Kernel
documentation file.

Issue identified using the coccinelle device_attr_show.cocci script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Changes in v2:
   - Revise patch log message to include details on the potential issues with
     current implementation and how the proposal is a better solution.
     Feedback provided by Peter Zijlstra <peterz@infradead.org>

 arch/x86/events/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 85a63a41c471..27c03e6dcb5d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1896,9 +1896,7 @@ ssize_t events_hybrid_sysfs_show(struct device *dev,
 		if (x86_pmu.hybrid_pmu[i].cpu_type & pmu->cpu_type) {
 			next_str = strchr(str, ';');
 			if (next_str)
-				return snprintf(page, next_str - str + 1, "%s", str);
-			else
-				return sprintf(page, "%s", str);
+				return sysfs_emit(page, "%s", str);
 		}
 		str = strchr(str, ';');
 		str++;
@@ -2544,7 +2542,7 @@ static ssize_t get_attr_rdpmc(struct device *cdev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	return snprintf(buf, 40, "%d\n", x86_pmu.attr_rdpmc);
+	return sysfs_emit(buf, "%d\n", x86_pmu.attr_rdpmc);
 }
 
 static ssize_t set_attr_rdpmc(struct device *cdev,
@@ -2602,7 +2600,7 @@ static ssize_t max_precise_show(struct device *cdev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu_max_precise());
+	return sysfs_emit(buf, "%d\n", x86_pmu_max_precise());
 }
 
 static DEVICE_ATTR_RO(max_precise);
-- 
2.34.1



