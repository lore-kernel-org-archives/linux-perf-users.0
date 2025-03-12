Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A35684;
	Wed, 12 Mar 2025 01:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741744312; cv=none; b=LVZaWwvSaD8pffBay4mUANenH/kiTk8xqkLOkHOLjJLsoCND3cJHs3ncKzChPdDi0MkCLGox6SQgVU5CzV8BgXvjTBmEncq2cu6STYpm8icuLqWGBB3dIWvxRrQp/u1ycedp8Dt6bH6KT4Y53MokmKeE5Np5UaBvEs0HA+NeuFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741744312; c=relaxed/simple;
	bh=vWvE2SvrKfCPdEvgnbBDA9WtH46Jloiipmh4jDXTBTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUNAeMEyhsvTboVAQhpkbFo2aiwl2GjJqmZlvx1Z73OsiA+US3yF6HeXCKkX4F2GkgBwe8KExBI8M8tvkxVu30w3hRDWr/mnDON/Vq09hCxKZErp3jEcABx64at+PKqxx4N8ZHmfhVTWk6r9ba/+oQ+fFwpjVemBLBHybaTZYvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ex7AMCm3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ex7AMCm3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840BDC4CEE9;
	Wed, 12 Mar 2025 01:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741744312;
	bh=vWvE2SvrKfCPdEvgnbBDA9WtH46Jloiipmh4jDXTBTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ex7AMCm3zMNJtLxS4mpgaSYWiv9sZZwVDY2/6SZED0Ak7FPwS9fMPPLEZfuwc5PK8
	 utm0IyaG2dsy0/nny8Aeo1xbsay3n8BkT199hjowTfkvZD9ynA6+pgEQHZ2+zt6vek
	 eWPm+C8hW7pYQMqhjpOx4kHj0fHENY8hMpy7MK3IXa/LBuKvevnKEJXnJhNb8iIfki
	 oT3nP9wo3hZr/8cHJR0TwAdRzTBixI3Z4u6mrktZb+EgtJNbA8unPTtbH1oPbQa7cK
	 aPR+2LuhGEB5tFu6B4fO71To/9unTzB0knwRGEKtna3GdfzbvM1VPamgBGeVU04XZT
	 7FZ85BIZ+Avew==
Date: Tue, 11 Mar 2025 18:51:49 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	James Clark <james.clark@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH v2 06/11] perf python: Add optional cpus and threads
 arguments to parse_events
Message-ID: <Z9DotccYb6WuhKJY@google.com>
References: <20250228222308.626803-1-irogers@google.com>
 <20250228222308.626803-7-irogers@google.com>
 <Z89jxAMEpYea9Qom@google.com>
 <CAP-5=fXniy+Ye=xYdGzr4NKMjh=zQpgZuL=X3Y4DC6ATM5t5Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXniy+Ye=xYdGzr4NKMjh=zQpgZuL=X3Y4DC6ATM5t5Pw@mail.gmail.com>

Hi Ian,

On Mon, Mar 10, 2025 at 05:28:48PM -0700, Ian Rogers wrote:
> On Mon, Mar 10, 2025 at 3:12 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, Feb 28, 2025 at 02:23:03PM -0800, Ian Rogers wrote:
> > > Used for the evlist initialization.
> > >
> > > Reviewed-by: Howard Chu <howardchu95@gmail.com>
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/python.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > > index b600b6379b4e..4a3015e7dc83 100644
> > > --- a/tools/perf/util/python.c
> > > +++ b/tools/perf/util/python.c
> > > @@ -1339,12 +1339,18 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
> > >       struct evlist evlist = {};
> > >       struct parse_events_error err;
> > >       PyObject *result;
> > > +     PyObject *pcpus = NULL, *pthreads = NULL;
> > > +     struct perf_cpu_map *cpus;
> > > +     struct perf_thread_map *threads;
> > >
> > > -     if (!PyArg_ParseTuple(args, "s", &input))
> > > +     if (!PyArg_ParseTuple(args, "s|OO", &input, &pcpus, &pthreads))
> > >               return NULL;
> > >
> > > +     threads = pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
> > > +     cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
> >
> > I wonder if it needs any type checks before accessing them.
> 
> Agreed. We don't do it yet elsewhere:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/python.c?h=perf-tools-next#n769
> although there keywords potentially avoid ambiguity. Given this I
> think improving the typing is follow up work.

Sounds good.

Thanks,
Namhyung

> >
> > > +
> > >       parse_events_error__init(&err);
> > > -     evlist__init(&evlist, NULL, NULL);
> > > +     evlist__init(&evlist, cpus, threads);
> > >       if (parse_events(&evlist, input, &err)) {
> > >               parse_events_error__print(&err, input);
> > >               PyErr_SetFromErrno(PyExc_OSError);
> > > --
> > > 2.48.1.711.g2feabab25a-goog
> > >
