Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFEA2D2394
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221833; cv=none; b=WQsQB6fVDYrDQvLjsrn0kV1fjvvITbsPSTk6NFD1bWCkpLyW8yXKHKCJynPvDT5gTZTiglbqPidSc5U+7gt2fzrJkukdAwg5+kzHMEXmI9KWo+7f54EBPnne5gjihy6Y6iLPVRCc+/afUUZSdzllyH1QVboPbAIXk3/F0NiQNog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221833; c=relaxed/simple;
	bh=F1BMgvln+SqluZDuDYnRl5MBVXYA9uigqeDPLEd5fSg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CzPAav3xFYkoqUNJCs4BjEO5ym/Tf3vzNWaSmuFV4/SmK2zh5emHgCW50rP4NhnROmuoYqM+3GUd0DzfTf09epXhE/L8/GkAKwi9b7/gzLH/RyH4U90ezf4AWjUm13OEP03qBsCMXL1pSC7AYMlHMuwP+aed3JdZ2i6QLk5s9+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wxt4ncxh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wxt4ncxh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0E21F00893;
	Mon,  5 Oct 2026 17:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791221831;
	bh=F1BMgvln+SqluZDuDYnRl5MBVXYA9uigqeDPLEd5fSg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wxt4ncxhbVW45raE7CxHkjgwA3Y7vdAd6Wg8otjh5k6lfaLAO5r36H7G2h23JcLbq
	 apVXIZKW9aCsmTiyXz/dRf5cfLAVn5uPtv9Yewpb0gQofxU1OeqUZjPz36ArCvzN3p
	 jSBo3rlWrH4kEeEYropYVXO00D+2PU0lpgL+XmjiRzfTgAXrChkDZeASMfOg4xk+fj
	 tU3jL8yQUBOz5DHlbL+i3SSSQ7wIZpPkwYt7MscBqNr3Nt+wEl8CNFBWeFJZ1poPL6
	 B7AFxjG+S1ZQ0L+uHs9H2YSSWACITTUC+Bvgagi1hjksj3rYZeaG0d+6XvjFLj5/R1
	 lq6jdLS9esYfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] perf symbols: Fix broken ELF_C_READ_MMAP
 fallback guard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261005-perf-symbol-memory-send-v5-1-165dceb2b049@uber.com>
References: <20261005-perf-symbol-memory-send-v5-0-165dceb2b049@uber.com>
 <20261005-perf-symbol-memory-send-v5-1-165dceb2b049@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 17:37:10 +0000
Message-Id: <20261005173711.1E0E21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Alireza Haghdoost <haghdoost@uber.com>
>=20
> Commit 22dd1ac91a77 ("tools: Remove feature-libelf-mmap feature
> detection") replaced perf's compile-time feature test with an #ifdef on
> ELF_C_READ_MMAP. ELF_C_READ_MMAP is an Elf_Cmd enumerator rather than a
> preprocessor macro, so the condition is always false and perf silently
> uses ELF_C_READ.
>=20
> Perf already requires a sufficiently recent elfutils version that
> provides ELF_C_READ_MMAP. Use the enumerator directly instead of
> restoring a feature probe or retaining an unreachable fallback.
>=20
> Fixes: 22dd1ac91a77 ("tools: Remove feature-libelf-mmap feature detection=
")
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-perf-symbo=
l-memory-send-v5-0-165dceb2b049@uber.com?part=3D1

