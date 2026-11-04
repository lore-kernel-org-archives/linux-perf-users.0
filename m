Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819320;
	b=hjkRBJxC4uLNEmwM37RirdGdMhUrGCe/woPYmg8/1Qnq/0+QBZt2QtkZGRbLYGi6+qHd
	 MlfF80Ti0eFu+Iz1yAV5atoDpTb3jI/fIuRojRAXzC6ehDeEMCz1YCMkpBpKo8l1IXgow
	 HFPpQGSfQ+nS8Wm8oh/yuGuuMg6eMA+kK4dVH1aUSuYOHtiwsVA3asy+RqRPrecVuqku3
	 9++7UBtdj00TnGJjNjwTKiDRx1oDvX5lDErb+KBIZADigx9Xs9MeS5I/sOSzG1EZjGjPr
	 TSSc+UkhIYm+6GpldE9uR2Yg0xDHqlaHC9Mc8N4hCHR+wVvSmnjqVJc7+x1dp14iUCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819320;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JwdfWgBzizcagauq4tQzWSBc0Oz1vfSm6TeeyNdvIVI=;
	b=cyrIWqWW7ADyKj16Fl3rJQU7mpCLCvZTUXc7XliCU6ujtXHNbFxHZc3LYc9q80ABIf3g
	 iP4Sk3YVIlMGdU1+vvPiEGJkQHnDC56N0hHwSvm1sUn9f3uQm07/DA/vUEitHfmCU6i2y
	 AM2j2wpBHHeVTbstKMKGpSkLkUQgc/oYFiaejV3OTwEWfKD+IyC4ptu8FAhuWHO9v2H3z
	 YTsNfiMr+Qq1z0e+Txy/eYxl7dyacrstF5PUp1JO/wxWoK2Xj6aroYyoCQveInzj8pIbn
	 KZ5QlH1xQ2TM0CQV0amcekCNDc+WuyZ1RxnA3YuUflZT+Ke3ROG3yqW3WbXhlLF6iqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MDTAyK7V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480F7606A326
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MDTAyK7V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E2F1F000C1;
	Wed,  4 Nov 2026 19:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793819320;
	bh=JwdfWgBzizcagauq4tQzWSBc0Oz1vfSm6TeeyNdvIVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MDTAyK7Vf6mwvoQs1MxFjixWs7icgfogeYQI1SpJNflJouX76PPlqJI0nMLVSvOJb
	 i9kYV9zQPyBynfz+U5iMlx/Xrf98fizrfhua8QKWXSl34Q7pZaKkaECECnrUP09OFM
	 msHQoesMSAayZs9Zh16l6+7iTWgOlp9NoedpaoRXed6UC/MqeGUUSOwrjJ0+pkO3yS
	 JHdVIK8y6uuq6l/f/JnpJyBI6b/Ca5Jj1LbJI0+meDgtPtQVFDg2SZvfoBvjgC7qWA
	 MTjSv29GRzsSmX3gR8Zgvcuobnwhd0Py81Z6aBJWyMIxBVCG5Ug3SKFRy4Xbo8dDOu
	 1kuS/aXKRAuyw==
Message-ID: <sashiko-outbox-197920@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] perf python: Add alpha-profileme.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104-perf-alpha-profileme-v4-2-1771ea02950e@gmail.com>
References: <20261104-perf-alpha-profileme-v4-0-1771ea02950e@gmail.com>
 <20261104-perf-alpha-profileme-v4-2-1771ea02950e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 19:08:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf report shows where Alpha ProfileMe samples land but cannot
> aggregate the raw status attached to them.
>=20
> Add a standalone script, using the perf Python module, that summarizes
> it by symbol or, with --pc, by instruction, in the style of DCPI: the
> fraction of samples killed on a wrong path, not retired, mispredicted,
> taken or stalled, the mean PCTR1 window count, and trap counts by type.
> Mispredict and trap types are only counted when I_STAT[TRP] is set
> and the instruction was not killed before it was mapped, since they are
> stale otherwise. Redirect traps are counted by their
> PALcode entry offset in PMPC.
>=20
> Raw data is only read from cpu PMU events, as a tracepoint's payload can
> pass for ProfileMe status. Rows are kept apart by PCTR_CTL[SL1], as a
> mean over two things PCTR1 can count means nothing.
>=20
> On an EV7, sampling a loop whose branch tests random data reports that
> branch mispredicted in 21% of its samples, and 0% with sorted data.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-perf-alpha=
-profileme-v4-0-1771ea02950e@gmail.com?part=3D2

