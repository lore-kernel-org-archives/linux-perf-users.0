Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9B9199939;
	Wed, 28 May 2025 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748455893; cv=none; b=hZPZH8Xe3+HxjYF83grFQNJK6AMBjNBnwf+T/BHuOfKKFBnN2DADwd+5CTaoHbVrgzovxfmSbbVE1PhNiMuD6Yzkq42I1I4p21ThuMHlTK9qvBqmMyrbBgG6NznAKof2n7ilw8hyXiIRkAvUQbqpEZVwj20xKM3+zH6H01J33AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748455893; c=relaxed/simple;
	bh=pA6/+lW7KQ8D9sdiQUAJgFyLpd7301C+JPUAiDBNi6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bn3JNKTVSNX9JjkNsqRzrfe3mTwRSJtz7B7uIvgMlcZeVyRC67tvFPSFHlb3cpFsmR1lUS6ldoNb1mW6mwXiSw49shSWl7t8fJyfKDeaa38C5Tde6ZxZ2hgONdOsQh9TpE9+SF1TwBkJ0MuZYNDPzzHyY76l8StL2MRf5nKiUis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYacyj/Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYacyj/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3EDC4CEE3;
	Wed, 28 May 2025 18:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748455892;
	bh=pA6/+lW7KQ8D9sdiQUAJgFyLpd7301C+JPUAiDBNi6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYacyj/YCQ5Npy3F3wheC1SzvhJOVNjtyG2ed/DUVuv5KCpM3AxcKT/uRHRTd3i3Y
	 oEjEJWzWjzKLulrMma0UtJqtgVj1PMCkKUha9gdzGNPaT/7yis2Hiakx0otvueg0Bd
	 wSjQFO4SHn96l7uhhCGEOJruMurOtNpPun/a82ry8IiP2b9MZ3XEevJ6Zt9jhzYgdt
	 toJAgmwx/RyNVOKmGahgN52nYyHIaplqoECEJSy5zOrOgoFaYA4m/+E5w3Ejjr+OUy
	 tyxk/Xq9GfKJ6Hu19dG4VR4fOofQz2Qzl5jkYwrKnYixI8PxZ/eHEqNDEWq3/VEgJ4
	 4O9Uw1w7rTQtQ==
Date: Wed, 28 May 2025 11:11:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>,
	Yujie Liu <yujie.liu@intel.com>,
	Graham Woodward <graham.woodward@arm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Matt Fleming <matt@readmodwrite.com>,
	Chun-Tse Shao <ctshao@google.com>, Ben Gainey <ben.gainey@arm.com>,
	Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/3] perf sample: Remove arch notion of sample parsing
Message-ID: <aDdR0pCNSmxCEyEZ@google.com>
References: <20250521165317.713463-1-irogers@google.com>
 <20250521165317.713463-2-irogers@google.com>
 <aC43Et06tyrBOrsT@google.com>
 <CAP-5=fUYUDq6hmd+e3_E7HCRPYuy-0KLE+gLuSCWAHh3A5wJLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUYUDq6hmd+e3_E7HCRPYuy-0KLE+gLuSCWAHh3A5wJLA@mail.gmail.com>

On Wed, May 21, 2025 at 02:15:24PM -0700, Ian Rogers wrote:
> On Wed, May 21, 2025 at 1:27 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, May 21, 2025 at 09:53:15AM -0700, Ian Rogers wrote:
> > > By definition arch sample parsing and synthesis will inhibit certain
> > > kinds of cross-platform record then analysis (report, script,
> > > etc.). Remove arch_perf_parse_sample_weight and
> > > arch_perf_synthesize_sample_weight replacing with a common
> > > implementation. Combine perf_sample p_stage_cyc and retire_lat to
> > > capture the differing uses regardless of compiled for architecture.
> >
> > Can you please do this without renaming?  It can be a separate patch but
> > I think we can just leave it.
> 
> It is not clear what the use of the union is. Presumably it is a
> tagged union but there is no tag as the union value to use is implied
> by either being built on x86_64 or powerpc. The change removes the
> notion of this code being built for x86_64 or powerpc and so the union
> value to use isn't clear (e.g. should arm use p_stage_cyc or
> retire_lat from the union), hence combining to show that it could be
> one or the other. The code could be:
> ```
> #ifdef __x86_64__
>        u16 p_stage_cyc;
> #elif defined(powerpc)
>        u16 retire_lat;
> #endif
> ```
> but this isn't cross-platform.

Right, we probably don't want it.


> The change in hist.h of
> ```
> @@ -255,7 +255,7 @@ struct hist_entry {
>         u64                     code_page_size;
>         u64                     weight;
>         u64                     ins_lat;
> -       u64                     p_stage_cyc;
> +       u64                     p_stage_cyc_or_retire_lat;
> ```
> could be a follow up CL, but then we lose something of what the field
> is holding given the value is just a copy of that same named value in
> perf_sample. The code only inserts 34 lines and so the churn of doing
> that seemed worse than having the change in a single patch for
> clarity.

Assuming other archs can add something later, we won't rename the field
again.  So I can live with the ugly union fields.  If we really want to
rename it, I prefer calling it just 'weight3' and let the archs handle
the display name only.

Thanks,
Namhyung

