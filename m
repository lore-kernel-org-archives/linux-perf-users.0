Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557CF37701A
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620564; cv=none; b=kfIRhcx6UditeXdV8Z7hfxocowz5uUAHKBTdnc1yaNWDjXNk69sV6BQsvR2x77cHlMWNYK0Y53CRIGAMvK1wyFFQumVOXGQh6PWG0oRvGOZXjVaN+3LTX22PN7PiqTYo698XcT3Wzm6NUKNw+yGFxdx6iHLo1fCtWudcf/LGBbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620564; c=relaxed/simple;
	bh=+5t+BjJOnZXYIFfkmXGddUK5jyxAOoiFRNssIEJzl4Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ir3cP7P+zLhnnBVJvkAfDPVBWF0xn6Wgo1+J815g8Sj554SDTWZ0v6Nk+Hcu6XhwvwKr7p/zVzWuCfgFXve/woyODlvDXt49xjzZLpX4/kUgrrGv/falApbcQ/UTI6eQgUFWjmt1WJNfE3lyMdk2PhsffG1R/rRRosuEq/XODP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSr4R8Zz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSr4R8Zz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20CF1F000FF;
	Mon, 28 Sep 2026 18:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620562;
	bh=+5t+BjJOnZXYIFfkmXGddUK5jyxAOoiFRNssIEJzl4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PSr4R8Zz7BvnJ5/iQd1/NRqIxYRs1erisWupgFpVqF1XU9l2xnR8WtNStybTY7gmv
	 GIiVK/H91a8gt0FlT3o+bUS+h1LQLHdkuMpGq81lmmvPStrw0mHssCmYilId4UtJS0
	 QNw1gj+Jl6E7oXUUGKkqi75xsWip2RIG7Eg6VAssGpzxVT1hFaJHVylHtfr2/aQW/6
	 X3Qy6GSeBxOZNhvU+R1bD4n8PbXSoFpUM8WX2L9FHLY5kMpEAeWSpZHXYSDcjMVOJx
	 KVUvjNOLafCXOj3OXyizm8ssUfg5bv/prdK88xDWsJPOqg27cB+NDxQ5ZwxsfNp3nd
	 S8v3GmPNtvPtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/26] perf trace: Open the BPF output event on every
 CPU for task targets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-17-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:36:02 +0000
Message-Id: <20260928183602.B20CF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The bpf-output event is opened per task without inherit, and
> __augmented_syscalls__ holds each CPU's event for the first thread in
> the thread map. bpf_perf_event_output() only writes to an event active
> on the current CPU, so the target's other threads and its children
> aren't augmented.
>=20
> As BPF now picks the target's tasks, open the event system wide. A CPU
> event isn't enabled by exec, so for a workload enable it when opened,
> BPF waiting for the exec instead.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D16

