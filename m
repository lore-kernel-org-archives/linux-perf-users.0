From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 11/11] perf tools report: Implement browsing of
 individual samples
Date: Mon, 25 Feb 2019 13:56:15 +0100
Message-ID: <20190225125615.GI19795@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-12-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190224153722.27020-12-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, eranian@google.com, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Sun, Feb 24, 2019 at 07:37:22AM -0800, Andi Kleen wrote:

SNIP

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
> +	if (he->num_res < symbol_conf.res_sample) {
> +		j = he->num_res++;
> +	} else {
> +		j = random_max(++he->num_res + 1);

will he->num_res keep raising all the time?

jirka

> +		if (he->num_res > symbol_conf.res_sample)
> +			return;
> +	}
> +	r = &he->res_samples[j];
> +	r->time = sample->time;
> +	r->cpu = sample->cpu;
> +	r->tid = sample->tid;
> +}
> +


SNIP
