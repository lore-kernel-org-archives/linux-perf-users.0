Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BEEB672;
	Tue, 13 May 2025 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747166696; cv=none; b=HfHR4CcBR1VGrB0mVRjYaVE33XPG8Dx9mGVZD/P7hMxRiIQgAVv/3F15spM8sV2ABWpigYqbdNAN06gnWxOc8KCmth2V9gzfNkm/otH1XKJXav4J63BBiaEvGOcKGd7NygNqDIwVDdxGU8h0CQqOvkPYydXFegipTnkfcUwCfvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747166696; c=relaxed/simple;
	bh=PbvXWPEHj3CJ720Vc2P5668xM5C4UMcH106vpWhJdIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPxY4fUmE0WLhv+9cCO+hbmITZiQ5O5Wsx3EmTcujMKkZCX6xWiXWeOQ1YleOgv5AAcRpB0a7FMOF2lhnZOIBCAlNvCjWbtkTtQdpL519l5RTgmOriel4gLg8XKOvz4aj47anATfUgQk67UJxbKdRlnXNT04hBQFZKcOlcVku3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fST1datj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fST1datj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3DDC4CEE4;
	Tue, 13 May 2025 20:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747166696;
	bh=PbvXWPEHj3CJ720Vc2P5668xM5C4UMcH106vpWhJdIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fST1datjKg6boceRGwpnD5lzzNrwsRTMyG3F6SNepRehdFyWd+nTdPBAg56AlEgPE
	 Q7YnDOO/kK5OluHdL78Sum3aZZT/jScC5iMG/pcFEJVC31VC3D+lP0YhwyPblkTqRZ
	 Xmp5idAQ3Jd0dYCXoSKTXKZOp12BeoPYScia1OQLJBeruXC0W0/ZIu54WanegiB5yh
	 7sdb8LyIwSTIhniZQ0yyxlhvLBQaD/Wb0b5fdHt0Pn7l0W+jpqtD1mgY41GzqkmhHy
	 7VDRzeLcjXr9mnjC4YXlWbIgOFz+5loxPmweq5ls2Lgl/dvGC15OrF/DwC4ab0mNeu
	 2A9pIANCvrMfw==
Date: Tue, 13 May 2025 17:04:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@linaro.org,
	howardchu95@gmail.com, weilin.wang@intel.com, yeoreum.yun@arm.com,
	linux@treblig.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Fix incorrect counts when count the same uncore
 event multiple times
Message-ID: <aCOl5ep67uTeGVmm@x1>
References: <20250512215929.2098240-1-ctshao@google.com>
 <aCOlViKRwS0kE0tg@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aCOlViKRwS0kE0tg@x1>

On Tue, May 13, 2025 at 05:02:33PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, May 12, 2025 at 02:50:29PM -0700, Chun-Tse Shao wrote:
> > Let's take a look an example, the machine is SKX with 6 IMC devices.
> > 
> >   perf stat -e clockticks,clockticks -I 1000
> >   #           time             counts unit events
> >        1.001127430      6,901,503,174      uncore_imc_0/clockticks/
> >        1.001127430      3,940,896,301      uncore_imc_0/clockticks/
> >        2.002649722        988,376,876      uncore_imc_0/clockticks/
> >        2.002649722        988,376,141      uncore_imc_0/clockticks/
> >        3.004071319      1,000,292,675      uncore_imc_0/clockticks/
> >        3.004071319      1,000,294,160      uncore_imc_0/clockticks/
> > 
> > 1) The events name should not be uniquified.
> > 2) The initial count for the first `clockticks` is doubled.
> > 3) Subsequent count only report for the first IMC device.
> > 
> > The first patch fixes 1) and 3), and the second patch fixes 2).
> 
> So, after having just the first patch applied I'm getting:
> 
>   CC      /tmp/build/perf-tools-next/util/bpf-filter-flex.o
> util/parse-events.c: In function ‘__parse_events’:
> util/parse-events.c:2270:25: error: implicit declaration of function ‘evlist__uniquify_name’; did you mean ‘evlist__uniquify_evsel_names’? [-Wimplicit-function-declaration]
>  2270 |                         evlist__uniquify_name(evlist);
>       |                         ^~~~~~~~~~~~~~~~~~~~~
>       |                         evlist__uniquify_evsel_names
> make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:85: /tmp/build/perf-tools-next/util/parse-events.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:142: util] Error 2
> make[2]: *** [Makefile.perf:798: /tmp/build/perf-tools-next/perf-util-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
> 
> 
>   CC      /tmp/build/perf-tools-next/pmu-events/pmu-events.o
>   LD      /tmp/build/perf-tools-next/pmu-events/pmu-events-in.o
> make[1]: *** [Makefile.perf:290: sub-make] Error 2
> make: *** [Makefile:119: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> ⬢ [acme@toolbx perf-tools-next]$ 
> ⬢ [acme@toolbx perf-tools-next]$ 
> ⬢ [acme@toolbx perf-tools-next]$ 
> ⬢ [acme@toolbx perf-tools-next]$ 
> ⬢ [acme@toolbx perf-tools-next]$ 
> ⬢ [acme@toolbx perf-tools-next]$ 
> ⬢ [acme@toolbx perf-tools-next]$ 
> ⬢ [acme@toolbx perf-tools-next]$ git log --oneline -3
> 6ffcaec3ac0d055a (HEAD) perf evlist: Make uniquifying counter names consistent
> 4102ff8b1fdaa588 perf metricgroup: Binary search when resolving referred to metrics
> 754baf426e099fbf perf pmu: Change aliases from list to hashmap
> ⬢ [acme@toolbx perf-tools-next]$
> 
> When test building the second patch, it builds, so I'm now looking if
> you used things from the future or if the second patch removes the
> problem.

At that point:

util/parse-events.c: In function ‘__parse_events’:
util/parse-events.c:2270:25: error: implicit declaration of function ‘evlist__uniquify_name’; did you mean ‘evlist__uniquify_evsel_names’? [-Wimplicit-function-declaration]
 2270 |                         evlist__uniquify_name(evlist);
      |                         ^~~~~~~~~~~~~~~~~~~~~
      |                         evlist__uniquify_evsel_names
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:85: /tmp/build/perf-tools-next/util/parse-events.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  LD      /tmp/build/perf-tools-next/util/scripting-engines/perf-util-in.o
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:142: util] Error 2
make[2]: *** [Makefile.perf:798: /tmp/build/perf-tools-next/perf-util-in.o] Error 2
make[1]: *** [Makefile.perf:290: sub-make] Error 2
make: *** [Makefile:119: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
⬢ [acme@toolbx perf-tools-next]$ 
⬢ [acme@toolbx perf-tools-next]$ git grep evlist__uniquify_name
tools/perf/util/parse-events.c:                 evlist__uniquify_name(evlist);
⬢ [acme@toolbx perf-tools-next]$

So its the later, the second patch builds because:

⬢ [acme@toolbx perf-tools-next]$ git rebase --continue
Stopped at ed3b26e31f42d1e4...  perf parse-events: Use wildcard processing to set an event to merge into
You can amend the commit now, with

  git commit --amend 

Once you are satisfied with your changes, run

  git rebase --continue
⬢ [acme@toolbx perf-tools-next]$ git grep evlist__uniquify_name
⬢ [acme@toolbx perf-tools-next]$ git show | grep evlist__uniquify_name
-			evlist__uniquify_name(evlist);
⬢ [acme@toolbx perf-tools-next]$

That function isn't there anymore.

Please try to fix this and build it patch by patch so that we don't
introduce bisection breakage patches.

Thanks,

- Arnaldo
