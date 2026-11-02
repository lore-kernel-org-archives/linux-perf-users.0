Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622397;
	b=cxRPyJlqmrhwY5MTMBufeLXPUoCwJGQ+tRvt9b9nrACpEpFJwSC3t6tVVp/qD4rT2Psq
	 pW7K0XGLjAuJRYABWu3Mz50dpLk1kduU1NQDJVxIoIbyDsuXRwmwHHrjx92IqiAnz9sXz
	 XlrYDSKom4PQC8CJOKpFsqGLHeoqF+i4cUn45U2v26vSiJiikW1zWs7O/RU5ZIqo6v1wj
	 PXDzHULi/ot4PSRNOYfmdJ4DpPJrJxhNPzSb02lp+TM0tGvVQSctxFKD+ERA0XLAsZw+b
	 v8IKJc8J4bkrMsyPBNeS5gLyZkgTnCr6hnnPno5Zowkrehp8fJDU7qR/cmT9vMzOuyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622397;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G4Ee82eP+LfKaPe3VllAQgw7tuXGMgPPe14RTT2fQFE=;
	b=rgntCux2Qhc+UdV7YzXil9fC3jy3DwAupfCqxLbtaJpwT4Q9c86U1HLpwg3juJOZZnm4
	 S+MtehcmfFagH7PdsTmvIfEmz6OehGPZ87eaYUeIFf4gEt6BTY7UdlrkH9up6mztypIX+
	 UGyKhsT1r4tOXwSvinrUA3jKoMo7KtVcX7/DJixNyHbxZ3DFOKHSh6niTBpwp2qEGcjtR
	 8K1JyRsHTbAKcp65RU6jM5pYNLNXoJQsFi9sQD/pFB9Iqh2FEzA/TDf7pBREv1U8DvbEv
	 FN3IChk4M8qI2vC9GGMSS5ikKGpxenVSeKhbidjmJ+HMbssbObFRbaGVkLG2jNSlzLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7DJrWBv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559D6606A326
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7DJrWBv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F331F00A16;
	Mon,  2 Nov 2026 12:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622396;
	bh=G4Ee82eP+LfKaPe3VllAQgw7tuXGMgPPe14RTT2fQFE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V7DJrWBvH1Amk7Ft7RMY8xIb+qdtAyKxjtb4BOzsBvgfnoCAkFTnKybgMryyd07NU
	 eU0bMh8U3yy5tgJEzm04oC15foVUzjrfoOV/iGImU8QUzAQfFXuo2D13BhjhdMWfZ3
	 Z+70W9MAfZ2wgM51C5CVQErk/QMgdUsDyTcLchYYOY0CtA6GUe1L1xlog7BwhLwPQ5
	 f3+tug5V9VYIsbWPeP83djno+CiUtqpvieBa2j+dQFVwNTm+gWDmpNBhGkX8wU34gi
	 TEDj/9kPDMntdcZDhRTW2vBzHH0OdRR/xOBa6COTgHm1CX8VDcQRK3EXeZr+tSF9uv
	 2iLHoFIFYjUag==
Message-ID: <sashiko-outbox-193401@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/18] perf cs-etm: Don't print missing buffers in
 snapshot mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-14-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-14-dbcb0c281b9b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:26:36 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The driver produces lots of AUX records for trace data that was never
> captured in snapshot mode. Downgrade this to a pr_debug3 message as it's
> only an error in normal mode.
>=20
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-james-cs-u=
nformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org?part=3D14

