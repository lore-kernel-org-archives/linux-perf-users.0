Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97309389DF0;
	Thu,  6 Aug 2026 05:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785993156; cv=none; b=tkPp1BjX4haRySylMn0eIAlfJU5OHxsiKbMIHcQGOYlEG9yMutxNffCzzt3oedNonASEN4zJ1ZOW5Zo+jZI+5N2YYtrYuQwe8xtrxFBcgyVY3OkBOJO2Q9V3z5ifi8qNI6LPeDapB0PE8roUTX25LombsnYaJMZDGuEMwP5R27M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785993156; c=relaxed/simple;
	bh=d8Fm8peU8WooM9ToFjEpTedyeDzYHmhxbWPCUY8hbuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnK9pjbQ51RZUTCDJKjgc7xvJoTlINYo9Y66Hu+qujKtAwOazYhi0g9IXwjI7b2gScfTV9GFWy9k+GQHrWQNJ8vaVXEKeYicj9XQl8iwd35uVyg2QfIfGgZeqJS8YTn7xC8pbYiLWwyKeD+2y7t4uavxswWxKpI+GE53ICzylAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ya19SGyP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ya19SGyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C630F1F000E9;
	Thu,  6 Aug 2026 05:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785993155;
	bh=vtnJbjtlFsTnhlZxh7hSJLxgw3p7weNWufTw8cKagKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ya19SGyPoFkJUCSW5jxqJe55tUjP5fP5B4ukNTY1X/fRJFG+0qPzecLqIsvrwlanB
	 p+y798VLMuVKzZX1WXA2sZJDiu2SO1L0HHS3j8fgOCdJ5R2OiWg+fmMUfPF7FMTnco
	 ldkzae8l4HCvW3ABbx7vhc/tj54Rrrl7cMgLWCIvQdIXdpa1lG7poIZZABFyFDqnkf
	 0V3B8IVBqkEiZjscQM8L/gjFCmXTQPo7qpwSqdq0EjNIJUlnVSU55GXIXtW05NyLHM
	 bNbEIgaID3XN7vIJQCNlsU45rb72YZWxlOJhYxuO32QMC8o1S0Th+g0qZUrFxe66zP
	 GjqNvqpIzAEPw==
Date: Wed, 5 Aug 2026 22:12:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: michael.niarchos@gmail.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] perf tools: Fix memory issues
Message-ID: <anQXwT3fD5oZDWz0@google.com>
References: <20260803-perf-kvm-fixes-v3-0-e06268ec06fa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260803-perf-kvm-fixes-v3-0-e06268ec06fa@gmail.com>

Hello,

On Mon, Aug 03, 2026 at 03:51:51PM +0200, Michalis Niarchos via B4 Relay wrote:
> Running:
>   $ perf kvm stat record -a sleep 10
> 
> gives this output:
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 1.361 MB perf.data.guest ]
>   double free or corruption (!prev)
> 
> In the process of resolving this, I came across some memory leaks.

I think those issues are already fixed in the perf-tools-next.
Can you please check the latest code?

Thanks,
Namhyung

> 
> Signed-off-by: Michalis Niarchos <michael.niarchos@gmail.com>
> ---
> Changes in v3:
> - Moved dead code removal to the correct patch.
> - Squashed double free patches, as both fix the same rec_argv
>   double-free/leak pattern.
> - Link to v2: https://patch.msgid.link/20260803-perf-kvm-fixes-v2-0-1b337189fffc@gmail.com
> 
> Changes in v2:
> - Removed code block that was rendered dead by the
>   get_filename_for_perf_kvm() change.
> - Dropped invalid free() fix from kvm_events_report().
> - Added double free fixes for: __cmd_record(), __cmd_report(),
>   __cmd_buildid_list(), and __cmd_top(), which follow the same pattern
>   as kvm_events_record().
> - Link to v1: https://patch.msgid.link/20260803-perf-kvm-fixes-v1-0-a5db849ac973@gmail.com
> 
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> To: Arnaldo Carvalho de Melo <acme@kernel.org>
> To: Namhyung Kim <namhyung@kernel.org>
> To: Mark Rutland <mark.rutland@arm.com>
> To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> To: Jiri Olsa <jolsa@kernel.org>
> To: Ian Rogers <irogers@google.com>
> To: Adrian Hunter <adrian.hunter@intel.com>
> To: James Clark <james.clark@linaro.org>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> ---
> Michalis Niarchos (3):
>       perf tools: Fix memory leak in cmd_kvm()
>       perf tools: Fix double free and memory leak issues
>       perf tools: Fix memory leak in cmd_kvm()
> 
>  tools/perf/builtin-kvm.c                         | 99 +++++++++++-------------
>  tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c |  4 +-
>  tools/perf/util/kvm-stat-arch/kvm-stat-x86.c     | 10 +--
>  3 files changed, 50 insertions(+), 63 deletions(-)
> ---
> base-commit: a1ed064cb4db70af8c4177b3805ca5b8b0be567e
> change-id: 20260731-perf-kvm-fixes-a17f0aa048ad
> 
> Best regards,
> --  
> Michalis Niarchos <michael.niarchos@gmail.com>
> 
> 
