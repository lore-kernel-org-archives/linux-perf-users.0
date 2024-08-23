Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B685186601;
	Fri, 23 Aug 2024 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419453; cv=none; b=WIpBqwLdHcPnfuN5ItEWEXen15fLT+2DM4zHEEJT0xMxQ9STZJ7Ff1hKN4yc/Cjmwa7c/75v0qxI6S3UUko5ycVreBlZXo9SG6ECzxZk9N9w5NhwA5X8pHuTzEv+G0LwFSAA5s6c1JglSbfvEYqEd51xpGbTTKHbC56lPICAj7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419453; c=relaxed/simple;
	bh=066YqwPkV+S6Xr7cjcMYLL9UHE3wQ7t2WPKn35QeMOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P10nYH78NAQhZpFEqYWqVlfcAEJDTNvkhscjWIAteRuTUA68GSGKociZyS9FMpfWRbcn7ZZqbWWgzda/vExMNUVan1KaMsVp3lLivUJrfgnZp977gwxHQETxX3td39m9Ie33Xfc4zxGlOEwB2OLZnsEoDtX6B8+lEKP5UAT9HUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1rNeTWN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1rNeTWN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5BEC32786;
	Fri, 23 Aug 2024 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724419452;
	bh=066YqwPkV+S6Xr7cjcMYLL9UHE3wQ7t2WPKn35QeMOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u1rNeTWN5hADGBzuOeh5813QN6x92S10tQXKQDBfQxcs8G81hQE7isZ36xIVPXasv
	 gw5ZFl71uzdSUVNmq6svzx3NEXXCTELWWhaViYIUxrqaDsRZmb87tRh0nZj35qlX3X
	 IzgRDE9psc3wlu/U3oqrkfL2iFO4vyHGKAmC+RVz78rCHGMibNwU00CNDt4Gd3uApm
	 9Iln/5yIP3evJGXVRJjwkn5wFrWztDNacu6ZldO4lwD5Q3PtqORkgxc/Bdx5xcpq9S
	 XrTrAb+LXPpioZbdZSWczqG4OvDAytHcwDrJncbC8W3mZ5NlvWPEm3Yzz/j7z60Ur8
	 zklJ1DH8oK4fw==
Date: Fri, 23 Aug 2024 10:24:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] perf trace: Collect augmented data using BPF
Message-ID: <ZsiNef72pSLnQO_c@x1>
References: <20240815013626.935097-1-howardchu95@gmail.com>
 <20240815013626.935097-10-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815013626.935097-10-howardchu95@gmail.com>

On Thu, Aug 15, 2024 at 09:36:25AM +0800, Howard Chu wrote:
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -427,7 +538,8 @@ int sys_enter(struct syscall_enter_args *args)
>  	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
>  	 * unaugmented tracepoint payload.
>  	 */
> -	bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
> +	if (augment_sys_enter(args, &augmented_args->args))
> +		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);

We shouldn't do that, instead we keep doing

	bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);

And userspace will setup the syscalls_sys_enter map adding the generic
pointer collector (augment_sys_enter) for syscalls that have pointers
_and_ are not serviced by a pre-existing, specialized handler, this way
we keep the ones we have already and that already take into account
pretty printing network addresses based on the network family, knows how
to pretty print flags (the perf_event_open, etc).

I'll try to do this now.

- Arnaldo

>  
>  	// If not found on the PROG_ARRAY syscalls map, then we're filtering it:
>  	return 0;
> -- 
> 2.45.2
