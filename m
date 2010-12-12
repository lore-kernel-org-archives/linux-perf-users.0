From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: perf-probe: issue with latest fedora kernel
Date: Sun, 12 Dec 2010 12:08:52 -0200
Message-ID: <20101212140851.GA2343@ghostprotocols.net>
References: <m2pqtb9ekn.fsf@gmail.com>
 <20101209153548.GA11820@ghostprotocols.net>
 <m3tyimxeyc.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gx0-f180.google.com ([209.85.161.180]:43731 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892Ab0LLOOc (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 12 Dec 2010 09:14:32 -0500
Received: by gxk19 with SMTP id 19so3399065gxk.11
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Dec 2010 06:14:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m3tyimxeyc.fsf@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: Francis Moreau <francis.moro@gmail.com>, linux-perf-users@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Em Fri, Dec 10, 2010 at 08:30:19AM +0100, Franck Bui-Huu escreveu:
> Looks like a standard path is missing...
> 
> What about adding the one above since it looks like Fedora is installing
> their debug kernel images at this place ?

Can I get your signed-off-by on this one?

- Arnaldo
 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index d628c8d..0f914c7 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -2260,7 +2262,7 @@ static int vmlinux_path__init(void)
>  	if (uname(&uts) < 0)
>  		return -1;
>  
> -	vmlinux_path = malloc(sizeof(char *) * 5);
> +	vmlinux_path = malloc(sizeof(char *) * 6);
>  	if (vmlinux_path == NULL)
>  		return -1;
>  
> @@ -2288,6 +2290,12 @@ static int vmlinux_path__init(void)
>  	if (vmlinux_path[vmlinux_path__nr_entries] == NULL)
>  		goto out_fail;
>  	++vmlinux_path__nr_entries;
> +	snprintf(bf, sizeof(bf), "/usr/lib/debug/lib/modules/%s.debug/vmlinux",
> +		 uts.release);
> +	vmlinux_path[vmlinux_path__nr_entries] = strdup(bf);
> +	if (vmlinux_path[vmlinux_path__nr_entries] == NULL)
> +		goto out_fail;
> +	++vmlinux_path__nr_entries;
>  
>  	return 0;
>  
> -- 
> 		Franck
