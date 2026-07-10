Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79D932B131
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783662433; cv=none; b=VEYikfqS+NIUSjyPpUBMEtl5WQlsVKi+9VQm3+L8B28qgugUMCX5FLWgI7mcegr/rfSU7yMbFT/wFNhK7q96xuUZdrf1bLKbBd8HHkYIGQAKt2g3hjdjqtsx3ppnSRQ9ltBUpIbjfNzJQSzuJvYuMyibKIg5luUvHjagiq/jmlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783662433; c=relaxed/simple;
	bh=UTa7v7Iex0xYObBwjn0ZYH0vIt5xbqpnJ2MOWl6t7Ss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uwxrYweCmqEHB0jXiR0Kj8XRWvTGsmqJ1N/+amSPsdiMpF7fyNehtYbqBL32EUxvYhdHI/lNdwlftKQXiZCXwDmSxPzyBghZRjBIx4oX4ceCGa4b+UALvWmjnf01LiB+sbqwq/rzYCa7Zc8BULkcmJSF7pO9FiXnROvO8hnIaaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhEogjqO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhEogjqO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF731F000E9;
	Fri, 10 Jul 2026 05:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783662431;
	bh=/LyQPBv7JFGJBG0FOHyCQVrGTDugWlLgq0j1ePLTcKA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fhEogjqO3emimKmNQMJXSetEuTnzazQY9qqDNfsK9AEfnQIG5bBMzMGtDhudGfrB3
	 ZkuRR9sZijQRi2nuUPGjEf12+CEaQSYbYqzLWtr2ln1/L0Sui2/yOC+Umnfsbjsntb
	 sLjabaModfSrhxPnJOGqipT9Tqeq/mKTy9YZ0AHdXIxnoBZKjvtz45mQWNly5czuyv
	 V05LCE43A1V/SImCNktvJ028qloh/3Fv1JMd/djvQO6z9MPKQ9JctDfOsXCu173x6L
	 hi+l2ZCaoDwpXOiSVYcoYBSSMeQ/zL5AhsICS2Zc833gflxxnUH1cIpnbxpF2Jgh7g
	 birOmSLcm8w0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] perf cap: If capability is missing still perform
 root test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710053927.1864021-2-irogers@google.com>
References: <20260710053927.1864021-1-irogers@google.com>
 <20260710053927.1864021-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 05:47:10 +0000
Message-Id: <20260710054711.5FF731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The capability fallback logic overrides valid capability checks fo=
r root users and incorrectly short-circuits sequential capability checks fo=
r non-root users by improperly setting the `used_root` flag.
--

--- Patch [2]: [PATCH v1 2/2] perf cap: If capability is missing still perf=
orm root test ---
commit 8515c6747c6ffb6d27af14829f03c002334e5c67
Author: Ian Rogers <irogers@google.com>

perf cap: If capability is missing still perform root test

This commit refines the capability checking logic in perf_cap__capable() to
fallback to the used_root test if a capability is missing, rather than only
doing so when the capget syscall fails.

> diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
> --- a/tools/perf/util/cap.c
> +++ b/tools/perf/util/cap.c

[ ... ]

> @@ -37,12 +38,21 @@ bool perf_cap__capable(int cap, bool *used_root)
>  	if (cap >=3D 32) {
>  		if (header.version =3D=3D _LINUX_CAPABILITY_VERSION_3) {
>  			cap_val =3D data[1].effective;
> +			has_cap =3D (cap_val & (1U << (cap & 0x1f))) !=3D 0;
>  		} else {
>  			/* Capability beyond 32 is requested but only 32 are supported. */
> -			return false;
> +			has_cap =3D false;
>  		}
>  	} else {
>  		cap_val =3D data[0].effective;
> +		has_cap =3D (cap_val & (1U << (cap & 0x1f))) !=3D 0;
>  	}
> -	return (cap_val & (1 << (cap & 0x1f))) !=3D 0;
> +
> +	if (has_cap) {
> +		*used_root =3D false;
> +		return true;
> +	}
> +
> +	*used_root =3D true;
> +	return geteuid() =3D=3D 0;
>  }

[Severity: High]
Does setting *used_root =3D true unconditionally here when a capability is
missing break sequential capability checks for non-root users?

For example, if an unprivileged user lacks CAP_SYS_ADMIN, this will return
false but set used_root to true. In callers like perf_event_paranoid_check(=
):

tools/perf/util/util.c:perf_event_paranoid_check() {
    ...
    if (!used_root && perf_cap__capable(CAP_PERFMON, &used_root))
    ...
}

If a previous check for CAP_SYS_ADMIN failed and poisoned the used_root
flag, won't it cause the subsequent check for CAP_PERFMON to be skipped
entirely?

This pattern appears in other locations as well, such as
check_bpf_filter_capable() where a failed CAP_BPF check might skip the
fallback for non-root users to access root-pinned BPF filters because
!used_root evaluates to false.

Additionally, could this override valid capability drops for root users
in containers? Because geteuid() =3D=3D 0 evaluates to true, it seems this =
might
falsely claim root users still possess the capability even if it was
explicitly dropped, potentially leading to later failures instead of
graceful fallbacks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710053927.1864=
021-1-irogers@google.com?part=3D2
