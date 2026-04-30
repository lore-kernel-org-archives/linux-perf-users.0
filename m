Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFB62E7BB6;
	Thu, 30 Apr 2026 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777533338; cv=none; b=YMv3aQKuc4i4cpZlYhSZeBRRsktVEWO0b7QsBou8yMBjw56GjX0rSsfc0FC2Q9w89nIhEAteP1tnaKSqrHgmw6ufYJuwUZtn7Z3ZnLfdJkXXz8LjS+AxFXcLsn3AyehnjycLXY5K4pxPGF9RpptH+Kx8JiWbq6j6B7fh0Ur8aE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777533338; c=relaxed/simple;
	bh=6Hc6/MPT7cg/sZCT1UPOTn1N9LNTY6R6BUWgf4l2WVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6dYQ7JzWow9wj6eS5D1vNANI3b+c/5OoEnfASoWax9pBiKfCuUUmHXtLfbzHor8FqbAECQUfyfr65C7ukZ/u3ulRc8ZSdock9X/sQxACqWHdsSdJpqCSkv76IJFu63msSNZERjr9IrL87oMxhWIoCLHd1RMOTn9/EeJKaFCzT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from martin by akranes.kaiser.cx with local (Exim 4.98.2)
	(envelope-from <martin@akranes.kaiser.cx>)
	id 1wILcJ-000000015fu-1NqQ;
	Thu, 30 Apr 2026 09:15:23 +0200
Date: Thu, 30 Apr 2026 09:15:23 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] perf test: fix sys_enter_openat event test for
 musl
Message-ID: <afMBi-V4FgEWgSVh@akranes.kaiser.cx>
References: <20260428143920.2466185-1-martin@kaiser.cx>
 <20260428143920.2466185-3-martin@kaiser.cx>
 <CAP-5=fU7vttJC6nP8swT19bynjnhV4DR4cetHK6=gBGsp67NMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU7vttJC6nP8swT19bynjnhV4DR4cetHK6=gBGsp67NMg@mail.gmail.com>
Sender: "Martin Kaiser,,," <martin@akranes.kaiser.cx>

Thus wrote Ian Rogers (irogers@google.com):

> On Tue, Apr 28, 2026 at 7:39 AM Martin Kaiser <martin@kaiser.cx> wrote:

> > The "syscalls:sys_enter_openat event fields" test calls

> > openat(AT_FDCWD, "/etc/passwd", O_RDONLY | O_DIRECTORY)

> > and verifies that the flags of the captured event are matching.
> > This fails for musl, where the openat syscall wrapper always adds
> > O_LARGEFILE.

> > Update the check to allow for additional flags, the access mode flags
> > must be unchanged.

> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > ---
> > v2:
> > - check that access mode is unchanged

> >  tools/perf/tests/openat-syscall-tp-fields.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)

> > diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
> > index 2a139d2781a8..5523cf4e9321 100644
> > --- a/tools/perf/tests/openat-syscall-tp-fields.c
> > +++ b/tools/perf/tests/openat-syscall-tp-fields.c
> > @@ -120,7 +120,10 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused

> >                                 tp_flags = evsel__intval(evsel, &sample, "flags");
> >                                 perf_sample__exit(&sample);
> > -                               if (flags != tp_flags) {
> > +                               /* C library wrapper may set additional flags,
> > +                                  access mode must be unchanged */

> I think normal style would be:
> ```
> /*
>  * C library ...
>  */
> ```

Ok, will fix this if we need another version.

> > +                               if ((tp_flags & O_ACCMODE) != (flags & O_ACCMODE) ||
> > +                                   (tp_flags & flags) != flags) {

> How can this second condition be true given the first condition?

Sorry if I am missing something obvious.

The O_ACCMODE check verifies that the two lower bits (access mode flags) in
the syscall and in the recorded event are identical.

The second check tests that all flags from the syscall are also set in the
event. Additional flags in the event are ok.

For tp_flags == 0x0 and flags == 0x4, the first condition is false, the second
one is true.

Best regards,
Martin

> Thanks,
> Ian

> >                                         pr_debug("%s: Expected flags=%#x, got %#x\n",
> >                                                  __func__, flags, tp_flags);
> >                                         goto out_delete_evlist;
> > --
> > 2.43.7

