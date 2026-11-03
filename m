Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702610;
	b=lmIMzHOHJclQqoG+pM85THC1jP/d4i2BU6gmTwnbooUg55w8eUj72DcN+2wIxVUW/cps
	 QDKInXybnjx6wrgJ7AJLhpRSgOkR/vUIaYqy8nkqSSPSbcF6gEfrETvlT528jy6Nor6hl
	 tQxuqXpmjBnXAeXGuOZvMeWWAZ8h+y1RnQiscDVCe18PY6+H2XW0tDbDWN6AguKp94Xwg
	 maCS82QYla1xBrEcJ9rB2K7gcDl2LSm+/4qK3P8INzL7GM5GF83mFGpmyScvcTpOcOMPu
	 ADOyEr1TG4OCKgKlifpbmWRWuBzO3YDMrJJSzADuad2arYYsrRUzMWdwDBSWBFZFKsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702610;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=in/2KUhYWCUNu5Apx1jARBLYcDYOWMaXTei8yAX4ta0=;
	b=lTgwUMsDtVYbo03MPB1bBQ8d6WlsSVEY7IjSRs6Dcrlr/ApUetHyWkbFA/riNRfZwGKM
	 8+hoDB84ODEreiD74m5XaCDA29YxRdnfpsy5kKfeTO9xBZZ+bl9mTdKPMFebFpCInpukM
	 y1Nib+epqdUCWSIrMgfLLgm9iQyDBWgvhvJpBW8IoQJvK6QrVwfkYM0sBBpNhN3pwj/2Q
	 RTnUSMTWtqmGZhM/WlWeNIIwbNr/N99Bgldu5ElP0GAfLe4lo7ygXvsW7qEtTWm8za+FH
	 6/CjyjXjKglduw/VF2b+QmfDoC7ljvtcQEvRMvpH4pwcPGGXRe1oFYkBdy366o0kW1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eybOUiWO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED488606BA5A
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eybOUiWO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586FB1F000C1;
	Tue,  3 Nov 2026 10:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702609;
	bh=in/2KUhYWCUNu5Apx1jARBLYcDYOWMaXTei8yAX4ta0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eybOUiWOjpXLyFFMP5S/6yaOVjNNDg7FwcnshlVaOV/iEQtcHca07BWu/OYGfb44P
	 X3Ejk5iINasDsafNEgb0HxVIa9bIM2M2ea3rUP5qw92ZhwQdKZinWyVqC6RYK/RGk4
	 kMUohXhI0sZfMrCaE1c8+I3L5bNqe6N51f0de5JeTlcHOgKlE1fKQAbeHayCqslfrp
	 MbPQoiOsaz9uDt4fs/7OKicFbYKiBx76AMgV1kppo7FD7waWeGNTBD83juMSokdRe3
	 OC5BhHTaqkAcxtrfB2dGTeE3GkWteSP+AjrNmtuQVRh9gUWoduXgp6x1IKXtQ/rRRO
	 9xJbXPiHZCsRQ==
Message-ID: <sashiko-outbox-195062@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/13] drivers/perf: apple_m1: Add Apple M4 Series
 Support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103-m3-plus-pmu-events-v1-7-a8eb6c1139fe@gmail.com>
References: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
 <20261103-m3-plus-pmu-events-v1-7-a8eb6c1139fe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:43:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Myria Sarvay <myrialsarvay@gmail.com>
>=20
> Add support for the CPU PMU found in the various M4 SoCs. This PMU is
> almost exactly the same as the M3 PMU, just with different event
> encodings.
>=20
> One notable difference, is the addition of the various ARM_* events,
> which appear to implement the PMUv3 specific events that the arm PMU
> specification provides. Hook them up with the various perf events so
> that more can easily be counted on M4+ devices.
>=20
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-m3-plus-pm=
u-events-v1-0-a8eb6c1139fe@gmail.com?part=3D7

