Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392BA33A9D1
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560067; cv=none; b=t2JtU+d9S3wluSarL3L5TSl1XhJjhpSODwicxh2pmPnkJlxdobsK6BF2EQlBRthURBryDe8SJ/TyLeuC3f5h4zjXPq6bBksiOp4ATKe5vo/Xq08kliLKufokl7lkKV3litnED8ZuGaFTgqdrkuuVdedVHTisBXHEo4OeqBvXV8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560067; c=relaxed/simple;
	bh=kunwCiMhbIAvwP+2E/YMDNI7Pk1usFotlDbs+259Okg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fIIUHPrAxze5Trw45XrTpt5AU8h55CgC+v09k18QCsLlPu+iRnQyJztk2jB/KfbBxm/Vzi3FSDp5+/F7quBMs5yiWsTxi/2GzNpGMr06GoD3UGvdnou6qTQ95VqIs3P1wHZDhI90K/GMElZdEIgmip/94CFRBiyuCiIv6C9NV2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4wxXvC7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4wxXvC7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE491F000FF;
	Wed, 16 Sep 2026 12:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560057;
	bh=T2dEqpWWWYcZ7avb/n13lV6+aUXlsmOZ7s4EMVoxQgw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F4wxXvC7UNzezv9ZAAkc85lxHlmdcMvcvwhv/bVX5uT1eqfh+JQwe2v9vB0vB+LDk
	 NeHycoCynjZ2p/P+K6vpg+ZkKoBGWKO4yfQT1HJYuBsBQZ8GvaifHWi+jygWae3D0b
	 Mbabm+5ihL+Cj1fb3bSPCbmImQK0B5q6IGjrGDZtm5O2xXrRlOaCclGDEo6eopp8sW
	 ggNl/b6RIoEdMBk5gig1tfAqVLXth6Bm1dixv9YKK8VFUUXg6Y9wWKFlChbPT7cMcy
	 91Gp6aMgTWS61zk5MH0K5NeBX7PsSjjunoxQwj6GJktNtxSScZj6pCgrXELp9yBHfG
	 2zmwcpooOJGdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/12] perf debuginfo: Show the debuginfod fetch
 progress and keys in the TUI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916114740.48230-6-acme@kernel.org>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:00:56 +0000
Message-Id: <20260916120057.6EE491F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf tui: infinite padding loop on narrow terminal width
--

commit bf7df34cfc153e952fa2cf73c078a1a435dfeb1c
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf debuginfo: Show the debuginfod fetch progress and keys in the TUI

The stdio only fetch UI left a fetch in progress in the TUI with
nothing on screen, indistinguishable from perf being stuck, with no way
out of it. The browser thread is the one doing the fetch, so it draws a
window over itself with the fetch progress and drains the 's'/'d' keys
from the input queue it owns.

> diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
> index e4d322ce0b54c..c3274b92b0e22 100644
> --- a/tools/perf/ui/tui/util.c
> +++ b/tools/perf/ui/tui/util.c

[ ... ]

> +void ui__progress_window(const char *title, const char *text,
> +			 u64 fetched, u64 total)
> +{
> +	static char lines[PROGRESS_WINDOW_MAX_LINES][256];
> +	char buf_cur[20], buf_tot[20], bytes[64];
> +	size_t len;
> +	int y, height, nr_lines, inner, i;
> +
> +	if (use_browser !=3D 1)
> +		return;
> +
> +	unit_number__scnprintf(buf_cur, sizeof(buf_cur), fetched);
> +	if (total) {
> +		unit_number__scnprintf(buf_tot, sizeof(buf_tot), total);
> +		scnprintf(bytes, sizeof(bytes), "  %s / %s fetched",
> +			  buf_cur, buf_tot);
> +	} else {
> +		scnprintf(bytes, sizeof(bytes),
> +			  "  %s fetched, size unknown", buf_cur);
> +	}
> +
> +	if (progress_window__shown && !strcmp(bytes, progress_window__bytes))
> +		return;
> +
> +	scnprintf(progress_window__bytes, sizeof(progress_window__bytes),
> +		  "%s", bytes);
> +	progress_window__shown =3D true;
> +
> +	ui__refresh_dimensions(false);
> +	mutex_lock(&ui__lock);
> +	inner =3D SLtt_Screen_Cols - 2;
> +	if (inner > 255)
> +		inner =3D 255;
> +	nr_lines =3D progress_window__wrap(text, inner, lines);

[Severity: Medium]
If the terminal is resized to 0 or 1 columns during a fetch, could
SLtt_Screen_Cols - 2 underflow to a negative value, allowing inner to
become negative without bounds checking here?

> +	height =3D nr_lines + 3;
> +
> +	SLsmg_set_color(0);
> +	if (progress_window__rows)
> +		SLsmg_fill_region(progress_window__y, 0, progress_window__rows,
> +				  SLtt_Screen_Cols, ' ');
> +	y =3D (SLtt_Screen_Rows - height) / 2;
> +	if (y < 0)
> +		y =3D 0;
> +	progress_window__y =3D y;
> +	progress_window__rows =3D height;
> +
> +	SLsmg_draw_box(y, 0, height, SLtt_Screen_Cols);
> +	SLsmg_gotorc(y++, 1);
> +	len =3D strlen(title);
> +	if (len > (size_t)inner)
> +		len =3D inner;
> +	SLsmg_write_nchars(title, len);

[Severity: Medium]
If inner is negative, won't casting it to size_t result in a huge unsigned
value? This seems like it would bypass the length bounds check and could re=
ad
out of bounds.

> +	for (i =3D 0; i < nr_lines; i++, y++) {
> +		SLsmg_gotorc(y, 1);
> +		SLsmg_write_nstring(lines[i], SLtt_Screen_Cols - 2);
> +	}

[Severity: Medium]
Could passing SLtt_Screen_Cols - 2 as a negative value here convert to a
massive unsigned parameter in the TUI renderer SLsmg_write_nstring()? This
seems like it would cause an endless padding loop that spikes the CPU and
locks up the TUI.

> +	SLsmg_gotorc(y, 1);
> +	SLsmg_write_nstring(bytes, SLtt_Screen_Cols - 2);

[Severity: Medium]
Does this also pass the same potentially underflowed width value to the pad=
ding
function?

> +	SLsmg_refresh();
> +	mutex_unlock(&ui__lock);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916114740.4823=
0-1-acme@kernel.org?part=3D5
