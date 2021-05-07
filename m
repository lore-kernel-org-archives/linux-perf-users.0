Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4CCC433ED
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 May 2021 20:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0BCC60E08
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 May 2021 20:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhEGU4j (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 7 May 2021 16:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhEGU4i (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 7 May 2021 16:56:38 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ED6C061761
        for <linux-perf-users@vger.kernel.org>; Fri,  7 May 2021 13:55:38 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t4so5894244plc.6
        for <linux-perf-users@vger.kernel.org>; Fri, 07 May 2021 13:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RS/EjsHgy2j7mFScraIl3oqZgCaBEgKPtIpvzQ9p7+0=;
        b=Q3D6AnEJzEWIr8mfGJfRGnN8CZUHh4CM22AZckuJy3ue1qyU7GbOqHoJYvJk658FIV
         PIwH16FhaCaMsDxMWrllp/z2B+1a+8qjKAq6K7oa25WKAM0QfmSbB0EuDtbGNxvGC12Q
         pWNCPy8Xnbv4Iw0QA2flbpsCUPig77kO15HfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RS/EjsHgy2j7mFScraIl3oqZgCaBEgKPtIpvzQ9p7+0=;
        b=U6vMCtZ+qSrW7irZ2Bl7BcrVci4pgso5C+/2z0sd3E2J+74cXBJVpPvSM18v71X38Z
         eNa/6j3S4noNb+hlQv2flAsJIyh6LDzs83mEJFZpzoVQJ9IHKvoQ8vC1LCp4MQseEko0
         eEkVg5U9U6l8pZZOFShGkj7kVwDcs3nhkIhO16bL9nJoFkXfxP+B2JVqxXuhvZB+t0oM
         1KjyZfHJo5Ejhs+OujNVov6tbeGCFAwefL/DziU+4/+hG3xImNXcKAGtR8YGh6ttxSeq
         0phKQDdZAcKiuCgChE7xK4Xk/PQbkBQ9wrvrDoNvTO9xSsGnNbDSYWzdcSA5wu3CSu4h
         zO5w==
X-Gm-Message-State: AOAM531IWiDr/vFZ/ucZqRLxD25AFUWjUjzYg2GVhJpUzRMFJbZhVxIn
        qZaGeizlEh60OBoGpfQYCnp1nQ==
X-Google-Smtp-Source: ABdhPJxBMPTlqJdFwOVdiEk49eJUYiSndvN7M24NaEUSiSvgA7E1HZcYAOXXQ1CBOTR299hI+nHiTQ==
X-Received: by 2002:a17:90a:f2ce:: with SMTP id gt14mr12812551pjb.177.1620420937529;
        Fri, 07 May 2021 13:55:37 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:3c7e:d35:3a19:632f])
        by smtp.gmail.com with ESMTPSA id ge4sm13161565pjb.49.2021.05.07.13.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 13:55:37 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Seth LaForge <sethml@google.com>,
        Ricky Liang <jcliang@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/3] arm64: perf: perf_callchain_user() compat support for clang/non-APCS-gcc-arm
Date:   Fri,  7 May 2021 13:55:11 -0700
Message-Id: <20210507135509.1.I5d969beafa0d7507f1e37fadaa6e4d88d428253d@changeid>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210507205513.640780-1-dianders@chromium.org>
References: <20210507205513.640780-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Up until now the arm32-compat support in perf_callchain_user() made
the assumption that userspace code was compiled with the defunct APCS
(ARM Procedure Call Standard) calling convention. The existing code
also didn't support Thumb at all. Let's add a whole lot more
support. Specifically, we'll now support:

- clang-compiled Thumb userspace code w/ frame pointers.
- clang-compiled ARM userspace code w/ frame pointers.
- gcc-compiled ARM userspace code w/ frame pointers.

We'll also continue to keep supporting the APCS calling convention.

All of the above will be supported automagically. The important
first-order thing to care about is that ARM and Thumb use different
registers for storing the frame pointer. After that, we need to handle
the fact that the compilers don't agree on the format of a stack
frame. Luckily, we can differentiate between all of the different
supported conventions by relying on the simple fact that the stack is
non-executable and the PC is executable. All of the details of how
this is accomplished is described in the copius inline comments
introduced by this patch.

Please note that there is one compiler convention that is explicitly
_NOT_ supported by this patch, primary because it's believed to be
impossible to support without much fancier logic (like unwind
tables). The _UNSUPPORTED_ case is gcc-compiled Thumb userspace code
w/ frame pointers. The frame pointers in gcc-compiled Thumb userspace
code are largely useless for the purposes of crawling the stack. Given
that the primary purpose of frame pointers is to facilitate stack
crawling, it has been asserted that turning on frame pointers in
gcc-compiled Thumb userspace code is 100% useless. For some history,
you can see the gnu bugzilla [1].

Other notes:
- Presumably tracing code that intermixes ARM / Thumb wouldn't work
  amazingly well given the disagreement about which register stores
  the frame pointer. This patch would theoretically support such a
  situation if (and only if) the code creating the frame pointers was
  smart enough to create them correctly. The problem here is that the
  userspace code creating the stack frames would need to look at the
  mode of the caller (ARM vs. thumb) to figure out if it should store
  R11 or R7 as the old FP. I don't believe code does that.
- This patch likely supports intermixing APCS, clang-ARM, and gcc-ARM
  code, though that hasn't been tested.
- Given a limitation in clang, tracing clang code will omit the
  _callers_ of leaf functions. A future patch will attempt to improve
  the situation a little.

This patch has been tested with some toy code. Some details and
history may be able to be found in the Chrome OS bug system [2]. In
general, when testing, I used these commands:
  perf record  -e cycles:u -g -o "${OUT}" -- "${PROG"}
  perf report -i "${OUT}" -g flat

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92172
[2] https://crbug.com/1040659

Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Ricky Liang <jcliang@chromium.org>
Cc: Seth LaForge <sethml@google.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
I carried Nick's review from the downstream review on the Chromium
gerrit. I believe this is what he intended by +1-ing my WIP patch at
<https://crrev.com/c/2877595>.

 arch/arm64/kernel/perf_callchain.c | 311 +++++++++++++++++++++++++----
 1 file changed, 275 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index 88ff471b0bce..e5ce5f7965d1 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -53,49 +53,294 @@ user_backtrace(struct frame_tail __user *tail,
 }
 
 #ifdef CONFIG_COMPAT
-/*
- * The registers we're interested in are at the end of the variable
- * length saved register structure. The fp points at the end of this
- * structure so the address of this struct is:
- * (struct compat_frame_tail *)(xxx->fp)-1
- *
- * This code has been adapted from the ARM OProfile support.
- */
-struct compat_frame_tail {
-	compat_uptr_t	fp; /* a (struct compat_frame_tail *) in compat mode */
-	u32		sp;
-	u32		lr;
-} __attribute__((packed));
 
-static struct compat_frame_tail __user *
-compat_user_backtrace(struct compat_frame_tail __user *tail,
-		      struct perf_callchain_entry_ctx *entry)
+static int compat_user_read(void *dest, u32 user_addr, size_t bytes)
 {
-	struct compat_frame_tail buftail;
+	const u32 __user *addr = compat_ptr(user_addr);
 	unsigned long err;
 
-	/* Also check accessibility of one struct frame_tail beyond */
-	if (!access_ok(tail, sizeof(buftail)))
-		return NULL;
+	if (!access_ok(addr, bytes))
+		return -EACCES;
 
 	pagefault_disable();
-	err = __copy_from_user_inatomic(&buftail, tail, sizeof(buftail));
+	err = __copy_from_user_inatomic(dest, addr, bytes);
 	pagefault_enable();
 
 	if (err)
-		return NULL;
+		return -EACCES;
+
+	return 0;
+}
 
-	perf_callchain_store(entry, buftail.lr);
+static bool compat_is_ptr_executable(u32 ptr, u32 fp)
+{
+	struct vm_area_struct *vma;
 
 	/*
-	 * Frame pointers should strictly progress back up the stack
-	 * (towards higher addresses).
+	 * Fastpath: if what's pointed to by the frame pointer
+	 * is on the same page as the frame pointer (which
+	 * must point to the stack) then it's on the stack too.
 	 */
-	if (tail + 1 >= (struct compat_frame_tail __user *)
-			compat_ptr(buftail.fp))
-		return NULL;
+	if ((ptr & ~0xfff) == (fp & ~0xfff))
+		return false;
 
-	return (struct compat_frame_tail __user *)compat_ptr(buftail.fp) - 1;
+	vma = find_vma(current->active_mm, (unsigned long)compat_ptr(ptr));
+
+	if (!vma)
+		return false;
+
+	return vma->vm_flags & VM_EXEC;
+}
+
+/**
+ * compat_perf_trace_1() - Trace down one stack frame
+ * @fp: Input: the frame pointer to trace at; output: the next frame pointer.
+ * @pc: Input: the program counter at the start; output: the next PC.
+ * @leaf_lr: If this is the first frame, this will have the value from the
+ *           CPU register LR (link register). If this isn't the first frame,
+ *           this will be 0.
+ *
+ * Return: 0 if no error; else an error code
+ */
+static int compat_perf_trace_1(u32 *fp, u32 *pc, u32 leaf_lr)
+{
+	u32 frame_buf[3];
+	u32 before_fp;
+	u32 at_fp;
+	u32 at_at_fp;
+	int err;
+
+	if (*pc & 1) {
+		/*
+		 * Thumb mode.
+		 *
+		 * There are no flags that make frame pointers on gcc-compiled
+		 * thumb code useful. Thus we'll simply assume userspace was
+		 * compiled by clang and hope for the best. On clang things
+		 * look like this:
+		 *
+		 * +-----------+ 0x1000
+		 * |   random  |
+		 * +-----------+ 0x1004
+		 * | old FP    | <--- FP
+		 * +-----------+ 0x1008
+		 * |     LR    |
+		 * +-----------+
+		 * |   random  |
+		 * +-----------+
+		 *
+		 * Note that clang doesn't create frames for leaf functions
+		 * which means the _caller_ of the leaf function will be
+		 * omitted from the crawl. Clang has a flag
+		 * "-mno-omit-leaf-frame-pointer " that's supposed to change
+		 * this behavior but (when I tried it) it didn't seem to work.
+		 * We also won't know for sure if userspace was built with it
+		 * since it presumably adds a bunch of extra overhead.
+		 *
+		 *
+		 * Just for reference, here is what happens when you ask gcc to
+		 * compile in thumb mode with frame pointers. This illustrates
+		 * why ARM should probably remove the following from AAPCS:
+		 *   The AAPCS does not specify where, within a function's
+		 *   stack frame record, the frame chain data structure
+		 *   resides. This permits implementors the freedom to use
+		 *   whatever location will result in the most efficient code
+		 *   needed to establish the frame chain record.
+		 *
+		 * +-----------+ 0x1000
+		 * |   random  | <--- FP
+		 * +-----------+ 0x1004
+		 * |    ...    |
+		 * +-----------+ ???
+		 * |   random  |
+		 * +-----------+ ???
+		 * | old FP    |
+		 * +-----------+ ???
+		 * |     LR    |
+		 * +-----------+
+		 * |   random  |
+		 * +-----------+
+		 */
+		err = compat_user_read(frame_buf, *fp, 8);
+		if (err)
+			return err;
+
+		*fp = frame_buf[0];
+		*pc = frame_buf[1];
+
+		return 0;
+	}
+
+	/*
+	 * ARM mode.
+	 *
+	 * With ARM code we can support 3 options:
+	 * - clang compiled with frame pointers
+	 *     Looks just like the clang thumb style except that we get the
+	 *     initial FP from R11 instead of R7.
+	 *
+	 *     NOTE: the R11 vs. R7 bit will likely change in the future.
+	 *     The 2019Q4 Issue of AAPCS revised the frame pointer to be R11
+	 *     for BOTH ARM and Thumb, as of 2021Q2 no such production
+	 *     compiler implements that change. There are rumors that
+	 *     toolchains may change to match this specification in the future.
+	 *     If/when that happens, we'll probably need a CONFIG option to
+	 *     support userspace code generated by the old compilers.
+	 *
+	 *
+	 * - gcc compiled with frame pointers (non-leaf)
+	 *     +-----------+ 0x1000
+	 *     |   random  |
+	 *     +-----------+ 0x1004
+	 *     | old FP    |
+	 *     +-----------+ 0x1008
+	 *     |     LR    | <--- FP
+	 *     +-----------+
+	 *     |   random  |
+	 *     +-----------+
+	 *
+	 * - gcc compiled with frame pointers (leaf). NOTE LR is in registers
+	 *     +-----------+ 0x1000
+	 *     |   random  |
+	 *     +-----------+ 0x1004
+	 *     | old FP    | <--- FP
+	 *     +-----------+
+	 *     |   random  |
+	 *     +-----------+
+	 *
+	 * - APCS (ARM Procedure Call Standard)
+	 *     +-----------+ 0x1000
+	 *     |   random  |
+	 *     +-----------+ 0x1004
+	 *     | old FP    |
+	 *     +-----------+ 0x1008
+	 *     |     SP    |
+	 *     +-----------+
+	 *     |     LR    |
+	 *     +-----------+
+	 *     |     PC    |  <--- FP
+	 *     +-----------+
+	 *     |   random  |
+	 *     +-----------+
+	 *
+	 * We will autodetect.
+	 */
+
+	/*
+	 * We'll start with reading whatever the FP points directly at. That
+	 * should be valid memory with all 3 supported layouts.
+	 */
+	err = compat_user_read(&at_fp, *fp, 4);
+	if (err)
+		return err;
+
+	/*
+	 * First let's try to identify clang or a gcc leaf function. In both
+	 * cases the FP points directly at the old FP. Frame pointers always
+	 * point to the stack and the stack should never be marked as
+	 * executable. This contrasts to APCS / gcc-non-leaf where FP will
+	 * either point to a PC near the start of the function or a LR, both
+	 * of which must be executable.
+	 */
+	if (!compat_is_ptr_executable(at_fp, *fp)) {
+		/*
+		 * We need to tell the difference between gcc-leaf and clang.
+		 *
+		 * The first clue is to look at "leaf_lr". It will only be
+		 * non-zero on the first call which is the only one that can
+		 * be a leaf. Thus if it's non-zero, we're clang.
+		 *
+		 * If there's a chance we could be in a leaf, look one frame
+		 * up. On gcc that would be a non-leaf FP and would point to
+		 * something executable. If it's non-executable then we're
+		 * clang. If we have any errors, we'll assume clang.
+		 */
+		if (!leaf_lr || compat_user_read(&at_at_fp, at_fp, 4) ||
+		    !compat_is_ptr_executable(at_at_fp, at_fp)) {
+			/* It's clang; we already have new FP so get PC */
+			err = compat_user_read(pc, *fp + 4, 4);
+			if (err)
+				return err;
+
+			*fp = at_fp;
+
+			return 0;
+		}
+
+		/* It's gcc leaf */
+		*pc = leaf_lr;
+		*fp = at_fp;
+		return 0;
+	}
+
+	/* We need to look at one word before to decide APCS / gcc-ARM */
+	err = compat_user_read(&before_fp, *fp - 4, 4);
+	if (err)
+		return err;
+
+	if (!compat_is_ptr_executable(before_fp, *fp)) {
+		/* It's gcc-ARM */
+		*fp = before_fp;
+		*pc = at_fp;
+
+		return 0;
+	}
+
+	/* APCS */
+	err = compat_user_read(frame_buf, *fp - 12, 12);
+	if (err)
+		return err;
+
+	*fp = frame_buf[0];
+	*pc = frame_buf[2];
+
+	return 0;
+}
+
+static void compat_perf_callchain_user(struct perf_callchain_entry_ctx *entry,
+				       struct pt_regs *regs)
+{
+	u32 old_fp = 0;
+	u32 fp;
+	u32 pc;
+	u32 leaf_lr;
+	int err;
+
+	pc = regs->pc;
+	leaf_lr = regs->regs[14];
+
+	/*
+	 * Assuming userspace is compiled with frame pointers then it's in
+	 * R11 for ARM code and R7 for thumb code. If it's thumb mode we'll
+	 * also set the low bit of the PC to match how the PC indicates thumb
+	 * mode when crawling down the stack.
+	 */
+	if (compat_thumb_mode(regs)) {
+		fp = regs->regs[7];
+		pc |= BIT(0);
+	} else {
+		fp = regs->compat_fp;
+	}
+
+	/* Trace as long as we have room and we have a 4-byte aligned FP. */
+	while ((entry->nr < entry->max_stack) && fp && !(fp & 0x3)) {
+		err = compat_perf_trace_1(&fp, &pc, leaf_lr);
+
+		/* Bail out on any type of error */
+		if (err)
+			break;
+
+		/*
+		 * Frame pointers should strictly progress back up the stack
+		 * (towards higher addresses).
+		 */
+		if (fp <= old_fp)
+			break;
+		old_fp = fp;
+		leaf_lr = 0;
+
+		perf_callchain_store(entry, pc & ~BIT(0));
+	}
 }
 #endif /* CONFIG_COMPAT */
 
@@ -121,13 +366,7 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 	} else {
 #ifdef CONFIG_COMPAT
 		/* AARCH32 compat mode */
-		struct compat_frame_tail __user *tail;
-
-		tail = (struct compat_frame_tail __user *)regs->compat_fp - 1;
-
-		while ((entry->nr < entry->max_stack) &&
-			tail && !((unsigned long)tail & 0x3))
-			tail = compat_user_backtrace(tail, entry);
+		compat_perf_callchain_user(entry, regs);
 #endif
 	}
 }
-- 
2.31.1.607.g51e8a6a459-goog

