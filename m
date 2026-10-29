Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250326;
	b=UMZiqi81BfBSQITenAkKuKgdUy+Y9/NLV4LrwnvQabsPj5Uf4BH6qm5IMAxlTZ+ZZ35Q
	 qyNtv6lofm80Zz3prt88/krOoIenJGUWPdxRrw92QZBuStLqbniMoaeHuY1797hWrjWb4
	 Qt27dnpXxYbpng51tJzYyziZLu3cmLFewl+wjy2Qha5ozpx0n2h4W/r0yHECm+KF2mr/O
	 NL9XAC3O+ZTaM2uB3v6LOJeAbboeo01O889to8Y+pwpOmlpUXbBUjwPSoZ8XFjys6GenO
	 qRZ/aDvE5RDh/FELun2MaqtvTrkAlaQvP4a9Z07NRP2teht5ZoouhLvpkNTNeuKbRLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250326;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P2Ag/3NX0ZxCCfyNlr7DkTwZhT0Rlg5E3G+xXPAX0jM=;
	b=lW0M31oE9I21QPc3kLpQzsrevJICKxQlNgkNEaWTfRTW3nKaTyt6+3lcI58R51BrG3Ra
	 S6dh0z+TXMmw2gwV/GcZsjfdgTwoSmcrRhhOZtPv5BfoKloG1jfi3efLwZu9hfTOAi9UY
	 i2Q6CLiwFqTlKW8KuqCFpyG+WPMFGbukcHdSULYn8V4IYT2mwJxJkVnNuAlx3izZHoi8G
	 AoEqrp8sA62FMJJ2B5fFkcLaaS6ExVD+fuddM2fyGslUsfHVZ0kgggozmb3BGq204hc/q
	 OHeMhS1bYj8hxUm8i76rxOP7VSOLgQSIQqsVI8eHfDmNNklU3jwz+6EAkMchgM+ugFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="A3PMfZ3/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33D3606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 05:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A3PMfZ3/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4897B1F01825;
	Thu, 29 Oct 2026 05:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793250325;
	bh=P2Ag/3NX0ZxCCfyNlr7DkTwZhT0Rlg5E3G+xXPAX0jM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A3PMfZ3/ecS9O27og2u2TYZhnIrGlmZd/i6UXd9z3rtf7O7Hd+Jp+jyr/rCJdAL0T
	 YkaFq4M2TMH9/svyPLQsPzu+3FxlW2R+L1S8dMXnIdUpYPI5PSmRH7dS4MM0z/fpA6
	 4AJlTO8K1wY4VzMH5Z4ZzueE9RArHxd2IW0hrBDy6NPnQI3gKWM8GjCVfCDWMJOebG
	 IEvWEeaESiLLfG86q0vhMQ6AK2NOxECE+8jyiKgtTS0EpVs8t5oplhxc1mfkiI9Fgg
	 my90Db/HBJVWH11wyPhQO+3/V3XvZXTpVqHUowvlaBSTFVz9BtzUZP5t6HFIadCjFl
	 DRCyYFyPp/z3A==
Message-ID: <sashiko-outbox-188728@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v5 11/18] perf/x86/intel: Use a dedicated LBR stack for
 BPF snapshotting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029043914.1395147-12-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-12-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:05:24 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> BPF LBR snapshotting currently reuses the default LBR stack
> (cpuc->lbr_stack) when storing sampled data. This is unsafe when the
> BPF helper runs in PMI context via bpf_overflow_handler(): it can
> overwrite the cached LBR state for active PEBS LBR events, causing
> incorrect LBR data to be reported to userspace. When the PEBS and BPF
> stacks have different depths, this can also lead to out-of-bounds reads
> when the LBR stack is later exported.
>=20
> Use a dedicated LBR stack for BPF snapshotting so the BPF path no
> longer clobbers the shared LBR state used by other perf events.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: 425507fa5f32 ("perf/x86/intel/lbr: Optimize v4 LBR unfreezing")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029043914.1395=
147-1-dapeng1.mi@linux.intel.com?part=3D11

