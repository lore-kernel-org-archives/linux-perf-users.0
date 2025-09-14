Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0071E51E1;
	Sun, 14 Sep 2025 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757858003; cv=none; b=NLemZ1P4AK/a5LpRSLL9Yc84VX96XkkFqHzHZoXRI4mO2pJPEdI1y8sEz5+1a+HzpCqUzlhv/cIwviYxtAWm7/IJrGjn+3A0mxD9fj3UA5vVasi1AwI/0Cb6JkJdJrI+FwfQOp5vzAgrYx0GpFaDwwCiFgrhjuh3muGuPRs8eY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757858003; c=relaxed/simple;
	bh=Up9Xu/CJoHEjUcchIJsyeiW2UaO4s1K1qCNgKItusWg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ArGxYsdjt1Tqky1DYtmRoWTBLxGKxtCQIGQDCunWVkOfpfGzjYwZP0vCN5KX8/U4HCc6KZog48VnHTetHCAfVmdUo44FKhwco4hZ2gnEQqcVcVTDOQmQZKmLgvj93e5kf/8QajtEHQp6LLywOZpoJ1yC9tNTx4Mu3ANwMJ/RANA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hm3bsaZn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hm3bsaZn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F0FC4CEF0;
	Sun, 14 Sep 2025 13:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757858000;
	bh=Up9Xu/CJoHEjUcchIJsyeiW2UaO4s1K1qCNgKItusWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hm3bsaZn2JvvJqxIY9S3ulwLpYVfges3Vprs9UKDgleuWKeb0EAYJrz6RKDtsItTD
	 2awMaKPZ+wOkswbhdv1+Wwe5OwP87TII+h6gIlFDrCBOG8/KpDgNBNgrqurUJrGwwj
	 1s28FU0H0CT4SdxvYS/av7lUhVE5zGQfFumGB0hGhZkHAtQeoLqiQd510v1PnFXFiK
	 YqZukWPqiKIe+x6kKKokwvL0KeD8SzvtJl5oA+wult90ARlAMp2b1Z2jJJd07f11YD
	 Vpe354oAqwdIWbmOkSkRqziYY5oO5Sho7Uc6n4G6FGbr0zo7SEsStdW68E/vgiMwDF
	 FdRnhA7K5BHNA==
Date: Sun, 14 Sep 2025 22:53:06 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Mike Rapoport <rppt@kernel.org>, Alexander
 Potapenko <glider@google.com>, Jonathan Corbet <corbet@lwn.net>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, David Hildenbrand
 <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Sami Tolvanen <samitolvanen@google.com>, Miguel
 Ojeda <ojeda@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Rong Xu
 <xur@google.com>, Naveen N Rao <naveen@kernel.org>, David Kaplan
 <david.kaplan@amd.com>, Andrii Nakryiko <andrii@kernel.org>, Jinjie Ruan
 <ruanjinjie@huawei.com>, Nam Cao <namcao@linutronix.de>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-mm@kvack.org, llvm@lists.linux.dev, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry
 Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 kasan-dev@googlegroups.com, "David S. Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/21] x86/hw_breakpoint: Add
 arch_reinstall_hw_breakpoint
Message-Id: <20250914225306.2185b79065e32f60a40ef54c@kernel.org>
In-Reply-To: <20250912101145.465708-3-wangjinchao600@gmail.com>
References: <20250912101145.465708-1-wangjinchao600@gmail.com>
	<20250912101145.465708-3-wangjinchao600@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 18:11:12 +0800
Jinchao Wang <wangjinchao600@gmail.com> wrote:

> The new arch_reinstall_hw_breakpoint() function can be used in an
> atomic context, unlike the more expensive free and re-allocation path.
> This allows callers to efficiently re-establish an existing breakpoint.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  arch/x86/include/asm/hw_breakpoint.h | 2 ++
>  arch/x86/kernel/hw_breakpoint.c      | 9 +++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
> index aa6adac6c3a2..c22cc4e87fc5 100644
> --- a/arch/x86/include/asm/hw_breakpoint.h
> +++ b/arch/x86/include/asm/hw_breakpoint.h
> @@ -21,6 +21,7 @@ struct arch_hw_breakpoint {
>  
>  enum bp_slot_action {
>  	BP_SLOT_ACTION_INSTALL,
> +	BP_SLOT_ACTION_REINSTALL,
>  	BP_SLOT_ACTION_UNINSTALL,
>  };
>  
> @@ -65,6 +66,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
>  
>  
>  int arch_install_hw_breakpoint(struct perf_event *bp);
> +int arch_reinstall_hw_breakpoint(struct perf_event *bp);
>  void arch_uninstall_hw_breakpoint(struct perf_event *bp);
>  void hw_breakpoint_pmu_read(struct perf_event *bp);
>  void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> index 3658ace4bd8d..29c9369264d4 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -99,6 +99,10 @@ static int manage_bp_slot(struct perf_event *bp, enum bp_slot_action action)
>  		old_bp = NULL;
>  		new_bp = bp;
>  		break;
> +	case BP_SLOT_ACTION_REINSTALL:
> +		old_bp = bp;
> +		new_bp = bp;
> +		break;
>  	case BP_SLOT_ACTION_UNINSTALL:
>  		old_bp = bp;
>  		new_bp = NULL;
> @@ -187,6 +191,11 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>  	return arch_manage_bp(bp, BP_SLOT_ACTION_INSTALL);
>  }
>  
> +int arch_reinstall_hw_breakpoint(struct perf_event *bp)
> +{
> +	return arch_manage_bp(bp, BP_SLOT_ACTION_REINSTALL);
> +}
> +
>  void arch_uninstall_hw_breakpoint(struct perf_event *bp)
>  {
>  	arch_manage_bp(bp, BP_SLOT_ACTION_UNINSTALL);
> -- 
> 2.43.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
