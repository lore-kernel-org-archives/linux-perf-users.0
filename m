Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114683;
	b=dDbFkwUPvxrof4N8raWojZzwm1p90GSs/uyOe4y9GycArhF4Gi0/kJlgK5rz40VLStK0
	 90aBcUm7r3HrFiY//lI5HXnIg4Au+cqAOkBr7DY7shOyAJ8/bXZHfJ3NuSQ6OPpl2QouK
	 D2m8iGMR4hRHJvDUAbmOFayZfsuiGpLBaIepKJLhrabJe3Fqg2COTspgnUJe1SRo0baf+
	 UabF2fWK2Y6qimxrEkRlcMKccSgAkN6ivuL/vGpTkBdPTIbINWDud3LwvMeLY7glYwPjK
	 hkbwv4zdAlplr1IZPbHqQaD5Cy3QnpPiWVEoMXDjmJN1YWokI8nFCRfUyxK39jdueRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114683;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FH4aBNU7q0uVDlwsenmLHhkGzgo/V+aOHVjxXgaFjXw=;
	b=EB0W9V19wZi93LNjQznr3eTpCulnXNeUJy7wqFFDXiq4kfzEwLmyHBjjHo1ezLQJslHc
	 U/hykS6jprkw43TemP2wa6kpec6RtrAxNChpG3X/4HtXS06Ov5epRLlp+7e+vT4/UpB6x
	 4fmsc3W/ffJAyN3UaUDPoDyI7dJXVTxTXFmkabdcANFmm/yUp0o73tN3A+KHNWIGFYgkq
	 W8XNcqiclq0iaRmlp1uLEGNR/8WxPUFaD1paH4wPyIQL0tIDyD/hjnWZ3EWf/g5SJhLI+
	 IAFf7ljaepit7WRYRbyqLwMzzc1p3zivz2yAGm2q+vYFHEnXQwPuu/yV7aWbHFg4Zlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nv1RT4yO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66170606A324
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nv1RT4yO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF491F000C5;
	Thu, 19 Nov 2026 18:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795114683;
	bh=FH4aBNU7q0uVDlwsenmLHhkGzgo/V+aOHVjxXgaFjXw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nv1RT4yOpBQdrqqo6sCMLj4k95TKSvS3SXpTIbGHtj9TDw5fFknEKxCliE8GlIyaL
	 DEgjbcSVIDPLrEQjZSC8B5xDmSC15q/BwPGjrT4zJ6TWsxdzSACcVKuj0LAe6lp8eC
	 6bjTEiIx2JC1G/8wxIeR6FFzMYC7wwBuHktahdrgytBUWXzWU2S2Oq0+V5GH5LMkUh
	 NrOH+FWArkYycJQtMjgCcfekLFw9b/WP+Nmq7F9L/fz6D88BnVYEzaIz5yRxL8sjkJ
	 n+l4wPFbgT6AZnuXExn+U6NizZBU42K/hFjKJ2cGJlA48bImAdoNjldfiYVqdGQMAH
	 cPdoJ4SViSu3w==
Message-ID: <sashiko-outbox-223815@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 11/33] KVM: arm64: Add initial scaffolding for
 Partitioned PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-12-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-12-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 18:58:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add the foundational helpers for Partitioned PMU support in
> arch/arm64/kvm/pmu-direct.c:
> - has_kvm_pmu_partition_support() to check VHE and PMUv3 availability.
> - kvm_pmu_partition_enable() and kvm_pmu_is_partitioned() to track per-VM
>   partitioning state via KVM_ARCH_FLAG_PARTITION_PMU_ENABLED.
> - kvm_pmu_guest_counter_mask() to compute the bitmask of guest-reserved
>   (0..HPMN-1 and PMCCNTR_EL0) hardware counters.
>=20
> Tested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D11

