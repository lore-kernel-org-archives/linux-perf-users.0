Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F12CC7EE29
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jun 2023 01:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbjFGBqT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jun 2023 21:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbjFGBoz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jun 2023 21:44:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2031FDA
        for <linux-perf-users@vger.kernel.org>; Tue,  6 Jun 2023 18:44:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb3855c34deso2563397276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jun 2023 18:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686102286; x=1688694286;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jfxVqcu2CXJndLVaHRwEEUAL5AeHKV2fgnyhsas076A=;
        b=HUfSQYFHc6NzgRtveDwEiUbyhktBsnvEdmsauf2233GDNNnfVG1TYxxa7EjJX3Sx+Z
         CQsoBZEg80xJ6LrEofzgA+rdH4bQztLYYJPbRr2rK/O70x5M4CKnwnzL9lLDWh4Qr++l
         +0XKydeAO7155XrCImjn85cHagz96SF/1gevNGDDCFWLhodHO63uMJJJBSa/mtKE9KAw
         QGnCINd289qakFmco2iQOlJF4LjJbFFAG7ygNcZRfFVdd7c+8Ez1gmK2Ry4wc0iOi+PQ
         Noiux4Veb78XAZ8VNWueFKK0fzyqCx0dhwKUn+NOBov8iv25aligiEFfoRfZJ6RznmNi
         i0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102286; x=1688694286;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jfxVqcu2CXJndLVaHRwEEUAL5AeHKV2fgnyhsas076A=;
        b=lTEa/2B21cAcmf2Rt3Jln+ouXjw7KYx0cUm+RIly3BjdTzb5xA7qgUcVtXP2yC4zHq
         QeMfVsgBbGcc9JTl++Kx4g7PvsGK1oBm1Pz+dg6q6Tm0kEJkDxS5/t0pXySCOp4l3atp
         MoQ6UN4mEj7t/JZVGJ3Gtke+1jXk0MyKRmznUAXrfCxyhE/A0iJdjGJynj1gfKEagOw4
         C4lChuKBbdKySsY8Zfb0o1/J/U/HbSfr5AHWF63poyl5YgrajqmEXSOa3Sd3YZdEOmic
         3d9OSjWNZL/SbeQ2FaMO3xm0jiUy+PEqh4G0EdIPPkyFLNnrOOCgJrzH1hZRiZICo7+F
         vtlA==
X-Gm-Message-State: AC+VfDxOAJa3w9hTwihHVNRI2DVeieWYBLyn+4uotSZRhsgoy8b7DL8V
        oYmtBK1dWWMjVTSVotL5bOpEKN7CiR4V
X-Google-Smtp-Source: ACHHUZ71vO0aUgfwYH60RkozvkP/e7xil66buUKML1mj0DHqVFthPBVqwFyqTn+6yi3Vhy6a0q8bdiSdn4hj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a05:6902:1823:b0:bb1:446f:1d00 with SMTP
 id cf35-20020a056902182300b00bb1446f1d00mr2113685ybb.10.1686102286405; Tue,
 06 Jun 2023 18:44:46 -0700 (PDT)
Date:   Tue,  6 Jun 2023 18:43:49 -0700
In-Reply-To: <20230607014353.3172466-1-irogers@google.com>
Message-Id: <20230607014353.3172466-17-irogers@google.com>
Mime-Version: 1.0
References: <20230607014353.3172466-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 16/20] perf symbol-elf: Correct holding a reference
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
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        "Shawn M. Chapla" <schapla@codeweavers.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Raul Silvera <rsilvera@google.com>,
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

If a reference is held, don't put it as this will confuse reference
count checking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol-elf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 63882a4db5c7..e6493d1cc251 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1389,11 +1389,11 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			/* Ensure maps are correctly ordered */
 			if (kmaps) {
 				int err;
+				struct map *tmp = map__get(map);
 
-				map__get(map);
 				maps__remove(kmaps, map);
 				err = maps__insert(kmaps, map);
-				map__put(map);
+				map__put(tmp);
 				if (err)
 					return err;
 			}
-- 
2.41.0.rc0.172.g3f132b7071-goog

