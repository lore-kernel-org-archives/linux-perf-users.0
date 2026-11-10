Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274954;
	b=cjUR82y87w0cCdT7g3szKMGgA4jVx/etAMEf7Cu8OAYSdzKxNhtNTDtEe9e9m2FPK1LV
	 ATwN4D6IhLi7yPqY3zqjCbx154Duf/zCp6gxw4JW4gvsfuF7OitA4rXUhCoc7aQli3CxQ
	 XoKraMed/XCnV9AW9UwRGQYvAGJbuYgOrkjEzOwMnH6oRGWshj397ExPg+qf1pvGqxj5Z
	 cJ1sm/f4DTkh6dUizYWhQvuy50xuww4u5aAdfojyx71ECtf0qJWZBzpj/Ab3VR3vzPhQe
	 NUFfD3cs2LAJLU1KlQQc9QsG4GC0Ky1dIO5MDXzb+GAybXZAn0PAD7Ka6E7tIwih7MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274954;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GS5QcbHcgeHbE8fi9wdjI8BAF+Ucegl1CTEttneWlv0=;
	b=cgGRCoqfOksM2pDgMGv7VJ8woj2uN2VbwrjB0CD4laViwnV+mRATyfQctZkAf4owIaAW
	 Iq+8lUEHLjG6yy2baVVCs33yg3QWwh/9R1cHeFfF6fFOnqaXd2juSdBa2ehkw4sWNb6BY
	 DmmWd2Ducj3CmtJqalmPgj38Ii9vq9/D+Cae8ADPqCbPvl8exc9Y7EaSD4jTRKXe+ysti
	 +mV6cYgFiYGiDbo/JvrOpnerM/jZc2jwJbUKiBbSsbzXU+32liPOKPcR6NvWG0hHFf7lA
	 Qgh56Wp4axkpauywCZujmY/PNuAsiqoGn3KY3kRVwzrrsg8Q9BYLETDifP2L8d0TExg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LEk+bKCO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3E3606A933
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LEk+bKCO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAA81F0089F;
	Tue, 10 Nov 2026 01:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274954;
	bh=GS5QcbHcgeHbE8fi9wdjI8BAF+Ucegl1CTEttneWlv0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LEk+bKCOHQ2N428/Ggc2q+LzNZTu5eHHesSNO5F9fAGNcPMKZV3UCTyZMBnaFxrFu
	 AzNGI9Ooxcig8omB4TLeL/Dp2Uw8YOukbdNYAOmXdKD9SVz57E2SPMN59wIMdHtkjC
	 /Gzzp3kg1616NInQnsn+XLpO9eBibUBim8GaXN8zqjEMBnpTYUYLtCggv10/3/jVGE
	 KEOHXuU1xZCJKhh+puAq0jmJWxu9VynkwfEl4U6xl3pktooEf32vlTx2gx+bGS0wex
	 vusJAK8mwMQUuJdmOeuUWlRjBbsUp8+sboWamDtJ6i7iOyj1Uz3UdJLurq7xU/GlkM
	 hURg3M9KkJ9xA==
Message-ID: <sashiko-outbox-205981@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/10] riscv: stacktrace: disable KASAN and KCOV
 instrumentation for stacktrace.o
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuai Xue" <xueshuai@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110013750.36800-6-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-6-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 01:42:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Wang Han <wanghan@linux.alibaba.com>
>=20
> KASAN records stack traces for every alloc/free, which means it walks
> the unwinder very frequently. Instrumenting the stack trace collection
> code itself adds substantial overhead and makes the traces themselves
> noisier.
>=20
> KCOV instruments every basic-block edge. The unwinder is a hot path,
> especially with KASAN enabled, so KCOV instrumentation has the same kind
> of cost and noise problem here.
>=20
> Mark stacktrace.o as not KASAN- or KCOV-instrumented, matching the x86
> treatment of its stack unwinding code. RISC-V keeps the relevant unwinder
> code in stacktrace.o, so a single translation-unit annotation covers the
> equivalent scope. This is a prerequisite preference for the upcoming
> reliable unwinder, but the change is valid on its own.
>=20
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Martin Kaiser <martin@kaiser.cx>
> Tested-by: Martin Kaiser <martin@kaiser.cx>
> Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110013750.3680=
0-1-xueshuai@linux.alibaba.com?part=3D5

