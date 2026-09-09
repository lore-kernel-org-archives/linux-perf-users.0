Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E26345CAA
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 03:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788923461; cv=none; b=dxlo2ZVkFBZDcX0lOF6A+LbBXUfkwEmMaYe7+plaWR7Ir6Byq3yz6Gg8OSoDkg9FzKYf5BMRcjgMImkgpFORtITo8iN5yw1CfCHqjzvTd9TDuMQKZtw7QoL8gJgATbx+hZ8oMej40CwuTuH6143jxUwhqk3REd85ZEbC1lQ1KwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788923461; c=relaxed/simple;
	bh=vLMLhLbN7ZYKfuYlV4+1eH7MwDNRF7MN8l3IlqDjBo8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eHP6TLviOnplEJpkq7jUAToJEJsbVCGMIXmZkJwSWUbT4BhN+9Zovwxtm0iXH/dOZRno9+CHbVMXjPatAFjvUcvquU7WN5FUfrAj+jLFs71J+yxcBKHHe5tee+JzAeCEsCsb44H/KIgAHeSiZiZ6ktIT9gsdtmzGX7hhYJJqjT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUaXS/7l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUaXS/7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BA31F00A3A;
	Wed,  9 Sep 2026 03:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788923457;
	bh=78bV7Cc6T6RPw1JupOwe5R5dEeFkv50wju1MToYT3+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DUaXS/7l/M4hGYT4qfO2DMJFqAuXyhlsAJYBjhlravHDnLUbYo//jiMDAXB9gVzMQ
	 HPYPBiLfwpm/51L/lUTawFXw4P3721Dbe2Rraq+01PWEVw0ry6fdcAiIHF2v0cv7vW
	 8A3NInwCWJ2yOKLrK6E7NG/LBIp3/365v2cEn/3dSYvIe20QPwf8ic6I6IPtOaLou6
	 27oRSnKwUZdzrSLQKYeTA9788U0ajCBTnLs6fhqBH326uxGkmWemWZdf5q98Ixvg3S
	 4OnRqIpx5LmANZiC9VlDAbCTTO+N6AOxOMmt5ek18eVT+C+wM0aO4vDA2C7lXh0acG
	 MRKzfVIWzC59w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/3] perf tools gtk: fix two hierarchy-view stack
 buffer overflows
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260908-perf-gtk2-v8-3-e90d5d155f0d@gmail.com>
References: <20260908-perf-gtk2-v8-0-e90d5d155f0d@gmail.com>
 <20260908-perf-gtk2-v8-3-e90d5d155f0d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 03:10:57 +0000
Message-Id: <20260909031057.90BA31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential stack buffer overflow when writing to `col_types` array =
if `nr_cols` exceeds `MAX_COLUMNS`.
--

commit d31e2f191655501641db6dac561539e4edaedb03
Author: Matt Turner <mattst88@gmail.com>

perf tools gtk: fix two hierarchy-view stack buffer overflows

This commit fixes two stack buffer overflows in the perf GTK hierarchy view.
It tracks the write offset and uses scnprintf() to prevent buffer overflows
when building merged column headers. It also clamps the value passed to
advance_hpp() to prevent size underflows during entry formatting.

> diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
> index 716dcf02bd0e8..80df3fec8ea13 100644
> --- a/tools/perf/ui/gtk/hists.c
> +++ b/tools/perf/ui/gtk/hists.c

[ ... ]

> @@ -505,6 +516,7 @@ static void perf_gtk__show_hierarchy(GtkWidget *windo=
w, struct hists *hists,
>  	GtkWidget *view;
>  	int col_idx;
>  	int nr_cols =3D 0;
> +	int ret;
>  	char s[512];
>  	char buf[512];
>  	bool first_node, first_col;

[Severity: High]
This is a pre-existing issue, but while looking at
perf_gtk__show_hierarchy(), can this code overflow the col_types[] array?

Further down in perf_gtk__show_hierarchy(), the code does:

	hists__for_each_format(hists, fmt) {
		if (perf_hpp__is_sort_entry(fmt) ||
		    perf_hpp__is_dynamic_entry(fmt))
			break;

		col_types[nr_cols++] =3D G_TYPE_STRING;
	}
	col_types[nr_cols++] =3D G_TYPE_STRING;

Since col_types is declared as GType col_types[MAX_COLUMNS], if a
perf.data file defines a large number of overhead formats (for example,
from an event group with >=3D 32 events), could nr_cols exceed MAX_COLUMNS
and write past the end of the stack buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-perf-gtk2-=
v8-0-e90d5d155f0d@gmail.com?part=3D3
