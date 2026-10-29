Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249589;
	b=pTrk+702FihDX9aHSi4hwSSR3jELWkkiEHpElJdnH7N6lSKmghRakVzyeWIOg5j2679W
	 szlZqcpqxd8ku8OAO5yzGgwDknPMGc9ZsJnNqA9/Ldfw8QvJ5oHfWVF7LPgxMdfVxUEhN
	 2UHCFsZHiulonK42Yxnevg4a/MEOHQo/1+/4vCc1eMYz5+vNilDiIAcW7aX5AlsA8l8tj
	 x3/3hMT51T9zEgc6WtccWf1wU9918dZgOOxQshWKPwLDkylL/wJBLGfFwpqIsXuj7iAwG
	 fawGMqqpZyls/tY2+UULbsqOXT+dR+kZcJ+K+PmJgQbcb3n8GFE3//DfjfMPbuhCrKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249589;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WM50RP1x/1+e79YiOYi9aMeUH8AVcil24Nyaxntpovg=;
	b=r6Nc8yuAhURlRCHhsqwuSJmnU6rB1ZQoNP9qTcL8rn60O03OVwKUySTTAEG4sL1/Sdgo
	 8134Y4ouOu5HVEHx/lSZqdXV25f5B+zGRQDbceG6PJ6e/OdRVGVOaXJlAP/lqW6CAwauX
	 vjVfw42+3Qo5wyyKoQzamZsD5J+PiHIeDDktSTzOZqkvSGFPAX5e015Eg8oP8bfMvt/Dd
	 WQe5I1+MQs2MlqxPldY+yx3jsWJZ10OqJX2owOlrrUoVfPVMEOjsZGlKquENfzIAQI5iD
	 tefwM4DCaYJ2jrlBl7q7IQlLY0aRYWCAFSrz1396OlrXollmzq9Yzc6hJaVp3Hqq0kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EDli3gtC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8FF606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 04:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EDli3gtC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E070E1F01825;
	Thu, 29 Oct 2026 04:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793249589;
	bh=WM50RP1x/1+e79YiOYi9aMeUH8AVcil24Nyaxntpovg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EDli3gtCExrUi9wMhPzyTgwyU9QwFapKS/VJnm6EB504fcxIlYvHrZmodRenqmgLq
	 mWkx6jUXmWwQIbzfqD2O9AaI+Mf+7dspnmPCmbDYH7ESsnpWzFoP02nxxIycq+cY7W
	 rqAJycGMVbeFo5aVHbYbGcHIs6MNwpWs733z9hMC0wtGwffETvRy6Qu+J3P4wsfCaT
	 Qefp2fFfBD3wS/FPsok138fvDe1Dm8FW7DnU2JRqE8MtH+Ackx6y/Cr2jWvpIz1RFh
	 3Slq62wmbjHJnQFzzd6zN1isSxBAWU/U8yNZTAxpA51xTH1cA1WYhgDunbQlSrTQou
	 4b1ho2Ilt0Yrw==
Message-ID: <sashiko-outbox-188713@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v5 17/18] perf/x86/intel: Pass LBR stack size into
 store_lbr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029043914.1395147-18-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-18-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 04:53:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> intel_pmu_store_lbr() assumes the LBR stack always contains
> x86_pmu.lbr_nr entries, but arch-PEBS can use a smaller configured depth.
> This can result in out-of-bounds reads when the stack is shallower than
> the hardware maximum.
>=20
> Add a lbr_nr parameter to the helper so the code only processes the
> available entries and avoids overrunning the LBR buffer.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: d21954c8a0ff ("perf/x86/intel: Process arch-PEBS records or record=
 fragments")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029043914.1395=
147-1-dapeng1.mi@linux.intel.com?part=3D17

