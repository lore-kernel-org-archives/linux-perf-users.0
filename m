From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/2] perf config: Show default report configuration in
 example and docs
Date: Wed, 31 Aug 2016 18:49:41 -0300
Message-ID: <20160831214941.GC13095@kernel.org>
References: <20160830134106.21240-1-milian.wolff@kdab.com>
 <20160830134106.21240-2-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756740AbcHaVtq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 31 Aug 2016 17:49:46 -0400
Content-Disposition: inline
In-Reply-To: <20160830134106.21240-2-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Em Tue, Aug 30, 2016 at 03:41:06PM +0200, Milian Wolff escreveu:
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>

Thanks, applied to perf/core.

- Arnaldo
 
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> ---
>  tools/perf/Documentation/perf-config.txt    | 8 ++++++++
>  tools/perf/Documentation/perfconfig.example | 9 +++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> index c7031bc..1559000 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -110,6 +110,14 @@ Given a $HOME/.perfconfig like this:
>  		order = caller
>  		sort-key = function
>  
> +	[report]
> +		# Defaults
> +		sort-order = comm,dso,symbol
> +		percent-limit = 0
> +		queue-size = 0
> +		children = true
> +		group = true
> +
>  Variables
>  ~~~~~~~~~
>  
> diff --git a/tools/perf/Documentation/perfconfig.example b/tools/perf/Documentation/perfconfig.example
> index 1d8d5bc..2b477c1 100644
> --- a/tools/perf/Documentation/perfconfig.example
> +++ b/tools/perf/Documentation/perfconfig.example
> @@ -27,3 +27,12 @@
>  	use_offset = true
>  	jump_arrows = true
>  	show_nr_jumps = false
> +
> +[report]
> +
> +	# Defaults
> +	sort-order = comm,dso,symbol
> +	percent-limit = 0
> +	queue-size = 0
> +	children = true
> +	group = true
> -- 
> 2.9.3
