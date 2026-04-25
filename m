Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D110438E5E9
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158703; cv=none; b=qK6SodY01z08liXs4wDhVCronTsBE4KuLTHTSOkwwaY84zwa47tOiCPsn80iI/b2HUKUAQgdDljWgvg63d70EWC+o1iCP1IiJE5ddhO5XhwphGH1YmSrvZTo1zeiq2ENwMCpYckzzBpu6hztel518PvvqUG/8+oHR3cmz8VFf88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158703; c=relaxed/simple;
	bh=V06PVJf7KeeDjJZqPO0mCE4HPN+et8YQbgyGq6yfdGw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xhp0OHuUMGvHdONVvOD0v7uiwpDCF62W0iZ21zKEvLZ0uM9egH209EytHiU9EJRgnrBjvF+tAqWs7J/KoHQqz+JmNcJHIUm+TzXZtUIF/fVRArw2cHGLAr3tN5FfB0pjTej7u1wl82uYt9pHfpozPlq1uOsHWGNHD4xVteg8RBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUpvt3iS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUpvt3iS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8691AC2BCB0;
	Sat, 25 Apr 2026 23:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158703;
	bh=V06PVJf7KeeDjJZqPO0mCE4HPN+et8YQbgyGq6yfdGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rUpvt3iSJaaMpHfpvatSdjNzbdRqyjmEFUYhg3Y3TlzpdfOUwxUi/SSkY9FS36/7a
	 n6UihkmlV7HRjhUk1rbzBAf7siflDNFhZl6N1xreJjRvbhC7OWd2Yd+1Pd/YvvgPdR
	 X1BhhLt4Z6LLtNd1d8TZDuZ0jEwFH+H0xyO8k+82RWAatpbaShG7SsG477n9GqG4Tz
	 cdRcUGNvIqqwwIQu3Hphvj3mFUtuBsm3ZzSehw1inSY33Wg69aOR5o37Wqh1tuc8XU
	 2p/OOPcyNq0g1HbJkDCXbL+oCXcybIEvLSpcq3sgaZl5fAaBJixBc606RnAeausr1L
	 HoYv3u32NZOqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 47/59] perf failed-syscalls: Port failed-syscalls to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-48-irogers@google.com>
References: <20260425224951.174663-48-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:11:43 +0000
Message-Id: <20260425231143.8691AC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Event filtering logic incorrectly drops `raw_syscalls:sys_exit` =
events due to a trailing underscore.
- [Low] The `unhandled` dictionary tracks dropped events but is never acces=
sed or printed.
--

commit 241c3a88498087d355f6d5b82a688ebb03b41ea2
Author: Ian Rogers <irogers@google.com>

perf failed-syscalls: Port failed-syscalls to use python module

This commit ports the legacy Perl script failed-syscalls.pl to a Python
script. It introduces a class-based FailedSyscalls analyzer that processes
sys_exit events from a perf.data file and tracks failed system calls.

> diff --git a/tools/perf/python/failed-syscalls.py b/tools/perf/python/fai=
led-syscalls.py
> new file mode 100755
> index 000000000000..c3b58664eb57
> --- /dev/null
> +++ b/tools/perf/python/failed-syscalls.py
[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process sys_exit events."""
> +        event_name =3D str(sample.evsel)
> +        if not event_name.startswith("evsel(syscalls:sys_exit_") and \
> +           not event_name.startswith("evsel(raw_syscalls:sys_exit_"):

Does the trailing underscore in the raw_syscalls:sys_exit_ pattern cause the
script to inadvertently drop standard raw syscall exit events? The generic =
raw
syscall exit tracepoint is typically named evsel(raw_syscalls:sys_exit)
without the trailing underscore.

> +            return
> +
> +        try:
> +            ret =3D sample.ret
> +        except AttributeError:
> +            self.unhandled[event_name] +=3D 1

This isn't a bug, but the unhandled dictionary tracks dropped events here
without ever being accessed or printed in the script's output routines. Sho=
uld
this tracked state be included in the summary table, or is the dictionary
unnecessary?

> +            return
> +
> +        if ret >=3D 0:
> +            return

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D47
