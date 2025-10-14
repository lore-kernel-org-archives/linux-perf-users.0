Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8929284880;
	Tue, 14 Oct 2025 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760467239; cv=none; b=nZoPZY9EhNHBm1oJOhwATIL1DjmGJLE5HOr4p4yx1lcPYhUUABGQQ8SPSjsHWy/k67FKZCgryzOb1QVNeFMplMcqSmvaAu5MiJyzAKT79QFv9gZkp5ssVIYOvIjCSgFlF4DUb28/8Z8On4kcX3Be+lf+r3AYn9S1R0rI7N/IKBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760467239; c=relaxed/simple;
	bh=xsXUITWBZ2cXFzhwdGcCUewaft7HR7reV3UnOiMU37M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSbxuaClJokiEzdp7WfTSaCNjOiyoSsq8OqVl1jLYngL1/e6QaeMpQqK4AKEPTMPU9hxEYcRfer3unzUCQOfyz4CH6jNSu7zMoe/yOylTfu/YHpejR5Vr7/xIDb91mxnNzvCOjM1DtIGSzaNOp7BS+4tQLnpnV5abH0FC6YU/sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCsOpA6X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCsOpA6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9991CC4CEE7;
	Tue, 14 Oct 2025 18:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760467238;
	bh=xsXUITWBZ2cXFzhwdGcCUewaft7HR7reV3UnOiMU37M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gCsOpA6X+yvJcDfk9RQGozVaIrLjPbIWBOgSWp/S4ZSOg08UU0UjCNPLtndrPLju5
	 Y0fCngp2NEikVjrp4cEOXfj5WZZ8tRty9Q/4hMagFjBh8JcPon8fYa5RovIu8d7VFI
	 0uW/gVcVwNChXQ7aTxCy8c6Y6auHWEbWuKZE/puC+Ah8Kk05jRmjcpfXRBah8en1Wm
	 ul7/YnTUskFVsGeA8sJT94k+3uH1I04tojh/QvW8RpeUIg4s4nwerNKImp611Ys46v
	 MM2cu16/p+yMRzKM5lmGZB75aVBHCzNcQJY9Phyxx4h0/4M0DMACXYg9jCBRpsXsNV
	 vgmIxRUCSWhdA==
Date: Tue, 14 Oct 2025 15:40:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] perf annotate: Skip annotating data types to lea
 instructions
Message-ID: <aO6ZIQ2WwTPGWATX@x1>
References: <20251013181607.2745653-1-zecheng@google.com>
 <20251013181607.2745653-2-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013181607.2745653-2-zecheng@google.com>

On Mon, Oct 13, 2025 at 06:15:58PM +0000, Zecheng Li wrote:
> Introduce a helper function is_address_gen_insn() to check
> arch-dependent address generation instructions like lea in x86. Remove
> type annotation on these instructions since they are not accessing
> memory. It should be counted as `no_mem_ops`.
> 
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  tools/perf/util/annotate.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index a2e34f149a07..fb60467fa877 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2698,6 +2698,20 @@ static bool is_stack_canary(struct arch *arch, struct annotated_op_loc *loc)
>  	return false;
>  }
>  
> +/**
> + * Returns true if the instruction has a memory operand without
> + * performing a load/store
> + */
> +static bool is_address_gen_insn(struct arch *arch, struct disasm_line *dl)
> +{
> +	if (arch__is(arch, "x86")) {
> +		if (!strncmp(dl->ins.name, "lea", 3))
> +			return true;
> +	}

Can't we turn this into:

tatic bool disasm_line__is_address_gen_insn(const struct disasm_line *dl)
{
		return dl->ins.address_gen;
}

I.e. at some initial step when setting dl->ins, cache this series of
string operations and then use it s result?

- Arnaldo

> +
>  static struct disasm_line *
>  annotation__prev_asm_line(struct annotation *notes, struct disasm_line *curr)
>  {
> @@ -2806,6 +2820,12 @@ __hist_entry__get_data_type(struct hist_entry *he, struct arch *arch,
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
> 2.51.0.788.g6d19910ace-goog
