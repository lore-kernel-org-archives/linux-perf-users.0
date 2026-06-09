Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0885274650
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 01:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967900; cv=none; b=EgVdloqAp6qzZRsI2KSnVIEm4MQaFCBCbDFDBIrbKDTc1xoZbyT5HmDI5t/dobvy/jDZvP4LS/lO9C8e4vaKEb/72hRibQCI/xQksIeOwpN78vYY9oyFk9jygnYziUz+AmOjLWOpzAsk/lK6JXX+hh+5xW8jzjcRrt64C+Bl1ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967900; c=relaxed/simple;
	bh=8tfoGl82nHl6vOEcRCovXyFZmv5QlwETjDfU98VeawY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hShqDbbQHVBUaOyw506AO2BAfJZXZxi3sw37t52sb7uPAwXWXeS+L7qhWp89JiWA8TndWHkZxlKsAoseFUYUw5EZi9eEN/065TmN5V4lP0AuLFjhlPP6j7nGibnzDTxQC81W8x57Ff5eEyKJE1OIJTNGnWpCGwzjYD+IsdpURVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxY+kvAh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxY+kvAh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00151F00898;
	Tue,  9 Jun 2026 01:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780967898;
	bh=c2uOoHGLA6GH+HU14lll793LtavK9D5lmhHRnmZsGjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oxY+kvAhQewxRcSMa7srGw9FKtjOSmpcjJkRmw7Rd1OzfevTPp6nV8Y7dfX8u7dVs
	 3uyVYY3eSDQAaYrDZZZS+SZB7/r0KPAt3dbg2l5t7h0Q/jtk/tgN6Y3L0Pkn5bxcSK
	 0PiJS3M96li2EBf+4QF6pT42B57RUgsDvz5xzf7RQBvNn9s1R777EDcMAYYO0wE/r8
	 FFFpmLUDkVNrgnhZpf+jRctEvXswRQd+/Tu34sOb+wWg1U2dbftwKjNvWywVoSpx+V
	 jqzykV2k3JTTrEFN9koy6th4irtK6pACPybdCOi+zso5Mc+MwHBnMugRkjA6NL+EG1
	 cH0QhRj8T83qQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/11] perf bpf: Use scnprintf() in snprintf_hex() and
 synthesize_bpf_prog_name()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609010526.1998472-9-acme@kernel.org>
References: <20260609010526.1998472-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 01:18:18 +0000
Message-Id: <20260609011818.B00151F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Accumulation of `snprintf` return values combined with fixed incre=
ments causes buffer size integer underflows, leading to a stack buffer over=
flow in `perf_pmu__for_each_event`.
--

commit 9c31711b5b63e0f7c6e422153e389b761e114baf
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf bpf: Use scnprintf() in snprintf_hex() and synthesize_bpf_prog_name()

This patch fixes a potential buffer overflow by switching from snprintf() to
scnprintf() during formatted output accumulation. This prevents the remaini=
ng
buffer size from underflowing if the output is truncated.

> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index a27945c279efb..2c09842469f1f 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c

[ ... ]

> @@ -153,9 +153,10 @@ static int synthesize_bpf_prog_name(char *buf, int s=
ize,
>  			short_name =3D info->name;
>  	} else
>  		short_name =3D "F";
> -	if (short_name)
> -		name_len +=3D snprintf(buf + name_len, size - name_len,
> -				     "_%s", short_name);
> +	if (short_name) {
> +		name_len +=3D scnprintf(buf + name_len, size - name_len,
> +				      "_%s", short_name);
> +	}
>  	return name_len;
>  }

While we are fixing snprintf() accumulations here, there is a similar
pre-existing issue in tools/perf/util/pmu.c:

tools/perf/util/pmu.c:perf_pmu__for_each_event() {
...
		info.scale_unit =3D NULL;
		if (strlen(event->unit) || event->scale !=3D 1.0) {
			info.scale_unit =3D buf + buf_used;
			buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - buf_used,
					"%G%s", event->scale, event->unit) + 1;
		}
		info.desc =3D event->desc;
		info.long_desc =3D event->long_desc;
		info.encoding_desc =3D buf + buf_used;
		buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - buf_used,
				"%.*s/%s/", (int)pmu_name_len, info.pmu_name, event->terms) + 1;
...
}

[Severity: High]
This is a pre-existing issue, but the same pattern is present in
perf_pmu__for_each_event().

Because snprintf() returns the length it would have written rather than the
amount actually written, and we unconditionally add 1 to it, buf_used can e=
xceed
sizeof(buf).

When buf_used exceeds sizeof(buf), sizeof(buf) - buf_used will underflow to=
 a
large positive size.

Could the subsequent snprintf() call use this massive size limit and write =
to
the out-of-bounds pointer buf + buf_used, overflowing buf[]?

Other similar bugs in hwmon_pmu.c and hist.c appear to be fixed in subseque=
nt
patches of this series, but pmu.c seems to remain vulnerable at the end of =
the
series.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609010526.1998=
472-1-acme@kernel.org?part=3D8
