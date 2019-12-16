From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 56/63] perf tests: Fix out of bounds memory access
Date: Mon, 16 Dec 2019 17:20:27 +0100
Message-ID: <20191216162027.GA2227094@kroah.com>
References: <20191107190011.23924-1-acme@kernel.org>
 <20191107190011.23924-57-acme@kernel.org>
 <CA+G9fYu-sGYutfX5K5LyAZ8cUfNpWomtyA_0SQsHyej0jD8qTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+G9fYu-sGYutfX5K5LyAZ8cUfNpWomtyA_0SQsHyej0jD8qTw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Sasha Levin <sashal@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, open list <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, linux- stable <stable@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, lkft-triage@lists.linaro.org
List-Id: linux-perf-users.vger.kernel.org

On Mon, Dec 16, 2019 at 09:37:02PM +0530, Naresh Kamboju wrote:
> This patch merged into stable-rc tree and perf build failed on OE for
> Linaro builds for 5.3, 4.19, 4.14 and 4.9.
> Please find build error logs here,
> 
> tests/backward-ring-buffer.c: In function 'test__backward_ring_buffer':
> tests/backward-ring-buffer.c:147:2: warning: implicit declaration of
> function 'evlist__close'; did you mean 'perf_evlist__close'?
> [-Wimplicit-function-declaration]
>   evlist__close(evlist);
>   ^~~~~~~~~~~~~
>   perf_evlist__close
> tests/backward-ring-buffer.c:147:2: warning: nested extern declaration
> of 'evlist__close' [-Wnested-externs]
> tests/backward-ring-buffer.c:149:8: warning: implicit declaration of
> function 'evlist__open'; did you mean 'perf_evlist__open'?
> [-Wimplicit-function-declaration]
>   err = evlist__open(evlist);
>         ^~~~~~~~~~~~
>         perf_evlist__open
> tests/backward-ring-buffer.c:149:8: warning: nested extern declaration
> of 'evlist__open' [-Wnested-externs]
> perf/1.0-r9/recipe-sysroot/usr/lib/python2.7/config/libpython2.7.a(posixmodule.o):
> In function `posix_tmpnam':
> /usr/src/debug/python/2.7.15-r1/Python-2.7.15/Modules/posixmodule.c:7648:
> warning: the use of `tmpnam_r' is dangerous, better use `mkstemp'
> perf/1.0-r9/recipe-sysroot/usr/lib/python2.7/config/libpython2.7.a(posixmodule.o):
> In function `posix_tempnam':
> /usr/src/debug/python/2.7.15-r1/Python-2.7.15/Modules/posixmodule.c:7595:
> warning: the use of `tempnam' is dangerous, better use `mkstemp'
> perf/1.0-r9/perf-1.0/perf-in.o: In function `test__backward_ring_buffer':
> perf/1.0-r9/perf-1.0/tools/perf/tests/backward-ring-buffer.c:147:
> undefined reference to `evlist__close'
> perf/1.0-r9/perf-1.0/tools/perf/tests/backward-ring-buffer.c:149:
> undefined reference to `evlist__open'
> 
> Full log can be found at,
> https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-5.3/DISTRO=lkft,MACHINE=hikey,label=docker-lkft/72/consoleText
> https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-4.19/DISTRO=lkft,MACHINE=intel-corei7-64,label=docker-lkft/378/consoleText
> https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-4.14/DISTRO=lkft,MACHINE=intel-corei7-64,label=docker-lkft/675/consoleText
> https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-4.9/DISTRO=lkft,MACHINE=intel-corei7-64,label=docker-lkft/753/consoleText
> 

Good catch, thanks, I'll go drop it from all of these queues.

greg k-h
