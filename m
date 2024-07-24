Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8ED4A18;
	Wed, 24 Jul 2024 20:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852579; cv=none; b=DC5TcOIQyRxIoQqckBmABGKFXxkGtmYx6hrnBw8cCNyv+V4L7VD+T/VPxOHo4tmqW30ThPryf5Bh7EppNk71Rjvc+yyd6AO1gaLq89S4o5T4eqKu+3pMo8Fm0jevGilbMeQOMdNGJG0LwSUMu3Ym17NmZLoAYYWufrmCAwlylFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852579; c=relaxed/simple;
	bh=FpdXAx8fnVheo2SgIF7cq/dlDHbFSYnXKIQW9k7HT8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcVXNC942qrg+PnJZFUsJ5mH22fcJr3c4k24Emz7OfgJr/06xtsZxIEB2PVnSHtS+BSqacbV8g+QceMLgc8c7DFuVkc2EW7ZDGMGifZqP0r0mpi4JeXNCf4lbY/8Yjz1m+BBvRfGmnOmGEuvDOyVHp9KljS1WpekUfRJPaXuXfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML9qYX6L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML9qYX6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E826EC32781;
	Wed, 24 Jul 2024 20:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721852579;
	bh=FpdXAx8fnVheo2SgIF7cq/dlDHbFSYnXKIQW9k7HT8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ML9qYX6LpPNVPL9m2a/dyy/crw+8wxBNI4phYtQCBWnErcq5Y9+n2KAiGyQ+HqhV+
	 ICdiDUjflAhV8l4Re24I5SRJO+U56iTKA6Gk8pGBhpVMvsCFhaRCcCGmOHc+ZPOwsu
	 X87viR/VFR2/5bIXSDfVxC1huJSFsWvKBD2qlkuEVfx7FEgs921JiGSD2qzCmE3NM/
	 fuwWB306PlkJbudA1uP+OQMPau6JLJ7BbdqzvPBnL/mizRYZEDeJwKtc4J/4iOFtbU
	 BUpkpW/TRCAVxw92vzsusXQGochMGWYF9wA+DYY28GksU7T9FWbyB3G+zjrSuZuoxH
	 wIKRoGVp5cpbQ==
Date: Wed, 24 Jul 2024 13:22:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Casey Chen <cachen@purestorage.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com, yzhong@purestorage.com
Subject: Re: [PATCHv5] perf tool: fix dereferencing NULL al->maps
Message-ID: <ZqFiodizE7xq5SV-@google.com>
References: <20240722211548.61455-1-cachen@purestorage.com>
 <CALCePG0GtG4DQwzJ-QCJRScfxVg3Up6Xeemxh48qSf2VjxjebA@mail.gmail.com>
 <CAM9d7cj20KdEtg8v93+bt+ZmpTzin=N3DfAX3K8ELHLkccoeqQ@mail.gmail.com>
 <CALCePG3sqCCJyRaUOiE0TqDCGmOdw7B38hBzs9PvF5EgPjU8EA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCePG3sqCCJyRaUOiE0TqDCGmOdw7B38hBzs9PvF5EgPjU8EA@mail.gmail.com>

On Wed, Jul 24, 2024 at 11:51:44AM -0700, Casey Chen wrote:
> On Wed, Jul 24, 2024 at 9:19 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Tue, Jul 23, 2024 at 6:01 PM Casey Chen <cachen@purestorage.com> wrote:
> > >
> > > Ian / Namhyung,
> > >
> > > Could you take a look at the latest diff PATCHv5 ?
> > >
> > > Thanks,
> > > Casey
> > >
> > > On Mon, Jul 22, 2024 at 2:15 PM Casey Chen <cachen@purestorage.com> wrote:
> > > >
> > > > With 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions"),
> > > > when cpumode is 3 (macro PERF_RECORD_MISC_HYPERVISOR),
> > > > thread__find_map() could return with al->maps being NULL.
> > > >
> > > > The path below could add a callchain_cursor_node with NULL ms.maps.
> > > >
> > > > add_callchain_ip()
> > > >   thread__find_symbol(.., &al)
> > > >     thread__find_map(.., &al)   // al->maps becomes NULL
> > > >   ms.maps = maps__get(al.maps)
> > > >   callchain_cursor_append(..., &ms, ...)
> > > >     node->ms.maps = maps__get(ms->maps)
> > > >
> > > > Then the path below would dereference NULL maps and get segfault.
> > > >
> > > > fill_callchain_info()
> > > >   maps__machine(node->ms.maps);
> > > >
> > > > Fix it by checking if maps is NULL in fill_callchain_info().
> > > >
> > > > Signed-off-by: Casey Chen <cachen@purestorage.com>
> > > > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Thanks,
> > Namhyung
> >
> >
> > > > ---
> > > >  tools/perf/util/callchain.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> > > > index 1730b852a947..6d075648d2cc 100644
> > > > --- a/tools/perf/util/callchain.c
> > > > +++ b/tools/perf/util/callchain.c
> > > > @@ -1141,7 +1141,7 @@ int hist_entry__append_callchain(struct hist_entry *he, struct perf_sample *samp
> > > >  int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *node,
> > > >                         bool hide_unresolved)
> > > >  {
> > > > -       struct machine *machine = maps__machine(node->ms.maps);
> > > > +       struct machine *machine = node->ms.maps ? maps__machine(node->ms.maps) : NULL;
> > > >
> > > >         maps__put(al->maps);
> > > >         al->maps = maps__get(node->ms.maps);
> > > > --
> > > > 2.45.2
> > > >
> 
> Thanks Namhyung.
> I have another question. When will this patch get merged into master
> branch or 6.6 release line ? Our benchmark systems depend on this fix
> to do performance analysis. Currently, both our kernel and perf are on
> 6.6.9 and they build separately. We want to update perf hash without
> patching it locally.

I'll route it to v6.11 through perf-tools tree.  Hopefully it'd get
backported to stable kernels later.

Thanks,
Namhyung

