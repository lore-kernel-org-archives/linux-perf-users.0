Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C82404BF9
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185895; cv=none; b=f8F1VqqSJLHsmmWe7esWga9wpVjjQqS9qORtNUeoFs1Y2sGsmHg3rVgNr1Lm1uXovqWQB1yTHt1xvKRdmmc/bWg0grN16Bh946AXnvKE1ek58sWX9CEtkX/1EYllB6d1D8Yzz45QzXGnJcy2rp0lLLQ8nXlZm6grOdThweNG+tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185895; c=relaxed/simple;
	bh=J1UhjGyYEw8lFn7ZJNd3vxnFRjJLqMIJvaRZCZ2/w+0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=LaOKxusAenTqBJpwEukTd9bdYf0ZkkshCic3pr+SQfQimGrpHBHqQ/YXDwc9a9DPFD7rUeIiBED9qTWwGtkNtXZWPyYFl+AWBUA8BPcbgGzjAhEVbMpDxMwr3qa3z07U01wLcE7gH7BSjDMHiZVPh0SZH4qO4zmuXY9SMw0YqEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBCTO7fw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBCTO7fw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFFC1F000C6;
	Fri, 16 Oct 2026 21:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185894;
	bh=J1UhjGyYEw8lFn7ZJNd3vxnFRjJLqMIJvaRZCZ2/w+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gBCTO7fwZ9uf0eD60sQzItEj1cVrV60HJnttDDTeX/08Tdv1MIi5bVRggSWYnW5Ow
	 ZiXB94z80fbfEsXA3nGHRjJZdklXYvdtWnleb0+emyhyRWmNZJjA/x+tfdjWXZ1r2Y
	 zAdIHlgbotDV8555lUZT+SyHumDTpPVWip4f7LUy1HPSHuKHL1WXXBZ6A+GdUczdXy
	 NkMXYDSTWF2f5UkhbKTn2+N+nR2Ksb6Y52oFm8+1o2qtsvLK9gFD4lR+d7Y7yrotE5
	 RBeu7Zw4kPaxr7vsNRb5Oq6vT8w6C4ZvntWWT0DPL9ck3a8q7CyX5yePXG97fU4I/Z
	 qEG/48mGd8C0g==
Message-ID: <sashiko-outbox-174961@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/21] perf tests: Mark the C tests mapping perf ring
 buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016212102.76550-19-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
 <20261016212102.76550-19-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:24:53 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The C tests that run 'perf record' in the test process itself map ring
> buffers and so need room in the per user budget set in
> kernel.perf_event_mlock_kb: mark them with the new 'needs_mlock' suite
> flag, read by the turnstile added later in the series, so that they
> take turns using that budget while the tests that don't map them keep
> running in parallel.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016212102.7655=
0-1-acme@kernel.org?part=3D18

