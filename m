Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDF7C7EE29
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jun 2023 01:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbjFGBqs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jun 2023 21:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240641AbjFGBo6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jun 2023 21:44:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACEC1FEE
        for <linux-perf-users@vger.kernel.org>; Tue,  6 Jun 2023 18:44:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb0cb2e67c5so9790631276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jun 2023 18:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686102293; x=1688694293;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QuS1g2OU4yoVfTehaUhzg1FIn5MgKlKDgdWGzdr+k/Y=;
        b=3YXEoKEN/nNf8meRVsOJ1z5FiTdMKpnE0acbngVa8MNgyD/uTLdtXgLV0bsixkPj57
         lSWKN3fiJ90VGXJfyQel994lr6YvUOCXS/R3GYR1hyvBtlLK76XJKeGnjdvzam8PHr+S
         j4IxI8Na0ijl28ty7RXKSFVWmKAO0A9ZWxNxSfP7kef2QGMQfbSPPyJXTx8aQc9AFE7L
         10/t611pIk0rU+SEWAQh9Id6Byfkwtr68chQpUXFuBKZcK0tM9rcYkTyZlTmmMacoWfk
         Q0EwxFdwJVuO27jERgV/8nBtbiqF8AXfPumLwdAqWAkX0+9cnTffbhgtdT8H/DvuevSj
         Jq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102293; x=1688694293;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QuS1g2OU4yoVfTehaUhzg1FIn5MgKlKDgdWGzdr+k/Y=;
        b=IvB/qto5J5hLLpkzUzYI4NPV36Zcc+2LivqFpMJV9thquDPs3gPw2iIkLUqY4MFZeD
         M+oZptedGMXojPa4Y7GfvPoGUc1t6hOOpPCKwMznGZGBr0b7rckO+TXzoH1eGHJuVRGH
         4bWGRVxAkMe2S8qCFasMhJJquVBYJqXA903Xg7dK+SA8ypQd4IxLHUTFKXKG1+m5j+9f
         R1cLrp6e7sfzFQDuaO7IPa/5b+rI0J/v7jf5PgU5rAXY6yw7OfmWLxyH68Khh50xKooi
         gyHjtfRThT1u1+H7j3ZpTBDLoo5ptb8HeEKAN2CcswaGq+rJqxm23mDyWF5/HMIuXEzs
         x/Ng==
X-Gm-Message-State: AC+VfDwkfyXEF8fa43CL6jjZdgtKusm2hUGt7CKQKntf02uhwieRlZB5
        VUTobKKoOeWL2yrFbrgYccEwYZeB/VRJ
X-Google-Smtp-Source: ACHHUZ7B7dQh8LL+jibikCYHFed+NMRUjP9zCbM9Dik4oJML+erCgoy6oLY5pMrFhCuumxHSGhJClC8+wNVr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a05:6902:1546:b0:b9f:14a5:b3b5 with SMTP
 id r6-20020a056902154600b00b9f14a5b3b5mr1437471ybu.6.1686102293264; Tue, 06
 Jun 2023 18:44:53 -0700 (PDT)
Date:   Tue,  6 Jun 2023 18:43:52 -0700
In-Reply-To: <20230607014353.3172466-1-irogers@google.com>
Message-Id: <20230607014353.3172466-20-irogers@google.com>
Mime-Version: 1.0
References: <20230607014353.3172466-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 19/20] perf machine: Don't leak module maps
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

machine__addnew_module_map requires a put on its result. Add this and
narrow the scope of map to make the correctness more obvious. This
leak was caught with leak sanitizer and the reference count checker.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f8e6c07f0048..359ef6b4e840 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1797,7 +1797,6 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 					      struct extra_kernel_map *xm,
 					      struct build_id *bid)
 {
-	struct map *map;
 	enum dso_space_type dso_space;
 	bool is_kernel_mmap;
 	const char *mmap_name = machine->mmap_name;
@@ -1823,8 +1822,8 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 	}
 	if (xm->name[0] == '/' ||
 	    (!is_kernel_mmap && xm->name[0] == '[')) {
-		map = machine__addnew_module_map(machine, xm->start,
-						 xm->name);
+		struct map *map = machine__addnew_module_map(machine, xm->start, xm->name);
+
 		if (map == NULL)
 			goto out_problem;
 
@@ -1833,6 +1832,7 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 		if (build_id__is_defined(bid))
 			dso__set_build_id(map__dso(map), bid);
 
+		map__put(map);
 	} else if (is_kernel_mmap) {
 		const char *symbol_name = xm->name + strlen(mmap_name);
 		/*
-- 
2.41.0.rc0.172.g3f132b7071-goog

