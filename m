From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH] perf-tools: Don't assume there's no attr info if no
 sample ids is provided
Date: Tue, 30 Nov 2010 11:53:05 -0200
Message-ID: <20101130135305.GA9217@ghostprotocols.net>
References: <m3mxor6nex.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56121 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab0K3NxK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 30 Nov 2010 08:53:10 -0500
Received: by gxk3 with SMTP id 3so315736gxk.19
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Nov 2010 05:53:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m3mxor6nex.fsf@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Em Tue, Nov 30, 2010 at 12:50:14PM +0100, Franck Bui-Huu escreveu:
> From: Franck Bui-Huu <fbuihuu@gmail.com>
> 
> This primarily fixes perf-report, which didn't report the correct type
> of event if perf-record was called to record one event different from
> 'cycles':
> 
>   $ perf record -e instructions true
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.007 MB perf.data (~295 samples) ]
> 
>   $ perf report | head -n1
>     # Events: 7  cycles
> 
> Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
> ---
>  tools/perf/util/header.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)


Please CC lkml when submitting patches.

Thanks a lot, applied to my perf/urgent branch.

- Arnaldo
 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index d7e67b1..64a85ba 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -946,11 +946,16 @@ perf_header__find_attr(u64 id, struct perf_header *header)
>  
>  	/*
>  	 * We set id to -1 if the data file doesn't contain sample
> -	 * ids. Check for this and avoid walking through the entire
> -	 * list of ids which may be large.
> +	 * ids. This can happen when the data file contains one type
> +	 * of event and in that case, the header can still store the
> +	 * event attribute information. Check for this and avoid
> +	 * walking through the entire list of ids which may be large.
>  	 */
> -	if (id == -1ULL)
> +	if (id == -1ULL) {
> +		if (header->attrs > 0)
> +			return &header->attr[0]->attr;
>  		return NULL;
> +	}
>  
>  	for (i = 0; i < header->attrs; i++) {
>  		struct perf_header_attr *attr = header->attr[i];
> -- 
> 1.7.3.2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
