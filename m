Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144F7C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 Jan 2022 22:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbiA0WIX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 Jan 2022 17:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbiA0WIX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 Jan 2022 17:08:23 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49F4C061714
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jan 2022 14:08:22 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id o12so3947425qke.5
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jan 2022 14:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thume-ca.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QkRUWEuFwRyqZcgGLF5sJwI8pKdHqXj5YUQro85YEY=;
        b=SR8erQjGlj+YDrFdaSXpZYghTgkYJUhW0FGZkqbZI6KYyaRLem4hQurYQgG+tTQG5L
         1NykbCiVpzj3hG3dqUsro6iV5t+ykgJTJcyt9bZS8uKElYG9q8T9tFRAzT+G4TtVaBt/
         a2Zt5kz3ISxZW4jwyEX1S51X2PBvCGGzxn1z+mM3zhwAoIs7UDEgRZnTfk7W70TdGQSA
         Pp/U1G4ahAGl42eUu/3LuCCamW7zzGRLMz78aB9eoIhDe71OOSUO1GAEiUXDNG6j6UVP
         TSNhaf0N/sYqqvgHQc2jwPYuDwykUGPayW8nclfGsc0vPmx/kTVVjxM+T/2SoVpvnhm0
         0/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QkRUWEuFwRyqZcgGLF5sJwI8pKdHqXj5YUQro85YEY=;
        b=7b/0FL1K/A3y3KBxqThEL2g0zDZUGifYfJqabxnYvXXJ4wpcG7uS50Se4wyHfkzBd+
         H6o3t2Ux4I9BaMo5pDcyaVaWtEJoSkc37lMMxd8gAavmplwU8p3B2Tj0sTghSkAZKTpa
         ulPl+Q4WROaAk1skhxy012cX8tu+KW+FMUFrhlCh2HLTPNx6AInhyS9mV4PqNyFdtbwW
         RiFp5eNdT3JSqV2gGMPVvY9N5snBAh6+NhyvUMfmAgiiHwgR34cjrMla0dcUmnlGjtHK
         KuInyl4ZMFJq/uMW4E/rsTB8yQIjE9DryBWnaupqkOeaH7t8PK1lFARd8N9VpV9hB9p/
         yVIg==
X-Gm-Message-State: AOAM531lwV1Elkxt9gt8pl7Amr1+WCC0J4btCFvtSCvgkUc1iJE/51yS
        jaEFN6B+lC30RvXOc51sqJ4F
X-Google-Smtp-Source: ABdhPJx8US/vK6QanW6c1TXbbSgJpBYMu9gVGzImssAfGcyX5x52669bvDjHByR7m2HYcMH4aQRB5A==
X-Received: by 2002:a05:620a:4016:: with SMTP id h22mr4162888qko.380.1643321302085;
        Thu, 27 Jan 2022 14:08:22 -0800 (PST)
Received: from localhost.localdomain (cpe-24-193-238-100.nyc.res.rr.com. [24.193.238.100])
        by smtp.googlemail.com with ESMTPSA id o22sm1881848qkl.88.2022.01.27.14.08.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jan 2022 14:08:21 -0800 (PST)
From:   Tristan Hume <tristan@thume.ca>
To:     mingo@kernel.org
Cc:     Tristan Hume <tristan@thume.ca>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/intel/pt: Fix crash with stop filters in single-range mode
Date:   Thu, 27 Jan 2022 17:08:06 -0500
Message-Id: <20220127220806.73664-1-tristan@thume.ca>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a check for !buf->single before calling pt_buffer_region_size in a
place where a missing check can cause a kernel crash.

Fixes a bug introduced by 670638477aede0d7a355ced04b569214aa3feacd,
which added a support for PT single-range output mode. Since that commit
if a PT stop filter range is hit while tracing, the kernel will crash
because of a null pointer dereference in pt_handle_status due to calling
pt_buffer_region_size without a ToPA configured.

The commit which introduced single-range mode guarded almost all uses of
the ToPA buffer variables with checks of the buf->single variable, but
missed the case where tracing was stopped by the PT hardware, which
happens when execution hits a configured stop filter.

Tested that hitting a stop filter while PT recording successfully
records a trace with this patch but crashes without this patch.

Signed-off-by: Tristan Hume <tristan@thume.ca>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/intel/pt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 7f406c14715f..2d33bba9a144 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -897,8 +897,9 @@ static void pt_handle_status(struct pt *pt)
 		 * means we are already losing data; need to let the decoder
 		 * know.
 		 */
-		if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries) ||
-		    buf->output_off == pt_buffer_region_size(buf)) {
+		if (!buf->single &&
+		    (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries) ||
+		     buf->output_off == pt_buffer_region_size(buf))) {
 			perf_aux_output_flag(&pt->handle,
 			                     PERF_AUX_FLAG_TRUNCATED);
 			advance++;
-- 
2.21.1 (Apple Git-122.3)

