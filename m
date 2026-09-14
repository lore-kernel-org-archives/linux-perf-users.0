Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6B47668C;
	Mon, 14 Sep 2026 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398770; cv=none; b=jiuPL/p+uNdUNSXm+RXR4K02kRD7hXxUOBOwUVxqy1fmKCm2tHq99JabiPhlV0X5yofm6aK0XcyqPTduLsdW34AmZVHe69bZcaU2J1tX3wEYDxu/Ds5w6zrNv58YsI0wi/DJ0ffNqSo7JIzwQEL2LOvSfDVzIeDpeEgh6erKNcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398770; c=relaxed/simple;
	bh=S7uZC5NmIpbjJvc3aNBAmw6yVAZV4ycIB6dVpRiQae8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f/xww2vGbmhpvV0Pm8yKfq5vf+0rkC1R6WrH0wWa4KgaWi648+Zg+SEsWg22Qqgwq2O71/hdgqgA3dCPeCDUb+GBPMKaQa25/9nxIAOrVilx1+0apib3aUn3IXINT4afh7qc5yCmqIq/RPA8BVGw8Lt9BM4qt60Fa7Sg2JD1zeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgXL5Y0R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgXL5Y0R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64171F000FF;
	Mon, 14 Sep 2026 15:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789398769;
	bh=KydHEY+bTECn9LqBLbDJK+Yqmh32ZI3mSxYDrsp7n7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mgXL5Y0R7lzTuOsorIKInWFuX7ypW459wPLgocQVS+EgMn+IizfH6D5h+9+ZGCxjD
	 q1+jSSncorE9fvFhSDNMxw1KFe2F5hIG8yyCG5Y5J437XYExn3OESn5DJNGUgSvQQk
	 1KL0qkAWQo/ziZbNpLbG7ARZUYhWtk5q975Ejt9Xe9kQcnDuGtkgyfcibLM5u2LkVS
	 jjDUlfn4uf0QgZ0M/31+wD+kdugQpb/tmFY2bmZNiSIjLZ3O+VPGD3iztkqqBNmDyK
	 4O/HEQEYT4x3PBhZcpK9DrElm3uKDVm5M6kWjGAPwFDEyD1Lp2OgUezFm5uxs8zPZM
	 0haHXfx/tQaQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 12/13] tracing/wprobe: Support BTF typecast in
 fetchargs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178939031984.94750.7757672527930679290.stgit@devnote2>
References: <178939017565.94750.9431053336761330458.stgit@devnote2>
 <178939031984.94750.7757672527930679290.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 15:12:48 +0000
Message-Id: <20260914151248.C64171F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178939017565.94750.=
9431053336761330458.stgit@devnote2?part=3D12

