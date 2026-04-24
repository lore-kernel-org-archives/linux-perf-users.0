Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD493EF661
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777054540; cv=none; b=tjcquLNg4AWJ/39Ix4OLexonaTDE+GQeMWr8FBbUyhCmKZUV15n8houUIaFsasaBERBxV0EWKR4qz+KkI1LkT6xtxsAVAgCnCxkf+x04jZKw5TMwK9EEM052JI+I4Qg/MCp0bcNwEDRzc3tsmIUrSCuVMfcakl6raiaAf6oLrVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777054540; c=relaxed/simple;
	bh=4W8sZe1TPgBwh9GSrM0buZ6S97+2D6GVTlweLGta6Cg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nZt3EflZv43q3uWnqYRH2p5jJcKi1NNW+9OsrCRP8gVrRBNfSKQt+BCExvJMTbZWJc7d7HR587jzNpxFJ+A37hunX2iqD471T0xZ+7RvQMPo9Zm8P7ga0XPtpDdqNE1mNaRxqa++dTOywPr/dz9UR6NE5Ogh03yQ1AomBmb/4Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUt490ZN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUt490ZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4426EC19425;
	Fri, 24 Apr 2026 18:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777054540;
	bh=4W8sZe1TPgBwh9GSrM0buZ6S97+2D6GVTlweLGta6Cg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=TUt490ZN7AqbTtPa2V0RC3r0T+bfgl+GQfgdyLm402E1zOj0kgA4OOJfLIMQHIDVd
	 c8iWT3jjyRPW2WBPbuDiEvZHDgO05rxsZTAOVDq5if4BIaQRjwjLF7GsvSxMyckVIe
	 HnFzpHcqABth/fs4dg5yACxdoMnYJaoN3UV1MuZdnEeg0f1RiKx3hHSmF6aXgUwWzQ
	 jrvZbKGjBKgIpQtce6eRA7SG1IbIE4IFuHXdAzpzUJdfKnm8VsRk7Fj2Wzi9xKqQL4
	 3+sSppUiODy0UAEgFTQ8ku4Sfk4tFuM/+tS4ASqDumvY/wFO+py+s3Gs2+RYMC1j2d
	 md42FhNqFKNwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 23/58] perf python: Add LiveSession helper
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-24-irogers@google.com>
References: <20260424164721.2229025-24-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 18:15:39 +0000
Message-Id: <20260424181540.4426EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Unsupported events cause an inescapable infinite loop that starves=
 the collection session.
- [High] The event reading loop fails to drain the CPU ring buffers, leadin=
g to excessive syscall overhead and dropped events.
- [Medium] A bare `except Exception: pass` block silently swallows all exce=
ptions from the user-provided callback.
- [Medium] The loop silently discards `perf.RECORD_LOST` events, preventing=
 the caller from detecting ring buffer overflows.
--

commit 8d1f04d2209b116868bc98675380c0d88ea3f54d
Author: Ian Rogers <irogers@google.com>

perf python: Add LiveSession helper
   =20
This commit adds a LiveSession class in tools/perf/python/perf_live.py to
support live event collection using perf.evlist and perf.parse_events. This
avoids the need to fork a separate perf record process.

> diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live=
.py
> new file mode 100755
> index 00000000000000..d1dcbab1150b9d
> --- /dev/null
> +++ b/tools/perf/python/perf_live.py

[ ... ]

> +    def run(self):
> +        """Run the live session."""
> +        self.evlist.open()
> +        try:
> +            self.evlist.mmap()
> +            self.evlist.enable()
> +
> +            while True:
> +                # Poll for events with 100ms timeout
> +                try:
> +                    self.evlist.poll(100)
> +                except InterruptedError:
> +                    continue
> +                for cpu in self.cpus:
> +                    try:
> +                        event =3D self.evlist.read_on_cpu(cpu)

If pyrf_evlist__read_on_cpu() encounters an unhandled event type like
PERF_RECORD_MMAP2, pyrf_event__new() returns NULL and sets a Python TypeErr=
or
before invoking perf_mmap__consume().

Because the event is never consumed, the ring buffer's tail pointer is not
advanced. The exception is then caught below, and on the next iteration pol=
l()
returns immediately. Will this cause read_on_cpu() to read the exact same
unsupported event and lock the script in an infinite loop?

Also, since read_on_cpu() extracts only one event per call, does this loop
structure require invoking the poll() system call for every individual even=
t?

If a burst of events occurs at high sampling frequencies, could this overhe=
ad
cause the script to lag and result in dropped events? Would it be better to
drain each CPU's queue completely before polling again?

> +                        if event and event.type =3D=3D perf.RECORD_SAMPL=
E:
> +                            self.sample_callback(event)

By filtering strictly for perf.RECORD_SAMPLE, this loop silently drops
perf.RECORD_LOST events.

Could we add a mechanism to report lost samples or log a warning, so the
caller can detect when the kernel's perf ring buffer overflows?

> +                    except Exception:
> +                        pass

Will this generic exception handler silently discard errors originating from
the user-provided callback?

If a user introduces a typo or logic error in their callback, the error will
be hidden. Should exceptions from the callback be logged or allowed to
propagate to terminate the session?

> +        except KeyboardInterrupt:
> +            pass
> +        finally:
> +            self.evlist.close()

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D23
