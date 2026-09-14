Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2851B3FFFA8;
	Mon, 14 Sep 2026 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392681; cv=none; b=A145GL5Sts1Po8D3A9FCLL45VaSUDI/lSZTxJCAbS124kTt9fuahGRBBI92QCfPrEijX1sr/UAdHTaX9G1M0slyREMeu8enTld3kH3bIy7ZzbAqPYaYcrDcv2NWthZSjEkyxFhmg/RRvYKABuEPMs8lq/redtGTXnuj+GFpEiWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392681; c=relaxed/simple;
	bh=T45r2dmr3jCMU1q2p11AnAT5vZX673oOdG3+j7uLv0E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UvLxuDk9fIgXTGpyfDx+uC55/EPHB26Ul++2UDPfTrk3ll0gyTjnGi4O+O9tM49u4KU9Ako6Au9lGT8l2XsBpw1uL9QJEmQMjXPnXNvIgq9R66yyB2rjIb7vYzOxWGyH3Qqa5DmfzYhwFEp2s8B+t73hUNLRaPh7SMv+GDL0c9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnIwSAcI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnIwSAcI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582961F00893;
	Mon, 14 Sep 2026 13:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789392679;
	bh=T45r2dmr3jCMU1q2p11AnAT5vZX673oOdG3+j7uLv0E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AnIwSAcIRKoaMciOVOfM2vWHfzqX4sS/XjYy0QJPB532IDVr3lqtWorgVxrNDy6/W
	 eqxaljAlFZwZU+K87ifWoP+nEsXQnwDNtWzKHBS7ruZsvyYS7kF0sgeV9mCz8xOS2E
	 NN+rUBHdnJ1VTJyzmAeJLfBN/t4cVSBz4vKKgiaW13U2Y8N2PRPGJL8AHE5TiXYD0v
	 s73jTtCJEjw272YaKO9N4gS+KWen0JIIcQXaCA/i9Cv7ZPJAALbLj84r89tLg5vyEu
	 5rq5je6VphzDMs4kMWIU/ArEwXNEXEfHoEPUT1Wu98//qoL2yWdStqJdkzhSooFkUp
	 5xUEeJIBs+6vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 03/13] x86/hw_breakpoints: Make DR7 updates NMI safe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <178939021170.94750.17115728735164122117.stgit@devnote2>
References: <178939017565.94750.9431053336761330458.stgit@devnote2>
 <178939021170.94750.17115728735164122117.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 13:31:18 +0000
Message-Id: <20260914133119.582961F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Jinchao Wang <wangjinchao600@gmail.com>
>=20
> Hardware breakpoint installation and removal run with IRQs disabled, but
> an NMI can still enter the same code through KGDB. The interrupted
> operation and the NMI can consequently claim the same slot or overwrite
> each other's DR7 state.
>=20
> Claim and release per-CPU slots with cmpxchg. Update cpu_dr7 with
> single-instruction per-CPU operations, and preserve hardware-first
> disable and hardware-last enable ordering. Add a per-CPU sequence number
> so interrupted DR7 writers and restore paths detect an NMI update and
> retry from the latest shadow state.
>=20
> Link: https://lore.kernel.org/all/4ee0a2efc9e8387af83286b8495b7d490247e16=
5.1785067572.git.wangjinchao600@gmail.com/
>=20
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178939017565.94750.=
9431053336761330458.stgit@devnote2?part=3D3

