Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AB4146A79
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2024 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729722805; cv=none; b=cmzBVI+FbLfqQMkr3edaeh8Kjhu9K4HueOdYHZ9pe+FAsjujlSSQWbedx+Spw5BwAgCFqJu0hgDktLg8I+F1wn/dX3cWnVo+gi1BYK145pKoZJpsycnDtHj4A/N47+n9y95Huu3r0t35ae76gZCuEVlwU2qpzsqyhpNiLTc+Kmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729722805; c=relaxed/simple;
	bh=Dqovx8Hgn9XiZatcu0kS6TB8KZgVuU8loZies80qeiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ao7cwvdxn4p9Bho4E7NEeDo1tTgoNJzvKGI2LAVeZjSBRSBVYOc/LclLuWhTg/hW67mnTuEzWye1JLGn1v5BqKe8O0lE9yp5UjJN5Kosng7VUMrhrn3xUR1/K38hjoJPe0tnnmt0B2TSyjmWZzzRiuNfX1C9D7FfokKcwEHCcD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekgZnK6t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekgZnK6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50908C4CEC6;
	Wed, 23 Oct 2024 22:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729722804;
	bh=Dqovx8Hgn9XiZatcu0kS6TB8KZgVuU8loZies80qeiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ekgZnK6tAO6U4eJHgloT4X0nVq7tL0sPZ8oDgqVnMUieA+jDb7/S7gbilRvR9Yi02
	 nW3rumxBG61TI8jEZoyn4w8T4Y4+JolONuDseyZ7qO/r+GvFvhLS4JCmLZnU6Nr13B
	 nA6eo7NBIdwJalIMMJk0Oh4YTMdjmb98T41qg4hYNgvY1lhh8Vs9YlCo9aYDE2Shfv
	 DfZ4o/9qg4rY3hB29zzNAzfPiul89V56XmcbuNzoDS2DsL+A4r+8ex6683KraaRmK9
	 eO5FQgSpOWfNS3C8cBgOkKy8cdMTlIMCUnaEDnZEcmLDz7Vx8veqNWAUdnJyHNdD6h
	 nklDC/0Vhdmzg==
Date: Wed, 23 Oct 2024 19:33:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Yunseong Kim <yskelg@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Subject: Re: Migrating from perf.wiki.kernel.org to RTD
Message-ID: <Zxl5sduEDnoxEmd2@x1>
References: <20241011-quiet-chowchow-of-temperance-d0e205@meerkat>
 <CAP-5=fUz5CFEL8D1L+UATsNqs4MBb6rNeYtZ26+pFC4NgRYt6w@mail.gmail.com>
 <20241011-uncovered-original-vole-cda87d@meerkat>
 <20241015-warping-condor-of-storm-afa06f@meerkat>
 <Zw8cN9daNBvCJd3u@google.com>
 <CAP-5=fXsVXYkncR0rwxXvKp_f5dR40L9_x-qoLxwHXWMiyXh3g@mail.gmail.com>
 <a0626ecb-cc64-4c6a-abf3-76868178234f@gmail.com>
 <b1c1a76b-5094-4384-9304-360a6012e3ad@intel.com>
 <b11407cf-8cfe-40ec-abe7-165122807e1d@gmail.com>
 <ZxlwoN57PF_5YX0F@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxlwoN57PF_5YX0F@google.com>

On Wed, Oct 23, 2024 at 02:54:40PM -0700, Namhyung Kim wrote:
> On Thu, Oct 24, 2024 at 03:17:38AM +0900, Yunseong Kim wrote:
> > On 10/24/24 2:34 오전, Adrian Hunter wrote:
> > > On 20/10/24 07:49, Yunseong Kim wrote:
> > >> I would like to express my sincere gratitude to everyone for their help in the
> > >> official renewal of the perf wiki.

> > >> Additionally, the reason I chose to use Markdown is that I wanted to actively
> > >> utilize its media features. For example, I wanted to embed videos,
> > >> presentation slide or display Mermaid diagrams directly on the page.
> > >> I thought these features would be welcomed by users who are new to perf tools.

> > >> On 10/19/24 8:47 오전, Ian Rogers wrote:
> > >>> On Tue, Oct 15, 2024 at 6:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >>>> On Tue, Oct 15, 2024 at 02:25:02PM -0400, Konstantin Ryabitsev wrote:
> > >>>>> On Fri, Oct 11, 2024 at 06:39:09PM -0400, Konstantin Ryabitsev wrote:
> > >>>>>>> Yunseong created:
> > >>>>>>> https://perfwiki.github.io/main/
> > >>>>>>> Perhaps the solution here is to make perf.wiki.kernel.org a redirect
> > >>>>>>> to https://perfwiki.github.io/main/

> > >>>>> To speed things along, and since the old perf wiki was near-unusable anyway,
> > >>>>> I went ahead and set the redirects from perf.wiki.kernel.org to
> > >>>>> perfwiki.github.io.

> > > Links to old pages end up at the main page.  For example:

> > > https://perf.wiki.kernel.org/index.php/Perf_tools_support_for_Intel%C2%AE_Processor_Trace
> > > https://perf.wiki.kernel.org/index.php/Top-Down_Analysis
 
> > > Any way to get them to redirect to the correct page?

> > We can use web.archive.org as of September 30th of last month.

> > Intel PT Link:
> > https://web.archive.org/web/20240930185823/https://perf.wiki.kernel.org/index.php/Perf_tools_support_for_Intel%C2%AE_Processor_Trace

> > Top-Down_Analysis Link:
> > https://web.archive.org/web/20240930164757/https://perf.wiki.kernel.org/index.php/Top-Down_Analysis
 
> The corresponding pages in the new site are:
 
>  https://perfwiki.github.io/main/perf-tools-support-for-intel-processor-trace/
 
>  https://perfwiki.github.io/main/top-down-analysis/

It is unfortunate that we can't have some sort of mapping from the old
URLs to the new ones, I can imagine other sites having links that now
will get broken :-\

- Arnaldo
