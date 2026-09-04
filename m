Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C57A1FC0EA
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525437; cv=none; b=YAQz42+e9/yK6Y+lOmLHNzl3yl1kCVmFEpj+EQMvO7rklTS4effEwQN0sMrw2bMFKlzViRyM8Et0P/gkldre3uhbY521vw4VvRKk+mgUFtAcSsZzVvvwuIliXSbsa3DnRfTvDt204D3fBE409FFJrIaRITACUuw6GFsVWw/doUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525437; c=relaxed/simple;
	bh=8KICW4s3/IHyhsnzzsrRAohRjUbFPDGLLcUOh4azabg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EAyAQqGfl4gCGcT7Uw2/ewmGjx039484j606747qsNmW3AKrDMeSn179I5NcrbZrkmPjATbMUxDkWFBZO3Iq52F8/ZE3fKWGy8HRz2ZkYpgXegA2jsimZ2Z5eXgRxJifhTTQc7zgM1WVJkX0tV13dy7xQ+3ynrdMt4tv6t0bIQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X44/9vsf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X44/9vsf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730DF1F00A3E;
	Fri,  4 Sep 2026 12:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788525435;
	bh=p4iCWFQtWd6l4gDr4T2k4rjnCoOIhS/K0HemDgHYcYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X44/9vsfeKwBCcn2MnFZVjOr+T1ND1WgcBJ87/X6eNaHT2HqFz+Z/fVqtL5hDcCN4
	 6YczKnF604VVedAib1bcJU5L1ECv6EE/a0j0hSBZOKt5h4JsEDII8fzPsomuVHzA8a
	 T+WchtRzsFfzMv852dUD39drIfx9Z/ppe1x0f4MqIsmNEnYGhqWeXtVtMO0xpnEnpj
	 Gbya4unU10DiaggcDwPdJbthAmdWb4pqHrzuP4RvNeFzIkVBaGGEkXne8CC6avEXuC
	 A892Vp9bSm+zhC3RyS2toS7bzjbL1G9FIVbd1bWvTpO/hi9C8Qg0exDnMo9rp/O7/d
	 Lf2bXS0KwOkbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf: fix typo "binded" in comment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hemanth Selam" <hemanth.selam@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260904123541.38602-3-hemanth.selam@gmail.com>
References: <20260904123541.38602-1-hemanth.selam@gmail.com>
 <20260904123541.38602-3-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 12:37:15 +0000
Message-Id: <20260904123715.730DF1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Correct "binded" to "bound", reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
>=20
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904123541.3860=
2-1-hemanth.selam@gmail.com?part=3D2

