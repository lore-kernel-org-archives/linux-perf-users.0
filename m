Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC2C46D096
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306606; cv=none; b=S/C62dwPg19MHY4n5rYivcv1Y+xa55XkGJin/EetlcJf51vrOdYnfrX6uUKSnIuSWLLbZirMu9SByI8jkOuhKFDc9CkRYtt8WEROvLy4OKN61EnDC0Nhr+rHPLL5Q1N27pGg8ZUfmOIaaRXehmwlIzEDIzkqsfXmj8Mj0vxWuHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306606; c=relaxed/simple;
	bh=xzZkMzLfezixjNhuTHmdQSig9I++k2Yt/Od2/w2wyeU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V04ZJRSB4hisZTuFTLTMDttzwJRpGPmJysnQuexfkrNh2Deyox5G5OFjZvIiRfTw7H0oI1J2GA+N8nTrmTC4t9q2KnjlPRavnccs3ZiX/yfzeC9JNTzWwaxWOLiSPBEzrC4zX9GNHf3PVrk6/aQrC1sItMH7Yli5gzfkhfXR688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6a4mDHu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6a4mDHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BB91F00A3D;
	Fri, 21 Aug 2026 10:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787306593;
	bh=xzZkMzLfezixjNhuTHmdQSig9I++k2Yt/Od2/w2wyeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B6a4mDHup1TEmfStQ5FOhbzLNfp/MG9yphgsliWzRIzq5IlAnlvpda7EwMqrj1ofq
	 O2eKM+zRaA9rkLw1RRbCQsze0oJZvqxiDpmFvN3jEudGLiq0JyDuosAj4l9wRTdz5z
	 uNBdDl7PY8Tw0RffnG7yNtou5Oajt3yzt/CmGE5PTr7B9CM+BqlUlyrJ4I9Eve4K2L
	 qZbJE8zjgDOgXikR/LyGjcXfBKf0egE1Mt9DbhvF4XuRh3+vD/NxyuO7wVZvkQTgBN
	 mp4IUKd0FZfeMJm39JGLpUKGQymo/6cKYvC/OCL5HhUhjl77TycpPn+5AfTcZlrdOZ
	 AttMY4mkfDYhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] perf: cs-etm: Don't add global v0 HW_IDs to
 unformatted queues
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821-james-cs-hw_id-output-failure-v1-1-9d532ddabcc3@linaro.org>
References: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
 <20260821-james-cs-hw_id-output-failure-v1-1-9d532ddabcc3@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:03:12 +0000
Message-Id: <20260821100313.19BB91F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> In the case of mixed formatted and unformatted trace with v0 HW_IDs, or
> no HW_IDs at all resulting in the cs_etm__map_trace_ids_metadata()
> fallback, formatted queues will write their HW_IDs to unformatted
> queues. This will result in an assert because of multiple decoders on an
> unformatted queue.
>=20
> Fix it by not inserting trace ID nodes on other unformatted queues. This
> isn't an issue for v0.1 HW_IDs because they aren't global so will only
> add to their own queue.
>=20
> Fixes: 19c3e4db38c5 ("perf: cs-etm: Create decoders based on the trace ID=
 mappings")
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-james-cs-h=
w_id-output-failure-v1-0-9d532ddabcc3@linaro.org?part=3D1

