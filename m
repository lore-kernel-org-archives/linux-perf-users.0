Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD10146D59
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169436; cv=none; b=Pl5/1nrgOgaWvWRhAvOdNaluqFUb4hjSjfGDIf2OrtGsCq3e+Wz9nBjbCgdXqwaqosunBRl/aD761FXfQ5UGFECczUX+WyinnKlvKXwxZBV1WMazL2YBmAxRHsv95Udh0HvZRBSKhdZtWH4q4VB9Of8VfHHsEv1fIVVltm3Gans=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169436; c=relaxed/simple;
	bh=x/O9coMrcpRq3V9Li1EhROiSGoTOGxZ/zkr3pypYcEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=f3yPbWdFjaOfnKZxjeXw5hQN3ow18xceujSuPTlt+JXeN5S95Ev3jNx5Pqk7X/Qov9nuB9DCXi7WmbhwdTuLqNKfIuKH8XOwwCirKExZLR/WSKuBLkaDbW5Tha70nP+pfTFidieVOmd5JdYKlm4v4HfduxMOICdPAWHQhZfjBqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TcoZ2pgb; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TcoZ2pgb"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c40942358eso8748169a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 02:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727169432; x=1727774232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zWxpwSxgLzbVRpzh8BPtUo4Pwl6suLBEsCM/MSlHNRQ=;
        b=TcoZ2pgbWs96D8jUUZml5nXT1hnnNSearPWzA/JOCymQRU1aubE0Glhpa9rqb0jau1
         PHRU2k+HOJqdNYLY3baQrXgAhongfW/F/GcL2ADbSmoZCagMuqqe/lTZgleU2HlJXh3G
         GlxxhkZ+TB3GDLS1UIm2iF3GHCT6YapTjCoaXEk1ehAaCuhLzU6xw3HzZVcEe0mK5uFG
         4+DZA/S07/OGoOr1bqNCZIo1I45kQQ1VSipITJwDwEOoXfILz/BqoaGE4tuAquJZ/2dD
         aA+inwPVq7CjAj9LbXtMQcWEzFNu2qcEjbJYfrZQSTtCR4SMxhAjAMw5sPPLITHn7eMP
         9jGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727169432; x=1727774232;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWxpwSxgLzbVRpzh8BPtUo4Pwl6suLBEsCM/MSlHNRQ=;
        b=lA7JtK9Zkfx2VcXLphFsiDIxCB8rXXlyYUrxzEe/KQtT6v9p6mam5t5TwkqmB2KX/W
         0sQe6w0qQiI/exQVxoS1UzHtbYJtlg4GspE+AijAnqd92aoZPUH4SL9+4Q0GAg+MuB+J
         2JUlzasuvF0McHfSKKEJjQJmK9q//YFwd1wLXRpnuXCD579SqBVE/NEbDdXfG1oTArcj
         Ux9JarhzPCewwYHbqF+LJ+RsNINqtIIMdVrAmPxrBp2VeqgPaqoavVw8I1HvksiN073G
         qDcYnSTLsQ0f381/32ct86AzGISlCcKT/SYyIJ7IOqlGtfkCOUNV9GeE75h2dr0Zq6S0
         WREg==
X-Forwarded-Encrypted: i=1; AJvYcCWH1xjzQH26+WVbXPNw7MBiyizQMHZLlA/4V7EFzBQfSSHlVHkcomH4PA9tzglTCb3fl9W45iMRokGAqYJrxaU6@vger.kernel.org
X-Gm-Message-State: AOJu0YxmYdqPDZx3qlZWE1FpwbkP1d0rrrRmyfmBjnDd31BrW1F+cNSD
	gL8K7YEvifYU3DAqIH9yTf46KN1YPQum5QpjuD2pzXxmBG6URSVPAuYSFwnr0Jw=
X-Google-Smtp-Source: AGHT+IEgqx6xzdAv+9H+cDifB7rWWZP4tPimo1MjDQXtQOXXDqbgo77FI2vmPWj19KpXCJg0Y91Vgg==
X-Received: by 2002:a50:85cc:0:b0:5c4:1c89:6e36 with SMTP id 4fb4d7f45d1cf-5c5cdfff686mr2178053a12.19.1727169431657;
        Tue, 24 Sep 2024 02:17:11 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf495db3sm545122a12.21.2024.09.24.02.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 02:17:11 -0700 (PDT)
Message-ID: <de38a809-1968-4d6d-b1ed-1f47e8762ee2@linaro.org>
Date: Tue, 24 Sep 2024 10:17:08 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] perf probe: Fix libdw memory leak
To: Ian Rogers <irogers@google.com>
References: <20240924003720.617258-1-irogers@google.com>
 <20240924003720.617258-3-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 "Steinar H. Gunderson" <sesse@google.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yang Jihong <yangjihong@bytedance.com>,
 leo.yan@arm.com
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240924003720.617258-3-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/09/2024 1:37 am, Ian Rogers wrote:
> Add missing dwarf_cfi_end to free memory associated with probe_finder
> cfi_eh or cfi_dbg. This addresses leak sanitizer issues seen in:
> tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> 
> Fixes: 270bde1e76f4 ("perf probe: Search both .eh_frame and .debug_frame sections for probe location")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/util/probe-finder.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 630e16c54ed5..78f34fa0c391 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -1379,6 +1379,11 @@ int debuginfo__find_trace_events(struct debuginfo *dbg,
>   	if (ret >= 0 && tf.pf.skip_empty_arg)
>   		ret = fill_empty_trace_arg(pev, tf.tevs, tf.ntevs);
>   
> +#if _ELFUTILS_PREREQ(0, 142)
> +	dwarf_cfi_end(tf.pf.cfi_eh);
> +	dwarf_cfi_end(tf.pf.cfi_dbg);
> +#endif
> +

I noticed that c06547d converted an _ELFUTILS_PREREQ(0, 142) into 
HAVE_DWARF_CFI_SUPPORT. But there is still a mixture of both in the code 
(unrelated to this patch). The commit message doesn't say why it is 
better, just that it could be changed, so I'm not sure which one is right.

