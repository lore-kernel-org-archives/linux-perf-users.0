Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F2752D2A9;
	Tue, 13 Oct 2026 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791920668; cv=none; b=MruZuR3A+nk9kd3LuX6pg9htPt3it5vJJqaopAOqweHYfcHP0YlZ7IxeTR9P1ltW3j+6ZF/UpEm1pZd1RQo88K+LQeVYOLRESgBIbpVnnwJ8PeSLi+eavuopjSPA/tzj3asu6voIS5wdF3QZAoyzYmQcxv7ITiVnyZJy72Jh6Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791920668; c=relaxed/simple;
	bh=ptTajPdsrvmZAZ2xebbOEy+6rvk7RQNZ7oxzHgevJ5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPGOc8mdVHSEaiXF1+JwzqFWXWK/+Mg8odC0XxR7rwYTaMYzdCj/Pfnmmo9dhBO6Bh2FdiEL1Shpp1f+7JLtjIQK2cCBPKVqXbDPoQAqGaVtWuNXN+QpL3TGodhvDQN5/DOjhkCLa8YM9kNssBt57daN6phhgqEaj1haLkyPuOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=T9wFIICG; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="T9wFIICG"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j44Xg0nHgz1XM4Tn;
	Tue, 13 Oct 2026 19:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1791920653; x=1794512654; bh=fXCRJRuu6VOintnUsKBn3m9y
	AP8nYruoeFPSSmmenmw=; b=T9wFIICGEEqubaSrLn+Qqp/TPsa/Ti29rHkiBbwY
	TDpVneY1mg38OmfLjbElwn2tUW+Ac6DhbcNB/sqn7Q6P8SuD02Ox4BUP+0CYeWQ4
	Aq1Yne/HTfLX5g+plUdzahPwUWiYUAEcMVmSPARoFGSOGzv1EmoJXTjNmc69uMev
	cXcH2i5Wd8P3sE2UvPu3GmJ5dfeT9a8XU8NqVvTwuO019iN26Bww/CqWdEZrxakD
	ulqLjkWFkDnrrqX55E2ZGCABrY71T8aprU+hBE4hzpMXm4sdNwaCzuszaKkUemj0
	86b1VABp70cMFdUB9q/V3J5dtFWOiyJnJ4c/GewWqccKsw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id uaSxp4M5S670; Tue, 13 Oct 2026 19:44:13 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:46f9:948:aeed:5df3] (unknown [104.135.182.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j44XX3420z1XM4Tl;
	Tue, 13 Oct 2026 19:44:12 +0000 (UTC)
Message-ID: <871bf440-5b43-4d63-83f8-15ba96719fa6@acm.org>
Date: Tue, 13 Oct 2026 12:44:11 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/10] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Lorenzo Stoakes <ljs@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013182458.1234616-2-irogers@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261013182458.1234616-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/26 11:24 AM, Ian Rogers wrote:
> _context_unsafe_alias() does not use its parameter 'p', which triggers
> -Wunused-parameter when building code that enables -Wextra (such as
> tools/perf, tools/lib/perf, tools/lib/subcmd, and tools/lib/symbol).
> Explicitly cast 'p' to void to silence the warning, matching
> __assume_ctx_lock() and __assume_shared_ctx_lock().
> 
> Assisted-by: Antigravity:gemini-3.1-pro

I think this should be changed into Gemini 3.1 Pro. I don't think that
the "Antigravity" part should occur in the Assisted-by tag.

> diff --git a/include/linux/compiler-context-analysis.h b/include/linux/compiler-context-analysis.h
> index 8302ebc2ea8c..024e303188ad 100644
> --- a/include/linux/compiler-context-analysis.h
> +++ b/include/linux/compiler-context-analysis.h
> @@ -243,7 +243,7 @@
>    * alias as a function argument).
>    */
>   #define context_unsafe_alias(p) _context_unsafe_alias((void **)&(p))
> -static inline void _context_unsafe_alias(void **p) { }
> +static inline void _context_unsafe_alias(void **p) { (void)p; }

Why a void cast instead of __attribute__((unused))?

Bart.
