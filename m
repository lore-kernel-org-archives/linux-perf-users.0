Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27157346E7E;
	Sun,  6 Sep 2026 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788709857; cv=none; b=Lmran9aIbR6i085rijUff4M8dTn/gEI6KvtkWXn56jGh7B4HzDOCXpS80fVPLxcxRunVi2gTpfngeQ4YaF5dwqcYitEpyogjS0BYsgE+k8610a3PKR24/nfEwUrjF9zakw5HMJcqj26D+w6mkGJlBVnNqE40edBSstC/oA2EInI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788709857; c=relaxed/simple;
	bh=D4FLliMx7Co62wYZMM0QZdSAGygmJK+SSy3loSA9ZhM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J9Maw9EcclJfBOvz5kQZlU0Mx/NChDOVdSK7vP7NqXgSdNfMqAeeAFPZ6hudRnz/r8vX4uowWN7iVzYxbEOqz81NH1uT6D7PY6X/5ZbY3KO/RdZDt3aC5NCRpItbKQ7CVa4+cFin+p3j1IkJycHJjMdCiyqwVtVWqYcsPihco4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhSl8wMq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhSl8wMq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918931F00A3A;
	Sun,  6 Sep 2026 15:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788709855;
	bh=7iIly6bsGuQf1IoGR0ccs8u+1+SVK5eOXLyr9vTPuQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZhSl8wMqA7N31PNUxvDoUtn6ExYYOk6iOJzEDI/cs2ZvYhg3Zh3iyFkd+SbYCIzss
	 2N9eGqBes6iGDBpvkNX1rVbvqCOxgJqx49MjRA5NAbottnx0IzRjVCGkkX3GUHdkWV
	 aqiNRxMt2h7BlZi0qIFGS/bWr53pGCgip22R6UVPVov7uqjttrDXk8sxXQ7gdh8z9W
	 979WYjsMw4TK2ax9YK8Gj+MA//P+O/bMJ4WCmW5RgSdYIDm3ftfgBzNIpK0aUhFLvG
	 lW75gl1MYjgF6CUagGTrDmUDhQDTyIUW5gLiSWm/k+7X+9OzoI19J/MPhLWVh7PFof
	 Ttl1/NWB/ZGrQ==
Date: Mon, 7 Sep 2026 00:50:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v14 11/14] tracing/wprobe: Add set_wprobe and
 clear_wprobe event triggers
Message-Id: <20260907005052.0a4a5ac1ec1734959e6ff4d6@kernel.org>
In-Reply-To: <20260830145252.AA74A1F000E9@smtp.kernel.org>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
	<178810013249.64882.3483637605217266271.stgit@devnote2>
	<20260830145252.AA74A1F000E9@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Aug 2026 14:52:52 +0000
sashiko-bot@kernel.org wrote:

> [Severity: Medium]
> Will this trigger a kernel warning in __flush_work() if the work struct has
> not been initialized yet?
> 
> In alloc_trace_wprobe(), if the kstrdup() allocation for the symbol fails,
> the function returns early. Since the tw pointer is managed by the
> __free(free_trace_wprobe) guard, it will automatically invoke this cleanup
> function:
> 
> alloc_trace_wprobe() {
>     ...
>     tw = kzalloc_flex(*tw, tp.args, nargs);
>     ...
>     if (symbol) {
>         tw->symbol = kstrdup(symbol, GFP_KERNEL);
>         if (!tw->symbol)
>             return ERR_PTR(-ENOMEM); /* triggers free_trace_wprobe(tw) */
>     }
>     ...
>     INIT_WORK(&tw->work, wprobe_work_func);
> }
> 
> Because the early return happens before INIT_WORK() is called,
> cancel_work_sync() will operate on a zeroed work_struct, which can cause a
> WARN_ON(!work->func).

Oops, good catch!

OK, I'll move the initialize those first and also check tw->work.func in
free_trace_wprobe() for safety.

Thank you!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
