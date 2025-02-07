Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A71912E1CD;
	Fri,  7 Feb 2025 03:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738900405; cv=none; b=PDefLlGvvjXTItn33Lc0jNowRxmcbgX5nnyQEjBYO/3yZuxOn2ZcOxDxw9v6qaA0OJbdtmXqdq1v5jJXPE8BWt8TY9DIukOeb5vOFGtsMWlks6KVCbpYM5d3pWkB8Td3I1NhocxUgF4c9bSRl72tlrSG8UvgY9ktcJEJFcaFx0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738900405; c=relaxed/simple;
	bh=RlAEHnED59qlLBnScLP1p6Vy4P09IWwl4VHSecIAl00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+6wf6vVHoEfNL4NS2dT5lrWXCsLy6WjneK/fkRNoCrsgWUUAYOYRl+d1hVbKLg5Ek6KqYlfgcpslYmeKbIHgob3qKJoL5+IA/OvRBMmUCpxuzeKsgBNma2rK7JTfUvIsN3VQh0eLK1Hye0PP3jvPaIowTU1tyD2TLfTvcE09PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUHvm/zJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUHvm/zJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF85C4CED1;
	Fri,  7 Feb 2025 03:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738900404;
	bh=RlAEHnED59qlLBnScLP1p6Vy4P09IWwl4VHSecIAl00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUHvm/zJ6hpiI2hLaozVfIgO9+pWHUm4nnELMa13r7o9sTtT7x6T9NNSH3LGl64Wm
	 RajjKZ0nz2lA9bFm2cRppdHG7tqxZ45SX7KPjARQDbhcbJ6Sb1Xes2r9+6NMr0sb6a
	 RqdfddcMUJBzbhODRrG+IkOeIKalJ4cK1zws6IF0UhiZz4tOwJn+CIFLTeH3YCtuRu
	 X/gzmlRqJ/NKyQUISn/DSyqqRg7qk7ry/Rf6G/5YCQzh0cK111FMZrATLfwoz3Snjy
	 3lcV9incfvazzWlmn4oyhe6lFJVfeSOrppoBxJlt/GrNm8rFkKeiN4yDfiEeYlRNZ5
	 1tuQr38c95Enw==
Date: Thu, 6 Feb 2025 19:53:22 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v5 6/8] perf report: Add --latency flag
Message-ID: <Z6WDsmeVr7qPk0te@google.com>
References: <cover.1738772628.git.dvyukov@google.com>
 <eb32b9b13856b0d508836b61b3e8377aef9163a3.1738772628.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb32b9b13856b0d508836b61b3e8377aef9163a3.1738772628.git.dvyukov@google.com>

On Wed, Feb 05, 2025 at 05:27:45PM +0100, Dmitry Vyukov wrote:
> Add record/report --latency flag that allows to capture and show
> latency-centric profiles rather than the default CPU-consumption-centric
> profiles. For latency profiles record captures context switch events,
> and report shows Latency as the first column.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> ---
[SNIP]  
> +void perf_hpp__cancel_latency(void)
> +{
> +	struct perf_hpp_fmt *fmt, *lat, *acc, *tmp;
> +
> +	if (is_strict_order(field_order) || is_strict_order(sort_order))
> +		return;

This also needs to be changed since you call setup_overhead even if you
have a strict sort_order.

For example, it's strange these two are different.

With default sort order:

  $ perf record --latency -- ls /

  $ perf report --stdio
  ...
  # Overhead  Command  Shared Object         Symbol                  
  # ........  .......  ....................  ........................
  #
      64.50%  ls       ld-linux-x86-64.so.2  [.] do_lookup_x
      33.41%  ls       [kernel.kallsyms]     [k] chacha_block_generic
       2.00%  perf-ex  [kernel.kallsyms]     [k] put_ctx
       0.09%  perf-ex  [kernel.kallsyms]     [k] native_write_msr
  
Same sort order, but explicitly:

  $ perf report --stdio -s comm,dso,sym
  ...
  # Overhead   Latency  Command  Shared Object         Symbol                  
  # ........  ........  .......  ....................  ........................
  #
      64.50%    64.50%  ls       ld-linux-x86-64.so.2  [.] do_lookup_x
      33.41%    33.41%  ls       [kernel.kallsyms]     [k] chacha_block_generic
       2.00%     2.00%  perf-ex  [kernel.kallsyms]     [k] put_ctx
       0.09%     0.09%  perf-ex  [kernel.kallsyms]     [k] native_write_msr

Maybe you want to cancel the latency field even if sort key is given
(unless it has 'latency').

Something like this?

---8<---
@@ -714,7 +715,9 @@ void perf_hpp__cancel_latency(void)
 {
        struct perf_hpp_fmt *fmt, *lat, *acc, *tmp;
 
-       if (is_strict_order(field_order) || is_strict_order(sort_order))
+       if (is_strict_order(field_order))
+               return;
+       if (is_strict_order(sort_order) && strstr(sort_order, "latency"))
                return;
 
        lat = &perf_hpp__format[PERF_HPP__LATENCY];
---8<---

Thanks,
Namhyung

> +
> +	lat = &perf_hpp__format[PERF_HPP__LATENCY];
> +	acc = &perf_hpp__format[PERF_HPP__LATENCY_ACC];
> +
> +	perf_hpp_list__for_each_format_safe(&perf_hpp_list, fmt, tmp) {
> +		if (fmt_equal(lat, fmt) || fmt_equal(acc, fmt))
> +			perf_hpp__column_unregister(fmt);
> +	}
> +}
> +
>  void perf_hpp__setup_output_field(struct perf_hpp_list *list)
>  {
>  	struct perf_hpp_fmt *fmt;
