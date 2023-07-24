Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998D9EB64DD
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Jul 2023 20:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjGXUNO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Jul 2023 16:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjGXUNH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Jul 2023 16:13:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A701732
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jul 2023 13:13:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-569e7aec37bso47295977b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jul 2023 13:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690229583; x=1690834383;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B2hkxh9LqcegTaK3Zyb2Y04p/jheCyz+iGuZbjHft5A=;
        b=dFnffByPi/9dPdpPXDPeErJAHkm4U9xmJEkUxTK523YIBmo/FhKa35iXauOduV2Pif
         qhrvAqczwoe1kO5YrqsE4HVa/uBo3+8dpoYCh3NieWigFEDe/IVK3O6HH6OdtI5i+ZM+
         2KRDhnab4TtHa6Xfwmg8rPe40dTtSGrCgHfS12vvP8ClkpFCg2qRBovuROUDtaY7RgGC
         rq6iGpbsv+MFoUANFCBaKzXVulRiJgAxltKkaziWxEl+HKkX9SEO4FlhIeLqgOjRtUd/
         7j9DqAayTNnDqpM5MrM1rjP74kQsTEvcd8AjHnDSeFYehB/V4Gfm0pF0X93t3kqOaUQl
         OgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690229583; x=1690834383;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2hkxh9LqcegTaK3Zyb2Y04p/jheCyz+iGuZbjHft5A=;
        b=epzK9iYrjpdl5jhZkbVNBiPrMczKc6rs7sg7XID4M7C/i3aYE/pNmGQjbVPpliXwZ+
         FDJhVbu8IcAE4o6AkVRxOHXuPndlewgbK7G7GYmW8w+/0vqaUYG5FTa+Zubz2T/7qE02
         60YW+MQF0fANMm3ptB5jcfixZzFR+1UVVdHXTn2V/pk8yzFnpcn3an9e3gBjRvS5w5/S
         adai5QvS2nqlXSKFpplQdLJzGC2vkjZbdOnLTg2wUG/kAhAYAQ2UUGYe96Iu43cv6qbz
         G2cyFCHOW/Y9ybGFZJQRPiAH+Uuw+BtCJ6CNCUxsWlW502x82R2We+boAJX4Zs6T59LU
         Iu3g==
X-Gm-Message-State: ABy/qLZM+oMHU3L+07oYa2+6UrvqFdqu/1PKtNMpA/T6+jp/44Fdu2N1
        0bdkFD0L1wgt4whhHv6/HcusBuQzNdbT
X-Google-Smtp-Source: APBJJlEcBOZe3u432ZlnenysdB3kMfqSv4wJ57ueFyPxQ8WNtoVZQq8B8/KVokgcDdDgdzCi3rPmRZZpci+e
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5724:8dc0:46f0:f963])
 (user=irogers job=sendgmr) by 2002:a81:af21:0:b0:56c:e585:8b17 with SMTP id
 n33-20020a81af21000000b0056ce5858b17mr70674ywh.5.1690229583398; Mon, 24 Jul
 2023 13:13:03 -0700 (PDT)
Date:   Mon, 24 Jul 2023 13:12:47 -0700
In-Reply-To: <20230724201247.748146-1-irogers@google.com>
Message-Id: <20230724201247.748146-5-irogers@google.com>
Mime-Version: 1.0
References: <20230724201247.748146-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 4/4] perf build: Add LTO build option
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     maskray@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add an LTO build option, that sets the appropriate CFLAGS and CXXFLAGS
values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c5db0de49868..a9cfe83638a9 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -256,6 +256,11 @@ ifdef PARSER_DEBUG
   $(call detected_var,PARSER_DEBUG_FLEX)
 endif
 
+ifdef LTO
+  CORE_CFLAGS += -flto
+  CXXFLAGS += -flto
+endif
+
 # Try different combinations to accommodate systems that only have
 # python[2][3]-config in weird combinations in the following order of
 # priority from lowest to highest:
-- 
2.41.0.487.g6d72f3e995-goog

