Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBFD3596F8;
	Tue, 22 Sep 2026 04:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051949; cv=none; b=QIIAZn+t0d1SgvEcYTh69JeJhrQi5VoRhzJ0kq8fAkEktWSX3jQsVUfQPxEDJVCc6DHy488ZvgkRSh3OZbADGsZCnsH8NHw3DrX9Yl+0TGjNiVTYvaKzZJB0R39unls7bAvEFRFKqxrZwDEOKnhQ+MOPtXKNgYL0pksBLkvwBok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051949; c=relaxed/simple;
	bh=d7Y5ljehc3zqBBHKwx9eAD4UeVEe6hzU/+3Bhxtxs88=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IOByw0xbfaCvsfDmGdv+ajqI8+V3cUA6fOILg6TqUvZOxfQDzoekOy5NUgPXkkXT70RwyMdKwvgYTxw4flUoe+vq06t7ygTChRe1Di6PFvF66OVONE4KyYLnbHRRiZuOC2RPTa0g13288MQyXFiuVpoZgDruOGhYivUsAJi3K0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4592Q8b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4592Q8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3781F000FF;
	Tue, 22 Sep 2026 04:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790051947;
	bh=d7Y5ljehc3zqBBHKwx9eAD4UeVEe6hzU/+3Bhxtxs88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i4592Q8bYeAlF1+WT4HkARtKZZSB9b5mylKa9BCp4o2FdTkimIl3R8WiEW84hgaP4
	 AB6nklRHscQ13nmngPADA0RpAHOqqzEU6JQOqFGawOg5TRIRQkyQXcl2/JTar0tmOO
	 bvwAdJaIYqOXtJRORTBB3OfGI5YkNYZe/JHEOwzxGV7yQ+HHiWCk+u17U3thZzNyEZ
	 hBBqZZI1ZzIuxCDB4g0SPiE2YJeT+i8fgVuvNgLn5WK2p0W0DWwXL52nj74vGiMPe2
	 YP0A6/yHbg5WDob2BbiIC/gkGGNamzvZhpMa4m5EY3oeY+dyShiQOJX0HA9q95Pb6M
	 dQOi1gpe+sEfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 04/13] x86/hw_breakpoints: Add
 arch_modify_local_hw_breakpoint_addr() API
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <179005113108.388919.2257490475086393913.stgit@devnote2>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005113108.388919.2257490475086393913.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 04:39:06 +0000
Message-Id: <20260922043907.5D3781F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Jinchao Wang <wangjinchao600@gmail.com>
>=20
> Wprobe needs to move an active per-CPU watchpoint without releasing and
> reserving its hardware slot.
>=20
> Add arch_modify_local_hw_breakpoint_addr() as the architecture backend for
> modify_local_hw_breakpoint_addr(). It validates the new address, finds the
> installed local slot, and updates the hardware debug register and per-CPU
> shadow register. The core layer (modify_local_hw_breakpoint_addr()) handl=
es
> updating bp->attr.bp_addr and counter_arch_bp(bp)->address.
>=20
> The caller must provide an installed local event and a valid address.
> Slot ownership, breakpoint type, length, mask and DR7 remain unchanged.
>=20
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c=
2.1785067572.git.wangjinchao600@gmail.com/
>=20
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179005108298.388919=
.4535333252892590932.stgit@devnote2?part=3D4

