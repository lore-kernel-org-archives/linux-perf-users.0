Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B7F3C3791
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780608549; cv=none; b=UcJfDA7es+YChOB5nai6F50bVLuXd2X534dBaZPA3Mynnmw76OMAz6jC29aUxigyuIYXrjapQl3Z1xCIDSzGOjODUY5ArNw02+mK0uF8dc/iKjlCavLxp6mZQjK/RXHSXNujmQM8tsQPCNuAGuByo69dFc6BCjeUpdTkR/Dpp7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780608549; c=relaxed/simple;
	bh=UZ8kFPgqs+J2oHj24BN8tWLieBoiiPz7V/Wp8T5PipU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eb7giWTA1IDkwmkhRN4BTpLt9V5F6KRZbJQmHjC160SzAS+gJlbnzPCm03lFAJG1kD5kiBC6tuqAsbBG9003sc4w3Z4FtUvFxXZITQvYZHmSRLc+hhnjkFsuWJh9Zk0UCJgQRxF4mri7GwPT0ZUQH7N2vHGxbXVeTnQokPp4tc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gK5jpFJe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK5jpFJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0483A1F00893;
	Thu,  4 Jun 2026 21:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780608547;
	bh=c6ckXz0jHSF7OlhU8goFIPNCoGt+kO4377K8w7qudg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gK5jpFJer05CeHIirHxe9UPKOJ6T5GPCa3iSNqlkx7TksW9YKGzBHWezDJrSeEETS
	 qwTI1ZR2jMJPv8Aza2SoSZnxJXb+hrpcnVb3Xxj0yvhFXieHoJNcYQcqIYMshrRTBh
	 q2MxsFDH/17We1QV0FxywgE+OwFg3VLih228G5tRmJHdXy5fm8cvhbfWD3k13eihQO
	 mr+AN4G8ef36B/B85WZe/oIIBW19HoVZKK+1z/ZjHFbtTnLOOJR23J9Ec8f56I0fvO
	 o1P3JhzrMr8AnQPpqcu2ezRSlg4itkyQ5c9ICBq34a8oTHDDNMr23IXjTC14zRYhxu
	 QU2do/HWbwvUw==
Date: Thu, 4 Jun 2026 18:29:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Tanushree Shah <tshah@linux.ibm.com>
Cc: jolsa@kernel.org, adrian.hunter@intel.com, vmolnaro@redhat.com,
	mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
	irogers@google.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	atrajeev@linux.ibm.com, hbathini@linux.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	Shivani.Nittor@ibm.com
Subject: Re: [PATCH] perf data convert json: Fix trace_seq memory leak in
 process_sample_event()
Message-ID: <aiHuIBAIgv3L6TI7@x1>
References: <20260604065519.112101-1-tshah@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604065519.112101-1-tshah@linux.ibm.com>

On Thu, Jun 04, 2026 at 12:25:19PM +0530, Tanushree Shah wrote:
> Unlike the in-kernel trace_seq which uses a statically allocated buffer,
> the userspace traceevent library's trace_seq uses a dynamically allocated
> one. Therefore, every trace_seq_init() call must be paired with a
> trace_seq_destroy(), otherwise it produces a memory leak.
> 
> In process_sample_event(), a trace_seq is initialized for each field when
> formatting tracepoint raw_data, but the matching trace_seq_destroy() is
> never called, leaking memory for every field of every sample processed.
> 
> Add the missing trace_seq_destroy() after using the trace_seq buffer to
> properly free the allocated memory.
> 
> Detected with Valgrind on a perf.data file with 2,729 tracepoint samples:
>   Before: definitely lost: 55,537,664 bytes in 13,559 blocks
>   After:  definitely lost: 0 bytes in 0 blocks

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
 
> Fixes: 9d895e468429 ("perf data: Add tracepoint fields when converting to JSON")
> Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
> ---
>  tools/perf/util/data-convert-json.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
> index d526c91312ed..6dd9349ab10f 100644
> --- a/tools/perf/util/data-convert-json.c
> +++ b/tools/perf/util/data-convert-json.c
> @@ -257,6 +257,7 @@ static int process_sample_event(const struct perf_tool *tool,
>  				trace_seq_init(&s);
>  				tep_print_field(&s, sample->raw_data, fields[i]);
>  				output_json_key_string(out, true, 3, fields[i]->name, s.buffer);
> +				trace_seq_destroy(&s);
>  
>  				i++;
>  			}
> -- 
> 2.47.3
