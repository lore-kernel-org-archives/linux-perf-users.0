Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E062DEA68;
	Mon,  6 Jul 2026 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358982; cv=none; b=TVA+ibwJq4QDU10bC9WrEGhgunFPXiysAj44pqwFucHWncOqtkONyAe8/7+OUGDU6u0nR/KstEWfn6aC9mCybiWyc36+xdE0CNVsk8+GBXLrvRDFf1QKaW19neGKqIgX1Tn/RXsYqyIS0sJB64reUz0gq08/dPaIvlKAgXv53bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358982; c=relaxed/simple;
	bh=LUwnC/QA6xTgLEI+6ROL1tRVqzXKyLJm3hBs+MnmVEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPHDyN4u0WF4NZpTgiuA/hyhKwfNvXelH5/OJMMGF3oyx91g26p+oIbV3I6QKV8FmNKKJMbh+K4u5xUsl8fD3jxVZBO+isFNInHhg5BUl/gxRRu3HtWYrSaA8TOD0YDA+hluRvbjFV+rm6ReQaDa/Uz4T3UHEq8nKdN9soMmME0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miR56bID; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miR56bID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C885B1F000E9;
	Mon,  6 Jul 2026 17:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783358981;
	bh=aFA8rrR6A2/Rfxa14BcpRpNQ6z/JG+NvfpMZGVk2DD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=miR56bIDPwDHqaFbOA1DCsf5zz2tDH/XqKsYv88NbgdSZVa1DI5AR+LZqYAFb2NjZ
	 KfiaAASSpcIOZc7QIGs7ePbmnLsHL4fYqEZV44gLkqS/UHm/ntIBhWC/DSOWlbidMJ
	 m3hmpWOFrOEQ9yuBiwRyIMqWY60wcZeDGLvNy00SIT4CC2mwEUCZLSIhz3SVVwdtzH
	 VlTTi49rNLd8ssipcmEa1rAxHuhp/5IxHhBIm/GUeu7QmFAp28JE7+27f4X0Zirwr5
	 6tsdhuIyHWkQtVW3+Cc8YE4Y/tekGKa5h6ZpQN2hJWhsDfJFVztiOlsKUeGdqBGz4L
	 XHs4Oe5iHZWCQ==
Date: Mon, 6 Jul 2026 10:29:39 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Sandipan Das <sandipan.das@amd.com>
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Subject: Re: [PATCH v2 1/2] perf vendor events amd: Update Zen 5 core events
Message-ID: <akvmA_ondqn-lj9W@google.com>
References: <619d0a273011c935b2654eab5121a4eba5ab1c03.1780383172.git.sandipan.das@amd.com>
 <CAP-5=fV_czvd-z4N7K+_SabxuOm9UUHRyBxNuchrtAgJL3OqOw@mail.gmail.com>
 <bf0b2ab8-c2b1-4020-8506-6e2188e78250@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf0b2ab8-c2b1-4020-8506-6e2188e78250@amd.com>

Hello,

On Mon, Jul 06, 2026 at 10:51:20PM +0530, Sandipan Das wrote:
> On 06-07-2026 22:44, Ian Rogers wrote:
> > On Mon, Jun 22, 2026 at 10:28 PM Sandipan Das <sandipan.das@amd.com> wrote:
> >>
> >> Update definitions for the following events.
> >>   * PMCx00A - Add missing unit masks
> >>   * PMCx00B - Add missing unit masks and fix descriptions
> >>   * PMCx00C - Add missing unit masks
> >>   * PMCx00D - Add missing unit masks
> >>   * PMCx025 - Add missing unit masks and fix descriptions
> >>
> >> Fixes: 45c072f2537a ("perf vendor events amd: Add Zen 5 core events")
> >> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> >> ---
> >>
> >> Previous versions can be found at:
> >> v1: https://lore.kernel.org/all/f16d1391366762dee0d49f00697f5e6ea913e2c1.1780330378.git.sandipan.das@amd.com/
> >>
> >> Changes in v2:
> >>   * Fix event description pointed out by sashiko.
> >>
> >> ---
> >>  .../arch/x86/amdzen5/floating-point.json      | 130 +++++++++++++++---
> >>  .../arch/x86/amdzen5/load-store.json          |   8 +-
> >>  2 files changed, 120 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
> >> index 9204bfb1d69e..569975b53cc3 100644
> >> --- a/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
> >> +++ b/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
> >> @@ -179,6 +179,30 @@
> >>      "BriefDescription": "Retired scalar floating-point blend ops.",
> >>      "UMask": "0x09"
> >>    },
> >> +  {
> >> +    "EventName": "fp_ops_retired_by_type.scalar_mov",
> >> +    "EventCode": "0x0a",
> >> +    "BriefDescription": "Retired scalar floating-point MOV ops.",
> >> +    "UMask": "0x0a"
> >> +  },
> >> +  {
> >> +    "EventName": "fp_ops_retired_by_type.scalar_shuffle",
> >> +    "EventCode": "0x0a",
> >> +    "BriefDescription": "Retired scalar floating-point shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
> >> +    "UMask": "0x0b"
> >> +  },
> >> +  {
> >> +    "EventName": "fp_ops_retired_by_type.scalar_bfloat",
> >> +    "EventCode": "0x0a",
> >> +    "BriefDescription": "Retired scalar floating-point bfloat ops.",
> >> +    "UMask": "0x0c"
> >> +  },
> >> +  {
> >> +    "EventName": "fp_ops_retired_by_type.scalar_logical",
> >> +    "EventCode": "0x0a",
> >> +    "BriefDescription": "Retired scalar floating-point logical ops.",
> >> +    "UMask": "0x0d"
> >> +  },
> >>    {
> >>      "EventName": "fp_ops_retired_by_type.scalar_other",
> >>      "EventCode": "0x0a",
> >> @@ -245,12 +269,24 @@
> >>      "BriefDescription": "Retired vector floating-point blend ops.",
> >>      "UMask": "0x90"
> >>    },
> >> +  {
> >> +    "EventName": "fp_ops_retired_by_type.vector_mov",
> >> +    "EventCode": "0x0a",
> >> +    "BriefDescription": "Retired vector floating-point MOV ops.",
> >> +    "UMask": "0xa0"
> >> +  },
> >>    {
> >>      "EventName": "fp_ops_retired_by_type.vector_shuffle",
> >>      "EventCode": "0x0a",
> >>      "BriefDescription": "Retired vector floating-point shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
> >>      "UMask": "0xb0"
> >>    },
> >> +  {
> >> +    "EventName": "fp_ops_retired_by_type.vector_bfloat",
> >> +    "EventCode": "0x0a",
> >> +    "BriefDescription": "Retired vector floating-point bfloat ops.",
> >> +    "UMask": "0xc0"
> >> +  },
> >>    {
> >>      "EventName": "fp_ops_retired_by_type.vector_logical",
> >>      "EventCode": "0x0a",
> >> @@ -278,7 +314,7 @@
> >>    {
> >>      "EventName": "sse_avx_ops_retired.mmx_add",
> >>      "EventCode": "0x0b",
> >> -    "BriefDescription": "Retired MMX integer add.",
> >> +    "BriefDescription": "Retired MMX integer add ops.",
> >>      "UMask": "0x01"
> >>    },
> >>    {
> >> @@ -299,16 +335,34 @@
> >>      "BriefDescription": "Retired MMX integer multiply-accumulate ops.",
> >>      "UMask": "0x04"
> >>    },
> >> +  {
> >> +    "EventName": "sse_avx_ops_retired.mmx_aes",
> >> +    "EventCode": "0x0b",
> >> +    "BriefDescription": "Retired MMX integer AES ops.",
> >> +    "UMask": "0x05"
> >> +  },
> >> +  {
> >> +    "EventName": "sse_avx_ops_retired.mmx_sha",
> >> +    "EventCode": "0x0b",
> >> +    "BriefDescription": "Retired MMX integer SHA ops.",
> >> +    "UMask": "0x06"
> >> +  },
> >>    {
> >>      "EventName": "sse_avx_ops_retired.mmx_cmp",
> >>      "EventCode": "0x0b",
> >>      "BriefDescription": "Retired MMX integer compare ops.",
> >>      "UMask": "0x07"
> >>    },
> >> +  {
> >> +    "EventName": "sse_avx_ops_retired.mmx_cvt",
> >> +    "EventCode": "0x0b",
> >> +    "BriefDescription": "Retired MMX integer convert or pack ops.",
> >> +    "UMask": "0x08"
> >> +  },
> >>    {
> >>      "EventName": "sse_avx_ops_retired.mmx_shift",
> >>      "EventCode": "0x0b",
> >> -    "BriefDescription": "Retired MMX integer shift ops.",
> >> +    "BriefDescription": "Retired MMX integer shift or rotate ops.",
> >>      "UMask": "0x09"
> >>    },
> >>    {
> >> @@ -324,9 +378,9 @@
> >>      "UMask": "0x0b"
> >>    },
> >>    {
> >> -    "EventName": "sse_avx_ops_retired.mmx_pack",
> >> +    "EventName": "sse_avx_ops_retired.mmx_vnni",
> > 
> > Just a heads up, when renaming events it may be a good idea to keep
> > the old name and mark the event as deprecated, then add the event
> > again with the new name. This avoids events breaking when the perf
> > tool is updated. Personally I feel vendors should get to decide about
> > this kind of thing, but there have been some strong sensitivities
> > around event names in the past.
> > 
> 
> Thanks for the suggestion. I agree that renames can be problematic
> for existing scripted workflows.
> 
> Namhyung, please let me know if you want to revert these changes.
> I can send out v3.

It'd be nice if you can send an incremental fix on top of the current
perf-tools-next.

Thanks,
Namhyung

