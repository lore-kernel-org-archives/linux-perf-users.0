Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D69C433F5
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 05:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0FCB60FBF
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 05:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhKFFlI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 Nov 2021 01:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbhKFFlG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 Nov 2021 01:41:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28000C061570
        for <linux-perf-users@vger.kernel.org>; Fri,  5 Nov 2021 22:38:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d9-20020a251d09000000b005c208092922so16827099ybd.20
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Nov 2021 22:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Tg5TDm4qC6UeNIYD0XPbfD7vBlef2Yfxw+Y9xztxVG8=;
        b=nHhROQoUoeOnMhq4hEeheovNulp00BK7oFx1VJZgsESDL929lrKYG4FlANZ7rztXFP
         ckrk+XL0HLlpuEQQswgzHI5MqDi1CxcdUAFCecSs6dl26DkxCeyrEZ368pciaAcfJZpu
         cGmR0ebNjafJw2jhFnFe+u4dZABJtvHtme5dTuIAg1/i5+loxv14hnMyZ6llOtoqxB6M
         xxqhKDl52MBk74WgCzs3BsdX33WSw4AH91hJqNRM11xiliH443qv3PNiaxHRs+9pxGwv
         AfwljPpZ7y0/n0NeCflEdDeXFMXHbf7gfinnNQnN/mTelKaRLh3J/bYwUTgfz3Eo1PbV
         +kYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Tg5TDm4qC6UeNIYD0XPbfD7vBlef2Yfxw+Y9xztxVG8=;
        b=QFgEU8JBu0vu7DNfNclbPsBUZdKMhtJL4Z7W2T14fsmNP4TDJDogtsb81itvD+O3UV
         zYLBdfucGcJkL3iljjsilSscgN8HetZhDwCi3szPBbyIwdx2UmuI0+GjiVze6Lu1nqtt
         1ph9SyB3+4g2pPcxy5qaq0yu0aMqD3h44edwiXcfqgkxlOm+9kYJxJ+r8Ip1M6AfLvm7
         eHixpeOT/VJfSJe+Vt6oq59f65zxBRHSq9DKXfA+ZJmg9p/sWjLlf604wz14/3f6jct4
         tzmCJ/0/cRMJOQ837+2R9uxzrNYHKIb7qe1VXo6vYdwbP+obp6FLqknHnzDiMIcmeY/+
         spgg==
X-Gm-Message-State: AOAM5308wzndCQAS8+VsMq5tJiIe5JyQFqIyAMK6zkLCCZN5bYUBFy0L
        NvQmXQ+q3Hn5YDVyKNbhAWEDbtU23DOz
X-Google-Smtp-Source: ABdhPJz0e8lLlaTt9y6F99fCcNxbjyEhMkd4yUph+qezq9MMmrIQRcEbbYsFONTAtJcldYZzD2XWicIFL44C
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b70b:3e34:63e5:9e95])
 (user=irogers job=sendgmr) by 2002:a25:ae1a:: with SMTP id
 a26mr51521917ybj.70.1636177105344; Fri, 05 Nov 2021 22:38:25 -0700 (PDT)
Date:   Fri,  5 Nov 2021 22:37:33 -0700
In-Reply-To: <20211106053733.3580931-1-irogers@google.com>
Message-Id: <20211106053733.3580931-2-irogers@google.com>
Mime-Version: 1.0
References: <20211106053733.3580931-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 2/2] perf bpf: Add missing free to bpf_event__print_bpf_prog_info
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

If btf__new is called then there needs to be a corresponding btf__free.

Fixes: f8dfeae009ef ("perf bpf: Show more BPF program info in print_bpf_prog_info()")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-event.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 0783b464777a..1f813d8bb946 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -579,7 +579,7 @@ void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
 		synthesize_bpf_prog_name(name, KSYM_NAME_LEN, info, btf, 0);
 		fprintf(fp, "# bpf_prog_info %u: %s addr 0x%llx size %u\n",
 			info->id, name, prog_addrs[0], prog_lens[0]);
-		return;
+		goto out;
 	}
 
 	fprintf(fp, "# bpf_prog_info %u:\n", info->id);
@@ -589,4 +589,6 @@ void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
 		fprintf(fp, "# \tsub_prog %u: %s addr 0x%llx size %u\n",
 			i, name, prog_addrs[i], prog_lens[i]);
 	}
+out:
+	btf__free(btf);
 }
-- 
2.34.0.rc0.344.g81b53c2807-goog

