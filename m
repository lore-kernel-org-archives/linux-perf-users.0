Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF7FC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Jun 2022 12:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356298AbiFNMLl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Jun 2022 08:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356679AbiFNML3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Jun 2022 08:11:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A8F749F26
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jun 2022 05:11:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8519A1516;
        Tue, 14 Jun 2022 05:11:27 -0700 (PDT)
Received: from [10.57.84.186] (unknown [10.57.84.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 280B73F73B;
        Tue, 14 Jun 2022 05:11:26 -0700 (PDT)
Subject: Re: [PATCH] perf test: Record only user callchains
To:     Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Cc:     acme@redhat.com, jolsa@kernel.org,
        James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>
References: <20220614105207.26223-1-mpetlan@redhat.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <7460bdf5-7c11-bfa7-9105-5b6b453aa925@arm.com>
Date:   Tue, 14 Jun 2022 13:11:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220614105207.26223-1-mpetlan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Michael, thanks for the fix

On 14/06/2022 11:52, Michael Petlan wrote:
> The testcase 'Check Arm64 callgraphs are complete in fp mode' wants to
> see the following output:
>
>     610 leaf
>     62f parent
>     648 main
>
> However, without excluding user callchains, the output might look like:

I think you meant "kernel callchains"

> 	ffffc2ff40ef1b5c arch_local_irq_enable
> 	ffffc2ff419d032c __schedule
> 	ffffc2ff419d06c0 schedule
> 	ffffc2ff40e4da30 do_notify_resume
> 	ffffc2ff40e421b0 work_pending
> 	             610 leaf
> 	             62f parent
> 	             648 main
>
> Adding '--user-callchains' leaves only the wanted symbols in the chain.
>
> Suggested-by: German Gomez <german.gomez@arm.com>
> Tested-by: Michael Petlan <mpetlan@redhat.com>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>

Fixes: cd6382d82752 ("perf test arm64: Test unwinding using fame-pointer (fp) mode")
Reviewed-by: German Gomez <german.gomez@arm.com>

German

> ---
>  tools/perf/tests/shell/test_arm_callgraph_fp.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> index 6ffbb27afaba..ec108d45d3c6 100755
> --- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> +++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> @@ -43,7 +43,7 @@ CFLAGS="-g -O0 -fno-inline -fno-omit-frame-pointer"
>  cc $CFLAGS $TEST_PROGRAM_SOURCE -o $TEST_PROGRAM || exit 1
>  
>  # Add a 1 second delay to skip samples that are not in the leaf() function
> -perf record -o $PERF_DATA --call-graph fp -e cycles//u -D 1000 -- $TEST_PROGRAM 2> /dev/null &
> +perf record -o $PERF_DATA --call-graph fp -e cycles//u -D 1000 --user-callchains -- $TEST_PROGRAM 2> /dev/null &
>  PID=$!
>  
>  echo " + Recording (PID=$PID)..."
