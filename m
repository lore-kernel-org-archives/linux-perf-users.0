Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893B226296;
	Sun,  6 Sep 2026 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788720022; cv=none; b=NlScBypC5D9ZfP8isN4ArP7uJgWxepid8PeUGikHsusR6yVM9slvuk42j5u52N1MLLNoOXNpgC1iy9q5QbzX93ILpXIsO8Ip9AG0GT5pWJVv65mFef0OOwDrDdT/Evm/J86GynNmprwcpbQBRczuNaeYrRyzQSpCGJ1vVR93qr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788720022; c=relaxed/simple;
	bh=EL3OhfhDoDdkrpaxL6Zq05JZ/4fH6bUqyf/3gntRDbM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xiu1XmyxnCdBzcJpmRdM/k7G/w6fPSxz34f5Qi0QK5OXJ3dvlB3X2vzPI/ewnwJaQEeknxoBTN9EZAMPWPm0ycAq4OokMvYx7sWqFyQO1thvcHq3dpQWAQ8aseGbNT/uWoNtzSsDbz1VFxggMUGMBRpOaGUUDU1LtseeEoZGG+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPD5ubgA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPD5ubgA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FF71F00A3A;
	Sun,  6 Sep 2026 18:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788720021;
	bh=NcJhcx51/+h2tIxA3pMCHq2agiKPragk3e78SMSVsuI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mPD5ubgAZxZcClgBnxkeoRExuq572WqV8KlQ+fJU4DF2q7lPcrFAPfEjVAGVXz/e3
	 2Y/rsFhCa5FEow+i6RSFi9C4U5d4zosZ5v+QlZWlmxIpVRaUSIH9dScbs9kLq4mtaJ
	 dLmgcRT7j9WVqvRZjyagDTgnDJLR4D8eYk6dLg4uUOeZuKzqLgWxudgmgmoghXq046
	 hR26aoY0nfxzmIfyIGg6vN0rDtQrYZSXU/MuhGgMM6177Mzv56PEIEdubCZEz9C7WA
	 hnB+RtCtexHqcTtUCo1jEBFLJXjZLH92wQngrrac8Rea2dlO3JlwswNM01BT29IUN8
	 FeBLgZt+n3MTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] tools: port perf ui from GTK 2 to GTK 4
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260906-perf-gtk2-v5-1-e8747a65c240@gmail.com>
References: <20260906-perf-gtk2-v5-0-e8747a65c240@gmail.com>
 <20260906-perf-gtk2-v5-1-e8747a65c240@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 18:40:20 +0000
Message-Id: <20260906184020.D9FF71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Missing explicit inclusions of POSIX libc headers (`<stdio.h>`, =
`<stdarg.h>`, `<string.h>`) in `hists.c` and `annotate.c`, violating musl c=
ompatibility guidelines.
--

commit add3ec3dbce9f1d3bd46b20c11244baa3a6dfeae
Author: Matt Turner <mattst88@gmail.com>

tools: port perf ui from GTK 2 to GTK 4

This commit ports the perf GTK UI to GTK 4, migrating deprecated constructs=
=20
like GtkContainer and GdkScreen to their modern equivalents. It updates the
main and error-dialog loops to use explicit GMainLoops, defers exit signals=
,=20
and removes conditional checks for the GTK info bar.

> diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
> index 8920e298420a8..b89389a3b92f1 100644
> --- a/tools/perf/ui/gtk/annotate.c
> +++ b/tools/perf/ui/gtk/annotate.c

[Severity: Medium]
This isn't a bug introduced by this patch, but since the commit message=20
mentions adding explicit inclusions for musl compatibility, does this file=
=20
also need <string.h> included directly?

Looking at perf_gtk__get_percent() in this file, it relies on strcpy():

perf_gtk__get_percent() {
    ...
    strcpy(buf, "");
    ...
}

Since musl strictly separates declarations, relying on implicit includes
can cause compilation failures for environments building against it.

[ ... ]

> diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
> index bae21f336ae6d..d8eec453dd094 100644
> --- a/tools/perf/ui/gtk/hists.c
> +++ b/tools/perf/ui/gtk/hists.c

[Severity: Medium]
This is a pre-existing issue, but similarly to the above, would it be=20
appropriate to explicitly include <stdio.h> and <stdarg.h> here to ensure=20
musl compatibility?

For example, perf_gtk__add_hierarchy_entries() uses snprintf():

perf_gtk__add_hierarchy_entries() {
    ...
    snprintf(buf, sizeof(buf), "no entry >=3D %.2f%%", min_pcnt);
    ...
}

Additionally, __percent_color_snprintf() relies on va_list:

static int __percent_color_snprintf(struct perf_hpp *hpp, const char *fmt, =
...)

Adding the explicit POSIX libc headers would prevent undefined function=20
errors on systems using musl instead of glibc.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-perf-gtk2-=
v5-0-e8747a65c240@gmail.com?part=3D1
