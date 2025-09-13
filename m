Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B912EFDAC;
	Sat, 13 Sep 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757774630; cv=none; b=Pj0ddjF+V8o0vhGKdLKhdmpFTWdDdHwNxsGSnYMaVSoJfmrov421aJQ0d9kXVv45zQzgzwcONL9aILpgINUEO0CPyk9xuaSAx+r3XIK8ZPzUMESFbgaFQLO6NsQaF7keLmd+exCJ/gBycTtDNSKOKxTtLvQCtTgF/pXRXHtSPJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757774630; c=relaxed/simple;
	bh=nAdASmCBX8yN9n6c7cOqbY9jV8lhwcIK3p7JE0e+qZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKNCkiq2Q08cFNJGB1N9tLCSmIlwPCnB9Di5gGGOUId/f6D/Br2kV6MYT/uxJRmUbVSOWKknsGsw0yY+UachVR9F1QJBsKdAnvrJxg9MMoQUP71wqE1COr9Dg6MG7/X2VFweTsAVdhkngmIoXQVQ751bFXpQ58vNUlFqbuwBar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNTMtPOH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNTMtPOH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC96C4CEF7;
	Sat, 13 Sep 2025 14:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757774630;
	bh=nAdASmCBX8yN9n6c7cOqbY9jV8lhwcIK3p7JE0e+qZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sNTMtPOH3mxDX/7gjcRrTYyEGwgAupJll7+v09uHSyxvuIkS66o6zJu2TPUeOtdtJ
	 SRgtnqcNZZPyd2CvzqtHSzgr7MjZxHzSnJBDR9A4DUpMmypgwNiIQcuj0ySC2ZxxJD
	 FoPBN684aJrJrzd6RWwowX5VLOeipBUqPWTGy0ZjFmtOYA6z2F/5pJD8+E0PosbAtF
	 rdDwTdEdirsFojcUz63Viv51c1+qB4TVABJdEDvae2IhKZ2qi7zKJhPVZ3ZIbEhOmz
	 0iV5g4sL1GDeCvth+WY+T50orHBZmkK83hG/lNqIVdx177NALa2eNDFu8RjkZlubiC
	 pqN1fDr0YQ04Q==
Date: Sat, 13 Sep 2025 11:43:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ahmed Atef El-Emary <ahmed.software.engineer1@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	namhyung@kernel.org, irogers@google.com, jolsa@kernel.org,
	adrian.hunter@intel.com
Subject: Re: [PATCH] perf trace: Use consistent print_opts formatting in
 trace__fprintf_callchain()
Message-ID: <aMWDI1BFsW0W4yp8@x1>
References: <20250826080811.27650-1-ahmed.software.engineer1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826080811.27650-1-ahmed.software.engineer1@gmail.com>

On Tue, Aug 26, 2025 at 11:08:11AM +0300, Ahmed Atef El-Emary wrote:
> trace__fprintf_callchain() previously omitted IP and symoffset from its
> print_opts, unlike other callchain printers in perf. This resulted in
> less detailed and inconsistent callchain output.
> 
> Add EVSEL__PRINT_IP and EVSEL__PRINT_SYMOFFSET to make the output more
> consistent and informative. The callchain output now includes IP, symbol
> offset, DSO, and falls back to the raw address when no symbol is found,
> matching the detail level of other perf callchain outputs.

Can you please exemplify before and after output in addition of just
describing the changes?

- Arnaldo
 
> Signed-off-by: Ahmed Atef El-Emary <ahmed.software.engineer1@gmail.com>
> ---
>  tools/perf/builtin-trace.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index fe737b3ac6e6..20f3488d4a21 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2892,8 +2892,10 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
>  {
>  	/* TODO: user-configurable print_opts */
>  	const unsigned int print_opts = EVSEL__PRINT_SYM |
> -				        EVSEL__PRINT_DSO |
> -				        EVSEL__PRINT_UNKNOWN_AS_ADDR;
> +				EVSEL__PRINT_DSO |
> +				EVSEL__PRINT_UNKNOWN_AS_ADDR |
> +				EVSEL__PRINT_IP |
> +				EVSEL__PRINT_SYMOFFSET;
>  
>  	return sample__fprintf_callchain(sample, 38, print_opts, get_tls_callchain_cursor(), symbol_conf.bt_stop_list, trace->output);
>  }
> -- 
> 2.43.0
