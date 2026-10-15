Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235473CA4A0
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065677; cv=none; b=ffXvWSNVHYxKLU+W2H3MikASDuTYgRttGLI+kOG5XERn6uSrsI2m9TqwQEip0kYhar3Be6xFFxasxtewb8omZ7I2o1qP0p/l6tKIhXupQBYnnz/v5zmcZb05vt1DkLi2ZiI7U0wLCUIRkwKuUoBlVIOCr+S2ZuGWh58IWwgjbH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065677; c=relaxed/simple;
	bh=Q4mrRApsaEFT2/827d8HyAojjgvgfotdyyc/yI6LWHI=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=OPyPfkob8RHjoAYzEMCq/R2LdxwHY6KZg0rSkbEvn0ARAO23Laj98C2FMoCZgVVlYk4fJZhqFucLWT7jzqWFyYU2sSaHcj2hZJiL7yMuRvrqCqiWMZhbLT6fjCM/sx71MP4lb94JMK5F857wCScLp58xt6XFyXojuGc9F1ouKTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWADeUoB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWADeUoB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD43C1F000C4;
	Thu, 15 Oct 2026 12:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792065675;
	bh=Q4mrRApsaEFT2/827d8HyAojjgvgfotdyyc/yI6LWHI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TWADeUoB0qxXj/N32wqjH5JQQ0iHkfXvLWocyIGWE32AAE8hbUXhfq/r+c3W5PExv
	 6yRdKMS3Jq2+3HtnKUaxUUgD3myCuCmDRj1k8QCMwkMFwpugHvuneIxXnyjtHrwpTX
	 1NOE1XIsQD4a9ZgkYV7qAV1G2/IekM2nTUI4ftbRfcu7ZOGbbYKLoYFU69DvBSAEk/
	 1YExK7zM+CQPuz2PxyZ+dnWfJv+43eOPLi8QszVQrAXB0oTE1gfpnRVpPhjyGwhPho
	 9AVRIEdX+oYbQv5Wicm7FWAhfbxdEsXotSec1FoIIKXgcTy3cAX9FmjpBGwbC0NBDi
	 KgGRKbX1oAq/A==
Message-ID: <sashiko-outbox-172779@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf/x86/intel/lbr: Limit branch snapshots to
 valid entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <7f611dcd599d6d65325d8c40566a1fc35b447ea2.1792064123.git.sandipan.das@amd.com>
References: <cover.1792064123.git.sandipan.das@amd.com>
 <7f611dcd599d6d65325d8c40566a1fc35b447ea2.1792064123.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:01:15 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The branch snapshot callback used by bpf_get_branch_snapshot() always
> copies x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
> last LBR read kept fewer branches. The entries past lbr_stack.nr hold
> invalid branches which end up reaching BPF programs.
>=20
> Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
> intel_pmu_lbr_read() skips reading the registers so that a stale count
> is never reused.
>=20
> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792064123.gi=
t.sandipan.das@amd.com?part=3D2

