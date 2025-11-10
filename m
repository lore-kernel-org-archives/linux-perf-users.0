Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CE9F50F;
	Mon, 10 Nov 2025 04:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762750728; cv=none; b=RLfNdHi73774F0LcfqeBLlGNUnGXN3i4i4sJ8EpmjcvFI7lAfZv6Ng4wBKnjctw+l0iOeymJCFGi05tq5RWIbBSReSeUKEV/hIgPNvMA/coIshgh2M/27gmzqbTo9QBMBJcAk235+8lElYV9VpPSeoeJ3oK4fIgA3zBOkQv9mKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762750728; c=relaxed/simple;
	bh=nphcQOI1kfRbhu/YEFcCiq+ww3xH/5WIF7mQO+nNk/s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ORucI6RfwuU7qMRtT3tpUeUvk7Tep6T7lBmY3ulPY1sdSIL6u9NMmYWEO5bJ53S1paK9leWCuW4ollmnqV7caaUl5deJR+/CeMZgAx4S8ioIy0v9LGkjLLecEwgIIyPMIJKoE9+cdOc+x21sZ4cvmSrz3OBR5GDYouMbqTl8WHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpeSBHUr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpeSBHUr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E88C4CEF5;
	Mon, 10 Nov 2025 04:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762750728;
	bh=nphcQOI1kfRbhu/YEFcCiq+ww3xH/5WIF7mQO+nNk/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mpeSBHUrB/nAOomS9Mm987ApUXi1jovyAG4bwh99uEGzMB114QdOPyCRJQ9fuRbiy
	 UbseNPen+CZyVShhms1MusQb73Tc3A1nNEtM0OqILMCVf0yx1zrsFwPYjIbKdvLMZd
	 OkyB5VhJ1H55wWqlrAg7KcJELMO5u2v1DWbz26ILez61BWbKSmoqcaSGAg4YE5rPxS
	 dHN0ZRmTThIuJ0cqZdxKsqG31LUYoUn6xR6Zb/wvxwiQngoWFlaKblpcwOG6wh4vwn
	 Cf/7Qmi5D2h15g5XLyO0/gMlmPJOS7JKVtZJgfObUE+uF/8nGAtTwf4+LUjCDsYdaf
	 Jqps5kxDE7Zsw==
Date: Mon, 10 Nov 2025 13:58:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Kyle Huey
 <khuey@kylehuey.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Will
 Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>
Subject: Re: [PATCH 0/2] tracing/wprobe: Fix to avoid inifinite watchpoint
 exception on arm64
Message-Id: <20251110135844.1c205d59be44d76169fc5e54@kernel.org>
In-Reply-To: <176179481538.959775.12326313742393696258.stgit@devnote2>
References: <176179481538.959775.12326313742393696258.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Ingo, Will, Ping?

I also found that Kyle made a change on this area recently.

Thank you,

On Thu, 30 Oct 2025 12:26:55 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here are patches which fixes a wprobe bug reported by Mark Brown on
> arm64[1]. The root cause was that the infinite watchpoint exception on
> the same instruction, because arm64 watchpoint exception happens before
> the memory access has done, it needs to configure a single-step after
> calling overflow handler. It does that only for the default overflow
> handlers, and not for custom overflow handler registered via
> hw_breakpoint interface.
> 
> [1] https://lore.kernel.org/all/aPvwGhMBJqMKcC9D@finisterre.sirena.org.uk/
> 
> To fix this issue, this series introduces default_overflow_compatible
> flag in the perf_event and use it for identifying default overflow
> handlers instead of checking handler functions everytime[1/2], and
> set it in wprobe[2/2].
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (Google) (2):
>       perf: Introduce default_overflow_compatible flag
>       tracing: wprobe: Make wprobe_handler default overflow_handler compatible
> 
> 
>  include/linux/perf_event.h  |    9 ++-------
>  kernel/events/core.c        |    2 ++
>  kernel/trace/trace_wprobe.c |    7 +++++++
>  3 files changed, 11 insertions(+), 7 deletions(-)
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
