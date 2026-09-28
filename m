Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1161463B9B
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582243; cv=none; b=q4vP6QCdfj8v2Td8sM7QddH1BacHvAEIOZtcFRdxpt3+h6O6CsjqK8RSTxYODN2ONh+NxzY0NLL+JZjGlrM5BXy8rDPYmIhlMs7bN+KdDzL6LtYCYNwc+5rfpCUIog5CVmVuFOtghyGDKpdILp3tlEVZZIBd1bQiDgIuHah9BMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582243; c=relaxed/simple;
	bh=BQYS9yf1iysvQNC4iqj37waWzWTgxC/DVQ68aeKIcpE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dQDVq/g6T0kmQTARA4dbWYdiWovn+tdW+lzMlBjw9VLnPSkp9nh5OyfFdPAhbSYzsCzNmZRRuSMOulxiJdUSGH8Quw3YZDqBzejzh2meD5aNoqGf8Ynlizs9B6a6saRZnXoRNu8LZhRBpJPM/bfCOrCLMLlzRnkuc4ckDNDtsYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/ga9qio; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/ga9qio"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4A91F000FF;
	Mon, 28 Sep 2026 07:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582241;
	bh=BQYS9yf1iysvQNC4iqj37waWzWTgxC/DVQ68aeKIcpE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N/ga9qio8gSySzRAWYpqLHjBBuMSZUX2lpxOWZXfwqPxKnqN+dxXd86QW7/p7r0F9
	 kSmFYuv4icbUrehbxrUv7F9tO8V+fpLOEM6gcHV9eqWraq2wGkuB5F5ZNWSwTX46NT
	 CtZ9BC80KGGCWYwl0nJMA0xt0JM8AiC3NBFrGCZa2nXX07KgSuGFg+qwGky+J+j9sh
	 l3N9sAlbu2uXn1A/CboI2OKiukYJJDsnd9pW6xY3pSMGH7h08sUbQEywjN3jJzOtn7
	 hscdE03MfGROhVXN3okW1jLGYLD0IV5KW/hAwYIe62yUWzu3uGzyZbW8D583yZqBKU
	 fauijo/nvX21A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/15] perf/x86/intel: Refactor
 intel_pmu_drain_arch_pebs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928074309.898043-10-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
 <20260928074309.898043-10-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 07:57:21 +0000
Message-Id: <20260928075721.8B4A91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> intel_pmu_drain_arch_pebs() and intel_pmu_drain_pebs_icl() use the same
> high-level PEBS drain flow. To reduce duplication, extract the shared
> logic into a common helper, intel_pmu_handle_pebs_records(), and have
> the arch-PEBS path use it.
>=20
> Add small helper wrappers, including get_pebs_cntr_mask(),
> get_pebs_cntr_status(), and find_next_pebs_record(), to hide
> record-layout differences between ICL adaptive PEBS and arch PEBS.
>=20
> This patch refactors only intel_pmu_drain_arch_pebs(); converting
> intel_pmu_drain_pebs_icl() to the same helper is done in the next patch.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928074309.8980=
43-1-dapeng1.mi@linux.intel.com?part=3D9

