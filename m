Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EAE2868B;
	Wed, 31 Jul 2024 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722450068; cv=none; b=gDNKDl5cbSuH51+MkUkXuW9iXAkMz+7H3bW1MKxet+FLX+gMhJpCcgmxP5eJSawem/kUUYje+YDtAf84J0XPMGEL2x86z8MNZwlhNU4JNksV1qKU94/vlS4DDwvBUZaP1oRQHVcagMvnqzIC4Xi9mZRqN+RALNCCM436D09IcqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722450068; c=relaxed/simple;
	bh=VdEye2jTkmKFtiaXEoH9vld+unsPx+YqDgjQAU++yBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+JRHz2t6WTdDG2+DHRs7AE9NixDCnaH2h4JeisJX1hafK9BSfxu9LOlYLuat/ehfYjw+koQIEIyrcUyIIeji8/7mlOUVbgD2Lq5UfR07P+X8DTqrTBADb0RUoycu6EqrGcQ07nE0Qgenl7QHv6REGCvJp0dhAKNbFZgazQ3L4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLIfzR2l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLIfzR2l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D040C116B1;
	Wed, 31 Jul 2024 18:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722450067;
	bh=VdEye2jTkmKFtiaXEoH9vld+unsPx+YqDgjQAU++yBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JLIfzR2lX3pOOR5VS7dk3awIliw7ZS3o3Du2+kGjdHvgeoxYunnt0y6xtqT1yRHjH
	 oHAu3oMyReXikLss54p/Sp+XuC/IK7io90x/kpuL0ATIj1bi8KnDoBgE08ehy9C60O
	 1Eo4au1ndzYJy6Q6jwcxSD9J5nfw3jTAASqtZjUqSab5SCgzd5daP/teP8BhGN1VHL
	 slqhdByNXYQmbodxqH1HBlWZB0Wfyfyl+NWPBWNwkDYOK1YY9Dkj9HroyEiL7bDcRD
	 THJS7rOhg1Q9JY8fYF2iwUxaV2F6ukMiVKA+CcucrxNpyKM1xkw7rnfHtjD0yy6G/E
	 wZUHctmbQxeiQ==
Date: Wed, 31 Jul 2024 11:21:05 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1] perf inject: Fix leader sampling inserting additional
 samples
Message-ID: <ZqqAkcz4xOto_sK5@google.com>
References: <20240729220620.2957754-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240729220620.2957754-1-irogers@google.com>

Hi Ian,

On Mon, Jul 29, 2024 at 03:06:20PM -0700, Ian Rogers wrote:
> The processing of leader samples would turn an individual sample with
> a group of read values into multiple samples. Perf inject would pass
> through the additional samples increasing the output data file size:
> 
> ```
> $ perf record -g -e "{instructions,cycles}:S" -o perf.orig.data true
> $ perf script -D -i perf.orig.data | sed -e 's/perf.orig.data/perf.data/g' > orig.txt
> $ perf inject -i perf.orig.data -o perf.new.data
> $ perf script -D -i perf.new.data | sed -e 's/perf.new.data/perf.data/g' > new.txt
> $ diff -u orig.txt new.txt
> --- orig.txt    2024-07-29 14:29:40.606576769 -0700
> +++ new.txt     2024-07-29 14:30:04.142737434 -0700
> ...
> -0xc550@perf.data [0x30]: event: 3
> +0xc550@perf.data [0xd0]: event: 9
> +.
> +. ... raw event: size 208 bytes
> +.  0000:  09 00 00 00 01 00 d0 00 fc 72 01 86 ff ff ff ff  .........r......
> +.  0010:  74 7d 2c 00 74 7d 2c 00 fb c3 79 f9 ba d5 05 00  t},.t},...y.....
> +.  0020:  e6 cb 1a 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
> +.  0030:  02 00 00 00 00 00 00 00 76 01 00 00 00 00 00 00  ........v.......
> +.  0040:  e6 cb 1a 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> +.  0050:  62 18 00 00 00 00 00 00 f6 cb 1a 00 00 00 00 00  b...............
> +.  0060:  00 00 00 00 00 00 00 00 0c 00 00 00 00 00 00 00  ................
> +.  0070:  80 ff ff ff ff ff ff ff fc 72 01 86 ff ff ff ff  .........r......
> +.  0080:  f3 0e 6e 85 ff ff ff ff 0c cb 7f 85 ff ff ff ff  ..n.............
> +.  0090:  bc f2 87 85 ff ff ff ff 44 af 7f 85 ff ff ff ff  ........D.......
> +.  00a0:  bd be 7f 85 ff ff ff ff 26 d0 7f 85 ff ff ff ff  ........&.......
> +.  00b0:  6d a4 ff 85 ff ff ff ff ea 00 20 86 ff ff ff ff  m......... .....
> +.  00c0:  00 fe ff ff ff ff ff ff 57 14 4f 43 fc 7e 00 00  ........W.OC.~..
> +
> +1642373909693435 0xc550 [0xd0]: PERF_RECORD_SAMPLE(IP, 0x1): 2915700/2915700: 0xffffffff860172fc period: 1 addr: 0
> +... FP chain: nr:12
> +.....  0: ffffffffffffff80
> +.....  1: ffffffff860172fc
> +.....  2: ffffffff856e0ef3
> +.....  3: ffffffff857fcb0c
> +.....  4: ffffffff8587f2bc
> +.....  5: ffffffff857faf44
> +.....  6: ffffffff857fbebd
> +.....  7: ffffffff857fd026
> +.....  8: ffffffff85ffa46d
> +.....  9: ffffffff862000ea
> +..... 10: fffffffffffffe00
> +..... 11: 00007efc434f1457
> +... sample_read:
> +.... group nr 2
> +..... id 00000000001acbe6, value 0000000000000176, lost 0
> +..... id 00000000001acbf6, value 0000000000001862, lost 0
> +
> +0xc620@perf.data [0x30]: event: 3
> ...
> ```
> 
> This behavior is incorrect as in the case above perf inject should
> have done nothing. Fix this behavior by disabling separating samples
> for a tool that requests it. Only request this for `perf inject` so as
> to not affect other perf tools. With the patch and the test above
> there are no differences between the orig.txt and new.txt.
> 
> Fixes: e4caec0d1af3 ("perf evsel: Add PERF_SAMPLE_READ sample related processing")
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/builtin-inject.c | 1 +
>  tools/perf/util/session.c   | 3 +++
>  tools/perf/util/tool.h      | 1 +
>  3 files changed, 5 insertions(+)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index a212678d47be..c80fb0f60e61 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2204,6 +2204,7 @@ int cmd_inject(int argc, const char **argv)
>  			.finished_init	= perf_event__repipe_op2_synth,
>  			.compressed	= perf_event__repipe_op4_synth,
>  			.auxtrace	= perf_event__repipe_auxtrace,
> +			.dont_split_sample_group = true,
>  		},
>  		.input_name  = "-",
>  		.samples = LIST_HEAD_INIT(inject.samples),
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 5596bed1b8c8..080242c69196 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1511,6 +1511,9 @@ static int deliver_sample_group(struct evlist *evlist,
>  	int ret = -EINVAL;
>  	struct sample_read_value *v = sample->read.group.values;
>  
> +	if (tool->dont_split_sample_group)
> +		return deliver_sample_value(evlist, tool, event, sample, v, machine);
> +
>  	sample_read_group__for_each(v, sample->read.group.nr, read_format) {
>  		ret = deliver_sample_value(evlist, tool, event, sample, v,
>  					   machine);
> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
> index c957fb849ac6..62bbc9cec151 100644
> --- a/tools/perf/util/tool.h
> +++ b/tools/perf/util/tool.h
> @@ -85,6 +85,7 @@ struct perf_tool {
>  	bool		namespace_events;
>  	bool		cgroup_events;
>  	bool		no_warn;
> +	bool		dont_split_sample_group;
>  	enum show_feature_header show_feat_hdr;
>  };
>  
> -- 
> 2.46.0.rc1.232.g9752f9e123-goog
> 
