Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E82473C65;
	Fri,  7 Aug 2026 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104081; cv=none; b=DuIvj7IJFbMeKv2H7tV6UySRuwgjishm8uSnGVguOYV0i8GHnU6HMpAT7BVjS+7N1Ri7IHVaCojjVhmW9E7RH3E5FN83qZDRjxfeIYbMvnlnmsulzsTSgUUmB5xLOp6UsC+BHbpeVanW8Qvj1+/uJk2QpvSoYgE7GE3q26/IVzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104081; c=relaxed/simple;
	bh=uB/s11ilmxdQO7GBq/teBpPaV3GciAzoWufSnoOveOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLEazwbUqqsE/Jkol9VEtU8SlSBS0g9Pvkc8aFTKAvshexrfer4/xIq4IQjLiTqKpWQh+42GnBEJHbVpvhKk/eABv3lPwRnWDTOAxsMNWN3BgzatIPnwVgRDnjkeckHtPPz31Ys+nBoDuuSk7EYxe6Gyc1QwMysdgRnsA/nAqTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPvN3ulE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPvN3ulE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A28C1F000E9;
	Fri,  7 Aug 2026 12:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786104060;
	bh=382U0Kti+Lbuas3lM6gxe+r8oW1NkwewtCcvuSWntHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LPvN3ulE7JsvzaAC1Y1X5HYXWzJ9d9w28Y+8xWAWNf/Rc7Vc9GWsGWMitpowHk9DV
	 uRELIOTZsuq/VyAVof46vJcf8FMFv/gdA/UMEnOKByaa4snQ+UexuZAS8yGo3q+60D
	 mCBGbxK20Xm86VWvu2rrUSNVW5US9OgF4O+yC1qMxgZ1V1wrJp130br3MSDVI8IR16
	 uXAtw8nY1XLJkqLcdQjm5tVNa1Rk5mq4K+n7WCJ9v/Qm1kl8+9KiinWh6n8odIdNRK
	 tX2Gk2U7Qq6JIcfOK4WoDD+kofYLhel35sR2UtdSMDq5xVIfaPCTtMpmXsCZp6oLBo
	 Z3YlZZDq8CcXg==
Date: Fri, 7 Aug 2026 09:00:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 05/12] perf jitdump: Check snprintf return before
 computing header size
Message-ID: <anXI90wr-sJ0PAY-@x1>
References: <20260805133013.235016-1-acme@kernel.org>
 <20260805133013.235016-6-acme@kernel.org>
 <CAP-5=fXRei4AivX_RcqR4xjmLtbYuNsJALOzJMAWvy7HCU09Dg@mail.gmail.com>
 <anOS6oYhAKJkAQdh@x1>
 <CAP-5=fU6w8pjDs161=JtKK-OLns9O2iLgTrJhd-Dcahn7xon-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU6w8pjDs161=JtKK-OLns9O2iLgTrJhd-Dcahn7xon-Q@mail.gmail.com>

On Wed, Aug 05, 2026 at 02:29:47PM -0700, Ian Rogers wrote:
> On Wed, Aug 5, 2026 at 12:45 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Wed, Aug 05, 2026 at 12:07:23PM -0700, Ian Rogers wrote:
> > > On Wed, Aug 5, 2026 at 6:31 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > +++ b/tools/perf/util/jitdump.c
> > > > @@ -493,6 +493,9 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
> > > >                         jd->dir,
> > > >                         nspid,
> > > >                         count);
> > > > +       /* snprintf returns would-be length on truncation, clamp to buffer */
> > > > +       if (size >= PATH_MAX)
> > > > +               size = PATH_MAX - 1;

> > > Given the recent fixes to reading /proc/pid/maps where it was assumed
> > > the file paths would be limited to PATH_MAX and it turns out that
> > > PATH_MAX doesn't really do that and we had potential buffer overruns
> > > during synthesis, I wonder it would be more intention revealing here
> > > to use "sizeof(event->mmap2.filename)" rather than PATH_MAX. Other
> > > than the constant used, I agree with the change and using PATH_MAX
> > > isn't wrong.

> > We need to go on having our tools/perf/AGENTS.md with all those rules
> > :-)
 
> Yeah, I don't know of a plan for AGENTS.md files but there is always:
> https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/perf.md
 
> Perhaps we can add something like:
> ```
> ## PATH_MAX avoidance
> 
> The PATH_MAX constant isn't a limit to paths in places like
> /proc/pid/maps, and reading paths from these locations can lead to
> buffer overruns for buffers sized at PATH_MAX - as such prefer dynamic
> memory allocation for paths. When referring to the size of PATH_MAX
> sized char arrays in kernel system call and ring buffer data
> structures, prefer to use sizeof the variable rather than the PATH_MAX
> constant to make it clear the size and possible truncation is being
> enforced by the kernel which may substitute long paths with the value
> "//toolong".
> ```

Looks sensible, I encourage you to submit a patch adding that:

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
