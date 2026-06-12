Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43F1369D43
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289413; cv=none; b=gzKHD8KRWxEuvSBDfXsRoF6RpkTiFmjKaeOO20DhklqUoR6LRG+CzjCerSbfbGELY4Vm7sdSC5lrRvdXzykHV6rzHnkvTRxyPLfZpTpDqgh00R3qgjVjhgzl5hd2+P3UhJa6jQBmbou3RGV3S992LuK0mbAcCUV1wXRYXjC1mx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289413; c=relaxed/simple;
	bh=0+Z3BwyCEv6hdweQUhV95ZGWB/z221sbhlS5CWQQiDA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Urd1iou5i8gzps/YldTkwqi5a8cCKOJlD7g7u1tmhMibH7Pe9SGTLHiKLu0N+/IihpsPuWN+sT3MkJBrft4uC0JCFuZkW0YaGiIhQc/UJJvmAAj14I4MjVQCGKZpJx6WPTPeWY56mnkZTTSYl65Bg8q4RmupEz1gkVX+ayJQVug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2mBEHb2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2mBEHb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F681F000E9;
	Fri, 12 Jun 2026 18:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781289412;
	bh=77hiigVXtw6AlK4I0YvTW+CUiyNG4Y56OmgIwDlBFa4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J2mBEHb2YdROXA0VvAKBxzUyfMyJUuCzckeSaY4+LYczWTrmdVcRc5JBtbfKZlWBS
	 y/FUL+LDzI+VmTqy2BIDIupcOUAnWk3UT+ry8DzsxBq2mhJviThFmU/LK3yOXgTWUk
	 dvxcd6jK3FHEgANBU2eGNKRnXjEqZlYUHutPioCT1WwHzX+BJ9EcpviGWIy1QeI5WN
	 OLYQiExoLrqPmVt5BTTXZRQTowWA1LNmfqveW5gTkiTAU+JplWNwhGU8z59dLJMx0n
	 p30Owsfh2pErbcSExkER1uLs+jYXqTpVllkkDc4QxbPO2a/kouVCfBLl2y9wIGcDoR
	 tD2XRXFQS5sxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 19/19] perf python: Add LiveSession helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612180956.1105352-20-irogers@google.com>
References: <20260612180956.1105352-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:36:51 +0000
Message-Id: <20260612183652.62F681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] LiveSession.run() crashes with an unhandled OSError when read_on_c=
pu() encounters an empty ring buffer.
--

commit 4826fb91a8d2846998d0841e7b023eb935dd9b06
Author: Ian Rogers <irogers@google.com>

perf python: Add LiveSession helper

This commit adds a LiveSession class in tools/perf/python/perf_live.py to
support live event collection using perf.evlist and perf.parse_events. This
avoids the need to fork a separate perf record process.

> diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live=
.py
> new file mode 100755
> index 0000000000000..fd049933a052e
> --- /dev/null
> +++ b/tools/perf/python/perf_live.py

[ ... ]

> +    def run(self):
> +        """Run the live session."""
> +        try:

[ ... ]

> +                for cpu in self.cpus:
> +                    for _ in range(1000): # Limit to 1000 events per CPU=
 per poll to prevent starvation
> +                        try:
> +                            event =3D self.evlist.read_on_cpu(cpu)
> +                        except TypeError:
> +                            # CPU might be unmapped or offline, wait for=
 mmap event
> +                            break

[Severity: High]
Will this loop crash with an unhandled exception if the ring buffer is empt=
y?

The underlying C function perf_mmap__read_init() returns -EAGAIN when the
buffer is empty, which the Python C extension pyrf_evlist__read_on_cpu()
translates into an OSError.

Since this try block only catches TypeError, won't the OSError bubble up and
abruptly terminate the live event collection loop?

Should this also catch OSError to cleanly break out of the loop instead?

> +
> +                        if event is None:
> +                            break

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612180956.1105=
352-1-irogers@google.com?part=3D19
