Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083A2481250;
	Thu, 13 Aug 2026 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630180; cv=none; b=hxpTebiNtaW3aZIc/hm0gVSNUrqkRbBlG5qOZy37wW66T76IS9MGV98uYDSstb3yvlwezcakmFW5fBxssd22SC/6TwhbRUHsXxrXwcEVg68QDQSL6PKUuRCXCp+PoUmQCLLcTcnmNh64lXKo4LMSfdJb0DBYq0u1X6FzXBvICxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630180; c=relaxed/simple;
	bh=HC0okGR3wepZYPJ8CpLkHOn12dCTgIrIhk9BAd9SJ+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWFDxAaoovDn/BQshZK+IOoYgJjAJl8KxEAeKrhpjoyHgXRYuJgDJ86hjV8JnWz2SRPBxd3y7O9kzNs8UMsX1u4gdYUaSGXla3FcYvBfZzCoRHW/U8W6qwHc1IwhEgyiwqJ3rzEI4UdVswlk0hzWj1ox3sE5bdfbn+f+CXn09NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtbnIR9c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtbnIR9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B806C1F000E9;
	Thu, 13 Aug 2026 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786630178;
	bh=lmnAjFynEBxd/k6luR2UPnuGBHOE3tGKXoYxs21fjiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YtbnIR9cbqenuziJOnglbkSy20cjMPJfWeIWd91HVRNLNVUuoeyWqURo3wlkQZ4Yc
	 UDrXMN6K0KwJ4jZltcgDPMsJ517Hb0iTPiNKOCSGcpOVEJ7pu2+eqD5TbAXvK+erm4
	 8oH6pj1E2sO4btKpPaddTrq/BiTYCFO+bUdghDa6c60XU5FXY6D3Xx3QnriGqzg1uf
	 BfgQbGzyv6oYucyU4IX9v4AaZtw9Obmfud4H08FeZK1gqGs4vM3MU2cZ9glZyhPsu1
	 lZ22tg2dsnnmdwJ7MAINgzH8me1JPgD19IoVU4/ULvRWca9xjoe6M3lPMXwjK/LmFY
	 /F30f2V8PWZVw==
Date: Thu, 13 Aug 2026 11:09:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH 3/5] perf dso: Use stored fd error instead of stale errno
 in file_read() and file_size()
Message-ID: <an3QHqKMwtO8ijw5@x1>
References: <20260811175140.7235-1-acme@kernel.org>
 <20260811175140.7235-4-acme@kernel.org>
 <CAP-5=fX4AC7yPa_6xXoVmAswhUetnvth59mtPpHmX8Qp4bdf5w@mail.gmail.com>
 <an0rMidlKOX1LrgV@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <an0rMidlKOX1LrgV@google.com>

On Thu, Aug 13, 2026 at 11:25:54AM +0900, Namhyung Kim wrote:
> On Wed, Aug 12, 2026 at 04:12:52PM -0700, Ian Rogers wrote:
> > On Tue, Aug 11, 2026 at 10:52 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > >
> > > file_read() and file_size() use ret = -errno when
> > > dso__data(dso)->fd is negative after try_to_open_dso() fails.  By this
> > > point errno has been through mutex_lock(), nsinfo__mountns_enter(), and
> > > multiple open() attempts inside try_to_open_dso() — it no longer
> > > reflects the actual open failure.  If errno happens to be 0, ret = 0
> > > looks like EOF rather than an error, and file_size() callers like
> > > dso__data_size() would then report a zero-sized file instead of
> > > failing.
> > >
> > > dso__data(dso)->fd is always negative on failure — -errno from
> > > __open_dso() when no filename could be built (e.g. -EINVAL, -ENOENT),
> > > or -1 when do_open() itself failed — and never 0, so use it directly
> > > instead of reading the stale global errno.
> > >
> > > Fixes: 33bdedcea2d7 ("perf tools: Protect dso cache fd with a mutex")
> > > Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Assisted-by: Claude:claude-opus-4.6
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > ---
> > >  tools/perf/util/dso.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > > index 124193453675ca18..32ae5c78cdb906e6 100644
> > > --- a/tools/perf/util/dso.c
> > > +++ b/tools/perf/util/dso.c
> > > @@ -1029,7 +1029,8 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
> > >
> > >         if (dso__data(dso)->fd < 0) {
> > >                 dso__data(dso)->status = DSO_DATA_STATUS_ERROR;
> > > -               ret = -errno;
> > > +               /* fd is always negative here: -errno or -1, never 0 */
> > > +               ret = dso__data(dso)->fd;
> > 
> > nit: we can "assert(ret < 0);" to verify the comment.
> 
> It's already checked in the above if statement.  I'm not sure the
> comment or assert is necessary.

You're right, I'm dropping both the comment and the assert, my bad.

- Arnaldo
