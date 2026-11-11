Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426285;
	b=oSWgiacAQk/mj8h8bNwis+HbQ3QfRAMndhto4FBgsfzmn//rU2X7PF/nHXD+1MekjKvg
	 Rm5leZdNecSsUSBpjZgQ04XjC53tGUvSF9hYSsWAcs6aw8YK3tBggNy6i5wZIS0ZYT8Id
	 ekIqtRV+oHxjWlJKpxeRGuoN8sHTDELtbsDU6UvkuRkiDwtfgvu/YyfCZQvT41oW/9axU
	 hyrvxtsH5jUDugEffzkH2wIMcu3xsxGXVRqHqeu9jgVH3Qj7wfTEmztH60A6VVpdukpfX
	 ay6JJmhHC9HvhIr+pzq6/kfUpSJB/KdAc0p6BJ9plHUhZ8Zd2TkQ33X5D51HiXubmHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426285;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QPmFxekiy810C57SBFGidBzxHDcFrFqkMZWYJ3zE0F8=;
	b=v/TllHb4M6hzOpZC38VYv1CyLEgnYjfNIQdznBMMdwVWPIQQfLDs5jumVVDHc/ys5QIP
	 S3Y+pKkL0IaJKO1YDsJ24Rf9WZjCBlrXRg178nPlY2hCKhSeIRKJ845TPwVnse0KBwdix
	 OdLuZfvxMJArN76FVdFg4eW+b/wxkiDsjift1D97Cz7CVcaJnrg/PbNOGIFq6AVS8f4G8
	 c7APr0RUiD7hdxBTTqjoAyVxwo+81fbIOy6nyKXG+DAiRyyECdPQbPN9UMdM2y04eJT90
	 WVdHfU/UAf+kVjZGKtMVZ4oI04/j7b8HMJJtFNpASyqw3F8StYnbLXgrpyPOA3t5T/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0WegfNA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C24606A8AA
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0WegfNA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833421F00AD6;
	Wed, 11 Nov 2026 19:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426285;
	bh=QPmFxekiy810C57SBFGidBzxHDcFrFqkMZWYJ3zE0F8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M0WegfNAu4bVlvz532sgMC9XqPIvbP2q36q/pf/GBtxZBt1iUr2iy+1ylHVOtKT3e
	 SHPFIHMqr66gIbjNXbGlSPY2TdMNubBQNKSF50qp9WBINVrQZP/CfFWxOSgY3phdYY
	 WktCUIsxoP/G3hM1X7Nzl+sNpIUj7JLOjJ4Xsmq+rVnzc1tlu6o2v3LnLDYdEzyX8p
	 tMgVQVDSOnX9IMGCpHoFtZ15Khrn4TAw4nDpgcD1O4W71RlQQr4E/9gLy3Pin8MAVO
	 pgdBO3w92eFY/TSV5/EZq7EMIyErPInpd/Hf7HgPTF3hAof2+L2tyQ4YB/RNmnMuyr
	 e0wEmKqNtLBuQ==
Message-ID: <sashiko-outbox-209590@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 07/20] perf vdso: Fix unlocked __dsos__add() and
 race in __machine__addnew_vdso()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111174213.3526604-8-irogers@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:44:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> __machine__addnew_vdso() called __dsos__add(&machine->dsos, dso) without
> holding machine->dsos.lock, and machine__findnew_vdso() and
> __machine__findnew_compat() initialized machine->vdso_info and created
> temporary VDSO files without synchronization. Acquire
> machine->dsos.lock in write mode across machine->vdso_info
> initialization, duplicate checking via __dsos__find(), temporary file
> creation, dso__set_long_name(), and __dsos__add().
>=20
> Fixes: f649ed80f3ca ("perf dsos: Tidy reference counting and locking")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111174213.3526=
604-1-irogers@google.com?part=3D7

