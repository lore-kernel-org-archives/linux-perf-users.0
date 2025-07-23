Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200B55464E;
	Wed, 23 Jul 2025 01:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234635; cv=none; b=TJan2WvbhmuXjCdeXXVQS9u/72TQUhWea7Y0y7RnUXhaGrvIa9OVsIEoRA7/9q9/rT50bc5n6ovCWOEULS7tWFF+47R4vwykD2VL+FTaBZTidESNQ8qHJZxnDl7V+z4AcYaVam/byHKMiD1xbYjfjW55S+gZpejnnEg1srnXjeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234635; c=relaxed/simple;
	bh=LQCNQ3CMM0RmYk36/MME+4qX7+Nyqrk0Fbt6A5zO96E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zsgx3qfvC9UdU46NmuXUnlzW7sMrt3mx9hqIzy7xToTAULr2kwRRzoutoctzWmfLvrdG6ivpstyUZdGQv/jO4MKqCeffzz/iuRISSp5rn7qsw7KSVVc6C4OqrEVbDYU5eT6TKRRe6ozr7vS5wk2QsQXXQEg4MTvTWOVyR4AX6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIYEA9pv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIYEA9pv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CE4C4CEEB;
	Wed, 23 Jul 2025 01:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753234634;
	bh=LQCNQ3CMM0RmYk36/MME+4qX7+Nyqrk0Fbt6A5zO96E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIYEA9pv4NI4eH2ivMscP5cDaiEztAW5qHuOoIMxmwCCi1AsAyNBKqmmYhdbFS9jN
	 je9lR/lPbgFUyJvBNt1I9A1ecwkj4gdg/l4h5rEIRz8Wgs0HwQi52XqYQmewiZRGnJ
	 sK9fbcDRrZNMG9e4TY1KWSsyoUXEswOOGAOl1oxqXvvyHo/dkgtaHqL5zIemuILC3s
	 hFnQWyxgnkAcDlG59l9DCWtQrjNCm6Ej7PPxF0t8NXZkpgIP14LzAQtRjdEjJfkDc6
	 JkxMA3VYaNw/Cr3xIeFIL00sj+PdBvlloCs8/ff2Fjyp+gXtMDmLSra4TJCAAEsAEs
	 2qDotx/o0TShw==
Date: Tue, 22 Jul 2025 18:37:12 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: James Clark <james.clark@linaro.org>,
	David Laight <david.laight.linux@gmail.com>, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] perf/x86: Replace strncpy() with memcpy() for vendor
 string
Message-ID: <aIA8yDYF_WJBxtxi@google.com>
References: <20250618215843.109941-1-usmanakinyemi202@gmail.com>
 <20250704102007.6354ce9f@pumpkin>
 <9c59d1b1-a483-49d9-b57a-c86e3e020234@linaro.org>
 <CAPSxiM9AHNrAhRjJKe9fHZ9s7VAQBF9c4S2_HWj2qu1A48hh+g@mail.gmail.com>
 <CAPSxiM9-tZjnssZMA_59ib8Ur+4VNWk4RYOsoFiWHC_Eq+drXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSxiM9-tZjnssZMA_59ib8Ur+4VNWk4RYOsoFiWHC_Eq+drXA@mail.gmail.com>

Hello,

On Thu, Jul 10, 2025 at 07:03:07PM +0530, Usman Akinyemi wrote:
> On Fri, Jul 4, 2025 at 6:17 PM Usman Akinyemi
> <usmanakinyemi202@gmail.com> wrote:
> >
> > On Fri, Jul 4, 2025 at 4:40 PM James Clark <james.clark@linaro.org> wrote:
> > >
> > >
> > >
> > > On 04/07/2025 10:20 am, David Laight wrote:
> > > > On Thu, 19 Jun 2025 03:28:43 +0530
> > > > Usman Akinyemi <usmanakinyemi202@gmail.com> wrote:
> > > >
> > > >> strncpy() is unsafe for fixed-size binary data as
> > > >> it may not NUL-terminate and is deprecated for such
> > >
> > > But memcpy doesn't null terminate after the 4 chars either so I don't
> > > think that's a good justification. Surely you don't want null
> > > termination, because char *vendor is supposed to be a single string
> > > without extra nulls in the middle. It specifically adds a null at the
> > > end of the function.
> > >
> > > >> usage. Since we're copying raw CPUID register values,
> > > >> memcpy() is the correct and safe choice.
> > > >>
> > >
> > > There should be a fixes: tag here if it actually fixes something. But in
> > > this use case strncpy seems to behave identically to memcpy so I don't
> > > think we should change it. Except maybe if b,c,d have NULLs in them then
> > > strncpy will give you uninitialized parts where memcpy won't. But that's
> > > not mentioned in the commit message and presumably it doesn't happen?
> >
> > Hi James,
> >
> > Thanks for the review.
> >
> > What you said is true, strncpy and memcpy seem to behave identically.
> >
> > I should have rephrased the commit message in a different way.
> > While strncpy seems to work here, firstly, it is an interface that has
> > been deprecated.
> > See -> https://github.com/KSPP/linux/issues/90.
> > Also, memcpy is semantically correct for copying raw data compared to
> > strncpy which is for string.
> >
> > I am not sure if the b, c, d can have a null byte, I think using the
> > semantically correct function (memcpy) improves the robustness even in
> > cases where b, c, d have null byte.
> >
> > What do you think?
> Hello,
> 
> This is a gentle follow-up on this patch.

Sorry for the delay.

> 
> I would like to know if I can send the updated patch series with the
> correct commit message.

I feel like the strncpy() is intentional and we don't want unexpected
NUL-termination in the middle.  If it has a NUL character then it should
be a short string and don't need the later part.

Thanks,
Namhyung

