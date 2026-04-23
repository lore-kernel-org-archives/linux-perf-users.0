Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E33361DB4
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918672; cv=none; b=FM+zoKe/TTY4rN+J4jO+Jq+mvBs9WA7OhsjndSpoLmufD/MJxr/mZ/P+3swQytOZcyygh6m9J/3XPpixGg3a6wjeqJqT49gXAFIQc9n/WXJvvfzo70XoDqLq0WhuebNgJSIzUWXR7qDGZm/JMkpR7TVwGhWdIlgUQhfauV7hA20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918672; c=relaxed/simple;
	bh=HqjhAxetXkEZz1O+Lo5WKNTpMaGI2ZQdVCyN47AYzLU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I/4wY9A5qk4hMo0i1TO9f5wlUruDx6ru1tGrvwHqINqpZieTNWHfZfI0n+TuO0937qauCm6cKhA/MjGuctDBDlU7J4WPA72l6zlSWMqkjIHfiaztkVT/6ROnBLRPLtTExF2upnho0m67DKpgTODv0mr/4eB0FLxV8Ssd4A8F7is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAY0Bhvh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAY0Bhvh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E65C2BCB2;
	Thu, 23 Apr 2026 04:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918672;
	bh=HqjhAxetXkEZz1O+Lo5WKNTpMaGI2ZQdVCyN47AYzLU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tAY0BhvhBuUBFBetqnbKDzvFzjA/KfSF/9P/4o4DlfeWcbGNoxmdEGO/TtnGChW2q
	 bD9WGxtERlnK/0DkWBi0BtlGG+8CDFhbRXWDjpkOr7QJZHSlF80Q7nfbD7lHqWj/cZ
	 lzf7EyhYW0eMF5miT9IVCpicQW532YH4Ysr9YQsThfyEemMXl0gIApJ5j35HiZA1rA
	 AYwimLzRZfoFgE7uIl1uvfbmxJwPGqTsJ4PYEXRTxkGUcyFCASeaqWiJo24oGr1uX5
	 pUIYvzYRw0v9Ebpy+0kgGMRbBEKLw9nwf9e+71Do/5TCyyCCnnPfTB5qYCgzfutfWo
	 hU1USftiCxIvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 23/58] perf python: Add LiveSession helper
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-24-irogers@google.com>
References: <20260423035526.1537178-24-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:31:11 +0000
Message-Id: <20260423043112.05E65C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Catching exceptions for unsupported events without consuming them =
from the ring buffer causes an infinite loop and CPU lockup.
- [High] Failure to completely drain the perf ring buffer upon waking from =
poll() causes massive overhead and dropped events.
- [Medium] Indiscriminate swallowing of all exceptions in the event process=
ing loop masks user bugs.
- [Medium] File descriptors and mapped memory are leaked if an asynchronous=
 signal (e.g., KeyboardInterrupt) is delivered between resource acquisition=
 and the try block.
--

commit cf300f60bb414d0c0ad67cd1aba7027d55a4b157
Author: Ian Rogers <irogers@google.com>

perf python: Add LiveSession helper

This commit adds a LiveSession class in tools/perf/python/perf_live.py
to support live event collection using perf.evlist and perf.parse_events.
It avoids the need to fork a separate perf record process.

> diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live=
.py
> new file mode 100755
> index 0000000000000..d1dcbab1150b9
> --- /dev/null
> +++ b/tools/perf/python/perf_live.py

[ ... ]

> @@ -0,0 +1,48 @@

[ ... ]

> +    def run(self):
> +        """Run the live session."""
> +        self.evlist.open()
> +        try:

Does this sequence leak file descriptors and mapped memory if an asynchrono=
us
signal like KeyboardInterrupt is delivered between open() and the try block?

If the signal occurs immediately after open() successfully returns but
before execution enters the try block, the exception will bypass the
finally block.

Could this prevent explicit cleanup via self.evlist.close()?

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

Does this code leave events in the ring buffer?

The live event collection loop calls read_on_cpu() exactly once per
CPU and then immediately re-enters the poll() system call.

Lockless ring buffers usually require the consumer to fully drain all
pending events to maintain synchronization with the kernel producer. If a
burst of events occurs, reading them one by one will invoke a poll
context switch for every single event.

Could this massive processing overhead cause the userspace consumer to
fall drastically behind the kernel, causing the ring buffer to overflow
and result in dropped events?

> +                        if event and event.type =3D=3D perf.RECORD_SAMPL=
E:
> +                            self.sample_callback(event)
> +                    except Exception:
> +                        pass

Could this exception block cause an infinite loop and CPU lockup if an
unsupported event type is encountered?

If read_on_cpu() encounters an unsupported event type (such as=20
PERF_RECORD_MMAP2), the underlying C extension might raise a TypeError
and return early. This early return would skip the perf_mmap__consume()=20
call, meaning the kernel's ring buffer data_tail pointer is not advanced.

The Python script would then catch the exception, ignore it, and loop
back to poll(). Since the buffer still contains the unconsumed event,
poll() returns instantly, leading to a tight loop.

Additionally, does this mask user errors in the callback?

If the caller-provided sample_callback contains logical errors or raises
standard library exceptions, this block will silently swallow them. Users
will see no output and no stack trace, making it difficult to debug
malfunctioning callbacks.

> +        except KeyboardInterrupt:
> +            pass
> +        finally:
> +            self.evlist.close()

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D23
