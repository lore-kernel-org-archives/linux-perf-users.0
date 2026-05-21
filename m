Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683A134CDD
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 04:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779338308; cv=none; b=WlmLfm+QgY8bjdlHSXU4uNg71LpFEpf3IYfYZZ9aGvcuyROpXjO1Z9W90q0nD7c+nVMR6NZcn5HfzaLWuIM9vDv1nr51nNccr020+Qpclf0j1ERffT2c4etuFW92o61DzKY+QTA9fEamhZwg7JFuW/y/WzpOY513LPDwFWN99Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779338308; c=relaxed/simple;
	bh=Zv76zB1ZmCSq/KZq/OgwMF614YSKrMBpQiA4nIpLPQg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R8nyN02q1YS2LUb1VfvqrGdT2MfUYa6eeLE+eSP9iyDzjGBPQdMSSmwZLRzNw2LNuG6BjRhaBJMYyUgCRscY5pwv5jo2TqVwaB+flMYdXoNTYzbaOLcz81Ezh1LAWX4zhDpQBh7zwMxlTU2LZOTWmkQmANIUfud3qXCfKK1DjfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xvd+DNDS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xvd+DNDS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77E81F000E9;
	Thu, 21 May 2026 04:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779338307;
	bh=GGQkUXxH8FMSPL2Zke+vTsINItlPJPM7nZ4981M9/WY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xvd+DNDSeg3iHOJLmDDELQImzWI+uiWfVYkTAmHmcvJZxpuMSIeXPZ8fWnDZX3UPk
	 gf6smcWnFHmull4RICf412TvaGoQ4b+B0J+BmFuDKQzORzXG9xO/lht5HedspImc9l
	 dAeNU7cG8nCb6B782p5Z0LgSFoC5uDlLzIyD6+THm0YYVhr34TPSobtrYoIk6NbTOU
	 UI61TcahAiyVU0EycfiYcpB5vOq6j0zvbnaqVJjkV10fCp7MNf08KiQahdKMfU+wCc
	 ufdxfBYxjcQ17CdJtFJ7H2HYxrdXbxVVHivvnbS4OwAuSFBwmO4RZ/7Ak7g3GdAo2D
	 98HmboL2BmxCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf stat: Use aggr_nr scaling for Intel uncore
 miss latency metrics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260521035941.3860145-3-ctshao@google.com>
References: <20260521035941.3860145-3-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 04:38:26 +0000
Message-Id: <20260521043826.E77E81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unnecessary and factually incorrect pylint disable comment for aggr=
_nr.
--

commit c584f803c073e5092cdaff15ea134a588cfc9a0a
Author: Chun-Tse Shao <ctshao@google.com>

perf stat: Use aggr_nr scaling for Intel uncore miss latency metrics

This commit updates the python metric generator to support the new aggr_nr
keyword. It also replaces the usage of source_count with aggr_nr in
IntelMissLat so that uncore latency metrics scale correctly on multi-socket
and SNC systems.

> diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metr=
ic.py
> index 585454828c2fe..25d73256be517 100644
> --- a/tools/perf/pmu-events/metric.py
> +++ b/tools/perf/pmu-events/metric.py

[ ... ]

> @@ -577,6 +577,12 @@ def source_count(event: Event) -> Function:
>    return Function('source_count', event)
> =20
> =20
> +def aggr_nr(event: Event) -> Function:
> +  # pylint: disable=3Dredefined-builtin

[Severity: Low]
This isn't a bug, but it looks like this pylint directive might have been
copied from another function. Since aggr_nr is not a Python built-in, is
this disable comment needed here?

> +  # pylint: disable=3Dinvalid-name
> +  return Function('aggr_nr', event)
> +
> +
>  def has_event(event: Event) -> Function:
>    # pylint: disable=3Dredefined-builtin
>    # pylint: disable=3Dinvalid-name

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521035941.3860=
145-1-ctshao@google.com?part=3D2
