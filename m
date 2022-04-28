Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CFCC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Apr 2022 16:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349242AbiD1QRl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Apr 2022 12:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349603AbiD1QRb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Apr 2022 12:17:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57EDF5C65F;
        Thu, 28 Apr 2022 09:14:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F95D1474;
        Thu, 28 Apr 2022 09:14:12 -0700 (PDT)
Received: from [10.32.33.49] (e121896.warwick.arm.com [10.32.33.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 720363F774;
        Thu, 28 Apr 2022 09:14:10 -0700 (PDT)
Message-ID: <93e36dac-47d4-1e2b-6cb1-0092a5371810@arm.com>
Date:   Thu, 28 Apr 2022 17:14:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] perf tests: Fix coresight `perf test` failure.
Content-Language: en-US
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-perf-users@vger.kernel.org,
        "acme@kernel.org" <acme@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linaro.org>
References: <20220428151947.290146-1-jeremy.linton@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220428151947.290146-1-jeremy.linton@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 28/04/2022 16:19, Jeremy Linton wrote:
> Currently the `perf test` always fails the coresight test like:
> 
> 89: Check Arm CoreSight trace data recording and synthesized samples: FAILED!
> 
> That is because the test_arm_coresight.sh is attempting to SIGINT the
> parent but is using $$ rather than $PPID and it sigint's itself when
> run under the perf test framework. Since this is done in a trap clause
> it ends up returning a non zero return. Since $PPID is a bash ism and
> not all distros are linking /bin/sh to bash, the alternative
> parent pid lookups are uglier than just dropping the kill, and its
> not strictly needed, lets pick the simple solution and drop the sigint.
> 
> Fixes: 133fe2e617e4 ("perf tests: Improve temp file cleanup in test_arm_coresight.sh")
> Cc: James Clark <james.clark@arm.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  tools/perf/tests/shell/test_arm_coresight.sh | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
> index 6de53b7ef5ff..e4cb4f1806ff 100755
> --- a/tools/perf/tests/shell/test_arm_coresight.sh
> +++ b/tools/perf/tests/shell/test_arm_coresight.sh
> @@ -29,7 +29,6 @@ cleanup_files()
>  	rm -f ${file}
>  	rm -f "${perfdata}.old"
>  	trap - exit term int
> -	kill -2 $$
>  	exit $glb_err
>  }
>  

Reviewed-by: James Clark <james.clark@arm.com>
