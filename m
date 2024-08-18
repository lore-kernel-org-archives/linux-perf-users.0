Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E192642A8F;
	Sun, 18 Aug 2024 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723987347; cv=none; b=G5ji3V4qRqJQ40RLseSPImzS1LhzSEmLbdKk0PtHPp6knlio/x9OsPV5L6yiG9kKoe0dv+C8sAVMPP9vC96/13jJaHuNYhpMzvux7nIfqb0j7aut6qVjkquMt4e6uf73lo9vO4NAnmwLG0l479fRQ9q4d168XoC1ooafrjjSM9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723987347; c=relaxed/simple;
	bh=q78J9YzO+9yDepnK+ZG7ivsszkYxSRLqe2yKgSFxcQA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jaPJBfne55I2QcGhaC9BwmTfx5lVHmkBSeyjvs0tQD0b3I/VszYNbJMthoqn57QFbbJkHgZnUH80Tciyw3uFIigGpg7Zhg3xLNsFiMfqCdEQ0WH6CR07axvAHixZGN2RyyfgQVKebFBdBoITGT3liZDppxxHENqVJZ5zqfzTuxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHHoulU1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHHoulU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04842C32786;
	Sun, 18 Aug 2024 13:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723987345;
	bh=q78J9YzO+9yDepnK+ZG7ivsszkYxSRLqe2yKgSFxcQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QHHoulU173Lrn4F8Nxagl2JkbaTRdP7sXDTaDG5VIGirgVGND2HAjnGaveaYnZr5B
	 iBktPMqRtUfW1XwXKMM3pcxg4Hf6/Nb+zsFIgZzzy70EREyyOTjFV/vgaOgYkqmx0P
	 Ni02vhR3Z50GoL9zq0415Q9IKHswRwFipISH9dk5kpgz6jJlokL/drfyUkYzgu5weO
	 I0EZTbIzldqX6bV9JazRGbK4IVPzpBUkizluyVRK5XPXmHAZthuiksd6XM/VltPbCv
	 LACTtPEBgKiXZ8BeQsRwUSnCb71f1IfMjukAjsdAfcOiV49dPNYnQF6H4uu8dsi6ys
	 7xXqBngGcXXbA==
Date: Sun, 18 Aug 2024 22:22:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers
 <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Athira
 Rajeev <atrajeev@linux.vnet.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: Re: [PATCH 2/9] perf annotate-data: Fix off-by-one in location
 range check
Message-Id: <20240818222221.fd9ced7456084b490c52b2da@kernel.org>
In-Reply-To: <20240816235840.2754937-3-namhyung@kernel.org>
References: <20240816235840.2754937-1-namhyung@kernel.org>
	<20240816235840.2754937-3-namhyung@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 16:58:32 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> The location list will have entries with half-open addressing like
> [start, end) which means it doesn't include the end address.  So it
> should skip entries at the end address and match to the next entry.
> 
> An example location list looks like this:
> 
>     00237876 ffffffff8110d32b (base address)
>     0023787f v000000000000000 v000000000000002 views at 00237868 for:
>              ffffffff8110d32b ffffffff8110d4eb (DW_OP_reg3 (rbx))     <<<--- 1
>     00237885 v000000000000002 v000000000000000 views at 0023786a for:
>              ffffffff8110d4eb ffffffff8110d50b (DW_OP_reg14 (r14))    <<<--- 2
>     0023788c v000000000000000 v000000000000001 views at 0023786c for:
>              ffffffff8110d50b ffffffff8110d7c4 (DW_OP_reg3 (rbx))
>     00237893 v000000000000000 v000000000000000 views at 0023786e for:
>              ffffffff8110d806 ffffffff8110d854 (DW_OP_reg3 (rbx))
>     0023789a v000000000000000 v000000000000000 views at 00237870 for:
>              ffffffff8110d876 ffffffff8110d88e (DW_OP_reg3 (rbx))
> 
> The first entry at 0023787f has [8110d32b, 8110d4eb) (omitting the
> ffffffff at the beginning), and the second one has [8110d4eb, 8110d50b).
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Fixes: 2bc3cf575a16 ("perf annotate-data: Improve debug message with location info")
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate-data.c | 2 +-
>  tools/perf/util/dwarf-aux.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index ff85d190e3ac..fd8d3cdead5a 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -95,7 +95,7 @@ static void pr_debug_location(Dwarf_Die *die, u64 pc, int reg)
>  		return;
>  
>  	while ((off = dwarf_getlocations(&attr, off, &base, &start, &end, &ops, &nops)) > 0) {
> -		if (reg != DWARF_REG_PC && end < pc)
> +		if (reg != DWARF_REG_PC && end <= pc)
>  			continue;
>  		if (reg != DWARF_REG_PC && start > pc)
>  			break;
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index beb632153a74..0151a8d14350 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1444,7 +1444,7 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
>  
>  	while ((off = dwarf_getlocations(&attr, off, &base, &start, &end, &ops, &nops)) > 0) {
>  		/* Assuming the location list is sorted by address */
> -		if (end < data->pc)
> +		if (end <= data->pc)
>  			continue;
>  		if (start > data->pc)
>  			break;
> -- 
> 2.46.0.184.g6999bdac58-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
