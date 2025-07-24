Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBD226560D;
	Thu, 24 Jul 2025 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345462; cv=none; b=ovXwz7DFxOWuwhBXQ1zmyboiEmGxe1YQ0eatiHl9qk5HM5O3KJQr/zjOMrAXq89Huj95HaU+hWdo5h2AWIe1Jp5p5X1Hr9HgMb7QdCHJD5jHp/p9Oyt772Ux2A5y22CIvbr8T2ZrTD+1uri1JC0oZ19ro+ptoYyvmKizaE5nPQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345462; c=relaxed/simple;
	bh=T2iNyoV3kaxSizudN13IYjiild8gnS6gEPKgFMynUSc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FEJ5nZJ5zT8l0pc0N7LEor8Ow7jXahNOeXEju4fj5qUxLrsol7l4l8Ag9jlhOKO6vvLwz2rAUtR4ZbAHWD1MBxA8PmSD0Elun/y6xjBRjYOFU1z86MdTnMJUpR+d+N+LL7ze69+5vfwCShetUDPP6QYwThNkx3Q8AUnmKlIEXr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4RUMyUx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4RUMyUx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C27CC4CEED;
	Thu, 24 Jul 2025 08:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753345461;
	bh=T2iNyoV3kaxSizudN13IYjiild8gnS6gEPKgFMynUSc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F4RUMyUxtou9sEqR/wU+24u9Yx+I5G6xK/Oe+lB+vP0QaNRJMUn1//mz3Wq54sqf8
	 qbX7jfYpFsAJ1I7UfVpvMTF1zptYTK9VVS1BPMnBQCWdw4zPemECDSLDG4y+l8i03y
	 XAyBDEa4j7H0kednx7hoPFFpUN0JKj5V+EnCDOFon64b8vrnFL5AzIMGS6haCxSuxQ
	 Kr/Uqz4myFKBTJdjqzDqBBXygt9NGuuWjQCLYN6+fTv2sIxhX1SGs0ArYlYuqNouyM
	 GYTXsdw7NLchjp4xWsn1Igc31RDjLQ5nlc6dz9VVCx4yziLV7OCVyI14mjsF8/hFL5
	 UyubH/Ay3wy5Q==
Date: Thu, 24 Jul 2025 17:24:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 thiago.bauermann@linaro.org, broonie@kernel.org, yury.khrustalev@arm.com,
 kristina.martsenko@arm.com, liaochang1@huawei.com, catalin.marinas@arm.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/8] uprobes: uprobe_warn should use passed task
Message-Id: <20250724172417.cd4a5092a21d65c337a59df6@kernel.org>
In-Reply-To: <20250719043740.4548-9-jeremy.linton@arm.com>
References: <20250719043740.4548-1-jeremy.linton@arm.com>
	<20250719043740.4548-9-jeremy.linton@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 23:37:40 -0500
Jeremy Linton <jeremy.linton@arm.com> wrote:

> uprobe_warn() is passed a task structure, yet its using current. For
> the most part this shouldn't matter, but since a task structure is
> provided, lets use it.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Looks good to me. BTW, is it a bug? This is introduced by
commit 248d3a7b2f10 ("uprobes: Change uprobe_copy_process()
to dup return_instances"), but there is no excuse why it
uses current instead of @t.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  kernel/events/uprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 4c965ba77f9f..2dc4fed837a2 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -121,7 +121,7 @@ struct xol_area {
>  
>  static void uprobe_warn(struct task_struct *t, const char *msg)
>  {
> -	pr_warn("uprobe: %s:%d failed to %s\n", current->comm, current->pid, msg);
> +	pr_warn("uprobe: %s:%d failed to %s\n", t->comm, t->pid, msg);
>  }
>  
>  /*
> -- 
> 2.50.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
