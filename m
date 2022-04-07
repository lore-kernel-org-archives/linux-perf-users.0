Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B596C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Apr 2022 23:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiDGXHR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Apr 2022 19:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiDGXHQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Apr 2022 19:07:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3059ABCB5B
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Apr 2022 16:05:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i5-20020a258b05000000b006347131d40bso5278459ybl.17
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Apr 2022 16:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tors/41JgQKyqvse+O7pu0FFz6GUUhE6Y3Idh3XFdO4=;
        b=VtpRPUeczstXHdV+zd2nTPGF6b/Tshh2qvyDNkCw3zgF3eb0ZPJZGb1X5aCh9Zaj51
         ICqxxGu+bkOPrCcWpGJJTTOKpvrPE2Jy5xFSl3otZMHsLZfHoFMa5UwNMjaY1DfWaaP1
         n7NAb651jlHirzvPUNVopB+Tan6HzXfzjcDbDT8I0TCJ4DExvHVXfxU8+BVu+3TNBncP
         nnWg44VKdxqLINhxqbuhPBbPl6F/KpHCxEo4BhaCalVZGHo15rfrzSlHzazPfsnHACaR
         Y925KpqG5uQcq+P/3MpWcU6CcgRGzSEKfNUeGTBW802evTkhoAcw1Q1Z2843XMItpK1A
         6RzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tors/41JgQKyqvse+O7pu0FFz6GUUhE6Y3Idh3XFdO4=;
        b=fl5TF9sEqw64ktsi7ttDlmyw19+MiobqK/E5X66l94zrZicLuSrzIrH5m+vH0fTLrP
         N3CRDT+hSApS5L3aEylNKmEXJr22e5p4g8XA65R4XmbIqkvy+BSYCnDEqLhs+vhqUQVj
         7N53H5E0c6zi5l12g2wyEVlt8YIcyxWnJ8B4y1LjJZ9b+l5n28m2V0h377ddxBqwJJK7
         N465BBIeF7v008g0CvB55xCbyHvlWAiuVi+JuOoZaJLA+GgnoHznJ4XrDe+O8e9TO1QA
         /cx0OGkDP6Xczs8GJezHIBhxlC8u0Yw3rWH0EsroAYjmzNkCJY4NgC9J4BuEvQPrr6E9
         L5YA==
X-Gm-Message-State: AOAM533jDSLqTtH4JjBLbNOkeDyXjScgHLI75fmOykXbg3J+eRdQiZYF
        jVWJ9W/AIrW6duerhuDoLeqRNzbMVzNa
X-Google-Smtp-Source: ABdhPJyH022FsTnDX21QaHconZXhJnn/KzbIMrLAOb8OT7uonKFUv72/UXwSrles6plotzyo7qhEGeurC/8L
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:560:aa27:649e:a07d])
 (user=irogers job=sendgmr) by 2002:a25:e70c:0:b0:63e:e00b:ecd5 with SMTP id
 e12-20020a25e70c000000b0063ee00becd5mr1602174ybh.547.1649372714390; Thu, 07
 Apr 2022 16:05:14 -0700 (PDT)
Date:   Thu,  7 Apr 2022 16:04:59 -0700
In-Reply-To: <20220407230503.1265036-1-irogers@google.com>
Message-Id: <20220407230503.1265036-2-irogers@google.com>
Mime-Version: 1.0
References: <20220407230503.1265036-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH 1/5] perf annotate: Drop objdump stderr
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Li Huafei <lihuafei1@huawei.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        William Cohen <wcohen@redhat.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Denis Nikitin <denik@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If objdump writes to stderr it can block waiting for it to be read. As
perf doesn't read stderr then progress stops with perf waiting for
stdout output.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e4c641b240df..82cc396ef516 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2047,6 +2047,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	objdump_process.argv = objdump_argv;
 	objdump_process.out = -1;
 	objdump_process.err = -1;
+	objdump_process.no_stderr = 1;
 	if (start_command(&objdump_process)) {
 		pr_err("Failure starting to run %s\n", command);
 		err = -1;
-- 
2.35.1.1178.g4f1659d476-goog

