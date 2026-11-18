Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794973925;
	b=w4aavf7xSsAhLhMXORErd62r2FNNldUcdjn90C9uSftOLQJoij0aJNoiZ887wf/dEZvv
	 mBl5qS6YJLpfBV//ArtFQBQd8fsR5rvsH9sLULwsbu9vLBDakrFPe9WABgWCxxYh9oaTD
	 UMXVLvERF/ilHCbCvaKdG3WAUCj57n1yI1e7wURk6E4taYAw41NUeBEFRsQEv02zX2ntV
	 8wKSz/+EgbsO8+lM4zGdE6wDw8SRbNKmKnHmyUsTTY9XW02kwtoAFTl4Cycyv+pS580Bd
	 canLCnqfMK/S4q+zMcmWj4O1gbIxI7krzzokaROy/E99CEqapKmzGeAoMXO7qRX3FFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794973925;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=StTKJ90Eir9m8UQ4oSjNoJ+4bXnf71p92QiYDKH7dhE=;
	b=JizLG4dTMtTiCjN5hWaOHvExnkblWV3dX0cG0pIvDqXbCsH3CRrcpArjMkefiUauTIDp
	 fuCtzyxsrMoSDFcMHsQqsrn5aqqsjT7YZZSHSrAsCmIBRqF1Ljskal89qD7H57+NmymVG
	 v3IYyKlosfbxuZrpU5KRcmeJ+DjYjctshACX9JlK77ChnRk3PBxC48/+rhriNvML/wrEW
	 uJta7EvGfj8vzBt/OF857cBzXJfWrCCEvri7p/gOhiWTjTzxcJLUMRtCxALX3GhoWCTlJ
	 uBnhZojMgT4nAGnW0MvWtYawLENb5uYwKUhbJw+mCA3nkS3mV3tWoiCbJkEbXb49snQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CUfnQUig;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C79606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 03:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CUfnQUig
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD311F000C4;
	Wed, 18 Nov 2026 03:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794973924;
	bh=StTKJ90Eir9m8UQ4oSjNoJ+4bXnf71p92QiYDKH7dhE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CUfnQUigcWHfCCdynidMicFopTcT+HLfEyLUC7ho66dJuwhtQxVXn3oyJ9DCCZYbn
	 pLTLfFg0/d0W9uV6iA22oT5+5MxLa2ptC3Lh6w6do1+ZFqYvR8ujiEFjeFkAMdWJj0
	 ZEsN+HevrdCJ3Nbac1e3kMf2UKhat6b+Sz0BlDqKZlZLT0m2PtqQ+xuwnUhMF+AgDp
	 y72hNQpSaQB4pLfsbLawJqKmAI5PYAsk4MZ5N0BCBiA+F5fD50duQrRukGE+t8Giq3
	 3pD6VZj1/aYwf6u4RZ5cdExW2AP/ZwXhxbdPT+Z2vivkMcr1CiJ+CE+yWkdLPPvI+5
	 dRPOcZFJMZUNg==
Message-ID: <sashiko-outbox-220054@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 19/24] perf/x86/intel: Drain PEBS buffer for branch
 events with PEBS LBR users
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-20-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-20-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:52:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> If an event needs a branch stack while PEBS LBR users are active, the
> PEBS buffer may get drained before the event's sample is output. The
> drain overwrites the live LBR snapshot read by the PMI handler, so the
> stale PEBS LBR stack is reported to userspace instead.
>=20
> This can happen, for example, when:
> - The event belongs to a SAMPLE_READ group that includes a PEBS event
>   snapshotting the LBR stack, and a later perf_event_overflow() calls
>   perf_output_read_group(), which drains the PEBS buffer via
>   intel_pmu_read_event();
> - The overflow triggers group throttling, disabling a PEBS LBR event and
>   causing intel_pmu_disable_event() to drain the PEBS buffer before the
>   live LBR snapshot is output.
>=20
> Thus, drain the PEBS buffer whenever the overflowed event needs a branch
> stack and PEBS LBR users are active.
>=20
> Fixes: c22497f5838c ("perf/x86/intel: Support adaptive PEBS v4")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D19

