Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019742;
	b=YonSXQHWs9tcnM8VL/p3QJ3DWSi8+KNHDi1502s7HTITvE2Wmpl+ZjO01tSFBzaCYOYE
	 jhqCPl0PvzLANJU0A/sCO9c4c66E1Y99aacubD0PC0Uc7CfIW4CKAoxXnYmPbMBmL//Mm
	 X9XyXGJgV0GOJvDVQQcoLo7W+RHP62f8Rf/475uDomSsuRFJGsrtmcaPdNQjE7my5IaoZ
	 0wvmHAloMsGC7buvk6bz2HyZvCwvdhWlXswwEyKdmEOiBkREbHq+c5LVaDBHWQdQovKQ7
	 F9GYo+2Xg4F0Z7BvKnk7I6Y4R4tEIzXAWi7x4S6OICuA8fyZVr+sk/4QE5xlu57j6cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019742;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ndQE2qrYKAdgZX2+HjOyoBnfJuDmT4BEwj9IP8qC/e8=;
	b=YPawJrqo5LFCuqTD8DvDE00c+Ulayw7vO1wDsomqT+V1oRRnVRvK6cqg50qDmaD9ftEr
	 bCtMdD8wUvjZDHKz5qirfBUyC67XJT1QZjlXIw+7buvx0XbjeOxCmOWtdcDcqbuChHAYo
	 7vp3yDAVwgBcqaNZjRF03nJZFPhzRpc4iVvBD+rvDo2WIOHCXjs25jBaKgW8aInfAfRdv
	 AFdnr6xOzR9YQeLUWEFMmRJ/ZGlzT+XCq9fDk43sYGiD/IHCOz/J/iTqnBOvlGiZGfia7
	 RSZdsKBfBHEFR06CpevEJ2PPKjWe0+gC70rYDnMKt9ch2qKbLvF2sgGhWUWL9wfyE4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JHiP12Hv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD20606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JHiP12Hv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3ED1F000C4;
	Wed, 18 Nov 2026 16:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795019742;
	bh=ndQE2qrYKAdgZX2+HjOyoBnfJuDmT4BEwj9IP8qC/e8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JHiP12Hv98pz8h5CVLVguxAUXOjgjoJWzhwK01hKkGCCvNyvwfgqSRjcCi39B6JTi
	 NPALS7oeWIQOjj/+Fc2VCl8Sp/PWrq2TUNvw0PS8z8+XRp4feOMKAyrsTX82vnuUMx
	 ZacONY//HzZXACiZJ93cvLvsgJ/1PUSBmAUPg/ySbCrgFlzJB9UaNB/h30LkMjdaIk
	 kkqxv7bEE1NtXdfYVgBkZr3S2RS2DrA74eD+LY5H6EMWSC0R2gMTJcX3RATol5kssP
	 yM14sWWUjFfdNnkzVGVLZKdv+xnhG6qNjbTtjOaBZ/Mb+r76pzPV6smflPKEvi5muq
	 jXqUuDiQnAbNw==
Message-ID: <sashiko-outbox-221506@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/34] perf cs-etm: arm-spe: Report error if default
 clock isn't used
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-9-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-9-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:35:41 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Coresight already reported an error if a different clock was used, but
> this also applies to SPE so add the same error there.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D9

