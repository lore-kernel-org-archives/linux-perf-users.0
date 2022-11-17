Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B20C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Nov 2022 00:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbiKQAoi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Nov 2022 19:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiKQAoY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Nov 2022 19:44:24 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F02211162
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Nov 2022 16:44:23 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-37010fefe48so3609897b3.19
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Nov 2022 16:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jb2+Mv9K/LFDyUH74/vUrjvC69FTheHi2sop9NGNDDg=;
        b=EeToBv2ab/HwHh2BINPuHn/YTQ2BmxkpzXjjH2qCQUMHWSO1DbWb2kPnw6e07uo0um
         dTbxN5qVXQGJfvCPX/U08k0Mpax0CBt8eru/jOX7fRKcajzsrQVvYJ8nlUgXppWC6DZ2
         FFM23sRyf3vSCFRUhwvrp5Hm18g8lfqnuGxmDOTdllrmal2Zn5ZcDqzdutOJs2267nOz
         N3wWUHuKBfpHnSeTJ90B6o8tQMtT0CXzJIH1UUq2r/vDixwvjj6eHnwZgoHtvfRaAnKp
         obEAMNs9S5K9B9TYLrvygObugs3cOHV7a4dvea66GLzVwbrl2F9DKv5NK8auKaqAUE5i
         yCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jb2+Mv9K/LFDyUH74/vUrjvC69FTheHi2sop9NGNDDg=;
        b=fn3j35ROhL1bUPFNbS2jbaxOeiI2+oaDvwQUZg3t6A34xlzNgZztMK2AvUJ88MUuwM
         D51QR6nAZ+bvibuDjJ+cBHjquDRw6v/AlR5JIdzedGd9Cu1dXFKH6otORuBan5TAkEwA
         75jBzUJNGMjcjRK8yhkZBFJhP5BEGC75Wk/Dl41F/CxQasmczwrmcljU55ByN+V+FL1Q
         HdCQhCndR7+siw4FAgR4YA5Yb8IKaZgrrjs/I1naJvOyha3L/LWBjnjMncJO4z+I6B4O
         IkWNUw+92ONFjfU50DgSqE+ZPY+BX9PQ2xEYbgr92NebdUvlE7Gl67CUZGzIu2Z+UwzR
         /HXA==
X-Gm-Message-State: ANoB5pn7n2yWHuhp8ilfAwOrr8ff8HPma0NxGTuGdjbjerS9erjHWVAB
        l8uMgio8nQMffpz7fdUridlnSmPhimRq
X-Google-Smtp-Source: AA0mqf69drmheqtALfnafu9Fr+lV1wALgs9yuFszvYEIzHoEcMU/nXWBcDWIBFJoB37J6GDh+W6eyCqmDML4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c14c:6035:5882:8faa])
 (user=irogers job=sendgmr) by 2002:a81:a116:0:b0:38e:b5bc:e996 with SMTP id
 y22-20020a81a116000000b0038eb5bce996mr1960731ywg.493.1668645862605; Wed, 16
 Nov 2022 16:44:22 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:43:52 -0800
In-Reply-To: <20221117004356.279422-1-irogers@google.com>
Message-Id: <20221117004356.279422-3-irogers@google.com>
Mime-Version: 1.0
References: <20221117004356.279422-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH 2/6] tools lib bpf: Avoid install_headers make warning
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

The perf build makes the install_headers target, however, as there is
no action for this target a warning is always produced of:

make[3]: Nothing to be done for 'install_headers'.

Solve this by adding a display of 'INSTALL libbpf_headers'.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 4c904ef0b47e..7f5f7d2ebe1f 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -255,6 +255,7 @@ $(INSTALL_GEN_HDRS): $(INSTALL_PFX)/%.h: $(OUTPUT)%.h
 		$(call do_install,$<,$(prefix)/include/bpf,644)
 
 install_headers: $(BPF_GENERATED) $(INSTALL_SRC_HDRS) $(INSTALL_GEN_HDRS)
+	$(call QUIET_INSTALL, libbpf_headers)
 
 install_pkgconfig: $(PC_FILE)
 	$(call QUIET_INSTALL, $(PC_FILE)) \
-- 
2.38.1.431.g37b22c650d-goog

