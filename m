Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDD3C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 19:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B3C60F9C
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 19:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbhJHTMZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240695AbhJHTMW (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Oct 2021 15:12:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C54F60F4F;
        Fri,  8 Oct 2021 19:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633720227;
        bh=4yxpXFUc2HurYKeztbb8RR9jfdOYKnPhwyqyTYdFooc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tLhobrzhmo1rsrJ8jlNbknfn8b5nhECuOU8BNO3Ly2Y4yIs6pJymBTcPhRXlFqVpK
         KBg17Ucz0WHJ6kVD3A9eP3KK5ebTCA4dAfEzfNK4S+RzOdlAM8DssiDuzvsYsJeNwE
         1LMcEIdj26TLrvXv9xAsDnIqwkmPZPbqwL55aslpwKvg6FMfOJR0ZW306eQHAbp+Hb
         R4QLnUHcNLg4c9TwTdWZxcDflKE/aPOiKXeWGgL1wkPKw6Ri1KjXWZY9h2w/xIQTrj
         ui90BM6ap5AO6gX6h7PVxJ4L6DddFwVZ4UiWq5VJlmStHgOV5vjvr2Y6W6zscNmW4a
         m5o6O17vOtxPw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 39FBF410A1; Fri,  8 Oct 2021 16:10:25 -0300 (-03)
Date:   Fri, 8 Oct 2021 16:10:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf kmem: Improve man page for record options
Message-ID: <YWCXoRis0BhKJCYC@kernel.org>
References: <20210922212031.485950-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922212031.485950-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Sep 22, 2021 at 02:20:31PM -0700, Ian Rogers escreveu:
> Since:
> https://lore.kernel.org/lkml/20200708183919.4141023-1-irogers@google.com/
> The output option works for 'perf kmem', however, it must appear after
> 'record'. This is different to 'stat' where '-i' for the input must
> appear before. Try to capture this complication in the man page.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-kmem.txt | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-kmem.txt b/tools/perf/Documentation/perf-kmem.txt
> index 85b8ac695c87..f378ac59353d 100644
> --- a/tools/perf/Documentation/perf-kmem.txt
> +++ b/tools/perf/Documentation/perf-kmem.txt
> @@ -8,22 +8,25 @@ perf-kmem - Tool to trace/measure kernel memory properties
>  SYNOPSIS
>  --------
>  [verse]
> -'perf kmem' {record|stat} [<options>]
> +'perf kmem' [<options>] {record|stat}
>  
>  DESCRIPTION
>  -----------
>  There are two variants of perf kmem:
>  
> -  'perf kmem record <command>' to record the kmem events
> -  of an arbitrary workload.
> +  'perf kmem [<options>] record [<perf-record-options>] <command>' to
> +  record the kmem events of an arbitrary workload. Additional 'perf
> +  record' options may be specified after record, such as '-o' to
> +  change the output file name.
>  
> -  'perf kmem stat' to report kernel memory statistics.
> +  'perf kmem [<options>] stat' to report kernel memory statistics.
>  
>  OPTIONS
>  -------
>  -i <file>::
>  --input=<file>::
> -	Select the input file (default: perf.data unless stdin is a fifo)
> +	For stat, select the input file (default: perf.data unless stdin is a
> +	fifo)
>  
>  -f::
>  --force::
> -- 
> 2.33.0.464.g1972c5931b-goog

-- 

- Arnaldo
