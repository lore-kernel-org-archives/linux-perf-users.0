Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA784A7CA7;
	Thu, 15 Oct 2026 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061914; cv=none; b=GPD4e+ZCRKhpayaLBmdUDsYo34QPp5nPUIrZJswnTFavP3PJZfGj1BpD74W0dt8DXsD4+89hEVd2BJ8SGQk8fNbJ8TCqFHCb+Cm+lIhtRd4+hLs8gIuYlpeYe0z1ViX7bA3cQz56zFUl+IfhvyT3TXWwXGvMCSGITiADV3QxG9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061914; c=relaxed/simple;
	bh=YscGmbcN3nNKIyT1JAHk3lBrqqw/zMhCCrWmt7pyH7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXJwp6Kmsq2s1rHjcD94OC4++P1mbcGyxQwq8dXqPj5SILgBpzoAbI81pia+xbOw1vMYviiIyPK1i6Dz1jzz8W6vFZPWdY9ehq4KiJwapFY2rZ0dJs7tzOqFwfOdm0BXWzdlG517uGVXFG0/5KnMRIUHFomjT3SiE0Rm7cPxOvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4Mki8A7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4Mki8A7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BDB1F000C4;
	Thu, 15 Oct 2026 10:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792061913;
	bh=525X9fRw3wVF943fAkOiBymkjHE2iaJQ8GGeeoS6trg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J4Mki8A7cHla3ZIiYgF8fE5u9sHRkT45HlWip9lnGlgNnn4wVTMun8me0jvJSt3Gm
	 cmMhdnHnhLxG8Hp+kbf6qD2N/xQhjoGcoCXYMVjkqPVIovCoZSmtnh9FMpxPguw82D
	 cJIwae6Y8UpMTjIIOjTSCM+4Etqh7x2Ntt0lA9UzUhwtLJijvutQgn1TO5Qd/zaC3j
	 wZiHn98w0KxgKp207XFG39bB3wZg385C2LTtbC/zheueFurs2AK4LTea7ZXwZZlxmJ
	 XEHr1kHcvCS6II70lFvB7x3iXJzc/BWT1YWLg/0GWVJxK7C3Ddk64jWTcGKVBy9Wwy
	 HVTW4tBN5CmyA==
Date: Thu, 15 Oct 2026 07:58:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 1/4] perf symbol: Fix symbol loading from libbfd
Message-ID: <atCx1cPi4g0hpxRi@x2>
References: <20261012235938.87912-1-namhyung@kernel.org>
 <as557LTNwiigXk0O@x2>
 <as6cV-cm6dgTtzet@google.com>
 <as__f7LjG4GckkBj@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <as__f7LjG4GckkBj@x2>

On Wed, Oct 14, 2026 at 07:17:39PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Oct 13, 2026 at 02:02:15PM -0700, Namhyung Kim wrote:
> > On Tue, Oct 13, 2026 at 03:35:24PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Mon, Oct 12, 2026 at 04:59:34PM -0700, Namhyung Kim wrote:
> > > > The dso__load() should return a positive number (number of symbols
> > > > loaded) when it succeded to load symbols.  But dso__load_bfd_symbols()
> > > > only returns 0 and it's hard to check if it actually loaded symbols or
> > > > not.  Let's return the value of dso__has_symbol() and check it in
> > > > dso__load() so that it can return 1 for success.
> > > > 
> > > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > > Closes: https://lore.kernel.org/r/sashiko-outbox-162540@kernel.org
> > > > Fixes: eac9a4342e5447cad ("perf symbols: Try reading the symbol table with libbfd")
> > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > 
> > > Thanks, applied to perf-tools-next, for v7.4.
> > 
> > Thanks Arnaldo!
> > 
> > As you may know, this is from my other series on cleaning up symtab and
> > binary types.  I'd like to land it as well so that I can continue
> > working on the related issues.  There are some Sashiko feedback left,
> > but I think they are either pre-existing bugs or known issues.
> 
> Right, its now at tmp.perf-tools-next, while I test build in my
> container set, will push it to perf-tools-next next.

Building it with CC=clang I get:

  LD      /tmp/build/perf-tools-next/tests/perf-test-in.o
util/dso.c:942:7: error: mutex '_dso__data_open_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
  942 |                 if (dso__data_open_cnt) {
      |                     ^
util/dso.c:940:4: note: mutex acquired here
  940 |                         mutex_lock(dso__data_open_lock());
      |                         ^
util/dso.c:942:7: error: reading variable 'dso__data_open_cnt' requires holding mutex '_dso__data_open_lock'   CC      /tmp/build/perf-tools-next/util/maps.o
[-Werror,-Wthread-safety-analysis]
  942 |                 if (dso__data_open_cnt) {
      |                     ^
util/dso.c:943:4: error: calling function 'close_first_dso' requires holding mutex '_dso__data_open_lock' exclusively [-Werror,-Wthread-safety-analysis]
  943 |                         close_first_dso();
      |                         ^
util/dso.c:949:3: error: releasing mutex '_dso__data_open_lock' that was not held [-Werror,-Wthread-safety-analysis]
  949 |                 mutex_unlock(dso__data_open_lock());
      |                 ^
4 errors generated.
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:95: /tmp/build/perf-tools-next/util/dso.o] Error 1
  CC      /tmp/build/perf-tools-next/util/thread.o

Bisected to:

⬢ [acme@tb-phoenix2-perf perf-tools-next]$ git bisect good
3759ca226d57d06c4c52a1e64890faf58a29ebf1 is the first 'bad' commit
commit 3759ca226d57d06c4c52a1e64890faf58a29ebf1
Author: Namhyung Kim <namhyung@kernel.org>
Date:   Tue Oct 13 10:21:51 2026 -0700

    perf tools: Factor out dso__find_binary_type()

    Separate out the logic to detect binary type of a DSO.  It checks if
    the candidate file contains ".text" section.  There could be data-only
    DSOs but as our use cases focus on the code (perf annotate or intel
    PT), we can ignore them for now.

    But it also can fail due to open file limit.  Handle the case by
    retrying with _dso__data_open_lock.

    Introduce bintype_searched flag and it accessors to prevent repeated
    (failed) search.

    Reviewed-by: Ian Rogers <irogers@google.com>
    Signed-off-by: Namhyung Kim <namhyung@kernel.org>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

 tools/perf/util/dso.c | 138 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 tools/perf/util/dso.h |  13 +++++++++++++
 2 files changed, 139 insertions(+), 12 deletions(-)
⬢ [acme@tb-phoenix2-perf perf-tools-next]$
