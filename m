Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7152F352952;
	Tue, 20 Jan 2026 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937400; cv=none; b=PSGxbeAjJTvTNPhcuPZsJsNaSAeAZ0qpjJITGONnh6w2TKFCwu9rWefKf/ijAgzBRcgS1frqKNOiTjQVvYs+bp0Dd4kwxcBRUBuYy0eI90TB01C/4Xk257tEUyxZ4XpE3eUTMelFQg4nk9PAWIESa+tzdMGpeTHbC4NdTWl7uGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937400; c=relaxed/simple;
	bh=JBPqSlyfEyqkueV6HlUAUk7xjVtxZp0D+L38Njpnh3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRcjVBFtDjniDP2vpf3JKQyZKQzLOmDD6wrV7Dgur5j5Y21S0FowHcYnOolnnVyd5M7aX5jVPehPJbX6k387PJzPN44IC7SALUgf3vcXYoqxh7ibXhea0KMR/RAoMay0mdOrCbzjVJ0t5HTbqHZ/xfStlWziWk0eJrRfgL7zX7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rokbb/f9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rokbb/f9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A62AC19421;
	Tue, 20 Jan 2026 19:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768937398;
	bh=JBPqSlyfEyqkueV6HlUAUk7xjVtxZp0D+L38Njpnh3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rokbb/f9lN5W67e64+U26tRVCGwuInkinw55kndBZgvJiyQMzt5+TmKtHqss4k0QY
	 d86HigiiwYR+blwppmfl3KmCPHCTb9iEZ7bp43qJT8MxZkSxpDJhofo8ZTe4zpw08M
	 FSi2wlGWr5+kDTLJxHxp9Xn4mQV6mIWazxqsN/iGOubRwVQoNlkJWhEE6sauoR6Ibv
	 Ecug9JyVn3FVkGj54KmvYnrjpvkI5NHc1B7jzDtS0vHD5fWn3gpl3EzS9Qfxyeb8Ty
	 omZXbnRJYLpeHlbU2zoHgo3VmvcxdsFJqkwnIyL6JRfl6FrGsueQmIGXav30kURuoM
	 V/DG3Y2KVN5VA==
Date: Tue, 20 Jan 2026 16:29:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	James Clark <james.clark@linaro.org>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH 1/6] perf tool ibs: Sync AMD IBS header file
Message-ID: <aW_XsuKv5n_IxXkj@x1>
References: <20260119024328.897-1-ravi.bangoria@amd.com>
 <20260119024328.897-2-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119024328.897-2-ravi.bangoria@amd.com>

On Mon, Jan 19, 2026 at 02:43:22AM +0000, Ravi Bangoria wrote:
> IBS_OP_DATA2 register will have two more fields: strm_st and rmt_socket
> in future AMD CPUs. Kernel header file is already updated. Add those
> fields in tools copy as well.

Was this already merged in the kernel? 

- Arnaldo
 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/arch/x86/include/asm/amd/ibs.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/arch/x86/include/asm/amd/ibs.h b/tools/arch/x86/include/asm/amd/ibs.h
> index cbce54fec7b9..e9662370e690 100644
> --- a/tools/arch/x86/include/asm/amd/ibs.h
> +++ b/tools/arch/x86/include/asm/amd/ibs.h
> @@ -99,7 +99,9 @@ union ibs_op_data2 {
>  			rmt_node:1,	/* 4: destination node */
>  			cache_hit_st:1,	/* 5: cache hit state */
>  			data_src_hi:2,	/* 6-7: data source high */
> -			reserved1:56;	/* 8-63: reserved */
> +			strm_st:1,	/* 8: streaming store */
> +			rmt_socket:1,   /* 9: remote socket */
> +			reserved1:54;   /* 10-63: reserved */
>  	};
>  };
>  
> -- 
> 2.43.0
> 
