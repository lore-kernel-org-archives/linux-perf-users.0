Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794973603;
	b=Ev69r1g58cv2P2eoIhzzpfn9qln6EpN+qUghBH5SzqEMlf7gBTxgSD++g0bTpRwa4QeU
	 Vb+3nhuKM6VA/MSIhVamqExRfhTf+qGkXt58sLUO7VpfYm+eIE9/r2CtyhwCDg2M+JVE4
	 GoL1Tfk37NM9Co2otegwsypS62n8JDGo06xdh1U0XvBHmtP4vCrtKs/rXewctDQpcuMmJ
	 MMBlnzYxU+kf+XfDwcAvFfjT5k0pAf02wiWLG+wnKFtdTWY1YPdYa355c9gIzu/kOMCud
	 XAzKwgBdmNks/dyzzkaRuT5PTCxx/E26WNaMVSfXg3U4igk6WV2yAfCzoRrld718cTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794973603;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6m2ReqDc88PdJu7aa1iq3EUrG/vqMgodPh/i0szFg4w=;
	b=K5MisPgKUKBUg/7SHiEutoOfMgCeYdSpqNeb4wsWT/4kLmaS2d8I+lS1qmAVGJONvpFF
	 kuCCxOQeYaVyn0k6NLmJBrmNJhu5v5xTwdqDaMsdE7D/L/Xm11txeoZRJM1u9+Rw1PZSH
	 G2D2GOt4UKEzdUUhrONlCekVCkrb71rvYlbag18ijFrbNG0+qlKKZp74iCLe91c3j1kQp
	 DH8HQlWxnaHAzQvWy/4wvhowmo80iVIukJ5s3Yug+do12TMvsmRfurkpB0tcOchPcms2R
	 zNtZPPsExbxR/CXfboSWcqUWvw0ncuASRDxfqDR1v8EafDQbtVuAfv+wjo7TakfdoIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QzmjpZ74;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FF9606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 03:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QzmjpZ74
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768A01F000C4;
	Wed, 18 Nov 2026 03:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794973603;
	bh=6m2ReqDc88PdJu7aa1iq3EUrG/vqMgodPh/i0szFg4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QzmjpZ74UxUoLZ3cJpbtRF3G9daek6rJz2xi1kbKMvOvN20yF5E+glSo1at1nOzlf
	 k1uX/YODAM55e4siRHaEIiKgKg4c7KiOXXam+aZUVaj1FB7gPN2ZGDYHw9Dm8TGHvx
	 PJkLM1oU2CxKAPvbaVvKmr8wLaBhMd6B/kLEz28X57NlqKGxB2IrCt81cCzvRNq4N1
	 V82+JYDYN4KziVukzgrMcz1hmLaF6RxW/e+BLaYn/IcTjekYPQZxuOigIBzsimjQ7t
	 BlZPkyIxdTeWsQMB0E5aWeg2mFnS5KrRC59lzcX1Owte/QAGZIZP7O2dNpc/LPj7ZP
	 ti818SQP2+oog==
Message-ID: <sashiko-outbox-220043@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 22/24] perf/x86/intel: Pass LBR stack size into
 intel_pmu_store_lbr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-23-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-23-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:46:43 +0000
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
> Fixes: d21954c8a0ff ("perf/x86/intel: Process arch-PEBS records or record=
 fragments")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D22

