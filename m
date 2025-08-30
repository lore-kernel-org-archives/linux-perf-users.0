Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606D1145A05;
	Sat, 30 Aug 2025 06:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756536083; cv=none; b=WQx3fsn4ljxtrB8wt7/4V8VD8JZHyxxDeWk6iddIADxAtgPTYEYwGneO45e5JB9i8ZhybR1K1vWD/B2z3oq15CU3T68I/icJer7KMX0QZx+5mgCyZpAdQLe5yTdTDe+99K8YB8f4pBY5Kl/+okUanKUFJVsdcN48nI0ZLt3OZC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756536083; c=relaxed/simple;
	bh=Uz2BxP005RvVFijEm9a1Dl9Vli+nxv/P8NTj5XzBrwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfuxWLPK6rbTbr4HEG2Ad5lcHoxZAgpe7sD3ubljRJEKQsWIb5bR0hoqqqtOpzKiq+Wx15T/x0G6q8FYGMIYG8ADwZrx777J1fcm23cp7bgm4BaGLvK8cYPoYdrWByPUdIfTKjznyGVim9pv38Jyt2n665RlJzQEOVl2N5ZXzlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na5IgFVj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na5IgFVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F5CC4CEEB;
	Sat, 30 Aug 2025 06:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756536082;
	bh=Uz2BxP005RvVFijEm9a1Dl9Vli+nxv/P8NTj5XzBrwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=na5IgFVjHvDBupxx7f6TfqccJQMCNdSHTiTLlDuWbRKIP6YTkKqwwYJF1K3vqxboh
	 rZKBWAIGGIqBQAJKBglceAWUZrPerG2aqskwpJota2/o6bHWy3EZSVoRw188nUsQVZ
	 gk86EBCMzc5AWvR417ZJ2b5oRJsvQhkobtG/edV6986TzxSeP2WSq1uiNyMb8MJ2SZ
	 Cn5fD7TPvFX2R97+yT10jNhHtp5Z+BZKuSB3kxnM6IvybxHTwC0n6m7RWJ5boK8BjV
	 N5wfYNz/vUXJRH1XNV1mg5OtgEp0XznUGTsTCGzydOAq257KEdv49QUBZ4mqrQske5
	 M0AHB8Gwbiczw==
Date: Fri, 29 Aug 2025 23:41:20 -0700
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
Subject: Re: [PATCH v2 04/10] perf annotate: Skip annotating data types to
 lea instructions
Message-ID: <aLKdEEjFVXNq1AA1@google.com>
References: <20250825195412.223077-1-zecheng@google.com>
 <20250825195412.223077-5-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825195412.223077-5-zecheng@google.com>

On Mon, Aug 25, 2025 at 07:54:06PM +0000, Zecheng Li wrote:
> Introduce a helper function is_address_gen_insn() to check
> arch-dependent address generation instructions like lea in x86. Remove
> type annotation on these instructions since they are not accessing
> memory. It should be counted as `no_mem_ops`.
> 
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  tools/perf/util/annotate.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 0dd475a744b6..9d36709d867d 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2621,6 +2621,19 @@ static bool is_stack_canary(struct arch *arch, struct annotated_op_loc *loc)
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
> +		if (!strncmp(dl->ins.name, "lea", 3))
> +			return true;
> +
> +	return false;
> +}
> +
>  static struct disasm_line *
>  annotation__prev_asm_line(struct annotation *notes, struct disasm_line *curr)
>  {
> @@ -2729,6 +2742,11 @@ __hist_entry__get_data_type(struct hist_entry *he, struct arch *arch,
>  		return &stackop_type;
>  	}
>  
> +	if (is_address_gen_insn(arch, dl)) {
> +		istat->bad++;
> +		return NULL;

Do you return NULL because you want to handle it with no_mem_ops case?
I suggest you add it here and return NO_TYPE.  There are places to call
__hist_entry__get_data_type() directly and I'd like to update the stat
in this function as much as possible.

Thanks,
Namhyung

> +	}
> +
>  	for_each_insn_op_loc(&loc, i, op_loc) {
>  		struct data_loc_info dloc = {
>  			.arch = arch,
> -- 
> 2.51.0.261.g7ce5a0a67e-goog
> 
