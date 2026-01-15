Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A7D2701DA;
	Thu, 15 Jan 2026 05:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768453217; cv=none; b=JeZ8UG8dg/5ZfEKmqoIvE9GIxDGvSZC0fA5ljcZqss1Ds93nblJ0+VgIa7FC6EkUBohMOeX0vIyMvhH/Fh7ryhCQv9GSaw/dxUTOq0+1D55zPQmRjylt3JGcvyKliETjQKxhT+1YN5vYlYHuSdN7POAC8TD1Ko999lvHr0iwjew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768453217; c=relaxed/simple;
	bh=WfJf4O09dh+5bTZivTdwQHmhc3nmSTAA1vRa3InT2wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apuK7MZgaGFfNnasLfETXv8nSuoDTXi0EccWX7xEfLZmpe9rPU/S2zKA7q8X3rZPPYYXzf9c193xp43bOMtx4m4YlkRzGlw1ynZkP85y23WIJAwRqh7mNHVj+TpbqylzQbu4jLVy/L3szeCpnQ9hLW0CHzFCS+MZxtSXHIbYtzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYUHp+Kl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYUHp+Kl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E120DC116D0;
	Thu, 15 Jan 2026 05:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768453217;
	bh=WfJf4O09dh+5bTZivTdwQHmhc3nmSTAA1vRa3InT2wI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lYUHp+KlaDmR+PZS4zY5Mw9Fn0MRnU8uYwY1FREsJw+fRENKN/hhJ1/tDG2Mg/UMs
	 28a2I5Slhx3V+Kwe6pgcHMenMYpThYrvBbOAJMDhoRw6izQqUVlpyJb3Gh31gA6q/m
	 CIyt025MydDz85sTDMbq4TeOwkGrCRJ1su5Db+Rkq2SqizI3NgNZfha+J/AuKXrv3x
	 fcyeKoygtYGXywU5TSzQS09scVJsogbKnYk1TNTD7Ba8mvRdXjtnO0CYPKupPCafaS
	 h0N1g2jGDHSbvGtujDTy6mkNa2FOthQeu4ycaNy8uWvB6AR4PwzbTwPXYV1CZm6i5H
	 Ju1KPfQdEqrrg==
Date: Wed, 14 Jan 2026 21:00:15 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Add procfs based memory and network tool events
Message-ID: <aWh0XwBDZRRYcZOG@google.com>
References: <20260104011738.475680-1-irogers@google.com>
 <871pju4vwt.fsf@linux.intel.com>
 <CAP-5=fW0QQj08_S+nn5+kos1mzMbeNg9EBeKPKm03Gfqj80v+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW0QQj08_S+nn5+kos1mzMbeNg9EBeKPKm03Gfqj80v+A@mail.gmail.com>

On Mon, Jan 12, 2026 at 10:08:20AM -0800, Ian Rogers wrote:
> On Mon, Jan 12, 2026 at 8:51 AM Andi Kleen <ak@linux.intel.com> wrote:
> >
> > Ian Rogers <irogers@google.com> writes:
> >
> > > Add events for memory use and network activity based on data readily
> > > available in /prod/pid/statm, /proc/pid/smaps_rollup and
> > > /proc/pid/net/dev. For example the network usage of chrome processes
> > > on a system may be gathered with:
> > > ```
> > > $ perf stat -e
> > > net_rx_bytes,net_rx_compressed,net_rx_drop,net_rx_errors,net_rx_fifo,net_rx_frame,net_rx_multicast,net_rx_packets,net_tx_bytes,net_tx_carrier,net_tx_colls,net_tx_compressed,net_tx_drop,net_tx_errors,net_tx_fifo,net_tx_packets
> > > -p $(pidof -d, chrome) -I 1000
> >
> > But AFAIK that's for the complete network name space, not just the
> > process, thus highly misleading in perf context because the scope
> > is incompatible.
> 
> Yeah, we can point this out in the event descriptions or just not have
> the events and try to do some per process BPF type thing. Given we
> don't have the BPF thing it is still tempting to have these counters
> as-is for the system-wide case.

You may want to make it fail to open for per-process mode.

Thanks,
Namhyung

