Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC811C38145
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Sep 2022 07:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiIGH4a (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Sep 2022 03:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIGH43 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Sep 2022 03:56:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CDF80EBB;
        Wed,  7 Sep 2022 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662537388; x=1694073388;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fMopzFhNruDXSSOJQ85hMcY11cZHcvUeUbTELdU0sWk=;
  b=STJ4K5Nei9nuRULladUDy+JZ6a70bLVmT1ELHLmcjjKcCZtRHBOwCKlk
   YDz8OLs1yO+NFGXFN7X3SMH1aYzYzzlLeqhOnJ6twZlWCi8Bgw7rb6Z1T
   PBbouZEYPXX1l5KfMXJ3XOaex2C+IcIv5tmMr1jnTn5jtODY6ak61Jfjm
   2vWYqzNKCoGXm8iWR0Kik0KguptApJHaHdpzIZrkOfd/hp8yGMzltqmoB
   7XUtRCf7zn+ErDYFadorXG46e9fGPKMDlPwov4Eb3WJUMyy3RmGP9hFPX
   jTa0owQ7X2NIxhawzg346KS0w/M9+CLZToquCwTHJk99lebKWAukOFVys
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="295543639"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="295543639"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 00:56:27 -0700
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="676069652"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 00:56:25 -0700
Message-ID: <a8a01dc8-a8ae-f102-5f08-42a646a837a1@intel.com>
Date:   Wed, 7 Sep 2022 10:56:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 1/6] perf test: Do not use instructions:u explicitly
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
References: <20220907064645.1197894-1-namhyung@kernel.org>
 <20220907064645.1197894-2-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220907064645.1197894-2-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 7/09/22 09:46, Namhyung Kim wrote:
> I think it's to support non-root user tests.  But perf record can handle
> the case and fall back to a software event (cpu-clock).  Practically this
> would affect when it's run on a VM, but it seems no reason to prevent running
> the test in the guest.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/tests/shell/record.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 00c7285ce1ac..40b087bfdb76 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -21,18 +21,18 @@ trap trap_cleanup exit term int
>  
>  test_per_thread() {
>    echo "Basic --per-thread mode test"
> -  if ! perf record -e instructions:u -o ${perfdata} --quiet true 2> /dev/null
> +  if ! perf record -o /dev/null --quiet true 2> /dev/null
>    then
> -    echo "Per-thread record [Skipped instructions:u not supported]"
> +    echo "Per-thread record [Skipped event not supported]"
>      if [ $err -ne 1 ]
>      then
>        err=2
>      fi
>      return
>    fi
> -  if ! perf record -e instructions:u --per-thread -o ${perfdata} true 2> /dev/null
> +  if ! perf record --per-thread -o ${perfdata} true 2> /dev/null
>    then
> -    echo "Per-thread record of instructions:u [Failed]"
> +    echo "Per-thread record [Failed record]"
>      err=1
>      return
>    fi
> @@ -49,7 +49,7 @@ test_register_capture() {
>    echo "Register capture test"
>    if ! perf list | egrep -q 'br_inst_retired.near_call'
>    then
> -    echo "Register capture test [Skipped missing instruction]"
> +    echo "Register capture test [Skipped missing event]"
>      if [ $err -ne 1 ]
>      then
>        err=2

