Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCDA37B40C
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620660; cv=none; b=j93neT14awqoMBucHV3olXWA8a1z0AGSj7vYFK0wZLgWIcPaIRrb7T/2L7xvmlVnRson1yWd9CwYxpVpnD8NxKQCcpyvaVVuLIf+NolyZgn6uaQYi0NKvC21jNSNqp3Ec3qeu52JA8n13cNTLfpe12DgZtz33uPydheUIWt5l8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620660; c=relaxed/simple;
	bh=7EEAU7vwDpNOM1iFpxJ7EG78VGgVyXGUS1dpRdyDtt0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GXw2Om3NMK0hXl0oU0njTTwXUgWs/HJbUGOwgrmPZLCbevgBuoR5eACVZvpGDkp0vdMtgg4dzJw6gKdY5/SbMh0ZbRanfpyOpcoRgG5M2up1b1SfLJ/XzILJj9bQP6w9Pacv9EBMQf5sVkFeYCf7EJvtwEaaOt11uRCPjkh64Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL87qB4Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL87qB4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7CC1F00893;
	Mon, 28 Sep 2026 18:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620659;
	bh=7EEAU7vwDpNOM1iFpxJ7EG78VGgVyXGUS1dpRdyDtt0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JL87qB4ZLS7ttxanVFxQiuOCpKuHC8OwePRSwafLnP14c8sxHww6ntn1XMh5SIKlb
	 c1lnBbLE2g6Ndz5PIpgnrkm8rke6qI5Ag3SZZzpJBbiJ/e0oRqIpkgL6O+IwEvhPHF
	 FVBogNR+WD6v/HrOjfTsE1EbBukDpfzca/nw/z9YeiFBZr+prx9T/TBB8QhoWn6sqz
	 zx9aBftY6y5BhJ+U9A6pxQua/iy5Fa3jzVoM7BgyS5z7OVfym4uNZPl+4pPf8PjEss
	 vQ88qHjP0KuxR0Gkz/DVSGVIPtE39lSvDfgmnvRd4/Ray9X1+VdcKGZUWRNJl3ZVZu
	 n/L/fL8Lz1/yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/26] perf trace: Destroy the BPF skeleton if it
 fails to load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-14-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:37:38 +0000
Message-Id: <20260928183738.CB7CC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> If augmented_syscalls__prepare() fails to load the skeleton, perf trace
> falls back to unaugmented tracing but leaves the skeleton in place.
> augmented_syscalls__set_filter_pids() then writes to maps that were
> never created and fails with -ENOENT, so a system wide session, or one
> using --filter-pids, exits with "Not enough memory to run!".
>=20
> Destroy the skeleton on failure and clear the pointer, so the setters
> do nothing.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D13

