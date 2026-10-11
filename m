Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CC7305660
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Oct 2026 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791750687; cv=none; b=FdWGN9UCjCLbJvsB2pfUK6NobZtiVnGffJXBl7fbxT9rU4CUzmfnFtE+cU0LE2/H2oEczc5muLZl2PvrxfBvgRIpjBN7uI4n25Am8MEx/MciwaUE4y1TEyvmCaLB7rM2UHgJZDP3hj1CT2kC+51z8dYs+aaNb3X22ipC/G74geo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791750687; c=relaxed/simple;
	bh=Q1aG4Rpre20QIeseF4/neokWyOvDMuyxvdoYTIX2V0Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=RO4GgRaFxtm6e73m9p6oCExuyoMSmzDs4tXVnpmz/To5LgcR2lbq6smmu/F8BBKPB/lbfvgri3xiHgVMJqmRznHz/buCFcqn55gnvFGm8V0qI4aOO2COZXtBP8+UxbzhuszD+ZaovTSqmJGOLEsCmqf/S9DxCgOszbkId2ziff4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hP+KJLuX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hP+KJLuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1591F0089B;
	Sun, 11 Oct 2026 20:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791750686;
	bh=Q1aG4Rpre20QIeseF4/neokWyOvDMuyxvdoYTIX2V0Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hP+KJLuX339mb7eqle5lEe3tTTgquuyT6feKWNa9mORxy1MWkSYv+6PeUtNwssaSj
	 FkxEB/1xGlnnMEm1Zlwu2HiHCFYAhulKa98CteHOtFEKd/zIRUJgGstzLRptTx7avz
	 fkbnjceWnRKPZz+ZbzsKPd13+kYh24RXHcsvQfcM2zdhw5abn+rGT4sX2yq1DS8sI5
	 iaw1c37VztAwxYzXW7aTIrfFdK8VE7nxRXD9LRpDuOmDwM3e6fBOwt0UPJI8YHGHSj
	 VcbIzD+dl8hFhwxbj4vRlYS5WooZ5HYnYe5f16Utd6MIc3KG1OIKZ7tL9awWyYmPK0
	 eLS+8tGtQ08NA==
Message-ID: <sashiko-outbox-167453@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] alpha: use user_stack_pointer() in KSTK_ESP() and
 dump_elf_thread()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261011-alpha-perf-regs-v3-v1-3-eaa625a39712@gmail.com>
References: <20261011-alpha-perf-regs-v3-v1-0-eaa625a39712@gmail.com>
 <20261011-alpha-perf-regs-v3-v1-3-eaa625a39712@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 20:31:26 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Both open-code the same PCB lookup.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-alpha-perf=
-regs-v3-v1-0-eaa625a39712@gmail.com?part=3D3

