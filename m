Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5F7376;
	Tue, 25 Feb 2025 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740510441; cv=none; b=uqHSTLj1CY6P3OHVVET3S3NRF4wPRhTDPUWMXqghqaPSAs0IiIb1nhRL/e4vZzQ9mZBrgyAV3zWaLNB4PAce/bo3aESKel9CfG+fF/++PhGJPl2YIndQZsAUUt1mFQ0BLD+xn5m1Vga/R2BL7X0X5CJmUY3Ks3FO5J3YFxvDAag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740510441; c=relaxed/simple;
	bh=FZwqJGKe6/A+tfCS8ySsYBYhYNrYgXfBIteR1CqltAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyAZVXDPq/e1XppQFTn+W7/4B8KOGID4Kn23b0HfbwLMvPyf2MrwaufO+4xfLBeph/qd1WC+hcziptbtyvDzhw1wnxcAYyoGRS72lM6PNYjhdRql0DDaJOGKi+tNoC28QpDhUXTzn6frv74RKrUQQRfvUmtzVKScdorhKOBGW6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/E+5alp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/E+5alp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E22C4CEDD;
	Tue, 25 Feb 2025 19:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740510441;
	bh=FZwqJGKe6/A+tfCS8ySsYBYhYNrYgXfBIteR1CqltAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/E+5alp2UOWKrVcnDXegC2Ym8468ccxau9GPj1KF0gu2sF5BkQnHPcHIH4cexF0O
	 I8K3NrKS+6fJoRdqqVSLkppErV/NgtINf45K4CujgRjQ2t1oorKW6x7PC3e/uGWI78
	 KxzhhO6IA9LP1DEgYna3qjWpQPbq8wfEimksnbqnmzD3k2eBMAnQN1sqjfSIQci922
	 1/E5TN0S2OgqUlE68ih96XSeKi+yKTtFRUdh+k1FiMVvjqF6yFo8+XZR2p1N7dMd0B
	 euMLY/N6R2h13QwnHaHnsUGNeb57VpPx2O5319m578n/8h03JEuxESd4AGlsptnn38
	 5+F41UCyJEcqA==
Date: Tue, 25 Feb 2025 20:07:18 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf report: Add 'tgid' sort key
Message-ID: <Z74U5s7Yf0f6I7Mo@x1>
References: <Z7UDlZKnqXRqNqQa@google.com>
 <Z7XsltyqUWrdKma0@x1>
 <Z7XvEFEZtCRZKG7Y@x1>
 <Z7ZIqpwffQbibwL2@google.com>
 <CAP-5=fWZXPjD3Ok5XmMwwaYt+9mL+V8t8fNSUdf-F5PPiEAvrg@mail.gmail.com>
 <Z7gllQZeg6U2OvZE@google.com>
 <CAP-5=fXEEMFgPF2aZhKsfrY_En+qoqX20dWfuE_ad73Uxf0ZHQ@mail.gmail.com>
 <Z70wHEl6Sp0H0c-3@google.com>
 <CAP-5=fUosOVUKi5tQ3gVtHhfApk0oH3r2zHDW7-i+_qASKm+Cg@mail.gmail.com>
 <Z712hzvv22Ni63f1@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z712hzvv22Ni63f1@google.com>

On Mon, Feb 24, 2025 at 11:51:35PM -0800, Namhyung Kim wrote:
> On Mon, Feb 24, 2025 at 08:40:37PM -0800, Ian Rogers wrote:
> > On Mon, Feb 24, 2025 at 6:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > On Mon, Feb 24, 2025 at 10:18:37AM -0800, Ian Rogers wrote:
> [SNIP]
> > > > I thought the real-time processing had to use
> > > > maps__fixup_overlap_and_insert (rather than maps__insert) as mmap
> > > > events only give us VMA data and two mmaps may have been merged.
> > > > Shouldn't doing this change be the simplest fix?
> > >
> > > Make sense.  How about this?
> > 
> > Lgtm, I have no way to test the issue. Why does maps__fixup_end need
> > to get pushed later?
> 
> I just noticed it would add extra kernel maps after modules.  I think it
> should fixup end address of the kernel maps after adding all maps first.
> 
> Arnaldo, can you please test this?

Trying it now.

- Arnaldo
