From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3 10/11] perf tools report: Implement browsing of
 individual samples
Date: Mon, 4 Mar 2019 16:27:33 +0100
Message-ID: <20190304152733.GM19809@krava>
References: <20190228183550.14126-1-andi@firstfloor.org>
 <20190228183550.14126-11-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190228183550.14126-11-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Feb 28, 2019 at 10:35:49AM -0800, Andi Kleen wrote:

SNIP

> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 6040eb49ea23..ba8a58f2cdd0 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -593,6 +593,40 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
>  	return he;
>  }
>  
> +static unsigned random_max(unsigned high)
> +{
> +	unsigned thresh = -high % high;
> +	for (;;) {
> +		unsigned r = random();
> +		if (r >= thresh)
> +			return r % high;
> +	}
> +}
> +
> +static void hists__res_sample(struct hist_entry *he, struct perf_sample *sample)
> +{
> +	struct res_sample *r;
> +	int j;
> +
> +	if (!he->res_samples) {
> +		he->res_samples = calloc(sizeof(struct res_sample),
> +					symbol_conf.res_sample);
> +		if (!he->res_samples)
> +			return;
> +	}

please allocate this in hist_entry__init

thanks,
jirka
