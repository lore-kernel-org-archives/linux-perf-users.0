Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941989;
	b=C+DWiBVufXsN+P948ZPtx9Xv3GxkcyE1g0EMj6rq2qhBE1syCbJD9Jag38s2C3qS/ZHz
	 gRcXnV3HQ2kLZ+eg5+53wsHaTMgq7S5+hiyH4l6fzLLH0EVimPNGP7TqMgUz1IEoJ7khW
	 TMHXsxHL+fyjD0TEBtTk0WV/m1nZKSkMOvhO06YqLbq5edoG/e+PqCtXYp3U2BpjeVgr0
	 dqMCdeKflJ3uuS7XASLx4ium/A0WvvLcZmxEfCesYskQtVs6OPsw+kG6o1IaD8GSzhocX
	 c91OoF7pXd0TnlTJ/JG80gjJsT/YT0Ytjqvyypkp7WOMCjHWlWzndYmnmCnAHCsONUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941989;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0TPB53YkmS0jjXHwGWd+CbOxoBLKbt/lKIM4hyuPTbA=;
	b=q6CGdgXTwoQt7i/QTswOhj6J0/jtOaipRGTiBHs/N9Lr9WC8gmmYTAOtk7HNmoeRUZPa
	 LFys4CN7uAz5tQ5ELGKeul+4BBP7HLc5DMwztQAU8cpUYHbvMSentxVO0eKLue9qQ5JB2
	 M/ammJxOlvNpqe2K3bnFl9pGBHnMIpIA3NlxGKNIuqgJN9znWN2HMdKXBSGIWxsp2A6eX
	 OTaKhm28rrVK4846RfgpsJUp9rJFvURqtbfmKHM0AqVpm+LksICWt6sokROmtERTK6tbt
	 YKywpcLIHZRj8LkP9qCPwF2c7v5FSMfokJX8XTdQY6hMWgJHfl9zcn77cpyyl4mSC8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ftMsUZjs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33540606A31B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ftMsUZjs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7091F0089F;
	Fri,  6 Nov 2026 05:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793941988;
	bh=0TPB53YkmS0jjXHwGWd+CbOxoBLKbt/lKIM4hyuPTbA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ftMsUZjs90F7X7TdmV+Mo8XsLyKb+OBPECGC/A6mPgjV9oraTvwyyzHbqV7ni2GCA
	 q8csNHyeKjzxFuPrWoPVbRPUGxGp/LrVo0+f26YAbks3SQ2InYrP5SMLqpywGy7xTi
	 C1Gm+nbcNdkF8o6wXIzAjg++KCbOQYASk63Ju/CPs1u9YneQ4vKzWw8LXr/uOg91e2
	 Rnvfnb72jz7bi0U2vgl2POA8TcPRb6Z1P1RfrG39RXHkUgUx06WaUEbJEEX5SySdqf
	 ZPB2wRRRio/KsTG3BXt8eu6nSEIQf2+mtvWGlv8hucThI+/hl9C8e51aZYAHsbPRwd
	 I+/SDaHptlt/g==
Message-ID: <sashiko-outbox-200803@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v6 13/20] perf/x86/intel: Always snapshot live hardware
 LBR state for BPF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106043257.842864-14-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-14-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:13:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> __intel_pmu_snapshot_branch_stack() is intended to capture the current
> live hardware LBR state for the BPF path. However, that snapshot is
> currently skipped when all LBR users are PEBS events.
>=20
> BPF LBR snapshotting now uses its own dedicated LBR stack, so there is
> no longer a risk of clobbering the shared default LBR stack. As a
> result, always snapshot the live hardware LBR state for the BPF path.
>=20
> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106043257.8428=
64-1-dapeng1.mi@linux.intel.com?part=3D13

