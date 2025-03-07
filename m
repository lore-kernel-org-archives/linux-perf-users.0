Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B729408;
	Fri,  7 Mar 2025 01:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741310543; cv=none; b=IBBop2+Np/WmvAE45hQnAD/9P1/N3G2arjdWLqf273jsANufeV/9vr8k6odnfdLyDx12sjKvUoTDsOapfLswswM1QD4qft6PVUSo3NZYwRJYUFqA+DaC7ujSgd0pZi4HoDC5udrmM+xv+YVyxmQY72ggdkHw3dv7PQYTkBZfM6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741310543; c=relaxed/simple;
	bh=qoWrscZOahCo4c1kw/Xs9+mG1u4iBzWCpyeXDPmje18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVcmp0mYP7sAfoHGq9eX5nykEImR1Bfv+Ucrh9CHjAPvHxv4ah5RSOOEJMvj8qQH5NY+YmbI4gNwXABcoFgNf/DLNzXLyd+a5ByR/+nfZhTUCA6lBRRcGMtesNtZSOqUQe+jV/fOA1knfxvhQa3pysdBBzdFOvof9+4uPsQjYW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixMTgMBN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixMTgMBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD6CC4CEE0;
	Fri,  7 Mar 2025 01:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741310543;
	bh=qoWrscZOahCo4c1kw/Xs9+mG1u4iBzWCpyeXDPmje18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ixMTgMBN5bEz5ywSEjw16lOymw3RAJaEk2QN1yCrCQ0/VC/jp02rZwjim3bweOKU1
	 inl9oBWKtjr0LIOvJJ6bs6vrkJexp+13IoBrLc+gxuGzZXYLMjpSjHO0WKu0udD6gi
	 YOPtf2AUGSLOC2QVKO/Gx59xuWDmBDnu5kq8yeGzjOH790tpdJE7RNCk/maGNdbumO
	 uOhSjdhOaiJipTJjCHQVW5CxwryBHVpxn6hXQOLyRtM72BW6Yin+U2n2XYDey1hGok
	 GTVwxD73YcSoxwO7jfitu7qi7esTTxO+LgD8RsUgFAt3X6RldmxuxrnNqPB23LwmKf
	 fgi8nNNzcIFRw==
Date: Thu, 6 Mar 2025 17:22:20 -0800
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
Subject: Re: [PATCH v4 06/11] perf dso: Add support for reading the e_machine
 type for a dso
Message-ID: <Z8pKTE7tOqdqNUdA@google.com>
References: <20250304050305.901167-1-irogers@google.com>
 <20250304050305.901167-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304050305.901167-7-irogers@google.com>

On Mon, Mar 03, 2025 at 09:03:00PM -0800, Ian Rogers wrote:
> For ELF file dsos read the e_machine from the ELF header. For kernel
> types assume the e_machine matches the perf tool. In other cases
> return EM_NONE.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/dso.c | 54 +++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/dso.h |  1 +
>  2 files changed, 55 insertions(+)
> 
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 5c6e85fdae0d..7f2f1af4f73b 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1170,6 +1170,60 @@ ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine,
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

I think some of them can be possible in recorded data.  But let's go
simple with EM_HOST as we haven't supported cross-arch trace.


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

Hmm.. I'm afraid it'd slow down perf trace a bit more.  It sees
occasional LOST events.  But it may be ok as it's cached in thread later.


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
> +		if (pread(fd, &e_machine, sizeof(e_machine), 18) != sizeof(e_machine))

I think it needs to check the endianess and swap the data.

Thanks,
Namhyung


> +			e_machine = EM_NONE;
> +	}
> +	pthread_mutex_unlock(&dso__data_open_lock);
> +	return e_machine;
> +}
> +
>  /**
>   * dso__data_read_addr - Read data from dso address
>   * @dso: dso object
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index f3ca2a5e7670..ba9b83db061a 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -818,6 +818,7 @@ int dso__data_file_size(struct dso *dso, struct machine *machine);
>  off_t dso__data_size(struct dso *dso, struct machine *machine);
>  ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine,
>  			      u64 offset, u8 *data, ssize_t size);
> +uint16_t dso__e_machine(struct dso *dso, struct machine *machine);
>  ssize_t dso__data_read_addr(struct dso *dso, struct map *map,
>  			    struct machine *machine, u64 addr,
>  			    u8 *data, ssize_t size);
> -- 
> 2.48.1.711.g2feabab25a-goog
> 
