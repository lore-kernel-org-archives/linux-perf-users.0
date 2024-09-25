Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13181B85D5;
	Wed, 25 Sep 2024 05:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727243411; cv=none; b=nVIEglD1PVOjU2Ie1vmro/t4r5HMN0lIOxHjKXCFzGL7bAu5sPOadtdS+BepYOss1PVU5AJ+RV25vnN7ZwPW+5HEEmbJp8Kr0OjUrEJ+9wp8fdweI3UDmNNveKvnic0afeaV+PoAwZurKRJXWCu6jH9lR/HogKNJG0GqvR9iwS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727243411; c=relaxed/simple;
	bh=rSX1IsaQQ1k0DI/hlmS0BNorx/LQ8UCwbDfk1W3HIzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elqvcaW3SNpFjEQFei/QlsmdBViURlUK8lzWFAC7DtnurQUffGLBq/6aCxt7Spfu4wYYee/EOc4ht/9XLFdYmUTKRqWF80Z8pqmDuUzXua++I+ihMMOK3ljh6/Z/U4oeI+VV244mQ8tGO41HVSXlHSmQpS7WTpH558Zbz3VmKHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8VGAvx8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8VGAvx8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7534C4CEC3;
	Wed, 25 Sep 2024 05:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727243409;
	bh=rSX1IsaQQ1k0DI/hlmS0BNorx/LQ8UCwbDfk1W3HIzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C8VGAvx8n9TqREQtZlcHpBlnJDU4PnkUCZoQYIIvHZBhpREMa15nvascCH/qs+66a
	 dOxxoo68yt4Vzfra6ATom7bgzKMdRHtFiCLpYbi1r348gd2x76O8RdZ6YE55Srjn/W
	 t3mdLs8qQfBgW01PL2l9zHXs+k9AW49jyYnmP958mIvl6X2dXuJYnUgxtFx0lSgdgl
	 55XEKhjl1B50fzdmNF39yo7u8Z+Gn2beldw59Y6vY78cX4WHPlEkj1sBFuoh29+XBP
	 b8E01tJWRJl7ggwaa1Y2Hxl9IEiTFOz6thaEx7ifcmz95DvuYqap+25OsxtfvauQUm
	 0K7QAgT95D5Tg==
Date: Tue, 24 Sep 2024 22:50:07 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf symbol: Set binary_type of dso when loading
Message-ID: <ZvOkj-USs2PRXxsH@google.com>
References: <20240426215139.1271039-1-namhyung@kernel.org>
 <b9a82437-cd4a-5331-47da-b0d1640169d7@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9a82437-cd4a-5331-47da-b0d1640169d7@ispras.ru>

Hello,

On Fri, Sep 20, 2024 at 08:04:00PM +0300, Alexander Monakov wrote:
> Hi,
> 
> On Fri, 26 Apr 2024, Namhyung Kim wrote:
> 
> > For the kernel dso, it sets the binary type of dso when loading the
> > symbol table.  But it seems not to do that for user DSOs.  Actually
> > it sets the symtab type only.  It's not clear why we want to maintain
> > the two separately but it uses the binary type info before getting
> > the disassembly.
> > 
> > Let's use the symtab type as binary type too if it's not set.  I think
> > it's ok to set the binary type when it founds a symsrc whether or not
> > it has actual symbols.
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Any chance this can be applied and propagated to stable? Annotating
> functions outside of the main executable is broken otherwise (regressed
> since 873a83731f1c ("perf annotate: Skip DSOs not found")).
> 
> Tested-by: Alexander Monakov <amonakov@ispras.ru>

Thanks for the test.  For some reason, it doesn't seem to be merged
while patch 2/2 is.  I'll add this with above information.

Thanks,
Namhyung

> 
> > ---
> >  tools/perf/util/symbol.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 7772a4d3e66c..63936269ec15 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1927,6 +1927,9 @@ int dso__load(struct dso *dso, struct map *map)
> >  		if (next_slot) {
> >  			ss_pos++;
> >  
> > +			if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND)
> > +				dso__set_binary_type(dso, symtab_type);
> > +
> >  			if (syms_ss && runtime_ss)
> >  				break;
> >  		} else {
> > 
