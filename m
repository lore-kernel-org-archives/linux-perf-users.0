Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FB7F9DA;
	Fri,  7 Mar 2025 01:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741310091; cv=none; b=UoSbhXZEDmY/pI5NUXaFr0X4sr5RwjdHRAAoZAGzOvh8v/9GyAyKDJTI0XH4chqmPjK3B2ZhH7lfenXtkz/FKCi0sjGXvt2I8VhzgXS3CEZK8xULaP48yvaVpu12W2mkjVH169QddTXZbUtBkj/0t4bkd5vt6VitfwcKWMvBj/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741310091; c=relaxed/simple;
	bh=nPxi1R9wqYshB4RGiTst8wDkKwvkQuArDF4nSaRBlDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dogEEbAdEJDn8OdFHoCpqy0UUZWDbLM3XaTF0F1E3sqIm9Mt6nCggkAdWbyUOtPR8L8gY4zXONRxJdaCSExDry+H/GzRXxtOs3TzaoR3ZFVJx8MpMi/7zkxrVCHUlFN1vyDPc7WOHIGed+EB/1fbnHs+L7/qd6OBuF2xug0i8DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUBIFdar; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUBIFdar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338C5C4CEE0;
	Fri,  7 Mar 2025 01:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741310091;
	bh=nPxi1R9wqYshB4RGiTst8wDkKwvkQuArDF4nSaRBlDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CUBIFdar1gT515+tHm6gO96vw+nqaC6RkPVMIA+BsRvDwqu5CnK0oZfhGQRFen92F
	 eOUoDGJuYo7CZ34AatHnJR4uEy10PfyOOWiRpX5sCYKkn5/cRvc4moHASFKZ2fATsN
	 2HZpL+c3/5mxhuZZXftf0ksK7gsx+Z2Ewxw6jMvkjHW4ObqSsJ9BQKwLnAxvKO8EZN
	 KP32Jt7QF5g5aAC7NKb1O+xDPKVWw/l5WDEUGni+nrjYnDzH+4Vwkpkr2RpC9B/KXC
	 9n+jKqEg0wE5KAV2a8f4MPIMn2zxI6s02aMYTVGe7EckwbbLXXm/3ahE3RXMlDL1dt
	 SE60x/Ygw1kIw==
Date: Thu, 6 Mar 2025 17:14:48 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	guoren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 02/11] perf dso: kernel-doc for enum dso_binary_type
Message-ID: <Z8pIiM2Z_jtNNUhN@google.com>
References: <20250304050305.901167-1-irogers@google.com>
 <20250304050305.901167-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304050305.901167-3-irogers@google.com>

On Mon, Mar 03, 2025 at 09:02:56PM -0800, Ian Rogers wrote:
> There are many and non-obvious meanings to the dso_binary_type enum
> values. Add kernel-doc to speed interpretting their meanings.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/dso.h | 53 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index dfd763a0bd9d..f3ca2a5e7670 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -20,30 +20,83 @@ struct perf_env;
>  #define DSO__NAME_KALLSYMS	"[kernel.kallsyms]"
>  #define DSO__NAME_KCORE		"[kernel.kcore]"
>  
> +/**
> + * enum dso_binary_type - The kind of DSO generally associated with a memory
> + *                        region (struct map).
> + */

Thanks for adding these comments!


>  enum dso_binary_type {
> +	/** @DSO_BINARY_TYPE__KALLSYMS: Symbols from /proc/kallsyms file. */
>  	DSO_BINARY_TYPE__KALLSYMS = 0,
> +	/** @DSO_BINARY_TYPE__GUEST_KALLSYMS: Guest /proc/kallsyms file. */
>  	DSO_BINARY_TYPE__GUEST_KALLSYMS,
> +	/** @DSO_BINARY_TYPE__VMLINUX: Path to guest kernel /boot/vmlinux file. */
>  	DSO_BINARY_TYPE__VMLINUX,

It's not for guest.  Also I think the vmlinux file can come from
different places.


> +	/** @DSO_BINARY_TYPE__GUEST_VMLINUX: Path to kernel /boot/vmlinux file. */
>  	DSO_BINARY_TYPE__GUEST_VMLINUX,

This is for guest. :)

Thanks,
Namhyung


> +	/** @DSO_BINARY_TYPE__JAVA_JIT: Symbols from /tmp/perf.map file. */
>  	DSO_BINARY_TYPE__JAVA_JIT,
> +	/**
> +	 * @DSO_BINARY_TYPE__DEBUGLINK: Debug file readable from the file path
> +	 * in the .gnu_debuglink ELF section of the dso.
> +	 */
>  	DSO_BINARY_TYPE__DEBUGLINK,
> +	/**
> +	 * @DSO_BINARY_TYPE__BUILD_ID_CACHE: File named after buildid located in
> +	 * the buildid cache with an elf filename.
> +	 */
>  	DSO_BINARY_TYPE__BUILD_ID_CACHE,
> +	/**
> +	 * @DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO: File named after buildid
> +	 * located in the buildid cache with a debug filename.
> +	 */
>  	DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO,
> +	/**
> +	 * @DSO_BINARY_TYPE__FEDORA_DEBUGINFO: Debug file in /usr/lib/debug
> +	 * with .debug suffix.
> +	 */
>  	DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
> +	/** @DSO_BINARY_TYPE__UBUNTU_DEBUGINFO: Debug file in /usr/lib/debug. */
>  	DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
> +	/**
> +	 * @DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO: dso__long_name debuginfo
> +	 * file in /usr/lib/debug/lib rather than the expected
> +	 * /usr/lib/debug/usr/lib.
> +	 */
>  	DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
> +	/**
> +	 * @DSO_BINARY_TYPE__BUILDID_DEBUGINFO: File named after buildid located
> +	 * in /usr/lib/debug/.build-id/.
> +	 */
>  	DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
> +	/** @DSO_BINARY_TYPE__SYSTEM_PATH_DSO: A regular executable/shared-object file. */
>  	DSO_BINARY_TYPE__SYSTEM_PATH_DSO,
> +	/** @DSO_BINARY_TYPE__GUEST_KMODULE: Guest kernel module .ko file. */
>  	DSO_BINARY_TYPE__GUEST_KMODULE,
> +	/** @DSO_BINARY_TYPE__GUEST_KMODULE_COMP: Guest kernel module .ko.gz file. */
>  	DSO_BINARY_TYPE__GUEST_KMODULE_COMP,
> +	/** @DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE: Kernel module .ko file. */
>  	DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE,
> +	/** @DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP: Kernel module .ko.gz file. */
>  	DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP,
> +	/** @DSO_BINARY_TYPE__KCORE: /proc/kcore file. */
>  	DSO_BINARY_TYPE__KCORE,
> +	/** @DSO_BINARY_TYPE__GUEST_KCORE: Guest /proc/kcore file. */
>  	DSO_BINARY_TYPE__GUEST_KCORE,
> +	/**
> +	 * @DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO: Openembedded/Yocto -dbg
> +	 * package debug info.
> +	 */
>  	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
> +	/** @DSO_BINARY_TYPE__BPF_PROG_INFO: jitted BPF code. */
>  	DSO_BINARY_TYPE__BPF_PROG_INFO,
> +	/** @DSO_BINARY_TYPE__BPF_IMAGE: jitted BPF trampoline or dispatcher code. */
>  	DSO_BINARY_TYPE__BPF_IMAGE,
> +	/**
> +	 * @DSO_BINARY_TYPE__OOL: out of line code such as kprobe-replaced
> +	 * instructions or optimized kprobes or ftrace trampolines.
> +	 */
>  	DSO_BINARY_TYPE__OOL,
> +	/** @DSO_BINARY_TYPE__NOT_FOUND: Unknown DSO kind. */
>  	DSO_BINARY_TYPE__NOT_FOUND,
>  };
>  
> -- 
> 2.48.1.711.g2feabab25a-goog
> 
