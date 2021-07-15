Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEA3C47E4B
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B4F5613F0
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbhGOQKq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhGOQKn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:10:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868BBC0613DC;
        Thu, 15 Jul 2021 09:07:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u1so8528899wrs.1;
        Thu, 15 Jul 2021 09:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A4HXyy2prW6zIXxOdQTWtyGlQ5vJrf9Gh1RnoG3M4TE=;
        b=hOjSgi7Vfo0CTNeZhpTh5LcivjMxPuzh94gvc5QUZGXEcdgdU6YasESduvqzcNJswu
         Dv8bcKi1VN0G6/Nf4Aly2kn+6XrWMcLbtKubQ/2QaROk7T9XIQFXNnqlUm5aMUUrzKw/
         i+3Im6bGRogP4LH4GLQFloUW6z+OrUVxaxpEb8EMIRVFszg0AnjjePbkWixtMFkyocQK
         8Myrp2IgBPKh7R2xifSyJTc/OzkYMTqasmA1+/JF3kxtf2hEAsBymlJzdC6gTqnc31Kk
         dgzyDnuqtROdfweo/siSMGcgdbl5lVRwYBKIS+JZQfiZioSM97df4BYYoqLIIFQ9CsNg
         GIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A4HXyy2prW6zIXxOdQTWtyGlQ5vJrf9Gh1RnoG3M4TE=;
        b=mVztgDg5W+I0t4m4ZXVfrm7+2IEntPwsKpOXRKaVH/3UpSC2tblMagfZd3Fs5GayRH
         JMdUWui0rpQ5YPhwhlJF+rxAVVUR+MRErQ9kQthPpl6qwQVfQhJ7taHUtKMBWFhAU2VL
         Vlp6I1lITrtHC0PwB3WMZtmC3/NfqQu+rRT850NTyNmT8bxFRObJgqLJygMFEsc2YqGp
         q3vM/7eP4s1K7KTfpuUq/cNbO1WTp3C3edky+92byJLBhbWtadzzX7er8psWXXxcPlZz
         DEYzEtA+1b3cF4xGFZSysMe22R2iYYxL0dzNEj5Ol5+gN1rimUgICHzc1KB1wCLieQtg
         rUBg==
X-Gm-Message-State: AOAM530nDiKqaefEPaMwJRqebTZtIPjrChOWFKRPj2JA47JrRYoB+wMG
        HKxXldXxKg7AWNxT2iJXg70=
X-Google-Smtp-Source: ABdhPJzCdcBPZrIzbAecdPK19H4qXiX6/W1BosY/GCdo8r5gAH3GLzXSjrsq6Ef7TjIwnFEsCpzjpA==
X-Received: by 2002:a5d:408f:: with SMTP id o15mr6646699wrp.342.1626365268082;
        Thu, 15 Jul 2021 09:07:48 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id k13sm7446952wrp.34.2021.07.15.09.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:07:47 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [PATCH 18/20] perf trace: free strings in trace__parse_events_option
Date:   Thu, 15 Jul 2021 18:07:23 +0200
Message-Id: <34d08535b11124106b859790549991abff5a7de8.1626343282.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626343282.git.rickyman7@gmail.com>
References: <cover.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports several memory leaks running the perf test
"88: Check open filename arg using perf trace + vfs_getname".
The fourth of these leaks is related to some strings never being freed
in trace__parse_events_option.

This patch adds the missing frees.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/builtin-trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d9c65d55a9ae7526..4a677f3ff273887a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4659,6 +4659,9 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
 		err = parse_events_option(&o, lists[0], 0);
 	}
 out:
+	free(strace_groups_dir);
+	free(lists[0]);
+	free(lists[1]);
 	if (sep)
 		*sep = ',';
 
-- 
2.31.1

