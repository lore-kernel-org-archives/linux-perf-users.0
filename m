Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDA814A630;
	Fri, 24 Jan 2025 00:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737678313; cv=none; b=j8/eK8lafGwBJNF3Wtb9O3NfZG9Auub16OBSc7jzAnjKmhYE9N13V8LPPkgookLj0eBOGulmiWYtJK6ji8fry9iI00u3YIiAccAi/6oK6QV6EjVIQRZY45lEc/YKqhNWPN/9D8Kd3fx6qG+4X49tPyNlv0oPxb+oIwQEf1IdMko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737678313; c=relaxed/simple;
	bh=+tbRR17szgQn1O/e6whVf7kJ/qMQQ5UO77xW+eAdOv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXQ17Md74/5Oi44booStRiSW/7jkER8JnOoY57rvAzJdJDa5bc7CWvykwV1xgSWADTUdtxYcu4e9vrhMpIxVpVEGiEVf4yXznKRl3aTjJAs+VUiky+lBQxOgnrdMhHTAs+zx5WJah5Ml+LsfXAsvi1FOtHp9D08a3h7THCrxxug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ay7sn3l/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ay7sn3l/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377D3C4CED3;
	Fri, 24 Jan 2025 00:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737678312;
	bh=+tbRR17szgQn1O/e6whVf7kJ/qMQQ5UO77xW+eAdOv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ay7sn3l/w+5Fsh4N/uTaKh2hoiHXNW7ARpmx9DxNE5YD8letw3Ra+mD9nAwzvRFI+
	 9il2Uq5L7k4WsoUcLP8WcwllkYnw+XPdxlZXK6Ml5MmbXxfQ/gKlRF7EM8x0pIoEzc
	 nGiT6T3h8vPzHqMcjToOv1tkB2ERTEDxOSXil8iXa3bPHOIjsWXX1kDLiDpl8mjugE
	 1o9I829JhV8tR2itcUPO0Q+2l+Mfyj108F4Ew4J4YVyFC+mdlbcpvvoPbrfS9H860e
	 t+lHdcPObR+sUaNnBllMp48do1SUqyfTB7ljsWX1YL95VaX9F7KdQfcH/zJMHFHM+o
	 3akKeDqss3fCQ==
Date: Thu, 23 Jan 2025 16:25:10 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf probe: Introduce --no-advice option when a new
 event is created
Message-ID: <Z5Ld5irdG--_Efgl@google.com>
References: <20241214193452.16627-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241214193452.16627-1-atomlin@atomlin.com>

Hello,

Sorry for the late reply.

On Sat, Dec 14, 2024 at 07:34:52PM +0000, Aaron Tomlin wrote:
> This patch introduces a new option namely "--no-advice" to be used with
> the add command. Now one has the ability to avoid the generation of any
> advice when a new event is created. Thus making the output reasonable.
> For example:
> 
>   # perf probe --no-advice --add 'user_path_at%return return=$retval:s32'
>   Added new event:
>     probe:user_path_at__return (on user_path_at%return with return=$retval:s32)
>   #

Thanks for sending the patch but why do you care?  You can just ignore
the message.

Thanks,
Namhyung

> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  tools/perf/builtin-probe.c    | 4 +++-
>  tools/perf/util/probe-event.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
> index 69800e4d9530..36b8e08f3725 100644
> --- a/tools/perf/builtin-probe.c
> +++ b/tools/perf/builtin-probe.c
> @@ -391,7 +391,7 @@ static int perf_add_probe_events(struct perf_probe_event *pevs, int npevs)
>  	}
>  
>  	/* Note that it is possible to skip all events because of blacklist */
> -	if (event) {
> +	if (event && !probe_conf.no_advice) {
>  #ifndef HAVE_LIBTRACEEVENT
>  		pr_info("\nperf is not linked with libtraceevent, to use the new probe you can use tracefs:\n\n");
>  		pr_info("\tcd /sys/kernel/tracing/\n");
> @@ -577,6 +577,8 @@ __cmd_probe(int argc, const char **argv)
>  		   "directory", "path to kernel source"),
>  	OPT_BOOLEAN('\0', "no-inlines", &probe_conf.no_inlines,
>  		"Don't search inlined functions"),
> +	OPT_BOOLEAN('\0', "no-advice", &probe_conf.no_advice,
> +		"Don't provide any advice after a new event is created."),
>  	OPT__DRY_RUN(&probe_event_dry_run),
>  	OPT_INTEGER('\0', "max-probes", &probe_conf.max_probes,
>  		 "Set how many probe points can be found for a probe."),
> diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
> index 61a5f4ff4e9c..be0dce26e133 100644
> --- a/tools/perf/util/probe-event.h
> +++ b/tools/perf/util/probe-event.h
> @@ -14,6 +14,7 @@ struct probe_conf {
>  	bool	show_location_range;
>  	bool	force_add;
>  	bool	no_inlines;
> +	bool	no_advice;
>  	bool	cache;
>  	bool	bootconfig;
>  	int	max_probes;
> -- 
> 2.47.1
> 
