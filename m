Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616243;
	b=gKIRdi0DK8p5HLCi324yV9JtQkhlpTpxMrqhaRqsn/RcgAwuAPTdoB/v2iKHPy+5MY1W
	 0Jzf8TtqU6uC7T2xwQVzxkm3ljMvH1f8gHTGezpijDFo4/H8lfM6ij/h2d7hwf5NpeKhL
	 V7uoi7ZHAyRzvqizfSnb/Ww4wQDsbgZjlhfyW2PxEqHzx6PsWv62vI5RitgscLWGrc+9O
	 vK1WDVCmbCKwjI3oFnx/9EAhndp+Q1nZFIgpwpw9S43Cgg0lggrtJWqftbAIBeFAD9O+v
	 2PEC10rtRzWURaAIq/G3rlPRoM8LE4K0ZRZSZLFlvfrc7fk/IyJpoRmDFbGutFkSmuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616243;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ILjqu4lZT1+kpOMUazlbTV+sjgTz2w82PwQmHm5Yvac=;
	b=Xjl1i1T8+s+ZNBlWP22qTHGoJQ6zYfj/NuGGHvCDm96li37rxejPbaRNQvWRIV/3iHd2
	 xxYaXN8iTg/Gb2rQ4K/vnYBYpRjj/q6i2or6VACTEA3xI/Ro/lqsPLHE4YIrM4QnXl6oH
	 7DysI11gj/FFGQjb/bCxny3HPfwtq6ACeIrzYuHGU5iBGevCfC9N6Q78T+Ei+uv72iRNU
	 R+7iBBKXWQjfbqwstb07KiY1O46Dcd+ou+2LqF5XOy2VSVLU0KM51vYyO8EWwhLSem1lP
	 P4Etocxj8aA9om7M4LKz1++xSf9niodenr+E/rfRdcLjgj9WxawLQMX586GqVBP7nVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xeb7RgU2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3789606A329
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xeb7RgU2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568FA1F000C4;
	Sat, 14 Nov 2026 00:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616243;
	bh=ILjqu4lZT1+kpOMUazlbTV+sjgTz2w82PwQmHm5Yvac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xeb7RgU2NhnwMjTnBnDbydCwYbTVho+XVRpBcLEino9n7ce9fzgIGxrHRwnPSIJyY
	 pZgryc5X7oYv8IzN5nUs9a4VVd5YU76txFvlcTW5sjQv1p8pOtiECqTFiNyUdka/bm
	 cWf/3RCFHL8AQnFoig1Kg7D6cQxF4Uk5SuBt2zZ1J0mwiPCpDgw66/SE6/6azwwCy2
	 zKwzGEMedncMQfFNQtvCJ8WwMXA//e6MPrdu7yHR1g2K2UilRrWmawdFJMUWilmdRk
	 JbtJGAvvlGsjDAg3zZQRkPDO0Cy8meFvWB52Civ6fHdnUHI/JdXYy223aOsGn5sn+W
	 LXGBUc+rJ8Ohw==
Message-ID: <sashiko-outbox-213926@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Run stacktrace_ips raw_tp,
 tp and fentry tests on arm64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrii Nakryiko" <andrii@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261114001846.873499-4-andrii@kernel.org>
References: <20261114001846.873499-1-andrii@kernel.org>
 <20261114001846.873499-4-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 00:30:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The raw_tp, tp and fentry subtests check stacks unwound from
> perf_fetch_caller_regs() regs, which arm64 reported with the caller
> twice until perf_arch_fetch_caller_regs() was fixed. Run them on arm64
> as well, where kernel stacks are always unwound through frame records.
>=20
> Leave the kprobe and fexit subtests x86-only: on arm64, kprobes at
> function entry miss the probed function's caller, and fexit stacks
> have an extra entry for the traced function (kretprobe subtests pass,
> but don't use these regs).
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114001846.8734=
99-1-andrii@kernel.org?part=3D3

