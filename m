Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778176;
	b=zAfF//vPhSvAUGt01pe08x6bKL53qXBidAKRep11u8/OkjcxnRAw31hA5PixAf9SfE9K
	 SBlCcQRA/AyA48Tb3bfsvSzhLHfWgWNys0X88D1EH7cF6U3YlT30TJU2Cqq+L0VJYEu6N
	 fIooYkozFtOBnQ3SzfbHv2LcEK65/arwH3acwMiB9b7yf8ePxsD+miUypeLZTfOJTEYUJ
	 PBJHvvozSTNMLc66axwKCgpSdsV/ZmdhQtWGwdf1AXkkdbIjqAsQ7tPsBpJb/fJNXUbSn
	 8gv104LqyrTMD5EIlYezaR1aUiXT59p0KuDdGdWqYKz2ixP/pjUYkvGI+k5cYO9rWNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778176;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Np0i0S5gDotjvzVRe8mE9yrhQJwWcllflBosI+UqWwU=;
	b=rK3rEbOsVml5kfxwHSSHQ8KSXmm9B8JkqAfuRh92ALEXOD++ka4/5BtZluTz1FUBoAKC
	 QEeTRvwj2l3ZiOG6/TK2WsRv/XC2iiLiDj02YpHD2yQqUJ51uEy3i77pqtKlWgWWoALYP
	 Ht4MdouXBdcStyK23evmNrfqFcZXPteiKVpb/5z8XOm/dR5Af3JOs0TsZoiSUTnOu3dMy
	 I/HsqlzJdcrYPxoppUEFa1PRzXTELyT0CSrwMYgqyMuRDmcOj8fb6ytx9thB1fztNnSW/
	 jAGDiQK5H63ahtCELT2xx+4Sx7/kAmXSAFKGJIRYZoE3HMmhJkrTTXSQDKdCibNmPKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LOlGYT/B";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECD1606A33D;
	Wed,  4 Nov 2026 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOlGYT/B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042F21F000C1;
	Wed,  4 Nov 2026 07:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793778175;
	bh=Np0i0S5gDotjvzVRe8mE9yrhQJwWcllflBosI+UqWwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LOlGYT/B2XmSPAhQ7Hb4vhd0NMLyMvvcPQhbbVaTdf4qtxCsIYM61wqiyn/LDEtmT
	 orGL6quJkV3ydnHsL89fUTGXUU4PA5noCKhYFD2dtLK5M6aXPD0TFpAnNgh94aUHES
	 pIfLtMzf25Pa/SZMB9ld7E5KLnP8Aloo3pFta9iQnla0f9Rf8Z7ePUZHebkcqFQGvL
	 WxLTrXUoByWTrUE8IGsw2M0fxgSe3oXnqjh6nAUDrH7b8MfKaLgKJjnzxfpM4/C1GA
	 2OK92/+yl0EYmypAMcOLfNL4mnbWOIRiKopfiUgX/JJS4hl95NAO+bSSalRAYKKE8D
	 lBsZsSybL/Wsg==
Date: Tue, 3 Nov 2026 23:42:53 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	chjohnst@mail.com, neelx@suse.com, sean@ashe.io,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v12 05/10] perf ftrace: Support context
 switch tracking in function graph tracer
Message-ID: <aurh_Uc9loXXZG0O@z2>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-6-atomlin@atomlin.com>
 <auZlT1eIOjpTnqHZ@z2>
 <qavabkz2qznknyttzymkppwz64ho6hvqeooqn4ktsxpw5hq4t3@4jfxdhl6c2mu>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <qavabkz2qznknyttzymkppwz64ho6hvqeooqn4ktsxpw5hq4t3@4jfxdhl6c2mu>

On Sun, Nov 01, 2026 at 07:04:17PM -0500, Aaron Tomlin wrote:
> On Sat, Oct 31, 2026 at 03:01:51PM -0700, Namhyung Kim wrote:
> > On Sun, Oct 25, 2026 at 10:57:30PM -0400, Aaron Tomlin wrote:
[SNIP]
> > > +
> > > +		/*
> > > +		 * Prune frames on existing and ts that exited during subsequent
> > > +		 * execution recorded on the other state.
> > > +		 */
> > > +		ftrace_task_state__prune_stack(existing, ts);
> > > +		ftrace_task_state__prune_stack(ts, existing);
> > 
> > I'm not sure about this.  In this context, it knows the 'ts' is uptodate
> > and the 'existing' contains the old state.  Does it need to prune the ts
> > using the existing?
> > 
> > IIUC this code assumes either ts or existing may have uptodate state
> > like in general cases but it would make the code unnecessarily longer.
> 
> The reason this handled both directions is due to how trace_pipe merges
> per-CPU buffers when a task starts on CPU 0 (unidentified, tracked in ts
> under FTRACE_UNKNOWN_PID(0)) and migrates to CPU 1:
> 
>     1.  Task X starts on CPU 0 before any context switch banner is seen on
>         CPU 0, so its initial frames are recorded in ts.
> 
>     2.  Task X migrates to CPU 1. If CPU 1's incoming banner ("1) idle =>
>         X") and subsequent function exits are read from trace_pipe before
>         CPU 0's outgoing banner ("0) X => idle") is flushed, existing is
>         created on CPU 1 first and actually holds the newer state, while
>         ts holds the older pre-migration frames from CPU 0.
> 
>     3.  Conversely, if Task X was already known on CPU 1 (existing) and
>         migrated to an unbannered CPU 0 (ts), then ts holds the newer state
>         and existing holds the older state.

IIRC we use the global trace pipe so I expect its output in time order.
How can it see CPU 1's sched switch before the CPU 0's?  Maybe some time
drifts on each CPU?  Anyway, if that happens in practice, yeah then we
can check in both directions.

> 
> That said, I agree that maintaining a dynamic per-task watermarks[] array
> for arbitrary multi-hop migrations before the first banner is superfluous.
> Replacing the dynamic watermarks array with a single scalar minimum-indent
> watermark on struct ftrace_task_state makes this much simpler and removes
> ftrace_task_state__record_indent(), ftrace_task_state__min_indent_after(),
> and the watermark merge loop in ftrace_task_state__rekey().

Sounds good, thanks!
Namhyung

