Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06CC23F369;
	Wed, 12 Mar 2025 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802245; cv=none; b=rz9XMnmwOmUDCtlMkH24ZBK7A0FeOEe/NnmqYsF/6p7CNDZLHq+X8PU2Kn+e9mx+Shj0+nF31QB/uSnrVdZmjnA7AcxP3E9esq3gb6Yri3TZPokiIj3xnu197uVI+BZ/FTMMLnlxUyevBLLTKDD1gzGE607q53SUGe+K6BJLLIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802245; c=relaxed/simple;
	bh=zljP+mDHAaQAZnFdNotLuiGw3OZI9tbEnF6C6rmzp7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+UbjyaZh3Qyq/LJoD9rgJ7eygZ36EWDT+lXm08i30yg4A8K8+erIT5A6T4qC7GWNUVh6UV42k2wmgGqDM2C+vL9kFNW1Uhvj7RkzPVQGESxnKopoAmt4e8CxS0k7j5wUNWfVsMTW6NfPWcZQXV00Bs8/EvTUmILy2y9amVZf6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEIcU+Uz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEIcU+Uz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A790C4CEDD;
	Wed, 12 Mar 2025 17:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741802245;
	bh=zljP+mDHAaQAZnFdNotLuiGw3OZI9tbEnF6C6rmzp7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nEIcU+Uz5BcICdmCXOe35LcQyckIKPgl3m2lHMHP2VQ1CnJY195bKoCiO9yxCVBkT
	 pwER7G7WR4IGxk0JXC6fUwPRTzGaFSnKxRDkvCOTO2Gopg6Y/NA2GGzQ+kNIrBi8x9
	 hqz/UvuRbAv/N7LHK9hjRpRfnvAnUq8mttoMckvGEgYyQsVrs8Omp6eAnG/k+TPV0W
	 4DQBEXSc1qtteDUnxE+xgD/TrG9IUibQlaPyTdH8Nn1BfaOCuRPoEPtW/JNriM86R5
	 IGRAdDG73EdBwnZ9DzAyypEOHpItoHvbWx7zsrPQUfu/Zi1qPAS/WtfJdmh9ooYCRv
	 l4uH7vHeWlLgw==
Date: Wed, 12 Mar 2025 14:57:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
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
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 06/11] perf dso: Add support for reading the e_machine
 type for a dso
Message-ID: <Z9HLArg6uGiK8FzM@x1>
References: <20250308003209.234114-1-irogers@google.com>
 <20250308003209.234114-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308003209.234114-7-irogers@google.com>

On Fri, Mar 07, 2025 at 04:32:04PM -0800, Ian Rogers wrote:
> For ELF file dsos read the e_machine from the ELF header. For kernel
> types assume the e_machine matches the perf tool. In other cases
> return EM_NONE.
> 
> When reading from the ELF header use DSO__SWAP that may need
> dso->needs_swap initializing. Factor out dso__swap_init to allow this.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/dso.c        | 88 ++++++++++++++++++++++++++++++++++++
>  tools/perf/util/dso.h        |  3 ++
>  tools/perf/util/symbol-elf.c | 27 -----------
>  3 files changed, 91 insertions(+), 27 deletions(-)

This one, due to this having already been merged:

commit b10f74308e1305275e69ddde711ec817cc69e306 (perf-tools-next/perf-tools-next)
Author: Stephen Brennan <stephen.s.brennan@oracle.com>
Date:   Fri Mar 7 15:22:03 2025 -0800

    perf symbol: Support .gnu_debugdata for symbols

Needs this so that we read the e_machine from the ELF file:

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 8188ba4d432cd5ac..8d2d8bb22e077bea 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1203,6 +1203,7 @@ uint16_t dso__e_machine(struct dso *dso, struct machine *machine)
 	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
 	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
 	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
+	case DSO_BINARY_TYPE__GNU_DEBUGDATA:
 		break;
 	case DSO_BINARY_TYPE__NOT_FOUND:
 	default:
 
---

Continuing the review and test.

- Arnaldo

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 5c6e85fdae0d..00fec1bc32bc 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1170,6 +1170,67 @@ ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine,
>  	return data_read_write_offset(dso, machine, offset, data, size, true);
>  }
>  
> +uint16_t dso__e_machine(struct dso *dso, struct machine *machine)
> +{
> +	uint16_t e_machine = EM_NONE;
> +	int fd;
> +
> +	switch (dso__binary_type(dso)) {
> +	case DSO_BINARY_TYPE__KALLSYMS:
> +	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
> +	case DSO_BINARY_TYPE__VMLINUX:
> +	case DSO_BINARY_TYPE__GUEST_VMLINUX:
> +	case DSO_BINARY_TYPE__GUEST_KMODULE:
> +	case DSO_BINARY_TYPE__GUEST_KMODULE_COMP:
> +	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE:
> +	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP:
> +	case DSO_BINARY_TYPE__KCORE:
> +	case DSO_BINARY_TYPE__GUEST_KCORE:
> +	case DSO_BINARY_TYPE__BPF_PROG_INFO:
> +	case DSO_BINARY_TYPE__BPF_IMAGE:
> +	case DSO_BINARY_TYPE__OOL:
> +	case DSO_BINARY_TYPE__JAVA_JIT:
> +		return EM_HOST;
> +	case DSO_BINARY_TYPE__DEBUGLINK:
> +	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
> +	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
> +	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
> +	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
> +	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
> +	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
> +	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
> +	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
> +		break;
> +	case DSO_BINARY_TYPE__NOT_FOUND:
> +	default:
> +		return EM_NONE;
> +	}
> +
> +	pthread_mutex_lock(&dso__data_open_lock);
> +
> +	/*
> +	 * dso__data(dso)->fd might be closed if other thread opened another
> +	 * file (dso) due to open file limit (RLIMIT_NOFILE).
> +	 */
> +	try_to_open_dso(dso, machine);
> +	fd = dso__data(dso)->fd;
> +	if (fd >= 0) {
> +		_Static_assert(offsetof(Elf32_Ehdr, e_machine) == 18, "Unexpected offset");
> +		_Static_assert(offsetof(Elf64_Ehdr, e_machine) == 18, "Unexpected offset");
> +		if (dso__needs_swap(dso) == DSO_SWAP__UNSET) {
> +			unsigned char eidata;
> +
> +			if (pread(fd, &eidata, sizeof(eidata), EI_DATA) == sizeof(eidata))
> +				dso__swap_init(dso, eidata);
> +		}
> +		if (dso__needs_swap(dso) != DSO_SWAP__UNSET &&
> +		    pread(fd, &e_machine, sizeof(e_machine), 18) == sizeof(e_machine))
> +			e_machine = DSO__SWAP(dso, uint16_t, e_machine);
> +	}
> +	pthread_mutex_unlock(&dso__data_open_lock);
> +	return e_machine;
> +}
> +
>  /**
>   * dso__data_read_addr - Read data from dso address
>   * @dso: dso object
> @@ -1525,6 +1586,33 @@ void dso__put(struct dso *dso)
>  		RC_CHK_PUT(dso);
>  }
>  
> +int dso__swap_init(struct dso *dso, unsigned char eidata)
> +{
> +	static unsigned int const endian = 1;
> +
> +	dso__set_needs_swap(dso, DSO_SWAP__NO);
> +
> +	switch (eidata) {
> +	case ELFDATA2LSB:
> +		/* We are big endian, DSO is little endian. */
> +		if (*(unsigned char const *)&endian != 1)
> +			dso__set_needs_swap(dso, DSO_SWAP__YES);
> +		break;
> +
> +	case ELFDATA2MSB:
> +		/* We are little endian, DSO is big endian. */
> +		if (*(unsigned char const *)&endian != 0)
> +			dso__set_needs_swap(dso, DSO_SWAP__YES);
> +		break;
> +
> +	default:
> +		pr_err("unrecognized DSO data encoding %d\n", eidata);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  void dso__set_build_id(struct dso *dso, struct build_id *bid)
>  {
>  	RC_CHK_ACCESS(dso)->bid = *bid;
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 4aa8c3d36566..38d9e3eac501 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -730,6 +730,8 @@ bool dso__sorted_by_name(const struct dso *dso);
>  void dso__set_sorted_by_name(struct dso *dso);
>  void dso__sort_by_name(struct dso *dso);
>  
> +int dso__swap_init(struct dso *dso, unsigned char eidata);
> +
>  void dso__set_build_id(struct dso *dso, struct build_id *bid);
>  bool dso__build_id_equal(const struct dso *dso, struct build_id *bid);
>  void dso__read_running_kernel_build_id(struct dso *dso,
> @@ -818,6 +820,7 @@ int dso__data_file_size(struct dso *dso, struct machine *machine);
>  off_t dso__data_size(struct dso *dso, struct machine *machine);
>  ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine,
>  			      u64 offset, u8 *data, ssize_t size);
> +uint16_t dso__e_machine(struct dso *dso, struct machine *machine);
>  ssize_t dso__data_read_addr(struct dso *dso, struct map *map,
>  			    struct machine *machine, u64 addr,
>  			    u8 *data, ssize_t size);
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 66fd1249660a..71df13a5722a 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1173,33 +1173,6 @@ int filename__read_debuglink(const char *filename, char *debuglink,
>  
>  #endif
>  
> -static int dso__swap_init(struct dso *dso, unsigned char eidata)
> -{
> -	static unsigned int const endian = 1;
> -
> -	dso__set_needs_swap(dso, DSO_SWAP__NO);
> -
> -	switch (eidata) {
> -	case ELFDATA2LSB:
> -		/* We are big endian, DSO is little endian. */
> -		if (*(unsigned char const *)&endian != 1)
> -			dso__set_needs_swap(dso, DSO_SWAP__YES);
> -		break;
> -
> -	case ELFDATA2MSB:
> -		/* We are little endian, DSO is big endian. */
> -		if (*(unsigned char const *)&endian != 0)
> -			dso__set_needs_swap(dso, DSO_SWAP__YES);
> -		break;
> -
> -	default:
> -		pr_err("unrecognized DSO data encoding %d\n", eidata);
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
>  bool symsrc__possibly_runtime(struct symsrc *ss)
>  {
>  	return ss->dynsym || ss->opdsec;
> -- 
> 2.49.0.rc0.332.g42c0ae87b1-goog
> 
