Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E14C26F465;
	Fri, 11 Apr 2025 00:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744332834; cv=none; b=IMsApGOYlNt5K0WD+R+NOh692i+6JMUodzWTgTnb3OY29UXYC4Wi0niISex+iRjs9DVYX4Nf/Fj9TlPl/z4ddMouOTFXCR9gHaJYX+fpvqg/v2viTEJZfOE+nAXaaOAlFx2bqg23aYfrhkYPXWfVDOWk8umm3RSZdG7ezI+C9vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744332834; c=relaxed/simple;
	bh=ohHhBlLmK53yYy+NEi9vJNeM2BRaT/ofomSIVkO2Q2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhI8M49LIL/MmWoAMS19EcoJZ2cPfmI8G3XxmCA97wNKTU3sw3Z0d4VfhagLfFf1xa1pg9jCrlVnKEaNCi5u3Xwz+qD2ZNWmBmmz1T5yyxBdRfN0q8724V+DxiJoBYl7nH9g8S2Kpm+NUYGhL6ifbbKfQwJ8j5iXNNcn/fEi1Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeCz7UVL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeCz7UVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E2DC4CEDD;
	Fri, 11 Apr 2025 00:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744332833;
	bh=ohHhBlLmK53yYy+NEi9vJNeM2BRaT/ofomSIVkO2Q2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AeCz7UVLSJznuAvAEcPJTNJ68f2jtaYwcpI5JoTkxv3uZW70TNCRQQrZoxZEJMp1x
	 4rJPiU0j3LePmjZb3oGB1LeLzBZXTxJhYkcQkyce+D/HasrYsn6nf3wwJIF2kGaZAB
	 11aqnxU6LIlYZFyXs/Z9CJ1Drtl1Q3lv8BnaQGwydd9Mihom7t2b8rbO8hd5YAKSPh
	 BkU2+8av0gCM/7cHF8qnZBuuTAoks46Ru/lxuQ6HFPvbrwgLzncm7Q64wwlXz1OKrU
	 Vd4akma9pUWj3hytPvIzPQ83dATKNx/fB91qAC7iBauonDN82qPQk+j6b7p7siR2JM
	 Z3G62zyIPGgpQ==
Date: Thu, 10 Apr 2025 17:53:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: xiaobo55x@gmail.com, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] perf symbols: Ignore mapping symbols on riscv
Message-ID: <Z_hoH0fu_NnEUUfe@google.com>
References: <20250409025202.201046-1-haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250409025202.201046-1-haibo1.xu@intel.com>

Hello,

On Wed, Apr 09, 2025 at 10:51:56AM +0800, Haibo Xu wrote:
> RISCV ELF use mapping symbols with special names $x, $d to
> identify regions of RISCV code or code with different ISAs[1].
> These symbols don't identify functions, so will confuse the
> perf output.
> 
> The patch filters out these symbols at load time, similar to
> "4886f2ca perf symbols: Ignore mapping symbols on aarch64".
> 
> [1] https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/
>     master/riscv-elf.adoc#mapping-symbol
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/symbol-elf.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index fbf6d0f73af9..55b1409b0593 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1733,6 +1733,12 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  				continue;
>  		}
>  
> +		/* Reject RISCV ELF "mapping symbols" */
> +		if (ehdr.e_machine == EM_RISCV) {
> +			if (elf_name[0] == '$' && strchr("dx", elf_name[1]))
> +				continue;
> +		}
> +
>  		if (runtime_ss->opdsec && sym.st_shndx == runtime_ss->opdidx) {
>  			u32 offset = sym.st_value - syms_ss->opdshdr.sh_addr;
>  			u64 *opd = opddata->d_buf + offset;
> -- 
> 2.43.0
> 
