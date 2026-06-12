Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4448F36654C
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304069; cv=none; b=XhX7jeBusUKAl9BV8F9D703M8k+qkn2Mcv5ROHJ45vvB99K1S1JRcNQMVLZw8TQHX5tUDYO5Svgqa84P4dZoQE5NkY2+xM2WpdNvMYk8A3HZV8QrwXhaCJ0+Y4XqX7sdbMTQsJFd+/qZYD33LlEqEBkwI87oiNCqjZlKo3+YlHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304069; c=relaxed/simple;
	bh=8E2KI3YBTsUPnOwUjG+YpGT4+u7XlHfQ5VQSZmmh/9o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n4+m5sOc9zm2rfpuyQCybzluWhIYKhTKTCaV1iRYd3iK1yoPrL+x4xF8X9DTA6KFujyGGcnhrVPZcKFBVwL1txHEidPshDv6ijOs6N7omWPVexJfdHA+Z7q0ecqpXRFIbTKPnLfY4WgTZbdRzgkuKteVs8m1iGIuLmiaJMKp+Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPklvk1z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPklvk1z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD63C1F000E9;
	Fri, 12 Jun 2026 22:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781304067;
	bh=BaDGCmSRxlhKD0OpBKhfB1QFIaLU5tGFlOMiJgCZS9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gPklvk1zsj+nyJP1vbfqcTsZpeRBhUXF8NKtLJUqDgLKOEkqUZiWs8IOwARZddxkP
	 zGSOT2+Qqn+vH8jXQqshbzmFdkclZJ7cyWYqPxmZ8ub70uYoS++YCdQ7vYJ95sGH6m
	 q7A2uyXDfbkgbFiSL6FcfZ2r7BpFliS7bZZR3POIVebGyYIU6sZPZDg7bTeIj3i/BA
	 2ZMiGR2pj3EK6SuhLRN2wSWYyv8UZ+JVFap2gAEtOBGDxvjoE1YJvHjU0psochcdnQ
	 QzmaohAXcuzsJ8syrX6UsTP2UBEC8leRa5f8KEI0k4CGcY9XDTSmiBEmrSzrJAl0b8
	 yKhFu2BUNlExw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 19/19] perf python: Add LiveSession helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612221211.1221305-20-irogers@google.com>
References: <20260612221211.1221305-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 22:41:06 +0000
Message-Id: <20260612224107.AD63C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] LiveSession will crash immediately with an unhandled OSError when =
polling CPUs that have no events.
--

commit c35bf37eb5bab2d0b282f5de633a0eb0e03997ea
Author: Ian Rogers <irogers@google.com>

perf python: Add LiveSession helper

This commit adds a LiveSession class in tools/perf/python/perf_live.py to
support live event collection using perf.evlist and perf.parse_events,
avoiding the need to fork a separate perf record process.

> diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live=
.py
> new file mode 100755
> index 0000000000000..fd049933a052e
> --- /dev/null
> +++ b/tools/perf/python/perf_live.py

[ ... ]

> @@ -0,0 +1,55 @@
> +            while True:
> +                # Poll for events with 100ms timeout
> +                try:
> +                    self.evlist.poll(100)
> +                except InterruptedError:
> +                    continue
> +                for cpu in self.cpus:
> +                    for _ in range(1000): # Limit to 1000 events per CPU=
 per poll to prevent starvation
> +                        try:
> +                            event =3D self.evlist.read_on_cpu(cpu)
> +                        except TypeError:

[Severity: High]
Will this crash with an unhandled OSError when polling CPUs that have no
events?

The underlying C code pyrf_evlist__read_on_cpu() raises PyExc_OSError when=
=20
perf_mmap__read_init() returns -EAGAIN for an empty buffer:

tools/perf/util/python.c:pyrf_evlist__read_on_cpu() {
        ...
        if (err < 0) {
                return PyErr_Format(PyExc_OSError,
                                    "perf: error mmap read init, err=3D%d",=
 err);
        }
        ...
}

Since evlist.poll() wakes up when any CPU has events, iterating over all
CPUs here will likely hit empty buffers on some CPUs, raising an OSError
that isn't caught by this try/except block.

Should OSError also be caught and handled here?

> +                            # CPU might be unmapped or offline, wait for=
 mmap event
> +                            break
> +
> +                        if event is None:
> +                            break
> +
> +                        if event.type =3D=3D perf.RECORD_SAMPLE:
> +                            self.sample_callback(event)
> +        except KeyboardInterrupt:
> +            pass
> +        finally:
> +            self.evlist.close()

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612221211.1221=
305-1-irogers@google.com?part=3D19
