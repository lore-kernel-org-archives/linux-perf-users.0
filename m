From: Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH 56/63] perf tests: Fix out of bounds memory access
Date: Mon, 16 Dec 2019 21:37:02 +0530
Message-ID: <CA+G9fYu-sGYutfX5K5LyAZ8cUfNpWomtyA_0SQsHyej0jD8qTw@mail.gmail.com>
References: <20191107190011.23924-1-acme@kernel.org> <20191107190011.23924-57-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191107190011.23924-57-acme@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, open list <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, linux- stable <stable@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, lkft-triage@lists.linaro.org
List-Id: linux-perf-users.vger.kernel.org

This patch merged into stable-rc tree and perf build failed on OE for
Linaro builds for 5.3, 4.19, 4.14 and 4.9.
Please find build error logs here,

tests/backward-ring-buffer.c: In function 'test__backward_ring_buffer':
tests/backward-ring-buffer.c:147:2: warning: implicit declaration of
function 'evlist__close'; did you mean 'perf_evlist__close'?
[-Wimplicit-function-declaration]
  evlist__close(evlist);
  ^~~~~~~~~~~~~
  perf_evlist__close
tests/backward-ring-buffer.c:147:2: warning: nested extern declaration
of 'evlist__close' [-Wnested-externs]
tests/backward-ring-buffer.c:149:8: warning: implicit declaration of
function 'evlist__open'; did you mean 'perf_evlist__open'?
[-Wimplicit-function-declaration]
  err = evlist__open(evlist);
        ^~~~~~~~~~~~
        perf_evlist__open
tests/backward-ring-buffer.c:149:8: warning: nested extern declaration
of 'evlist__open' [-Wnested-externs]
perf/1.0-r9/recipe-sysroot/usr/lib/python2.7/config/libpython2.7.a(posixmodule.o):
In function `posix_tmpnam':
/usr/src/debug/python/2.7.15-r1/Python-2.7.15/Modules/posixmodule.c:7648:
warning: the use of `tmpnam_r' is dangerous, better use `mkstemp'
perf/1.0-r9/recipe-sysroot/usr/lib/python2.7/config/libpython2.7.a(posixmodule.o):
In function `posix_tempnam':
/usr/src/debug/python/2.7.15-r1/Python-2.7.15/Modules/posixmodule.c:7595:
warning: the use of `tempnam' is dangerous, better use `mkstemp'
perf/1.0-r9/perf-1.0/perf-in.o: In function `test__backward_ring_buffer':
perf/1.0-r9/perf-1.0/tools/perf/tests/backward-ring-buffer.c:147:
undefined reference to `evlist__close'
perf/1.0-r9/perf-1.0/tools/perf/tests/backward-ring-buffer.c:149:
undefined reference to `evlist__open'

Full log can be found at,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-5.3/DISTRO=lkft,MACHINE=hikey,label=docker-lkft/72/consoleText
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-4.19/DISTRO=lkft,MACHINE=intel-corei7-64,label=docker-lkft/378/consoleText
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-4.14/DISTRO=lkft,MACHINE=intel-corei7-64,label=docker-lkft/675/consoleText
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-4.9/DISTRO=lkft,MACHINE=intel-corei7-64,label=docker-lkft/753/consoleText


On Fri, 8 Nov 2019 at 00:38, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> From: Leo Yan <leo.yan@linaro.org>
>
> The test case 'Read backward ring buffer' failed on 32-bit architectures
> which were found by LKFT perf testing.  The test failed on arm32 x15
> device, qemu_arm32, qemu_i386, and found intermittent failure on i386;
> the failure log is as below:
>
>   50: Read backward ring buffer                  :
>   --- start ---
>   test child forked, pid 510
>   Using CPUID GenuineIntel-6-9E-9
>   mmap size 1052672B
>   mmap size 8192B
>   Finished reading overwrite ring buffer: rewind
>   free(): invalid next size (fast)
>   test child interrupted
>   ---- end ----
>   Read backward ring buffer: FAILED!
>
> The log hints there have issue for memory usage, thus free() reports
> error 'invalid next size' and directly exit for the case.  Finally, this
> issue is root caused as out of bounds memory access for the data array
> 'evsel->id'.
>
> The backward ring buffer test invokes do_test() twice.  'evsel->id' is
> allocated at the first call with the flow:
>
>   test__backward_ring_buffer()
>     `-> do_test()
>           `-> evlist__mmap()
>                 `-> evlist__mmap_ex()
>                       `-> perf_evsel__alloc_id()
>
> So 'evsel->id' is allocated with one item, and it will be used in
> function perf_evlist__id_add():
>
>    evsel->id[0] = id
>    evsel->ids   = 1
>
> At the second call for do_test(), it skips to initialize 'evsel->id'
> and reuses the array which is allocated in the first call.  But
> 'evsel->ids' contains the stale value.  Thus:
>
>    evsel->id[1] = id    -> out of bound access
>    evsel->ids   = 2
>
> To fix this issue, we will use evlist__open() and evlist__close() pair
> functions to prepare and cleanup context for evlist; so 'evsel->id' and
> 'evsel->ids' can be initialized properly when invoke do_test() and avoid
> the out of bounds memory access.
>
> Fixes: ee74701ed8ad ("perf tests: Add test to check backward ring buffer")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Wang Nan <wangnan0@huawei.com>
> Cc: stable@vger.kernel.org # v4.10+
> Link: http://lore.kernel.org/lkml/20191107020244.2427-1-leo.yan@linaro.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/backward-ring-buffer.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
> index a4cd30c0beb3..15cea518f5ad 100644
> --- a/tools/perf/tests/backward-ring-buffer.c
> +++ b/tools/perf/tests/backward-ring-buffer.c
> @@ -148,6 +148,15 @@ int test__backward_ring_buffer(struct test *test __maybe_unused, int subtest __m
>                 goto out_delete_evlist;
>         }
>
> +       evlist__close(evlist);
> +
> +       err = evlist__open(evlist);
> +       if (err < 0) {
> +               pr_debug("perf_evlist__open: %s\n",
> +                        str_error_r(errno, sbuf, sizeof(sbuf)));
> +               goto out_delete_evlist;
> +       }
> +
>         err = do_test(evlist, 1, &sample_count, &comm_count);
>         if (err != TEST_OK)
>                 goto out_delete_evlist;
> --
> 2.21.0
>
