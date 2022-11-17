Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCFFC43219
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Nov 2022 00:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiKQAo5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Nov 2022 19:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbiKQAol (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Nov 2022 19:44:41 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8A330F6C
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Nov 2022 16:44:31 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v189-20020a252fc6000000b006e7396ee2c3so4719ybv.9
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Nov 2022 16:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jvCSVmgPzSHRqmw4ao0rkGS2JaSHBM4HPOCpMgiqjz8=;
        b=W2oWY4rwEM5AaE08aIgnj/PebRcwaX0h1rd2nPnNIKAsZtTyvsHeYUyLOzBKXLYt1g
         YAxqT2SVCT+CK+aN4x2+skH6QY/3HOgKZbGGIm4IFEP4OGJ2kga0C4f6vSRn3iu3Rqbf
         GjDqjMHYEvk+E5Q8NpysMlNoAdbwT9dEVKlsr6SQcSVzbZQFCwupurkDP4M3z+P8YExg
         QRtZb/u7zLory0PamwAn+cBuEas0IRnRp9bpDiWhmt+GAcCifejnya56qpBc+O8WcMMP
         RGDalbNGetu+9dcmZsDYl3s9RMz0/Do59ws+R/4+5OSbljsNmFf1BUZT6EGS/HadENkr
         867g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvCSVmgPzSHRqmw4ao0rkGS2JaSHBM4HPOCpMgiqjz8=;
        b=Ut6SZ+QHfqudZf8ivUEUYComQCJvdo2j8Yra2z2I6dI9d/bfAogBl2kkwjipGfncKC
         nMDhkBi1Y9Z5ykWVD2OghgJ3TtvgGO9c9HbOc8FA3oRef1pDQY0FyJxMyxccRfH6V/ry
         g6rCz3TSUAVkRQfeuNLQJEYFcH0VFZTLwMFwm+xbJA230XQmDIFkY9GYSWP6pvO77Trx
         ks+aLQ1LPugiEpToiE2OCIKfbGeM8oD8ndTVhkhApqeX8yfbRFG7OHa4zH8hb6ystvKp
         ZwAtgP57KjlSRTyaHqNWBaMsPj0iq/kwt7tqlfi4vCCrH5cWvF/wqtUM9iRRns+HTQTx
         76jA==
X-Gm-Message-State: ANoB5plCFrvxr1XQvIDObH+2Z8eSAbkm6NbwcnXb4p3KSyokjLa7mEfV
        6p80GUp3qOqgM8ZFQNHODiC9z6z1q0HW
X-Google-Smtp-Source: AA0mqf4dl6phgEboohJWHjzZMtx4etccfHoNQKn+VYvDhIjIWJyalrS3bM6sZyMhY8keOHUcTSoYEzN2d88W
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c14c:6035:5882:8faa])
 (user=irogers job=sendgmr) by 2002:a81:742:0:b0:38e:7550:171f with SMTP id
 63-20020a810742000000b0038e7550171fmr2191297ywh.466.1668645870526; Wed, 16
 Nov 2022 16:44:30 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:43:53 -0800
In-Reply-To: <20221117004356.279422-1-irogers@google.com>
Message-Id: <20221117004356.279422-4-irogers@google.com>
Mime-Version: 1.0
References: <20221117004356.279422-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH 3/6] tools lib symbol: clean up build output
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Missing @ when building libsymbol. Make the install echo specific to
installing the libsymbol headers.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/symbol/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/symbol/Makefile b/tools/lib/symbol/Makefile
index 4c1d6b53032d..ea8707b3442a 100644
--- a/tools/lib/symbol/Makefile
+++ b/tools/lib/symbol/Makefile
@@ -77,7 +77,7 @@ include $(srctree)/tools/scripts/Makefile.include
 all: fixdep $(LIBFILE)
 
 $(SYMBOL_IN): FORCE
-	$(MAKE) $(build)=libsymbol V=1
+	@$(MAKE) $(build)=libsymbol
 
 $(LIBFILE): $(SYMBOL_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(SYMBOL_IN)
@@ -101,7 +101,7 @@ install_lib: $(LIBFILE)
 		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
 
 install_headers:
-	$(call QUIET_INSTALL, headers) \
+	$(call QUIET_INSTALL, libsymbol_headers) \
 		$(call do_install,kallsyms.h,$(prefix)/include/symbol,644);
 
 install: install_lib install_headers
-- 
2.38.1.431.g37b22c650d-goog

