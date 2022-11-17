Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83389C43217
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Nov 2022 00:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbiKQApb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Nov 2022 19:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbiKQApG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Nov 2022 19:45:06 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED0C6C70E
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Nov 2022 16:44:46 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-36ba0287319so4160477b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Nov 2022 16:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tum0QI4JrQbJkTRSnOZKoT24fC5feLZgv7UTX0Fwycw=;
        b=IdE/wkDiulLB7ueEdQuM/Q3TFeYar3AeAQzJco0voawyZfAa6Ww7pCAE9rCOblqlLX
         JQwwyq4Segl8xY26XV6gTQP9e7IiOBkMGK4HzTbjVGzB4ICfzlTfwN8nqPLeP4Zynkcq
         nla27vnlGmJBWYAtsHy/xBNg61w1viGgFqWG9gcg4Y3pnDIgjHtLx7CqwDUs1UDFydq1
         c5pwLx6GXjzJbyRy2b3vJGZRcgsx0z5j0+EDogznEK0ufCSBymLJ5XIXNNXPId3fDejM
         sH0z9bKNgm9rhjUzOBtjA+mQabAURJ81Q6HqsNb3JXtJYBKsde+2S0YxGhf+2FbH8UMF
         //oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tum0QI4JrQbJkTRSnOZKoT24fC5feLZgv7UTX0Fwycw=;
        b=BfE8GWdRVpm3B8ijyGTFYAkjTavOoVWL2SrWOrrPqapEo3kTNyzqic0JxoBnwZYCFb
         X0oHMoRXAp/vRGv+C18SQujZZu6MJnL3504gcQIghBpK52W4HdLZA8YIWV/Tb1psx3FZ
         kWournl807nJArrPf3g4M0DMf0F+gZgG57Q/BJSxMQSOZijgXr1L/HUxe+lu5zLP0kZJ
         NzCPOWDc9AjM+xFCWsk8jLIOTC9N1P20bJRaMMGGZv8K+XwQZbmToNGrc0ve51sTliPO
         ROzoBSyRX6EmpN0CDH53QNYxy9o293Wt8FOELNmbKjT84qrtlbGWYwjbaQByTtphkpGd
         wQ7g==
X-Gm-Message-State: ANoB5pl3SgbPhtJMts6yDqwtUyQLdZgc7xssFt0fWap/rce/KR7nhI3E
        SEJXetsJie5Vd54SIn3KLPFVYuJtiiqG
X-Google-Smtp-Source: AA0mqf6phvU1jt2/Utb9PhvTPZh28JlWMdb5v5Ef3ZlPK4+ioGcalRs4LeyaGCqY7Y6wR4TF9FroWCK1E9eJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c14c:6035:5882:8faa])
 (user=irogers job=sendgmr) by 2002:a0d:efc2:0:b0:368:97e7:8ed1 with SMTP id
 y185-20020a0defc2000000b0036897e78ed1mr24869968ywe.381.1668645885966; Wed, 16
 Nov 2022 16:44:45 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:43:55 -0800
In-Reply-To: <20221117004356.279422-1-irogers@google.com>
Message-Id: <20221117004356.279422-6-irogers@google.com>
Mime-Version: 1.0
References: <20221117004356.279422-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH 5/6] tools lib subcmd: Make install_headers clearer
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

Add libsubcmd to the name so that this install_headers build appears
different to similar targets in different libraries.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index e96566f8991c..9a316d8b89df 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -101,7 +101,7 @@ install_lib: $(LIBFILE)
 		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
 
 install_headers:
-	$(call QUIET_INSTALL, headers) \
+	$(call QUIET_INSTALL, libsubcmd_headers) \
 		$(call do_install,exec-cmd.h,$(prefix)/include/subcmd,644); \
 		$(call do_install,help.h,$(prefix)/include/subcmd,644); \
 		$(call do_install,pager.h,$(prefix)/include/subcmd,644); \
-- 
2.38.1.431.g37b22c650d-goog

