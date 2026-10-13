Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9947C547071
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 00:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849965; cv=none; b=VFOXVjfu/oQOGeka0dmblXR2BBuRntmaabseeXBCCmJQHFK1XpiXY0XakLUDZrewz0RfmejT6U1gnD6k9w2gfHyd1/cWnXOgIBwetQ4wqi+yuAcYwgntBYfc27al5x082+7ygnOhnQMch2fXWYMw4hl6qFWMC9h4XbEXwfpSHAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849965; c=relaxed/simple;
	bh=KfYivwMfjv9B3bpd8QpJ/rvcAx0VOC/9IkEqmzz7ipQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=R8fWrgnICjbUpB0YZ5e3huCBvjZlEPJrCI/W1RziTYjs+ZJXbVtz/kXu9mpT6V5oz90n5nYw+x+sbeZVC5H9uZhKxOUdVucpkMjsMbXA2Woj6uUjgXbZ/6RbUzs8Uv9T/a9gvIcNdhyQr73jbIhivVzypXKxTt06uouDnE9Oeuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lomNknv3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lomNknv3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF95A1F0089B;
	Tue, 13 Oct 2026 00:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849964;
	bh=qwvYr+CNo7wQyyaHNaacCv+evog8Cm/Nae6ZzE4Jlfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lomNknv3W7VqHdtU+SN527tHo46euh3H6DCNNkxsiV9l9TYwVjI0Wybo0uZKlR2es
	 qaJ7YTP5e+j0M/4mElkAMV+ZL27bu49LvW17hLV+dlN/1BtMiLDcwFLr6leYrb5Ssp
	 oOIy3wzb4bvJlnoWxaSvkDof+I6EEQMlyRYLJb0veujbPc2tQnuiSt4reRXCuVOTRk
	 s5HReFSPmlHo7WTB5iQHuT+6DXR7Ol2dVhl1Sm6vcwhF/T5C8dpjPTc74O7t5j4OYX
	 aBUwktemPs0CLXoXLpGco1orgxgqzECI3tuPQCu2Ees9BWSNvr0EwnEN7B2TAWFH6/
	 CBUrBbZKSzqoQ==
Message-ID: <sashiko-outbox-168772@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/10] perf annotate: Simplify symbol__disassemble()
 with dso binary_type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012234654.60666-10-namhyung@kernel.org>
References: <20261012234654.60666-1-namhyung@kernel.org>
 <20261012234654.60666-10-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 00:06:03 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Now it should set the binary type of a DSO properly.  No need to figure
> out a filename suitable for disassembly.
>=20
> Just call dso__find_binary_type() and dso__get_filename() for that type.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012234654.6066=
6-1-namhyung@kernel.org?part=3D9

