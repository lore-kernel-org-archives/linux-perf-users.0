Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F6FC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Oct 2021 23:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC53F610E5
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Oct 2021 23:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhJ0X6f (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Oct 2021 19:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhJ0X6f (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Oct 2021 19:58:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16B576109F;
        Wed, 27 Oct 2021 23:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635378969;
        bh=vkiMMBmyVknfXHRJpHX8+Ih6N4FKDhqqF+YZ+FdyRMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y0m6Aw3RXhvpOUygZb/eE/qvdSfLBGyt33oLHM9j86p7SJEsWHp9/Gjavxu8mvevy
         Nm8jNr5NQF95npfNvNKZLRJB5FvEEqNvWHBU5Jln3vh2JEM5g0E1GmfE30fV2rEWH8
         ruEwMVrS82Syh0ikRU3RZwN0QJAD07GIVQsEqxVLhjFgfqI94sGcKun8hLAHcoGIky
         OV6JrwDUeFLDc/onVcfNRW4w8gKPBlUA9Kp9brnOgXID8+zEnTEWv7F+Mo6P9FIHRF
         jAodRIKnDsq/YOhAk1a0SgjGrM4kgPBDBto6kIpBNnTQFE8jRz2pC2ngh+S532l/32
         lkgMrj2I39Zyw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 69326410A1; Wed, 27 Oct 2021 20:56:06 -0300 (-03)
Date:   Wed, 27 Oct 2021 20:56:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alistair Francis <alistair.francis@opensource.wdc.com>
Cc:     linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        dvhart@infradead.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mingo@redhat.com, atish.patra@wdc.com,
        linux-kernel@vger.kernel.org, arnd@arndb.de, alistair23@gmail.com,
        mark.rutland@arm.com, peterz@infradead.org, dave@stgolabs.net,
        Alistair Francis <alistair.francis@wdc.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH v5 1/4] perf bench futex: Call the futex syscall from a
 function
Message-ID: <YXnnFj19AnEq4f+g@kernel.org>
References: <20211022013343.2262938-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022013343.2262938-1-alistair.francis@opensource.wdc.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Oct 22, 2021 at 11:33:40AM +1000, Alistair Francis escreveu:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> In preparation for a more complex futex() function let's convert the
> current macro into two functions. We need two functions to avoid
> compiler failures as the macro is overloaded.
> 
> This will allow us to include pre-processor conditionals in the futex
> syscall functions.

Thanks, applied both patches.

- Arnaldo

 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Acked-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  tools/perf/bench/futex.h | 43 ++++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
> index b3853aac3021c..ebdc2b032afc1 100644
> --- a/tools/perf/bench/futex.h
> +++ b/tools/perf/bench/futex.h
> @@ -28,7 +28,7 @@ struct bench_futex_parameters {
>  };
>  
>  /**
> - * futex() - SYS_futex syscall wrapper
> + * futex_syscall() - SYS_futex syscall wrapper
>   * @uaddr:	address of first futex
>   * @op:		futex op code
>   * @val:	typically expected value of uaddr, but varies by op
> @@ -38,17 +38,26 @@ struct bench_futex_parameters {
>   * @val3:	varies by op
>   * @opflags:	flags to be bitwise OR'd with op, such as FUTEX_PRIVATE_FLAG
>   *
> - * futex() is used by all the following futex op wrappers. It can also be
> + * futex_syscall() is used by all the following futex op wrappers. It can also be
>   * used for misuse and abuse testing. Generally, the specific op wrappers
> - * should be used instead. It is a macro instead of an static inline function as
> - * some of the types over overloaded (timeout is used for nr_requeue for
> - * example).
> + * should be used instead.
>   *
>   * These argument descriptions are the defaults for all
>   * like-named arguments in the following wrappers except where noted below.
>   */
> -#define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
> -	syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
> +static inline int
> +futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct timespec *timeout,
> +	      volatile u_int32_t *uaddr2, int val3, int opflags)
> +{
> +	return syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3);
> +}
> +
> +static inline int
> +futex_syscall_nr_requeue(volatile u_int32_t *uaddr, int op, u_int32_t val, int nr_requeue,
> +			 volatile u_int32_t *uaddr2, int val3, int opflags)
> +{
> +	return syscall(SYS_futex, uaddr, op | opflags, val, nr_requeue, uaddr2, val3);
> +}
>  
>  /**
>   * futex_wait() - block on uaddr with optional timeout
> @@ -57,7 +66,7 @@ struct bench_futex_parameters {
>  static inline int
>  futex_wait(u_int32_t *uaddr, u_int32_t val, struct timespec *timeout, int opflags)
>  {
> -	return futex(uaddr, FUTEX_WAIT, val, timeout, NULL, 0, opflags);
> +	return futex_syscall(uaddr, FUTEX_WAIT, val, timeout, NULL, 0, opflags);
>  }
>  
>  /**
> @@ -67,7 +76,7 @@ futex_wait(u_int32_t *uaddr, u_int32_t val, struct timespec *timeout, int opflag
>  static inline int
>  futex_wake(u_int32_t *uaddr, int nr_wake, int opflags)
>  {
> -	return futex(uaddr, FUTEX_WAKE, nr_wake, NULL, NULL, 0, opflags);
> +	return futex_syscall(uaddr, FUTEX_WAKE, nr_wake, NULL, NULL, 0, opflags);
>  }
>  
>  /**
> @@ -76,7 +85,7 @@ futex_wake(u_int32_t *uaddr, int nr_wake, int opflags)
>  static inline int
>  futex_lock_pi(u_int32_t *uaddr, struct timespec *timeout, int opflags)
>  {
> -	return futex(uaddr, FUTEX_LOCK_PI, 0, timeout, NULL, 0, opflags);
> +	return futex_syscall(uaddr, FUTEX_LOCK_PI, 0, timeout, NULL, 0, opflags);
>  }
>  
>  /**
> @@ -85,7 +94,7 @@ futex_lock_pi(u_int32_t *uaddr, struct timespec *timeout, int opflags)
>  static inline int
>  futex_unlock_pi(u_int32_t *uaddr, int opflags)
>  {
> -	return futex(uaddr, FUTEX_UNLOCK_PI, 0, NULL, NULL, 0, opflags);
> +	return futex_syscall(uaddr, FUTEX_UNLOCK_PI, 0, NULL, NULL, 0, opflags);
>  }
>  
>  /**
> @@ -97,8 +106,8 @@ static inline int
>  futex_cmp_requeue(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2, int nr_wake,
>  		 int nr_requeue, int opflags)
>  {
> -	return futex(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_requeue, uaddr2,
> -		 val, opflags);
> +	return futex_syscall_nr_requeue(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_requeue, uaddr2,
> +					val, opflags);
>  }
>  
>  /**
> @@ -113,8 +122,8 @@ static inline int
>  futex_wait_requeue_pi(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2,
>  		      struct timespec *timeout, int opflags)
>  {
> -	return futex(uaddr, FUTEX_WAIT_REQUEUE_PI, val, timeout, uaddr2, 0,
> -		     opflags);
> +	return futex_syscall(uaddr, FUTEX_WAIT_REQUEUE_PI, val, timeout, uaddr2, 0,
> +			     opflags);
>  }
>  
>  /**
> @@ -130,8 +139,8 @@ static inline int
>  futex_cmp_requeue_pi(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2,
>  		     int nr_requeue, int opflags)
>  {
> -	return futex(uaddr, FUTEX_CMP_REQUEUE_PI, 1, nr_requeue, uaddr2,
> -		     val, opflags);
> +	return futex_syscall_nr_requeue(uaddr, FUTEX_CMP_REQUEUE_PI, 1, nr_requeue, uaddr2,
> +					val, opflags);
>  }
>  
>  #endif /* _FUTEX_H */
> -- 
> 2.31.1

-- 

- Arnaldo
