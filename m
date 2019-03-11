From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v5 11/15] perf tools report: Implement browsing of
 individual samples
Date: Mon, 11 Mar 2019 13:32:27 +0100
Message-ID: <20190311123227.GA26829@krava>
References: <20190309055628.21617-1-andi@firstfloor.org>
 <20190309055628.21617-12-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190309055628.21617-12-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Fri, Mar 08, 2019 at 09:56:24PM -0800, Andi Kleen wrote:

SNIP

> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 08e2b3be4c1b..da3a944f42aa 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -445,6 +445,14 @@ static int hist_entry__init(struct hist_entry *he,
>  			return -ENOMEM;
>  		}
>  	}
> +
> +	if (symbol_conf.res_sample) {
> +		he->res_samples = calloc(sizeof(struct res_sample),
> +					symbol_conf.res_sample);
> +		if (!he->res_samples)

you need to free the memory in here, anyway this function
just changed, so please rebase on latest Arnaldo's perf/core

jirka

> +			return -ENOMEM;
> +	}
> +

SNIP
