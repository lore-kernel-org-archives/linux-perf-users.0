Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF7713B797;
	Mon,  7 Oct 2024 19:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728329076; cv=none; b=pXXwvlWxdogrTgeMDdLuMe+JmMd3jAbFTN1onRo2pLuOst7AIi0guzdqJueVsl39nMu5ZE2ezB323izMBvtaNoDGhlb0EdWKgJBybJcGA53gxsDnO07NaqggYMX/IEl0CJO5NTJbIefd30b9zYiop3FtTzE7RO7yWJJqirp0dfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728329076; c=relaxed/simple;
	bh=MJyteUBXzR7rkYONl8zAQVKdleok4P6vuQ1Z0LCohv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocUDb10uRZT55jfLuxy8dnTEd8iueS7DLtdVp75/MYVW/3tHZrwsGMKGzYDF/e45US6pXxfuQlYljbVS6dhpWKcC28igCE3nUkvjwGk1FjhBdFwGuOiC1VgrEyxd5vX/sgCPga0zNYkhqxTeNMtjgyRgP/4S8WyXaeD3e8dfLkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxJFGzSe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxJFGzSe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D36C4CEC6;
	Mon,  7 Oct 2024 19:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728329076;
	bh=MJyteUBXzR7rkYONl8zAQVKdleok4P6vuQ1Z0LCohv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UxJFGzSeq55JlqKAuiQRKTXuZxh6yPGQ0Sz6c4VxEhqQCUZsuo1FrJBLZ5aFvu3k4
	 AAfcjRrPqEBrTTUyIE+yE1xBu+V9TGckEopicJQXNthMTU7WJH4RemFIsZoWAD5aKE
	 NQ9YsclEX2zayMF1ji4E2WmnMi4it+UqMBQIHWUICamBa/REQCekbxIlFfbOqIMByR
	 Tk8XhRHmk7qE1NtZhnoQaRb3y8b6FaACflXi9o0TyjNFDqmCESd6LFEsfDenPgnhKD
	 La8DljEE1S23CfaMBgo2RfVeESrgz+aOpsHuq7nG+DFq0CWVB5G+OeP2Ej/fCiefq3
	 j+f3abeWb25Gw==
Date: Mon, 7 Oct 2024 12:24:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	eranian@google.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	santosh.shukla@amd.com, ananth.narayan@amd.com,
	sandipan.das@amd.com
Subject: Re: [PATCH 5/8] perf/amd/ibs: Don't allow freq mode event creation
 through ->config interface
Message-ID: <ZwQ1cRhRuE3kunjK@google.com>
References: <20241007034810.754-1-ravi.bangoria@amd.com>
 <20241007034810.754-6-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007034810.754-6-ravi.bangoria@amd.com>

On Mon, Oct 07, 2024 at 03:48:07AM +0000, Ravi Bangoria wrote:
> Most perf_event_attr->config bits directly maps to IBS_{FETCH|OP}_CTL
> MSR. Since the sample period is programmed in these control registers,
> IBS PMU driver allows opening an IBS event by setting sample period
> value directly in perf_event_attr->config instead of using explicit
> perf_event_attr->sample_period interface.
> 
> However, this logic is not applicable for freq mode events since the
> semantics of control register fields are applicable only to fixed
> sample period whereas the freq mode event adjusts sample period after
> each and every sample. Currently, IBS driver (unintentionally) allows
> creating freq mode event via ->config interface, which is semantically
> wrong as well as detrimental because it can be misused to bypass
> perf_event_max_sample_rate checks.
> 
> Don't allow freq mode event creation through perf_event_attr->config
> interface.

Sounds reasonable.  I agree the freq mode should use the standard
interface using attr->sample_freq.  But I'm not sure if the behaivor is
defined when attr->freq is set and attr->sample_freq is 0.  Maybe this
should be handled in the generic code.

Thanks,
Namhyung

> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 152f9116af1e..368ed839b612 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -302,6 +302,9 @@ static int perf_ibs_init(struct perf_event *event)
>  	} else {
>  		u64 period = 0;
>  
> +		if (event->attr.freq)
> +			return -EINVAL;
> +
>  		if (perf_ibs == &perf_ibs_op) {
>  			period = (config & IBS_OP_MAX_CNT) << 4;
>  			if (ibs_caps & IBS_CAPS_OPCNTEXT)
> -- 
> 2.46.2
> 
