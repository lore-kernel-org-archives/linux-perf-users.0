From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] Fixes issue when debugging debug builds of Perf.
Date: Tue, 29 Oct 2019 11:00:52 -0300
Message-ID: <20191029140052.GB4922@kernel.org>
References: <20191028113340.4282-1-james.clark@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191028113340.4282-1-james.clark@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Clark <James.Clark@arm.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, nd <nd@arm.com>, "acme@redhat.com" <acme@redhat.com>, "irogers@google.com" <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Oct 28, 2019 at 11:34:01AM +0000, James Clark escreveu:
> When a 'make DEBUG=1' build is done, the command parser
> is still built with -O6 and is hard to step through.
> 
> This change also moves EXTRA_WARNINGS and EXTRA_FLAGS to
> the end of the compilation line, otherwise they cannot be
> used to override the default values.

The patch came mangled, so I'm applying by hand, and separating it into
two patches, the first for the first paragraph and the other for the
second, ok?

- Arnaldo
 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/lib/subcmd/Makefile | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
> index 5b2cd5e58df0..1c777a72bb39 100644
> --- a/tools/lib/subcmd/Makefile
> +++ b/tools/lib/subcmd/Makefile
> @@ -19,8 +19,7 @@ MAKEFLAGS += --no-print-directory
>  
>  LIBFILE = $(OUTPUT)libsubcmd.a
>  
> -CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
> -CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -fPIC
> +CFLAGS := -ggdb3 -Wall -Wextra -std=gnu99 -fPIC
>  
>  ifeq ($(DEBUG),0)
>    ifeq ($(feature-fortify-source), 1)
> @@ -28,7 +27,9 @@ ifeq ($(DEBUG),0)
>    endif
>  endif
>  
> -ifeq ($(CC_NO_CLANG), 0)
> +ifeq ($(DEBUG),1)
> +  CFLAGS += -O0
> +else ifeq ($(CC_NO_CLANG), 0)
>    CFLAGS += -O3
>  else
>    CFLAGS += -O6
> @@ -43,6 +44,8 @@ CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
>  
>  CFLAGS += -I$(srctree)/tools/include/
>  
> +CFLAGS += $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
> +
>  SUBCMD_IN := $(OUTPUT)libsubcmd-in.o
>  
>  all:
> -- 
> 2.23.0

-- 

- Arnaldo
