Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF5377010;
	Sun, 20 Sep 2026 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789948371; cv=none; b=H61vkAiiweNQTaOkQEuoUVSHz6XDhuOSZhGkZfjz5i10M24Dg881b4vL+YMSh/UH3RpcUjFXhCQtmmAffq8MB6ix1JPFxn9bdXWQDaJuyQPsaDHFJIzg0pY+mzknmy9iJNGvluIJYoWQRVx7xUU/E9jkbmWdP+T+IFWTPPXp4/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789948371; c=relaxed/simple;
	bh=WoELFWbmfJUwcizwCs5lT4qlc2trHAOkfxIRSEl8vCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EilZhXgaTbu/p/TEplPMQ+cLlOAFwa8XmJ+XFT3PBVaKnajbPoH0N4eDbP7w8bDoIbSgw9y3TSerOO9jM3OjtyCIohaseY/Lec6cT2ubgb0dXmVHtPuK0ZsZEch7E6rE+JBtFNd4lUFMgIhMneTbsROwmCQASxkpX14nMcd4pcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaYIa/2h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaYIa/2h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F18D1F000FF;
	Sun, 20 Sep 2026 23:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789948369;
	bh=+JUGD4V8FAmmGaW8GSd69N98p0iPercbYRv5f0k7oOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IaYIa/2h29sPo8eVeTh74rBaa1AxhgR3RB6KPAEtmphiLkskr5xhO0HSnwvyhYXQO
	 B5tI5sKlU0pPn/vu9i6Lm71gio+IRbQWsJLBeJQg9L87XfzcFZYrnLktFA2kiRZ5VX
	 jxfPB9RHxk7ZhA+6+X+PNdcWVXOFEp20PDwhjRnsqapENj/PxXrL+9vFVcmgU0Cj49
	 8xIfPPAGoiA+W3UbExvxNErNhUbn3wLbpcOUDNw6P6QArLxGnO6j7Qk4FdfGE8PJl9
	 7X9Kdz6Kx5WQzft96gHhtPpUPDf/N32dQphhTfkBsy3S1Fkh0HWGNak0YqF+xsx2yF
	 ukox7WN+g+9NA==
Date: Sun, 20 Sep 2026 16:52:47 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: haghdoost@uber.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] perf symbols: Fix broken ELF_C_READ_MMAP fallback
 guard
Message-ID: <arBxzy1Qd-3d5gwh@z2>
References: <20260919-perf-symbol-memory-send-v2-0-495b8f00ad7c@uber.com>
 <20260919-perf-symbol-memory-send-v2-1-495b8f00ad7c@uber.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919-perf-symbol-memory-send-v2-1-495b8f00ad7c@uber.com>

Hello,

On Sat, Sep 19, 2026 at 07:33:56PM -0700, Alireza Haghdoost via B4 Relay wrote:
> From: Alireza Haghdoost <haghdoost@uber.com>
> 
> Commit 22dd1ac91a77 ("tools: Remove feature-libelf-mmap feature
> detection") replaced perf's compile-time feature test with an #ifdef on
> ELF_C_READ_MMAP. ELF_C_READ_MMAP is an Elf_Cmd enumerator rather than a
> preprocessor macro, so the condition is always false and perf silently
> uses ELF_C_READ.
> 
> Perf already requires a sufficiently recent elfutils version that
> provides ELF_C_READ_MMAP. Use the enumerator directly instead of
> restoring a feature probe or retaining an unreachable fallback.
> 
> Fixes: 22dd1ac91a77 ("tools: Remove feature-libelf-mmap feature detection")
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/symbol.h | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index d0bac824c79c..46b1649c64fc 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -57,15 +57,7 @@ static inline bool is_livepatch_symbol(const char *str)
>  	return strstarts(str, KLP_SYM_PREFIX);
>  }
>  
> -/*
> - * libelf 0.8.x and earlier do not support ELF_C_READ_MMAP;
> - * for newer versions we can use mmap to reduce memory usage:
> - */
> -#ifdef ELF_C_READ_MMAP
> -# define PERF_ELF_C_READ_MMAP ELF_C_READ_MMAP
> -#else
> -# define PERF_ELF_C_READ_MMAP ELF_C_READ
> -#endif
> +#define PERF_ELF_C_READ_MMAP ELF_C_READ_MMAP
>  
>  #ifdef HAVE_LIBELF_SUPPORT
>  Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
> 
> -- 
> Git-157)
> 
> 
