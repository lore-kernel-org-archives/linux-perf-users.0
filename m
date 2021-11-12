Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32526C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 07:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0824D60F26
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 07:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhKLHsV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Nov 2021 02:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbhKLHsU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Nov 2021 02:48:20 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC44C06127A
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 23:45:30 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w5-20020a25ac05000000b005c55592df4dso13265358ybi.12
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 23:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lBk8dGY4hFJkFmSHmPRQmSxy6IAflxMTO27FP9s8b+w=;
        b=OTwDuIdL8CRDE4t/A+7voiAtQtDhuLkEOav8gVsu8YQHJpcmQjg0Ymj0XLxITAEx61
         +gIHzmRepKXd2Dmvxfl/Zir6uirlc/VRoo/FDs7lO28ZaX0USpBUrQ6l6RYKJ4iDiABi
         v5PE/XDJVDlmtX+dc6uns0KL44Efq9VxexECohoyGKWK0qqvDmXpb+5rBpxUMduEdWIf
         zUdn+AIr/KNU36T26BKIWbMNu/bmR5nu/LNHXKMncamGUszfd+NSjK0z+evloDdt3Bmc
         Nxqzm3hE9iWqencUaWPWHFEcdA8bXX3ZCrtnB8NDQvW75NpcNsjpTFEM172C1hT5vWxf
         +8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lBk8dGY4hFJkFmSHmPRQmSxy6IAflxMTO27FP9s8b+w=;
        b=lfKiGEQ8b7Zd6b21xDba1szHL4W4uobwF1Qn1dxDj8CYzrsoKXeQHasgEXYFTDjx4f
         v7ZuSf8RHmA+dmf/bVHG79/ZBQB/KQw9YL8Xq6roBuMhzq6Mqfh3EuCIansPq/2PQ8Ms
         8YUdVaqkmnJtFz3gxEz1JD12r4imVVlrDGKE2WNUcTtORqDNuw/ppANIfMCxsEw1HtoR
         KG2ARW4dvmVIBI2jeeoSSvjI86qkcm3Xxn+J1E4QwpXg45+TDaESaHJP3wLcgaJQkxQX
         JE6NkQp61remHOpUzUrbP7kHM7UtlRw1V51YsxNsKJbD7+WE6UkMJgVt4zUW/5O8hHta
         M2Lg==
X-Gm-Message-State: AOAM533Ss8hvsuCDxUdfJmK3IiU6j2IAaxD4yw2EisU7hKp1dNQCKKdN
        rtuECDyPNfSdjkHcaRQq/L0r+NHjYJTj
X-Google-Smtp-Source: ABdhPJyzg/K2BXrzWNNCTEC82Wr4M/VaVTvD03vyOuSvcRJzqozFC7v08rJvrUrHF/y+btADRBPrseTPWBF5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:5ce9:74ca:7ed9:75f2])
 (user=irogers job=sendgmr) by 2002:a25:3341:: with SMTP id
 z62mr14319876ybz.101.1636703129304; Thu, 11 Nov 2021 23:45:29 -0800 (PST)
Date:   Thu, 11 Nov 2021 23:45:25 -0800
Message-Id: <20211112074525.121633-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v2] perf bpf: Avoid memory leak from perf_env__insert_btf
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-perf-users@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf_env__insert_btf doesn't insert if a duplicate btf id is
encountered and this causes a memory leak. Modify the function to return
a success/error value and then free the memory if insertion didn't
happen.

v2. Adds a return -1 when the insertion error occurs in
    perf_env__fetch_btf. This doesn't affect anything as the result is
    never checked.

Fixes: 3792cb2ff43b ("perf bpf: Save BTF in a rbtree in perf_env")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-event.c | 6 +++++-
 tools/perf/util/env.c       | 5 ++++-
 tools/perf/util/env.h       | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 4d3b4cdce176..d49cdff8fb39 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -119,7 +119,11 @@ static int perf_env__fetch_btf(struct perf_env *env,
 	node->data_size = data_size;
 	memcpy(node->data, data, data_size);
 
-	perf_env__insert_btf(env, node);
+	if (!perf_env__insert_btf(env, node)) {
+		/* Insertion failed because of a duplicate. */
+		free(node);
+		return -1;
+	}
 	return 0;
 }
 
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 17f1dd0680b4..b9904896eb97 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -75,12 +75,13 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 	return node;
 }
 
-void perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
+bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
 {
 	struct rb_node *parent = NULL;
 	__u32 btf_id = btf_node->id;
 	struct btf_node *node;
 	struct rb_node **p;
+	bool ret = true;
 
 	down_write(&env->bpf_progs.lock);
 	p = &env->bpf_progs.btfs.rb_node;
@@ -94,6 +95,7 @@ void perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
 			p = &(*p)->rb_right;
 		} else {
 			pr_debug("duplicated btf %u\n", btf_id);
+			ret = false;
 			goto out;
 		}
 	}
@@ -103,6 +105,7 @@ void perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
 	env->bpf_progs.btfs_cnt++;
 out:
 	up_write(&env->bpf_progs.lock);
+	return ret;
 }
 
 struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 1383876f72b3..163e5ec503a2 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -167,7 +167,7 @@ void perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node);
 struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 							__u32 prog_id);
-void perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
+bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
 struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
 
 int perf_env__numa_node(struct perf_env *env, int cpu);
-- 
2.34.0.rc1.387.gb447b232ab-goog

