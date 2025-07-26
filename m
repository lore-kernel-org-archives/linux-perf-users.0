Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A20B347D5
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 05:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753507623; cv=none; b=NnGeyFwZbL0blvHlRUqrkjNhFbFtX9q12gq5v+r2AE/MUqyFOc0s/uHdyFwVbbsC03/idutQtqlvxg99OC/iPEnmRqM3bV2Yu5CXa3nzD/7ZSvQAckshwo4pNP015nGwm7T5znf3N+cVk1/PBSNIt3HgOQ7COn0e6JziX+IEQAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753507623; c=relaxed/simple;
	bh=q+EeUv+rQyWASmS9ZfrAfGwVQz4TRIy8WHEuiNabm5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgVSp468cPf7MzKp7x6ojmSwzslzeJmJVohGlkXucsULx4+BJgli+JLGomvUoQUl8b+ukJ8qqbCAXw7IvbByuIJw4rq2vbnrS+E7oMoRqp4PNCTdUy4LWypAzjOn7qEDeUiq/9bkEy/w8OIWiddi+9s8fDXphyo3SkjGUAVnpKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnyVfjHq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnyVfjHq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69EAC4CEED;
	Sat, 26 Jul 2025 05:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753507623;
	bh=q+EeUv+rQyWASmS9ZfrAfGwVQz4TRIy8WHEuiNabm5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnyVfjHqJxWdNi1AxEkZy0paPJWy7diDsvjhz/h/GjdhaheKSjm/FFLZvLZwmtoF8
	 USRvsRWjxsHusY2hYdWUXl9Jpdq3P/Z35ZNnbVBzjGAGa8q4MKcNbmod29IyUnOrWW
	 F9kXgboT0JGafgpDhxWCo+ALLUfFOhY7qeudxPAZhetPkHHUfQsXGy3G9/gZkMNxUW
	 U1LvzttKoMrvA66r5TtkZ3lvn9nAAmsCOG7Yqb1CkIlxRo9mWwq4rmbf+lsn1vyGjb
	 O+GalQsm4pjm7RtxbpkaPk7w03VenXgPJ44s6hXA2CZwSXuawW4Og5VqYfSmi8kQz+
	 tvYLa6iCWjXzQ==
Date: Fri, 25 Jul 2025 22:27:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jan Polensky <japo@linux.ibm.com>
Cc: adrian.hunter@intel.com, irogers@google.com,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/1] perf tools: Fix auto-complete on s390x
Message-ID: <aIRnJDMRNO8olMdD@google.com>
References: <20250725171354.3180806-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250725171354.3180806-1-japo@linux.ibm.com>

Hello,

On Fri, Jul 25, 2025 at 07:13:54PM +0200, Jan Polensky wrote:
> On s390x, CPU-related events are not located in
> event_source/devices/cpu/events. Instead, they are found in architecture
> specific locations depending on the hypervisor configuration:
> 
>     /sys/devices/pai_crypto/events/
>     /sys/devices/cpum_cf_diag/events/
>     /sys/devices/pai_ext/events/
>     /sys/devices/cpum_cf/events/
>     /sys/devices/cpum_sf/events/
> 
> Using current auto-complete script result in the following error:
> 
>     [root@localhost perf]# perf top -e
>     ls: cannot access '/sys/bus/event_source/devices/cpu/events': No such file or directory
> 
> Fix this by skipping the check for
> /sys/bus/event_source/devices/cpu/events on s390x systems.
> 
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  tools/perf/perf-completion.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/perf-completion.sh b/tools/perf/perf-completion.sh
> index 69cba3c170d5..8db6de98007b 100644
> --- a/tools/perf/perf-completion.sh
> +++ b/tools/perf/perf-completion.sh
> @@ -168,10 +168,11 @@ __perf_main ()
>  		local cur1=${COMP_WORDS[COMP_CWORD]}
>  		local raw_evts
>  		local arr s tmp result cpu_evts
> +		local arch=`uname -m`
>  
>  		raw_evts=$($cmd list --raw-dump hw sw cache tracepoint pmu sdt)
>  		# aarch64 doesn't have /sys/bus/event_source/devices/cpu/events
> -		if [[ `uname -m` != aarch64 ]]; then
> +		if [[ $arch != aarch64 && $arch != s390x ]]; then

I think it's better to check if the directory exists or just ignore the
error message by redirecting to /dev/null.

Thanks,
Namhyung


>  			cpu_evts=$(ls /sys/bus/event_source/devices/cpu/events)
>  		fi
>  
> -- 
> 2.48.1
> 
