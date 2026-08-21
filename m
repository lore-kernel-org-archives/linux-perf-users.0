Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B454545C6EA
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306761; cv=none; b=iAeMoN15DPZmR0LcAqnurbPUT8mAvsdg967chaoHOPLntDH9P6Y5JcvkS77TqC/+4Y6IQVfASXdWoF1U093iq2usXo4jwwhkfIkOa1G88CWbmypd6yFxWUzteIqgaxYq3Hbzj8Qqs5VcLxG2j1izRKnFeFNZ7zr8rEi8ow8LZYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306761; c=relaxed/simple;
	bh=vQO43st+TIx3XuGAtLHd9lwg6P5jk8rHHpu9bNBItts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YWq3OKEj2Iby/zFt9JMkZRIJ5a+XRKlJaLg2ZVqnSKWtVEBpbNarQto/RjkfibXfvx27gX6ec9oVobj2IKbeZpaZ2Ytf9wRTqNiUQWbg4m6syZjolVcmL9+9DddNjyMIqZ4ZsqtxWf8hYVKjDDenvehQIApe6uFabvQ8zU9dLZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6Q19iv8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6Q19iv8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B411F000E9;
	Fri, 21 Aug 2026 10:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787306746;
	bh=vQO43st+TIx3XuGAtLHd9lwg6P5jk8rHHpu9bNBItts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a6Q19iv8kmNoT9Dv6JJj+seK5BQ2Sf/kdqeBjmvqtqtumxtdlzviRgxvhPi/UxUQ1
	 c/mh2vgAnzzbtTKPu1++uRwd6aYt4YCsx+/TtzoSCotE6Qe6fXFq6kMcZiP/gCkrLV
	 JUDJwCvmGV2pbocgqAmfyrnaZdrbN+45JkQL5NXN/+Cwk0epOH/wXRDpMCDmCHql0y
	 qNN1F0etsi9Sauqu9ihaZEQghR91G1HvdvYKjnr5AX2uBGh0nyUdAl5QpyKHQCnZx+
	 Yx9afxKSRXlStoLVOPE4yxJaEwfC6YonH2vPIhAGCgJRxMFDLP3k5pvrbgl1PnOI2n
	 S2FoR8lSvb5Wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] perf cs-etm: Free partially created queues
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821-james-cs-hw_id-output-failure-v1-2-9d532ddabcc3@linaro.org>
References: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
 <20260821-james-cs-hw_id-output-failure-v1-2-9d532ddabcc3@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:05:45 +0000
Message-Id: <20260821100546.18B411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> cs_etm__create_decoders() can fail half way through and the
> err_free_queues label won't free them. Call the full queue free function
> here instead. If no decoders were created it's a nop.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-james-cs-h=
w_id-output-failure-v1-0-9d532ddabcc3@linaro.org?part=3D2

