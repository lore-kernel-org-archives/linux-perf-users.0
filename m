Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42E7C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 11:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80473610F7
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 11:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbhHILP4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 07:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbhHILPz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 07:15:55 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05AEC0613D3
        for <linux-perf-users@vger.kernel.org>; Mon,  9 Aug 2021 04:15:34 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so3478905pjl.4
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Aug 2021 04:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KBSuwCB1b/ChF6VSdcQNyQNSh8bYSwVqW8B8R0ec9VE=;
        b=XsVTG6SWZqv0staKJR3Gu359GOub7QKqJIRyUsfqK/80YS9zetWc9yWsed0K3qzutc
         96BygAEa0ofmhintRfTORNXvmOePzhBGTs4oXadIJNDWf2AVxOUwc4qkjVMWjMpl3Bf2
         IzxsPVbV7CQfZGWgrM4oHmV5BXQ3AtMMaCeJDeLTuGaKhHdaRBawLUCJ/F061tn1v4KW
         fYSrfXfcLTSQa1jh03Nc3fRyJ8IK29QCkOLaonpVw/KXl8FnJjz5YPP0aJr7TrvoECba
         GpTS7WykjQ6KJb0ujzb6qXBcmGoYoaRmiqJD//vvtKxYYfVEeC0JKAhfXnIUBGxSPLUu
         zWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KBSuwCB1b/ChF6VSdcQNyQNSh8bYSwVqW8B8R0ec9VE=;
        b=tdEUaJiqPQNchwySpIkTyWQZetZfxB3B8XJrDnKsE8uFVBDWYMZYfOBYLJCrm4idZn
         gkrA+zk6p1mvJOvscGDgFJqXa8b401qzC4xjQpqlc9gTx015S/IauBcSf9/nMWE/WeWO
         FgIjvm8qpQ4tOL3q4eiKuU6IvP/X4nBmKijPSpDjti04Kv9XXhKqR7iDO0ffxvKqmJG0
         OcjQQ2mDXdH8lWMXEKofVZHmCUPa1RB9+MAY8yIPxzErXyVRVW6+jOptCD61MhI23cPE
         +vfk52TGEkhs4YYrB+fMNGAE8qQtqg7Hfud1SinynGsJGtiGouinuGouoIb5F1lxlYGB
         HoVA==
X-Gm-Message-State: AOAM531FmH90t/3/fV9wmqxVwvNxeJ5/eOuwdyo121Pt8wLMrN3hZmf2
        zGhTnkx6NZRxKrwZ46olM5AiPw==
X-Google-Smtp-Source: ABdhPJx9QY+JW5O/b35K4NFwHIULAeTDOm7xQ2MzU0ph7Vt9O+bA47CDvZ0efP1Z09z2pNZmEnTVbg==
X-Received: by 2002:a65:6205:: with SMTP id d5mr1657482pgv.326.1628507734364;
        Mon, 09 Aug 2021 04:15:34 -0700 (PDT)
Received: from localhost ([210.0.159.74])
        by smtp.gmail.com with ESMTPSA id m24sm22295840pgv.24.2021.08.09.04.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 04:15:33 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>, x86@kernel.org,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 6/9] perf auxtrace: Drop legacy __sync functions
Date:   Mon,  9 Aug 2021 19:14:04 +0800
Message-Id: <20210809111407.596077-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809111407.596077-1-leo.yan@linaro.org>
References: <20210809111407.596077-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The main purpose for using __sync built-in functions is to support
compat mode for 32-bit perf with 64-bit kernel.  But using these
built-in functions might cause potential issues.

__sync functions originally support Intel Itanium processoer [1]
but it cannot promise to support all 32-bit archs.  Now these
functions have become the legacy functions.

Considering __sync functions cannot really fix the 64-bit value
atomicity on 32-bit archs, thus this patch drops __sync functions.

Credits to Peter for detailed analysis.

[1] https://gcc.gnu.org/onlinedocs/gcc/_005f_005fsync-Builtins.html#g_t_005f_005fsync-Builtins

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/auxtrace.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 79227b8864cd..4f9176368134 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -440,12 +440,6 @@ struct auxtrace_cache;
 
 #ifdef HAVE_AUXTRACE_SUPPORT
 
-/*
- * In snapshot mode the mmapped page is read-only which makes using
- * __sync_val_compare_and_swap() problematic.  However, snapshot mode expects
- * the buffer is not updated while the snapshot is made (e.g. Intel PT disables
- * the event) so there is not a race anyway.
- */
 static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
 {
 	struct perf_event_mmap_page *pc = mm->userpg;
@@ -459,11 +453,7 @@ static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
 static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
 {
 	struct perf_event_mmap_page *pc = mm->userpg;
-#if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
 	u64 head = READ_ONCE(pc->aux_head);
-#else
-	u64 head = __sync_val_compare_and_swap(&pc->aux_head, 0, 0);
-#endif
 
 	/* Ensure all reads are done after we read the head */
 	smp_rmb();
@@ -473,19 +463,10 @@ static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
 static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
 {
 	struct perf_event_mmap_page *pc = mm->userpg;
-#if BITS_PER_LONG != 64 && defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
-	u64 old_tail;
-#endif
 
 	/* Ensure all reads are done before we write the tail out */
 	smp_mb();
-#if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
 	WRITE_ONCE(pc->aux_tail, tail);
-#else
-	do {
-		old_tail = __sync_val_compare_and_swap(&pc->aux_tail, 0, 0);
-	} while (!__sync_bool_compare_and_swap(&pc->aux_tail, old_tail, tail));
-#endif
 }
 
 int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
-- 
2.25.1

