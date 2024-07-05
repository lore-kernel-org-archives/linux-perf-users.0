Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ECE22313;
	Fri,  5 Jul 2024 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720175660; cv=none; b=GhJrBByfpSgjsBH+NSYyXFGrvHhWZDjlwskiJlj0NDdUqRm2TdDREqum3ZMWHWyw001TNBln0zjYykWnJTP5jDU8Z0LU+rZykwh01DQxAK12bFmJtJwF2ZypEoMhTXyjY/ZY1x7CghE1/mKe/9HEypjzL6QqaHdvEe7yYE2rv6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720175660; c=relaxed/simple;
	bh=OHwCYZYWuxr2zibh0sQUzfqPPVvOiWBqC8XZucSKSvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INZZMGb/RJLNTODEHXqDXvNUThriYW76JXbzBpZTtfzySxLdVDA5eDr9J4Fzbowt2og0PiBWD/NxtDdBl9urDKdoGeLwbuPoEDane/xPP8DMFr3gHwXQ658VIFyW8fqSxcmbPTaM+2KGbcs15yDrRMrTvUeYj4ekGQMiEJtDrIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3safjMw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3safjMw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B308C116B1;
	Fri,  5 Jul 2024 10:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720175659;
	bh=OHwCYZYWuxr2zibh0sQUzfqPPVvOiWBqC8XZucSKSvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3safjMw/dDD3rJLDXb4XhWm2WKeYsnc1ctTMrqVkE8pKfVodLxHeKO3Dl7M2tmaG
	 RLlM8EsRhZyAJSjcexvOmNNb86bntNpEQCEEn8cchKb2M6GlG7aG1aayYkk6egYUJp
	 hXFXJRYYOdslWYc14Ow/awXNWVHHzRpqVWCLvR8Rdzy4Ed4gvCkZgnQ72AuxtquCUr
	 7z5fYzuUPLqqEYIDAMkZEiF1vIWdWYR0TS5xEWYLH0aFmxWIbFw94ZAg7bVtYQy3U0
	 W5ROIRgRP6Hia3VBf/OkpHm/aUN1Tvxtlyrw+wKeh9mnKLMM9Nn3/DmRaaNVX2X0Kl
	 MJSaSH4t6ouXQ==
Date: Fri, 5 Jul 2024 11:34:13 +0100
From: Will Deacon <will@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] perf: Add perf_event_attr::bp_priv
Message-ID: <20240705103413.GA8971@willie-the-truck>
References: <20240621073910.8465-1-yangtiezhu@loongson.cn>
 <20240621073910.8465-2-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621073910.8465-2-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jun 21, 2024 at 03:39:08PM +0800, Tiezhu Yang wrote:
> Add a member "bp_priv" at the end of the uapi struct perf_event_attr
> to make a bridge between ptrace and hardware breakpoint.
> 
> This is preparation for later patch on some archs such as ARM, ARM64
> and LoongArch which have privilege level of breakpoint.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  include/uapi/linux/perf_event.h | 3 +++
>  kernel/events/hw_breakpoint.c   | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 3a64499b0f5d..f9f917e854e6 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -379,6 +379,7 @@ enum perf_event_read_format {
>  #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
>  #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
>  #define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
> +#define PERF_ATTR_SIZE_VER9	144	/* add: bp_priv */
>  
>  /*
>   * Hardware event_id to monitor via a performance monitoring event:
> @@ -522,6 +523,8 @@ struct perf_event_attr {
>  	__u64	sig_data;
>  
>  	__u64	config3; /* extension of config2 */
> +
> +	__u8	bp_priv; /* privilege level of breakpoint */
>  };

Why are we extending the user ABI for this? Perf events already have the
privilege encoded (indirectly) by the exclude_{user,kernel,hv} fields in
'struct perf_event_attr'.

Will
