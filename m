Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF263EB7F0;
	Tue, 22 Sep 2026 04:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790052035; cv=none; b=LBC/fJNQcsfShMKS5kGbEISrv89VWD+k5UfhWhobSaLrQdCYii8iGDCOa8FJ2LbjXzY/7G5/AvJWsHZ8yXFDK3SVX670/hLXIXIzTxaaR5GHGT4v9DViObo4q6jIl0Ik2flZIk8gLGL+g41HMNWCBxsADBTugu8HdsrxtYJD/3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790052035; c=relaxed/simple;
	bh=gOYf6wn0mGV6xWJFSg9e15PTCNCdNpmxuNLajrS2MyM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ww8ZWgNOAWFjQNVdG4Zsd6dSIe2FJRr2tgX3HMH6/Qfx/9ab1ZhumY0wt5ySLkPCByX4QsaO3fy4NEOoiDj6/GyX9CI6lWQTZ5s/kJLtKuCMx4X2uXxJiZfW6U7I8hLBSu6ESaaSzACk/3gmeHuGxHB4LASn1CVQnQAONUPKLNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUAbxtsj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUAbxtsj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B3F1F000FF;
	Tue, 22 Sep 2026 04:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790052034;
	bh=gOYf6wn0mGV6xWJFSg9e15PTCNCdNpmxuNLajrS2MyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TUAbxtsjCGzBrNDtIg5UXBKTt/9anlEu5JHeAvaVAZfJDRTBmzxWmTgmJ4enH5Dt3
	 ix6PsyWdKGKNyGLwp7OeptCdldWSt2p5MFf+lc8xXSfdDrZWwrkCjrIujROp4RhoKg
	 jcSWqul0m+G49N8FLdsZNLFyMXuUoZShX0rB8CMqRcZsprp1oe00GpuzLqxTddEe6i
	 msVFMX21l+Nz9EZiQqb1KIF/khwnKK6SaWAPD3aRaRQx471yBvJKH5ZP+XGQGtQeAK
	 Tg5q+17+neuBxnTORZx8yI1+/2pC5qn2CE0uBncDa2xvisCumm7Tlk13ts1MiZs1JR
	 wAV+iADXRZcwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 03/13] x86/hw_breakpoints: Make DR7 updates NMI safe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: kvm@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <179005111951.388919.3131603399440492416.stgit@devnote2>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005111951.388919.3131603399440492416.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 04:40:33 +0000
Message-Id: <20260922044033.E9B3F1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179005108298.388919=
.4535333252892590932.stgit@devnote2?part=3D3

