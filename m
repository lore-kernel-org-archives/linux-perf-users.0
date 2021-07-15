Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20A1C636C9
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 922F5613DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhGOUo0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:44:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232123AbhGOUo0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 16:44:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D386600CC;
        Thu, 15 Jul 2021 20:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626381692;
        bh=bkDEIMWl5CaS9HGBWR8W6BsVY6VHXUM4aZ0On1Vy+so=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZgX7RCV1DyrboIvApF1XpuKL6eHlI9k5lum4mLxhmRoyuJ1B8Mz9fjQpv/pDqcZSp
         p63lTsHY9kgtGZq+Bq6Jd11Ln4eV5aXdbmgfUkXpoqn4PR6a7b2HhrqU/+OEpyRrmV
         SuXylsASi2eKIcqiGO0EQ5XZJLyHd78t9+vAh8NKC9r3FoRGDGFe2HHlgSDxN91bVV
         ASw2fgGbDmXASabYl4YLw3aGvrGwSOkoi4ptQQclOL7u561seh6AasYaGDcU/Yg0d+
         6fRtvyHf/dDXReyWAfNVDEL5/NKFNZ3hzRQyBu56eMiGTh8F8zXPvrKc1WcBk982gu
         VFk3y5fyEcv/Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 11C97403F2; Thu, 15 Jul 2021 17:41:30 -0300 (-03)
Date:   Thu, 15 Jul 2021 17:41:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 20/20] perf util/probe-file: delete namelist on error in
 del_events
Message-ID: <YPCdelyIfI7AA8lD@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <174963c587ae77fa108af794669998e4ae558338.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174963c587ae77fa108af794669998e4ae558338.1626343282.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:07:25PM +0200, Riccardo Mancini escreveu:
> ASan reports some memory leaks when running the perf test
> "42: BPF filter".
> This second leak is caused by a strlist not being dellocated on error
> inside probe_file__del_events.
> 
> This patch adds a goto label before the deallocation and makes the error
> path jump to it.

Fixes: e7895e422e4da63d ("perf probe: Split del_perf_probe_events()")

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/probe-file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> index f9a6cbcd641501b8..3d50de3217d50ae1 100644
> --- a/tools/perf/util/probe-file.c
> +++ b/tools/perf/util/probe-file.c
> @@ -377,11 +377,11 @@ int probe_file__del_events(int fd, struct strfilter *filter)
>  
>  	ret = probe_file__get_events(fd, filter, namelist);
>  	if (ret < 0)
> -		return ret;
> +		goto out;
>  
>  	ret = probe_file__del_strlist(fd, namelist);
> +out:
>  	strlist__delete(namelist);
> -
>  	return ret;
>  }
>  
> -- 
> 2.31.1
> 

-- 

- Arnaldo
