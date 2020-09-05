From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] tools feature: Add missing -lzstd to the fast path
 feature detection
Date: Sat, 5 Sep 2020 12:26:14 +0900
Message-ID: <CAM9d7cj0PpuFDTQ+iqAtaFS=SCRM+=1bmV=jC5+eKbTfne4Z_A@mail.gmail.com>
References: <20200904202611.GJ3753976@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200904202611.GJ3753976@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Sat, Sep 5, 2020 at 5:26 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> We were failing that due to GTK2+ and then for the ZSTD test, which made
> test-all.c, the fast path feature detection file to fail and thus
> trigger building all of the feature tests, slowing down the test.
>
> Eventually the ZSTD test would be built and would succeed, since it had
> the needed -lzstd, avoiding:
>
>   $ cat /tmp/build/perf/feature/test-all.make.output
>   /usr/bin/ld: /tmp/ccRRJQ4u.o: in function `main_test_libzstd':
>   /home/acme/git/perf/tools/build/feature/test-libzstd.c:8: undefined reference to `ZSTD_createCStream'
>   /usr/bin/ld: /home/acme/git/perf/tools/build/feature/test-libzstd.c:9: undefined reference to `ZSTD_freeCStream'
>   collect2: error: ld returned 1 exit status
>   $
>
> Fix it by adding -lzstd to the test-all target.
>
> Now I need an entry to 'perf test' to make sure that
> /tmp/build/perf/feature/test-all.make.output is empty...
>
> Fixes: 3b1c5d9659718263 ("tools build: Implement libzstd feature check, LIBZSTD_DIR and NO_LIBZSTD defines")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung

>
> ---
>
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 977067e34dff064d..ec815ffc7777a02b 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -91,7 +91,7 @@ __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(
>  ###############################
>
>  $(OUTPUT)test-all.bin:
> -       $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -I/usr/include/slang -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma
> +       $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -I/usr/include/slang -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd
>
>  $(OUTPUT)test-hello.bin:
>         $(BUILD)
