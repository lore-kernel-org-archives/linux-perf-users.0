From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] Properly interpret indirect call in perf annotate.
Date: Thu, 23 Aug 2018 11:12:19 -0300
Message-ID: <20180823141219.GA4766@kernel.org>
References: <bd1f3932-be2b-85f9-7582-111ee0a43b07@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bd1f3932-be2b-85f9-7582-111ee0a43b07@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc: linux-perf-users@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Aug 23, 2018 at 02:29:34PM +0200, Martin Liška escreveu:
> The patch changes interpretation of:
> callq  *0x8(%rbx)
> 
> from:
>   0.26 │     → callq  *8
> to:
>   0.26 │     → callq  *0x8(%rbx)
> 
> in this can an address is followed by a register, thus
> one can't parse only address.

Please mention one or two functions where such sequence appears, so that
others can reproduce your before/after more quickly,

- Arnaldo
 
> Signed-off-by: Martin Liška <mliska@suse.cz>
> ---
>  tools/perf/util/annotate.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> 

> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index e4268b948e0e..e32ead4744bd 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -246,8 +246,14 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
>  
>  indirect_call:
>  	tok = strchr(endptr, '*');
> -	if (tok != NULL)
> -		ops->target.addr = strtoull(tok + 1, NULL, 16);
> +	if (tok != NULL) {
> +		endptr++;
> +
> +		/* Indirect call can use a non-rip register and offset: callq  *0x8(%rbx).
> +		 * Do not parse such instruction.  */
> +		if (strstr(endptr, "(%r") == NULL)
> +			ops->target.addr = strtoull(endptr, NULL, 16);
> +	}
>  	goto find_target;
>  }
>  
> 
