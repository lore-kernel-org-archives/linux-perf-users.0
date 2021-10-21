Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000D3C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 13:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA522611CE
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 13:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhJUN2M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 21 Oct 2021 09:28:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhJUN2M (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Oct 2021 09:28:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B47EB610CB;
        Thu, 21 Oct 2021 13:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634822756;
        bh=97EQWqxB+NgM73M8P2ikYsx5BVa/jFCaVEfOcLm4DAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LC3bzHXANc9HNpdF1fCEzyxrw4yDtgeVY9RGeGo+Qh3KCwCCVjQSJDObGvPDRm9nu
         twT67ERS3WpER4BD9b/ZmeUZ/BSAdy661UWuwGGyHp9j/SsxzBj27Lfr9Q3HA7Pusl
         L6iOPJhGEazpR0tGObvShlLV+QSLto7HXtoJrGnwt7IP70B8F93Nl7ekeXlU3HMrZ3
         SsUT38t5Ru3kAg+X+bjaimtvgtxrdqhCHFeIqRvMPMtOn3SpPmNlQByh7zoQ9YKHl/
         vX+K2ZfV5oc8y6RLumbS6l9EOyyyvzh4lBqkPEtQgWnjzjMKaMucP+w86Y3THp7VRE
         jHzZFW17mb9CA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 789E2410A1; Thu, 21 Oct 2021 10:25:52 -0300 (-03)
Date:   Thu, 21 Oct 2021 10:25:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alistair Francis <alistair.francis@opensource.wdc.com>
Cc:     linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        namhyung@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        dave@stgolabs.net, dvhart@infradead.org, peterz@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, atish.patra@wdc.com,
        arnd@arndb.de, Alistair Francis <alistair.francis@wdc.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH v4 1/4] perf bench futex: Call the futex syscall from a
 function
Message-ID: <YXFqYJsPYA4c4Fqw@kernel.org>
References: <20211020223920.2810727-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211020223920.2810727-1-alistair.francis@opensource.wdc.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Oct 21, 2021 at 08:39:17AM +1000, Alistair Francis escreveu:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> In preparation for a more complex futex() function let's convert the
> current macro into two functions. We need two functions to avoid
> compiler failures as the macro is overloaded.
> 
> This will allow us to include pre-processor conditionals in the futex
> syscall functions.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Acked-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  tools/perf/bench/futex.h | 43 ++++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)

Right after applying this one:

In file included from bench/futex-hash.c:29:
bench/futex.h: In function ‘futex_syscall’:
bench/futex.h:52:61: error: ‘ts32’ undeclared (first use in this function); did you mean ‘s32’?
   52 |         return syscall(SYS_futex, uaddr, op | opflags, val, ts32, uaddr2, val3);
      |                                                             ^~~~
      |                                                             s32
bench/futex.h:52:61: note: each undeclared identifier is reported only once for each function it appears in
bench/futex.h:49:82: error: unused parameter ‘timeout’ [-Werror=unused-parameter]
   49 | futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct timespec *timeout,
      |                                                                 ~~~~~~~~~~~~~~~~~^~~~~~~
bench/futex.h:53:1: error: control reaches end of non-void function [-Werror=return-type]
   53 | }
      | ^
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/bench/futex-hash.o] Error 1
make[4]: *** Waiting for unfinished jobs....
In file included from bench/futex-wake-parallel.c:31:
bench/futex.h: In function ‘futex_syscall’:
bench/futex.h:52:61: error: ‘ts32’ undeclared (first use in this function); did you mean ‘s32’?
   52 |         return syscall(SYS_futex, uaddr, op | opflags, val, ts32, uaddr2, val3);
      |                                                             ^~~~
      |                                                             s32
bench/futex.h:52:61: note: each undeclared identifier is reported only once for each function it appears in
bench/futex.h:49:82: error: unused parameter ‘timeout’ [-Werror=unused-parameter]
   49 | futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct timespec *timeout,
      |                                                                 ~~~~~~~~~~~~~~~~~^~~~~~~
bench/futex.h:53:1: error: control reaches end of non-void function [-Werror=return-type]
   53 | }
      | ^
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/bench/futex-wake-parallel.o] Error 1
In file included from bench/futex-requeue.c:26:
bench/futex.h: In function ‘futex_syscall’:
bench/futex.h:52:61: error: ‘ts32’ undeclared (first use in this function); did you mean ‘s32’?
   52 |         return syscall(SYS_futex, uaddr, op | opflags, val, ts32, uaddr2, val3);
      |                                                             ^~~~
      |                                                             s32
bench/futex.h:52:61: note: each undeclared identifier is reported only once for each function it appears in
bench/futex.h:49:82: error: unused parameter ‘timeout’ [-Werror=unused-parameter]
   49 | futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct timespec *timeout,
      |                                                                 ~~~~~~~~~~~~~~~~~^~~~~~~
bench/futex.h:53:1: error: control reaches end of non-void function [-Werror=return-type]
   53 | }
      | ^
cc1: all warnings being treated as errors
In file included from bench/futex-lock-pi.c:19:
bench/futex.h: In function ‘futex_syscall’:
bench/futex.h:52:61: error: ‘ts32’ undeclared (first use in this function); did you mean ‘s32’?
   52 |         return syscall(SYS_futex, uaddr, op | opflags, val, ts32, uaddr2, val3);
      |                                                             ^~~~
      |                                                             s32
bench/futex.h:52:61: note: each undeclared identifier is reported only once for each function it appears in
bench/futex.h:49:82: error: unused parameter ‘timeout’ [-Werror=unused-parameter]
   49 | futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct timespec *timeout,
      |                                                                 ~~~~~~~~~~~~~~~~~^~~~~~~
bench/futex.h:53:1: error: control reaches end of non-void function [-Werror=return-type]
   53 | }
      | ^
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/bench/futex-requeue.o] Error 1
make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/bench/futex-lock-pi.o] Error 1
In file included from bench/futex-wake.c:25:
bench/futex.h: In function ‘futex_syscall’:
bench/futex.h:52:61: error: ‘ts32’ undeclared (first use in this function); did you mean ‘s32’?
   52 |         return syscall(SYS_futex, uaddr, op | opflags, val, ts32, uaddr2, val3);
      |                                                             ^~~~
      |                                                             s32
bench/futex.h:52:61: note: each undeclared identifier is reported only once for each function it appears in
bench/futex.h:49:82: error: unused parameter ‘timeout’ [-Werror=unused-parameter]
   49 | futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct timespec *timeout,
      |                                                                 ~~~~~~~~~~~~~~~~~^~~~~~~
bench/futex.h:53:1: error: control reaches end of non-void function [-Werror=return-type]
   53 | }
      | ^
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/bench/futex-wake.o] Error 1
make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:139: bench] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [Makefile.perf:660: /tmp/build/perf/perf-in.o] Error 2
make[1]: *** [Makefile.perf:240: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf/tools/perf'

 Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin':

          2,467.00 msec task-clock:u              #    1.263 CPUs utilized
          2,457.82 msec cpu-clock:u               #    1.259 CPUs utilized

       1.952573032 seconds time elapsed

       1.444401000 seconds user
       1.111434000 seconds sys


⬢[acme@toolbox perf]$


