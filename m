Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F4B2E401;
	Thu,  3 Oct 2024 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727973919; cv=none; b=dfRhRgoPRMlIjzX6RgtRzRK7/Y5vJlojXnUJr8QNl0+8J0pWc2JoadUMVhj73BM4Qel25Ow08VJgm+oLoODI40E31BoFahraolB22iJ28hrVwBIP0eqb9AXJxBaPf4NFXdbBMGXumfwIz1Qwi2FoNgvrkdvVzVKCpoZ2fatpucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727973919; c=relaxed/simple;
	bh=Q/EKWE1hNN8542JxNZpkEj1hOy0vS/dhDiyU+pSAiuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrTX7nB9e+I0G11RQbDG6Omcfegepp2SlTWEutZHnjpGfwuNWXXjt055bEF6EMnqq/JjCNkuImiYeGOP/xQnXuiw41ICrYrRjCIW/5on8yIYFBjR6fp5EDChiCJ0yylytFWOTcZ/8k8bmWTPWeHXXXPpPaasEm8J/vCjfUttf5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD6GaiSl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD6GaiSl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EC1C4CEC5;
	Thu,  3 Oct 2024 16:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727973918;
	bh=Q/EKWE1hNN8542JxNZpkEj1hOy0vS/dhDiyU+pSAiuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YD6GaiSlDOiIYKmNAtjYifGojpJ7mkqu1gOOiV1baZRKpaGWJsrilxps3kKJo5MBo
	 08PBNhFcrGLmh3GIwOtw1K1r7EXUnvZDWJiASvsGjy/JB+WTTinqR9LBcHFLiTkdKN
	 EHO1MrTw01jQbqDaS6qepVjz0eBO8foi/QJrB8KR4IjiLQ6msc3v2YGrlJPAh9CyrY
	 mTn+ng3l2hgsyU8HuF2Jpft38SB06ifhdP+83MP+WJqKxWkIUf45nefXBOO548PcC2
	 oz//UD+bkkr1+OKLAYTplvZr0UcvdjZJQuaHvctZM9Tr9K0cCPZGQOuhC4a0IsYmse
	 wk1Tkzrs2K8QQ==
Date: Thu, 3 Oct 2024 09:45:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v5 0/6] Bug fixes on topdown events reordering
Message-ID: <Zv7KHGQx0y3rAGWx@google.com>
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
 <172781650408.2469191.8205759350946908012.b4-ty@kernel.org>
 <CAP-5=fUekHedP74PZU-F_poETt505AVSwVNYWcYNE=1D9P00AQ@mail.gmail.com>
 <Zv3ek7aBkQo0Z9To@google.com>
 <CAP-5=fUjLhGw4SmMTH_H2=1OwRDrY04RL6+C=DdQ=VSgXk8JZg@mail.gmail.com>
 <b0695ef6-8a59-4550-8a33-9afb25c93f48@linux.intel.com>
 <CAP-5=fXutWptEKZKNvLXvXXpuDoMje6PiOxMuF872xoMjtumGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXutWptEKZKNvLXvXXpuDoMje6PiOxMuF872xoMjtumGQ@mail.gmail.com>

On Thu, Oct 03, 2024 at 08:55:22AM -0700, Ian Rogers wrote:
> On Thu, Oct 3, 2024 at 7:57 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >
> >
> >
> > On 2024-10-02 8:57 p.m., Ian Rogers wrote:
> > > On Wed, Oct 2, 2024 at 5:00 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >>
> > >> On Tue, Oct 01, 2024 at 03:32:04PM -0700, Ian Rogers wrote:
> > >>> On Tue, Oct 1, 2024 at 2:02 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >>>>
> > >>>> On Fri, 13 Sep 2024 08:47:06 +0000, Dapeng Mi wrote:
> > >>>>
> > >>>>> Changes:
> > >>>>> v5 -> v6:
> > >>>>>   * no function change.
> > >>>>>   * rebase patchset to latest code of perf-tool-next tree.
> > >>>>>   * Add Kan's reviewed-by tag.
> > >>>>>
> > >>>>> History:
> > >>>>>   v4: https://lore.kernel.org/all/20240816122938.32228-1-dapeng1.mi@linux.intel.com/
> > >>>>>   v3: https://lore.kernel.org/all/20240712170339.185824-1-dapeng1.mi@linux.intel.com/
> > >>>>>   v2: https://lore.kernel.org/all/20240708144204.839486-1-dapeng1.mi@linux.intel.com/
> > >>>>>   v1: https://lore.kernel.org/all/20240702224037.343958-1-dapeng1.mi@linux.intel.com/
> > >>>>>
> > >>>>> [...]
> > >>>>
> > >>>> Applied to perf-tools-next, thanks!
> > >>>
> > >>> I disagreed with an early patch set and the issue wasn't resolved. Specifically:
> > >>>
> > >>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=perf-tools-next&id=3b5edc0421e2598a0ae7f0adcd592017f37e3cdf
> > >>> ```
> > >>>   /* Followed by topdown events. */
> > >>>   if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
> > >>>   return -1;
> > >>> - if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
> > >>> + /*
> > >>> + * Move topdown events forward only when topdown events
> > >>> + * are not in same group with previous event.
> > >>> + */
> > >>> + if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
> > >>> +     lhs->core.leader != rhs->core.leader)
> > >>>   return 1;
> > >>> ```
> > >>> Is a broken comparator as the lhs then rhs behavior varies from the
> > >>> rhs then lhs behavior. The qsort implementation can randomly order the
> > >>> events.
> > >>> Please drop/revert.
> > >>
> > >> Can you please provide an example when it's broken?  I'm not sure how it
> > >> can produce new errors, but it seems to fix a specific problem.  Do you
> > >> have a new test failure after this change?
> > >
> > > It may work with a particular sort routine in a particular library
> > > today, the issue is that if the sort routine were say changed from:
> > >
> > > if (cmp(a, b) < 0)
> > >
> > > to:
> > >
> > > if (cmp(b, a) > 0)
> > >
> > > the sort would vary with this change even though such a change in the
> > > sorting code is a no-op. It is fundamental algorithms that this code
> > > is broken, I'm not going to spend the time finding a list of
> > > instructions and a sort routine to demonstrate this.
> >
> >
> > I'm not sure I fully understand. But just want to mention that the
> > change only impacts the Topdown perf metric group, which is only
> > available for the ICL and later p-core. Nothing will change if no perf
> > metrics topdown events are used. Very limited impact.
> 
> How is breaking every ICL and later Intel model (excluding atoms)
> limited impact?

I guess he meant it's only for Topdown metric groups with an incorrect
order on those models.

> 
> > I like the patch set is because it provides examples and tests to cover
> > the possible combination of the slots event and topdown metrics events.
> > So we will have a clear expectation for different combinations caused by
> > the perf metrics mess.
> 
> Tests are good. I have no problem with the change, possibly it is
> inefficient, except that hacking a sort comparator to not be symmetric
> is broken.

Ok.

> 
> > If the algorithms cannot be changed, can you please give some
> > suggestions, especially for the sample read failure?
> 
> So this is symmetric:
> ```
> if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
>   return -1;
> if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
>   return 1;
> ```
> That is were lhs and rhs swapped then you'd get the expected comparison order.
> ```
> if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs) &&
> lhs->core.leader != rhs->core.leader)
>   return -1;
> if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
> lhs->core.leader != rhs->core.leader)
>   return 1;
> ```
> Is symmetric as well.
> ```
> if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
>   return -1;
> if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
> lhs->core.leader != rhs->core.leader)
>   return 1;
> ```
> (what this patch does) is not symmetric as the group leader impacts
> the greater-than case but not the less-than case.
> 
> It is not uncommon to see in a sort function:
> ```
> if (cmp(a, b) <= 0) {
>   assert(cmp(b,a) >= 0 && "check for unstable/broken compare functions");
> ```

I see.  So are you proposing this?

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index 438e4639fa892304..46884fa17fe658a6 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -70,7 +70,8 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
                if (arch_is_topdown_slots(rhs))
                        return 1;
                /* Followed by topdown events. */
-               if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
+               if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs) &&
+                   lhs->core.leader != rhs->core.leader)
                        return -1;
                /*
                 * Move topdown events forward only when topdown events

Dapeng and Kan, can you verify if it's ok?  My quick tests look ok.


> and we could add this here:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/lib/list_sort.c?h=perf-tools-next#n22
> Try searching up "Comparison method violates its general contract"
> which is what Java throws when its TimSort implementation detects
> cases like this. If you break the comparator you can get the sort into
> an infinite loop - maybe that's enough of an indication that the code
> is broken and you don't need the exception. As is common in kernel
> code we're missing guard rails in list_sort, were the comparator
> passed to qsort then expectations on breakage are a roll of the dice.
> 
> I believe when I originally gave this feedback I didn't think the fix
> was to do it in the comparator and maybe an additional pass over the
> list was going to be necessary. Basically a sort needs to be a sort
> and it can't kind of be a sort depending on the order of the
> comparison, this is just incurring tech debt and when a sort tweak
> happens everything will break. As the usual chump cleaning up this
> tech debt I'd prefer it wasn't introduced.

Sorry, I think I didn't follow the previous thread and missed your
feedback.

> 
> Fwiw, I refuse to carry this change in:
> https://github.com/googleprodkernel/linux-perf/commits/google_tools_master/
> and if the tests break as a consequence then the appropriate thing is
> to revert those too. Linus/upstream maintainers follow a different
> plan and that's their business, I can't build off of this code.
> 
> It is unclear to me why we get patches that have been pointed out to
> be broken rebased/resent repeatedly without the broken-ness corrected.
> For example, the abuse of aggregation for metrics in perf script. At
> least point to the disagreement in the commit message, call me an
> idiot, and let the maintainer make an informed or uninformed choice. I
> am frequently an idiot and I apologize for all those cases, to the
> best of my knowledge this isn't one of them.

Yeah I understand your point and it sounds reasonable.  Thanks for your
feedback.  I don't think I'll revert the change though, we can add the
fix on top instead.

Thanks,
Namhyung

