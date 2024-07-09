Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07CA12E1F1;
	Tue,  9 Jul 2024 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519391; cv=none; b=WJeawJ+wM++hGDTc5pSExWZmhRKJ3vM09fuWXHt/BBTxuI/qtbLJcoIzrOcClEy/aEXtZZ+sQiBKArbHu0PIf6gAGshZB24FYiMqSDYRsBnx9kIxhGUhSViOHf4/ar5OVWkoVg27uhCkzsXtcH6F56JvcZzEmV9ntYzmEb8ZOPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519391; c=relaxed/simple;
	bh=90k6vXvGy1/771jGUVqqx8EP2at+HrFhDC+HXJzPZcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cdg24RAMFNrZcs+fhu7nv4EP0pgAh0vdIyMvAPaSegu6/t00UegVai7MWRMlcJo8WHs0fTgP8H4jlFSQewH76smgGZiuUmZ9FIe4NTA9Gj/M4NRq7aUEU5X9m3ySIg1GNcLF06WAZ/dL/JO3s97Iw0LqbBBLL5+JuGo/8AxZ8dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hide48Ez; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hide48Ez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47990C3277B;
	Tue,  9 Jul 2024 10:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720519390;
	bh=90k6vXvGy1/771jGUVqqx8EP2at+HrFhDC+HXJzPZcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hide48EzY0NIf5tk+1RgD7DK21UeOlRjXcco+4DV05BEMNAkbmBGPhPaI8mSziIPS
	 FQq2on0chm84oogI0rERTu50xXTXn3il8cpzB71WJAvHlnz7D5ZjQMJApjCyyAiaff
	 5C6Q6OOGa3FSaJDekrgzOO9dFxXXAiBOZCHFbNg6VX9OdycDcp6CqPRcLuqpboEGP3
	 ivfKScL+mKVOGTMipT/KHaM6AN0ugh2kura/+ZlB4Tmu/z6+uBn89ftAiExDKhypua
	 ABI2qJH2pkK9gTCXvsJg/itYtAagHyERFTOjkZ+4lwUnNtZlzYDn7Qj/kGrLBrgUWw
	 CtkKVxUjGK8dQ==
Date: Tue, 9 Jul 2024 11:03:04 +0100
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
Subject: Re: [PATCH v3 1/3] perf: Add perf_event_attr::bp_priv
Message-ID: <20240709100304.GA12978@willie-the-truck>
References: <20240709095506.9691-1-yangtiezhu@loongson.cn>
 <20240709095506.9691-2-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709095506.9691-2-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jul 09, 2024 at 05:55:04PM +0800, Tiezhu Yang wrote:
> When developing hardware watchpoint on LoongArch, we want to set the
> same privilege passed by the ptrace user data, but there is no bridge
> to save this value like bp_addr, bp_type and bp_len. This is a common
> issue for the archs which have privilege level of breakpoint.
> 
> Add a member "bp_priv" which lives in a union on config3 at the end
> of the uapi struct perf_event_attr to make a bridge between ptrace
> and hardware breakpoint.
> 
> This is preparation for later patch on some archs such as ARM, ARM64
> and LoongArch which have privilege level of breakpoint.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  include/uapi/linux/perf_event.h | 5 ++++-
>  kernel/events/hw_breakpoint.c   | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 3a64499b0f5d..abe8da7a1f60 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -521,7 +521,10 @@ struct perf_event_attr {
>  	 */
>  	__u64	sig_data;
>  
> -	__u64	config3; /* extension of config2 */
> +	union {
> +		__u8	bp_priv; /* privilege level of breakpoint */
> +		__u64	config3; /* extension of config2 */
> +	};
>  };
>  
>  /*
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 6c2cb4e4f48d..3ad16b226e4f 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -754,6 +754,7 @@ static void hw_breakpoint_copy_attr(struct perf_event_attr *to,
>  	to->bp_addr = from->bp_addr;
>  	to->bp_type = from->bp_type;
>  	to->bp_len  = from->bp_len;
> +	to->bp_priv = from->bp_priv;
>  	to->disabled = from->disabled;
>  }

Sorry, but I still don't see why we should change uapi for this. As I
have said multiple times, this is unnecessary.

Will
