Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5033A2F22;
	Wed,  2 Oct 2024 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727906042; cv=none; b=XxoxQ7uQWtti7Df/YwsmFOZT3s7VIxIYxqqfOcto+pBk/IQPpwN/iwyGLkZK0LllNwouNnzulDg9EHJLBpemPocqbw8yNkeU86t0EJ2q3Hjv7/DdfVlMC9P26QE2sg4UShl9iEw5ZIfGKfE80TeJJ+NIJEIh4p/DUbs1abjM/XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727906042; c=relaxed/simple;
	bh=5q+i0gp1vPXmBcyAl+Nx7gfwKW63dEO5S8qHd6zwaCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cm9AdKSkx5HnFVsqjf/7WaKamRho5d9odPNOrrR6RRfg4KSPhf+l/9oaJai6i6g3G+26cqbv0kD16t0CsQC7CTdsvebKp94s42uc4QNO2ZuaB4cReOAsaj6MU30wow9IPMz5Srlh/SgP97e0rAUHpi7ccobBS0cIdg05t3GJdZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCTMAL8q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCTMAL8q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3452AC4CEC2;
	Wed,  2 Oct 2024 21:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727906041;
	bh=5q+i0gp1vPXmBcyAl+Nx7gfwKW63dEO5S8qHd6zwaCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZCTMAL8q6Vaae1ZjYWpoIvyEOOU0PxKiiuPNcCm2yC27elym337EQX0BDzMGEdD5V
	 lBhXaJ4VEsp3LI6d+O5lPoielSMg6I0rp7KMAY3+WRYA+ytFNhSxFxuCUGSeRCGteq
	 VPmkvUgyvcugdkZgbzuXaXZkHbylRunNOiVt56awsvz3JFg45Ld2fLwaNEjCBaZ2lR
	 Emg1Ex7Hqz4dCydt/Q8HinTwiz5VmW5zj6UajA+oSIavMd64IqTsetSxFE00jAcR7h
	 cASAX0vjPfMAnbWY1uR8jiyKu2E122HcKR88OC/pSnBZp9edUD+X99qTMRhmsscRY6
	 t9BGJ8VsOOtQQ==
Date: Wed, 2 Oct 2024 14:53:59 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Hemant Kumar <hemant@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yang Jihong <yangjihong@bytedance.com>, leo.yan@arm.com
Subject: Re: [PATCH v1 2/3] perf probe: Fix libdw memory leak
Message-ID: <Zv3A98bZdlmJ8GaW@google.com>
References: <20240924003720.617258-1-irogers@google.com>
 <20240924003720.617258-3-irogers@google.com>
 <CAM9d7cjDeGF6rO8+DJQdG+tELO2ueqqvkFU-rCFETQm9KJ4JmA@mail.gmail.com>
 <CAP-5=fWgounnfvSQtOiqZQdpkg00yvT3E-rGNFUKKb8ZksPhjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWgounnfvSQtOiqZQdpkg00yvT3E-rGNFUKKb8ZksPhjg@mail.gmail.com>

On Wed, Oct 02, 2024 at 12:08:30PM -0700, Ian Rogers wrote:
> On Wed, Oct 2, 2024 at 10:44 AM Namhyung Kim <namhyung@gmail.com> wrote:
> >
> > On Mon, Sep 23, 2024 at 5:37 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > Add missing dwarf_cfi_end to free memory associated with probe_finder
> > > cfi_eh or cfi_dbg. This addresses leak sanitizer issues seen in:
> > > tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> > >
> > > Fixes: 270bde1e76f4 ("perf probe: Search both .eh_frame and .debug_frame sections for probe location")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/probe-finder.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> > > index 630e16c54ed5..78f34fa0c391 100644
> > > --- a/tools/perf/util/probe-finder.c
> > > +++ b/tools/perf/util/probe-finder.c
> > > @@ -1379,6 +1379,11 @@ int debuginfo__find_trace_events(struct debuginfo *dbg,
> > >         if (ret >= 0 && tf.pf.skip_empty_arg)
> > >                 ret = fill_empty_trace_arg(pev, tf.tevs, tf.ntevs);
> > >
> > > +#if _ELFUTILS_PREREQ(0, 142)
> > > +       dwarf_cfi_end(tf.pf.cfi_eh);
> > > +       dwarf_cfi_end(tf.pf.cfi_dbg);
> > > +#endif
> >
> > This is causing another problem.  Now vfs_getname tests are
> > failing because perf probe aborts.
> 
> I wasn't able to reproduce but largely as the test skips. The variable
> is out of scope after the function so I'm struggling to see what the
> issue is.

I'm seeing this.

  $ sudo ./perf test -v vfs
   91: Add vfs_getname probe to get syscall args filenames:
  --- start ---
  test child forked, pid 3013362
  free(): invalid pointer
  linux/tools/perf/tests/shell/lib/probe_vfs_getname.sh: line 13: 3013380 Aborted                 perf probe -q "vfs_getname=getname_flags:${line} pathname=result->name:string"
  free(): invalid pointer
  linux/tools/perf/tests/shell/lib/probe_vfs_getname.sh: line 13: 3013381 Aborted                 perf probe $add_probe_verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring"
  ---- end(-1) ----
   91: Add vfs_getname probe to get syscall args filenames             : FAILED!
   93: Use vfs_getname probe to get syscall args filenames:
  --- start ---
  test child forked, pid 3013479
  free(): invalid pointer
  linux/tools/perf/tests/shell/lib/probe_vfs_getname.sh: line 13: 3013502 Aborted                 perf probe -q "vfs_getname=getname_flags:${line} pathname=result->name:string"
  free(): invalid pointer
  linux/tools/perf/tests/shell/lib/probe_vfs_getname.sh: line 13: 3013514 Aborted                 perf probe $add_probe_verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring"
  ---- end(-1) ----
   93: Use vfs_getname probe to get syscall args filenames             : FAILED!
  127: Check open filename arg using perf trace + vfs_getname:
  --- start ---
  test child forked, pid 3013528
  free(): invalid pointer
  linux/tools/perf/tests/shell/lib/probe_vfs_getname.sh: line 13: 3013547 Aborted                 perf probe -q "vfs_getname=getname_flags:${line} pathname=result->name:string"
  free(): invalid pointer
  linux/tools/perf/tests/shell/lib/probe_vfs_getname.sh: line 13: 3013548 Aborted                 perf probe $add_probe_verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring"
  ---- end(-1) ----
  127: Check open filename arg using perf trace + vfs_getname          : FAILED!
  
Dropping the series from tmp.perf-tools-next for now.

Thanks,
Namhyung

