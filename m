Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088438887C;
	Mon, 21 Sep 2026 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018648; cv=none; b=rIJClCiWCNbijhpoXX3YbNvCebDLYW1gX0Mtx16h18vjFZ5xkWaxajWXaImojoXEyRwYnlLSVzIqNwYipxAcdjARK6bV76Jl+yhtkNxN66ge1lGwDLOYeO4QY2kHxEkEZgvvvyA0xM+lyM6MJwPBIkZIPS26HHUWGA5AHIcNfds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018648; c=relaxed/simple;
	bh=acaaEyqHrXFLS2eIPiP3rHwyHTFVOtZsb6ztMDQKfm4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gR8/8l/t9RLo4kh7BoHW+YwLX9+WhzPyufjRA4V5f3k3eqfxowDHrl1vkWhUflXcfxlLj1sdiElZOMv+qa+a9JuQmfpudFwNshCtLPkSOVZCNERqglCMSlR3/pKIO+lyEE5xMIeup7k17SY0LxmPuClSyskNPymcda56hCGiHzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1EFdkfP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1EFdkfP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D4C1F00893;
	Mon, 21 Sep 2026 19:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790018646;
	bh=AWydTqqFnHhupqyPjngLhIoLs+JeIxBrjQ+TDv0UdcA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i1EFdkfPR/3xPk8O6voOPeIQMQreM2l9E9jog4gmskQvbrPf3Tm+Rlkl1PNv85eGl
	 Edai+h/8WI+TTZ9sbQuvsIxIOcU8f8ydN5tUCWvwht0Mm8FuMh90yjD0e4qTQ+dmo/
	 BfUaa7ds9HzxxvRIsH2qAXEz3WaXneZNsL9iLcwaQ0g2dBkeuJWmL8uGWER5WhjDuk
	 Q5jxGbSVNDpst8gwROlRwrI63PhhbcQD58UO65IZDOrlwG9AfZ3bkm/SfRyu/XuJkG
	 G5EH9shJ0TdIS+LHdsepDNAevsLdH1y2sHrH7k29fN/iLllQpqkYXiqYG4gc4eM/0a
	 H8PbYvYUVX7DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/10] perf/x86/intel: Don't context switch DS_AREA
 (and PEBS config) if PEBS is unused
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260921191418.950933-4-seanjc@google.com>
References: <20260921191418.950933-1-seanjc@google.com>
 <20260921191418.950933-4-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 19:24:06 +0000
Message-Id: <20260921192406.98D4C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When filling the list of MSRs to be loaded by KVM on VM-Enter and VM-Exit,
> load the guest values for DS_AREA and (conditionally) MSR_PEBS_DATA_CFG if
> and only if PEBS will be active in the guest, i.e. only if a PEBS record
> may be generated while running the guest.  As shown by the !pebs_ept path,
> it's perfectly safe to run with the host's DS_AREA, so long as PEBS-enabl=
ed
> counters are disabled via PERF_GLOBAL_CTRL.
>=20
> Omitting DS_AREA and MSR_PEBS_DATA_CFG when PEBS is unused saves two MSR
> writes per MSR on each VMX transition, i.e. eliminates two/four pointless
> MSR writes on each VMX roundtrip when PEBS isn't being used by the guest.
>=20
> Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation fo=
r extended PEBS")
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Mingwei Zhang <mizhang@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921191418.9509=
33-1-seanjc@google.com?part=3D3

