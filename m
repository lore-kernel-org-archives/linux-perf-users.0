Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6191447668A
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395306; cv=none; b=J4F4sJ4GErnJS2EzCUgyiqdoa21TSmkUTvSf/9vPsSYhyHXCOxbhzxEH9wZYPR0uWccIJ3niiOPfoaRnfIsNiNzodUCIqBzZ8eeEMmwnzhkEcDdoqNzletHlWGIcJqSS6XrHY+SEPiq8iV9iFLFt2+6YfzfGoG4c6LXbylUmkls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395306; c=relaxed/simple;
	bh=yYGr1esUsrenHlQHyK+FaEK4bfXEGp4C7B3Nkd93phk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qLac2Y4cb8hatYeXuTj2maE8Qjp0OEuPQ4WrsOsDdn5BGIFUnrvs5ZQgFhZ5VFQCTjTwW7kKAYfG9i7bmlGzoF/8Mb7QgVq9oikq/s8jZzU2AYKL0xv016PmbNUkF4bY1oCfoecyG/aga6sv01tlTOXo2xh1HsZBDrgizlqJa0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of5NNBCO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of5NNBCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B441F000FF;
	Mon, 14 Sep 2026 14:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395304;
	bh=Ohte4G00gJ3sUOIOaj+ZKnCpSYXGT97uS65RjQavKa4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Of5NNBCOs1P4D8Irv0wbwb1oaonVwcuzqYp+la6GXEjfOMx4xII7XjGWT3zJEu0ig
	 0xaxJvuf/XWbZNJ/3t1Ie/VwLjPikqIHTl4Ed8CxACejbKECQ7UxKdM1Dj3ggKEY/+
	 YVIIaNgtk7qz3SDoA/xit0nn7Up4FW9yJMNL2bMORWy2FM8c1vrOkmHIChCrxRalLN
	 Mf2+wFJIVCP5rkEZsXpK14ubYtuiIwaSkXxKnvsbD7dllGeLQsBOMSDi3ChwVDpn80
	 1r0qnY7/QajcJoSz/512WJ0L/u4NH6LiPC1WfByWn7xOjAWRFwXAxCGeWbTVCkI997
	 gaIo28M8SV7+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] perf mem record: Use the IBS swfilt filter when
 available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914125451.2045-10-acme@kernel.org>
References: <20260914125451.2045-1-acme@kernel.org>
 <20260914125451.2045-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:15:04 +0000
Message-Id: <20260914141504.B9B441F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> IBS events with exclude_{user,kernel} bits, as used in per-thread mode
> when kernel samples are not allowed, are rejected by the kernel on
> hardware without the privilege filter, so a per-thread 'perf mem
> record' fails:
>=20
>   $ perf mem record -o /dev/null -- true
>   Error:
>   Failure to open event 'ibs_op/ldlat=3D0/u' on PMU 'ibs_op' which will b=
e removed.
>   Invalid event (ibs_op/ldlat=3D0/u) in per-thread mode, enable system wi=
de with '-a'.
>=20
> Kernel v6.14 added swfilt, a software privilege filter that makes those
> events usable per-thread, exposed as the 'swfilt' format term
> (d29e744c71673a71 "perf/x86: Relax privilege filter restriction on AMD
> [ ... ]
> ldlat=3D150.
>=20
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914125451.2045=
-1-acme@kernel.org?part=3D9

