Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540413AA504;
	Mon,  7 Sep 2026 04:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788753836; cv=none; b=pCBs/I/flhEG2Wf01vPbI6MhBe4jlsd1P3rba1YdA6eHOUhwPWkQm+yz9Pvdkb6WRLeoiVhjKJZn9rQu2dS+MczaTUDSJDjvbVeiiuoAiyJ6ochmOXCitHr6mn+9maIqhndc4diphJFgc4eI2VdIPv/tP6bn+DwKsfstMar4ttA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788753836; c=relaxed/simple;
	bh=k9kmKcTJ4nAl4eGIKAivPewXF6rHlIVBrzTP73u4Kvk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KjdsvLQ/1SU4tA8H/lmH8VD4/6qLvIBc/GHzKxrWbdQJbiuA/dbdo3u1En59xvRQiHvAbEFhogp4AHL+WuqmmI1PQHSTAHns0Xeyh6C/U3Ae/xhEWqfk19PkBul0M/OPCCqogRJ/hHYtWmCetkLQpgAKajLnb1UgnALosQjuUzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USft2dBC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USft2dBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF62D1F00A3A;
	Mon,  7 Sep 2026 04:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788753834;
	bh=hTC6nOBWeaqU69Sz6EvggVDDtV4DTSlzqNAuwUcTVZk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=USft2dBCXeZWdFmIuJ2qtv+2t30DDSbOH1A/6LmiQW53p3FOAn+EnWZOhqxDQlavd
	 oKtcG2Eb/mpeC6AMYEOU+a+uThOxUwHejI2l9l4PZe+ptBgUNH0betmJrJdkcExwhR
	 pdV2hE8uDQ/Rjt6UKialcl/0uiyaZfcnkGyrX3wkuDqSJxIa0w/0cjYZ0nLV9c3Er3
	 Vj4fQHONGv2Y4p0OzguJAGVEibn8Gm15epaHVHQxnXMuXbMebjTeF/0ihobam6fDf7
	 ihGUKtT9ENo6SepIzyd09ATGdhoVn3JXyMg4QpoLIxSppaj0salPBRknfMk/AEm1DS
	 wP8Qw7Vb0Nm7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 11/12] tracing/wprobe: Support BTF typecast in
 fetchargs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178875290158.93794.6123987120712635214.stgit@devnote2>
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
 <178875290158.93794.6123987120712635214.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 04:03:54 +0000
Message-Id: <20260907040354.AF62D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Allow BTF typecast syntax (STRUCT)FETCHARG->MEMBER in wprobe event
> fetchargs. Previously, handle_typecast() rejected any probe context
> that was not a function entry/return or tracepoint event probe.
>=20
> Wprobe events use $addr (the accessed address) and $value (the value
> at that address). By enabling BTF typecast, users can now cast these
> to a concrete struct type and access its fields directly. For example:
>=20
>   echo 'w:watch rw@-1:8 dflag=3D(dentry)$addr->d_flags' >> dynamic_events
>=20
> With a set_wprobe trigger pointing the watchpoint at a dentry address,
> the resulting trace shows d_flags being accessed at that location.
>=20
> Note that $addr and $value are restricted to kernel-space memory,
> which is consistent with the existing TPARG_FL_KERNEL flag used when
> parsing wprobe fetchargs.
>=20
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178875277830.93794.=
14247844688761142429.stgit@devnote2?part=3D11

