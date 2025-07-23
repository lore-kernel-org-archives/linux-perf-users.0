Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA442F43
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 00:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753231036; cv=none; b=DVZ48k8dMI03VWle6cD1/LAQ3dYzXC/VCfLPnfIzhOobZOEUMuzHSthduv2a8dS2YPFqdzTABOCslDnBvS8WIWqMSChz2BZ7F8kxZg5sFFCEuDN1ZMoUvoJUqWGTQ4yz7jIWMKQGtLkemXEn63uNt7OlP2YpPVS2dWUJeRg4hlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753231036; c=relaxed/simple;
	bh=R4JuDpULNKFkGzGHna+bohAj2cVbOZ9resF4fyzhn6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpW+xPZT9VPk79X3SmSx207yNFG9xYTPOdGcaYwSBeLBtJmfJ8srb75sGZHMEe0TTTMV4ZrODSaW1MR7qYfCkYE6YrqQ9ZRV3LCcqlSbHgNC6QVNVOEv1V9YHKq332Re0FV+Sw7qIs2IMMI5sQeg4Do7DOAASc+hvmbqG7eSxUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ak+MSl4r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ak+MSl4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6D9C4CEEB;
	Wed, 23 Jul 2025 00:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753231036;
	bh=R4JuDpULNKFkGzGHna+bohAj2cVbOZ9resF4fyzhn6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ak+MSl4rFKUSmwyll+lzSf+oqBI57bck7BjQnMxUgTXGggeE9RfdF/EdQgtNypGAG
	 HBFpu9wBS2+PoRkXGqAJxlTEeCWISt6oWjkNbO+RzWugNHzbSoZUp74n13tKWwYOxK
	 WF3LuJ7G69UApGxclaeRKGfjlZNLEvL14AodSXJvVgNinzLwMlphoxUVIjeBUgT4AQ
	 vZfcID/Xa3gqZONTDSmHZPvLfmxJYzhbqzxmDe+CfKtocQ4ca+MoE0vBv7FkDEv+NF
	 cqT2PfLfnfAmyZMBIT2QlqtdlafdgfWrOjbmUDwawr++cm0kL+RuI/mhHzX42HfLYh
	 KQUwN9IGXY8dw==
Date: Tue, 22 Jul 2025 17:37:13 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Federico Pellegrin <fede@evolware.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf build: Always disable stack protection for BPF
 skeleton objects
Message-ID: <aIAuuVM-VYIF0Lsl@google.com>
References: <20250718041224.12389-1-fede@evolware.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250718041224.12389-1-fede@evolware.org>

Hello,

On Fri, Jul 18, 2025 at 06:12:24AM +0200, Federico Pellegrin wrote:
> When the clang toolchain has stack protection enabled, the bpf
> skeletons build fails with:
> 
> error: A call to built-in function '__stack_chk_fail' is not supported.
> 
> Since stack-protector makes no sense for the BPF bits, just unconditionally
> disable it.
> 
> See also similar case at 878625e1c7a10dfbb1fdaaaae2c4d2a58fbce627
> 
> Signed-off-by: Federico Pellegrin <fede@evolware.org>

Applied to perf-tools-next with minor updates.

Thanks,
Namhyung

> ---
>  tools/perf/Makefile.perf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index d4c7031b01a7..ca7dc65a3182 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1251,7 +1251,7 @@ else
>  endif
>  
>  $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h | $(SKEL_TMP_OUT)
> -	$(QUIET_CLANG)$(CLANG) -g -O2 --target=bpf $(CLANG_OPTIONS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
> +	$(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=bpf $(CLANG_OPTIONS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
>  	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
>  
>  $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
> -- 
> 2.50.1
> 
