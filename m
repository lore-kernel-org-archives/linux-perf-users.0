From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH 11/36] tools build feature: Check if pthread_barrier_t is available
Date: Wed, 6 Dec 2017 22:31:50 +0100
Message-ID: <CAOFm3uFr62eP7drBcm4U_91qH8=WTC_kd-8XFH7MfEia6gU_Jg@mail.gmail.com>
References: <20171206144115.15097-1-acme@kernel.org> <20171206144115.15097-12-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206144115.15097-12-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, James Yang <james.yang@arm.com>, Jiri Olsa <jolsa@kernel.org>, Kim Phillips <kim.phillips@arm.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Dec 6, 2017 at 3:40 PM, Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> As 'perf bench futex wake-parallel" will use this, which is not
> available in older systems such as versions of the android NDK used in
> my container build tests (r12b and r15c at the moment).
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: James Yang <james.yang@arm.com
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kim Phillips <kim.phillips@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Wang Nan <wangnan0@huawei.com>
> Link: https://lkml.kernel.org/n/tip-1i7iv54in4wj08lwo55b0pzv@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/build/Makefile.feature               |  1 +
>  tools/build/feature/Makefile               |  4 ++++
>  tools/build/feature/test-all.c             |  5 +++++
>  tools/build/feature/test-pthread-barrier.c | 12 ++++++++++++
>  tools/perf/Makefile.config                 |  4 ++++
>  5 files changed, 26 insertions(+)
>  create mode 100644 tools/build/feature/test-pthread-barrier.c
>
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index c71a05b9c984..e52fcefee379 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -56,6 +56,7 @@ FEATURE_TESTS_BASIC :=                  \
>          libunwind-arm                   \
>          libunwind-aarch64               \
>          pthread-attr-setaffinity-np     \
> +        pthread-barrier                \
>          stackprotector-all              \
>          timerfd                         \
>          libdw-dwarf-unwind              \
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 96982640fbf8..cff38f342283 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -37,6 +37,7 @@ FILES=                                          \
>           test-libunwind-debug-frame-arm.bin     \
>           test-libunwind-debug-frame-aarch64.bin \
>           test-pthread-attr-setaffinity-np.bin   \
> +         test-pthread-barrier.bin              \
>           test-stackprotector-all.bin            \
>           test-timerfd.bin                       \
>           test-libdw-dwarf-unwind.bin            \
> @@ -79,6 +80,9 @@ $(OUTPUT)test-hello.bin:
>  $(OUTPUT)test-pthread-attr-setaffinity-np.bin:
>         $(BUILD) -D_GNU_SOURCE -lpthread
>
> +$(OUTPUT)test-pthread-barrier.bin:
> +       $(BUILD) -lpthread
> +
>  $(OUTPUT)test-stackprotector-all.bin:
>         $(BUILD) -fstack-protector-all
>
> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
> index 4112702e4aed..6fdf83263ab7 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -118,6 +118,10 @@
>  # include "test-pthread-attr-setaffinity-np.c"
>  #undef main
>
> +#define main main_test_pthread_barrier
> +# include "test-pthread-barrier.c"
> +#undef main
> +
>  #define main main_test_sched_getcpu
>  # include "test-sched_getcpu.c"
>  #undef main
> @@ -187,6 +191,7 @@ int main(int argc, char *argv[])
>         main_test_sync_compare_and_swap(argc, argv);
>         main_test_zlib();
>         main_test_pthread_attr_setaffinity_np();
> +       main_test_pthread_barrier();
>         main_test_lzma();
>         main_test_get_cpuid();
>         main_test_bpf();
> diff --git a/tools/build/feature/test-pthread-barrier.c b/tools/build/feature/test-pthread-barrier.c
> new file mode 100644
> index 000000000000..0558d9334d97
> --- /dev/null
> +++ b/tools/build/feature/test-pthread-barrier.c
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdint.h>
> +#include <pthread.h>
> +
> +int main(void)
> +{
> +       pthread_barrier_t barrier;
> +
> +       pthread_barrier_init(&barrier, NULL, 1);
> +       pthread_barrier_wait(&barrier);
> +       return pthread_barrier_destroy(&barrier);
> +}
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index f6786fa2419f..2c437baf8364 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -263,6 +263,10 @@ ifeq ($(feature-pthread-attr-setaffinity-np), 1)
>    CFLAGS += -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP
>  endif
>
> +ifeq ($(feature-pthread-barrier), 1)
> +  CFLAGS += -DHAVE_PTHREAD_BARRIER
> +endif
> +
>  ifndef NO_BIONIC
>    $(call feature_check,bionic)
>    ifeq ($(feature-bionic), 1)
> --
> 2.13.6
>

Arnaldo: for the use of SPDX ids in the hwol patch series, thank you very much.
Acked-by: Philippe Ombredanne <pombredanne@nexb.com>

-- 
Cordially
Philippe Ombredanne
