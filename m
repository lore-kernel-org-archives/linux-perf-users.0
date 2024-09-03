Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586DC1A265F;
	Tue,  3 Sep 2024 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352782; cv=none; b=jloSdPkHmpfL3Vm8AEw9WzjLywZIeAM/qFBkehvSWPQOzYwyHJSGtvlsavP0ojqfE6TfocPKi4/xD8PjKVgEYkjJdTHbRYeTxhr9XqA1zRxC0+IdalBe8XB0uQ1rvGTmzxZNepdq4mX335GlRibtt6REUrji+IVprVbIZo1N3S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352782; c=relaxed/simple;
	bh=DivgtVo8kSPGiFPbJHdLGpJ1p7dtqCDEGh+U4Foj22E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALwONGH0x9wvK06Q6OJJR8XIFMql8rGjiLA5Np+85F6oGSAYwTKnAVm9RFDB6P2kKwiZA2drTLWDz0eVzght5CiADgw4IB8yzu5quvyY9hjqvU1FSN+g60OYFIATErzOZDrlnYQejuXj4SAtdxe8DIR4p46gmHVJb+b7ziCqiGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T8zg94hI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T8zg94hI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=NNRvXjTTF8R6VeKLUxlS3MDewRmdHJ2ZY5+l+5Cbj3E=; b=T8zg94hIr1kJxbtfXOEA3Y4JUE
	iT8ANLmrR/e46rQ99gvKCeQOHofZ9Qf9uU5XAiseyZBcc6DXBeAxEDi0xwwsEWlzE5pf0sHQ9djnG
	5RVb5B0BAgo8KDHmGBGQsX4h2kRq1Y/DZgBab5mXOkNkISGBBjLYD9HG6iQx8i6yrBsxzTNwKjaOX
	zLjY4O1kLuGmF2BT4HQGsb1ZJ3HO8fdZ0JiUxNl3472FGN5DW8ie7xAa2FpHYmK0XCSz24+hU+InZ
	GxWxGJNyFP5KfK1zlMCoYyaJpWXfjUhDiPhQELdBpU96gtMUALy4jOAkJxH/28g6K3AN0f2Ph6mdp
	KbEkA52w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1slP4X-00000007xo4-1urv;
	Tue, 03 Sep 2024 08:39:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 20A48300390; Tue,  3 Sep 2024 10:39:33 +0200 (CEST)
Date: Tue, 3 Sep 2024 10:39:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: Re: [RFC/PATCH 0/4] perf tools: Do not set attr.exclude_guest by
 default (v1)
Message-ID: <20240903083933.GQ4723@noisy.programming.kicks-ass.net>
References: <20240902014621.2002343-1-namhyung@kernel.org>
 <20240902085628.GA4723@noisy.programming.kicks-ass.net>
 <CAM9d7cg13isO4rmwUpDAm9pL7qLYDOfXsBnGhr6eLMuUyM2Z2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cg13isO4rmwUpDAm9pL7qLYDOfXsBnGhr6eLMuUyM2Z2w@mail.gmail.com>

On Mon, Sep 02, 2024 at 10:20:41AM -0700, Namhyung Kim wrote:
> Hi Peter,
> 
> On Mon, Sep 2, 2024 at 1:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sun, Sep 01, 2024 at 06:46:17PM -0700, Namhyung Kim wrote:
> > > Hello,
> > >
> > > I found perf tools set exclude_guest bit inconsistently.  It used to
> > > set the bit but now the default event for perf record doesn't.  So I'm
> > > wondering why we want the bit in the first place.
> > >
> > > Actually it's not good for PMUs don't support any exclusion like AMD
> > > IBS because it disables new features after the exclude_guest due to
> > > the missing feature detection logic.
> > >
> > > AFAIK it doesn't matter for the most cases but perf kvm.  If users
> > > need to set the bit, they can still use :H modifier.  Please let me
> > > know if it's ok for you.
> >
> > IIRc the point of setting exclude_guest by default was so that default
> > perf keeps working in the precense of that PMU pass through mess, no?
> 
> Sorry I haven't followed the vPMU pass through threads.  It makes
> sense to keep the exclude_guest for the kernels with it.  But I guess
> it's configurable via kernel config and/or boot option.

Yeah, you need KVM build with the passthrough thing on, and then at
runtime enable it or something -- I too have to still read the latest
posting.

> A question, with PMU pass through would the kernel reject host events
> which don't set the exclude_guest?

Yes.
