Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232625;
	b=Umozocw+Bsh86JMsN0IDnKJMCatxzOnjcwQTSShqHy5gQUHpZ5lBTsB7TxhJsO7tYWaE
	 DPzvsSPk7K+diqvhFX/OXEsKNCinuIa+UoYVHcF07lKEbf4osvP41elxMKPfR5LQEkP0D
	 h8PmDS9OISvix3GNFE3JsFjaRfLfjsyYkCuAmfqDLRK15h6R8WkXNgxeqQYzbT6Zl60Oc
	 UIu//MH40BjnpV3rrmdJp9LlF8EuPVfRpS3tbBr9CU1c5zOggU8tgmu1N9TTEfKuhFk3j
	 TGyQY8LkUtkrnOdOLPxUXPyjDLRNtpuIEH8ce+tZ9AwDYNxod8T7I4ZHeRywSai8U0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232625;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S2G+DSPYLFOn55xqv3gA8EmdNOpqxA15xP8usem+OBw=;
	b=hvgYN68o36kDU6tD0zGRy/t+UwlYu0hAcA2uQaFAu0kdSTYPhm778d8MTPa5kXSLDhOp
	 QTAOkf6D/vKNsfczvvsFj6G0dSVS2L/bCOVCMd5Y0bd5PVdXBwb/n43yCiqeb2nBAbG1Q
	 oP+keI3kfpqqXvh7zW5yEXCoSV1oo6hsl2oPyRUIpopnFHepghYPr/IWe5bbK9Jv16XoB
	 /T97gc/CcwzqRO8n9nv+8v1XaJtpO9Fev3V7IZs3CBb2TUX14Aq/hGG6fkPoDXiI8YFii
	 ouG8hKpq6agx59wkRDaqSWmtxfSw947p1tu9JwnsSYx6SYguk863OxR5SWSjcecbSzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M3CRXJ3Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0BF606A322
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M3CRXJ3Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0A81F008A1;
	Mon,  9 Nov 2026 13:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794232624;
	bh=S2G+DSPYLFOn55xqv3gA8EmdNOpqxA15xP8usem+OBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M3CRXJ3YtM35o7tXQgtSfokzsCYhPpgZz1bj7Fsyr2hYdrbV1af91BJqgQOP6BTS4
	 hdxOk4Su7tMcclTyb2nnKXApnktBuoNWu4vdPfWx8qfOrFnfoIEoeMcArVtGF2a+bU
	 fYciWlgr+i/7m0PH8K86qC6P6/EUO8CumpgqhaZKCOg9WdT1lGDTnXz58tdHb1f4Nq
	 NGBtmxlZ3veEURNbp7vmKzSobdcFquyDJrjcq3C1IKm/brCzYysHl7IeZbOyBJ3MyK
	 t2pRW11qsu4XzaIS2FG1R36mDpw5S3Q/UER5R3KJu8oY41EVhkMgQMxl2aXQZ3CX/3
	 vYExMmjj8HDRw==
Message-ID: <sashiko-outbox-205044@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] perf test: Don't starve per-process tests with
 system-wide events
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109-james-perf-test-fixes-v4-4-355ee6b81917@linaro.org>
References: <20261109-james-perf-test-fixes-v4-0-355ee6b81917@linaro.org>
 <20261109-james-perf-test-fixes-v4-4-355ee6b81917@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 13:57:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Some tests intermittently fail when run in parallel, for example "Check
> branch stack sampling" fails with no branches recorded at all.
>=20
> The default event is cycles:P which there may only be 1 or 2 HW counters
> for on Intel because it's precise. System wide or per-core precise
> events hog the HW counter leaving other per-process tests with no
> samples. Rather than make all the tests that use default record commands
> run serially, just make the system wide ones use a software event which
> has the greatest possible compatibility. They don't need precise
> sampling or HW counters anyway. The per-process tests can be left alone
> as their events/processes never run concurrently on any one core.
>=20
> The LBR filter is another resource shared by all events on a CPU, and
> the system-wide LBR test uses different filters to the per-process
> branch stack test, so mark the LBR test as exclusive.
> [ ... ]
>   ...
>   ---- end(-1) ----
>   138: Check branch stack sampling : FAILED!
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-james-perf=
-test-fixes-v4-0-355ee6b81917@linaro.org?part=3D4

