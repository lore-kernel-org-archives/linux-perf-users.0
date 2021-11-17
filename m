Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A361C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 15:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E39D613C8
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 15:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhKQP21 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Nov 2021 10:28:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238038AbhKQP2X (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Nov 2021 10:28:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8F57613C8;
        Wed, 17 Nov 2021 15:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637162724;
        bh=R25fmkeDsTohW55S+4oxgo7vBySu9f8sHLX0EbzuNys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Couya29XjivwLpqDvF6qzd9AyufVubHLKeajGkW3oLDxmiNC+PDU0QfVLPETdVyci
         wQUCCsnAuhf8yOM2E+9REVq9imdnin7fhU9CzzQpJlNNcQ0up/EaBSfYMx9Mlhh6qP
         QtiJiyvby47rO8X7M+TeAQr6yYhWoeFw0sCZ9bFwo9EA+p0E+3j+MRjKII4C50JWiv
         e5i6uyaCvrkvPIwS+0vup72jJZwjIrHk3gXSVOKl2IXibAUmBlPv4VaWn9o2zgWZhA
         hvb3+r6UONGNVJvwJiciymDIc3LA1QVdBaE7LLvYYFqwvkJGAiE1GVux7fg8AYRdUF
         Oiz/CUnM0dc+A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0752B4088E; Wed, 17 Nov 2021 12:25:20 -0300 (-03)
Date:   Wed, 17 Nov 2021 12:25:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     irogers@google.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf bench: Fix memory leaks.
Message-ID: <YZUe4C7laP5BkMmu@kernel.org>
References: <20211110022012.16620-1-sohaib.amhmd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110022012.16620-1-sohaib.amhmd@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Nov 10, 2021 at 04:20:11AM +0200, Sohaib Mohamed escreveu:
> ASan reports memory leaks while running:
> $ perf bench sched all
> 
> Fixes: e27454cc6352 ("perf bench: Add sched-messaging.c: Benchmark for
> scheduler and IPC mechanisms based on hackbench")

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
> Acked-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/bench/sched-messaging.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
> index 488f6e6ba1a5..fa0ff4ce2b74 100644
> --- a/tools/perf/bench/sched-messaging.c
> +++ b/tools/perf/bench/sched-messaging.c
> @@ -223,6 +223,8 @@ static unsigned int group(pthread_t *pth,
>  		snd_ctx->out_fds[i] = fds[1];
>  		if (!thread_mode)
>  			close(fds[0]);
> +
> +		free(ctx);
>  	}
> 
>  	/* Now we have all the fds, fork the senders */
> @@ -239,6 +241,8 @@ static unsigned int group(pthread_t *pth,
>  		for (i = 0; i < num_fds; i++)
>  			close(snd_ctx->out_fds[i]);
> 
> +	free(snd_ctx);
> +
>  	/* Return number of children to reap */
>  	return num_fds * 2;
>  }
> --
> 2.25.1

-- 

- Arnaldo
