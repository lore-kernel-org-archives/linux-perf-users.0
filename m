Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6907C7EE23
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Jun 2023 23:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbjFHXa7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Jun 2023 19:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237421AbjFHXaS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Jun 2023 19:30:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E9B3583
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Jun 2023 16:29:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bacd408046cso1595430276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jun 2023 16:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686266994; x=1688858994;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dsHeOnEMfHd9s4DOJfCHWE1AXrbWG8qUbRavLpQo6Y4=;
        b=u/Qq25sb4E3B/YN9x8AfhOptxhinrbUgxpyj6i2VnVhF2falloUPeEVua2xI7eTgZ6
         9Y8toDrNHLnYKnplX5n9qqM33bvduJatdErNYGQESFU0FadeY7tKHF1ahdrkv1yFddlL
         pBErliZx0UsK/W9S1qORmBxXTTCtDepCNQwf5bwE/uLFWIr+VSqant5bxtav5gTlrcaA
         F/9rW8q3tuQS+6PEX6dtl46wyFTCxHPwHHMr0gxri3Ghal/QZje/aOk408AxeUO8F0Qh
         udCQ04uab2R7IuY1HP8r9ROZBB4/Mt1ChYs+oD+J3Rg1CRWI+cA8UMoUJ4cb+g9hNUig
         TXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266994; x=1688858994;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsHeOnEMfHd9s4DOJfCHWE1AXrbWG8qUbRavLpQo6Y4=;
        b=h8ynCvxc8iawoicR9qrGBxLYjC8ylPoT3dUGBGo23BEEJfXJZCOLjYKIHIDQp0kntP
         o36mixdCv65KeSJMdU/NSMXbeeVll27cq0yWBpkpSrW2t289LQR4RDzbAqdl+y6eEDtJ
         z2D3FJBWJZ6QxQoTdmLtSv7vdQLR2m0+uGWishWFRVQ/cMsNrQeWK3zVw6WWJHAWAHN3
         1WXssJKSyYbPHXxwKCv0/k1ZffPjJvpgcKU7eUC/2lbHYzbHC2RNxNTTgiZlrS5FdA2b
         EW3sNkScC/kLQhh/XitIJl5OD3YcKZgIYKyYuy4nTOn4/TbW1STxEbXEn+tV9WfMRvfD
         3CsA==
X-Gm-Message-State: AC+VfDy5R4kIyoysDg/ZqbeefieILfdqpRA9g5LY2hQVEuO3j8dODrX/
        irQMJwxKBO4XcZoY6b6ELfi/VdIjhUXX
X-Google-Smtp-Source: ACHHUZ72ScCy5hQCMHWZ9ZJ+Q/Hjmqux3MK2aSfNgD4ALpiCGxXMG3yuJqiTHTTc+k5GHvXKXHBsUuFK+hDJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a25:240f:0:b0:bad:600:1833 with SMTP id
 k15-20020a25240f000000b00bad06001833mr605870ybk.0.1686266993757; Thu, 08 Jun
 2023 16:29:53 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:14 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-18-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 17/26] perf maps: Fix overlapping memory leak
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

Add a missed free detected by leak sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 5206a6433117..233438c95b53 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -374,6 +374,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 		}
 put_map:
 		map__put(pos->map);
+		free(pos);
 	}
 	up_write(maps__lock(maps));
 	return err;
-- 
2.41.0.162.gfafddb0af9-goog

