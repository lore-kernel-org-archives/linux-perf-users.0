Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795784862;
	b=EvQnEKcIgkumCQiWZwwsX69Dp102UOkvgd3o/bf/lQEofpkOQJ/mbhcvylHRV4/DR+Ty
	 8hXRPMPVF1xngAamF5DYADZo+IISn6LtATTV8H18RKLaIlmJL3wWMRIpQp1Ql5yFHrBVI
	 Ho3llM3Yr5SMq0zTiv45TNOhXOU8VJCwfBWUtiPYoZ8tOvSeMRIBuhjDbBZX9sRmrio3J
	 lyhMts4Ywm6TRjZgxTb5PlH0INzgHSwiQ4NDuevtQ2UoaKhk4dLhIVIsB9vUbP9feUPT4
	 UXQa3Dyz4hNonO2rsbvjw6jITSR910qDetRKEIb6ZnGtGEmt+jgkEUTw1eV6mOP65mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795784862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=kIn3Z40GB3Fv6RQJNleZ9bonkImRIY4BwaanX9JUugM=;
	b=JlUYi5t18abXOn7bMPq5Pb4Qjj7F3bnf0B69WdLEZ9NNyn7js7jS6bjuEb9RuW6p1Kya
	 swbig2ixsoi0fKg+Pzk1QJW5pWigCKiQTI9gTSYN37lUwfdnXgM1uDhOc5XdPTWn1lLUb
	 njYMSV8RPlg2V2U9XLJjvP0s2sxLQR3xB4ulN0LfpgnAPeW+mRmSjqvG8ZIkUT+HHfU+8
	 6iM78C4DAuOjyShRzMWcqOCBWYHSPTbdUivLEmT7Mo2lNYEZwQHTRZhi8a9a+DyTeOdLu
	 OqGOZaEUnS89mSr7KaPN7ByvFvmXj4Ri7y5NKafur4RJtrtCzGEfOMlo585e3DRaNWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=csHhW7oT;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7B3606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 13:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD7B3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=csHhW7oT
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so69534905e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 05:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795784860; x=1796389660; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kIn3Z40GB3Fv6RQJNleZ9bonkImRIY4BwaanX9JUugM=;
        b=csHhW7oTx/7IUXKBRYeC+C+z7IgdGVPU5zrgJhMaisMEotfSmxmYQzrUBUAj2EI2vj
         L44sPJZxi/FDJsBAJp18JKdXG/3Ih8ijYCzcHe5fGgtd58WF2GcPMdc0Fgj02DuXf3+t
         btRZYQXSlKdhUexvevGSlQDPveUZIwg8Vy7uY5cnLKuny9n2Z2yAZIpwDzO61CPWbU48
         hiTSzeX1YkTfLpezfeofyAYaAU6I/GpqVI8kyXFUIYDN4WsAwV2XbhPFgDYtNHk4RJMO
         37TgJsRfueLD6z2n8frUtpydcroGwBJWVLetLTc+bNH0Zkv1aH3uEGPwSiepLrR0YCkS
         G0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795784860; x=1796389660;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kIn3Z40GB3Fv6RQJNleZ9bonkImRIY4BwaanX9JUugM=;
        b=pUEHqMkypi+89t/ol8JWXbvnBSV7TLjQqfdZM6P4geKjRF7ytmIgsnYRXX4Gtvy2N+
         dA7tmjPYaR+JCU9T4wmPiRm4WJIlEWvBTR0tSEgi/WMDJzLXVrM4z4WffFFxZtmYFt3Y
         Jr0VbgUBOTdNxQRjyFEfkZwQtlKJfvRXXJbSFWhpFJ3GC7HXTySK9Jws+8XH6U/5itLO
         hquVUEVHNP2xa6OkoveR3E0X4OmAFb2Ksq4bXTNkBIN0/vm2GQHFyxyq27ftILY7Mj6A
         CCSUpsNzmNzrgHrnzyKSXee6cJdEZYPHVlOvFlIkRso3te7+1art7ceEJWjG+lQShIQ4
         Emug==
X-Forwarded-Encrypted: i=1; AL+hErGSUca4/+rxFnIy3+M3YnzGf8qxEBd3b5Y6h0QkrDFotudx10bYch0FfPIzzyMvX8HvJANL6HxBETKG9V+KqmpE@vger.kernel.org
X-Gm-Message-State: APuU4Z88BfabEVsWVjGH0Chi6DaYQ6oxmtkcrWMCeHalv0iznZSne03a
	Gn9pqsAQOXjEal0WbUJo37GYm56/+GX2KPKIoXHQcijRyl4wnM6nWxMz8vTTGolBSt0D9XAAx25
	sSg3p
X-Gm-Gg: AZFdTZfrEvecbBgXdBO+K9M29hAEMLMU/PuwGlcr+/ZBwwChywNQ1b/lOmS/2nk8555
	ehhRZzu0o3oiwhX75mWEmcMrXUADngEEG2cNCXZLbqgF3N4e8lITQh+w4XCVn8SXLDLabO2rhqw
	iQvl68aJtmVMNGuG4499WlBP9BcO8LaqhSdlQVXOj6dHB0n2EI1iS/anh9AOILt4ZZUb3oaU6rh
	0CgIdvDK0yGOoLjhi6mxaZMI1xDdVrpUPqi1B7X/Vgyba+JRWE202n62RXM2c5y8J3H8s5YcjEo
	Rn5JAjzkVZT6dAWYurQ1RdwDIATJcdPXMCtLeYKetMMUW2RSuDHdbq21sgcBPtMYWG9y7psso5c
	iamybN4p/bU1bhzIr9vcaRnhFXD/clKwHKrVj/S+oWHFp7yQi4E+cHqPnrJY/xyDlOcdm2F4ka9
	YKdLpoo3XVDShqGYqqdZhydAapPawWi3JicyrReFvuMbfYvOMp3x3+lsRcCuKfhOPNl5So38h1S
	d0ogdofS4PeuqnzitNQGbxdZt9jN1rx1DED5QLF525+si7aIo94L8Ab78/CrcjXuIzNTjJNErvo
	gYNWtlyQR2MJno1X7XcyM6HGrSsAV/tpXg==
X-Received: by 2002:a05:600c:6749:b0:4a2:d99:3171 with SMTP id 5b1f17b1804b1-4bb8881b52dmr457902075e9.23.1795784859950;
        Fri, 27 Nov 2026 05:07:39 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442995sm725641925e9.2.2026.11.27.05.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 05:07:39 -0800 (PST)
Message-ID: <f1cd9130-76d3-4828-9cd0-aebb43e51de2@linaro.org>
Date: Fri, 27 Nov 2026 13:07:38 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf arm-spe: Honor --time ranges when synthesizing
 samples
To: Jan Bernloehr <jbernloehr@nvidia.com>
Cc: Leo Yan <leo.yan@linux.dev>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@arm.com>, John Garry <john.garry@linux.dev>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matt Ochs <mochs@nvidia.com>,
 Linux perf Profiling <linux-perf-users@vger.kernel.org>
References: <20261127123855.78212-1-jbernloehr@nvidia.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261127123855.78212-1-jbernloehr@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/11/2026 12:38, Jan Bernloehr wrote:
> perf script and perf report pass their --time ranges to the AUX trace
> decoders through itrace_synth_opts. Intel PT uses them to skip decoding
> outside the ranges, but Arm SPE ignores them: it synthesizes a sample
> for every record, only for the tool to drop the samples outside the
> ranges in its sample handler.
> 
> Check each record's timestamp against the ranges before synthesizing
> samples for it. The check runs after the --itrace period count and
> converts the record timestamp with tsc_to_perf_time(), as
> arm_spe_prep_sample() does for sample->time, so the tool receives the
> same samples as before. Without timestamps (timeless decoding) nothing
> changes.
> 
> Decoding still runs to the end of each queue rather than stopping at the
> first record past the last range: record timestamps do not always
> increase within a queue, and on Neoverse V2 traces such an early stop
> dropped samples that were inside the range.

Do you care that timestamps don't always increase? Seems like it would 
be acceptable to stop after the first timestamp that you see outside of 
the range, even if there are some edge cases where there may be an 
earlier one later.

Also can you elaborate why they don't always increase? I would have 
thought that they would always generally increase in SPE data, if not 
for some allowance for instruction re-ordering or something like that. 
But that would be tiny and not really relevant for this feature.

> 
> On 28 GB and 55 GB Neoverse V2 traces, perf script --itrace=i1i with
> --time=70%-95% goes from 212 s to 188 s and from 383 s to 339 s, and
> with --time=70%-70.01% from 101 s to 72 s and from 188 s to 131 s, with
> byte-identical output.
> 
> The code and this message were drafted with an AI coding assistant
> (Claude Opus 5.5).
> 
> Signed-off-by: Jan Bernloehr <jbernloehr@nvidia.com>
> ---
> Tested on GB200 (Neoverse V2) with two perf.data files (28 GB, 55 GB)
> recorded with
>    perf record -e 'arm_spe_0/branch_filter=1,event_filter=0x2,jitter=1,period=4096/u'
> and decoded with
>    perf script --itrace=i1i -F comm,tid,cpu,time,period,event,addr,ip,dso --no-demangle
> using perf-tools-next 29fd95dbd25 with and without this patch:
> 
>                            28 GB            55 GB
>    --time=70%-95%          212 s -> 188 s   383 s -> 339 s
>    --time=70%-70.01%       101 s ->  72 s   188 s -> 131 s
>    --itrace=i10i 70%-95%    84 s ->  81 s   150 s -> 147 s
> 
> Output was byte-identical to the unpatched perf in every case.
> 
> An earlier version also stopped decoding a queue at its first record past
> the last range. On the 55 GB trace that dropped 21% of the in-range
> samples, because some queues produced in-range records after a record
> stamped past the range, so this version decodes every queue to the end.
> 
>   tools/perf/util/arm-spe.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 8d95df23be6..bf1e824ea76 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -26,6 +26,7 @@
>   #include "symbol.h"
>   #include "thread.h"
>   #include "thread-stack.h"
> +#include "time-utils.h"
>   #include "tsc.h"
>   #include "tool.h"
>   #include "util/synthetic-events.h"
> @@ -93,6 +94,9 @@ struct arm_spe {
>   
>   	u64				kernel_start;
>   
> +	struct perf_time_interval	*ptime_range;
> +	int				range_num;
> +
>   	unsigned long			num_events;
>   	u8				use_ctx_pkt_for_pid;
>   
> @@ -1077,6 +1081,19 @@ arm_spe__synth_data_source(struct arm_spe_queue *speq,
>   	return data_src;
>   }
>   
> +/*
> + * Check a record against the --time ranges. Samples outside them would only
> + * be dropped by the tool, so do not synthesize them.
> + */
> +static bool arm_spe__skip_record(struct arm_spe *spe, u64 timestamp)
> +{
> +	if (!spe->range_num)
> +		return false;
> +
> +	return perf_time__ranges_skip_sample(spe->ptime_range, spe->range_num,
> +					     tsc_to_perf_time(timestamp, &spe->tc));
> +}
> +
>   static int arm_spe_sample(struct arm_spe_queue *speq)
>   {
>   	const struct arm_spe_record *record = &speq->decoder->record;
> @@ -1092,6 +1109,9 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
>   		return 0;
>   	speq->sample_count = 0;
>   
> +	if (arm_spe__skip_record(spe, record->timestamp))
> +		return 0;
> +
>   	arm_spe__sample_flags(speq);
>   	data_src = arm_spe__synth_data_source(speq, record);
>   
> @@ -1255,6 +1275,17 @@ static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
>   	return 0;
>   }
>   
> +static void arm_spe__setup_time_ranges(struct arm_spe *spe,
> +				       struct itrace_synth_opts *opts)
> +{
> +	/* Without timestamps, samples cannot be filtered by time */
> +	if (!opts || !opts->range_num || spe->timeless_decoding)
> +		return;
> +
> +	spe->ptime_range = opts->ptime_range;
> +	spe->range_num = opts->range_num;
> +}
> +
>   static int arm_spe__setup_queue(struct arm_spe *spe,
>   			       struct auxtrace_queue *queue,
>   			       unsigned int queue_nr)
> @@ -2055,6 +2086,8 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>   	 */
>   	spe->synth_opts.period = spe->synth_opts.period ?: 1;
>   
> +	arm_spe__setup_time_ranges(spe, session->itrace_synth_opts);
> +
>   	if (spe->synth_opts.period > 1)
>   		ui__warning("Arm SPE has a hardware-based sampling period.\n\n"
>   			    "--itrace periods > 1i downsample by an interval of n SPE samples rather than n instructions.\n");

