Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188972;
	b=EcZjoR+tlVKrRvheGYTyS6p8rkqO8PxzvzsyKq5Pqyn42tgprDdrMAGU1Eni5FGwj12q
	 ewHkqzSXqPwUh6UBMPxc/QncyPNP3PXIahllrbS+a+PEPB+Agqhhos+TTOpoVSptsAv2Y
	 or0JYygA8qnf2bGjC6CB2emnsJ+iJX6sWK81/XpMowT0J8GbPGMyGojXWGhJKSOAjYM5B
	 lIQQSuIL5VHcUsJhWQUOpp1PQ53yDiDnmFEPGZJbgncDjuqNk+4z3bB0w+3nE5fr3aDKI
	 RlMH5fLlc0iM0ZjMM6UTAi8nNdDZ3mTQuhGBpA1WrGXwV9tSMqMyJwF9Dk6UjZlQqKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188972;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8nWlyEwoio7sNV6kwcuaEzuq0tQdernx9g2aZeXqk0M=;
	b=3S9EhKA4EAxLw5QD9kb04dirJrugwm9ACqWcvRXDGLjEJJSNHUbskzHcVe5s3qvWmtJv
	 XZ09f7oL/vOIeFYxqEJ+jPxgf0Us2fei3dPZ+OPC9vxzQjoHp8mfYXmD2mKtpYWSpB/ns
	 NscL4jcib5sadmrKkae7i1Aft1PsK0T2Wiv76RK5F3YVXRC5xFj1on6d7f/XsD4VkN5fh
	 qJdN7ak13h+I/ve2tsoq//L06LR40RM8ZypgTD27dn3FzsXtijLMzKVIow/ZHuLJ93HM+
	 YBx/GjdxPhCnr0h0aekx2KC2u4RWlPI4/qG668PFcRUC6J+yeDFqNGxhfO0a4Jwyp/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vt5QEyM6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B1E606A32A
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vt5QEyM6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7521F000C6;
	Fri, 20 Nov 2026 15:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795188971;
	bh=8nWlyEwoio7sNV6kwcuaEzuq0tQdernx9g2aZeXqk0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vt5QEyM64b4kh6WuhQcWVK+sBO3Cvp7aZUPlErOYDFdD6bBkzJXV2XSASoJwl1T8R
	 SA3l9PoHaGQHmP1s4q2qkAVvh2wpBc0xeB97W0bMCFtS1AvQAXe4dQpaP3XZ2oCGYq
	 mQ7MJ+omr5jyQV1v3LEJsTIP1oVI6e/TM3zlcNh1ZFPtJDJWcEom11xpZbgZ0iXFZ6
	 rSmaDZBUYw3TXQSQZW7Uiymx7rvCnBVdsemXtKIUUnVdRK+9w1lifQ6c/35JNDsm4H
	 OMsguhVN3xTtiXrod/5zdUykTwjtlY7TnlomXZcdNI5PRm0InG6/RNflxJl/IEVMPd
	 e0sykt1RtHJcg==
Message-ID: <sashiko-outbox-225472@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/7] coresight: syscfg: Fail to enable a
 configuration not loaded on the device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <699bb518b0f92c57227d4c73e21c58d8aadcc5a2.1795182850.git.aaupov@fb.com>
References: <cover.1795182850.git.aaupov@fb.com>
 <699bb518b0f92c57227d4c73e21c58d8aadcc5a2.1795182850.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 15:36:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] coresight: syscfg: cscfg_csdev_enable_active_config() rejects
  unmatched csdev
--

commit 963b92e15bb563c4e0e56506b797ad0f0117ff05
Author: Amir Ayupov <aaupov@fb.com>

coresight: syscfg: Fail to enable a configuration not loaded on the device

This commit makes cscfg_csdev_enable_active_config() return -EINVAL when
the active configuration is not loaded on the target CoreSight device.

> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwt=
racing/coresight/coresight-syscfg.c
> index 2bfdd7b45e49c..a816c22c87bc8 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> @@ -1088,36 +1088,39 @@ int cscfg_csdev_enable_active_config(struct cores=
ight_device *csdev,
>  	raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
> =20
>  	/*
> -	 * If found, attempt to enable
> +	 * The configuration is active but not loaded on this device, because
> +	 * none of its features match the device. Fail rather than trace
> +	 * without it.
>  	 */
> -	if (config_csdev_active) {
> +	if (!config_csdev_active)
> +		return -EINVAL;

[Severity: High]
As reported by Mike Leach on v2 [1], should
cscfg_csdev_enable_active_config() fail when a configuration is not loaded
on csdev?

cscfg_csdev_enable_active_config() is a generic helper across CoreSight
device classes, and its kernel-doc states that it enables the configuration
only if supported on the device:

drivers/hwtracing/coresight/coresight-syscfg.c:
/**
 * cscfg_csdev_enable_active_config - Enable matching active configuration =
for device.
 *
 * Enables the configuration selected by @cfg_hash if the configuration is =
supported
 * on the device and has been activated.

For perf sessions, etm_setup_aux() activates cfg_hash globally and builds
paths for every CPU in event_data->mask without filtering out ETM sources
that do not have the configuration loaded.  Returning -EINVAL here causes
etm_setup_aux() to succeed even if some or all CPUs lack the configuration,
only for etm_event_start() -> coresight_enable_source() -> etm4_enable_perf=
()
to fail at schedule-in time and stop the event with PERF_HES_STOPPED.

Incompatible ETM sources should instead be filtered out of event_data->mask
during etm_setup_aux().

[1] https://lore.kernel.org/r/DB9PR08MB64756F200065042673030C848C722@DB9PR0=
8MB6475.eurprd08.prod.outlook.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795182850.gi=
t.aaupov@fb.com?part=3D2
