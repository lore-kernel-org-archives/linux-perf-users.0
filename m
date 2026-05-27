Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2630112F585;
	Wed, 27 May 2026 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903333; cv=none; b=gPvXR6G1heX4X0/Db3Bu/WHJe0Q9QccJP77YkdVoYTBpQLvO+LocgMYfU5t/I7z/D/exHkIDrU5QTRFgBChBjt/gI2WGamu20jPrAopbp6wS4KC5J/MAI9vXRB8h6Nlc445aU0inefGHKf+gJM48KBvNuRrzjHEhw3qyMRxsfcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903333; c=relaxed/simple;
	bh=zlX4SqO4IOpDAIi8T5LpV3Zgp3P7kISNyU5Ww9G+2cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZX5eSfK6cmb91D4c8z9lRHUK+Ujt4PcLOJphNvg3Fam995gAIU74Wt52a5QrGCuU1mL2hGFZFzUXIpKjqj1Gc1ttyAFb3GKRCRylE+xq/JAfagizR+1RpUOPW2I+SCwKELH98ZwhembXtgeEd660wL9sGmCNZd+WrKGVrqPng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7mX9mQB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7mX9mQB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C0C1F000E9;
	Wed, 27 May 2026 17:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779903331;
	bh=zwwdLlB2L4O2BGzACUZC0q8e984MXb/7DcEaDtGN9Fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q7mX9mQBtynBXzk81F6XYDpNDeRXRKbyqAQVl4RemygWKIC/tjQ5DrW4YrkOdV+yw
	 IRD63JmrOL5c6xhiwArD5ArQmlSrdEv5Rk1I3S0rZNeSEmbwShDDYg/zGPcCl7/xDU
	 su8H4SFYT+Owrwpq8pSljpFLgYGeEotFRFucPsJyoCoGucwBH5ZkQyOYKRdQU33MMt
	 nBsxSe2p+Pyos/3J1VJqrkREUgQl8mzqKXxwPcnrnN1GsG9a5CGeCKUKvcEXWlrXai
	 zHqzuugf2O/LFja9UuyvCV6LsQSlPjB5XEB0YPI17Tx+LT/cbmcX5LhAmMt3qRxjLe
	 BaRhS8gpnxWHQ==
Date: Wed, 27 May 2026 10:35:29 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Rui Qi <qirui.001@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf: Fix off-by-one stack buffer overflow in
 kallsyms__parse()
Message-ID: <ahcrYd2xj1gWvl0m@google.com>
References: <ahUAyRcMsJv4_W_Y@google.com>
 <20260527075716.1642712-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260527075716.1642712-1-qirui.001@bytedance.com>

On Wed, May 27, 2026 at 03:57:16PM +0800, Rui Qi wrote:
> In kallsyms__parse(), the loop reading symbol names iterates with
> i < sizeof(symbol_name), which allows i to reach sizeof(symbol_name)
> upon loop exit. The subsequent symbol_name[i] = '\0' then writes one
> byte past the end of the stack-allocated symbol_name[] array.
> 
> Fix this by changing the loop bound to sizeof(symbol_name) - 1, so
> the null terminator always lands within the array. The overflow is
> triggerable by a kallsyms entry with a symbol name of KSYM_NAME_LEN+1
> or more characters (e.g., long Rust mangled names or a malicious
> /proc/kallsyms).
> 
> Fixes: 53df2b934412 ("libsymbols kallsyms: Parse using io api")
> Signed-off-by: Rui Qi <qirui.001@bytedance.com>
> 
> ---
> 
> Changes in v3:
> - Use KSYM_NAME_LEN instead of sizeof(symbol_name) - 1 for the
>   overflow check, as suggested by Namhyung.
> 
> Changes in v2:
> - Added read_to_eol(&io) when a symbol name exceeds the buffer size,
>   preventing remaining characters from being parsed as the next symbol entry.
> - Added Fixes tag.
> ---
>  tools/lib/symbol/kallsyms.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
> index e335ac2b9e19..198bfc7c1f63 100644
> --- a/tools/lib/symbol/kallsyms.c
> +++ b/tools/lib/symbol/kallsyms.c
> @@ -60,7 +60,7 @@ int kallsyms__parse(const char *filename, void *arg,
>  			read_to_eol(&io);
>  			continue;
>  		}
> -		for (i = 0; i < sizeof(symbol_name); i++) {
> +		for (i = 0; i < sizeof(symbol_name) - 1; i++) {

Oh.  I meant here as well.

Thanks,
Namhyung


>  			ch = io__get_char(&io);
>  			if (ch < 0 || ch == '\n')
>  				break;
> @@ -68,6 +68,9 @@ int kallsyms__parse(const char *filename, void *arg,
>  		}
>  		symbol_name[i]  = '\0';
>  
> +		if (i == KSYM_NAME_LEN)
> +			read_to_eol(&io);
> +
>  		err = process_symbol(arg, symbol_name, symbol_type, start);
>  		if (err)
>  			break;
> -- 
> 2.20.1
