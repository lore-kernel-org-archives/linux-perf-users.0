Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2482F691F;
	Wed,  6 May 2026 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778093645; cv=none; b=k/KjZZPWuZ0brIc9aDaTBPOI8mRfxVdSIZRG410gWAh1LALzFaYoq8UNpmv9wXWzIwbe3qaNgF7wOtrkpmjEZEW8fQDt+PBVA8kkS3HcKQrOaaPwCQauo9SBfjsQeheu4dvP9u4YXhVYac78nj5HN5KjOmqA5z8JmiioyVrycck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778093645; c=relaxed/simple;
	bh=89W1B4QdbowPtBhNkcxxpHzU7oKd7EAH2SX2laB63Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smNafbD0+D7V0mjso0rMtgWaYdh/7wJAKesBXSZv9T9dpe/1aonwpPNnrSNQPTaO0ZOHmITHMR8fuomDEhf9lN4U9dB+VDVBUdQt4dQRLO5PtKxpPa89UxoPyeiuThw7zQNRiqMTRZSFiJ4PywuIeEX5XMx4gHMabpqTKzfy0QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXfxh7pM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXfxh7pM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D75C2BCB0;
	Wed,  6 May 2026 18:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778093644;
	bh=89W1B4QdbowPtBhNkcxxpHzU7oKd7EAH2SX2laB63Y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LXfxh7pM0DADy7d6Ju2PbiUlsNQDiwXHxMcL2Xq92FQD1/6G0hzCvZHBoVPXo+OW0
	 YOhpHpWkIbkpZFlnANw3EwKrSOebYj3qeD+NQ/2S7bqTeZCNUVsuieRCSqP6RFOoDb
	 Bh4NfRTK/07aCBfa8+VyNx8Y3iWoTd5CfmMlOqDE/rrfP1VnR7h3ubgsRT4CO1pY31
	 fLAGV6DzsYu7KMCyJDPOWGlFoCh4Hp8Wi6T0E+HouVtk9E0fwChzcJci8A+OzVfD/T
	 2aRE5SN73ktc0tL47CWkdRV0wZ2VC4NmUjD/0rFHdTfH+vTXC8JEAMITJi4vglJQQO
	 BXA+yMjl3wmTg==
Date: Wed, 6 May 2026 11:54:02 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf sched: Avoid segv if tp_handler not set
Message-ID: <afuOSvbCaUgFRQUI@google.com>
References: <20260321061448.810525-1-irogers@google.com>
 <acW_IHQVZnxIETdd@google.com>
 <CAP-5=fWh66OwPC0K4ZyedAWqwyXez0ya9Dz6hzbgY0AhoqMfdg@mail.gmail.com>
 <ac8pEDUKjuMxXUS6@google.com>
 <CAP-5=fXeBje03BM8D9q-0KsXg2KmyRa81CuphtSQfHp0isFc_w@mail.gmail.com>
 <adPzEmwDaHq4SsZw@google.com>
 <CAP-5=fW-H-ri3MdVv4Vh4xiyB-qpDqnO3gqXR+XyfMK+kXpHQA@mail.gmail.com>
 <afs9tx6hpi9CiEzN@x1>
 <aftpmFmahaykG7Rg@google.com>
 <CAP-5=fUuF4LpSMy30AuLoz-wKy9O8ZLkh+UWBrDJTwNV-D=eqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUuF4LpSMy30AuLoz-wKy9O8ZLkh+UWBrDJTwNV-D=eqw@mail.gmail.com>

On Wed, May 06, 2026 at 10:12:05AM -0700, Ian Rogers wrote:
> On Wed, May 6, 2026 at 9:17 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, May 06, 2026 at 10:10:15AM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Tue, May 05, 2026 at 02:56:02PM -0700, Ian Rogers wrote:
> > > > On Mon, Apr 6, 2026 at 10:53 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > On Fri, Apr 03, 2026 at 08:29:25AM -0700, Ian Rogers wrote:
> > > > > > On Thu, Apr 2, 2026 at 7:42 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > On Tue, Mar 31, 2026 at 10:59:52PM -0700, Ian Rogers wrote:
> > > > > > > > On Thu, Mar 26, 2026 at 4:20 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > > > On Fri, Mar 20, 2026 at 11:14:47PM -0700, Ian Rogers wrote:
> > > > > > > > > > Doing a `perf sched record` then `perf sched stats report` crashes as
> > > > > > > > > > the tp_handler isn't set. Add extra checks that tp_handler is set
> > > > > > > > > > before accessing through it.
> > >
> > > > > > > > > Oh.. unintended use case. :)  Probably better to add a dummy handler
> > > > > > > > > for `perf sched stats report`.
> > >
> > > > > > > > Perhaps. I'd prefer to land the simpler change as-is.
> > >
> > > > > > > Well.. I guess the dummy handler approach would be simpler and perform
> > > > > > > better. :)
> > >
> > > > > > > +++ b/tools/perf/builtin-sched.c
> > > > > > > @@ -4955,6 +4955,7 @@ int cmd_sched(int argc, const char **argv)
> > > > > > >                 .switch_event       = replay_switch_event,
> > > > > > >                 .fork_event         = replay_fork_event,
> > > > > > >         };
> > > > > > > +       struct trace_sched_handler stats_ops  = {};
> > > > > >
> > > > > > Oh, because there's an existing null test on the function pointer we
> > > > > > don't need dummy functions, which is what I thought you were asking
> > > > > > for. I'm still not convinced this is very intention revealing, but if
> > > > > > it works for you then you can have my reviewed-by tag.
> > >
> > > > > Applied this and the patch 2 to perf-tools-next, thanks!
> > >
> > > > Thanks Namhyung. Did this get accidentally dropped? I'm not seeing it
> > > > in perf-tools-next.
> >
> > I think I've applied my approach and test fix.
> 
> Ok, that wasn't clear. I think it is good to post such changes to the
> list. For example, just sync-ing the header files prompted sashiko to
> point out a bug in our beauty scripts:
> https://lore.kernel.org/linux-perf-users/20260504193334.9F978C2BCB8@smtp.kernel.org/

Ok, will do but patches are there.  I also plan to send out v2 for this
header sync.

Thanks,
Namhyung

