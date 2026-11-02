Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611367;
	b=erjCUy/MNnIcNnf1vNHIMR+mt7UW/u7zWF+yiExQk44e0rip5Bf+G86TCYS4S2zojFOn
	 AOR3OlwWprzeQnSa53Lro8GyuKZUPO13BsntR3dq0SuQePZsS8qsF2ZCHtv7t8TV0Q0DO
	 BV6v6qoIznbldLAMNDEARUcFVmkzMHsMIKXbgflsQC9qXY0TO5AuJH/fX8p8dMPy9m3qT
	 00fDT1vlRpGinKIqt7jkLph0u0/vXSIzldqHMtOKiv9y15ucL1794REOSM0Bs5u5CUyLC
	 DcarrIoAvwLtGJ9ebYgICCG1tvW8yqCP1M9cHXk47uoNmvbYU+xmt4a4FyuKFEZ9R/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611367;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q8k5RESz1RKUzihpxKMyY5HaMcoalCwq3xOopnnLoPw=;
	b=TiY4lwjurPWlXYvrvxXZBSYdRvHJMdtr1Bx7n2+8xz+uVE2wS4vldyeQDqkpAbnUJH4K
	 TSnU1V5JBZBXJHLcEgOJ09tSWrNoYNhl72udZ09eGkKa/scYbXsfJ/y666TY2dbfCqdpj
	 qs1nT7ESKeZkiD1VEUEkHvgFpT8M3VzR3msHbpGJGh59ECtduaHn5CgVQ0sN1oQ5FmCqQ
	 ChXdNAaDVdahM/IwevGyZTgbHvnpVpmRvRKDDNCRITU/vDrc2BTQnjFuTTg6KBAF4Mbk2
	 o5bFCMveqvJKwF66K2+fbI9uinguBLpdIonxFet7vJ3B0hRC37GL+2M/jZKdFnQoDwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfxPYP01;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1E1606A324
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfxPYP01
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814891F000C1;
	Mon,  2 Nov 2026 09:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793611366;
	bh=Q8k5RESz1RKUzihpxKMyY5HaMcoalCwq3xOopnnLoPw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=VfxPYP01qAt2HayCPEtFi+edzFvGHvfxcv05Uq/+WehvOHbEGtZ/AzK3Wa/9GFeuC
	 e69LAQA4HQXCIHL3UEFmia0U+oGQZ81OZVRAnvGFTB5hT0H7mR3wpCfL+tWpO8Xspd
	 T5NljPr8YmvPOzI6SKmhQxw090Tynbx+cFo42AgONPv4N71ZWcTu2LUf2mGf9cnyrA
	 orpbBuMVdGMKfyIfVtiiPOBptoZFJ16bz/64xDzGEC1x2e3A1yaKxHmepPsxfoIdRN
	 dMHDHhlmyd4iTwhkHAwPmWgVzebEoOlQyqRa4WCMBs3NBmbVtMAaV2mIzANr9+ZiCG
	 +Fm/zkYbxQOJg==
Message-ID: <sashiko-outbox-193167@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf kvm: Fix RISC-V VM-exit duration accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261102091809.2215-1-lirongqing@baidu.com>
References: <20261102091809.2215-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 09:22:46 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Li RongQing <lirongqing@baidu.com>
>=20
> Use kvm_exit as the start event and the following kvm_entry as the
> end event for RISC-V VM-exit statistics. Keep decoding scause from
> the exit sample.
>=20
> Before this change, RISC-V measured guest runtime as VM-exit time.
>=20
> Fixes: da7b1b525e97 ("perf kvm/riscv: Port perf kvm stat to RISC-V")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102091809.2215=
-1-lirongqing@baidu.com?part=3D1

