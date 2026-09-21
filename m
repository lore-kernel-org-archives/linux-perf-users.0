Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9826939A06F;
	Mon, 21 Sep 2026 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018903; cv=none; b=LoA4BRF6BGJ8+pg1X0Hq+m0rlj8JQMJvf5pvdMSBVGLI1ffio2Ts6GL9REvif2GWqi0YPYd9IA9m9xNaAnVcYZ111VTuFKuvRnQ92Vf5PtJTdIOJ4yRxc6k8j2EMjt9XIv26aQ7TEXH9E/H4xTMszY9FZFS/tht6M/xiRIpa6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018903; c=relaxed/simple;
	bh=NaCqqP8mnMyp3l/k+E8ZCXgmHinvE/FzPdPUyynWJM4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pRGbGQHWk8KbHLrmD4V4BAO99PJs9Kr4IQupqgSV5AlEzrhxQtdAer3aBjQsTBHrNR+isnb4rjCd8TniEDhIVBeHUvF7Ucc2wgSK6bSDyqGKPWJod6wE/9Uc3JA2ksNzX6M7Cx7P9j/tYDNFlihB2u8/x+1JJ6h+7J7mfGgHRSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BL76zXre; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BL76zXre"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906781F00899;
	Mon, 21 Sep 2026 19:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790018900;
	bh=M/DWzqqpJdk+nG+uA/GMWnhryd32n3yt/HP2cRk0aos=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BL76zXrelP/yRYphzpvX8NILLIPCEAWUeloSVecKhxmr9vY3wV0lwAYbHVAxB3q07
	 5XTz7vs9J2d3fccmYsZmBgYunNjfIwVMgRmGSd1MASBsdePoiNhtHxyAYI11HpafK0
	 OqaJfo79N1T/P6XdMxjN/UPNTWdyb7qJ8FNV7A6XpYRohphqgQ7iviE6sfurnebc6C
	 FDVJQVJbqwpBkIUs8/Jo+Wku8kXD1d97twOQ87CCv9oPKlwITHWx4GxDiZYv4UuL6H
	 kZqiy9VkgPekqgfBrQD2XWpKNsW+q6xmD06VDusQTXdfQVpVeF+0wBgOrZqhOOqEuC
	 UlBtFwdgGXn8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/10] perf/x86/intel: Don't write PEBS_ENABLED on
 host<=>guest xfers if CPU has isolation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260921191418.950933-3-seanjc@google.com>
References: <20260921191418.950933-1-seanjc@google.com>
 <20260921191418.950933-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 19:28:20 +0000
Message-Id: <20260921192820.906781F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When filling the list of MSRs to be loaded by KVM on VM-Enter and VM-Exit,
> *never* insert an entry for PEBS_ENABLED if the CPU properly isolates PEBS
> events, in which case disabling counters via PERF_GLOBAL_CTRL is sufficie=
nt
> to prevent unwanted PEBS events in the guest (or host).  Because perf loa=
ds
> PEBS_ENABLE with the unfiltered cpu_hw_events.pebs_enabled, i.e. with both
> host and guest masks, there is no need to load different values for the
> guest versus host, perf+KVM can and should simply control which counters
> are enabled/disabled via PERF_GLOBAL_CTRL.
>=20
> Avoiding touching PEBS_ENABLED "fixes" a bug where PEBS_ENABLED can end up
> with "stuck" bits if a PEBS event is throttled between generating the list
> and actually entering the guest (Intel CPUs can't arbtitrarily block NMIs=
).
> Fixes in quotes because leaving PEBS_ENABLED as-is doesn't fix the
> underlying problem of perf (via PMIs) being able to modify state after the
> perf<=3D>KVM handoff.
> [ ... ]
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Mingwei Zhang <mizhang@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921191418.9509=
33-1-seanjc@google.com?part=3D2

