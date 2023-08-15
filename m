Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22449C001B0
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Aug 2023 17:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjHORtP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Aug 2023 13:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238947AbjHORtC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Aug 2023 13:49:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879DB10F4
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Aug 2023 10:49:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1017E65462
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Aug 2023 17:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1A1C433C8;
        Tue, 15 Aug 2023 17:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692121740;
        bh=S2AyS/oMkMG+6KkoW2E0h76w1Jp0Unq0CA4GWbeZF08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FWyP9RZYCBfwJ/cv9DQ9V04Q3BkcG1WDSTBIUwjX+IOCpY/gX5kysUSI8Oux7PCjG
         sv8vOjxrlck4p25Tt6ksK20kXGUgW+mFGyv6TEriCAQR82TzqS5PtxMuhovJG/P+cQ
         pemaTcztHuAPoBDCl7rmQydFl+hlkMxKXw4K4fanRpY+SOA4O/zuYlZhfMqsrGaSWF
         /71eIGwxNPxHaKfNY+tPwTgZKBDlyjvWVeonJbFysObfocV9XR9rMuDPFIHwg/ZxNx
         DKxC6hzpm72FoFWiW5V5ke8IcxcXdDvMD0PWg8j9yxpEHeSMqrVQDrapzqprH9o9HE
         93MpQN/OvsY7A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B1B3F404DF; Tue, 15 Aug 2023 14:48:57 -0300 (-03)
Date:   Tue, 15 Aug 2023 14:48:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, huawei.libin@huawei.com
Subject: Re: [PATCH] perf scripts python: Support syscall name parsing on
 arm64
Message-ID: <ZNu6iWfCfh9aU1OQ@kernel.org>
References: <20230815131735.1237221-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815131735.1237221-1-liwei391@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Aug 15, 2023 at 09:17:35PM +0800, Wei Li escreveu:
> In the result of "perf script syscall-counts" on arm64, the syscall
> events are not resolved currently. Add "aarch64" to audit uname list to
> support name parsing.
> 
> * After the patch:
> 
> [root@localhost ~]# perf script syscall-counts sleep 1
> Press control+C to stop and show the summary
> 
> syscall events:

Thanks, applied.

- Arnaldo
 
> event                                          count
> ----------------------------------------  -----------
> mmap                                               6
> close                                              5
> mprotect                                           4
> brk                                                3
> newfstatat                                         3
> openat                                             3
> getrandom                                          1
> prlimit64                                          1
> munmap                                             1
> clock_nanosleep                                    1
> set_robust_list                                    1
> set_tid_address                                    1
> exit_group                                         1
> read                                               1
> faccessat                                          1
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
> index 84536b1a27ba..b75d31858e54 100644
> --- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
> +++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
> @@ -54,6 +54,7 @@ try:
>  	import audit
>  	machine_to_id = {
>  		'x86_64': audit.MACH_86_64,
> +		'aarch64': audit.MACH_AARCH64,
>  		'alpha'	: audit.MACH_ALPHA,
>  		'ia64'	: audit.MACH_IA64,
>  		'ppc'	: audit.MACH_PPC,
> -- 
> 2.25.1
> 

-- 

- Arnaldo
