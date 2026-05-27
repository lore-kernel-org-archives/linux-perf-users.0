Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBF837FF41
	for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2026 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896709; cv=none; b=YFMuD1fbD92Imf94Gxf6Y3lFrwQL4T48ftgTjtLbZY++kwqlsbHF99rvfao/Y8Z/15iDwZCJzVSa1PhF9iYAxTv0RnbMfkd7aZ2/dymVjLyiNqncSVY7a3/IVCfa0t1itceMrv8s6WBTHEGw69HiYMcwyCcHJF+y+8QjrcFISOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896709; c=relaxed/simple;
	bh=UGjowfXcxO6TvAwes1zdO/W9JcJWbQo2pxJaWmggDHE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G5nlP8yYLM5kaY4NBOF2UY6VHdVOTJ2QmV19cw+QPQTvGsgR4BF+5HiCWOoTNXjGExRd8hw79d3uAlpBUd3AhCN0iQNQVs742dWwmo0u4wbXNhXv1zvzGTANmQbvq+hdIVFuqKdgfDJ89+WH35OxbXeyNxLvqTeYdKFnq+7Aq5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyHJ6i+R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyHJ6i+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329CA1F000E9;
	Wed, 27 May 2026 15:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779896708;
	bh=UGjowfXcxO6TvAwes1zdO/W9JcJWbQo2pxJaWmggDHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NyHJ6i+R5ka5442bEM2eaSYzKrZO0wc0slNaGL0rTe2EKYqUKyKspdmrO86WM61g+
	 5zyJ5xUkj3/aojXl0pcK6EPEtMyK+OLLRmjjJK2YKH6Jaj0BSL2r05rEwcgAgvEl6V
	 I10Ft5JP2ZVT64JtucQtOHInQbwpfPejTBtuyOx5QHR1fVHvrEsLl1kN0oa3Wl0PlK
	 DT4rWPq8aPvbW1c6+tNIntfRU9WuYXs/dadGkVYMNzpiDLY91PlBf3P6JvDYX1rOHO
	 qYc79H4vCWazNq3i4LIzINdw5iNJJJhz9da6fw39uWQ9jjtrA885rCG6q6rOB0nis8
	 cPU0G3DSHY5zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 1/7] perf/x86/intel/uncore: Fix discovery unit lookup
 for multi-die systems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260527151154.130505-1-zide.chen@intel.com>
References: <20260527151154.130505-1-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 15:45:07 +0000
Message-Id: <20260527154508.329CA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Unhandled return value of 0 from `intel_generic_uncore_box_ctl=
()` causes fatal writes to MSR 0 or PCI offset 0.
--

Note: The format of this report has been altered to provide a free-form sum=
mary without directly quoting the original patch code, due to automated rec=
itation restrictions.

commit e9069bffe8688f6e4044b8f15ff7ac27dcdbb094
Author: Zide Chen <zide.chen@intel.com>
Subject: perf/x86/intel/uncore: Fix discovery unit lookup for multi-die sys=
tems

This commit fixes a unit lookup issue on multi-die systems by using the box=
's
die ID instead of a hardcoded -1. It also removes a warning when a discovery
unit is not found, as offline CPU dies will now rightfully return a NULL un=
it.

[Severity: Critical]
In the updated intel_generic_uncore_box_ctl(), returning 0 when the unit is
not found (such as for offline dies) appears to introduce a regression in
its callers.

Looking at callers like intel_generic_uncore_msr_init_box() and
intel_generic_uncore_pci_init_box(), they seem to use the returned control
address blindly. If 0 is returned, MSR-based uncores would attempt to write
to MSR 0x0 (IA32_P5_MC_ADDR), which triggers a general protection fault and
panics the kernel on modern CPUs. For PCI uncores, writing to offset 0
targets the read-only vendor and device ID, which could trigger AER NMIs.

Is it safe to return 0 here without adding validation to the callers? I
note that this is fixed later in the patch series by a commit named
"perf/x86/intel/uncore: Guard against invalid box control address", but
does leaving it unhandled in this commit break git bisectability?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527151154.1305=
05-1-zide.chen@intel.com?part=3D1
