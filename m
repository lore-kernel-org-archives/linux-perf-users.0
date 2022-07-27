Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F1FC19F29
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Jul 2022 09:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiG0J1u (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Jul 2022 05:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiG0J1l (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Jul 2022 05:27:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 885E62654D;
        Wed, 27 Jul 2022 02:27:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A237D6E;
        Wed, 27 Jul 2022 02:27:40 -0700 (PDT)
Received: from [10.57.42.213] (unknown [10.57.42.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADD893F70D;
        Wed, 27 Jul 2022 02:27:38 -0700 (PDT)
Message-ID: <62efe3a0-21d7-dfee-2532-cf2090359548@arm.com>
Date:   Wed, 27 Jul 2022 10:27:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] perf/tests: Fix test case 95 Check branch stack sampling
 on s390
Content-Language: en-US
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        german.gomez@arm.com
References: <20220727071159.173360-1-tmricht@linux.ibm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220727071159.173360-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 27/07/2022 08:11, Thomas Richter wrote:
> On linux-next tree perf test 95 was added recently.
> s390 does not support branch sampling at all. Therefore
> omit this test on s390 platform.
> 
> Output before:
>  # ./perf test -Fv 95
>  95: Check branch stack sampling                                     :
>  --- start ---
>  Testing user branch stack sampling
>  ---- end ----
>  Check branch stack sampling: FAILED!
>  #
> 
> Output after:
>  # ./perf test -Fv 95
>  95: Check branch stack sampling                                     :
>  --- start ---
>  ---- end ----
>  Check branch stack sampling: Skip
>  #
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/tests/shell/test_brstack.sh | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
> index 113ccd17bf03..dedaf74164dc 100755
> --- a/tools/perf/tests/shell/test_brstack.sh
> +++ b/tools/perf/tests/shell/test_brstack.sh
> @@ -4,6 +4,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # German Gomez <german.gomez@arm.com>, 2022
>  
> +# s390 does not support branch sampling, omit
> +[ $(uname -m) = "s390" -o $(uname -m) = "s390x" ] && exit 2
> +

Hi Thomas,

Do you know why the below check doesn't cover this scenario? It seems
like it would be best to check if it's available wherever it's running
rather than enumerate every platform where it's not supported:

  # skip the test if the hardware doesn't support branch stack sampling
  perf record -b -o- -e dummy -B true > /dev/null 2>&1 || exit 2

Thanks
James

>  # we need a C compiler to build the test programs
>  # so bail if none is found
>  if ! [ -x "$(command -v cc)" ]; then
