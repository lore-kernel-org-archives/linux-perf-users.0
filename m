Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE56824A3;
	Fri, 15 Aug 2025 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755288923; cv=none; b=QyWKDqmDNkZAzLlcKqTRBgapG1Mt+7wOoQOVRt2IzUwrG3pO5lFZpMsibjW8BDtxnwIRuNkQ3tSll0MIDrKQnvJ9iC96dnhALjqT+kZ14aGjThBlVcNLWsk+9d1zfQ+DyQRZKB3oIN87zmcqWMl9huRWdYYyzL9/VlDBPxXlE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755288923; c=relaxed/simple;
	bh=Mm4Y+rNMaulQFt94lvcOhS0cSRTfwAy8PMf9MYOmQ1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZeeQT+1jEeNbIikF8Prj6SESMcvJxNnT/m64zpvBuIAzsp5yhPZ2M7IFLsyLwTIYIp/e5SRAyllEsDUvlpPvkINzTs2fHPXRpu6n8SXK2AEvnrF90ImMuyrCWjQngvMK4iHB0YGl2z3VWEYjv8QCWs25u8rtWzrN4LkKWoLQCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKanWDbV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKanWDbV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CDCC4CEEB;
	Fri, 15 Aug 2025 20:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755288923;
	bh=Mm4Y+rNMaulQFt94lvcOhS0cSRTfwAy8PMf9MYOmQ1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKanWDbV6UFcB6rPzmgqEaP0FJj0cX4+5DS9ft/TjeXfiCbPDJoA3jGUWJxPk7aUz
	 /3TOjOq86wtKlWk96Z76KFh58EjyZN+aHgr09Jgggwl9i8Vz125jqxEPmvkU+4R9gK
	 ftEP6j+UlOeKY92vdFqqYPwwQNyClVt5oWArlh6TaI06JYBCFxX7Zcw/TzOC1yf/7m
	 b0c8Qaq8OxNhAj79EfoErqH6AizJTNqwiiR/zzyArjPhaWLGuc/sIUgP5OJk/uJlGQ
	 zz/FUCGS70z+5YfRBn13Wpjq8OqO/ukt8pOZOGlK0037ZSNuIgQc6FQp0fPRuKHpFC
	 sTAQFrf6S8RUA==
Date: Fri, 15 Aug 2025 13:15:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v2 0/6] Perf kvm commands bug fix
Message-ID: <aJ-VWevppm9Srjmr@google.com>
References: <20250811055546.296678-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250811055546.296678-1-dapeng1.mi@linux.intel.com>

On Mon, Aug 11, 2025 at 01:55:40PM +0800, Dapeng Mi wrote:
> his patch-set fixes perf kvm commands issues, like missed memory
> allocation check/free, out of range memory access and especially the
> issue that fails to sample guest with "perf kvm record/top" commands on
> Intel platforms.
> 
> The commit 634d36f82517 ("perf record: Just use "cycles:P" as the
>  default event") changes to use PEBS event to do sampling by default
> including guest sampling. This breaks host to sample guest with commands
> "perf kvm record/top" on Intel platforms.
> 
> Since the change "KVM: x86/pmu: Add basic support to enable guest PEBS
>  via DS"[1] starts, host loses the capability to sample guest with PEBS
> since all PEBS related MSRs are switched to guest value after vm-entry,
> like IA32_DS_AREA MSR is switched to guest GVA at vm-entry. This leads
> to PEBS events can't be used to sample guest by host, otherwise no guest
> PEBS records can be really sampled. The patches 5-6/6 fix this issue by
> using "cycles" event instead of PEBS event "cycles:P" to sample guest on
> Intel platforms.
> 
> Changes:
>   v1 -> v2:
>   * Free memory allocated by strdup().
>   * Check "--pfm-events" in kvm_add_default_arch_event() as well.
>   * Opportunistically fix the missed memory allocation and free issue in
>     builtin-kwork.
>   * Comments refine. 
> 
> 
> Tests:
>   * Run command "perf kvm record -a && perf kvm report" and "perf kvm
>     top" on Intel Sapphire Rapids platform, guest records can be
>     captured successfully.
>   * Since no powerpc platforms on hand, doesn't check the patches on
>     powerpc. Any test on powerpc is appreciated.
> 
> Ref:
>   [1] https://lore.kernel.org/all/20220411101946.20262-1-likexu@tencent.com/
> 
> 
> Dapeng Mi (6):
>   perf tools kvm: Add missed memory allocation check and free
>   perf tools kwork: Add missed memory allocation check and free
>   perf tools kvm: Fix the potential out of range memory access issue
>   perf tools: Add helper x86__is_intel_cpu()
>   perf tools kvm: Use "cycles" to sample guest for "kvm record" on Intel
>   perf tools kvm: Use "cycles" to sample guest for "kvm top" on Intel

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/arch/x86/util/kvm-stat.c |  51 +++++++++++
>  tools/perf/builtin-kvm.c            | 130 ++++++++++++++++++++--------
>  tools/perf/builtin-kwork.c          |  27 ++++--
>  tools/perf/util/env.c               |  22 +++++
>  tools/perf/util/env.h               |   2 +
>  tools/perf/util/kvm-stat.h          |  10 +++
>  6 files changed, 203 insertions(+), 39 deletions(-)
> 
> 
> base-commit: 6235ce77749f45cac27f630337e2fdf04e8a6c73
> -- 
> 2.34.1
> 
