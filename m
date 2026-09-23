Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57459495504
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188565; cv=none; b=uYNjZeip3vbFX8+LrGNEl0ncRBduijixSEK29HLAZaQZGKYBxaPTkIK43fv5wGK/3RT8E4iPgz4jdaziufzhmxclbqrCDNJzKjhWLzt+SozPWTlfFlKTzn/5W8sOic04RCLBjyEnRkkcK0qvliAoEwTJZxumnT+PrRO63WBCIgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188565; c=relaxed/simple;
	bh=Mxhmn0LAluDx4JosEEBXm/Kx+i3tpHggyNupVkWGFCE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZF5z4GqBFpGJey+QVgkj/DDGx6q05vzd4MlkIPac8g51XHR8zNatyCwQ7DqNMzl+nWOAhdy9nMrekFs1ThfYqWDw2akcTzU7OOGYZyHg8+L0ab7u1/1vuHtzdjD1x8edvytT0aeifLc5l/p4YbHAheO70PXkNF514VJBSYTRnOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofWtjpqF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofWtjpqF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA3D1F00898;
	Wed, 23 Sep 2026 18:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188554;
	bh=7eRZs/UeXP1C9OLNhyOP9vk4wvoUSEKUwdbPSJV9rwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ofWtjpqFzZwPjzt16vogoWpEWR6qVO3ZwdfZCBCVyzIBmsqAUITxHRu6n/9S1ZL6f
	 qid60wptVperH9Oi6E3s+v2xBQ4s2ldPS/rGDix4oTRvzgex0S0to28zmIggUZaQTP
	 t2dDsJVh98w7u6I5VSCwbPYoy09tCfJqsYTtv0GFXgZidEE1sv1TN8YIeL+nsXoyiE
	 fsvPal89aajfa74/00bNfcx2qIo4O2P4hd9MjM/IqWeeazjp1Z+t8Hq1ZiZBa+HVgZ
	 yRRDtYMZqLM7IAZqWchTEOlCRR/MuAVh2S+iM57y4/0mE7y4EHemoRjZntGiG4i5MU
	 9OeDvlt8ERZ+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 26/49] perf python: Port sctop to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-27-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-27-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:35:52 +0000
Message-Id: <20260923183554.0FA3D1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf python: sctop silently drops legacy syscalls:sys_enter even=
ts
--

commit d8ecc80e7d73cc2057e5019382b002550902b4ce
Author: Ian Rogers <irogers@google.com>

perf python: Port sctop to perf module

This commit ports the sctop.py script to a standalone script in
tools/perf/python/ using an SCTopAnalyzer class structure. It adds support =
for
both offline analysis and live monitoring, resolves architecture-aware sysc=
all
names, and replaces unsafe signal mutation and subshell spawning with
threading locks and ANSI escape sequences.

> diff --git a/tools/perf/python/sctop.py b/tools/perf/python/sctop.py
> new file mode 100755
> index 0000000000000..fb709206993a1
> --- /dev/null
> +++ b/tools/perf/python/sctop.py
[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Collect syscall events."""
> +        if not self.offline and sample.sample_pid =3D=3D self.own_pid:
> +            return
> +
> +        name =3D str(sample.evsel)
> +        # raw_syscalls:sys_enter exposes the syscall number as 'id', whe=
reas
> +        # per-syscall syscalls:sys_enter_* tracepoints expose '__syscall=
_nr' (or 'nr')
> +        # and may have an unrelated syscall argument named 'id'.
> +        if name.startswith("evsel(raw_syscalls:sys_enter"):
> +            syscall_id =3D getattr(sample, "id", -1)
> +        elif name.startswith("evsel(syscalls:sys_enter"):
> +            syscall_id =3D getattr(sample, "__syscall_nr", -1)
> +            if not (0 <=3D (syscall_id & ~0x40000000) <=3D 0xffff):
> +                syscall_id =3D getattr(sample, "nr", -1)

[Severity: Medium]
Will this silently drop legacy syscalls:sys_enter events?

When processing an event named evsel(syscalls:sys_enter), it matches this
elif block intended for per-syscall tracepoints like
syscalls:sys_enter_openat. This path expects the syscall number in
__syscall_nr or nr.

However, the legacy syscalls:sys_enter tracepoint (used by older kernels
like RHEL6) stores its syscall number precisely in the id field. Since this
block avoids fetching id, syscall_id will evaluate to -1, causing the
script to silently drop the event and report empty totals.

Could the prefix match be updated to distinguish the legacy tracepoint from
the per-syscall variants, so we don't drop events from older perf.data
files?

> +        else:
> +            syscall_id =3D -1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D26
