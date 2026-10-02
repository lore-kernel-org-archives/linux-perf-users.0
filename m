Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1AA481A98
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932476; cv=none; b=t/vMMZvjPmLwDwa/wRY2MjE9wkkfo/C3mLOyaNv7rY5by0709PqN4VExfhlOT4bBQ4ZvWuRoZD2FZzwvkgOHMo124d2fHh+7nFbMpxbAznsz0vFkDQgLo6xSo4otgeJ/O6Vpf19niXjbfsmHM6IP9OD+PTLwqTxBC1n+rJvnQHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932476; c=relaxed/simple;
	bh=z+9NWZpD68ySVxAMRywq2ANoPvy3znwtNQBaGHQXv2Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E3yqgIGs6Ll7kuilh2g0C6e8b/5EyBLqjxo0h7LJZosQe7F8hmElO185vh2DdWjDk29dXIFWB0GwHEz3dqG4IX93twe9+FIjSe1biwLC+eLDTS58PGk/C40WCJFYuQDdQYLQopC2LTZ2OQfxAzXZeItjwDZuQsva4GjeIcbsyRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZkdSEvx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZkdSEvx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEC91F00893;
	Fri,  2 Oct 2026 09:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932474;
	bh=z+9NWZpD68ySVxAMRywq2ANoPvy3znwtNQBaGHQXv2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mZkdSEvxwznC07YNmP8R16VApBS8U4MTYrczTW3vXGTuDZNa+4z3REGgJVASXagJT
	 TDJq2VzMwuZisBWOSmemgZ2F6nvrCiuTgFzfcAANJUbgnCw1ld0QNawSLlyQZD7EBW
	 l7NNuJIlnsqy7E00xWImGuhgHUL9hcqQXGfiaN702VpbOqeWNbvCsEOQn6x0KUy7Lr
	 /3atzJ3KGZhtGN6pWVu1CeYRYp29jtTie7U9Bu+mhwTXu4PFX6+sLuw0RatDxs4MgE
	 x2pzoDynoeTV5iK3/CGBLqsPf8FSseOuVLN28Q+cRXLc4nNEI0fB2wq9C2A7FIhbta
	 /bec8aQ/KBebQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf trace: Only call bpf_get_current_pid_tgid()
 when filtering tasks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002065440.2781176-1-irogers@google.com>
References: <ar6nzTSj17IxCy0j@x2>
 <20261002065440.2781176-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:34 +0000
Message-Id: <20261002091434.BBEC91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> In task_traced(), bpf_get_current_pid_tgid() was called before checking
> has_pids_to_trace. Because BPF helper calls are not marked pure, the
> compiler cannot sink the call past the has_pids_to_trace check, so the
> helper was called on every syscall enter and exit even when tracing
> system-wide.
>=20
> Check has_pids_to_trace before calling bpf_get_current_pid_tgid().
>=20
> Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002065440.2781=
176-1-irogers@google.com?part=3D1

