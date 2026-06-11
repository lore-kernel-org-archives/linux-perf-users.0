Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541FF374E7F
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 23:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219547; cv=none; b=hR8jjSJwWZ7f+k4dGYMPbhcs76eXtgZBKk72+rMD9DpsnLdbqJ2aEBac+X6dJv8gMRwlNG4xnm3Z4zrwI+K7YCCcezlAJHUzfRwZ2nVG1s3G4/1A05Ki5HOiSpqqEbT3blOou8BZbKHyyhFHmpJl6n28UUFT9tRb+SUwy4Xkcaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219547; c=relaxed/simple;
	bh=+bNlIVdU98CNlUvS0e1v45+LSTrwMpdELVXz0VF/NMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n1bCLJ9d4ZgFaFA8k/QAWnKZJpsjS/8erKX3gI1pMymucYNRda+dim55i1njxHohhDg8hEb6XzdZ9YYqmx8WLE6C9no4EdKK6E0qZjga9juswfmI1JBwi3lBvMjjn/uNod7QB/X8nax+mTZTodZ0lkb/ITniWTM3Zr47v9uGGwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1v3eSRJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1v3eSRJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147DF1F000E9;
	Thu, 11 Jun 2026 23:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781219546;
	bh=u9Tvbt7nKk5Eb1rtQ7xPmp1sDepROFM/R4valaqfQmw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f1v3eSRJ2ybc3GiTpZdp5RXkJIYLPmksFo6ZeJPAfI4OZDTXnQl7XZqjcN9CgZJVU
	 0UgLTZJTvpz4zp9YL9tTemDVoh/WoVXaWIBhMTNjbQ6zNdfPk0fdle011g+Agrz3P4
	 l5eaVbMSO0u4X2PVii7tj4VGG+rHkyYxV/CSL33mLx73DtK8TU1iSmnDcglv9Tpz5h
	 jayqF8Ei2RpZdJVj4t6AGNCxlvYD7qLuFm4zd2fUK0juiRSB1B6/xjazwskpB56rc1
	 Q5MGuunlRbS7JAWhygcakjSeYS9Ij93YiT99dHzyahOGTY9wJg4PFHMxKHwG09Uxfg
	 9c/tTEMtcG2eQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 19/19] perf python: Add LiveSession helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611224455.201994-20-irogers@google.com>
References: <20260611224455.201994-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 23:12:25 +0000
Message-Id: <20260611231226.147DF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] LiveSession.run() crashes immediately on empty ring buffer due to =
incorrect errno attribute check.
- [Medium] Using `continue` inside the 1000-event inner loop causes an expe=
nsive busy-wait retry loop for offline CPUs.
--

commit 8298891aaf516d3f5649df308e23fe24d2333a36
Author: Ian Rogers <irogers@google.com>

perf python: Add LiveSession helper

This commit adds a LiveSession class in tools/perf/python/perf_live.py to
support live event collection using perf.evlist and perf.parse_events. It
allows collecting events without needing to fork a separate perf record
process.

> diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live=
.py
> new file mode 100755
> index 0000000000000..7455f60d21157
> --- /dev/null
> +++ b/tools/perf/python/perf_live.py
[ ... ]
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
> +                            # CPU might be unmapped or offline, wait for=
 mmap event
> +                            continue

[Severity: Medium]
Will this 'continue' statement cause the script to busy-wait by retrying the
same offline CPU 1000 times?

Since this is inside the inner 'for _ in range(1000):' loop, it skips to
the next iteration of the inner loop rather than moving to the next CPU.
Should this be a 'break' instead?

> +                        except OSError as e:
> +                            # Ignore -EAGAIN on empty buffer
> +                            if e.errno =3D=3D errno.EAGAIN:
> +                                break

[Severity: High]
Does checking 'e.errno =3D=3D errno.EAGAIN' cause a crash when the ring buf=
fer
is empty?

The underlying C extension (pyrf_evlist__read_on_cpu) uses PyErr_Format to
raise this OSError when perf_mmap__read_init returns -EAGAIN. Because
PyErr_Format initializes the exception with only a format string, the
Python exception's '.errno' attribute is implicitly None.

This causes 'None =3D=3D 11' to evaluate as false, falling through to 'rais=
e e'
and crashing the live session instead of ignoring the empty buffer.

> +                            # OS/mmap errors are unrecoverable
> +                            raise e
> +
> +                        if event is None:
> +                            break
> +
> +                        if event.type =3D=3D perf.RECORD_SAMPLE:
> +                            self.sample_callback(event)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611224455.2019=
94-1-irogers@google.com?part=3D19
