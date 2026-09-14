Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E30F366567
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426425; cv=none; b=CJKkSdtlh47iaC+/3Dr2GzSUKlQ8AdB76l0e7s250y2tm+6KbwkcK0R65m7wH3subOlsF7lXJZcSI4QCl3aEOVabhb0YeK1j4NzXVU2rZqWZr1ckVjXtTK5Ij6JBSN67SntJ3I3nP4zX5/MoPTNze8tVyyO3vzDZ2LFU0hG2v7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426425; c=relaxed/simple;
	bh=n+cVUjCtJ3zL2vp3qHeBVG39Fn8BjNJp8Yr1Pp6gtDc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uHnIlQSo64SCI2TxLDh5tqMSUeAYVwc9r4VH5MJ9TEyg+L/hh5EMAB7AWo3HZjlgVGpmZQjc1Uprn/WNmAKKxjH46H5i8RIiSnxJ3tR7D6azPUwoJs6OUoGnwYlx7AS5Lj2p1XhrmvSwRVsaKFttHcWI2IWoYS6D4hfgv/nwFkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVLLkR4U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVLLkR4U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BBE1F00893;
	Mon, 14 Sep 2026 22:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789426424;
	bh=n+cVUjCtJ3zL2vp3qHeBVG39Fn8BjNJp8Yr1Pp6gtDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZVLLkR4UCzIbOFN2UnZ/EGfeXFDyll5E7vATd0O3wybQCGY1OfB6VWPzxV/UiuDtI
	 Q11g8hGQU/CjLmc6/BqTRYQJwSpxYSYpGCIoxX/ug7ezTNr1cmu0w132++ItasxDoj
	 VJxPup8M3nR8OFNJ0XuFZ7GkGLX53mdCrhYvDHkLAiVkX3XX8yDzSfWa8uDb6SlSFj
	 PlgmDu8DGb/AsawYnluYZsL3u3jzhs4tImSHy8i598gh+vwnAb2CxHCqH82DextgDf
	 DscVmr6/DSqGAGT4W2KKK9J2AykL695a6vzPp3U0GoS2Pp203v6jTZuh5oHhlE6oQB
	 IoNoPVNM7kQjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/6] perf mem: Fix size tracking for mem_lvl's in
 perf_script__meminfo_scnprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914224650.52982-2-thomas.falcon@intel.com>
References: <20260914224650.52982-1-thomas.falcon@intel.com>
 <20260914224650.52982-2-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 22:53:43 +0000
Message-Id: <20260914225344.00BBE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When printing memory info in perf script, the entire size of the
> buffer is passed to perf_mem__lvl_scnprintf() instead of the remaining
> size. Pass the remaining buffer size instead.
>=20
> This issue was detected by sashiko during an internal code review.
>=20
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Fixes: fdefc3750e847 ("perf mem: Print memory operation type")
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914224650.5298=
2-1-thomas.falcon@intel.com?part=3D1

