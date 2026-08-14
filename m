Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFAA353A75
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730501; cv=none; b=lIEIssdYvW3CaPUxO7sz78NRQnQCgeb+F008yY9/H3356/UM6Zm5zmz3mgimeFtMaTTfd7ezrsFZuHn7yDSoTl2iT99GeTVrdHtf0LvpQDHyVZOMkfFbErpARNYu3RN+iMINC4wcOTz4u8BZJ6Ct+JV56a72Ko9MoxVCbiK4dG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730501; c=relaxed/simple;
	bh=nK96wFza4vvptpUL/ktgfW5x/0CyW4/rATBtMjPGfZ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NR1K+nNIlMv3UV/h3hn3LEbfZxXmQmvmIpjBTu9w8wmeThawNEGXCPbjLllZFH/OBEdOy1psbGsBs2ZiWYO2HpfFN92XZ8mYdut57gd9PqyDwisTgh6NQd4ZYJE2zTZWRMzE/bz+7wH3lq49GPNXEWMKQ/3tTnn0c7kHCjRxSCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbI6m0cq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbI6m0cq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31731F000E9;
	Fri, 14 Aug 2026 18:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786730499;
	bh=nK96wFza4vvptpUL/ktgfW5x/0CyW4/rATBtMjPGfZ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZbI6m0cq07E21yi24dQpPZ8eAGn/QYGPFeuNMHxTJ1t6MTcnN/5uD9M2KHQBNTkwW
	 FPXxPSOcXNbHT8l9pVroyWiKggr08BqDxG4SQzmaUAKxD3Y6xnPW4QDeBt8eF4AKbD
	 BwL7CI4YPIrrsQRz08z0e40ZFcNuiNUuOshIcNY3qGUimLcKZ7P7cDCXL588NuWXFU
	 EsyBmzCXc2pyUC1p8A/OuJwYWaXxrUaB+TWTcl1r47z3oqzQtS+0It7d9ui3tV7D1P
	 EO+6ArV5DNz7Fq73ZX00MneRc+EOYChTo0FPgo3b95QzEMJXiuwwgUlgM6fwxVbLxi
	 zQlVg3qN5u7pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] perf/x86: Add x86_pmu::print_debug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <36cb7f0289adf8a186e6107ae3f6f5286857fd00.1786728929.git.sandipan.das@amd.com>
References: <cover.1786728929.git.sandipan.das@amd.com>
 <36cb7f0289adf8a186e6107ae3f6f5286857fd00.1786728929.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 18:01:39 +0000
Message-Id: <20260814180139.B31731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> perf_event_print_debug() dumps the global control and status MSRs
> whenever x86_pmu.version >=3D 2, reading registers that exist only on
> Intel-compatible PMUs. This is not safe since x86_pmu.version is not
> Intel-specific and is now set by other vendors whose global registers
> use different addresses.
>=20
> As a first step, split perf_event_print_debug() in two. The register
> dump moves into a new common helper, x86_pmu_print_debug(), leaving
> perf_event_print_debug() to handle the preamble and dispatch to an
> optional x86_pmu::print_debug method. This lets each vendor-specific
> PMU dump its own global state before chaining into the common helper.
> PMUs that do not implement the method, such as those with
> x86_pmu.version < 2, get the common helper alone.
>=20
> No functional change intended.
>=20
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786728929.gi=
t.sandipan.das@amd.com?part=3D1

