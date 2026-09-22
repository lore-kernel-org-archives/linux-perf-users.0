Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41685437CC;
	Tue, 22 Sep 2026 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081446; cv=none; b=MepByLaKge51fGhVuWX4xSdGJTUsNk6VWYHT52PfkBqFDSFa5uNsZolr6Uk83N/nendZPK+5cF1qD/ghk4HwX5TdJT0N3Pg6ModuEZIuABRW7VsHV45AK7pDXUWlKK0243UJwcaSopF6sL9lsS2smkHra9NcGKbuunClpcPsW7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081446; c=relaxed/simple;
	bh=nR98H85s6ku9CeYEttHMKot2DHtDQNNd6C4kKhZaqy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChOFy324rqqCCzbyJqnaTVeEvhgig0eiqoEvm3ZdRw9k2dN1twyulL3vTAtQO4aJ03CeC9BRoEcz9tH+ZzD9ekuSk8emcW0fNQ+WWNaWuMdwfzxWs/OUfokTBcphUx+2qhSKLe+IeejQGNTdctjkNvt5CVbP9vBkNq2bP+bx9UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvqF41w7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvqF41w7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAE61F000FF;
	Tue, 22 Sep 2026 12:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790081445;
	bh=d5owc9FWKmCLCAT57V5SZmu3cBmMcWa6fhzQ9ftg7Ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PvqF41w73g7TQMu/c8K9XRl2sS2AnIAfbayWRLlqkuhzP2AnNlatF6IvKnACbJxxA
	 mPb6ugt2NMZzlEEjgaKNlMtH80/7zB6bgBUb6OgJJ/hhk5bkSp3oHEOVNCAPRfRQJG
	 Yfv6yXD4WXHuHiwvUhAjvC8dif0o8XSqzbfB9E7rBnmxAIBLXbiL4/AZLNSTy1LCrN
	 l0cvzHoSVD0B/bL9dhsSHCX6pa+/HUaQyZ9RPXoTNIE30mOCrt1lD7V++4p+lCCZfn
	 BEsmtAaP7lcbO9qXaK3uaPjA6nBqkbcZqoK9d1A+n53juJutmtq8Q+PEvVsBUqe8T4
	 1pLgc5RYrS8qQ==
Date: Tue, 22 Sep 2026 14:50:35 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH 1/2] perf alsr: Add missing SIMD handling in
 aslr_tool__process_sample()
Message-ID: <arJ5mwKTBuludevg@x2>
References: <20260915091112.333308-1-dapeng1.mi@linux.intel.com>
 <024fd251-a4ba-443f-8aff-f5b1cdb062a3@linux.intel.com>
 <CAP-5=fUc_WOHAe4EkLVYuBgvQmxk7_XY4N+v8yJKNJQpCSObHg@mail.gmail.com>
 <CAP-5=fWTRPmPTkzd98hCEfh6LUTrRTNHZ2dS4nUDyQBuU8oSzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWTRPmPTkzd98hCEfh6LUTrRTNHZ2dS4nUDyQBuU8oSzg@mail.gmail.com>

On Mon, Sep 21, 2026 at 09:22:11AM -0700, Ian Rogers wrote:
> On Mon, Sep 21, 2026 at 9:21 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Sun, Sep 20, 2026 at 11:42 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
> > >
> > > Kindly ping ...
> > >
> > > @Arnaldo, @Namhyung, @Ian, not sure if you have bandwidth to review this
> > > small patchset which fixes the Sashiko found minor issues for the "Perf
> > > tools: Support eGPRs/SSP/SIMD registers sampling" patchset?
> > >
> > > If possible, it's better to be queued in this cycle, then we don't need
> > > extra backporting. Thanks.
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Oh, another nit: there's a typo in the commit message subject: s/alsr/aslr/g.

Fixed.



Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
