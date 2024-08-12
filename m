Received: from mx-8.mail.web4u.cz (smtp7.web4u.cz [81.91.87.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8333516C85D;
	Mon, 12 Aug 2024 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.91.87.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723456331; cv=none; b=FRSvWNG7bo7bTtiVuSMIH+auT9UvM1VdYZ9HWoewvYPA63csN8VQaiQTBhbmgnS1+TkP6M/lxMVeRPYFkdZ40ZzuJ/+XbY2cERgs2gAAhFG3+LzEcqFJoLL9+P2GEKAeIU5uUNICUeUfvXZ96tYYfbZV8f3cusLK5RzlRwFqHag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723456331; c=relaxed/simple;
	bh=Nr9BWj2ksg27MHMDKcxBvFSPQ/BgmCcwe0oFtlQS7HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYaSy03tx3IxeKDvpmWDoxlAHNczo8um0MzF6f0iZCck1p7MzQH3bYRYanjSM2nd1QK+ycUYWpsaMccaYjCBsM0/AHrS+EjiD0zJdW/06tyKZ66mkqLo5yFEzNFNZfgvyTtJgWrBknoBvaXx3us3ebn8+CjCU4LRV0BTkcu2Hfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=foxlink.cz; spf=pass smtp.mailfrom=foxlink.cz; arc=none smtp.client-ip=81.91.87.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=foxlink.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxlink.cz
Received: from mx-8.mail.web4u.cz (localhost [IPv6:::1])
	by mx-8.mail.web4u.cz (Postfix) with ESMTP id E54561FF3AE;
	Mon, 12 Aug 2024 11:42:31 +0200 (CEST)
Received: from [192.168.0.36] (unknown [193.86.188.206])
	(Authenticated sender: m.liska@foxlink.cz)
	by mx-8.mail.web4u.cz (Postfix) with ESMTPA id 8320B1FF16A;
	Mon, 12 Aug 2024 11:42:31 +0200 (CEST)
Message-ID: <c814c49f-fdd6-46cf-ba89-ca46ff7e64b9@foxlink.cz>
Date: Mon, 12 Aug 2024 11:42:31 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf script: add --addr2line option
To: irogers@google.com
Cc: acme@kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <CAP-5=fXPC+pXmJCpvkr5x2Ae1hdKeL7Cd6Uak+7mn+uG+R8yVQ@mail.gmail.com>
 <eadc3e36-029d-4848-9d69-272fe5a83a26@foxlink.cz>
Content-Language: en-US
From: =?UTF-8?Q?Martin_Li=C5=A1ka?= <m.liska@foxlink.cz>
In-Reply-To: <eadc3e36-029d-4848-9d69-272fe5a83a26@foxlink.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-W4U-Auth: b8f49746f1723c8f9d6af6e5d027af853e6509bd

@acme: May I please ping this patch?

Thanks,
Martin

On 7/19/24 12:57, Martin Liška wrote:
> Similarly to other subcommands (like report, top), it would be handy to
> provide a path for addr2line command.
> 
> Signed-off-by: Martin Liska <martin.liska@hey.com>
> ---
>  tools/perf/Documentation/perf-script.txt | 3 +++
>  tools/perf/builtin-script.c              | 2 ++
>  tools/perf/util/symbol_conf.h            | 2 +-
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index ff086ef05a0c..5abb960c4960 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -369,6 +369,9 @@ OPTIONS
>  --demangle-kernel::
>  	Demangle kernel symbol names to human readable form (for C++ kernels).
>  
> +--addr2line=<path>::
> +	Path to addr2line binary.
> +
>  --header
>  	Show perf.data header.
>  
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c16224b1fef3..932167b2362b 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -4052,6 +4052,8 @@ int cmd_script(int argc, const char **argv)
>  			"Enable symbol demangling"),
>  	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
>  			"Enable kernel symbol demangling"),
> +	OPT_STRING(0, "addr2line", &symbol_conf.addr2line_path, "path",
> +			"addr2line binary to use for line numbers"),
>  	OPT_STRING(0, "time", &script.time_str, "str",
>  		   "Time span of interest (start,stop)"),
>  	OPT_BOOLEAN(0, "inline", &symbol_conf.inline_name,
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> index c114bbceef40..d41b25e10f1b 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -63,7 +63,7 @@ struct symbol_conf {
>  			*sym_list_str,
>  			*col_width_list_str,
>  			*bt_stop_list_str;
> -	char		*addr2line_path;
> +	const char		*addr2line_path;
>  	unsigned long	time_quantum;
>         struct strlist	*dso_list,
>  			*comm_list,
