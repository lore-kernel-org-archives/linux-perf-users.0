Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB003FFACB;
	Thu, 28 May 2026 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989701; cv=none; b=AggfMnJEF13/qIvoZUftKCiA09Hv8o/+GEmuVIylYbphRS33PECnDmgtvldt8uzlHTgaEyBiziqsmCCeRx/vTwNMZWCvX6NVVSC7Jh1hUalesAabFyWcv5+iuP4lm5eqYqpK+9xZj1PUDUCOnFw/aUWiBp3vDJecXQCHlszzDMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989701; c=relaxed/simple;
	bh=9gQ6/nkgNTTcbsQ5LBkr6wTuk65Y2PVq76wusJRSLTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3ftPemSByj9vksCHNx5UpwTCRJ55qsHvFYnUwRJI1R6tiebRZ8iHV2CvaeFJoqYRYEKVLdcZbiBIWpRHMUOv9NIVhiuS1j7cAb4InusCq4WCiXoKL8Q5WtiKv1epAF6N422GaWBaYda5wjHGPHpLEIRI3cWHpi5xN2Yb/HOeWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geSJbu/3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geSJbu/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8451F000E9;
	Thu, 28 May 2026 17:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779989698;
	bh=jA+7JOr+xAG/3B/JVLxUm/6Q3nvgTPEegvhTonQHRMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=geSJbu/3LrN5aLP8hO4lEDSKeoV5YN5DaiVTJb4QsKgssrDcdMD0S5sM9F9wTnB1j
	 OTfxvNgdzKais7hyXe613WXveiImAD2tLr2WoAfL07nw856s9k/yNNbO0OvOF20Drl
	 Jgaw6w20/c5tIjY3/wX/HGnlWKHedXOAowVCvYf+fCBSOd5oyCoaEevosgIpvwEWgm
	 E3p2xpDhTY1xsUWB19sw1gvO6H4YqaonyJYPsitqMz3lU8ICDj1fFnumcxv2z5sYCT
	 Ocnw5K6Dke25hrwfUgKKfilIuBIaoWcOw0/Ol4enqwod9X92bASNsGh9dyGXG3rvSL
	 BRpZpHX4+2Jhw==
Date: Thu, 28 May 2026 10:34:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Rui Qi <qirui.001@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf: Fix off-by-one stack buffer overflow in
 kallsyms__parse()
Message-ID: <ahh8v0Zvh7iFz9i8@google.com>
References: <ahcrYd2xj1gWvl0m@google.com>
 <20260528062355.2320045-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260528062355.2320045-1-qirui.001@bytedance.com>

On Thu, May 28, 2026 at 02:23:55PM +0800, Rui Qi wrote:
> In kallsyms__parse(), the loop reading symbol names iterates with
> i < sizeof(symbol_name), which allows i to reach sizeof(symbol_name)
> upon loop exit. The subsequent symbol_name[i] = '\0' then writes one
> byte past the end of the stack-allocated symbol_name[] array.
> 
> Fix this by changing the loop bound to KSYM_NAME_LEN, so
> the null terminator always lands within the array. The overflow is
> triggerable by a kallsyms entry with a symbol name of KSYM_NAME_LEN+1
> or more characters (e.g., long Rust mangled names or a malicious
> /proc/kallsyms).
> 
> Fixes: 53df2b934412 ("libsymbols kallsyms: Parse using io api")
> Signed-off-by: Rui Qi <qirui.001@bytedance.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
> ---
> 
> Changes in v4:
> - Use KSYM_NAME_LEN for the loop bound as well, as suggested by Namhyung.
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
> index e335ac2b9e19..d64bd9cc82a9 100644
> --- a/tools/lib/symbol/kallsyms.c
> +++ b/tools/lib/symbol/kallsyms.c
> @@ -60,7 +60,7 @@ int kallsyms__parse(const char *filename, void *arg,
>  			read_to_eol(&io);
>  			continue;
>  		}
> -		for (i = 0; i < sizeof(symbol_name); i++) {
> +		for (i = 0; i < KSYM_NAME_LEN; i++) {
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
