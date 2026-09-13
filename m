Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213B31352D
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789267216; cv=none; b=fIjE2oLv95X3I2v9IheIbh7iFTfe908xI39immsigGY0XTFQRNkY8wM7y3alKgaO3hdxqyJ1JnMwk5PYH9cWQlvERkvkzavgg0iERNjNB+68B0O7u3WP2kQOiOuqs52dpPSM6bomk8M3OpOEOEDZ7BSzsoVPAo5fjtbbY+B1+34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789267216; c=relaxed/simple;
	bh=qzA8seQkddxwE/d4I4GlB6OSEyiOYJQtXvKqk6x+R2U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DJQh+lVBe0cpu4v0SRW1bzfq/j272AKggaOVXDrkc9YaIHssaFNHKgfHUpeVr9AawjxVhee+989sJz3y9K0L09JRTHjjBW/lwvy83Q71MvDLx+t1YN1JbYE9nZTHt+z6ozJwgACG6zMkDi/s5Tn96NWBIwRID4ut0nlWGJPUHh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjcSQUvA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjcSQUvA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B721F000FF;
	Sun, 13 Sep 2026 02:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789267215;
	bh=zm8Fb/uXF5qmvhfDMooTi074UQKbUhhF+93W3zeb9gE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GjcSQUvARzsEOor9Q2GVKOTEyc2T2sraLgrJuHNKN0k/47Iwb2gzD3mv5QZ+P6NEV
	 3ycau5Gf1VVrWxOzqz25BSDjxn38j0ZE3AAkZFPPygdkoK/QuYz8tFsWDrwSqTnVvx
	 AI3+41L+J5Hd2LEPHPMPHDtg0+7dQIT+6+HubDt+cOhvb8+U7tUHMKDRT8x2YNiCTp
	 uoDw9O17LoPKIzmZSMiYhF9FmJuARVfqRUcBINBgze35qjTXvrxb41a6TYbIlIesqp
	 iuIt19b1S9F2BLnUw78t+nQImUk5iSjCRIAT9Kxe+LX9xky4yiEmfo7ri301soGvNX
	 DM7jntQXuFNcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/8] perf test: Skip data_type_profiling when the PMU
 cannot record memory events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913023459.112654-2-acme@kernel.org>
References: <20260913023459.112654-1-acme@kernel.org>
 <20260913023459.112654-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 02:40:14 +0000
Message-Id: <20260913024014.D4B721F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The test records with 'perf mem record' in per-thread mode and its only
> guard matches one specific message:
>=20
>   perf mem record -o /dev/null -- true 2>&1 | \
>         grep -q "failed: no PMU supports the memory events" && exit 2
>=20
> A PMU that has memory events but refuses them per-thread falls through
> it, and AMD IBS does:
>=20
>   $ perf mem record -o /dev/null -- true
>   Error:
>   Failure to open event 'ibs_op/ldlat=3D0/u' on PMU 'ibs_op' which will b=
e removed.
>   Invalid event (ibs_op/ldlat=3D0/u) in per-thread mode, enable system wi=
de with '-a'.
> [ ... ]
>   Pipe C perf annotate test
>   Pipe annotate [Failed: perf record]
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913023459.1126=
54-1-acme@kernel.org?part=3D1

