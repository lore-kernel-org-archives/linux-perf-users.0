Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2556B10F1;
	Tue, 26 May 2026 02:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779761357; cv=none; b=h9DYDcq3gJyyb/DGS2ZD9oNNxTNniViMtvO2HCVRN44QvNLB11bMrOIIGcyMgkw4ChZiGUUcIBOTpcGLPAN4wa5Gvzs8GN0eiB62eSGUd6DmBsD6XCaVII9lcyu7yapC1FgAs/YuAGrFokJoeuhUiS03I7ETMwrU0Rk5LEkZ2os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779761357; c=relaxed/simple;
	bh=AX73C+LNbrID3gE9NoEf2cQ+aKdkY43UHe9qDnB4N00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqOBTO44m0bPoD9MuuRHv57TWlnbeG9+2cb+9j+Ct993odMyRotwLD5S6mDQiTWEDhMNuaOHQV9A+v0WcqDl8DtZ4Hhm/T6PnKqBAocPGY2ibxsY/P2sNgBe1rba1DknZQVrpPfN0yRtvSHRaELwOX7cJ7B45BQrXbgo6QzAThY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZA+Fwc6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZA+Fwc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10721F000E9;
	Tue, 26 May 2026 02:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779761355;
	bh=8NMf+Jkf6AGhAAuxwJt6P9dLupQL9vDkM307LHSqrQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jZA+Fwc6N6DvaWNRlWxNtdqgcdUraWW1Tv3Fkcmxmf8jzoez7K7wj7aXLiz3Ysq4W
	 iwo5/tpHtykBagbgVIAiNVUMmCNd/dKCtGV/LibQvYiblvp0QQbDd041Q7g6w+m0Ff
	 mIWbs9egQIBoAVBtZ+P1v8I/2b9dmlRTx7oj7FZwxWzAtDfta4nzdF4diXUbxbB1Ze
	 D9Mr64KGOlftonouXha/vGYAIfIKOQGoLDfUzXdhliaVCv3IJomDg1R9Il/yXSvXdS
	 jKrE91kOQteXZjO/8nCPyq0RjvjyAut9YFfR/E1L588euG4oWUHYdIoBcJx/zvXCCy
	 JUZo7hBTQNNHw==
Date: Mon, 25 May 2026 21:09:13 -0500
From: Namhyung Kim <namhyung@kernel.org>
To: Rui Qi <qirui.001@bytedance.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf: Fix off-by-one stack buffer overflow in
 kallsyms__parse()
Message-ID: <ahUAyRcMsJv4_W_Y@google.com>
References: <20260522070738.31900-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260522070738.31900-1-qirui.001@bytedance.com>

On Fri, May 22, 2026 at 03:07:38PM +0800, Rui Qi wrote:
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
> ---
> Changes in v2:
> - Added read_to_eol(&io) when a symbol name exceeds the buffer size, 
>   preventing remaining characters from being parsed as the next symbol entry.
> - Added Fixes tag.
> 
>  tools/lib/symbol/kallsyms.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
> index e335ac2b9e19..0f87c654ea63 100644
> --- a/tools/lib/symbol/kallsyms.c
> +++ b/tools/lib/symbol/kallsyms.c
> @@ -60,7 +60,7 @@ int kallsyms__parse(const char *filename, void *arg,
>  			read_to_eol(&io);
>  			continue;
>  		}
> -		for (i = 0; i < sizeof(symbol_name); i++) {
> +		for (i = 0; i < sizeof(symbol_name) - 1; i++) {
>  			ch = io__get_char(&io);
>  			if (ch < 0 || ch == '\n')
>  				break;
> @@ -68,6 +68,9 @@ int kallsyms__parse(const char *filename, void *arg,
>  		}
>  		symbol_name[i]  = '\0';
>  
> +		if (i == sizeof(symbol_name) - 1)

Then maybe it's more intuitive to check with KSYM_NAME_LEN.

Thanks,
Namhyung


> +			read_to_eol(&io);
> +
>  		err = process_symbol(arg, symbol_name, symbol_type, start);
>  		if (err)
>  			break;
> -- 
> 2.20.1
