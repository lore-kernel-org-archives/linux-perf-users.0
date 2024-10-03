Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8162C63CB;
	Thu,  3 Oct 2024 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727913621; cv=none; b=SSRJLPkZPe3OivzrTAXVory+ek9IO5rRkDipFChBnKh0O3L2qf6qQLFLPIHJqZUw/1bGEE7jeA3ucHcOgrTVHElAG2skW8KOcyWBken5c2zck8Fm+z7QSsOumokW/Ak6wyviT58KBBfgGmg3h/fSewjCAMbiMlGghlv177bnV8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727913621; c=relaxed/simple;
	bh=l7Ai4uJ2WmdodLKKKV1L+UBOHEh6ATojiNTXF/E/Qsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPBmC50fuwlHlziIwPvfeNnHs7xxhe5wl7lL1TIabSqX/hfwNXPr5UXAyh3In147YratAshusr7i/S8bo91ImFVKL1+c3zXXnf+MulZpk/P3lbl9xKagGCM1mPnlm6xAuiBoks3zxrkMkchej/Tch4Cl9CZBf6Ct1bwEr6zQUho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpkpjTHj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpkpjTHj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B876EC4CEC2;
	Thu,  3 Oct 2024 00:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727913621;
	bh=l7Ai4uJ2WmdodLKKKV1L+UBOHEh6ATojiNTXF/E/Qsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CpkpjTHjGn09cl+i3PsQkXgMsrafRA96b/E9vOAJ8IHAccI10r33mawCB/fWEnZeF
	 wwysezURLxkfa2t4Bs0vWePrd3km+RXfIxU2fdr+03Rvvw8Ia8/kI4IlgNtfiKS+do
	 +DH/g5HqTX2ojYaKiKzaZXQA1p4kGSfIQj7Vh3/ZPjHZiwsnx9cwxH5B77rxJzyKot
	 rwnUpf8Eswl9rHQ0fYgkBKg6QiRsBv7MBKCz4xRxLhJGtO6gt3oy3gsu5IkLDLeF1L
	 y6JIYBY6JIBZyqHFPvDC9AIdUlZZwd95ud/yDWkbiEa1ZAYoZUqLj2NBYlj+aDN3M7
	 fFTzhJZ5DichA==
Date: Wed, 2 Oct 2024 17:00:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v5 0/6] Bug fixes on topdown events reordering
Message-ID: <Zv3ek7aBkQo0Z9To@google.com>
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
 <172781650408.2469191.8205759350946908012.b4-ty@kernel.org>
 <CAP-5=fUekHedP74PZU-F_poETt505AVSwVNYWcYNE=1D9P00AQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUekHedP74PZU-F_poETt505AVSwVNYWcYNE=1D9P00AQ@mail.gmail.com>

On Tue, Oct 01, 2024 at 03:32:04PM -0700, Ian Rogers wrote:
> On Tue, Oct 1, 2024 at 2:02 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, 13 Sep 2024 08:47:06 +0000, Dapeng Mi wrote:
> >
> > > Changes:
> > > v5 -> v6:
> > >   * no function change.
> > >   * rebase patchset to latest code of perf-tool-next tree.
> > >   * Add Kan's reviewed-by tag.
> > >
> > > History:
> > >   v4: https://lore.kernel.org/all/20240816122938.32228-1-dapeng1.mi@linux.intel.com/
> > >   v3: https://lore.kernel.org/all/20240712170339.185824-1-dapeng1.mi@linux.intel.com/
> > >   v2: https://lore.kernel.org/all/20240708144204.839486-1-dapeng1.mi@linux.intel.com/
> > >   v1: https://lore.kernel.org/all/20240702224037.343958-1-dapeng1.mi@linux.intel.com/
> > >
> > > [...]
> >
> > Applied to perf-tools-next, thanks!
> 
> I disagreed with an early patch set and the issue wasn't resolved. Specifically:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=perf-tools-next&id=3b5edc0421e2598a0ae7f0adcd592017f37e3cdf
> ```
>   /* Followed by topdown events. */
>   if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
>   return -1;
> - if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
> + /*
> + * Move topdown events forward only when topdown events
> + * are not in same group with previous event.
> + */
> + if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
> +     lhs->core.leader != rhs->core.leader)
>   return 1;
> ```
> Is a broken comparator as the lhs then rhs behavior varies from the
> rhs then lhs behavior. The qsort implementation can randomly order the
> events.
> Please drop/revert.

Can you please provide an example when it's broken?  I'm not sure how it
can produce new errors, but it seems to fix a specific problem.  Do you
have a new test failure after this change?

Thanks,
Namhyung

