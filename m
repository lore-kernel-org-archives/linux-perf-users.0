Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672ABC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 11:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45FC361159
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 11:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240349AbhI1Lxv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 07:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240489AbhI1Lxs (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 07:53:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 667AD60F44;
        Tue, 28 Sep 2021 11:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632829929;
        bh=h8Engh8zQeFpE+PhZXkY+8dWxtq2jDFRJZFdSobFGKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZVthk8MkxmKiF8UzP6pQT2JFhauSxdEjRxQC/oMzbji0vZtGpqhA36l9A9e3C7fQ8
         htv5eRf4a9Q6VYIeE4M2C8WzaC6IDRmaWvNvAkLn7Qz3kKRSwJzBNnAsTGlx3wUBQ+
         +fqtLMvT1NkmpG/uAym/QhWPSPnQ8SmmYJ7L3zMRCqwn6wef0kMBps80LGmr9NwSc0
         gqYAKQ1Q2uJuPowqUl7EdDI2aPjrd903PNHaSoLrVYAxgX4j9MHzrrM7gLkrFyNn7N
         Xei9n8Y8hJSV5UGjhwlY0tdBpnk2kOKn0XRpKEOh0RUzAME3VKdK42EUooTKD8h/uT
         rjasLJBQdXvtw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 513DC410A1; Tue, 28 Sep 2021 08:52:06 -0300 (-03)
Date:   Tue, 28 Sep 2021 08:52:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     John Garry <john.garry@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf jevents: Fix sys_event_tables to be freed like
 arch_std_events
Message-ID: <YVMB5kt8XG+OdJ1M@kernel.org>
References: <20210928102938.69681-1-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928102938.69681-1-likexu@tencent.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Sep 28, 2021 at 06:29:38PM +0800, Like Xu escreveu:
> From: Like Xu <likexu@tencent.com>
> 
> The compiler reports that free_sys_event_tables() is dead code. But
> according to the semantics, the "LIST_HEAD(arch_std_events)" should
> also be released, just like we do with 'arch_std_events' in the main().

Thanks, applied.

- Arnaldo

 
> Fixes: e9d32c1bf0cd7a98 ("perf vendor events: Add support for arch standard events")
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  tools/perf/pmu-events/jevents.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 6731b3cf0c2f..7c887d37b893 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -1285,6 +1285,7 @@ int main(int argc, char *argv[])
>  	}
>  
>  	free_arch_std_events();
> +	free_sys_event_tables();
>  	free(mapfile);
>  	return 0;
>  
> @@ -1306,6 +1307,7 @@ int main(int argc, char *argv[])
>  		create_empty_mapping(output_file);
>  err_out:
>  	free_arch_std_events();
> +	free_sys_event_tables();
>  	free(mapfile);
>  	return ret;
>  }
> -- 
> 2.32.0

-- 

- Arnaldo
