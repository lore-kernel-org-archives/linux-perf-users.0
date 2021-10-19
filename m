Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11435C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 16:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBB0661260
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 16:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhJSQ6t (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 12:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhJSQ6s (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 12:58:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 759766113B;
        Tue, 19 Oct 2021 16:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634662595;
        bh=O/2mCEk859jM6shQhgv+fX2GqL6oT0eP64zQhWzS8XA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vQOwAFXnmBJNnyD0+d8jW5THLSLuYsgiKsPzu07BEx1yVJnYmmNHNqlRrMZIwgu1C
         xExURgAQOYBOzdSRNhaD0IHOPr7ivqJhBCryPsc4amDTsXAWERIPfl01w61UZ07AJa
         /Ag9TRIuzBWVtxYgaor2LcbKOhURKp09PhhVeDhTQNhJhRtuKSAXUWkTRJ7pa/7WFX
         JAP8yPACcKApT+4+M8nFjYR9e8iNfuKi0sFE97Nv1SEc6DGGg1SDWz6hxr7CgRmdKD
         yAah+9IgFTuH9Eg8CSia0MEKsc+Ef22BTNwwyJxjaCHvE5sO6m+JvBO9ajfG2K+g/d
         EDLoohP9itwag==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E68B8410A1; Tue, 19 Oct 2021 13:56:32 -0300 (-03)
Date:   Tue, 19 Oct 2021 13:56:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alistair Francis <alistair.francis@opensource.wdc.com>
Cc:     linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        namhyung@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        dave@stgolabs.net, dvhart@infradead.org, peterz@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, atish.patra@wdc.com,
        arnd@arndb.de, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 1/2] perf bench futex: Use a 64-bit time_t
Message-ID: <YW74wK03ibOS3jVZ@kernel.org>
References: <20211015005634.2658470-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015005634.2658470-1-alistair.francis@opensource.wdc.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Oct 15, 2021 at 10:56:33AM +1000, Alistair Francis escreveu:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Convert tools/perf to only use a 64-bit time_t. On 64-bit architectures
> this isn't a functional change. On 32-bit architectures we now only
> perform 64-bit time_t syscalls (__NR_futex_time64) and use a struct
> timespec64.
> 
> This won't work on kernels before 5.1, but as perf is tied to the kernel
> that's ok.

No, perf is not tied to the kernel, one can use a new perf tool on any
previous kernel, and an old perf tool should work on new kernels as
well.

- Arnaldo
 
> This allows us to build perf for 32-bit architectures with 64-bit time_t
> like RISC-V 32-bit.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  tools/perf/bench/futex.h | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
> index b3853aac3021c..b9665d43d2988 100644
> --- a/tools/perf/bench/futex.h
> +++ b/tools/perf/bench/futex.h
> @@ -12,6 +12,7 @@
>  #include <sys/syscall.h>
>  #include <sys/types.h>
>  #include <linux/futex.h>
> +#include <linux/time_types.h>
>  
>  struct bench_futex_parameters {
>  	bool silent;
> @@ -27,12 +28,14 @@ struct bench_futex_parameters {
>  	unsigned int nrequeue;
>  };
>  
> +#define timespec64 __kernel_timespec
> +
>  /**
>   * futex() - SYS_futex syscall wrapper
>   * @uaddr:	address of first futex
>   * @op:		futex op code
>   * @val:	typically expected value of uaddr, but varies by op
> - * @timeout:	typically an absolute struct timespec (except where noted
> + * @timeout:	typically an absolute struct timespec64 (except where noted
>   *		otherwise). Overloaded by some ops
>   * @uaddr2:	address of second futex for some ops
>   * @val3:	varies by op
> @@ -47,15 +50,26 @@ struct bench_futex_parameters {
>   * These argument descriptions are the defaults for all
>   * like-named arguments in the following wrappers except where noted below.
>   */
> -#define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
> -	syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
> +/**
> + * We only support 64-bit time_t for the timeout.
> + * On 64-bit architectures we can use __NR_futex
> + * On 32-bit architectures we use __NR_futex_time64. This only works on kernel
> + * versions 5.1+.
> + */
> +#if __BITS_PER_LONG == 64
> +# define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
> +	syscall(__NR_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
> +#else
> +# define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
> +	syscall(__NR_futex_time64, uaddr, op | opflags, val, timeout, uaddr2, val3)
> +#endif
>  
>  /**
>   * futex_wait() - block on uaddr with optional timeout
>   * @timeout:	relative timeout
>   */
>  static inline int
> -futex_wait(u_int32_t *uaddr, u_int32_t val, struct timespec *timeout, int opflags)
> +futex_wait(u_int32_t *uaddr, u_int32_t val, struct timespec64 *timeout, int opflags)
>  {
>  	return futex(uaddr, FUTEX_WAIT, val, timeout, NULL, 0, opflags);
>  }
> @@ -74,7 +88,7 @@ futex_wake(u_int32_t *uaddr, int nr_wake, int opflags)
>   * futex_lock_pi() - block on uaddr as a PI mutex
>   */
>  static inline int
> -futex_lock_pi(u_int32_t *uaddr, struct timespec *timeout, int opflags)
> +futex_lock_pi(u_int32_t *uaddr, struct timespec64 *timeout, int opflags)
>  {
>  	return futex(uaddr, FUTEX_LOCK_PI, 0, timeout, NULL, 0, opflags);
>  }
> @@ -111,7 +125,7 @@ futex_cmp_requeue(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2, int nr_wak
>   */
>  static inline int
>  futex_wait_requeue_pi(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2,
> -		      struct timespec *timeout, int opflags)
> +		      struct timespec64 *timeout, int opflags)
>  {
>  	return futex(uaddr, FUTEX_WAIT_REQUEUE_PI, val, timeout, uaddr2, 0,
>  		     opflags);
> -- 
> 2.31.1

-- 

- Arnaldo
