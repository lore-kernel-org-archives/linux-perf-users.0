Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423083AFAEA;
	Mon, 15 Jun 2026 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553422; cv=none; b=iE9dp6gdj21mm3BJ5u9NOm1UxewYb6i2xm+ZRQJLPdkIMOm6W4BSjsnFkNr6Ap4riYIzSGOn5EB+eqNyHn5Hd2euCJx3ha0RKbbXtxoG60UH1lw/aQNGP4HO3fMalutbiLcT+K2M56ENjwj76XHVWEUmR7s8VhVqReFkE9OKPnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553422; c=relaxed/simple;
	bh=EGq63h4Pj4JSW7yqWoOcZ8lDqRHVi3SV1fjmXyLV224=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiJ5nv0lllu5dOm6w2zuZvkud0Q55SYfzRTxFyBmWMj5Q+culJLAZG/p0be92fQyLL9mmN8vfP9H8K9xhQxwqXFJwf5U8ApkJP8Gsegr6O++EAOq/T8ZaVw/iOX22TiORhTP9DgjMDeg8kLCMyC7QEZilZqOXDiSv22uJzr7lqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHZAn+II; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHZAn+II"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006051F000E9;
	Mon, 15 Jun 2026 19:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553420;
	bh=Er/7fJVBRCoqZ4fh/+ZNTzL5xcesIj+KDk+0u+OCJKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aHZAn+IIB3SUfNfCQTO4Xk1KYassSN4M+xDuNOCAZozE8y8WkpdStgqzWdmv6CmDG
	 IceFToHZkLAPLmgHb8eoF0WnCvrLL//ly8X5dmGZRAttlwxkxZ+Y5rhtv69Q3Ut2GV
	 eW2smn0VxoWbfqTPL1mc6FAfqNqxcncgAOKS5BekTPH+sJueH8ya2fs6Y/7XZ3UTUd
	 npsKbvySxxgFQPKit3tkQVZlsGmbYL2+8PkrcBfTi6F8BlIdMeGrqHw92TX5NWzNwb
	 JjUNIUreHAb1Fvlq4UzJSIBeP44Wzw5VgGB8yNpzm0vXgj2krcwQz2Q7HcZETXE4f2
	 UXdEz449MfRUg==
Date: Mon, 15 Jun 2026 16:56:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: Re: [PATCH 12/13] perf c2c: Free format list entries when releasing
 c2c hist entries
Message-ID: <ajBZCWzSuxNpQLOl@x1>
References: <20260612222413.40791-1-acme@kernel.org>
 <20260612222413.40791-13-acme@kernel.org>
 <CAP-5=fW2SEMgKJkENrz5vmwZNiyv_8T5mMsdcyjfza=OgyMGwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW2SEMgKJkENrz5vmwZNiyv_8T5mMsdcyjfza=OgyMGwg@mail.gmail.com>

On Mon, Jun 15, 2026 at 10:23:45AM -0700, Ian Rogers wrote:
> On Fri, Jun 12, 2026 at 3:25 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > c2c_hists__init() calls hpp_list__parse() which allocates and registers
> > format entries on hists->list.  When c2c_he_free() destroys a c2c hist
> > entry, it deletes the histogram entries and frees the hists container but
> > never unregisters the format list entries, leaking them.
> >
> > Call perf_hpp__reset_output_field() before freeing the hists to properly
> > unregister and free all format entries.
> >
> > Fixes: f485e33c4543ac31 ("perf c2c report: Add cacheline hists processing")
> > Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/finding/41
> 
> I don't think these are public "Closes:" links and should probably be stripped.

Yeap, will remove and add a memory for this not to be added again,
better to make sure that whatever is added _is_ accessible, this one
isn't :-\

- Arnaldo
 
> Thanks,
> Ian
> 
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/builtin-c2c.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index e205f58b2f3d3786..07c7e8fb315e6cf3 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -185,6 +185,7 @@ static void c2c_he_free(void *he)
> >         c2c_he = container_of(he, struct c2c_hist_entry, he);
> >         if (c2c_he->hists) {
> >                 hists__delete_entries(&c2c_he->hists->hists);
> > +               perf_hpp__reset_output_field(&c2c_he->hists->list);
> >                 zfree(&c2c_he->hists);
> >         }
> >
> > --
> > 2.54.0
> >
