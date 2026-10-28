Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180093;
	b=13nz+NcAFM6EAQWM4eojvFa9cVHJnfoF2qsMZkzIAEsQNhS/ssyVgDdkFuwhzn2K/GpI
	 +7BbAg2TSi+tMlmX7YSNbAnKW9is+3wN3OqPggakvj3Jb/6GK5sCi7IAXPsXSS0dH5whz
	 h9AiX4VmbRTnGijG1IqJEtMp+XSUWNkQJoPCo7pDgVXUS+UYag0T2I6dHxmZGn+QyCpG5
	 YCPkUKcvBnEpX+DZA6/41nUvc75leU4/50uCwku04eBQGHw0+rjmLoY1L29UNCN3Ro/j0
	 PUVTqDLe0qMIA35BCh2AICYjh4IHzeeC85YC4ToEqhSB8J1GFAs0lXhcukZbQMRfs2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Uz7TxrCpEZWGCaZAK5ft/7H16VUw5+yLoLa8TVo/kwI=;
	b=WfExIUnI47Z0VulWY8vgiLR7M4JnJFBoENwG7N9hsqXhUh/YgXtS1MDW5Tz9P3ogqoI7
	 zQZ3b89tJZrVqoBfX8BWwR2HEky0A1so4iZ5D9l+1/gb7f5jzwrlM5AuImGVddIae1kvl
	 rsqYiqLRrIbZfjP84wpHeA736e0P4Ss9hPFnh/MHJx8wIBi0ACv5O5Y0q9e5ljgL24wIJ
	 dlMbTgjKIleBH4c1Za1IWxfX7Ep2h19psSPm6TdwhX5n5XhBvUA0/J1/bq7ezimYCaqmI
	 FU+3m7U/n7DZBVRbI+sv9xMQ5x5ItJpnkNw2SR05QuruyDFsZ43BHWX2afV6kj4PZLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FdBXCTtO;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D6C606A31A
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 09:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2D6C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FdBXCTtO
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so6314835e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 02:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793180091; x=1793784891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uz7TxrCpEZWGCaZAK5ft/7H16VUw5+yLoLa8TVo/kwI=;
        b=FdBXCTtOGxYGiAkj9jk2edA+5oH9gpj7beKhTOhRE2sV7wdRnaCHYged9f/VjewsUZ
         q6PlNA2j/Q2uTKbwyKAP0Vi5gQnAG1QOkj4NTpWQVAZ9aGga8e6W//ViweWPg3m144dU
         cSGbqF4RlJQQrpc9BGicpfGp+J7krOeKVXetL+B+2hb8kVQQr2JC0BxKk/xTlhEqUukJ
         X4ElTqC97k+ZIDNzEWeukQ3hFeL7lh+FZa6JK+nkP/yakUGcN1SmykU5VclE9H8NRBLc
         C+YgYnyRDAksZUUFdfPkAgir8KmB2+Men+FC1qHS6YHu4IUV9dXbGO7t6k9q9RzLwfhk
         YvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180091; x=1793784891;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uz7TxrCpEZWGCaZAK5ft/7H16VUw5+yLoLa8TVo/kwI=;
        b=bXLT9eRCD9L8Y1QRblL2smhOPu4xMp3Q5OmzvnDVXPnH/dfp0wz+5mPclh8h9gEFE+
         nYbSMT8pSPiCczEOois2V007BFqPnTO296istLrfmuEqc00keaw2mAX02sz2OBJHFmrW
         YVNlYdTRHWYmyZpf5oPqP/3THEvC0dL2UY/TLwowkvreYaZDLkFj4sCA6W8vi5W+2Tzi
         0M6iTxO8+KigToVOpHeVyK0QTgjrHvIosZxcsd2feBzXeI4UfR09+wHIFe7g8dSfDcLR
         15PR1Sz8oh6aVcTn/mP606jLM+HcepbUcmzirjZB2BwceL4Yi9ReA78Uj/0u/FlwMJuE
         TSTg==
X-Forwarded-Encrypted: i=1; AKwUvBwk9VHcQ072n/CNfVizV3FwYe7h58CUisfrvJuCLnCWe9HZ2OAGGJj2fl8Fk1fd3Uz27VujcLYFQaW/yfFdqH3g@vger.kernel.org
X-Gm-Message-State: AFq9FYJbdTDpDtcgbj230gzt43QGsiyyWBlVlj1JrV05HPS9tBkX47tV
	hFqtYyQZlAjquTu0+msgBL1PBz+x/+7ET++t/sj2hO3zWq3yS61YtdbBfU/wf4b3bzY=
X-Gm-Gg: AYBFou0IkQO8sQxwmxA83keG+kYvIqzmC7E7ecSSgZ805NLpRkkMBlh0HNnuMLPhY1E
	SJrMbJn8BxCoatBdhlgeNwgOvm5CwYfmA2PAqCPuFXXJK56gA/ALxoIYZMN9326Ssm/Vtc2PsyZ
	f8EGrUP9NICLoZI1RjQhu6n+RMdJTpUQbhPzwhtJIsb+YhislgJlyo+wBjhyCFtia2ULp6GoVs/
	q2eaKnOfn2UE1Y4a13Y1alOVjUXofqNWBAxetUOkLyUsfIEJNTh+fmMVr7UtQSGdV/BDL98dqxq
	69jH9hWEnhqy51mOB6qTXVmEXhirmaQmE8iN7Axp/ZRYDVjHKBREtLoeUAnFu4pPZSvTaFit6Wu
	XabbKyqMTrEqx1H3AU68fu0Yp9EPazsNMnVwcvofdmu2n53xTZUyL7zmVbFpywF2FaiEtzN+sMC
	TEjOI9/U6x0GrZw/j+hCXskS6xjE+1KeAPqqVjgcw/j3VY2RnlR+D+bKHFl8IdbyA6alnNtqI67
	Egt81+2TyUhOssSkHLwEkU+z9C42onstVDiH7+JJgasaah7Zu9QXhhOkjkGGzPqfTKLOU0qyrbP
	bqnh83WHSJU2D/s+byfoXfvhHnAEOIS+fFLD9t8mcKjhrIupm9G1BtI=
X-Received: by 2002:a05:600c:848c:b0:4a1:fe26:24f0 with SMTP id 5b1f17b1804b1-4a966b4afc5mr39506605e9.20.1793180091431;
        Wed, 28 Oct 2026 02:34:51 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a978795f4dsm28997165e9.9.2026.10.28.02.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 02:34:51 -0700 (PDT)
Message-ID: <e93cac91-8fce-4c07-8632-fe37d53a18f6@linaro.org>
Date: Wed, 28 Oct 2026 09:34:50 +0000
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
Subject: Re: [PATCH v1 3/4] perf off-cpu: Fix cgroup_filter map sizing
To: Ian Rogers <irogers@google.com>
References: <20261027170415.2815859-1-irogers@google.com>
 <20261027170415.2815859-3-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Ankur Arora <ankur.a.arora@oracle.com>, Howard Chu <howardchu95@gmail.com>,
 Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261027170415.2815859-3-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/10/2026 17:04, Ian Rogers wrote:
> off_cpu_prepare() assumed that if evlist__first(evlist)->cgrp is set,
> the number of cgroups is evlist__nr_entries(evlist) - 1 (excluding the
> dummy bpf-output event). This can under-size cgroup_filter when
> non-cgroup events precede cgroup events or when no dummy bpf-output
> event is added.
> 
> Count the number of evsels in evlist that have a cgroup set and use that
> count to size and populate cgroup_filter.
> 
> Fixes: 685439a7a037 ("perf record: Add cgroup support for off-cpu profiling")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/util/bpf_off_cpu.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> index 16948761cc45..71933a71c8d1 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -151,9 +151,10 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
>   		    struct record_opts *opts)
>   {
>   	int err, fd, i;
> -	int ncpus = 1, ntasks = 1, ncgrps = 1;
> +	int ncpus = 1, ntasks = 1, ncgrps = 0;
>   	struct strlist *pid_slist = NULL;
>   	struct str_node *pos;
> +	struct evsel *evsel;
>   
>   	if (off_cpu_config(evlist) < 0) {
>   		pr_err("Failed to config off-cpu BPF event\n");
> @@ -208,8 +209,12 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
>   		skel->rodata->uses_tgid = 1;
>   	}
>   
> -	if (evlist__first(evlist)->cgrp) {
> -		ncgrps = evlist__nr_entries(evlist) - 1; /* excluding a dummy */
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (evsel->cgrp)
> +			ncgrps++;
> +	}
> +
> +	if (ncgrps > 0) {
>   		bpf_map__set_max_entries(skel->maps.cgroup_filter, ncgrps);
>   
>   		if (!cgroup_is_v2("perf_event"))
> @@ -274,8 +279,7 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
>   		}
>   	}
>   
> -	if (evlist__first(evlist)->cgrp) {
> -		struct evsel *evsel;
> +	if (ncgrps > 0) {
>   		u8 val = 1;
>   
>   		fd = bpf_map__fd(skel->maps.cgroup_filter);

Reviewed-by: James Clark <james.clark@linaro.org>

