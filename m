Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40F320FA9C;
	Fri,  3 Oct 2025 05:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759469794; cv=none; b=MZ4g8d+esqxMzsOs9YtsrLj2q/4hE2bc+8zSZIOucizdhG2Z5gnB0Vg6ym7zsn/pt3Ycnl29PDPS6uu1dk1kNnBNi3LExk3Xn3fYLO/jLK3FnBgrm8nsSTvvN+poJPeFfBPbP6Wal/ki//PhrCoG37jhe+h4jmOf1/94aIl+0r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759469794; c=relaxed/simple;
	bh=EyZ5vXjvmRKU+2UuZvMYYm9KC9IQFeACmA9qFW+Oo10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBh/aYj9Fj9QbCm7C1sS3XwhUAZbXy+8RrQkEzke+3EJoYS/PnoR21/hjKafc+yp9m+F0J72Hn2o3G94gJFUfLPRGieTXY6Idih66LFNMUgqfwBUEFatuilrkbm6wRpR5/s7a2i/yxL8jc2kDl/BIbXJOidbMrvZzQ3IxQvB/n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJnIkWLU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJnIkWLU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A22C4CEF7;
	Fri,  3 Oct 2025 05:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759469793;
	bh=EyZ5vXjvmRKU+2UuZvMYYm9KC9IQFeACmA9qFW+Oo10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oJnIkWLUnzg8lcp2XhswaOdVtuhAwRuV1CCPSUIa5GaLlw1ahTkWcIB8oNCNGS4NO
	 PCE0zFsDb2Oz1FmY+B9GFumuWU9xhxywhUsMAwrS2jSXyO8dDQ/m93ml11OBnrrGxo
	 y/zGb/RgQeug2+yQd4SxeJD93zXZqJLbknWLMV2TU8OUisqvjerWOgkcQOIKEfNr22
	 15mdmE4jMmMfRue0JmkXYaogQ+RXBCUYAf9moYndEEUCPife5L/U0iGrGWy7vQa7Gp
	 QnZQBc4vg43LLYZCGSgbVScsuJcPGBrzOgZ93b0riW/tYbB4bz2MXCSydSlj8VMoZ+
	 En1OvSmj2Qqnw==
Date: Fri, 3 Oct 2025 14:36:25 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] perf annotate: Skip annotating data types to
 lea instructions
Message-ID: <aN9g2YfwZzBjyiOr@google.com>
References: <20250917195808.2514277-1-zecheng@google.com>
 <20250917195808.2514277-2-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917195808.2514277-2-zecheng@google.com>

Hello,

On Wed, Sep 17, 2025 at 07:57:59PM +0000, Zecheng Li wrote:
> Introduce a helper function is_address_gen_insn() to check
> arch-dependent address generation instructions like lea in x86. Remove
> type annotation on these instructions since they are not accessing
> memory. It should be counted as `no_mem_ops`.
> 
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  tools/perf/util/annotate.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index c9b220d9f924..e2370b7fd599 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2699,6 +2699,19 @@ static bool is_stack_canary(struct arch *arch, struct annotated_op_loc *loc)
>  	return false;
>  }
>  
> +/**
> + * Returns true if the instruction has a memory operand without
> + * performing a load/store
> + */
> +static bool is_address_gen_insn(struct arch *arch, struct disasm_line *dl)
> +{
> +	if (arch__is(arch, "x86"))

Please put parentheses if the inner statement is placed on multiple
lines even if it's a single statement.

Otherwise, looks good to me.

Thanks,
Namhyung


> +		if (!strncmp(dl->ins.name, "lea", 3))
> +			return true;
> +
> +	return false;
> +}
> +
>  static struct disasm_line *
>  annotation__prev_asm_line(struct annotation *notes, struct disasm_line *curr)
>  {
> @@ -2807,6 +2820,12 @@ __hist_entry__get_data_type(struct hist_entry *he, struct arch *arch,
>  		return &stackop_type;
>  	}
>  
> +	if (is_address_gen_insn(arch, dl)) {
> +		istat->bad++;
> +		ann_data_stat.no_mem_ops++;
> +		return NO_TYPE;
> +	}
> +
>  	for_each_insn_op_loc(&loc, i, op_loc) {
>  		struct data_loc_info dloc = {
>  			.arch = arch,
> -- 
> 2.51.0.384.g4c02a37b29-goog
> 
