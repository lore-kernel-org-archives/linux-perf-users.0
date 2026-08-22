Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBEF352037;
	Sat, 22 Aug 2026 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787391182; cv=none; b=goE+GxNNVpdb04Q/6UmZdlgkQkV7twtSWuUsM5mxEpAoD3WT5yvIosyxSgzk230JUfFe6VT5XiJubOHlOdXt2kFfsbFgnTmLKT1EmzZWt6Z9cslIa/dYkTtu1oYTfqfZ2neRp9BIY3dQ7kLmuGoo87eKl/vtbcy0E6BZaEsfQog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787391182; c=relaxed/simple;
	bh=Ku0FaQLM2SpeS90Gp5vo8Kdxhzr8TuQG6WAWp1NrLgg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WDNKhloBRZjZ13xOx0bWMZCMfndOKzrW1NywlehqX1Goo3GzDRrYv65UB6X3MAGj1Gkzh/dx0bQJpEzZ+7HB8IUsoAdWxNIGVGUtxDWZIe72rQAlmBAKzTXpY4Oc3zTSdCkVZ99rKgBazi+7p2YkEOMIsLT5dX+5dbzEkwL7SJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/VPT9tS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/VPT9tS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430B81F000E9;
	Sat, 22 Aug 2026 09:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787391181;
	bh=Ku0FaQLM2SpeS90Gp5vo8Kdxhzr8TuQG6WAWp1NrLgg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e/VPT9tSrgVJPtGTBjiMLyhU0zWgBQATQR0kKrJJfedmtYMbFbIjYQVlnEeE79/v4
	 YWALcyzWNB1HAtmDYsYPP304v3lilWJCkql3QWxB/hG7FQKx9cbW5TitaDhc2z5dtg
	 ed6BGg+N45wf8G1p4lw5Q/wEzxwN7uHsfwGX+sdimodyoZJZN6DqnJ0yjDwGmCF5BL
	 DVot59DovvsxvJWiWJFGr9yqonsNIxYrQGtbnx9mwY0K4+g4Qzz0ErfDImXwlVEBVS
	 8HXsuLcgMjcV/6zwHvs3IqvKLU2j2AQ9iYv2oNpdcbTarL7oxRuUosuZPPkkHwQdNO
	 fB8oY6qXiUL/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 03/12] x86/hw_breakpoints: Add
 arch_modify_local_hw_breakpoint_addr() API
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178739057338.1520941.9166530552338317000.stgit@devnote2>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
 <178739057338.1520941.9166530552338317000.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 09:33:00 +0000
Message-Id: <20260822093301.430B81F000E9@smtp.kernel.org>
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
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178739053919.152094=
1.17662338993878200834.stgit@devnote2?part=3D3

