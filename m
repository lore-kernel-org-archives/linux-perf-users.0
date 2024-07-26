Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF12524F;
	Fri, 26 Jul 2024 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003176; cv=none; b=hntPudbJ38fHMMtYZvGIeKa3/sbzvFcNpbOC6kYRkNSoEFejXjESuDEZ3Kj++KaNAqyJaFSR+yMBO3K6LJtHA8Ip/rW9kvSkdV0/zzHqxMFQ9BL3BwoEDLba2f7Lc9ODenGj7LoC1dDwN58pOlMCA9mKiYq/eGNJ4SWCKhmkhZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003176; c=relaxed/simple;
	bh=ERz/qr81asuVqF/B2eXTBotFjDZHS/G2DBMv4nvfZRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9ULgPhYP2XIeqec92wqVuOH8igipnA6MhJqIUSPm9kJiMWfVxwbBDmz9+3DJD9QMqy/B14F893nO0lCsbKfbuH1gwzQs339jaO/dMX6VoXA2VuRph33YFmeiC3zyzRNOVuvSvAtVSbc8Nkrnh7gPzzZq1fADZnYjiut6IfyCIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmNAs128; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmNAs128"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D3AC32782;
	Fri, 26 Jul 2024 14:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722003176;
	bh=ERz/qr81asuVqF/B2eXTBotFjDZHS/G2DBMv4nvfZRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pmNAs128jIVnHtdDqakbcoz2zTMia4M2JjmBV3NHWWAXj3mORvWojaV6XMoAStoqj
	 SZpxLqBwBEiV+TxJPN5bTP5HbOGCJI9zIXsLu18igamoAp0zCKs1x9YK5HUIDXv+OU
	 WVrF7CN6JJKzhIUstryIOCO4LaCErvC4nvKmI7clw0MnyjJ2YGJ3WEVUDftM33QqIA
	 tBVWibZB8yb/YF+R3qLYuSuIbja7jqaopFvWVGabLWYAilwDifdnG3zbZjnErS8//p
	 zUgtxQ/WbNBbnbyFP3+O1iHFi1HScDt9JsYihIpusJ16lab6s9gT78Arhx+CxBjoeX
	 aA1TUtSjHTQVg==
Date: Fri, 26 Jul 2024 11:12:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Chen Ni <nichen@iscas.ac.cn>, peterz@infradead.org, mingo@redhat.com,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	nabijaczleweli@nabijaczleweli.xyz, penberg@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf annotate: Convert comma to semicolon
Message-ID: <ZqOu5NNK39IRBBLz@x1>
References: <20240716073405.968801-1-nichen@iscas.ac.cn>
 <CAP-5=fW8pVzHD+AN73Y1WLBSqf9LLHtnwBkuuZ2OLK9sCmv1ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW8pVzHD+AN73Y1WLBSqf9LLHtnwBkuuZ2OLK9sCmv1ww@mail.gmail.com>

On Tue, Jul 16, 2024 at 06:33:15AM -0700, Ian Rogers wrote:
> On Tue, Jul 16, 2024 at 12:35 AM Chen Ni <nichen@iscas.ac.cn> wrote:
> >
> > Replace a comma between expression statements by a semicolon.
> >
> > Fixes: aca7a94d6a59 ("perf tools: Move UI bits to tools/perf/ui directory")

I'm removing this fixes tag to avoid churn on the stable trees, the
referred cset just moves things around, so its not where the harmless
comma was introduced.

Thanks, applied.

- Arnaldo

> > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/ui/browsers/annotate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> > index ea986430241e..fe991a81256b 100644
> > --- a/tools/perf/ui/browsers/annotate.c
> > +++ b/tools/perf/ui/browsers/annotate.c
> > @@ -985,7 +985,7 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
> >
> >         browser.b.width = notes->src->widths.max_line_len;
> >         browser.b.nr_entries = notes->src->nr_entries;
> > -       browser.b.entries = &notes->src->source,
> > +       browser.b.entries = &notes->src->source;
> >         browser.b.width += 18; /* Percentage */
> >
> >         if (annotate_opts.hide_src_code)
> > --
> > 2.25.1
> >
