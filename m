Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA8B2D949F
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 00:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775781486; cv=none; b=I3bcR146HiGZDYn7oNHnr9uAJpy7cWmJOgu1I0/keyuylBwbwAYFUj5ikBiUhl4qDe+ZIPflGBHBTVr+0Bd0J/vaf080SMBOs3FbFkrcVJkizxr5P+ExzhxBEA0b0JCnweFoXYEjdvBKV44dhJk/02LTrtZUkZRlCJ/co8kWJx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775781486; c=relaxed/simple;
	bh=H04/IbOWw7GwAuVwKgfkE0UTGBrgNXBf70U9giWBmOI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hSWnJbQwYoHErs/0Fcymsvcuq78dPciXhSFue+9ZT7KYFy72ddaWXtRDdunYP1RdgwnC0Fadzgs36tZ1UWIM9/3QZ2m/l6YF7Aes36XetTYPAINu55+VWtxHCHl0FqE0aqop6MD2pcf5hMm/AdeKAlHetAm5/UAUhp1sWBLCW2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skBDuxjU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skBDuxjU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EC4C4CEF7;
	Fri, 10 Apr 2026 00:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775781486;
	bh=H04/IbOWw7GwAuVwKgfkE0UTGBrgNXBf70U9giWBmOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=skBDuxjUoueGk2HUXI5MeFBJEhb3JS0Bv4jXRVcTQsYkHV8RNDPleYSMMgmMWvJkc
	 orSEWBYbpMDrQeFIf1S5hCG/p6AjD0FNcJYK4K21k0ZzT80jyLa19/gwebCVGgzBq+
	 ghzT6CEwFe416CfaD5E+2qfnn0XDX4mcGNLKAz25fxfjUriMbOBN4khL0HJfSBXB8I
	 MRyK0tDjNfYl12vayBBSJNi+BG6YLyjdULnxYOT7qJSTSDuBnT300NnTPG+Dw3/HVb
	 seaTPDL+cCOwEeZPEHsSepsmbm/Kc2aOaFNVBjBszxBZ81g2LsRfUoMGtb9OUkoIGb
	 /coYAw5WyNUdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf test: Fix inet_pton probe failure due to
 multiple probes
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260410002351.10856-1-irogers@google.com>
References: <20260410002351.10856-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 00:38:05 +0000
Message-Id: <20260410003806.27EC4C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The use of `sort -u` fails to guarantee a single event name on s=
ystems without uprobe multiprobe support, leaving the test broken in those =
environments.
--

commit 82ddf08abe58056272425532334245db796f2020
Author: Ian Rogers <irogers@google.com>

perf test: Fix inet_pton probe failure due to multiple probes

This commit attempts to fix a test failure caused by perf probe outputting
multiple probe points. It replaces a tail/head pipeline with sort -u to try
and extract a single, unique event name from the awk script output.

> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tool=
s/perf/tests/shell/record+probe_libc_inet_pton.sh
> index ab99bef556bf0..b717063f70c27 100755
> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> @@ -22,9 +22,9 @@ event_pattern=3D'probe_libc:inet_pton(_[[:digit:]]+)?'
> =20
>  add_libc_inet_pton_event() {
> =20
> -	event_name=3D$(perf probe -f -x $libc -a inet_pton 2>&1 | tail -n +2 | =
head -n -5 | \
> +	event_name=3D$(perf probe -f -x $libc -a inet_pton 2>&1 | \
>  			awk -v ep=3D"$event_pattern" -v l=3D"$libc" '$0 ~ ep && $0 ~ \
> -			("\\(on inet_pton in " l "\\)") {print $1}')
> +			("\\(on inet_pton in " l "\\)") {print $1}' | sort -u)

Does sort -u guarantee a single event name is captured on kernels without
uprobe multiprobe support?

On systems without multiprobe support, perf probe actively prevents name
collisions by appending indices to subsequent probe points, outputting
names like probe_libc:inet_pton and probe_libc:inet_pton_1.=20

Because these strings are textually distinct, sort -u will output all of
them rather than deduplicating them.

This leaves the event_name variable containing multiple words separated by
newlines. When expanded unquoted in the subsequent perf record and perf pro=
be
commands, bash word splitting causes the same syntax errors the patch inten=
ds
to fix.

Could this use head -n 1 or awk '{print $1; exit}' instead to robustly
guarantee a single name is captured across all environments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410002351.1085=
6-1-irogers@google.com?part=3D1
