Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B2C263F4A
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 22:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984209; cv=none; b=nCoW0S1QbAR97xXtxMCOcrg0O6x3kLFMXWV7W5Xu3WSUvrUqtRt83P+QycLdYsAJ/siZjDxmwpA/VWRrptegEhyrwDuCq1PymIrMC7l+4sB1Ovn0oYQ9gkemePrQnOB3iN2ARlJWKogQPVp2LHNZQxYsrJ/vbBJwrfHXXsANR5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984209; c=relaxed/simple;
	bh=w+C5RCmGrCnGyK6yall2TFJyEPu+dnkwap2KpE+PaXw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QcNHAt26bICeuFd/nm9jQLEsdotY9JwqfymDue3qTJXp1YW5/U1XV6M+uVED8yOs5W56CoKv9tkXyLIynAhJbboQgd4F668ka3aIw0ackJz0jGFa8g04carDlMFug4h5dfsSR+DS560C78ss1oVo8y9H4yjXoCLGUZP0bdvnpys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ngj2e8kd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ngj2e8kd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14907C2BCAF;
	Thu, 23 Apr 2026 22:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776984209;
	bh=w+C5RCmGrCnGyK6yall2TFJyEPu+dnkwap2KpE+PaXw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ngj2e8kdjxehOm6a/USSoZV6So8lWSPPWpDtw54UQbfijTNfDeNRzX1PgY7O06lxJ
	 8rfzcU+DQZZ3Sp5ioesl7Zrw4nuGnoIP5z0kqPHvTXRwx4Usv0clwJ2wl/LtHtG+o1
	 LWsMbkH6PmOmdu17/v42AAZ3IgVU1Eb9ZsUz7/731M+W/DGUZw0yq2ebWOCSApuyI+
	 O9mrVIdDwYMu8Gl3UPqzS0BDIAkjl6WOjbFF1HJNHjQQZ80xWz7I/vUjrOyp7z6saY
	 sUgWA4tcb2xnoq5EUwDyFeJd/hyGGrLN7A5AEVzqm06Nr3XIB+Fgr0FArm3bmVcQ7c
	 O6JASus+uuEeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf trace: Introduce --show-cpu option to display
 cpu id
Reply-To: sashiko@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423194032.134416-1-atomlin@atomlin.com>
References: <20260423194032.134416-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 22:43:28 +0000
Message-Id: <20260423224329.14907C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The `--show-cpu` option fails to print the CPU ID for interrupte=
d system call entries, resulting in lost information and broken columnar al=
ignment.
--

commit f837c4ea902d9b8f1e88b211cf0a2320cd3c7a26
Author: Aaron Tomlin <atomlin@atomlin.com>
perf trace: Introduce --show-cpu option to display cpu id

This commit introduces the --show-cpu option for perf trace. It extracts=20
the CPU from the perf sample and prints it alongside the timestamp to=20
better trace system-wide workloads.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 311d9da9896a41..820b0a304ff90f 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c

[ ... ]

> @@ -2704,7 +2729,9 @@ static int trace__printf_interrupted_entry(struct t=
race *trace)
>  	if (!ttrace->entry_pending)
>  		return 0;
> =20
> -	printed  =3D trace__fprintf_entry_head(trace, trace->current, 0, false,=
 ttrace->entry_time, trace->output);
> +	printed =3D trace__fprintf_entry_head(trace, trace->current, 0, false,
> +					    ttrace->entry_time, (u32)-1,
> +					    trace->output);

When a system call entry is processed in trace__sys_enter(), it is often
buffered (ttrace->entry_pending =3D true) so it can be combined with its
exit event on a single line. Does hardcoding (u32)-1 here cause the CPU ID
to be lost when a pending entry is interrupted?

Since trace__fprintf_entry_head() skips printing the CPU ID entirely when
the cpu is (u32)-1, it appears this will omit the CPU column for interrupted
entries (which print with " ..."). Could this break the columnar alignment =
of
the output?

Would it be better to extend struct thread_trace to store the cpu ID from t=
he
sample during trace__sys_enter(), so it can be accurately printed when the
entry is flushed here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423194032.1344=
16-1-atomlin@atomlin.com?part=3D1
