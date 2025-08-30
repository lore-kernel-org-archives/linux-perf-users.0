Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE095BAF0;
	Sat, 30 Aug 2025 07:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756538129; cv=none; b=Jbo0wmn3ayh3X1A+6axvNU5tW6zkhbNWEu/Gr54q5f9V1nOWYDGBwWeuDWG58ukRTORS974VhBxhKNLV6DluEstNGCg27SZOCyhoxh7BBRmjg94jM/iLgvujDzGaW+yitVCvECtTLmeZX3MBUYpcVQk3reuC7U2usr7iHp/aEIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756538129; c=relaxed/simple;
	bh=kTKoSB2+PmDXSyzWEqMpSLxyyKbpJVWUMI5G6R9EGEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwPF2qr88oMdtHakNXzGkTWKAWpTHOKkia4Htbgp2yNUzJwObi0BEIU5mrk3ZKgkk8jM7TgcKIkcIJEXMIIOkkPtb0HCtRCA7aqY3tdXWIlx1EUZAjsAJmolmX4D8vBCjJk31bNzJfIbsqZH2M1LihycpyDVV+Bd3D3+4vvaUIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrtgHTsQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrtgHTsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C543C4CEEB;
	Sat, 30 Aug 2025 07:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756538128;
	bh=kTKoSB2+PmDXSyzWEqMpSLxyyKbpJVWUMI5G6R9EGEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lrtgHTsQiWmRicgWpyohiK6w/VTTqwHO9RDlscptOapp6jb9AzEr3jCfByU7DtDQf
	 fBmQwnmOSCM21U+/+2wE/SydrNlQ1kHbE6HtHTTVME2pKW2G9nPfbnGtwVPcmLWhIp
	 W9EeV4uX+JPvpVClPKe8bzELata1AHy8xkb4Gw5o24rmPYcX18PZZd4lRYlUUpgLK4
	 9D7HJ8g3YBDksEkwwJ1n07M7bTrcjEmLh0E5m8EFsNGlhH2Jz6lkTf/eUV9Miewjc5
	 wNU4FqRWrCSk6VPaQAt/syVbbGdogx7207sYsMU1s4rZWkJfOkXCsCHLbGer6QEsEp
	 khCoPOqtL5Z6w==
Date: Sat, 30 Aug 2025 00:15:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] perf annotate: Invalidate register states for
 unsupported instructions
Message-ID: <aLKlDp6bl9Qjiziy@google.com>
References: <20250825195748.226052-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825195748.226052-1-zecheng@google.com>

On Mon, Aug 25, 2025 at 07:57:48PM +0000, Zecheng Li wrote:
> Invalidate register states when encountering unsupported instructions
> that modify pointers, to prevent propagating incorrect pointer types.
> 
> On x86, the 'xor' instruction may appear in a predecessor basic block
> and zero out a register that invalidates the target register state. This
> sometimes relates to tagged pointers and normal programs should not
> dereference NULL pointers, so we assume such execution paths are invalid
> and do not invalidate states for 'xor' instructions.

Probably we can set it to 0 with TSR_KIND_CONST.

Thanks,
Namhyung

> 
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  tools/perf/arch/x86/annotate/instructions.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
> index 540b4d0a01af..03df52a5266d 100644
> --- a/tools/perf/arch/x86/annotate/instructions.c
> +++ b/tools/perf/arch/x86/annotate/instructions.c
> @@ -413,6 +413,23 @@ static void update_insn_state_x86(struct type_state *state,
>  		return;
>  	}
>  
> +	/* Invalidate register states for other ops which may change pointers */
> +	if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
> +	    dwarf_tag(&state->regs[dst->reg1].type) == DW_TAG_pointer_type) {
> +		if (!strncmp(dl->ins.name, "imul", 4) || !strncmp(dl->ins.name, "mul", 3) ||
> +		    !strncmp(dl->ins.name, "idiv", 4) || !strncmp(dl->ins.name, "div", 3) ||
> +		    !strncmp(dl->ins.name, "shl", 3)  || !strncmp(dl->ins.name, "shr", 3) ||
> +		    !strncmp(dl->ins.name, "sar", 3)  || !strncmp(dl->ins.name, "and", 3) ||
> +		    !strncmp(dl->ins.name, "or", 2)   || !strncmp(dl->ins.name, "neg", 3) ||
> +		    !strncmp(dl->ins.name, "inc", 3)  || !strncmp(dl->ins.name, "dec", 3)) {
> +			pr_debug_dtp("%s [%x] invalidate reg%d\n",
> +						dl->ins.name, insn_offset, dst->reg1);
> +			state->regs[dst->reg1].ok = false;
> +			state->regs[dst->reg1].copied_from = -1;
> +			return;
> +		}
> +	}
> +
>  	if (strncmp(dl->ins.name, "mov", 3))
>  		return;
>  
> -- 
> 2.51.0.261.g7ce5a0a67e-goog
> 
