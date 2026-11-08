Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794144487;
	b=oZeKk2Ml8XU3a39bOaige7q1VfqjLF/2oiERgzRyjYRYkTB9j0VKEDk9Fz+7KcmZgdba
	 GovMQoac3IpMNTLMV33UJMqJyo+MQnmvunVi79+7bgfKUv76kiI/QdjxJnxEiC4B6o4Pk
	 fB/4Kn084kXTG8wqCoGPou0mdaZ5u0ZRHz6hYKneeRxNe+jLm4Res9ZI6JxHJoicjJ3mV
	 IK4khvWLZZiN+dzFi2jBhApbVjHDzlUIFcp8Jy1i2l25JAzKoGBdCUzRp9Ug2Astc1JZ7
	 292MyXiNYXDdqADMtyAF/vdtINemMgzrtIMRGbGiz2rZgwV432R1imPtu2sC+v7hBgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794144487;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=95D60lJwPPRh7oesSbozYjICYxOXZWglGzgEdDruuZQ=;
	b=1EfCtAKJBvJ6+XGB2NTsl2ipMuPFhYIQUZACIepDphoEci+M85CxEW6VJgrgBLHYUWLw
	 j3wAMj3NjGLPFJF2wVK4xBcJARrYiKdaTB21zCpxbSdGj+6G9a+CG1w0yzR/1tdyCdZXN
	 zrgfvPBSz6BTvAzU25SlkoKSpAk04FLIpV5bk3xBUZuKLusO8luBvy4pmi/Ii5lfSuddi
	 7B29XJ6DgVoH48SN+ab0XQa5VAZnK8+WIPmTo8NSTrqX9s+RL89hnbR7RgupEII7uvt58
	 ajW5wQCAeASWniiazB36AnilZJjo6sU2R7W31lpa0eJVPfm7XnzPIArogYzcVlV5KEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ihFwRZ/I";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6F1606A31C
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Nov 2026 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ihFwRZ/I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B5A1F0089F;
	Sun,  8 Nov 2026 13:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794144486;
	bh=95D60lJwPPRh7oesSbozYjICYxOXZWglGzgEdDruuZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ihFwRZ/IS9y0UP/khMVDc6VCmouQfYaG3qiL5htQn+W71a0ZEYuF4Z77A0cvAKKbk
	 t3PPQj8weZiRRUCKW6trvrf+ipYKzTufbZGI7VKbhoOCYLhwOA5da28KlBsl8Ppa1k
	 qSXYnisphDLjKSbeRIxV85VUuIrxncTkKVahKCp8qHRvI5lPf2IA3CDvAXLN7JfJEP
	 L39SRNF7bba4SS916ddjeLCpk/+7fdrF0AJRAEq6Yz3GNq9Z/eE8bn6Ebsp3SrO556
	 F/YJ2JYMIvTmKZ6+TdPWmRQDP2o1hplZZ1ZoWmCuSaQj/4tWhaJryM+4vIQ/tvrxgS
	 k1UNHJHMWiQ6w==
Message-ID: <sashiko-outbox-203779@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] MIPS: CM: export the symbols needed to access the
 GCRs from a module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261108-i6500-cm3-pmu-v1-2-bd119584891a@mobileye.com>
References: <20261108-i6500-cm3-pmu-v1-0-bd119584891a@mobileye.com>
 <20261108-i6500-cm3-pmu-v1-2-bd119584891a@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 13:28:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Allow modules to use the GCR and CPC accessors from asm/mips-cm.h and
> asm/mips-cpc.h:
>=20
> - mips_gcr_base and mips_cpc_base are the mapped register blocks;
> - the CPS_ACCESSOR macros consult mips_cm_is64 on every 64-bit register
>   access;
> - mips_cm_lock_other() / mips_cm_unlock_other() are the only way to
>   reach the registers of another cluster through the redirect block.
>=20
> This is a prerequisite for building the CM3 PMU driver as a module.
>=20
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-i6500-cm3-=
pmu-v1-0-bd119584891a@mobileye.com?part=3D2

