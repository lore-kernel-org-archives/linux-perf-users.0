Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738462;
	b=NZRDtkRbOKf9m1KG8GK7gbjdqGWQTWoDHF63HoLJcLG57gmFIQrzoS8nB9oUQCZzZXLE
	 9bsk5SBPZ7lCBKY7WgsYuH5Xzw4faV+NNMfV0K6hGhEC47fwbeFWR6ZwxwJMVlsctWpql
	 SOMGcmjzveO9+YaRLSYVNlEPOLPyaV9ugksgI8TvP5UP9nU6PhZyFiGINch+tKdLJMhVd
	 OGY+pG7TW/tiLYYS9zVcWWG7FhZzE6kMKrfyFhPGT5j3do6TbaJiT6qMTa4woANPx5+L9
	 ZMzcgMekdK3ogzdUfEQ+FV90TgUrJp2bI0PiikXY93LKqMiCqJwmM9/EUPgrRGnihvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738462;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1+eg770RunJC626vc9BCfUu+9Stm8chxjbBFkqeDEEE=;
	b=Iwuzr5zNslhXARQT+0DOKSnUeQ4nD3I4KaqLHqiTfCDTnTQ1VEP764+CAlVmWfDHRJSD
	 y0ZUX/1amUBmox953bE2FYzuCa2CkaOicv5hWG+PjA8t0gIUsrUbu6AZORe41Zh6aec0C
	 FVhysHkk5N0XpTN7RxwneV7roOuZRzaOTcf9sL1XIgHWLe6c8pAr3emIHBJDJneNbB7qo
	 UWDWKo16oEB++ibJ6byqk+bvMzQQFfApWaCbqLB9xA9djd1sMjza6iZortKMSt9LPEor9
	 ls6kegSuKthgjUo/irAaJZPwAr9Ice6J6cDWR9NV0WozmoorSDy9HFAvqLDc5dz5awA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mrPpPXcL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC74606A31B
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mrPpPXcL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05BA1F000C1;
	Tue,  3 Nov 2026 20:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793738462;
	bh=1+eg770RunJC626vc9BCfUu+9Stm8chxjbBFkqeDEEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mrPpPXcLmIS/QbVY+gBaf3kNh7uzA169V8tFDbQ4snieKol4vuq13Qjop67YGCWPu
	 SbvFkfIE+lQB+6Zs/ogei1N4aIejxiPo2OXmbwA9W08AFz3Flkp72B17Yi8y8yeJS3
	 EV25zWVzdCZGHxm0qXsc+VvyLa7rG3PRuFhp5Fqb8AovESp1vG3MuV7/JMk/9W/X97
	 fqvaYLqUUININcpguilXtKT/DLN68rAvAc/bLIzs9KSyxs0MLEBauT6L+dCJul3Xzw
	 WizANWZZtFj67s2cQNpBaUt+DoMNcQCOxlin/wY/E+22Y6WBRQ6t2X54jtfEAAxGA7
	 p6xIRZ6rlBAjQ==
Message-ID: <sashiko-outbox-196001@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/11] alpha/perf: add sysfs format and event
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103-alpha-profileme-v5-2-bbe3937fbf3a@gmail.com>
References: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
 <20261103-alpha-profileme-v5-2-bbe3937fbf3a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 20:40:58 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The Alpha PMU registers with no attribute groups, so the perf tool has no
> way to learn the raw config layout, and the PMU's own events can only be
> named as raw hex numbers.
>=20
> Describe the event field in format/event and export aliases for the four
> EV67 event types. mbox-replay has no generic hardware event, and can now
> be named as cpu/mbox-replay/.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-alpha-prof=
ileme-v5-0-bbe3937fbf3a@gmail.com?part=3D2

