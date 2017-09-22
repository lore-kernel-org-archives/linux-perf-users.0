From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 4/4] Replace printf with fprintf for all the output
 functions
Date: Fri, 22 Sep 2017 11:03:33 +0200
Message-ID: <20170922090333.GH15856@krava>
References: <1505714122-39141-1-git-send-email-yuzhoujian@didichuxing.com>
 <1505714122-39141-5-git-send-email-yuzhoujian@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1505714122-39141-5-git-send-email-yuzhoujian@didichuxing.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yuzhoujian <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Mon, Sep 18, 2017 at 01:55:22PM +0800, yuzhoujian wrote:

SNIP

>  		     data->deepest_cstate, data->last_cstate,
>  		     data->wake_reason);
>  	fprint_sample_pt_spacing(len, fp);
> @@ -1299,10 +1299,10 @@ static void fprint_sample_synth_cbr(struct perf_sample *sample, FILE *fp)
>  		return;
>  
>  	freq = (le32_to_cpu(data->freq) + 500) / 1000;
> -	len = printf(" cbr: %2u freq: %4u MHz ", data->cbr, freq);
> +	len = fprintf(fp, " cbr: %2u freq: %4u MHz ", data->cbr, freq);
>  	if (data->max_nonturbo) {
>  		percent = (5 + (1000 * data->cbr) / data->max_nonturbo) / 10;
> -		len += printf("(%3u%%) ", percent);
> +		len += fprintf(fp, "(%3u%%) ", percent);
>  	}
>  	fprint_sample_pt_spacing(len, fp);
>  }
> @@ -1377,7 +1377,7 @@ static size_t data_src__fprintf(u64 data_src, FILE *fp)
>  	if (maxlen < len)
>  		maxlen = len;
>  
> -	return printf("%-*s", maxlen, out);
> +	return fprintf(fp, "%-*s", maxlen, out);

all these 'fp' adding changes should be in separate patch

jirka
