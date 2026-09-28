Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C85346D085
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582445; cv=none; b=X4y4Sf4rf11F+ovXTWbJWeHCHmSxKfuBCkjYWba+AHvSLW6hRv3EOAw6QP6gow/o3BENmaoTdwITr44Z+5celGroiOOsb/PclYSFKS7ve/LWwq4JxxONXDI9GlvHINgRiVbXLGsHnsgjFgDjGNun0W7cN75lBdiQtmsAfU/9RTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582445; c=relaxed/simple;
	bh=OsHoT++boVgHQJNpqoktiIt35gMNFlzbxIhG0pKXCM0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M/v/wfFTdudSqO2YQ0Pae1LGz6X8w9ecn4TQBUDRyTA+CPZmfMUEIrohSfqU0lhplQgat9SeC6/bh+4Z4yhoqit8nGKhddaUE3i76Gm7QZ1ZzudCBGt0iliWUutKs7ObBI0a/SxUcxbN6dRKekJ31LYmkD+lOX0IlyiYT9x4pnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aj0Ydo/v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aj0Ydo/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB341F00893;
	Mon, 28 Sep 2026 08:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582440;
	bh=OsHoT++boVgHQJNpqoktiIt35gMNFlzbxIhG0pKXCM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Aj0Ydo/vXmUJYtJ208rprk3lP3GlG2mqJ6fLyqi8QpNUk/JH82VinS1EibugsWVi1
	 oVOVAQxet12M9wYlU11TrSjOW0OFzNb3vowzm4KGog41AcpkBXuAo0BECxNk7rwbwE
	 6cFb0JDx4ozyDX4bvOfPM148RcjxAsQGD6yYLfCLUFBlpaBdFYqDzSC6NKV8YIIle5
	 a5hz1hwInOquIkarhDPhzLM7Nnmt9N2TPILI2VFlvUb9jIIUeDWzu4RizP6VxheM/5
	 5PVf9xnvkMAFRuMC2Yu5DN0fKVcYSP0I07I+zIbbwqmXdGH/ufrQlNhYpFCln675iW
	 tHikTzCDn83PQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/15] perf/x86/intel: Limit PEBS counter iteration to
 valid array bounds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928074309.898043-7-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
 <20260928074309.898043-7-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:00:39 +0000
Message-Id: <20260928080040.2BB341F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> __intel_pmu_handle_{,last_}pebs_record() iterate counter indexes up to
> X86_PMC_IDX_MAX (64), while counts[] and *last[] are sized only for
> INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS (48) entries.
>=20
> If pebs_status were ever to contain bits above the highest valid PEBS
> counter index, the loop could access those arrays out of bounds.
> Although that should not happen in practice, limit the iteration bound
> to INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS to match the array
> sizes and keep the code consistent.
>=20
> Fixes: 8807d922705f ("perf/x86/intel/ds: Factor out PEBS record processin=
g code to functions")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928074309.8980=
43-1-dapeng1.mi@linux.intel.com?part=3D6

