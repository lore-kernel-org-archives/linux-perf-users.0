Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EFB2505A7;
	Wed,  5 Mar 2025 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197179; cv=none; b=hn13MaTxbNcuzBWtc8bB4Fk50gNBDKl921/YeQgxJFefhPWEVlnrobpnKMEqkjU54Qs+Mk6+6dtuyl+YbEZDOUblX1DOJct8KSluLg7nsfOLj1uJhbFhaJDo/t5oqkg0eR9+XJIDrAYe4GjnKopVeRstYDQK4QutDXT2CNNQ3HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197179; c=relaxed/simple;
	bh=hE0MFGTk7bcOjMBBN//SQY7SQOQlJ98ye1JVJhEBqyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkeSXsEqbWTSapINhtHAGJH1cT2WfsxyR6MOfGIM9QVcnyAPL1V7KJyUq85uu3csGoyLmbiWiklC/rkenzUUtJQIVTOsiw6iUfj2wpnrGpKVLNMXGq+eUUQpweCubMvyeen0WD6MuokEQ0L2EQncBxvPFAow9TgZbKN8yO7rvOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgLq2Qph; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgLq2Qph"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F10DC4CEE2;
	Wed,  5 Mar 2025 17:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741197179;
	bh=hE0MFGTk7bcOjMBBN//SQY7SQOQlJ98ye1JVJhEBqyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YgLq2Qph/XKnO0vPpE1w+YDPzp+TATFzB/KsCjnTv8bJ7JXTedWgOJQm8tzJLxZgZ
	 RzNeV1nI8Xc2+E/Er4K/hySns3z7+C89eKgfHDUr6QtPU0P5y01Ba1RBAst0pm+6qU
	 mFLXKWzxQEy+Po+4p5IUUfdcPnLlJzrVxqdys88Y/3XRAXIVMDX1fqHm7z0wq3oLAc
	 ji7wVU7OS1ax1G4HnyeM+cI3XG7HBzv9GYCm3VeVF9Nm+ebYUvekUKf7JnvtVEU2qa
	 DZIqOuEuwea+hBvlg7PkrLq3C9fyIilBiwD1tjINhk+UTQelj1WFnTKgjWxTm/3790
	 lFk35gC77gIuA==
Date: Wed, 5 Mar 2025 14:52:56 -0300
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
Subject: Re: [PATCH v4 01/11] perf dso: Move libunwind dso_data variables
 into ifdef
Message-ID: <Z8iPeEbldTUqotsQ@x1>
References: <20250304050305.901167-1-irogers@google.com>
 <20250304050305.901167-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304050305.901167-2-irogers@google.com>

On Mon, Mar 03, 2025 at 09:02:55PM -0800, Ian Rogers wrote:
> The variables elf_base_addr, debug_frame_offset, eh_frame_hdr_addr and
> eh_frame_hdr_offset are only accessed in unwind-libunwind-local.c
> which is conditionally built on having libunwind support. Make the
> variables conditional on libunwind support too.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/dso.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index bb8e8f444054..dfd763a0bd9d 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -154,10 +154,12 @@ struct dso_data {
>  	int		 status;
>  	u32		 status_seen;
>  	u64		 file_size;
> +#ifdef HAVE_LIBUNWIND_SUPPORT
>  	u64		 elf_base_addr;
>  	u64		 debug_frame_offset;
>  	u64		 eh_frame_hdr_addr;
>  	u64		 eh_frame_hdr_offset;
> +#endif
>  };
>  
>  struct dso_bpf_prog {
> -- 
> 2.48.1.711.g2feabab25a-goog
