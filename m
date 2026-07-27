Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAFE2D249B;
	Mon, 27 Jul 2026 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155803; cv=none; b=d1H1d+duTXm+NSGoHkLdPnYLqSUC7WfXTaui7BLGlfVpeROWFAWYJYID8gTzqbn04HwzmJdXWJCpb4giOQvzpKt9IuLbuIb2OSVXpJY4VpN8Rzp5I9y9qgsGnc3+oqDKuhpR3A8Neio5U+fNfbCqHssg+R4LASE6ZxchzXxT3TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155803; c=relaxed/simple;
	bh=TlfOgGUjWpT7PngCpfcuSImForFETaHdkIlQoJibbCw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DUp1YNXyDS8KfjrvY2kuQUZgafWbjeNZu28g9AEIJ/e134jNIz+tLZDB1f/mUmoYanoqlENoCIu0o9v7Tw7PCI9pvTqK1x/A4kuAK4ii3YcgHecnhqLBshn03djf364Oy11LONAU4vsVIxL03SjUHZWQXE5OXC5DhDrf4MqlCCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Koh8xlep; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Koh8xlep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110501F000E9;
	Mon, 27 Jul 2026 12:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785155802;
	bh=1nv1S5hEpBMVAguEKnHI+47lbGEypcaxvcdcKDztF5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Koh8xleplA+pyua6Yi4m2itBZfUeVSuhkH4fobBPXR4F5+YX1LNH1GWTf3I1lGMS3
	 bgl9u0/+0bZPnY/ryHSEM0zKvKZPD3/R8i+vIQTaKiNQiZNPNVxYIPfYupsJ6HuiPS
	 56AqPkjfDbfOAVJdMcqpEoHh8qEiPl7h7De1hN9xVv5F00/ZNj1Jkpbel5lWojwpdu
	 JlfLoi6FeGlVWGHKPGDODUmiX00U8IaHGOo+3JFLhrh4tv4iR49kYxjKmqsd845G3V
	 4UOImZq+tk5rGUv7S5jGImBIRX/LpI98LA8vNOAOGfJjdYv/flz+eiCTmHWEsDi8Kt
	 KGbJMqBzQT84A==
Date: Mon, 27 Jul 2026 21:36:34 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tony Luck
 <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-edac@vger.kernel.org
Subject: Re: [PATCH 0/3] hw_breakpoint: Fix and simplify local address
 updates for wprobe
Message-Id: <20260727213634.72581cb0d2923269a940a87c@kernel.org>
In-Reply-To: <cover.1785067572.git.wangjinchao600@gmail.com>
References: <178476143000.26117.9810509272687580410.stgit@devnote2>
	<cover.1785067572.git.wangjinchao600@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jul 2026 20:22:29 +0800
Jinchao Wang <wangjinchao600@gmail.com> wrote:

> Hi Masami,
> 
> While reviewing wprobe v10, I prepared three patches to fix and simplify
> the HWBP support required by wprobe.

Hi Jinchao,

Thanks for the series!

> 
> This series is based on linux-trace/probes/for-next, the same base used by
> wprobe v10. It is intended to replace patches 5-7 in v10, so it should not
> be applied on top of topic/wprobe-v2.

OK, let me replace it with this series.
I'll also update wprobe side and make it v11.

> 
> Patch 1 fixes the x86 HWBP slot and DR7 races when an operation is
> interrupted by an NMI.
> 
> Patch 2 adds arch_modify_local_hw_breakpoint_addr(), which updates only
> the watched address of an installed breakpoint on the local CPU.
> 
> Patch 3 adds the matching generic modify_local_hw_breakpoint_addr() API.
> It keeps the original patch structure and Masami's authorship, while
> removing attribute parsing, type/length updates and rollback.
> 
> With the address-only interface, the install/uninstall refactoring in the
> old patch 5 is no longer needed.

OK.

> 
> I can take care of follow-up maintenance related to fast local HWBP
> watched-address updates.
> 
> The patches passed checkpatch and the relevant x86_32 and x86_64 object
> builds.

Thanks!

> 
> Jinchao Wang (2):
>   x86/hw_breakpoints: Make DR7 updates NMI safe
>   x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API
> 
> Masami Hiramatsu (Google) (1):
>   HWBP: Add modify_local_hw_breakpoint_addr() API
> 
>  arch/Kconfig                         |   8 ++
>  arch/x86/Kconfig                     |   1 +
>  arch/x86/include/asm/debugreg.h      |  36 ++++++---
>  arch/x86/include/asm/hw_breakpoint.h |   2 +
>  arch/x86/kernel/cpu/mce/core.c       |  20 +++--
>  arch/x86/kernel/hw_breakpoint.c      | 114 ++++++++++++++++-----------
>  arch/x86/kernel/nmi.c                |  10 ++-
>  arch/x86/kernel/traps.c              |  10 ++-
>  include/linux/hw_breakpoint.h        |   6 ++
>  kernel/events/hw_breakpoint.c        |  30 +++++++
>  10 files changed, 166 insertions(+), 71 deletions(-)
> 
> 
> base-commit: 1a416ae446afa42d2d8500ce25bd61c564508721
> -- 
> 2.53.0


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
