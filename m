Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424E38DD3;
	Sat, 11 May 2024 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715442188; cv=none; b=P8WBgg+ljqDwHmbhPpC7cOHkizefJf6qn7TJtNAoEQZvtPrXnMfs8sg/sG3zmHw9UXWyhl/Ae1eo8hyn2DxYF1xWfD32eAqhekone6kaL5tnJ36MVSOi46wM78tB5DTqO4v7EwnZEDqz1whu0nknoJfQRCzk4xrQwqYy6qngLEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715442188; c=relaxed/simple;
	bh=XXaqHCJAzABGwZ2wMv/Kt7MKG+X9S9a1FPy02FlWTAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbQFjgYd/Ym0rD5vl5ygpNrmbiUruHFWWC5AfVhU1YbE3kh3zO2bQD1/WgX5TTu71RPneL9H1xh1Jtc7q/58/HeuBC25UGjP2xNdghHx8t2mMfyC5p5MiyynhK4+YCZfMyH16Sb/5MJy/ncRCZ9Thu7Pz90FD2GLSZhti5krgOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTQfWTS1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTQfWTS1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E861BC2BBFC;
	Sat, 11 May 2024 15:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715442188;
	bh=XXaqHCJAzABGwZ2wMv/Kt7MKG+X9S9a1FPy02FlWTAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iTQfWTS1WL8RtJn8ViiE9QQ33xfj0QEUahYMpeiAdrn5gN7J6oTZ+1nwHs9jbKXTK
	 Q5Pc0BOLu/E7ybOfETp1byuTaoIbVKEFcHzLKSp0+52U+rPem/VxWy4UAy6/3PlMud
	 TtpDlKrpe7TdxGaJFabq9G37EuC4wvgrJScAU75hoQr1uAfydZqH0Ee/NvR2JU2/i3
	 JUPfRDyM7ZQGj7ZONiUBZgXK9gJwLzVvaw1F73BAN1e8Whq1tV4IxFKHKz3+2Q5tf0
	 cTUf0RwQEvBd/KxmRvAP66rFHmDJqpPj+UUOvnFXyvdD87xsRH+vtyP7jqF0d2y44G
	 lvPFQ9PkgvBCw==
Date: Sat, 11 May 2024 12:43:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf annotate-data: Ensure the number of type
 histograms
Message-ID: <Zj-SCPBJn673kgbr@x1>
References: <CAM9d7ci6Y98hkiN1+=Q=YgLQLL-GN+pTxQ1JjqA+Q1EMEi52+g@mail.gmail.com>
 <20240510210452.2449944-1-namhyung@kernel.org>
 <20240510210452.2449944-2-namhyung@kernel.org>
 <CAP-5=fUBQ=GdeQdB25GNtS_ijRxu42W+uz4p6kuykG-8iC1DdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUBQ=GdeQdB25GNtS_ijRxu42W+uz4p6kuykG-8iC1DdA@mail.gmail.com>

On Fri, May 10, 2024 at 02:27:36PM -0700, Ian Rogers wrote:
> On Fri, May 10, 2024 at 2:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Arnaldo reported that there is a case where nr_histograms and histograms
> > don't agree each other.  It ended up in a segfault trying to access NULL
> > histograms array.  Let's make sure to update the nr_histograms when the
> > histograms array is changed.
> >
> > Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/util/annotate-data.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> > index 57e7d4b3550b..965da6c0b542 100644
> > --- a/tools/perf/util/annotate-data.c
> > +++ b/tools/perf/util/annotate-data.c
> > @@ -1800,7 +1800,6 @@ static int alloc_data_type_histograms(struct annotated_data_type *adt, int nr_en
> >         sz += sizeof(struct type_hist_entry) * adt->self.size;
> >
> >         /* Allocate a table of pointers for each event */
> > -       adt->nr_histograms = nr_entries;
> >         adt->histograms = calloc(nr_entries, sizeof(*adt->histograms));
> >         if (adt->histograms == NULL)
> >                 return -ENOMEM;
> > @@ -1814,6 +1813,8 @@ static int alloc_data_type_histograms(struct annotated_data_type *adt, int nr_en
> >                 if (adt->histograms[i] == NULL)
> >                         goto err;
> >         }
> > +
> > +       adt->nr_histograms = nr_entries;
> >         return 0;
> >
> >  err:
> > @@ -1827,7 +1828,9 @@ static void delete_data_type_histograms(struct annotated_data_type *adt)
> >  {
> >         for (int i = 0; i < adt->nr_histograms; i++)
> >                 zfree(&(adt->histograms[i]));
> > +
> >         zfree(&adt->histograms);
> > +       adt->nr_histograms = 0;
> >  }
> >
> >  void annotated_data_type__tree_delete(struct rb_root *root)
> > --
> > 2.45.0.118.g7fe29c98d7-goog
> >
