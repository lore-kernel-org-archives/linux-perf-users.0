Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792441406;
	b=PveBeg5zyWkh59q+00K1vLCNh307vKSlRWsqAN4kYrFaTYgbxy9c7GnI9at4dW/QEfpm
	 ymCgb6N2uc8r3Ar6MANUllpm2ulCa3dJL7HffbeODUqz8EI3EGldIqJ8tZ8IWPgZCXxCH
	 QDb7Bt0UlhDuJJQG8Qcaf72P4vuv4F9t5m8nF3koFODr9yE68MTertKUOJR0WSCSnxZfb
	 oBpIQWJArvGGgJ4veE1wtcsMOiOiNsj3htV/XtGdl3FtwaEtodUlBC5EMd5Mql7Y7oCZU
	 St2HJVBePamhcozMFWDDpMdHsFeoLAt6mMT2rZIOFDKM5nlRrkdVpmY+Ain/QA2DN8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441406;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=e+91LVyYgpJtyf/OPZSBPPxdxkoD27lOBjuOv70041k=;
	b=X3rTMoDJMf+6s8NLq2DA9gyjFMkrUugMuizM4aIbgxgP7DOFqKgM0VL4WfahmHQgiDgR
	 LjJ0J07rkBPmf5unv4FCCKh/QOPejS2+/43ytXi48/6qcstjVlFU9g2gDEmEtZFHVgAVG
	 yOWG1AJxD8E7Ob3QJDcZrMY0H739QUr1M4R4Jo06aexayets6hOL9CEMOkjoK1hvccDBV
	 Y2vp2XhWRsEjJoJ2XzNy7p75zbANCMGXdaIAaV4bfu45Gvk21FKOPP2uWXY7zPm5VV2tb
	 T5k3J80dFS1ym2p2HMxJ0gJWidZEsAx/ROxBVTZpkvcYTjJdzuvxluqNWmRTd2cav8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmFGDfOU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C1A606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmFGDfOU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8531F000C4;
	Mon, 19 Oct 2026 20:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792441405;
	bh=e+91LVyYgpJtyf/OPZSBPPxdxkoD27lOBjuOv70041k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DmFGDfOUV+To7BYmkSQoYlMNtCf0WYOUMkIVb7zyxgbvWxYn49e3Ehj/E4jY85tWQ
	 81X1boWELWoPIUe8WNoLOkq+rGV7NQXRG+wrfvqxY9e0QrVEQVBwSgFOyl8TTERAag
	 x+S41XbArE/Xsezxb+py7xJojr1HCDf1mN48EJvyX3Y0L3nMVLIdzsU3BlSUyD2PHD
	 5KuKKPdQoo99Na0bL4z6BIOH/DVe71srNOaoKtVE1NpjkCGuTKMONIWO0Mm+gqWVAi
	 8Jbog8mM85P0ANqDyA7H8vBJHIn3CVEdnW6Mri5r6jNEyFdR4O5JG78u2VxW46I7kf
	 Sdr3vjkQmFkhA==
Message-ID: <sashiko-outbox-178164@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] tools headers: Update the vdso/unaligned.h copy
 with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019201257.3805356-2-irogers@google.com>
References: <20261019201257.3805356-1-irogers@google.com>
 <20261019201257.3805356-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 20:23:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> To pick up the changes in:
>=20
>   vdso: Add VDSO_UNALIGNED_PACKED config option for ARMv5
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019201257.3805=
356-1-irogers@google.com?part=3D2

