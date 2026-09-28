Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A134E533C
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613013; cv=none; b=r3Y9n5hQxxW8EGSLkiFuuBsEKdZPXzXTYhieV8n7HCUtflb+zoBaqDMrB/vXY28vB/dWlCEVAedrhoQawa2QcA/dE6Rb5an3QZLwQXQ19c2SN9JKia0ONEs0pHYWPeEstzDvgvXK/lVjmHIzTYh+VEh+r8Oz3WcELL8fq0xOjIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613013; c=relaxed/simple;
	bh=pZfQSV0dII+LulZi7+cLEmnKE22EpyMsnx0KJfhcGuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/S+qfUR8gUsYBh+qKhD3/psp6rDb70k97bdNTy8875+i58GCLOCqEOnpbiaio/Hdq5uq7KrOQ3aLmCDeaPTE5bjmzwRVZY/LxAI4px0AFX6Yp4BcpFeywCbadti7lsYCXxBkXcZJQNK+1px1Y7hMG05DLQvCXI9+7PnGMREIgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBBc0LtF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBBc0LtF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D6D1F000FF;
	Mon, 28 Sep 2026 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613012;
	bh=xtDOXsU1zTtECBxkpjkUqcBlML0KLbjw2mLIrOfspWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dBBc0LtFxT6/0clK11YoSmTwvkJRSe2is9un6xKv/sSnUr/AqgLjHM6BETnoxiPXU
	 CGOXoi/+GbA2nco2A53iyqItzRmZVvaeHTdJgKj29eDz3CntcAO+OrvMBvB0jE3Dgw
	 tLRMkkiXDg0X0WGvysxp2v95pk7YZZcPfayNgqn5RgK8uTHzKbzeSkZ/iTKbRn8Y68
	 3J444MneRklSaaA6+ZAbhe+qG3Bj8FDXt5vj5NH2rVsIQcq0EeLmVuhB6BG23+tS4D
	 IG7eF+wRzOQmrD+lTxodOxri7zF7F4HRdjw7y3uOC5omwGlUGhvn4qIJWbA7RLjB07
	 2K9G+14vXcz8A==
Date: Mon, 28 Sep 2026 18:30:09 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] tools feature gettid: Undef _GNU_SOURCE before
 defining it
Message-ID: <arqWEZef5mdrc6vO@x2>
References: <arpXYeRUu3B-ouqB@x2>
 <CAP-5=fUyYuheX6jC=+WOYw4kM3Ak0S1SFk45QgCXhgy23V+F3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUyYuheX6jC=+WOYw4kM3Ak0S1SFk45QgCXhgy23V+F3g@mail.gmail.com>

On Mon, Sep 28, 2026 at 08:12:45AM -0700, Ian Rogers wrote:
> On Mon, Sep 28, 2026 at 5:02 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Since most of tools/build/feature/test-*.c feature tests are included in
> > tools/build/feature/test-all.c, we can't just define _GNU_SOURCE as it
> > may already been defined and this will break the build with:
> >
> >   acme@alta:~$ cat /tmp/build/perf-tools-next/feature/test-all.make.output
> >   In file included from test-all.c:26:
> >   test-gettid.c:3:9: error: "_GNU_SOURCE" redefined [-Werror]
> >       3 | #define _GNU_SOURCE
> >         |         ^~~~~~~~~~~
> >   In file included from /usr/include/python3.13/pyconfig.h:9,
> >                    from /usr/include/python3.13/Python.h:14,
> >                    from test-python-module.c:2,
> >                    from test-all.c:14:
> >   /usr/include/aarch64-linux-gnu/python3.13/pyconfig.h:1810:10: note: this is the location of the previous definition
> >    1810 | # define _GNU_SOURCE 1
> >         |          ^~~~~~~~~~~
> >   cc1: all warnings being treated as errors
> >   acme@alta:~$
> >
> > I.e. pyconfig.h is included by the new test-python-module.c, that is at
> > the start of test-all.c, defines _GNU_SOURCE, noticed on Debian 13
> > (/usr/include/aarch64-linux-gnu/python3.13/pyconfig.h, libpython
> > 3.13.5-2+deb13u5), and then test-all.c includes test-gettid.c that was
> > defining it as well, undef it first as does several other tests.
> >
> > Fixes: 1b7e0280e247b93d ("perf Makefile: Update Python script installation path")
> > Cc: Ian Rogers <irogers@google.com>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
