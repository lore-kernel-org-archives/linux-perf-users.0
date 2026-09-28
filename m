Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963623876A0
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620403; cv=none; b=Oc//pon3SDd5nhjVFg0juem8NAfppvz7boECfX/wrYJJ71cACUIL8QNlMf4YEX5QYE7ocvr4bVp6BLtPMrkb42NqtCpI4GmxqrMZpHJAFZtS78yDY+I1zGC/xVdBWuyZpRe8v06rKf+bxjOXET6g7kvbRJouftNN93m+FMkZ5d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620403; c=relaxed/simple;
	bh=C4DZy1xDTdfVlOySEKeSb1s5ZxdLkhpven39L6wlaHM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aSJAYmVt9mE/3W1wdjoZkTmMi0HnxnLtb/9OwCE6uPzNb+nWZyoRMOV3a0UW1u2n6M65RS29WwiRRHcrsN8hX9Ivar6XoysM1Nlkfkzg9AHbwdCbZodQfvFN5K0G9GvwdZdNa3a69ZcCa8T+2pW/i7yjcCH+sKl3Nc4JXC0esU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiTpZlAb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiTpZlAb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FEE1F00893;
	Mon, 28 Sep 2026 18:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620401;
	bh=C4DZy1xDTdfVlOySEKeSb1s5ZxdLkhpven39L6wlaHM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZiTpZlAbpVHBjKDDZKstvZ8AgHihjlEMVu7qc74CeBGS64qhvPJozmfHTVPJhHquU
	 op093shnSLLGQ9+wp+SQeidTUJUCVTMPoDx9m3P1ycMdf0JdNnN6u41OWBDuaakEf9
	 XF+HG2supqlInNXSg8T5hhmv+wGBHq1Ixx31SaIkImSk8emo3KkBfuT9cMx67qlA7N
	 5+0xR9ZOZYz5Als6iSqgM94/dj+Aclfx8XzP8WflqzzAmoFKfYqX5+kU3reQwhofBN
	 khPwSMXM6WIejyqEnZVAt8ifTCAkeatETslNlqQEFixN/5gu795TK98SrljP5372jH
	 9oARD765cHL+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/26] perf thread_map: Add thread_map__tgid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-15-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:33:19 +0000
Message-Id: <20260928183321.21FEE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> bpf-filter reads the tgid of each thread in a thread map from /proc, to
> key its BPF map by process, and perf trace is about to do the same. Move
> convert_to_tgid() to thread_map.c as thread_map__tgid(), taking the
> thread map and index both users have.
>=20
> While moving it, fix two bugs. Match Tgid: at the start of a line, as a
> task can set its comm, shown on the Name: line before it, to contain
> "Tgid: <n>". And check the character after the number before freeing the
> buffer it points into, rather than after.
>=20
> Fixes: eb1693b1150d ("perf bpf-filter: Split per-task filter use case")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D14

