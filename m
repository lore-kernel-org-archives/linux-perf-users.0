Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBB41E25F2
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226548; cv=none; b=Hnm8PIAiqF0SphLtVurRY8dHgYqO9GcDTi33QflHyfhuXoX9tq576E+/Nn5EWY2As/LZDNA54FFvMSKaJtrgJzgQdmkAUqmId9h8HrBgqPN2PsVKc1bH13aox470DBICol0mUTSmybxrXmJztduLXMDg6GD/KEA9Qw3wC4KDa5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226548; c=relaxed/simple;
	bh=h+jPO0cnsRnc1NHKA7TCu+7++BbxwU/AKq/B2ZtyC4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB073oPtEalQ1Ft2TCw4wPR+ss6KLOBqODhEKjQi/Z6gmL616+iiwJt/PDfjloEdCstIAN+9Xl+OnBqz2cNDb1MQqU3cCXXGg9leQ6iQpgm9EbeAiezCILRkm5sxDM0byK3YglOHZfJ2rZXPH5HER2cP7u0th+VVM7q/eezcx8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NC7a9mNw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NC7a9mNw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B43EC4CEE2;
	Wed,  9 Apr 2025 19:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744226547;
	bh=h+jPO0cnsRnc1NHKA7TCu+7++BbxwU/AKq/B2ZtyC4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NC7a9mNw281j7CUJEVWS0urFJzUL9QRAGPJTk1yNAD1V2zrnW5X5wZy61w6rSy3aG
	 sj+lNf9hoJxrSuPp6Jk/IewPPukYgoH+A/C0cIOnQaFD1H4AJF1XrTniLX4uhs2CqJ
	 oSQjGHRcsVnSWa46yJSIMsRyD3OCWSnGPShSwCFyxCajMGLgW82DBVQgFLHerz6GNn
	 ybmH2RXWmF4jOGuiPfVIBoE/vQoZHKMY42U2uPetOP1LN4bgHryEHLiSHHp39cOkRI
	 98X5jsb9i0l+dohxamLmLU0chdMGmljufr0zWDXe+PMpFqXqNdacBv1IIDD7SB+81j
	 pAJNMBTS9ja1w==
Date: Wed, 9 Apr 2025 16:22:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [perf top] annotation doesn't work, libunwind doesn't seem to be
 working either
Message-ID: <Z_bI7wK8mJYVOWDH@x1>
References: <Z-EJnye74la1triY@gmail.com>
 <Z--pWmTHGb62_83e@gmail.com>
 <CAH0uvoi3oaZesWKLtaJRm3AkJx9j-G_Xm66Z276xH5+k11zisQ@mail.gmail.com>
 <Z_QEND63LoxP0h9H@gmail.com>
 <Z_Rz10stoLzBocIO@x1>
 <Z_TYux5fUg2pW-pF@gmail.com>
 <Z_XaOp4TCBKe-M0o@x1>
 <Z_ZltdaHx9XuKcd9@x1>
 <Z_aY0fTs53id77CS@x1>
 <Z_bHtD7umCsKeWJ6@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_bHtD7umCsKeWJ6@x1>

On Wed, Apr 09, 2025 at 04:17:11PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Apr 09, 2025 at 12:57:05PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Apr 09, 2025 at 09:19:01AM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Tue, Apr 08, 2025 at 11:23:54PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Tue, Apr 08, 2025 at 10:05:15AM +0200, Ingo Molnar wrote:
> > > > >      - Yay! But very unintuitive. The intuitive step would have been 
> > > > >        the left arrow key BTW. (with restoring the cursor position to 
> > > > >        the cc1 entry I pressed 'Enter' on originally), but that doesn't 
> > >  
> > > > That is how I implemented it initially, yes, over 10 years ago.
> > > 
> > > I'll experiment with making the Left arrow key, if already on the first
> > > column, to work as zoom out.
> > 
> > Can you try this, on top of the series or even just this, pressing left
> > should do what we want.
> 
> This is working for zooming into/out of a DSO, but for threads, which is
> what you described, it is not working, checking that...

Using 't' to zoom into a thread and then LEFT to zoom out works, ditto
for 'd' + LEFT, 'k' (zoom into the kernel) + LEFT its just 'm' + thread
or ENTER + Zoom into Thread that isn't working...

Not even that, there is something subtle, investigating.

But as a suggestion, pressing 't' zooms into a thread, pressing it again
zooms out of that thread, rinse repeat.

Ditto for 'd' for DSO and 'k' for the kernel DSO, 'S' for a CPU socket
(Kan Liang implemented this, but not for 'c' CPU, will try to add that).

Anyway, back to the bug.

- Arnaldo
