Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED894C76196
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Apr 2023 22:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjDJWQX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Apr 2023 18:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjDJWQX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Apr 2023 18:16:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5D1131;
        Mon, 10 Apr 2023 15:16:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6A8561BBB;
        Mon, 10 Apr 2023 22:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23394C433D2;
        Mon, 10 Apr 2023 22:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681164981;
        bh=5+Vu0u8xhRv+uGKlrUrXGJWww7elBjf7lpZ/udtRXIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W+zZZdzmUhDI2HaplyaSNTFoYCux9ZRWCLyThuYsbf21iwcyNfQpjshv6K+FYC+Wo
         M+Hns6Vi7+6VmjXz0F8skEmwAnyXDA8HfM1ppuRIGz32fWXr6YyK2kAHCxyXR15THB
         dlj+I6VX+0RCOvnQyT2kbDil27uNlorqkM6yn1FC8ORU/Hz3MlWat28yYIxdhQyQ/+
         wPkMLzRlOTTMDuTlXY47K0zZWseqbAF8jGSgeCJIXk+4gp+ggMo4ecbv0CTePQT8i4
         A1wHqCvGFAZ92aTAFWUxYEDlXEDQcTyExABTxc2NTekTG7PpUIGyakkmZfLi55ZN2i
         JsXj2ayQjTCZw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9BB7F40009; Mon, 10 Apr 2023 19:16:18 -0300 (-03)
Date:   Mon, 10 Apr 2023 19:16:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Write json and csv test output to test files
Message-ID: <ZDSKsqkZkV/2AB5p@kernel.org>
References: <20230408054456.3001367-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408054456.3001367-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Apr 07, 2023 at 10:44:53PM -0700, Ian Rogers escreveu:
> Avoid problems where debug/warning messages would break output
> formatting.
> 
> v2. move the XXX with mktemp to the end of the template as required.

Thanks, applied.

- Arnaldo

 
> Ian Rogers (3):
>   perf test: Write CSV output to a file
>   perf stat: Don't write "started on" for json output
>   perf test: Write Json output to a file
> 
>  tools/perf/builtin-stat.c                     |  6 +-
>  .../tests/shell/lib/perf_json_output_lint.py  |  3 +-
>  tools/perf/tests/shell/stat+csv_output.sh     | 58 ++++++++++++++-----
>  tools/perf/tests/shell/stat+json_output.sh    | 48 +++++++++++----
>  4 files changed, 84 insertions(+), 31 deletions(-)
> 
> -- 
> 2.40.0.577.gac1e443424-goog
> 

-- 

- Arnaldo
