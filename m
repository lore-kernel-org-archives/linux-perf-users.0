Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0E3C07E9B
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Jul 2021 08:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A5A6120E
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Jul 2021 08:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbhGTIQq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 20 Jul 2021 04:16:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3436 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbhGTIQV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Jul 2021 04:16:21 -0400
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GTXRY3cNxz6G8Dn;
        Tue, 20 Jul 2021 16:48:09 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 20 Jul 2021 10:56:57 +0200
Received: from [10.47.85.214] (10.47.85.214) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 20 Jul
 2021 09:56:56 +0100
Subject: Re: [PATCH] perf pmu: Create x86 specific perf_pmu__valid_suffix
To:     Jin Yao <yao.jin@linux.intel.com>, <acme@kernel.org>,
        <jolsa@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>
CC:     <Linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <ak@linux.intel.com>, <kan.liang@intel.com>, <yao.jin@intel.com>
References: <20210720082044.5380-1-yao.jin@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <68849032-ccb2-2d36-ea70-6a41301c6063@huawei.com>
Date:   Tue, 20 Jul 2021 09:56:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210720082044.5380-1-yao.jin@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.214]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 20/07/2021 09:20, Jin Yao wrote:
> The commit c47a5599eda3 ("perf tools: Fix pattern matching for same
> substring in different PMU type") breaks arm64 system because it
> assumes the first token must be followed by a '_', but it is
> possibly a numeric on arm64.

I wouldn't just say arm64. The core code should support matching 
multiple tokens, but it just so happens that only arm64 uses it.

> 
> For example, perf_pmu__valid_suffix("hisi_sccl3_l3c7", "hisi_sccl")
> fails. "hisi_sccl3_l3c7" is pmu name and "hisi_sccl" is token.
> "hisi_sccl" is followed by a digit but not followed by a '_'
> ('3' in this example).
> 
> Since the PMU alias format on arm64 has difference than the format
> on x86. Create a x86 specific perf_pmu__valid_suffix. For other arch,
> the weak function always returns true to keep original behavior
> unchanged.
> 
> Fixes: c47a5599eda3 ("perf tools: Fix pattern matching for same substring in different PMU type")
> Signed-off-by: Jin Yao<yao.jin@linux.intel.com>
> Reported-by: John Garry<john.garry@huawei.com>
> ---

I tend not to agree with this solution. Let's not make it x86 vs non-x86 
problem. Indeed, if we continue to support custom PMU alias matching 
per-arch, then it becomes a maintenance burden.

So this change fixes my initial problem:

-----8<------

 From bbc9c7bf65c9cea756f0716dd717e9cfc767ba39 Mon Sep 17 00:00:00 2001
From: John Garry <john.garry@huawei.com>
Date: Tue, 20 Jul 2021 09:48:22 +0100
Subject: [PATCH] perf pmu: Only check valid suffix for final token

Since commit 730670b1d108 ("perf pmu: Support more complex PMU event
aliasing"), matching multiple alias tokens has been supported.

However, commit c47a5599eda32 ("perf tools: Fix pattern matching for 
same substring in different PMU type"), ignored the possibility of 
multiple tokens, and assumed that we can only match on valid suffix and 
a single token.

Fix multiple token support by only checking valid suffix from final token.

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 44b90d638ad5..6de2275b2ae2 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -789,12 +789,17 @@ bool pmu_uncore_alias_match(const char *pmu_name, 
const char *name)
  	 *	    match "socket" in "socketX_pmunameY" and then "pmuname" in
  	 *	    "pmunameY".
  	 */
-	for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {
+	for (; ; ) {
+		char *next_tok = strtok_r(NULL, ",", &tmp);
  		name = strstr(name, tok);
-		if (!name || !perf_pmu__valid_suffix((char *)name, tok)) {
+		if (!name || (!perf_pmu__valid_suffix((char *)name, tok) && !next_tok)) {
  			res = false;
  			goto out;
  		}
+		if (!next_tok)
+			break;
+		name += strlen(tok);
+		tok = next_tok;
  	}

  	res = true;
-- 
2.26.2

----->8------

Please check it.

I need to check the other place perf_pmu__valid_suffix() is referenced 
(perf_pmu__match()) to see if anything is broken there.

Thanks,
John
