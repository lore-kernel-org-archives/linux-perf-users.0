Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03513ED3BB
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541248; cv=none; b=mQuz8zHHokb2gbLeouSG/665bER4QNuwKE9mKb0LpDnkb914Rqjr29T/1BSek3gbPb7x2DcCqsjFgOWyVssPUKmYh8Wwz/Wn9qrzhHfLIixYPIYFabYTNj2IuGLXmrE+M5LdYqCyG9XG/OCfKU4m/flElPn7rXrY0IIjZGmqulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541248; c=relaxed/simple;
	bh=hZhfNVyJrjMd4c6JKTI5Yik/rzxlCRIhA9D1blN6ol4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ad8gR+gWW4ZVduxGAeH0d7mGiQOCpbgV5HGheZTF7Rup2p9KifSM6sZ46Kjcu28JQYncf0edPCLP94OE2/HCdrl2PbA4qfbZ6nL0w5pnh8RL5rcr9FRo7RL2VhNyTyT1EJ6sPLezNnOfu5LjRGxM+e/K6y/r85rZ3+tEC0jOW+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lU7wOBvd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lU7wOBvd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D181F00899;
	Wed, 16 Sep 2026 06:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541247;
	bh=dujLCUv1HR2XkWyND1xwdQ2NC2tDHjZOJ1kVKnHmI3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lU7wOBvdRNadP9SYCCeymApEivkKFR+e+GGn94tAp4go3kQ7osdG6NZ90qJBnXT/d
	 Zt6poBfwlb5cedYGJr8qCeeAPSMimIYL2jntjtCKJwfDUTRrBP8w/izhqXPt34sj7H
	 DavYszQyIBJ0xJizknWpkKMRL5Efl2+mzdihpnkEeUrRQmdl996bBdb+9RZcEltd77
	 SA1UrAPSSJAkfP39FOLZglWLxDweXU7AxIMMdeYR87bHKaRzCSPYmbwfjFh2mEGNTA
	 JFdqH3pyrcrYH0KFlwC5/T2dmZwNy0JNkXqMgnUTksy693OtgCOZOlETogBuhEj4fl
	 1SQV1llEIMTzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] perf libbfd: Report success when an address is
 found
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916063545.3103314-4-irogers@google.com>
References: <20260914170759.1992947-1-irogers@google.com>
 <20260916063545.3103314-1-irogers@google.com>
 <20260916063545.3103314-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:47:26 +0000
Message-Id: <20260916064727.22D181F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> libbfd__addr2line() only reports success when the caller asked for a file
> name. addr2inlines() passes a NULL file as it just wants the inline_node
> populating, so libbfd__addr2line() returns 0 for it unless
> bfd_find_inliner_info() happened to find an inline frame. addr2line() in
> srcline.c treats 0 as a failure and tries the next addr2line
> implementation, which appends its own frames to the inline_node libbfd
> already appended to. Every frame that isn't inlined is then reported
> twice, which happens by default when perf is built with libbfd but
> without libdw as the fallback order is then libbfd followed by the
> addr2line command:
>=20
>   $ perf record --call-graph dwarf -- perf test -w inlineloop 1
>   $ perf script --fields +srcline
>   ...
> 	    56051a994f8e parent+0x2e (perf)
> [ ... ]
> does, and clear the frames appended so far when appending fails so that a
> following implementation starts from an empty node.
>=20
> Fixes: 257046a36750 ("perf srcline: Fallback between addr2line implementa=
tions")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916063545.3103=
314-1-irogers@google.com?part=3D3

