Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652EB1E25FD;
	Tue,  5 Nov 2024 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730836370; cv=none; b=eDOJbyVjm4SxjmV0AkwSmvnbnAAK5n9nRO+/GHFMuWQq8MWZm6+lKsK2q8/1QtBLa8d98uo3J4JexPFS9xarGfAhn1G2ZzzK1yHVpvF7aOrUOKdT/O+zfR9zeoBVWyFgWBGMCnp/HekfCMDcvvNiTojy6fxO7C2LlGyi1rMcBLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730836370; c=relaxed/simple;
	bh=ifdrJqfK1N4E0OCQaVRQ91URLptDkX6eScHJuwPFLLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiN0om2uSovi6wUAngGioWdMY5BamgNmYn4dPb/yD7kaXxFOFyTVDNa8MkMFQXnnqsL5mrLXGepby69c7bj/+aMpoYxxnevZrhdNCp7EsCRIQAdsyO+0ui4zBtk1iXsmrgxC36jwooPxRldrJfV4h7rCIY2fcGF+rh/wf684ye8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iItkjvTu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iItkjvTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AEFC4CECF;
	Tue,  5 Nov 2024 19:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730836369;
	bh=ifdrJqfK1N4E0OCQaVRQ91URLptDkX6eScHJuwPFLLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iItkjvTufXsEKLa2SL9674Ih7Q0fed8Tc1jTBBuFbwZPajk+JJ2IJB1pLwobyFj21
	 DH0/7X3FsDP0WXwRKSIS2CQhSqSzslM5z8qU0bYbfqwgUfz/TPV25q7W5OlM8QSp44
	 g7or9dcp15LVyTK2FYqReezpSSoz/0c1v1pidolBfEqcRJ5M0iKyhwKYQSaVG/454i
	 PRb0eTdTqDFYhJsF08+28+nP4mqqyXI+U8fzog9BIeHGmV/GQZ6Jf+uenHsnGhY3ES
	 BdYyYeAxh2K04fDefkYddsEYmmDIktsxUjgRlYdVzRWJJOmL9TJSfwPUIwjStJ+7JI
	 thYtQ0kkqVNRw==
Date: Tue, 5 Nov 2024 16:52:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	James Clark <james.clark@linaro.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>,
	Ben Gainey <ben.gainey@arm.com>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>,
	Paran Lee <p4ranlee@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: [PATCH v2 4/6] perf evsel: Add/use accessor for tp_format
Message-ID: <Zyp3jeLz4ympxfHv@x1>
References: <20241102165400.75785-1-irogers@google.com>
 <20241102165400.75785-5-irogers@google.com>
 <ZypXmtlqQUxABhMI@x1>
 <CAP-5=fUNR_t8R33enM1WHzR1-ZzZMUDM1hTLohPdefbKfhMSXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUNR_t8R33enM1WHzR1-ZzZMUDM1hTLohPdefbKfhMSXA@mail.gmail.com>

On Tue, Nov 05, 2024 at 11:33:09AM -0800, Ian Rogers wrote:
> On Tue, Nov 5, 2024 at 9:36 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Sat, Nov 02, 2024 at 09:53:58AM -0700, Ian Rogers wrote:
> > > Add an accessor function for tp_format. Rather than search+replace
> > > uses try to use a variable and reuse it. Add additional NULL checks
> > > when accessing/using the value. Make sure the PTR_ERR is nulled out on
> > > error path in evsel__newtp_idx.

> > > Signed-off-by: Ian Rogers <irogers@google.com>

> > > +++ b/tools/perf/builtin-kmem.c
> > > @@ -772,8 +773,9 @@ static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
> > >       }
> > >
> > >       trace_seq_init(&seq);
> > > -     tep_print_event(evsel->tp_format->tep,
> > > -                     &seq, &record, "%s", TEP_PRINT_INFO);
> > > +     tp_format = evsel__tp_format(evsel);
> > > +     if (tp_format)
> > > +             tep_print_event(tp_format->tep, &seq, &record, "%s", TEP_PRINT_INFO);
> > >
> > >       str = strtok_r(seq.buffer, " ", &pos);
> > >       while (str) {
> > > @@ -2011,14 +2013,15 @@ int cmd_kmem(int argc, const char **argv)
> > >       }
> > >
> > >       if (kmem_page) {
> > > -             struct evsel *evsel = evlist__find_tracepoint_by_name(session->evlist, "kmem:mm_page_alloc");
> > > +             struct evsel *evsel = evlist__find_tracepoint_by_name(session->evlist,
> > > +                                                                   "kmem:mm_page_alloc");
> >
> > Try to avoid these reflows to reduce patch size, please.
> 
> Agreed, in this case check `checkpatch.pl` is complaining that the
> line length is 109 columns.

Ok, but it was like that before, your patch is not touching that line
for some other reason, so it is unrelated to what you're doing, causing
a distraction.

Besides, even the documentation for checkpatch mentions that that is:

  **LONG_LINE**
    The line has exceeded the specified maximum length.
    To use a different maximum line length, the --max-line-length=n option
    may be added while invoking checkpatch.

    Earlier, the default line length was 80 columns.  Commit bdc48fa11e46
    ("checkpatch/coding-style: deprecate 80-column warning") increased the
    limit to 100 columns.  This is not a hard limit either and it's
    preferable to stay within 80 columns whenever possible.

    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#breaking-long-lines-and-strings

----------------

So if it was there already, meaning the original author preferred it
that way, its not touched by the feature that is being worked on in this
patch, ends up being an extra hunk, just reflowing, a distraction.
 
- Arnaldo
