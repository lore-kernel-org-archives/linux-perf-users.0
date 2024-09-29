Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC04182D2;
	Sun, 29 Sep 2024 02:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727575356; cv=none; b=VjYHZghEe//F8yPjCbNFgnpdqtC7xDUP3PHvrPNKsAeSikyV2knR24gAPf4ceFRLWLBW8DYMH3foF+xYL6VwxYTQuR/vFd9KwBOwLXQXc8ZrZN5WmngvrcaSL9vlAP/1ED8GS2CnmP+3q9jvDUTShGB/nfXMreD96EEBj28A4kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727575356; c=relaxed/simple;
	bh=ZUv2SoJuX9FN1RybOJ6eFMF0hi1RFZfrLok268zRdhs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=D84Y7+p+IZKx0TQXtGC/URThfjHd+hMJwDegG+FQxzF5qcu4bJBff8k9ERpg61P3knWcdSc+r3GDSeL4+gmKHebS/33mFmSixtrd6zKe33582s4+0O9xSW+QoLNhpphK1TM3ZplbOyknEXo0lZpV/G9QlEBUFPYjokpp/Ofv71k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9sdZRNG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9sdZRNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B53C4CEC3;
	Sun, 29 Sep 2024 02:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727575355;
	bh=ZUv2SoJuX9FN1RybOJ6eFMF0hi1RFZfrLok268zRdhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q9sdZRNGl30Z33clufljhJglJot9mDOCnmELgTUBAcqgPGnNjk+wDdkgfNDZ1SJTH
	 IhWPKkDH9zlEs5At1m0IEFe5vL8qUg7Du1O2+8RQ+IsQZ8dkuF3aSdhvSQ+TZ5qLz9
	 15fMYIBereFs6Q5DIo4vr4yumg2ERDeXAqQnTJzyJ7NtUfD3KfJ9jK1qTbjproDiDo
	 pxwjvDlsFWVJ2EnULqzxERL8S2XT/y43LL0YlN9buT4zujwJ1WY+3qcrO8gsEHB4O7
	 utC9hVYn0mld2awJRX0H1T5FuwanVpdJqyaYFrrcMkuFnCrNSYi0J2OJiI1tSEst12
	 eS8QCPh98yBBg==
Date: Sun, 29 Sep 2024 11:02:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang
 <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, Will
 Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, Mike Leach
 <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren
 <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Nick
 Terrell <terrelln@fb.com>, Guilherme Amadio <amadio@gentoo.org>, Changbin
 Du <changbin.du@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>,
 Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev
 <atrajeev@linux.vnet.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, Kajol
 Jain <kjain@linux.ibm.com>, Anup Patel <anup@brainfault.org>, Shenlin Liang
 <liangshenlin@eswincomputing.com>, Atish Patra <atishp@rivosinc.com>,
 Oliver Upton <oliver.upton@linux.dev>, Chen Pei <cp0613@linux.alibaba.com>,
 Dima Kogan <dima@secretsauce.net>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Yang Jihong
 <yangjihong@bytedance.com>
Subject: Re: [PATCH v1 02/11] perf build: Remove defined but never used
 variable
Message-Id: <20240929110225.70061347465502e318c5567b@kernel.org>
In-Reply-To: <20240924160418.1391100-3-irogers@google.com>
References: <20240924160418.1391100-1-irogers@google.com>
	<20240924160418.1391100-3-irogers@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Sep 2024 09:04:09 -0700
Ian Rogers <irogers@google.com> wrote:

> Previously NO_DWARF_UNWIND was part of conditional compilation but it
> is now unused so remove.
> 

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.config | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 55a39211496d..182e14e39cd5 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -753,8 +753,6 @@ endif
>  ifeq ($(dwarf-post-unwind),1)
>    CFLAGS += -DHAVE_DWARF_UNWIND_SUPPORT
>    $(call detected,CONFIG_DWARF_UNWIND)
> -else
> -  NO_DWARF_UNWIND := 1
>  endif
>  
>  ifndef NO_LOCAL_LIBUNWIND
> -- 
> 2.46.0.792.g87dc391469-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
