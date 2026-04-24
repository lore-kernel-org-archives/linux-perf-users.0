Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1E33E0C47
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051233; cv=none; b=rP7oJeKBRMjE/l5HWUQyRZksCIal7n8m59I2aAUQNkI0hzkXQ8lC8PCFqq5mP2UXRYTfhVMpzVZ+n2T1L9OWwLBIedNx7WXaZZx8ydQwAos98WCN2oOiJK5CiAAVQKmB47Z+WP1j//6DlSbAyGjzo81tDhUGOVszXfqxTLjkhCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051233; c=relaxed/simple;
	bh=P0ai+amYF0gga15lmvFYnMaPcZ/Qq7DsflgXxm6e9PQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YpZ+IwaJALVNEPk9mMQIid1ctjCacpJ8ugQGqoLrQ4y6DO+eKh2yNiPcqoFyqjivwBcgZyWM2AuR3NAJsx+g1SJYeMgwzilB40/sb7lj9CtU1fmkMZPRSNfoiHUHgZnE0xqRS5ZV0Yi/2AWDKRVM+nz4FnnV8sz6UcWT4S8YeTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dl/VkhaG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dl/VkhaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005C8C19425;
	Fri, 24 Apr 2026 17:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051233;
	bh=P0ai+amYF0gga15lmvFYnMaPcZ/Qq7DsflgXxm6e9PQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dl/VkhaGW+vM7uyWBowEQu8zJi7TnXA45OGCoS7LQq+Rd72mMicBQ7ipCaYRTxJkj
	 dmrG+yTxD7YNLpP1vGoRo6xIlykvyM0ysqPS135Yf5GQA75nREk4mFqtrC6O2MMg9+
	 u930YipfX2mtfl4CotpG9ka5iq6von9Oh+8njJM2aqaMODoa+gFwf1FmGK9HRsrMll
	 FkZ38VX6/et2ZXSLK//w+zw8I1w5URD68JsDmLuWrHCZ3lrZemoIlW7is6Xm+wgZk+
	 uqdgmIiPwMK0YZPP/n2nJrkU9ROnX3YxdnmDgRoSNzJYi3g22CEuljl54hjP336M8o
	 PiG2YV5SfZAUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 47/58] perf failed-syscalls: Port failed-syscalls to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-48-irogers@google.com>
References: <20260424164721.2229025-48-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:20:32 +0000
Message-Id: <20260424172033.005C8C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The event filtering condition drops `raw_syscalls:sys_exit` even=
ts due to a trailing underscore in the prefix match.
--

commit badfbafe402502cf834a49c44f2d34e63cf304da
Author: Ian Rogers <irogers@google.com>

perf failed-syscalls: Port failed-syscalls to use python module

This commit ports the legacy Perl script failed-syscalls.pl to Python using
the perf module. It uses the perf.session API to filter sys_exit events and
aggregate failed system call counts by command name.

> diff --git a/tools/perf/python/failed-syscalls.py b/tools/perf/python/fai=
led-syscalls.py
> new file mode 100755
> index 00000000000000..178c1458430a24
> --- /dev/null
> +++ b/tools/perf/python/failed-syscalls.py
> @@ -0,0 +1,78 @@
[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process sys_exit events."""
> +        event_name =3D str(sample.evsel)
> +        if not event_name.startswith("evsel(syscalls:sys_exit_") and \
> +           not event_name.startswith("evsel(raw_syscalls:sys_exit_"):
> +            return

Does this inadvertently drop raw_syscalls:sys_exit events?

The raw_syscalls subsystem provides a catch-all exit tracepoint named
exactly raw_syscalls:sys_exit, so the stringified evsel is
evsel(raw_syscalls:sys_exit). Because the startswith check includes a
trailing underscore, it seems it will evaluate to false and drop these
events.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D47
