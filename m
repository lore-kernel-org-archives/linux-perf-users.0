Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B3DC07E95
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 14:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08C5610F7
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 14:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239278AbhGSNc3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 09:32:29 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3432 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239277AbhGSNc2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Jul 2021 09:32:28 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GT3Rn5Dcpz6H7SH;
        Mon, 19 Jul 2021 22:01:41 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 16:13:04 +0200
Received: from [10.47.85.214] (10.47.85.214) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 19 Jul
 2021 15:13:03 +0100
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Subject: [bug report] Patch "perf tools: Fix pattern matching for same
 substring in different pmu type" broken
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <44e25825-5f23-c641-9f1c-72268d895f75@huawei.com>
Date:   Mon, 19 Jul 2021 15:13:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
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

Hi guys,

The named patch has broken PMU alias matching on my arm64 system.

Specifically it is broken for when multiple tokens are used in the 
alias. For example, alias "hisi_sccl,l3c" would previously match for PMU 
"hisi_sccl3_l3c7", but that no longer works.

In my example, in looking at the code, the callchain 
pmu_uncore_alias_match("hisi_sccl,l3c", "hisi_sccl3_l3c7") -> 
per_pmu__valid_suffix("hisi_sccl3_l3c7", "hisi_sccl") fails in the 
following check:

static bool perf_pmu__valid_suffix(char *pmu_name, char *tok)
{
	char *p;
	...
	p = pmu_name + strlen(tok);
	...
	if (*p != '_') //here
		return false;
}

This check assumes the first token must be followed by a '_', but it is 
possibly a numeric.

Please let me know how this should work. Previously it would match on 
the tokens, ignoring numerics and '_'.

As an aside, I'll look at why our testcases don't cover this scenario 
and look to add a test if necessary.

Thanks,
john

Ps, please cc linux-perf-users@vger.kernel.org as in the MAINTAINERS 
file in future, as not all subscribe to the open kernel list (and so 
cannot easily reply directly).

