Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD172192EA;
	Wed, 28 May 2025 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748436523; cv=none; b=tPJl4zlFr3r52BZ1zx/Xvix5bcoKaZYP47qYlQZZosL4lo01mczlTJDnrdenODNjrK9KD+inrno7NQv2TwcX9ZfdNbl5YKQbL5yNPdd0neYwBA/LUuiwSaLBBQc3A1IC3jC2RzsRl1248sppYWiL+Hj+JZswn5buzikzyqgXYUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748436523; c=relaxed/simple;
	bh=Ug8/vudQFIbaLAckMyOPR6Hl0BP4LHF3OKGs6fH3eek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/04Q2WmWtSgj+UMJXUgUCkVz+jUHK91N3LGq4n5nugIUHLiB1o85UTptftrf9X6zJeJq9aOAd5mSbzdpmhRl7uzXdY8fwSwp01VrPqcIMwF4fwODiurbeit3mJiJLNl+/9jjSXnfEKnaL636W5XMWXUgS+k/5SsSA6tdRgVDb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6GljPw+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6GljPw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53553C4CEE7;
	Wed, 28 May 2025 12:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748436522;
	bh=Ug8/vudQFIbaLAckMyOPR6Hl0BP4LHF3OKGs6fH3eek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a6GljPw+XJSS9WFNCvIH9kT3JiTTMaOxXtpF2Hqw2Gy89QBK8A3MPzzeie2ZiiK1t
	 Jqx2L0pjrrV+CZ4wIaLJHx1TLnAr8tdykz6lZAeH3ZE/zVNALh06cYqY7BMvOcr2lS
	 xjumZzwavAo1I7n/+LK4lJDdDoFe/Crno46Od3N0UHkz3hYjNETKrej+FZVh7DiSoI
	 /0nkDpUyHhB3SzevdsFmquQKUO6MU9RxC7VY29Ojc79pYG9N+OkniO2MtHit0FLtdj
	 nWyDG1iw5jBr4QvAExgFfyP/fBXO8ILg22hz7FKBLvkQKPyPuNm/5juYuNrAKquRyw
	 M5PBwQ0yZD2yQ==
Date: Wed, 28 May 2025 09:48:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/6] perf symbol: Fix use-after-free in
 filename__read_build_id
Message-ID: <aDcGKINHFEEacu3x@x1>
References: <20250527180703.129336-1-irogers@google.com>
 <20250527180703.129336-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527180703.129336-2-irogers@google.com>

On Tue, May 27, 2025 at 11:06:58AM -0700, Ian Rogers wrote:
> The same buf is used for the program headers and reading notes. As the
> notes memory may be reallocated then this corrupts the memory pointed
> to by the phdr. Using the same buffer is in any case a logic
> error. Rather than deal with the duplicated code, introduce an elf32
> boolean and a union for either the elf32 or elf64 headers that are in
> use. Let the program headers have their own memory and grow the buffer
> for notes as necessary.

Applied.

- Arnaldo
 
> Before `perf list -j` compiled with asan would crash with:
> ```
> ==4176189==ERROR: AddressSanitizer: heap-use-after-free on address 0x5160000070b8 at pc 0x555d3b15075b bp 0x7ffebb5a8090 sp 0x7ffebb5a8088
> READ of size 8 at 0x5160000070b8 thread T0
>     #0 0x555d3b15075a in filename__read_build_id tools/perf/util/symbol-minimal.c:212:25
>     #1 0x555d3ae43aff in filename__sprintf_build_id tools/perf/util/build-id.c:110:8
> ...
> 
> 0x5160000070b8 is located 312 bytes inside of 560-byte region [0x516000006f80,0x5160000071b0)
> freed by thread T0 here:
>     #0 0x555d3ab21840 in realloc (perf+0x264840) (BuildId: 12dff2f6629f738e5012abdf0e90055518e70b5e)
>     #1 0x555d3b1506e7 in filename__read_build_id tools/perf/util/symbol-minimal.c:206:11
> ...
> 
> previously allocated by thread T0 here:
>     #0 0x555d3ab21423 in malloc (perf+0x264423) (BuildId: 12dff2f6629f738e5012abdf0e90055518e70b5e)
>     #1 0x555d3b1503a2 in filename__read_build_id tools/perf/util/symbol-minimal.c:182:9
> ...
> ```
> 
> Note: this bug is long standing and not introduced by the other asan
> fix in commit fa9c4977fbfb ("perf symbol-minimal: Fix double free in
> filename__read_build_id").
> 
> Fixes: b691f64360ecec49 ("perf symbols: Implement poor man's ELF parser")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/symbol-minimal.c | 168 +++++++++++++------------------
>  1 file changed, 70 insertions(+), 98 deletions(-)
> 
> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
> index d8da3da01fe6..c9b7a1ca5e52 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c
> @@ -90,11 +90,23 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
>  {
>  	FILE *fp;
>  	int ret = -1;
> -	bool need_swap = false;
> +	bool need_swap = false, elf32;
>  	u8 e_ident[EI_NIDENT];
> -	size_t buf_size;
> -	void *buf;
>  	int i;
> +	union {
> +		struct {
> +			Elf32_Ehdr ehdr32;
> +			Elf32_Phdr *phdr32;
> +		};
> +		struct {
> +			Elf64_Ehdr ehdr64;
> +			Elf64_Phdr *phdr64;
> +		};
> +	} hdrs;
> +	void *phdr;
> +	size_t phdr_size;
> +	void *buf = NULL;
> +	size_t buf_size = 0;
>  
>  	fp = fopen(filename, "r");
>  	if (fp == NULL)
> @@ -108,119 +120,79 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
>  		goto out;
>  
>  	need_swap = check_need_swap(e_ident[EI_DATA]);
> +	elf32 = e_ident[EI_CLASS] == ELFCLASS32;
>  
> -	/* for simplicity */
> -	fseek(fp, 0, SEEK_SET);
> -
> -	if (e_ident[EI_CLASS] == ELFCLASS32) {
> -		Elf32_Ehdr ehdr;
> -		Elf32_Phdr *phdr;
> -
> -		if (fread(&ehdr, sizeof(ehdr), 1, fp) != 1)
> -			goto out;
> +	if (fread(elf32 ? (void *)&hdrs.ehdr32 : (void *)&hdrs.ehdr64,
> +		  elf32 ? sizeof(hdrs.ehdr32) : sizeof(hdrs.ehdr32),
> +		  1, fp) != 1)
> +		goto out;
>  
> -		if (need_swap) {
> -			ehdr.e_phoff = bswap_32(ehdr.e_phoff);
> -			ehdr.e_phentsize = bswap_16(ehdr.e_phentsize);
> -			ehdr.e_phnum = bswap_16(ehdr.e_phnum);
> +	if (need_swap) {
> +		if (elf32) {
> +			hdrs.ehdr32.e_phoff = bswap_32(hdrs.ehdr32.e_phoff);
> +			hdrs.ehdr32.e_phentsize = bswap_16(hdrs.ehdr32.e_phentsize);
> +			hdrs.ehdr32.e_phnum = bswap_16(hdrs.ehdr32.e_phnum);
> +		} else {
> +			hdrs.ehdr64.e_phoff = bswap_64(hdrs.ehdr64.e_phoff);
> +			hdrs.ehdr64.e_phentsize = bswap_16(hdrs.ehdr64.e_phentsize);
> +			hdrs.ehdr64.e_phnum = bswap_16(hdrs.ehdr64.e_phnum);
>  		}
> +	}
> +	phdr_size = elf32 ? hdrs.ehdr32.e_phentsize * hdrs.ehdr32.e_phnum
> +			  : hdrs.ehdr64.e_phentsize * hdrs.ehdr64.e_phnum;
> +	phdr = malloc(phdr_size);
> +	if (phdr == NULL)
> +		goto out;
>  
> -		buf_size = ehdr.e_phentsize * ehdr.e_phnum;
> -		buf = malloc(buf_size);
> -		if (buf == NULL)
> -			goto out;
> -
> -		fseek(fp, ehdr.e_phoff, SEEK_SET);
> -		if (fread(buf, buf_size, 1, fp) != 1)
> -			goto out_free;
> -
> -		for (i = 0, phdr = buf; i < ehdr.e_phnum; i++, phdr++) {
> -			void *tmp;
> -			long offset;
> -
> -			if (need_swap) {
> -				phdr->p_type = bswap_32(phdr->p_type);
> -				phdr->p_offset = bswap_32(phdr->p_offset);
> -				phdr->p_filesz = bswap_32(phdr->p_filesz);
> -			}
> -
> -			if (phdr->p_type != PT_NOTE)
> -				continue;
> -
> -			offset = phdr->p_offset;
> -			if (phdr->p_filesz > buf_size) {
> -				buf_size = phdr->p_filesz;
> -				tmp = realloc(buf, buf_size);
> -				if (tmp == NULL)
> -					goto out_free;
> -				buf = tmp;
> -			}
> -			fseek(fp, offset, SEEK_SET);
> -			if (fread(buf, phdr->p_filesz, 1, fp) != 1)
> -				goto out_free;
> +	fseek(fp, elf32 ? hdrs.ehdr32.e_phoff : hdrs.ehdr64.e_phoff, SEEK_SET);
> +	if (fread(phdr, phdr_size, 1, fp) != 1)
> +		goto out_free;
>  
> -			ret = read_build_id(buf, phdr->p_filesz, bid, need_swap);
> -			if (ret == 0) {
> -				ret = bid->size;
> -				break;
> -			}
> -		}
> -	} else {
> -		Elf64_Ehdr ehdr;
> -		Elf64_Phdr *phdr;
> +	if (elf32)
> +		hdrs.phdr32 = phdr;
> +	else
> +		hdrs.phdr64 = phdr;
>  
> -		if (fread(&ehdr, sizeof(ehdr), 1, fp) != 1)
> -			goto out;
> +	for (i = 0; i < elf32 ? hdrs.ehdr32.e_phnum : hdrs.ehdr64.e_phnum; i++) {
> +		size_t p_filesz;
>  
>  		if (need_swap) {
> -			ehdr.e_phoff = bswap_64(ehdr.e_phoff);
> -			ehdr.e_phentsize = bswap_16(ehdr.e_phentsize);
> -			ehdr.e_phnum = bswap_16(ehdr.e_phnum);
> +			if (elf32) {
> +				hdrs.phdr32[i].p_type = bswap_32(hdrs.phdr32[i].p_type);
> +				hdrs.phdr32[i].p_offset = bswap_32(hdrs.phdr32[i].p_offset);
> +				hdrs.phdr32[i].p_filesz = bswap_32(hdrs.phdr32[i].p_offset);
> +			} else {
> +				hdrs.phdr64[i].p_type = bswap_32(hdrs.phdr64[i].p_type);
> +				hdrs.phdr64[i].p_offset = bswap_64(hdrs.phdr64[i].p_offset);
> +				hdrs.phdr64[i].p_filesz = bswap_64(hdrs.phdr64[i].p_filesz);
> +			}
>  		}
> +		if ((elf32 ? hdrs.phdr32[i].p_type : hdrs.phdr64[i].p_type) != PT_NOTE)
> +			continue;
>  
> -		buf_size = ehdr.e_phentsize * ehdr.e_phnum;
> -		buf = malloc(buf_size);
> -		if (buf == NULL)
> -			goto out;
> -
> -		fseek(fp, ehdr.e_phoff, SEEK_SET);
> -		if (fread(buf, buf_size, 1, fp) != 1)
> -			goto out_free;
> -
> -		for (i = 0, phdr = buf; i < ehdr.e_phnum; i++, phdr++) {
> +		p_filesz = elf32 ? hdrs.phdr32[i].p_filesz : hdrs.phdr64[i].p_filesz;
> +		if (p_filesz > buf_size) {
>  			void *tmp;
> -			long offset;
> -
> -			if (need_swap) {
> -				phdr->p_type = bswap_32(phdr->p_type);
> -				phdr->p_offset = bswap_64(phdr->p_offset);
> -				phdr->p_filesz = bswap_64(phdr->p_filesz);
> -			}
> -
> -			if (phdr->p_type != PT_NOTE)
> -				continue;
>  
> -			offset = phdr->p_offset;
> -			if (phdr->p_filesz > buf_size) {
> -				buf_size = phdr->p_filesz;
> -				tmp = realloc(buf, buf_size);
> -				if (tmp == NULL)
> -					goto out_free;
> -				buf = tmp;
> -			}
> -			fseek(fp, offset, SEEK_SET);
> -			if (fread(buf, phdr->p_filesz, 1, fp) != 1)
> +			buf_size = p_filesz;
> +			tmp = realloc(buf, buf_size);
> +			if (tmp == NULL)
>  				goto out_free;
> +			buf = tmp;
> +		}
> +		fseek(fp, elf32 ? hdrs.phdr32[i].p_offset : hdrs.phdr64[i].p_offset, SEEK_SET);
> +		if (fread(buf, p_filesz, 1, fp) != 1)
> +			goto out_free;
>  
> -			ret = read_build_id(buf, phdr->p_filesz, bid, need_swap);
> -			if (ret == 0) {
> -				ret = bid->size;
> -				break;
> -			}
> +		ret = read_build_id(buf, p_filesz, bid, need_swap);
> +		if (ret == 0) {
> +			ret = bid->size;
> +			break;
>  		}
>  	}
>  out_free:
>  	free(buf);
> +	free(phdr);
>  out:
>  	fclose(fp);
>  	return ret;
> -- 
> 2.49.0.1204.g71687c7c1d-goog
> 
