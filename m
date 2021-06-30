Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95912C11F65
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Jun 2021 04:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B02C61CED
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Jun 2021 04:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhF3ElA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 30 Jun 2021 00:41:00 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:42154 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhF3ElA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Jun 2021 00:41:00 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Wed, 30 Jun
 2021 12:38:29 +0800
Received: from [10.28.64.110] (10.28.64.110) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Wed, 30 Jun
 2021 12:38:28 +0800
Subject: Re: [PATCH] x86/perf: Fixed kernel panic during boot on Nano
 processor.
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <bp@alien8.de>, <hpa@zytor.com>, <x86@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shyaololo@163.com>, <8vvbbqzo567a@nospam.xutrox.com>
References: <20210607013109.7870-1-CodyYao-oc@zhaoxin.com>
From:   Codyyao-oc <Codyyao-oc@zhaoxin.com>
Message-ID: <174219f5-c8ab-0ee4-8055-5cfa60c6a0fc@zhaoxin.com>
Date:   Wed, 30 Jun 2021 12:38:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210607013109.7870-1-CodyYao-oc@zhaoxin.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.28.64.110]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx2.zhaoxin.com (10.29.252.164)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Dear Mingo and Peter,

Thank you for taking your precious time to read this letter, I am very 
graterful.


Last month, I fixed the bug that boot failed on Nano processor which 
introduced by

"Fixes: 3a4ac121c2ca ("x86/perf: Add hardware performance events support 
for Zhaoxin CPU.")"

with Arjan's help and submitted this patch.  But I haven't got back. 
Greatly appreciate if you could kindly

check it and reply at your convenience.

Many Thanks!

Cody

On 2021/6/7 上午9:31, Cody Yao-oc wrote:
> From: CodyYao-oc <CodyYao-oc@zhaoxin.com>
>
> Nano processor may not fully support rdpmc instruction, it works well
> for reading general pmc counter, but will lead to GP(general protection)
> when accessing fixed pmc counter. Futhermore, family/model information
> is same between Nano processor and ZX-C processor, it leads to zhaoxin
> pmu driver is wrongly loaded for Nano processor, which resulting boot
> kernal fail.
>
> To solve this problem, stepping information will be checked to distinguish
> between Nano processor and ZX-C processor.
>
> [https://bugzilla.kernel.org/show_bug.cgi?id=212389]
>
> Reported-by: Arjan <8vvbbqzo567a@nospam.xutrox.com>
> Signed-off-by: CodyYao-oc <CodyYao-oc@zhaoxin.com>
> ---
>   arch/x86/events/zhaoxin/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
> index 949d845c922b..cef1de251613 100644
> --- a/arch/x86/events/zhaoxin/core.c
> +++ b/arch/x86/events/zhaoxin/core.c
> @@ -541,7 +541,8 @@ __init int zhaoxin_pmu_init(void)
>   
>   	switch (boot_cpu_data.x86) {
>   	case 0x06:
> -		if (boot_cpu_data.x86_model == 0x0f || boot_cpu_data.x86_model == 0x19) {
> +		if ((boot_cpu_data.x86_model == 0x0f && boot_cpu_data.x86_stepping >= 0x0e) ||
> +			boot_cpu_data.x86_model == 0x19) {
>   
>   			x86_pmu.max_period = x86_pmu.cntval_mask >> 1;
>   
