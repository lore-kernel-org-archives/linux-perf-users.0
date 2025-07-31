Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382691E51D;
	Thu, 31 Jul 2025 04:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753937662; cv=none; b=T/lSM/QscgkOgc1bDENogCB9IEWYxtrQuqcObiVwdrsZLUc0vLk5Qq2tevjZqdJD0O5DT5Xq84G8jzV7yVsvlYAwdc0tPH1SE4jJ3RW1PEb5CgOnWa4I/JSxXKA+qwFwRCgYrJBLNhUTG9Gqji0qZtSTBfzjKtkd7doKp9z83Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753937662; c=relaxed/simple;
	bh=xZMZeLw0gwPBfA4PhjfT0LcUxX4lQHPSCvNhei41giw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgZTQz7PbyQbrDvRWdfzQnwOWet1pjeUNZNT4OtPA/1LOSakERqHFcrkYXTB+eKAT9X1VmqdVryPy6BddS6iiZQKJ5oMv0Wr7xEPtAt7s388Wly8lGOZmc3LjmfMT7DNRyk+9IyuDBJ6NeyumWDrl1RNWSkwsnd23L2raGUIdJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyMPFf3Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyMPFf3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF080C4CEEF;
	Thu, 31 Jul 2025 04:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753937661;
	bh=xZMZeLw0gwPBfA4PhjfT0LcUxX4lQHPSCvNhei41giw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uyMPFf3QE7ARDeB9v9RFRuv7ux/ehOW0yUzOIH2GDm/TrTEuRAivdqMb5ubQ1h/UK
	 MiCrB7L/LwXp5eHjGWrxMAfPsb9Dtmq8E+0wms8ADh1KCGV2+rDCxqFAM3og+aYKPL
	 MSjc5wvfg7es/03T2n0LQRXVZzkuESgqZXo2CMmzm0Xl7kvqQjpaRDyPkmYVyR+kzZ
	 UxMlCGeSD5tox3hOYFrKMdOCL7p/J0oYuwlwioWv2LUT1o/SxU/gNbc6sxlFeGsokZ
	 4JkzRlaGb5FizfwFjH2wom6NPBl8WAv1eT23wPsgQrmmlfuTbwAjJFPE5lnkV1L2cO
	 O5lAG5Dq3q4qw==
Date: Wed, 30 Jul 2025 21:54:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yuzhuo Jing <yuzhuo@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yzj@umich.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 3/7] tools: Partial import of prefetch.h
Message-ID: <aIr2-7842FIi2_8V@google.com>
References: <20250729022640.3134066-1-yuzhuo@google.com>
 <20250729022640.3134066-4-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250729022640.3134066-4-yuzhuo@google.com>

On Mon, Jul 28, 2025 at 07:26:36PM -0700, Yuzhuo Jing wrote:
> Import only prefetch and prefetchw but not page and range related
> methods.
> 
> Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
> ---
>  tools/include/linux/prefetch.h | 41 ++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 tools/include/linux/prefetch.h
> 
> diff --git a/tools/include/linux/prefetch.h b/tools/include/linux/prefetch.h
> new file mode 100644
> index 000000000000..1ed8678f4824
> --- /dev/null
> +++ b/tools/include/linux/prefetch.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Generic cache management functions. Everything is arch-specific,  
> + *  but this header exists to make sure the defines/functions can be
> + *  used in a generic way.
> + *
> + *  2000-11-13  Arjan van de Ven   <arjan@fenrus.demon.nl>
> + *
> + */
> +
> +#ifndef _LINUX_PREFETCH_H
> +#define _LINUX_PREFETCH_H
> +
> +/*
> +	prefetch(x) attempts to pre-emptively get the memory pointed to
> +	by address "x" into the CPU L1 cache. 
> +	prefetch(x) should not cause any kind of exception, prefetch(0) is
> +	specifically ok.
> +
> +	prefetch() should be defined by the architecture, if not, the 
> +	#define below provides a no-op define.	
> +	
> +	There are 2 prefetch() macros:
> +	
> +	prefetch(x)  	- prefetches the cacheline at "x" for read
> +	prefetchw(x)	- prefetches the cacheline at "x" for write
> +	
> +	there is also PREFETCH_STRIDE which is the architecure-preferred 
> +	"lookahead" size for prefetching streamed operations.
> +	
> +*/
> +
> +#ifndef ARCH_HAS_PREFETCH
> +#define prefetch(x) __builtin_prefetch(x)
> +#endif

Do we have ARCH_HAS_PREFETCH somewhere?

Thanks,
Namhyung

> +
> +#ifndef ARCH_HAS_PREFETCHW
> +#define prefetchw(x) __builtin_prefetch(x,1)
> +#endif
> +
> +#endif
> -- 
> 2.50.1.487.gc89ff58d15-goog
> 
