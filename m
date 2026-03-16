Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C850B38C2C9;
	Mon, 16 Mar 2026 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654230; cv=none; b=cqRcnNw6HaatmJhDxIRLMyPOMWhxGz5A0U7L5ejRCnPI+qWpfetU466OpS7XbbSC9veagHsL4FwcbiS4mShDNk8i6P4+EmR8MaOEFgL4vvJ/VgF791yP63oQTMBUFzCMy/EWAfK5E3K0RTTKmxC1abvg/twHgjL8nfo4qsbmT5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654230; c=relaxed/simple;
	bh=xdfRXTM63VAAwXNHzaAFM6innPneiAhWb2PfLXWafAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHiNnVZKKlbW2bZtkljVjlAycSnqCgRB1i1AodvzvorER5A6IFDJsQljev+S3e7CsVyLt8ExsuFkwYvZtMGZFXas7LlJRqkV4qZQwEslRREIcq1Kgyvwhn+V0u1duVGuaF+2N56nOxKkQP//eb5vXm02geD9aFy1w/OtsC5whuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97CC51477;
	Mon, 16 Mar 2026 02:43:40 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 622E63F778;
	Mon, 16 Mar 2026 02:43:46 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:43:44 +0000
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Oliver Upton <oupton@kernel.org>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: REQUEST: Syncing tools/arch/arm64/include/asm/cputype.h with the
 kernel sources
Message-ID: <20260316094344.GA8048@e132581.arm.com>
References: <aba3Z0aelph_gQ6c@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aba3Z0aelph_gQ6c@x1>

Hi Arnaldo,

[ + Mark ]

On Sun, Mar 15, 2026 at 10:43:03AM -0300, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	Can someone please address this perf build warning:
> 
>   make: Entering directory '/home/acme/git/perf-tools/tools/perf'
>   BUILD:   Doing 'make -j32' parallel build
> Warning: Kernel ABI header differences:
>   diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
> 
> I tried updating that header and got the problems below.
> 
> I just merged perf-tools with upstream, will push to tmp.perf-tools at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tmp.perf-tools
> 
> Thanks in advance,

Sorry that this issue has come up again.

A quick summary:

The plan was to extract the CPU ID definitions from cputype.h so that
kernel and userspace can share the same definitions.  This would avoid
keep syncing cputype.h between the kernel and userspace [1].

James worked on this a bit, and later Mark wanted to try a different
implementation.  However, we haven't posted formal patches yet.

To avoid extra burden on perf maintainers, I suggest removing the
cputype.h check in check-headers.sh.  In the short term, Arm developers
will take responsibility for keeping it up to date.  In the long term,
once the CPU ID refactoring is completed, we can do a proper cleanup of
cputype.h.

James, Mark, is this reasonable?

[1] https://lore.kernel.org/linux-perf-users/aFJ8bQh_30JMzF_-@J2N7QTR9R3/

> - Arnaldo
> 
> ⬢ [acme@toolbx perf-tools]$ git diff
> diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
> index 9b73c1aa3ad747ec..08860d482e60009f 100644
> --- a/tools/arch/arm64/include/asm/cputype.h
> +++ b/tools/arch/arm64/include/asm/cputype.h
> @@ -255,6 +255,16 @@
> 
>  #define read_cpuid(reg)                        read_sysreg_s(SYS_ ## reg)
> 
> +/*
> + * The CPU ID never changes at run time, so we might as well tell the
> + * compiler that it's constant.  Use this function to read the CPU ID
> + * rather than directly reading processor_id or read_cpuid() directly.
> + */
> +static inline u32 __attribute_const__ read_cpuid_id(void)
> +{
> +       return read_cpuid(MIDR_EL1);
> +}
> +
>  /*
>   * Represent a range of MIDR values for a given CPU model and a
>   * range of variant/revision values.
> @@ -290,31 +300,6 @@ static inline bool midr_is_cpu_model_range(u32 midr, u32 model, u32 rv_min,
>         return _model == model && rv >= rv_min && rv <= rv_max;
>  }
> 
> -static inline bool is_midr_in_range(u32 midr, struct midr_range const *range)
> -{
> -       return midr_is_cpu_model_range(midr, range->model,
> -                                      range->rv_min, range->rv_max);
> -}
> -
> -static inline bool
> -is_midr_in_range_list(u32 midr, struct midr_range const *ranges)
> -{
> -       while (ranges->model)
> -               if (is_midr_in_range(midr, ranges++))
> -                       return true;
> -       return false;
> ⬢ [acme@toolbx perf-tools]$ m
> make: Entering directory '/home/acme/git/perf-tools/tools/perf'
>   BUILD:   Doing 'make -j32' parallel build
> Warning: Kernel ABI header differences:
>   diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
>   diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm/svm.h
> 
> Auto-detecting system features:
> ...                                   libdw: [ on  ]
> ...                                   glibc: [ on  ]
> ...                                  libelf: [ on  ]
> ...                                 libnuma: [ on  ]
> ...                  numa_num_possible_cpus: [ on  ]
> ...                               libpython: [ on  ]
> ...                             libcapstone: [ on  ]
> ...                               llvm-perf: [ on  ]
> ...                                    zlib: [ on  ]
> ...                                    lzma: [ on  ]
> ...                                     bpf: [ on  ]
> ...                                  libaio: [ on  ]
> ...                                 libzstd: [ on  ]
> ...                              libopenssl: [ on  ]
> ...                                    rust: [ on  ]
> 
>   INSTALL libsubcmd_headers
>   INSTALL libapi_headers
>   INSTALL libperf_headers
>   INSTALL libsymbol_headers
>   INSTALL libbpf_headers
>   CC      /tmp/build/perf-tools/util/arm-spe.o
> util/arm-spe.c: In function ‘arm_spe__synth_ds’:
> util/arm-spe.c:986:43: error: passing argument 1 of ‘is_midr_in_range_list’ makes pointer from integer without a cast [-Wint-conversion]
>   986 |                 if (is_midr_in_range_list(midr, data_source_handles[i].midr_ranges)) {
>       |                                           ^~~~
>       |                                           |
>       |                                           u64 {aka long unsigned int}
> In file included from util/arm-spe.c:37:
> util/../../arch/arm64/include/asm/cputype.h:310:53: note: expected ‘const struct midr_range *’ but argument is of type ‘u64’ {aka ‘long unsigned int’}
>   310 | bool is_midr_in_range_list(struct midr_range const *ranges);
>       |                            ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> util/arm-spe.c:986:21: error: too many arguments to function ‘is_midr_in_range_list’; expected 1, have 2
>   986 |                 if (is_midr_in_range_list(midr, data_source_handles[i].midr_ranges)) {
>       |                     ^~~~~~~~~~~~~~~~~~~~~       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> util/../../arch/arm64/include/asm/cputype.h:310:6: note: declared here
>   310 | bool is_midr_in_range_list(struct midr_range const *ranges);
>       |      ^~~~~~~~~~~~~~~~~~~~~
> make[4]: *** [/home/acme/git/perf-tools/tools/build/Makefile.build:95: /tmp/build/perf-tools/util/arm-spe.o] Error 1
> make[3]: *** [/home/acme/git/perf-tools/tools/build/Makefile.build:158: util] Error 2
> make[2]: *** [Makefile.perf:797: /tmp/build/perf-tools/perf-util-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [Makefile.perf:289: sub-make] Error 2
> make: *** [Makefile:119: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf-tools/tools/perf'
> ⬢ [acme@toolbx perf-tools]$
