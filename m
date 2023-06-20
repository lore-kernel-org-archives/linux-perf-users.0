Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6067BEB64D8
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Jun 2023 12:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjFTMir (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 20 Jun 2023 08:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjFTMip (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Jun 2023 08:38:45 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E1B10E2;
        Tue, 20 Jun 2023 05:38:43 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qBad3-0002Ja-8H; Tue, 20 Jun 2023 14:38:37 +0200
Message-ID: <984f4eb8-2d47-45ad-184f-7f5637820101@leemhuis.info>
Date:   Tue, 20 Jun 2023 14:38:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [REGRESSION][BISECT] perf/core: Remove pmu linear searching code
Content-Language: en-US, de-DE
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <3abd3693-ad87-9abf-a762-337076638fcc@linaro.org>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <3abd3693-ad87-9abf-a762-337076638fcc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687264723;ff7c3218;
X-HE-SMSGID: 1qBad3-0002Ja-8H
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux regression tracking. A
change or fix related to the regression discussed in this thread was
posted or applied, but it did not use a Closes: tag to point to the
report, as Linus and the documentation call for. Things happen, no
worries -- but now the regression tracking bot needs to be told manually
about the fix. See link in footer if these mails annoy you.]

On 04.06.23 13:38, Krzysztof Kozlowski wrote:
> 
> #regzbot introduced: 9551fbb64d09
> 
> Bisect pointed to commit 9551fbb64d09 ("perf/core: Remove pmu linear
> searching code") as first one where all hardware events are gone from
> perf for ARMv7 Exynos5422 board.

#regzbot fix: 228020b490eda91
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


