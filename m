Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78BE33DEC2
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050182; cv=none; b=gXGUPi1lwdVxxZvRhhG2cwjAjmmskOoRG0SUlvIODjlogx7OHKkeXFAVpbfssxbtRjvtlPl6C7OKFfVH4CyGSdlR02oWr6ToQS3ncm9pQby5W+4kG4WovWXCcbZaKqz+lm/Sgpb1K0SVALQtChzl6tO0JNGgQQpF+EnGE1sDhGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050182; c=relaxed/simple;
	bh=CAiFGGzzXDwiBki/RxYHRnPEmxohjizCMCdsDBAfL2k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C2Weezp4lVB6h+ZnReVsUpUWJTYDo1GzEKvQfw/hG9wgZEVEmUOakor8DVFtgpIU0UnyPy+qFkE9Qg+mhZ7xdderyXSY3Oyk2qSrrbLwjgreAJ2x/O/ZEK92khEcX6xN7hc0wE1ri2gzmdCNl5Zdqw/1ePPSqcOuKWXD8F6o4JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvuuW+oW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvuuW+oW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC52C19425;
	Fri, 24 Apr 2026 17:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050181;
	bh=CAiFGGzzXDwiBki/RxYHRnPEmxohjizCMCdsDBAfL2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KvuuW+oWgJ3UQ5H7xzMpYTQECMj9BZI1o4G/Xj70yUngq28nzcqCxOqRAhW0TrkS1
	 XfguCTjqWTBbspeuSXtyOUD1DMiGrzR5d/Ob77UpqwZQfjm/yg3m5OjpI6S0MON4Ok
	 lw94TbqFX4II1tuGtOIsuyTC6LmCDB+IL0HUAfH2QeoUTTOHdMEq04cFu5DtCRC9ck
	 SgKBhFKZgL4w0p5kkdVNwuOw0i3t7eqopEuuaXUdv4zFD98vTLW7CuPesj2/bidySJ
	 G67fTO8QruM8UAcmpjp9wIyfguJhLVPugzUUgTqgOx9YwU3D6X0PLvT9nS5faNZL27
	 IVqm0llhbmjsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 40/58] perf net_dropmonitor: Port net_dropmonitor to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-41-irogers@google.com>
References: <20260424164721.2229025-41-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:03:00 +0000
Message-Id: <20260424170301.7DC52C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Functional regression: script incorrectly aggregates drops by the =
sample instruction pointer instead of the drop location, and missing kallsy=
ms parsing contradicts the commit message.
- [Medium] Dead code in `process_event` due to catching `AttributeError` fr=
om a `getattr` call that provides a default value.
--

commit aeda053dba70774e82fead7325506ebffb58c7b8
Author: Ian Rogers <irogers@google.com>

perf net_dropmonitor: Port net_dropmonitor to use python module

This commit ports the net_dropmonitor script to use a Python module,
refactoring it to use a class structure and perf.session for event
processing.

>     - Maintained the manual /proc/kallsyms reading and binary search for
>       symbol resolution as in the original script.

The commit message states that manual /proc/kallsyms reading and binary sea=
rch
for symbol resolution is maintained. Is this description accurate? Looking =
at
the script, this logic appears to have been removed entirely.

> diff --git a/tools/perf/python/net_dropmonitor.py b/tools/perf/python/net=
_dropmonitor.py
> new file mode 100755
> index 00000000000000..25ea2a66ed3c89
> --- /dev/null
> +++ b/tools/perf/python/net_dropmonitor.py

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process a single sample event."""
> +        if str(sample.evsel) !=3D "evsel(skb:kfree_skb)":
> +            return
> +
> +        try:
> +            symbol =3D getattr(sample, "symbol", "[unknown]")
> +            symoff =3D getattr(sample, "symoff", 0)

Does this correctly identify the drop locations? By using sample.symbol and
sample.symoff, it appears the script resolves the instruction pointer where
the sample was taken (which will likely always point to kfree_skb itself).

Should this be extracting the raw drop address from the event's "location"
payload field instead, to accurately report where the packets were dropped?

> +            self.drop_log[(symbol, symoff)] +=3D 1
> +        except AttributeError:

Can this exception handler ever be reached? Because getattr() is called abo=
ve
with default values ("[unknown]" and 0), it will return the default instead=
 of
raising an AttributeError when the attribute is missing.

> +            self.unhandled[str(sample.evsel)] +=3D 1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D40
