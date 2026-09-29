Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A1223394A
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790713363; cv=none; b=pqI0gW7kMWaOg39B8Pr1Wyy9RDdzlE8rPrlnwoXMwGaiVDcLgm7PSyCtuRurZec8owNZSBW1aJ6PidzU91Q12j4GHzT1Dx/K4E+Cj+UcdG9uIp21kgzvWQIFMPYs5KLWz8fE1vAsJl3OWd0rHgz1NM8OG2prM1HkLEDDZlnSblU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790713363; c=relaxed/simple;
	bh=EpY+GYey8hQboFrJtTxL+0dfQ7C011+o5hFrUZHjLqg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bZgwAS2zOmg1kerP/WbGLZWCR+eqsX3RhjK9QMsBr+bkH3sXiV4zQF4kAF/ruk+BMZKf4iVipXS61NqUOQ7+jvNz2+3De9ZaNhXdoRMtQMHqM0H5WNcMVhLIdBd5ortB3usMLru97uCBHM+ydDIpn//xOtaO2CK4ZySAoqKrTcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdPQYywm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdPQYywm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEB41F000FF;
	Tue, 29 Sep 2026 20:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790713361;
	bh=KUbPj9dkCEpGJ1AMcWbNT9KXYumDZ5H3aj0MHBt5fCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gdPQYywmVl5m67nOpCJnLuKP8snwNOjCu+ujjAKX6uSLEQfzAk73CU0WO8l6103G9
	 vsw8GtEDDccQnDOKTOZQoh/gt1f1Lq+sS7MXpoDXlMjAVwNZexBim4CPSphicgQqwe
	 VHIHY+4thcSstqJSJeUVuQECuML1i4hkiwiHIsz4auH48/fdzR71OLMcpMaURmaOoC
	 3VE+3KBU4AhfGcKQ0TsUVyVYa4jwN45Pfu9dYrC75jJ6LR3EfZ1ibcBdRXf6JFsV0A
	 rikxUQkXtUIkSeJY4vbFBr1HFfRIOWW1SjZmormtGrw5t2ST6tusWWm4/X6DvoIZcz
	 J3hz07/AH2uFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] perf scripts: Add perf-stuck, to tell where a
 running perf is stuck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929201524.2507733-5-acme@kernel.org>
References: <20260929201524.2507733-1-acme@kernel.org>
 <20260929201524.2507733-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 20:22:41 +0000
Message-Id: <20260929202241.7AEB41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A perf that takes forever is hard to tell apart from one stuck in a
> loop, and there is no way to see where without attaching gdb.
> perf-stuck.sh samples a running process' /proc entries and its progress
> line at a fixed interval, and with -g runs gdb (perf-stuck.gdb, adding
> the perf-die-chain command) when no progress is made across two
> samples, printing the DIE chain a DWARF type chase is stuck in.
>=20
> It is a prototype: the plan is to turn it into a first class 'perf
> stuck' command.  The process name is resolved with pgrep among the
> caller's own processes only, as root an unscoped one would attach gdb
> to the first process of any user with a matching name.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929201524.2507=
733-1-acme@kernel.org?part=3D4

