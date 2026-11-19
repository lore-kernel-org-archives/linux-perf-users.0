Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115074;
	b=m8r7zDkquH2fNH0HeSzEU978Hfg1hzOE2wNl6yymGzfdKXCAIocFtSfEei/nD316biot
	 dUUBYW2o+ZzQ6X6wZtAnA9N/q10rNNZyaJ1Mw43i4m4RdubZwrzyofuAmaUKsohB8Ycb7
	 Dl3qk2my8k9Yy+lOxsGt6ZSI2L+CwRzK1cms6HxAUY2zmntzWmlkTBeVpJ/Q2pi9Bwbnv
	 yFw2gjqWDklO3F+by4OPzPkD+7W+dgHxEuj6iSPW9tGmXKelelApqw7W4PVk6PW53srcg
	 9gK3wLlso7phlchNa+25cVj7V7BPgSgRuxSJSIe42lV51QwcX9UZ4K9S+fdKFJ4rHYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115074;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Sl/FhyoebQ2OZ2t1K1u3k1u0jmSBeN6ihBUZntpRJq4=;
	b=QK0RkTOJOOv+ADacdtyckd7VJ1gw7IqfBd8N9UfF3rbpUUCujpZdVEpk42F9vTdRHlAC
	 qhYIlkCXikXJW6LdcSI7yq98d4a4Ag9DFhVbChidcMMtlb/hHF/u+aRLYaT9VeW1IWCiJ
	 tYk9Vkfm57lmd6IqrbErF894eer46XZN6UQXhSQBk0QxUpHM8tLd6iWywxZJKDZNETaFU
	 7CQePvkkB1vVm1TGYhhj5wm5uekt7ftfqH43xLzv1rw0UP66ek9VXkzR/UIHoMecJAmrf
	 Cd5umIu0TYAKMk9Uzr6zY046dgY3T6/XxZDp9icDN4eHU5xJaPMml75Qy5xvYBdJQzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GYBiIR7V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C060A2630
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GYBiIR7V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A271F000C8;
	Thu, 19 Nov 2026 19:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795115073;
	bh=Sl/FhyoebQ2OZ2t1K1u3k1u0jmSBeN6ihBUZntpRJq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GYBiIR7VSFfVeIY1aVBiAT+7Gan+Qj7zBJh0LnC22VswSCkDLko54b+EFuexTOGtw
	 cQO1G7Y2qr/dHYfb77rWKSIgCcV4AGo3UukJ+l91eYP+0TRx5Pb2G3NiunJO2pV1XJ
	 8r7h6MR6B/XxxJe4P52eUqh+Q2nCrL24AYquF+brW4b5KoCucVYYtEiXEdk2d79b+E
	 pUEn8aEKiEK/wubR7GCBv3zoej9CGJ0I8c1cu/cLBCKlzcPFgyMHhYTILuBHEPDIOj
	 h16WZ0FLanSlzlIJ8n3t7ik4a7BU9EIGUsgAp0OqNVmxUP5mgiZ1kebfDfzAYVrIpP
	 6dHIFDlEvfAXg==
Message-ID: <sashiko-outbox-223828@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 07/33] perf: arm_pmuv3: Move counter allocation mask
 to per-CPU struct pmu_hw_events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-8-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-8-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:04:33 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In preparation for dynamic per-CPU PMU counter reservations when running
> KVM guests with a partitioned PMU, move the counter allocation mask from
> the global struct arm_pmu to per-CPU struct pmu_hw_events.
>=20
> Initialize cpuc->cntr_mask from the static cpu_pmu->cntr_mask during PMU
> probe and CPU hotplug startup, and update event counter allocation
> helpers (armv8pmu_get_single_idx(), armv8pmu_get_chain_idx(), and
> armv8pmu_get_event_idx()) to query the per-CPU mask.
>=20
> Tested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D7

