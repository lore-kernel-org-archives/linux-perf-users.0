Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD92A2E285C;
	Mon, 30 Mar 2026 21:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774904938; cv=none; b=PZF2iwYyYuxqHlOI4LttQxwR6yDYlhSHlhs4Kc9z1lDCEC47rTt0O2Znrr3XKbuboynBoQPdfoJacEvKTF3KHZM8k9tZlMCzRzfVIj7ST/MkN4nsHl8Q+PrSTE7gexFrWImQkcdZWGnUTvxgUYBBmVzNx2kFbvYJyzib80F5ve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774904938; c=relaxed/simple;
	bh=LihhuuGe1wazeIERreGWoOQzwjMDxoaIwNu5UQf1i+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJoBgeEkEsnGjtqCDpabJa8iylQh2XtRy1JwwFp1b+Clpr47zczYcHlU0ZC9PQUPD0gHcSA2IyJkSts9LxBj/uKJJFLntN5UBPcaqKvXmYTPU/8GoEQe56L5DG9Vuwfu2YXy8ytOzbnuJVAaAD4FjzFABVxeHeolMwV7t5Yfke0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BS+GTEim; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BS+GTEim"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D42C4CEF7;
	Mon, 30 Mar 2026 21:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774904938;
	bh=LihhuuGe1wazeIERreGWoOQzwjMDxoaIwNu5UQf1i+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BS+GTEim568F04dnhh9XAU5AQN7Q13SwG/8IuKUOtbOpW7onARby5I9+GrZZ767lU
	 nOat2vBN2MnxE7jpMej9shSQ16WGOcSkHLr8bv6yAqVfmifA4RhSASiCgEYwMzWpYY
	 gJl3EzxV0Ah9z/GucNJk55BIFq6maZQp+KFFJdX08vCKwjp39bc6u7cRJf9Kgl4598
	 hro1Pjwinda/adRsCCD2VvL+fp93QugQjq1QOjyqZnNZ1pBFWzOq5LM0LiZ+wi61J7
	 n/vvBsGd8sc0fAJD5ZsQ/ZmmPUbOQzJRNizfG5tgsLWTTu89QG1lg+EaLGkYX7bK1a
	 SKEGGGSJxvCrQ==
Date: Mon, 30 Mar 2026 18:08:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr,
	alexander.shishkin@linux.intel.com, andrew.jones@oss.qualcomm.com,
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
	blakejones@google.com, ctshao@google.com,
	dapeng1.mi@linux.intel.com, howardchu95@gmail.com,
	james.clark@linaro.org, john.g.garry@oracle.com, jolsa@kernel.org,
	leo.yan@linux.dev, libunwind-devel@nongnu.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
	mingo@redhat.com, namhyung@kernel.org, palmer@dabbelt.com,
	peterz@infradead.org, pjw@kernel.org, shimin.guo@skydio.com,
	tglozar@redhat.com, tmricht@linux.ibm.com, will@kernel.org,
	yuzhuo@google.com
Subject: Re: [PATCH v2 3/8] tools build: Deduplicate test-libunwind for
 different architectures
Message-ID: <acrmZbWi-uhXjIfU@x1>
References: <CAP-5=fWVU3ktkGAnZQrjQJf+Z5AtQo73BVUhj-nr3H95GdcEJQ@mail.gmail.com>
 <20260305221927.3237145-1-irogers@google.com>
 <20260305221927.3237145-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305221927.3237145-4-irogers@google.com>

On Thu, Mar 05, 2026 at 02:19:22PM -0800, Ian Rogers wrote:
> The separate test files only exist to pass a different #include,
> instead have a single source file and pass -include to $(CC) to
> include the relevant header file for the architecture being
> tested. Generate the rules using a foreach loop. Include tests for all
> current libunwind architectures.

Clever :-)

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/build/feature/Makefile                  | 38 +++++++++----------
>  tools/build/feature/test-libunwind-aarch64.c  | 27 -------------
>  tools/build/feature/test-libunwind-arm.c      | 28 --------------
>  .../test-libunwind-debug-frame-aarch64.c      | 17 ---------
>  .../feature/test-libunwind-debug-frame-arm.c  | 17 ---------
>  .../feature/test-libunwind-debug-frame.c      |  1 -
>  tools/build/feature/test-libunwind-x86.c      | 28 --------------
>  tools/build/feature/test-libunwind-x86_64.c   | 28 --------------
>  tools/build/feature/test-libunwind.c          |  1 -
>  9 files changed, 19 insertions(+), 166 deletions(-)
>  delete mode 100644 tools/build/feature/test-libunwind-aarch64.c
>  delete mode 100644 tools/build/feature/test-libunwind-arm.c
>  delete mode 100644 tools/build/feature/test-libunwind-debug-frame-aarch64.c
>  delete mode 100644 tools/build/feature/test-libunwind-debug-frame-arm.c
>  delete mode 100644 tools/build/feature/test-libunwind-x86.c
>  delete mode 100644 tools/build/feature/test-libunwind-x86_64.c
> 
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 1fbcb3ce74d2..a0b40e826688 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -204,27 +204,27 @@ $(OUTPUT)test-numa_num_possible_cpus.bin:
>  	$(BUILD) -lnuma
>  
>  $(OUTPUT)test-libunwind.bin:
> -	$(BUILD) -lelf -llzma
> +	$(BUILD) -include libunwind.h -lelf -llzma -lunwind
>  
>  $(OUTPUT)test-libunwind-debug-frame.bin:
> -	$(BUILD) -lelf -llzma
> -$(OUTPUT)test-libunwind-x86.bin:
> -	$(BUILD) -lelf -llzma -lunwind-x86
> -
> -$(OUTPUT)test-libunwind-x86_64.bin:
> -	$(BUILD) -lelf -llzma -lunwind-x86_64
> -
> -$(OUTPUT)test-libunwind-arm.bin:
> -	$(BUILD) -lelf -llzma -lunwind-arm
> -
> -$(OUTPUT)test-libunwind-aarch64.bin:
> -	$(BUILD) -lelf -llzma -lunwind-aarch64
> -
> -$(OUTPUT)test-libunwind-debug-frame-arm.bin:
> -	$(BUILD) -lelf -llzma -lunwind-arm
> -
> -$(OUTPUT)test-libunwind-debug-frame-aarch64.bin:
> -	$(BUILD) -lelf -llzma -lunwind-aarch64
> +	$(BUILD) -include libunwind.h -lelf -llzma -lunwind
> +
> +LIBUNWIND_ARCHS:=aarch64 arm loongarch64 mips ppc32 ppc64 riscv s390x x86 x86_64
> +define LIBUNWIND_RULE
> +$$(OUTPUT)test-libunwind-$(1).bin:
> +	$$(CC) $$(CFLAGS) -MD -Wall -Werror -include libunwind-$(1).h -o $$@ \
> +		test-libunwind.c $$(LDFLAGS) -lelf -llzma -lunwind-$(1) \
> +		> $$(@:.bin=.make.output) 2>&1
> +
> +$$(OUTPUT)test-libunwind-debug-frame-$(1).bin:
> +	$$(CC) $$(CFLAGS) -MD -Wall -Werror -include libunwind-$(1).h -o $$@ \
> +		test-libunwind-debug-frame.c $$(LDFLAGS) -lelf -llzma -lunwind-$(1) \
> +		> $$(@:.bin=.make.output) 2>&1
> +
> +endef
> +$(foreach arch,$(LIBUNWIND_ARCHS), \
> +    $(eval $(call LIBUNWIND_RULE,$(arch))) \
> +)
>  
>  $(OUTPUT)test-libslang.bin:
>  	$(BUILD) -lslang
> diff --git a/tools/build/feature/test-libunwind-aarch64.c b/tools/build/feature/test-libunwind-aarch64.c
> deleted file mode 100644
> index 323803f49212..000000000000
> --- a/tools/build/feature/test-libunwind-aarch64.c
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <libunwind-aarch64.h>
> -#include <stdlib.h>
> -
> -extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
> -					       unw_word_t ip,
> -					       unw_dyn_info_t *di,
> -					       unw_proc_info_t *pi,
> -					       int need_unwind_info, void *arg);
> -
> -#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
> -
> -static unw_accessors_t accessors;
> -
> -int main(void)
> -{
> -	unw_addr_space_t addr_space;
> -
> -	addr_space = unw_create_addr_space(&accessors, 0);
> -	if (addr_space)
> -		return 0;
> -
> -	unw_init_remote(NULL, addr_space, NULL);
> -	dwarf_search_unwind_table(addr_space, 0, NULL, NULL, 0, NULL);
> -
> -	return 0;
> -}
> diff --git a/tools/build/feature/test-libunwind-arm.c b/tools/build/feature/test-libunwind-arm.c
> deleted file mode 100644
> index cb378b7d6866..000000000000
> --- a/tools/build/feature/test-libunwind-arm.c
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <libunwind-arm.h>
> -#include <stdlib.h>
> -
> -extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
> -					       unw_word_t ip,
> -					       unw_dyn_info_t *di,
> -					       unw_proc_info_t *pi,
> -					       int need_unwind_info, void *arg);
> -
> -
> -#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
> -
> -static unw_accessors_t accessors;
> -
> -int main(void)
> -{
> -	unw_addr_space_t addr_space;
> -
> -	addr_space = unw_create_addr_space(&accessors, 0);
> -	if (addr_space)
> -		return 0;
> -
> -	unw_init_remote(NULL, addr_space, NULL);
> -	dwarf_search_unwind_table(addr_space, 0, NULL, NULL, 0, NULL);
> -
> -	return 0;
> -}
> diff --git a/tools/build/feature/test-libunwind-debug-frame-aarch64.c b/tools/build/feature/test-libunwind-debug-frame-aarch64.c
> deleted file mode 100644
> index 36d6646c185e..000000000000
> --- a/tools/build/feature/test-libunwind-debug-frame-aarch64.c
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <libunwind-aarch64.h>
> -#include <stdlib.h>
> -
> -extern int
> -UNW_OBJ(dwarf_find_debug_frame) (int found, unw_dyn_info_t *di_debug,
> -				 unw_word_t ip, unw_word_t segbase,
> -				 const char *obj_name, unw_word_t start,
> -				 unw_word_t end);
> -
> -#define dwarf_find_debug_frame UNW_OBJ(dwarf_find_debug_frame)
> -
> -int main(void)
> -{
> -	dwarf_find_debug_frame(0, NULL, 0, 0, NULL, 0, 0);
> -	return 0;
> -}
> diff --git a/tools/build/feature/test-libunwind-debug-frame-arm.c b/tools/build/feature/test-libunwind-debug-frame-arm.c
> deleted file mode 100644
> index 8696e48e1268..000000000000
> --- a/tools/build/feature/test-libunwind-debug-frame-arm.c
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <libunwind-arm.h>
> -#include <stdlib.h>
> -
> -extern int
> -UNW_OBJ(dwarf_find_debug_frame) (int found, unw_dyn_info_t *di_debug,
> -				 unw_word_t ip, unw_word_t segbase,
> -				 const char *obj_name, unw_word_t start,
> -				 unw_word_t end);
> -
> -#define dwarf_find_debug_frame UNW_OBJ(dwarf_find_debug_frame)
> -
> -int main(void)
> -{
> -	dwarf_find_debug_frame(0, NULL, 0, 0, NULL, 0, 0);
> -	return 0;
> -}
> diff --git a/tools/build/feature/test-libunwind-debug-frame.c b/tools/build/feature/test-libunwind-debug-frame.c
> index efb55cdd8d01..4c57e37004b3 100644
> --- a/tools/build/feature/test-libunwind-debug-frame.c
> +++ b/tools/build/feature/test-libunwind-debug-frame.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <libunwind.h>
>  #include <stdlib.h>
>  
>  extern int
> diff --git a/tools/build/feature/test-libunwind-x86.c b/tools/build/feature/test-libunwind-x86.c
> deleted file mode 100644
> index e5e0f6c89637..000000000000
> --- a/tools/build/feature/test-libunwind-x86.c
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <libunwind-x86.h>
> -#include <stdlib.h>
> -
> -extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
> -					       unw_word_t ip,
> -					       unw_dyn_info_t *di,
> -					       unw_proc_info_t *pi,
> -					       int need_unwind_info, void *arg);
> -
> -
> -#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
> -
> -static unw_accessors_t accessors;
> -
> -int main(void)
> -{
> -	unw_addr_space_t addr_space;
> -
> -	addr_space = unw_create_addr_space(&accessors, 0);
> -	if (addr_space)
> -		return 0;
> -
> -	unw_init_remote(NULL, addr_space, NULL);
> -	dwarf_search_unwind_table(addr_space, 0, NULL, NULL, 0, NULL);
> -
> -	return 0;
> -}
> diff --git a/tools/build/feature/test-libunwind-x86_64.c b/tools/build/feature/test-libunwind-x86_64.c
> deleted file mode 100644
> index 62ae4db597dc..000000000000
> --- a/tools/build/feature/test-libunwind-x86_64.c
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <libunwind-x86_64.h>
> -#include <stdlib.h>
> -
> -extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
> -					       unw_word_t ip,
> -					       unw_dyn_info_t *di,
> -					       unw_proc_info_t *pi,
> -					       int need_unwind_info, void *arg);
> -
> -
> -#define dwarf_search_unwind_table UNW_OBJ(dwarf_search_unwind_table)
> -
> -static unw_accessors_t accessors;
> -
> -int main(void)
> -{
> -	unw_addr_space_t addr_space;
> -
> -	addr_space = unw_create_addr_space(&accessors, 0);
> -	if (addr_space)
> -		return 0;
> -
> -	unw_init_remote(NULL, addr_space, NULL);
> -	dwarf_search_unwind_table(addr_space, 0, NULL, NULL, 0, NULL);
> -
> -	return 0;
> -}
> diff --git a/tools/build/feature/test-libunwind.c b/tools/build/feature/test-libunwind.c
> index 53fd26614ff0..5af5dc3a73d4 100644
> --- a/tools/build/feature/test-libunwind.c
> +++ b/tools/build/feature/test-libunwind.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <libunwind.h>
>  #include <stdlib.h>
>  
>  extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
> -- 
> 2.53.0.473.g4a7958ca14-goog
> 
