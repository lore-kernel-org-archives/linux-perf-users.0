Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C6F481672
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Sep 2026 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281155; cv=none; b=CfGhcRDufeF6KDCwwYdzZGVmFNrM5x8+9AXDD9F5kIf5ZLk45ML1IAThKzUbYm5ZC2z+7UL5Um2/3XxsdzYUWRSN1Krx8xXM6QiMgPGRV0aNKNqNB+uxrGc4A4iXa71/fBw/cwkiCBSUOIKFIP62xg6YU1eFVtPQKGTBCpiaePM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281155; c=relaxed/simple;
	bh=4c7N+siU2+6eZ8Sw4p5AUx46EW4dwAB47KFcJr8ff8U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rvl2PzycugBHRDwN5b1lZErFr2lAisaJPXPde/2o3cAbTDYKCRRDpGxvMkTExp/Rg9KUSt3hrpdDA7IbTF5BBOuQwvhPw8ipbZSq25SYamA2LCCfKynWn8aVMYpbtMgq3rdXdvomZjqkccJf/6iDDQhnTYbrplI2RlhSn/11EyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRuseRJj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRuseRJj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BB41F00A3A;
	Tue,  1 Sep 2026 16:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788281154;
	bh=4c7N+siU2+6eZ8Sw4p5AUx46EW4dwAB47KFcJr8ff8U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TRuseRJjYvP5MYMry5QwTonqJRNCC4Mnh0xxred0uUmOO9/vLSiWOcrBBhevawqFU
	 dHRYnM95T0pIw3Nsd9d4qBmZZcNZguWsonymIC4FvVdMandDW5jsgljCknUF62YnHt
	 30TkONh+IcAXuZjK4PFn+3leamHa9wAD2uefwVJJXhseWZlekwvVbGuxmJukks/T51
	 fOaqR1TREV2hEdAWZVpOb3tWGlMQS2eQTFw5uWrPgTzTbLbw35rwH+Fa0JdXdgMR0a
	 3Kyh0CZ9+EsVq0JRGZ66YjK3ODRTZWON6ttijyU5wjv/U06EzigNDt2iVIzMwFEL8f
	 ifEYUk3tLLHiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] coresight: perf: Suppress ITRACE start records
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260901-perf_suppress_itrace_start_records-v1-3-c4fbc6860859@arm.com>
References: <20260901-perf_suppress_itrace_start_records-v1-0-c4fbc6860859@arm.com>
 <20260901-perf_suppress_itrace_start_records-v1-3-c4fbc6860859@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:45:53 +0000
Message-Id: <20260901164554.38BB41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> PERF_RECORD_ITRACE_START establishes the initial thread context at the
> beginning of a trace. Afterwards, decoders track the thread context using
> context packets.
>=20
> Call perf_event_itrace_started() after successfully starting the event
> to prevent perf core from emitting redundant PERF_RECORD_ITRACE_START
> records when the event is scheduled in again.
>=20
> When per-thread mode traces multiple child threads, tooling should
> enable context ID tracing instead to identify each thread.
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-perf_suppr=
ess_itrace_start_records-v1-0-c4fbc6860859@arm.com?part=3D3

