Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7909126C02;
	Sun,  6 Sep 2026 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788721907; cv=none; b=iMUxRwvtBaHvqmSZU1kIcauGF/e/ocRi89L9UoBQFY0T1NwWYHwsW5HQKqbzUB4Me43I3c5HdkXzhZOgqCtr5Bd9udcDrgKWgJIcYmXU0tWjWhpYCL1rn/FVmcvYADeymnTwd8soDtw1jMBd1TwQMUiHYYstABXI5cXTQaLjjW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788721907; c=relaxed/simple;
	bh=RiE4fYTVsV7sl0E7QgvLEOyULI2CEhtM1pvphHC4ktQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lDY2husO/uTHh04oyU/cHz8wkOigZkT0LVo1j2f0mafJCdycIS8Ek3SZv+KlvlsHsSHyTwiFfXUWdtLVPwSJ6IjvgHvs9x8bu+icT57Sou8KkvIMh6nvtpgtdJeH7GjXKtNBKkyfxq3PpPTKaWXa0PquR/8I/0LrrjHXa2NdMl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFoDnQSJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFoDnQSJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189381F00A3A;
	Sun,  6 Sep 2026 19:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788721906;
	bh=Xn0EFMSiS8vXKC7FjFrz9UlVVjyvOcYeHy0NX88wS/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AFoDnQSJzZ/nNlmpuGi1Yi3mY+I3wRXTr8zt1YY7KRwWkCGdEjUjLjxfs29Lc59SQ
	 D/RXJEMZHuPsXpayG9suLCKk3UHEUx09n4gFx9PN4JBZSFPfSIAFGjnl9kMF9LuZCE
	 +fc0JeHHEG9Zc24rhQrz6ys/+J9+cUUb1M9l01KOJ2sBRLhXEPbhpkJVBbkx8jGAdE
	 5XtUwNqNYQsbj+uBBuNZifKRj8fAeEWWjmDb6LtI+lA8PSkLqqSwx6Fh2f+uHingyv
	 YnMdnxcZ5Qwc648eYeP+RImsDnjqZxLCvGk1NRV9h65Ndxw9Bo1g/iA8OgFW8aSyAj
	 06lbOvK1TKOvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] tools: port perf ui from GTK 2 to GTK 4
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260906-perf-gtk2-v6-1-695d1c01aaa1@gmail.com>
References: <20260906-perf-gtk2-v6-0-695d1c01aaa1@gmail.com>
 <20260906-perf-gtk2-v6-1-695d1c01aaa1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 19:11:45 +0000
Message-Id: <20260906191146.189381F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Stack buffer overflow in `perf_gtk__show_hierarchy` via unboun=
ded `strcat` operations on a fixed-size 512-byte buffer.
- [Critical] Stack buffer overflow in `perf_gtk__add_hierarchy_entries` due=
 to `advance_hpp` causing `hpp->size` to underflow.
--

commit 7496ddfd9ec629824a25a0325ee855c455c6681b
Author: Matt Turner <mattst88@gmail.com>

tools: port perf ui from GTK 2 to GTK 4

This commit ports the perf GTK UI to GTK 4. It replaces deprecated
widgets, updates signal handling to use GLib sources, and adjusts
dialogs to align with the new GTK 4 event loop paradigms.

> diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
> index bae21f336ae6d..716dcf02bd0e8 100644
> --- a/tools/perf/ui/gtk/hists.c
> +++ b/tools/perf/ui/gtk/hists.c

[Severity: Critical]
This is a pre-existing issue, but while reviewing the GTK 4 changes in
this file, I noticed a potential stack buffer overflow.

Does this code safely prevent overflowing the fixed-size 512-byte buffer?

The column formats are derived from the tracepoint fields in perf.data,
which could be crafted to contain an excessive number of columns or very
long headers. In perf_gtk__show_hierarchy():

        char buf[512];
        ...
        buf[0] =3D '\0';
        first_node =3D true;
        list_for_each_entry_continue(fmt_node, &hists->hpp_formats, list) {
                if (!first_node)
                        strcat(buf, " / ");
                ...
                perf_hpp_list__for_each_format(&fmt_node->hpp ,fmt) {
                        ...
                        if (!first_col)
                                strcat(buf, "+");
                        ...
                        fmt->header(fmt, &hpp, hists, 0, NULL);
                        strcat(buf, strim(hpp.buf));
                }
        }

Could this unbounded strcat() sequence overwrite the stack if the combined
headers exceed 512 bytes?


[Severity: Critical]
This is also a pre-existing issue, but I spotted a second potential stack
buffer overflow in this file.

Can the manual size accounting here cause hpp->size to underflow?

In perf_gtk__add_hierarchy_entries():

        perf_hpp_list__for_each_format(he->hpp_list, fmt) {
                int ret;

                if (fmt->color)
                        ret =3D fmt->color(fmt, hpp, he);
                else
                        ret =3D fmt->entry(fmt, hpp, he);

                snprintf(hpp->buf + ret, hpp->size - ret, "  ");
                advance_hpp(hpp, ret + 2);
        }

If the bytes written by fmt->entry() (stored in ret) are equal to or
slightly less than hpp->size, couldn't ret + 2 be strictly greater than
hpp->size?

If this occurs, advance_hpp() will subtract a value larger than hpp->size,
causing the unsigned hpp->size to underflow to SIZE_MAX.

Would subsequent loop iterations then use this unbounded size, allowing
formatting functions to overwrite the stack?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-perf-gtk2-=
v6-0-695d1c01aaa1@gmail.com?part=3D1
