Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85FF2E419;
	Tue, 24 Sep 2024 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203102; cv=none; b=EZrzu7r0z056XnGO/YXGExF7GgGNK0RUYbh5Vq31jr3mMZFwLnV9ydhd27eYmu3CG5bN9I4NF5B3jQ/nrzt0rXGNdsYoAIWnHwgGsm12YbzB2cJeBdb+Am0GJMIHWd/SnVWdfWZAE8iThmeIod3Z35UWK5YPhaxc9fbs+WvNbek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203102; c=relaxed/simple;
	bh=pOHALC1Fv7PRsfVelWfhPDd6u4Uu2yJ1MWdqaReyBBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pwz/HyH37lP8oEkhePRjn0AkBqd+6gELsQzbx4KF8P9Povzk9Y6lNwOGp54r1vG3FQZRKHyS5JaNYBPkpLnKLOQXwO3W8wKx4XcEWI1sy/g+E90dxDAzXmHpLFZQFFo8f6BuHRW0xpj64dJXKnh3owfBDrZgk7izwDvTVZHt+jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRs35OhQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRs35OhQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1072C4CEC4;
	Tue, 24 Sep 2024 18:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727203102;
	bh=pOHALC1Fv7PRsfVelWfhPDd6u4Uu2yJ1MWdqaReyBBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MRs35OhQ5vNPgPkQTkBfrC8KWWtdIhVaH3PEL91bUNZgep/hSWxxKgHqx8oO4FP7V
	 bJDLpILqK0cHcLTqytl+751RIEWryIoF3DoEAdQ/4Et4j4Afr70r/PXLfJJDafC1Ol
	 fB7JLsNvEurJCU2154CyYNeVWmuUeDnjpcvRcBEFTZIPOKe0wgIY7AmoQnEetW55Rm
	 lpSwMHA1+NGNQ1V1jjit9EB/bjFIIwcwbO7Lu2KPWIHXgU0nESOIbwLDPgv57eVPEL
	 jgoyFaUpNlfP+lDGhK79bn9GVlAVg7PuPGm5H9AF3kzigSihLjVf9TafHm8ktbfbLN
	 XLDlHuIhS9wpQ==
Date: Tue, 24 Sep 2024 11:38:20 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Hemant Kumar <hemant@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yang Jihong <yangjihong@bytedance.com>, leo.yan@arm.com
Subject: Re: [PATCH v1 1/3] perf disasm: Fix capstone memory leak
Message-ID: <ZvMHHKKZwab2IhlL@google.com>
References: <20240924003720.617258-1-irogers@google.com>
 <20240924003720.617258-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924003720.617258-2-irogers@google.com>

On Mon, Sep 23, 2024 at 05:37:18PM -0700, Ian Rogers wrote:
> The insn argument passed to cs_disasm needs freeing. To support
> accurately having count, add an additional free_count variable.
> 
> Fixes: c5d60de1813a ("perf annotate: Add support to use libcapstone in powerpc")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/disasm.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index f05ba7739c1e..2c8063660f2e 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -1627,12 +1627,12 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
>  	u64 start = map__rip_2objdump(map, sym->start);
>  	u64 len;
>  	u64 offset;
> -	int i, count;
> +	int i, count, free_count;
>  	bool is_64bit = false;
>  	bool needs_cs_close = false;
>  	u8 *buf = NULL;
>  	csh handle;
> -	cs_insn *insn;
> +	cs_insn *insn = NULL;
>  	char disasm_buf[512];
>  	struct disasm_line *dl;
>  
> @@ -1664,7 +1664,7 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
>  
>  	needs_cs_close = true;
>  
> -	count = cs_disasm(handle, buf, len, start, len, &insn);
> +	free_count = count = cs_disasm(handle, buf, len, start, len, &insn);
>  	for (i = 0, offset = 0; i < count; i++) {
>  		int printed;
>  
> @@ -1702,8 +1702,11 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
>  	}
>  
>  out:
> -	if (needs_cs_close)
> +	if (needs_cs_close) {
>  		cs_close(&handle);
> +		if (free_count > 0)
> +			cs_free(insn, free_count);

It seems cs_free() can handle NULL insn and 0 free_count (like regular free)
so we can call it unconditionally.

Thanks,
Namhyung


> +	}
>  	free(buf);
>  	return count < 0 ? count : 0;
>  
> -- 
> 2.46.0.792.g87dc391469-goog
> 
