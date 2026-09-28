Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B814F3917;
	Mon, 28 Sep 2026 17:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614918; cv=none; b=LCrUMlbj7nbUgZCXMEfyt8SXT4Dx2ZdyGraoCr/j5ec/JZgxqV9y3Bw7NspF1im2/lVuNJ943RLMb0e4EEh2/mfaCpPqg6NeztQ449iHAhOeiE9FQhpIjR+8uIrQVMnKQrnQb14Jyug6KopnGQkLsvtlXNOB8Ti84+tKtsoFDmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614918; c=relaxed/simple;
	bh=b9QlV3PC/Tx2LZ2OpP4Vx1ShDllkXZt+lqw9pS8QsQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wzz0i4LRhxerYsdDs7yuvIYofQ19L7sjeFYIlwFJIz67ka5sihUhmMQ5pb0lJvhXr6qsa9MuV+u+sbVDN/UTKUCD5PDm2dwjv5LRJ09qYSvVf/DEiQoZYtaT4Opc0tqgZB9gw/G1FRHNMVk4MmkiaA4WCPM2/woeYuJ6nSkIBCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEmxMsnh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEmxMsnh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76F81F00893;
	Mon, 28 Sep 2026 17:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790614916;
	bh=FzUBOvELPxMgwlEm+1B3PqsplMwcMDKmmyZxpSozQTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IEmxMsnhRDExrq0Qjt0zuNk+VHAe9+W/aS2tg0vuWLn3eZoH15lH/lCkb414dkkEu
	 rKN/aVMkCVnjpcIIkkNoKkLv1mTkKEO+uCQp3bR9HP3VbjjmghouIrmpMVOBJ1bgES
	 nc3+6AogIYi3lC1tYuYpEgsuA90/iCoEM6XJoKJWAnB2a0qTFWC7mEAedk4Att9WsP
	 V5/R3PMd7eZJXpspbsgtAsuk1x/owi+oOOJcDzySk64YSWL+QvHsf3a1YJI8JpEXWD
	 kzGZNBOzK9EACj3Smh2O2sfhUPdOoXJtTZAHSAQSiyNXdRfHSzeI2z3rs140e3DuSz
	 KNcJ4rq3mScBg==
Date: Mon, 28 Sep 2026 19:01:53 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: sashiko-reviews@lists.linux.dev,
	"Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 04/26] perf vendor events intel: Update broadwell
 metrics to TMA 5.2
Message-ID: <arqdgUD0rTEbnx6C@x2>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-5-irogers@google.com>
 <20260924171457.7626C1F00893@smtp.kernel.org>
 <arqaq6ulLswHEQyg@x2>
 <CAP-5=fUpvYfs__94ByRtib3Px1o5kL+rTrzq=mdK0kyHB_T8FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUpvYfs__94ByRtib3Px1o5kL+rTrzq=mdK0kyHB_T8FQ@mail.gmail.com>

On Mon, Sep 28, 2026 at 09:54:50AM -0700, Ian Rogers wrote:
> On Mon, Sep 28, 2026 at 9:49 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Thu, Sep 24, 2026 at 05:14:57PM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > > - [Medium] perf: missing NO_GROUP_EVENTS_SMT constraint for tma_l3_miss_bound
> > > - [Low] perf: invalid event and metric references in broadwell TMA descriptions
> > > --
> >
> > Hi Ian,
> >
> >         I just saw Mi thanking you for addressing an issue in this
> > series, will you address these Sashiko comments?
> 
> Thanks Arnaldo!
> 
> NO_GROUP_EVENTS_SMT  - this is an optimization to avoid weak group
> fallbacks when SMT is enabled. Applying this tag across all Intel
> models is something of a chore and I'm lazy about it. It isn't a
> critical issue as weak groups (should) work.
> 
> The invalid metrics in the documentation aren't great, but we're
> building the metrics from a spreadsheet. The column containing the
> related metrics doesn't differentiate per model, which is where the
> problem originates. We could validate that metrics are present with
> additional passes over the data; however, fixing this is something we
> need to address in the longer term, in my opinion.

Thanks for the clarification:



Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
