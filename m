Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8576E1F8BCD;
	Wed, 26 Mar 2025 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012894; cv=none; b=NmQT11jEC9ZPKMhdQwfll5X4NDLuSSbnUruKkYiOpPF0VmOTaGB+UeeVPaE0EDejvWL6zh3AoAFQCuFmVb29/j51+afwcCWpX5nBfxflRbaopHx/PwWY6LOXM5Gd4lXYQW6qesjjf0Klg5ga9Z13G116mGg/IDK7025jtCLSh5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012894; c=relaxed/simple;
	bh=cd7EYHFEFbA7MQbzFPnhq7BpVfRthx6uK+y6bly3n58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pj4HL9K3B3VmcFL6FkZ2PYbvuQNuu++RoTZ0Wm2WOW1eCjFm17ywDpyG7SwOqteqr3s1ybI7kbp9vf5LYyVq6rzWUOOjQZzPl/mIbIRQtVzxgG5bx32pxVXQ03qfqB/0Fowhbu4zTYFaFDuGDQj69SfX7Y/0SD/WaOg5nuit/I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7AjiESS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7AjiESS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73932C4CEE2;
	Wed, 26 Mar 2025 18:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743012894;
	bh=cd7EYHFEFbA7MQbzFPnhq7BpVfRthx6uK+y6bly3n58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W7AjiESSnKTCkRD23VAAdVgS+p1U9DyzVly9BjXM9Pg1mCZJ7KXNsnNCjpjK+ptrY
	 xTCkvNjtbNGsziQbwCoPZ63NGmlkhREmB5v7bOxa8CJ+g5HLF/sZUu2Dpvk1ws1piB
	 t1NsQmGvMDbYf0kduPS9huNHw2HpiIfw7A1PWBZOokQM6y36bahpGl++gM0nrWQFCq
	 pMgiA/JS89kVjqjgNp4vMeNkDeZXrLyF7WA3khkxDZ6uVpsxZU97zBaOEOEgbx4yZi
	 Ru+uxLhvNNKK6AOGZZYnFoHfymaHSSt4Ijm8VpfHhsHXxFXY0fUVJ0GSW6S0jYeKOQ
	 FNiFwksIrSGSA==
Date: Wed, 26 Mar 2025 11:14:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf doc: Improve perf trace's doc on --force-btf
 option
Message-ID: <Z-REG5kkE1RahBW2@google.com>
References: <20250326160416.1725322-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250326160416.1725322-1-howardchu95@gmail.com>

Hello,

On Wed, Mar 26, 2025 at 09:04:16AM -0700, Howard Chu wrote:
> As mentioned by Arnaldo in a past discussion (Link:
> https://lore.kernel.org/linux-perf-users/Z2m0pWiQgZNXhvxK@x1/), the
> current documentation on --force-btf is vague and inaccurate, this patch
> aims to provide a clearer explanation of the option.
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> ---
>  tools/perf/Documentation/perf-trace.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
> index 887dc37773d0..cf2445d2ba3d 100644
> --- a/tools/perf/Documentation/perf-trace.txt
> +++ b/tools/perf/Documentation/perf-trace.txt
> @@ -246,10 +246,10 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
>  	arguments to strings (pid to comm, syscall id to syscall name, etc).
>  
>  --force-btf::
> -	Use btf_dump to pretty print syscall argument data, instead of using hand-crafted pretty
> -	printers. This option is intended for testing BTF integration in perf trace. btf_dump-based
> -	pretty-printing serves as a fallback to hand-crafted pretty printers, as the latter can
> -	better pretty-print integer flags and struct pointers.
> +	Use libbpf's btf_dump to pretty print syscall arguments, utilizing only the debug
> +	information from BTF. This option is intended for testing BTF integration in perf
> +	trace. Using libbpf is a fallback to perf trace's own prettifiers generated from the
> +	kernel source, as the latter can better pretty-print integer flags and struct members.

"the latter" means our own prettifier, right?  Then why do we need the
fallback as it's better and always works?

Thanks,
Namhyung

>  
>  PAGEFAULTS
>  ----------
> -- 
> 2.45.2
> 
