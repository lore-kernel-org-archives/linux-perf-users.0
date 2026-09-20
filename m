Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8104356748
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882708; cv=none; b=pR1rgUrjK3TPzIVJ2Z4gqyhtGQXrX0/+jjjJ/CvYYDu5K9oukaiS00eMNwliZ1bycfHA+82b7NXVlfzeRqN7TSdp4d+7fZMJS9v5NiFlMYPaj0q5LJhPFiIpvZi4VQ8uww5OPfOd0ofsWrv3lO/ddV4nQqLQemkK9Mqzn3Aneps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882708; c=relaxed/simple;
	bh=TOm/gloz7vJxt8dWq/crcwWwJXeAILpQb/Nf8h9tAoA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EIdya7rtcnmyPiROb/ovKeAoGwMA41qxuFDHgX9nyORO9NS6S4mVWY3vLMxfqGJUv8MEJYjnppsMxtwY9mHlD2MUKkzEXs59N4OQHq5SpjUpOUIUa620eVTp5jWFRsWIAwYKkxGnq7Jm55znMhvXqPpr4YQewqJZT5idMgMq4e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GS4M0AhD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GS4M0AhD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDDE1F000FF;
	Sun, 20 Sep 2026 05:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882706;
	bh=rtD2N7LMNL/FGq+oVFSZ4P2N1KKPiYIyQJRI24iB22g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GS4M0AhDHC35Rzpip5XoCWaxQa8oY2utWXGbjFPsuDgQMjoDLHs6VL1Mp4DYQLXkt
	 XdGpc/WlbXecOsVHCA6RKX4NdnIb4xJvNle9k4MbxJZlUHFmRHjFH1ZMWPJ8qNlJRb
	 ZK1jGV6W++yH15NeIT0QJLWRtvZ0c9bdA+MKHFfA+Z56Up/pgBs7MBpUwBieoF9F6u
	 ledkl0p7rWs2T+VTZNVIoRtX+dZvqXds8zxRXOBPc6KXrWhD0a8SF8SB62YvOYCkVA
	 hGQay99Qt+KJy3waurjQzDt/3IJ7Zw1Uu5SRgYk9//1HmetzqW13WgLiP0NAoxyhXl
	 VdE3BTNP6BlXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 39/49] perf python: Port powerpc-hcalls to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <aa8b536ea5805d9d45226db53a79487bfafa751d.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <aa8b536ea5805d9d45226db53a79487bfafa751d.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:38:26 +0000
Message-Id: <20260920053826.ACDDE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port powerpc-hcalls.py from tools/perf/scripts/python/ to a standalone
> script in tools/perf/python/:
> - Refactor the script into an HCallAnalyzer class with full type
>   annotations to encapsulate per-CPU hypervisor call entry/exit state.
> - Use perf.session for event processing to track hypervisor call entry
>   and exit timestamps and aggregate min/max/average duration statistics
>   against HCALL_TABLE.
> - Add argparse CLI support (-i/--input) and remove Python 2
>   compatibility code.
>=20
> Add a shell test (test_powerpc_hcalls_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D39

