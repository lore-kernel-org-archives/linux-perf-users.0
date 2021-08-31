Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0917AC432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B6F61059
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhHaTvW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:51:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhHaTvV (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 15:51:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7075160FE6;
        Tue, 31 Aug 2021 19:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630439425;
        bh=ekHRx31xM7F0lGz1VDIoOTtbt1ej1vJeqD8rSC0v11U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XViDsM1Wyg0Ma+Qekrqx4vg4No3lgCD3GyUoAgVAeQy+FFTRUZVYnwrkfw63ua8nc
         apcjV4sJDHSWGkFhCfukmsjyLJwN5eOBMzrhHnkusyMKF9SDL332oTUk8qhtmE6Gii
         VRXx9TyipzApKPODqD+ir57qsMO4XEE7B12VI3wxSItc1tlsVhkxyeJf+Zz77e2DIx
         tu7ILb+mjvv3I/Roynx4Dg7ytD7HhZAkM1AJeZuW7yzdS9UcLR3SSBmiFQvID+1ynt
         YChg98MAiRff6OQv/+JfzIqmvAZXlKOAUZk6lXVb9zwfbjYDMYaXQ8liKStBdLv3ZV
         N7EWauc3U0G7g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2D9754007E; Tue, 31 Aug 2021 16:50:22 -0300 (-03)
Date:   Tue, 31 Aug 2021 16:50:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>,
        Song Liu <songliubraving@fb.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 23/37] perf evsel: move bpf_counter__install_pe to
 success path in evsel__open_cpu
Message-ID: <YS6H/hiBHVMxWeQR@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
 <64f8a1b0a838a6e6049cd43c1beafd432999ae57.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64f8a1b0a838a6e6049cd43c1beafd432999ae57.1629490974.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Aug 21, 2021 at 11:19:29AM +0200, Riccardo Mancini escreveu:
> I don't see why bpf_counter__install_pe should get called even if fd=-1,
> so I'm moving it to the success path.
> 
> This will be useful in following patches to separate the actual open and
> the related operations from the fallback mechanisms.

Looks sane, applied.

Next time please use git blame to find the author and add him to the CC
list, like I just did, so that the mistery can be unveiled or a duh!
uttered :-)

- Arnaldo
 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/evsel.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d2b0391569286080..3e556afed8dd396c 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2009,8 +2009,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  
>  			FD(evsel, cpu, thread) = fd;
>  
> -			bpf_counter__install_pe(evsel, cpu, fd);
> -
>  			if (fd < 0) {
>  				err = -errno;
>  
> @@ -2019,6 +2017,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  				goto try_fallback;
>  			}
>  
> +			bpf_counter__install_pe(evsel, cpu, fd);
> +
>  			if (unlikely(test_attr__enabled)) {
>  				test_attr__open(&evsel->core.attr, pid, cpus->map[cpu],
>  						fd, group_fd, evsel->open_flags);
> -- 
> 2.31.1

-- 

- Arnaldo
