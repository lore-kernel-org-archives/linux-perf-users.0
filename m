Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD929157A5A;
	Sat,  3 Oct 2026 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791014585; cv=none; b=LdL1nGXoIGU2toBHcFIb8KqZUswPg2S6Ff2HapBb9NY51mSSIGZfFoVafhM10GMoeeHJl7YjSm6PYbIPRx5DVUPQgt//j6Jrh+IaK36DLVrFYLJ8C1hMIa+eWTztAnsG00b48+9iMxs5YzamxmAe3Z/xPxmXk1MoqpLtxwGTUS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791014585; c=relaxed/simple;
	bh=qfzJPtLihp2X8rsCDaF/CUtUZiUTtojxDAe//CZuwdk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P64FeBX2Z+jezl48vuY7GXXAe5xg3Yr1y0LDXmItcHhyG8zrGwZIPPS/oTnERolIBcmOLC9V9FZB06QDBmER7zo13hQwdvi8rkMwlM0H7aYXr/XNL3KTDFnn9uoLiBOjjkAJQEmNqvZ6N/c8MzUZbcRuy3B+u/TmwMKV1RQiFGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHv1UJCX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHv1UJCX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877FD1F0089B;
	Sat,  3 Oct 2026 08:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791014584;
	bh=qfzJPtLihp2X8rsCDaF/CUtUZiUTtojxDAe//CZuwdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hHv1UJCX29HU7JnVvvXNTc04luyeURnia4QUnz9FAbPSIwcUGoZPr+K9Cw3mgciu6
	 3ckmsf+BGiCTC2Ygib7OiJse4xq8n420qvI9P0iqs+UKOdFPFmhk30yn2IBxRY3VPk
	 pO/1Vh6FYJvFr0aa7fOtoHOVKPoq7/VDKAuhDqgYdETNxF8JjWBg+E1Z1qMWX/gJRt
	 Y/4z95Hi7+t7XEH/cP/Nysd77vyn2aBAPwaf7wEYGgO2o4zM+B2P6pOBc99Em4iSHC
	 rEPpUJWh4PDoiLSll2LAXHlJ+qp/Kgocaex3JiReufocx202gv429pG2EqUy06Hc82
	 upl305H69SmFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 01/11] x86/hw_breakpoints: Add
 arch_modify_local_hw_breakpoint_addr() API
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <179101394685.22872.14912193681254587207.stgit@devnote2>
References: <179101393469.22872.5895666191299551553.stgit@devnote2>
 <179101394685.22872.14912193681254587207.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 08:03:04 +0000
Message-Id: <20261003080304.877FD1F0089B@smtp.kernel.org>
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
> Assisted-by: LLM
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179101393469.22872.=
5895666191299551553.stgit@devnote2?part=3D1

