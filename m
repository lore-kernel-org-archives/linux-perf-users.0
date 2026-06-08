Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DC715665C
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 01:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780883475; cv=none; b=XeIC71/AXGap9rgbAEJ/k4zXlADhwKbIzBn2zwMcviealKVT3HrtU+xAy+2xyW1Kjbz1mkiiuSWZSB1S7ITAz2zZ5X7yDG4TnvMLz7t5AlWZNdCx3g5t8QVwoCAfMYb8wpIReSjNL7BiGjsDqmWtGgJ5wiOgDPVIlTSefVFw8K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780883475; c=relaxed/simple;
	bh=/pQPMuaJVEhbmipBaqsiJS6XjFxtaqd2WLFLF+g5VZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LVxYgB+Twftar5gkVbCBbp08WYn6gO607drzZdcVSAy22hjJHPLBeA+X4K/SFlyVKk/ZLdyIVmaaU7YdxgejIx2Hp9HKaUO0LbEdU0kyKCy6TWFrOfeuJn9KZ3U/jmZcU18swqIECRpW1TG0xSaENou2PX/69kmhOJIYAPkaHwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FB7mjW3U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FB7mjW3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033B31F00893;
	Mon,  8 Jun 2026 01:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780883474;
	bh=LWqrAhSSLJOiMtJFfCQGfBKsKxuQ//crcEke6HNr5E4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FB7mjW3UOumR9qEgfeVoJQKumJ3M+zAsSO0Jwjf9H8JUO6K1/Pf0PgKhQxW5b50Dp
	 o8ZE9Ga5m6vetrxVbN0Oi37NFmFraWWGL+ekCCRU7JKlCBc/1HBO4Oj6Pzh7MN87yw
	 9HB1cdgff2w6xzeunwZDw0PDD8nKExaOQmHtpTbzAVmpy9e6J/zw7RL4kZTgiRR+ka
	 ph3MwwGHqloiyiZSbY8RdXzaMm9qSM8ql7koTH2lRaky1JQ/v5Wc3ELAyY/O1EFaSq
	 WgSW5zdgGqVzk3WjjxN50rXx0hhvGNib9uHVfKDYpMEFFr64xtYTMVYDW3uvR5exAp
	 +OjHtCQAbxR9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] perf hists: Fix snprintf() in
 hists__scnprintf_title() UID filter path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260608013057.1942953-11-acme@kernel.org>
References: <20260608013057.1942953-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 01:51:12 +0000
Message-Id: <20260608015114.033B31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Stack buffer overflow in perf_pmu__for_each_event due to unchecked=
 snprintf accumulation.
--

commit 6971cf80165017520e4fc2dbee2d01c9c2ff4efb
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf hists: Fix snprintf() in hists__scnprintf_title() UID filter path

This patch fixes a potential buffer overflow by switching an unchecked
snprintf call to scnprintf. The original code accumulated the return value
of snprintf, which could underflow the remaining size on subsequent calls.

> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 811d68fa6770c..df978c996b6c2 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -2963,9 +2963,10 @@ int __hists__scnprintf_title(struct hists *hists, =
char *bf, size_t size, bool sh
>  			   ev_name, sample_freq_str, enable_ref ? ref : " ", nr_events);
> =20
> =20
> -	if (hists->uid_filter_str)
> -		printed +=3D snprintf(bf + printed, size - printed,
> -				    ", UID: %s", hists->uid_filter_str);
> +	if (hists->uid_filter_str) {
> +		printed +=3D scnprintf(bf + printed, size - printed,
> +				     ", UID: %s", hists->uid_filter_str);
> +	}

[Severity: High]
This is a pre-existing issue, but while you are fixing this unchecked
snprintf accumulation here, there appears to be another instance of the
exact same pattern in tools/perf/util/pmu.c:perf_pmu__for_each_event().

When accumulating buf_used across consecutive snprintf calls, if the first
formatted string is large enough:

tools/perf/util/pmu.c:perf_pmu__for_each_event() {
	...
	char buf[1024];
	...
	buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - buf_used,
			     "%G%s", event->scale, event->unit) + 1;
	...
	buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - buf_used,
			     "%.*s/%s/", (int)pmu_name_len, info.pmu_name,
			     event->terms) + 1;
	...
}

If the first snprintf returns a value causing buf_used to exceed
sizeof(buf), the second snprintf will execute with an underflowed limit
and an out-of-bounds destination pointer.

Could this write past the stack buffer if a crafted PMU sysfs entry is
encountered?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608013057.1942=
953-1-acme@kernel.org?part=3D10
