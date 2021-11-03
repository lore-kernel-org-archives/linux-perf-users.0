Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE52C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Nov 2021 09:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BDE661073
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Nov 2021 09:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhKCJUC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Nov 2021 05:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhKCJUC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 Nov 2021 05:20:02 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18469C061714;
        Wed,  3 Nov 2021 02:17:26 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gt5so847647pjb.1;
        Wed, 03 Nov 2021 02:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3aDTcyLaxlTzmld97lRKtg8oGlo6vYz73kceJptCCyg=;
        b=meXBYcAiuUATe1TchsOkL+iwWGF4ZhfPlpPyx2mL0tbJ0kc2ItO128v1H68+26QmC/
         GtA90sX/kENmd3CgrXitRqK5AbOhSJUS+TFyxV5Qr8CfwfAc9Dqc618h48hUTZtQ94QP
         brIaD2hshMz5BOEcFxexpcL93rWF3dG8HZqcin42PvJE3dojownEjfXdBOAxcc1TIQY1
         hoVVx++YcGVIz5iuc/IXSrIytYWZ/EE24TD/1Myq4y+k7GF6crtExBLI9dBZzVW+XRkJ
         48dtGK1U1Gt5CM6+HtB+1jvOTylYXvHSKQcJzxGtr8axwSXKytWov/biJoE67V5U/Y2o
         rWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3aDTcyLaxlTzmld97lRKtg8oGlo6vYz73kceJptCCyg=;
        b=GfVJnW0icl0ncDT4UD4kbJ/rMLXJkbWaQB39x1aXTALzQY3rR0sTVJmYs6qcoAtYVx
         jmFKEMBTSdL4uKjwvzt5PGsoxuNkiYXRw12GF4wgMJG6qFLhy4ql0i/1gSjPszrr9hV0
         tjD87teqjptbajtEyJtCEsYffjKbUXz5nBZ3N8AXrYvGUSOG/sWsxZb5TBtT+3LsmWPM
         FCuEH+YekwwcXZiFD7vZiYB7fyxFEq24U4m0y/7t/arisslFjpHASML3kSvYpn69Eu28
         /qzCC4i8dafDyqstRbfkAW5lDKiboGJx4uNMCugUNp/Vt+5sjrUTh9ECUjhukdeAGiqb
         M5EA==
X-Gm-Message-State: AOAM531QKb4w7yfVXmZn43YIN2aEhojg9ARECEeoBteUkWbnoww8tkCs
        wFHEE3jYntw5SAshkVC248E=
X-Google-Smtp-Source: ABdhPJy5Y4eqSoHCTp9Yr5lITYqTGJdx9GDsuD5XscDdnqm4uxCTHCk4L9+ORn6rJ+EqHTo72hsN1Q==
X-Received: by 2002:a17:90a:e613:: with SMTP id j19mr13309561pjy.182.1635931045671;
        Wed, 03 Nov 2021 02:17:25 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id m3sm1891037pfk.190.2021.11.03.02.17.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Nov 2021 02:17:24 -0700 (PDT)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/vlbr: Add c->flags to vlbr event constraints
Date:   Wed,  3 Nov 2021 17:17:16 +0800
Message-Id: <20211103091716.59906-1-likexu@tencent.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Like Xu <likexu@tencent.com>

Just like what we do in the x86_get_event_constraints(), the
PERF_X86_EVENT_LBR_SELECT flag should also be propagated
to event->hw.flags so that the host lbr driver can save/restore
MSR_LBR_SELECT for the special vlbr event created by KVM or BPF.

Reported-by: Wanpeng Li <wanpengli@tencent.com>
Fixes: 097e4311cda9 ("perf/x86: Add constraint to create guest LBR event without hw counter")
Signed-off-by: Like Xu <likexu@tencent.com>
---
 arch/x86/events/intel/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7011e87be6d0..30b5d1b3cb03 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2997,8 +2997,10 @@ intel_vlbr_constraints(struct perf_event *event)
 {
 	struct event_constraint *c = &vlbr_constraint;
 
-	if (unlikely(constraint_match(c, event->hw.config)))
+	if (unlikely(constraint_match(c, event->hw.config))) {
+		event->hw.flags |= c->flags;
 		return c;
+	}
 
 	return NULL;
 }
-- 
2.33.0

