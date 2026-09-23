Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEC554DAF7
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188756; cv=none; b=uy0Wa5/DZuxwcN+hP6koglV0tHdACT1OrmzGHshk9NFe+xYB9dZMGgQx7JwJ0NCEe86+oBoYwEAZAfVWy7lKuyysaIO6i13f1TGCDMnrpInFMI+Yqr+0dz72lUhSS0IWclfph+Hcd80fe4PDVWajWWZzZp8P7k2N3bEuBgN6gxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188756; c=relaxed/simple;
	bh=O2MPfnBO8g7MsnvtuEXr68n95MDDeAn1Ly2d7Dcr19M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VBe8Slk9A4JTFqT8en/UvANr9Qlwqav+lKvrx1D9tAfBeb4KVKNKGwDlci+4G/d5bDnLHQWVUHQBEUib9cHjYXQQG2/zvfW/F2Naj8pkgtkNkMvn95Z1mZGXSJcGwXIFoJn6ifSvMyccELdUjj4OhTaJnDV/LLC+FO5fFM0XYHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHjVNoES; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHjVNoES"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9E01F000FF;
	Wed, 23 Sep 2026 18:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188754;
	bh=6YjKcPqUT9jDydJPdMSbsOcIaw+FgWbWpHXnDGU0k5k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QHjVNoESwq8X8jwonp4D9lpM72VScWV8DQbFLaizsCRJwY3mWcsb2ClTWxcEuaINo
	 b6bk93NhEOzdtyo2dGw5bw0biM085JS+XxpI0IIhhDDNiimK4Q54DLGqyVvz99C7vc
	 s44up9iR/v1h3rt10DbXXC6PA/3JoMP29syKrJH4+eZJ8Vaqlx9pXaX27tHTOg3q7F
	 Bc2yCewlqWylXrhoaWGhpxSqc21Qmfrzv/4N39bWy6CAOW55KqVxUcYVJuhxG7RrIJ
	 ti/BbTjmMJdzdIFgvtvKO7ahTlMLq/QyLLAqA7CY3ImwltySiAkuyIpL3YPzWhs5Cy
	 wU2dABezklVgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 35/49] perf python: Port net_dropmonitor to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-36-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-36-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:39:13 +0000
Message-Id: <20260923183914.5A9E01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port net_dropmonitor.py from tools/perf/scripts/python/ to a standalone
> script in tools/perf/python/:
> - Refactor the script into a DropMonitor class with full type
>   annotations to encapsulate state.
> - Use perf.session for skb:kfree_skb event processing and add argparse
>   CLI support (-i/--input and -k/--kallsyms).
> - Resolve kernel drop addresses via perf.session symbols/callchains and
>   binary search over /proc/kallsyms, ignoring zeroed kptr_restrict
>   addresses with graceful fallback when kallsyms is unavailable.
> - Remove Python 2 compatibility code.
>=20
> Add a shell test (test_net_dropmonitor_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D35

