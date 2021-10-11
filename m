Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0558C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 23:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2DC560E74
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 23:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbhJKX0z (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Oct 2021 19:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbhJKX0z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Oct 2021 19:26:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68274C06161C
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Oct 2021 16:24:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y16-20020a2586d0000000b005b752db8f97so24958729ybm.18
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Oct 2021 16:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sRMGxf/QWkSIvOyrGEHw7zgVURL6a7pQ1XR3ZP8rEXw=;
        b=nIuAoquaDI/sspmWGoKBMYKBsX//8qBhGRizTZ2/OrijGyzjqxxI/VzNQyWhrt2wOy
         z8g6u8AleH0Te3HuTsgDF+qJA90zmPuA5UzViXa6m+yGkXqiXIh8lQ0nwUMhqsPItPSD
         vhZZCr/DY2EHdQ7RkgnbDFVZf2mQ7U5wG22K6X5ZHkMcyxQ+ENNJZMPdPtIweR65TIXS
         EX5xiWoCTcBSu5O85KuUu/XldqXgFZ634XASi6I8sPIdaUDrIZmeGXAVVHkLUqrhJkVd
         LYsTueAMOYSxn/m2xwha2YxiiwZ92d67o8Tdj/Uf+6sOt705PsC1PqxIcUt/331edW+e
         wipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sRMGxf/QWkSIvOyrGEHw7zgVURL6a7pQ1XR3ZP8rEXw=;
        b=uaPWuPj+6QCgNW7Ygqs2JpWHRm4VRuhFit0PB28yqUwGigXM4aIvMD+mlHCrr2bwtE
         GI+sQwTEQ/3ilzQDly10SqXbnTc3IhT4hIC/4ryk3qT4IKo7BvOx0Po/XP1q0+P3YeU6
         xZLCVWm+n+jU8mBGUINLQtxjAH7JobR3pQ7ETQ0bpLNvAHziFf/nLcxxaIaG1d8kp23R
         O/AedhMIEHABvxxDOE0M6bW5UJac1QdkIxbcATA87VZ23JVeGqwjk8t7ZTRtw8s9xwSP
         5PTWglI/53sNXFfVYQcDeaVmVlcGs8CxAhr7lmxkP0K+F4OWOOcX4L0281/gNJF5rfYB
         0CmQ==
X-Gm-Message-State: AOAM533abJ97U8t6rQHH8i/tZ+enbZBquFFvijNFETMN7zUkYpO64F5h
        FXbStetJqnE4oyYKgJXyADStusN9W9bG
X-Google-Smtp-Source: ABdhPJw2/5rT3Msh74FHXo0z+T9ByKwujBrHptH+dNLegy9iGwKHXiILFzCByVPGFqvMG+qt28mRXoHX1haD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2ad2:cb91:6fbd:a6f2])
 (user=irogers job=sendgmr) by 2002:a25:7383:: with SMTP id
 o125mr24530968ybc.525.1633994693655; Mon, 11 Oct 2021 16:24:53 -0700 (PDT)
Date:   Mon, 11 Oct 2021 16:24:46 -0700
In-Reply-To: <20211011232446.250195-1-irogers@google.com>
Message-Id: <20211011232446.250195-2-irogers@google.com>
Mime-Version: 1.0
References: <20211011232446.250195-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 2/2] perf clang: Fixes for more recent LLVM/clang
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The parameters to two functions and the location of a variable have
changed in more recent LLVM/clang releases.

Tested with LLVM 6, 8, 9, 10 and 11.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/c++/clang.cpp | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
index c8885dfa3667..756200cb80b1 100644
--- a/tools/perf/util/c++/clang.cpp
+++ b/tools/perf/util/c++/clang.cpp
@@ -44,7 +44,6 @@ createCompilerInvocation(llvm::opt::ArgStringList CFlags, StringRef& Path,
 		"-triple", "bpf-pc-linux",
 		"-fsyntax-only",
 		"-ferror-limit", "19",
-		"-fmessage-length", "127",
 		"-O2",
 		"-nostdsysteminc",
 		"-nobuiltininc",
@@ -55,7 +54,11 @@ createCompilerInvocation(llvm::opt::ArgStringList CFlags, StringRef& Path,
 		"-x", "c"};
 
 	CCArgs.append(CFlags.begin(), CFlags.end());
-	CompilerInvocation *CI = tooling::newInvocation(&Diags, CCArgs);
+	CompilerInvocation *CI = tooling::newInvocation(&Diags, CCArgs
+#if CLANG_VERSION_MAJOR >= 11
+                                                        ,/*BinaryName=*/nullptr
+#endif
+                                                        );
 
 	FrontendOptions& Opts = CI->getFrontendOpts();
 	Opts.Inputs.clear();
@@ -151,13 +154,16 @@ getBPFObjectFromModule(llvm::Module *Module)
 
 	legacy::PassManager PM;
 	bool NotAdded;
-#if CLANG_VERSION_MAJOR < 7
-	NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream,
-						      TargetMachine::CGFT_ObjectFile);
+	NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream
+#if CLANG_VERSION_MAJOR >= 7
+                                                      , /*DwoOut=*/nullptr
+#endif
+#if CLANG_VERSION_MAJOR < 10
+                                                      , TargetMachine::CGFT_ObjectFile
 #else
-	NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream, nullptr,
-						      TargetMachine::CGFT_ObjectFile);
+                                                      , llvm::CGFT_ObjectFile
 #endif
+                                                      );
 	if (NotAdded) {
 		llvm::errs() << "TargetMachine can't emit a file of this type\n";
 		return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);
-- 
2.33.0.882.g93a45727a2-goog

