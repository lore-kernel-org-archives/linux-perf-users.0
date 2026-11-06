Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939744;
	b=afAyWN6bZJY6S2XaSDyOUj2OePQlpl079a66ijoDgg2MNhg96Bt1ZBr5pSXi3PyDapFa
	 bOkZjfp8W4bqTAIxARRQ/b2kh+hci/+zwJmzNw/6Z8hoJjxWcAdhOxhMm0NohI9UC0mDe
	 BnUq4pX9wos8CdLMVuYZWe8EwghzYe6zKSYHoQi0yulu8U25xbEB7w3utKhJGMHsGTf6k
	 bnHaZluavfL/OrMeRGg9RR5FDbmmWyu7rkq98H7OT4oTxd5hYMPRnLv6zH5Ob5s6Ehqvs
	 Iqb0vyfqLPvW/VXdvyD1PYxL9xn4e8sixH/V/GqakuhSxW+vsp2UVLMcc4rh1hw5g0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939744;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FWLLbBOK+mcS4eIN1CiSsi4LDKR8zyfzV1LKhvyYIpg=;
	b=uMlE8kqsDIcvOVSGXD9/v6f1iYua932CQiA8cQXJhO04kH7hcWPN+H0TTuy/FycaRNHP
	 XW6MuJGN61PcPBpK/jC9SUuIh2Ahoaa0VusiX+UxoTjGzXWcslEPE0WkRnHRl8X/hlLsI
	 PPaixOBUIR5tXmitVWTb0VRgy1DBgpjmWSOSQA/wK1xyhO1Ih0v3ca3if8R0VNzRZFRAY
	 SPVHyIHniQa025yl3coj9xjJ4YhW3q44pfiN+A6pmmlv1hLwdV8/NZkpsTX9CKvKWTE8P
	 /1rx+JdY/vF+BHr/ocCwubuC//R3ILSrScQdTpsdPkrxNCGX4pdIZmuKuBK85kqB65Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXMCRF08;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0F0606A31B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 04:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXMCRF08
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA491F0089F;
	Fri,  6 Nov 2026 04:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939744;
	bh=FWLLbBOK+mcS4eIN1CiSsi4LDKR8zyfzV1LKhvyYIpg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bXMCRF08zOD1BWjNyekAPl8mjJQaUDiBQJ8BY4KrWGO6SLgh4aU/wJawCGGtg31A8
	 fprCiiZz4b0wvjIUJx4pma7MTI18xRrt25vgvZlXwPAQYiOuX8cYr8MjkHNXfTNr2D
	 9tAFzqR/zPIbfn+UuECRJvGax2ECldXf9CC/w5zhspJt06g2+alvRc5msuP/L2wsQM
	 +SXI8bff+ouIWT02GnKI0vJ8SLNriDuF85okfL777rMS9ul0MZmMlC/UeeoCnxRETP
	 G4rguqed9klnkHmlscTUs4OFtL3jXVOyWumB9VbEWcPFQXRIn3IQZaB+/VuBoY4PtJ
	 6W2mhfNIGqbsw==
Message-ID: <sashiko-outbox-200741@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/14] alpha/perf: add sysfs format and event
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-alpha-profileme-v7-3-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
 <20261105-alpha-profileme-v7-3-c474e892abb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:35:43 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The Alpha PMU registers with no attribute groups, so the perf tool has no
> way to learn the raw config layout, and the PMU's own events can only be
> named as raw hex numbers.
>=20
> Describe the event field in format/event and export aliases for the four
> EV67 event types. mbox-replay has no generic hardware event, and can now
> be named as cpu/mbox-replay/.
>=20
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-alpha-prof=
ileme-v7-0-c474e892abb0@gmail.com?part=3D3

