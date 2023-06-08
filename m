Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD91C7EE25
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Jun 2023 23:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbjFHXbt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Jun 2023 19:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237700AbjFHXbV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Jun 2023 19:31:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5096B3AAD
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Jun 2023 16:30:26 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565de4b5be5so15602517b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jun 2023 16:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686267016; x=1688859016;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tvDaWeTNK3WSoU7RxteMJWYjgKCzqqKrMU8SOHl6IsA=;
        b=zq7n0FG6q55kI1lknHAHE1lHuS0TVc2SIL7xiqJwpHFzQgHoHR7VyUNJvMJLM7LqZK
         PReM7k5azlxan7GYT1OEQt6A9BGBbAC3OZKpRnVe2PD57AM/SvI0WBHohv4qVe4lmE8e
         XM8+/NASVm3hFIJF3NtAK4Z98KBICfnux+nLsiXJ4NUp463Ykl0ZkWzFvMFlk/BFoSD9
         DPIiedqbcOjh/XwcM6s3MbzY8xp8RCXeqbF2SA9G2Lb7D5ayo8igY25wrzJmVtqrLy4K
         akYi8T8ZNXtjwn6ejlcluxF5wrXbxLo1nhT5TB0nexOVLZO/9jIWD3tBE3eT80vTS7OY
         rL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686267016; x=1688859016;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tvDaWeTNK3WSoU7RxteMJWYjgKCzqqKrMU8SOHl6IsA=;
        b=OP+hDuoNAHL3bcQTP50QKHQwRGgmvYTcKPjfMByMy0AgibLRMBCelbADH+Mhlej4rR
         UnRdVkT+h62b0X6/i345JTBlaiFQIx2IkKC6LnXeaS21k+muRqLRDr2H4aQlhrFjr1ZF
         K/jiF7FrdgVk241WPGYAr0XgBXDB5NlF38iEjmjZ8CuLQHypRrxi31hsqAwsbGiDRgTm
         GPrRch9ZpdVxIWoCmiXVxiqj0CigvicZXJfxF5xR/FLkwUhirpOYJV6bIkYc9XQLjHX8
         Gn7lGAFamiPXsY5aXsgflCqAI8IlSIsWxvTM4i00lvfVPLeJLvoNuY8U0IOV44PuLZk1
         Bv9Q==
X-Gm-Message-State: AC+VfDzIZrmgKWn/ASFaOJ2DNlBEQzrCqXZc/bYGsZLsr8OX2cm4Jp/M
        7rky7agaG9Pls3uCrwDZoNw+ekDkLF43
X-Google-Smtp-Source: ACHHUZ5mehvIfiWPsR3FMIB5AYIB4oykjMARcMG88ABn1UYKXC7tDYxPh/EBCaYSpCh78GjCUjEvdjauAAmr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a25:b116:0:b0:ba8:4c16:78b7 with SMTP id
 g22-20020a25b116000000b00ba84c1678b7mr600676ybj.12.1686267015833; Thu, 08 Jun
 2023 16:30:15 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:23 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-27-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 26/26] perf hist: Fix srcline memory leak
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

srcline isn't freed if it is SRCLINE_UNKNOWN. Avoid strduping in this
case as such strdups are redundant and leak memory.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 77cb2cc83bb9..cc6f7f51faa5 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -484,7 +484,7 @@ static int hist_entry__init(struct hist_entry *he,
 			goto err_infos;
 	}
 
-	if (he->srcline) {
+	if (he->srcline && strcmp(he->srcline, SRCLINE_UNKNOWN)) {
 		he->srcline = strdup(he->srcline);
 		if (he->srcline == NULL)
 			goto err_rawdata;
-- 
2.41.0.162.gfafddb0af9-goog

