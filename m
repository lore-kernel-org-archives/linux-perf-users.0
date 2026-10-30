Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373440;
	b=qxNAMFRkS2lbaFMWVR+WWunQJdv85yuXlKqD1Yk0OLFqherZ71dJEfOwykQ7jrvkBko9
	 AXTXw3XC3VseQl2z96ZsP6BtBt+zTOJlcgo/cm2zBbt57cPhKSD0ZRWFaj8IFcBXBIHFW
	 gGNSfkrKp/t1bwOmI/lMMMxNxPnBaTryYIWDvNQwlfn9zmp06aJ/z5nup/U42NJH/XKXL
	 tTi4eFQCRjH/1nUG3OY9akkPa+SuXrF4P91O21obLxi/Y8FPFeekHYOUyqf3S0NAKjVxs
	 iPFXyofDlNSJ598rlOJpuxVQOtaLys8aMgAkdepo2RrxZpTManJjoK/latZ4GsQ3/Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373440;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Z3NRBBhJWC2AWTLQUW4o9YkhE4LhDx7m/dgwhggUNZs=;
	b=20QKVhWwZ6EZ1WVQJrQLadFmODoXHGQ5Fr/FoWJ1eP1g2ZSkWA1EvQcos4JUoacgE1X0
	 /ybpsrKPu86K4vK28zI6sci9iGW+45dnPO2jaid73J9rklocXCikNBnbty2B7CNMlxxe9
	 3YdvmoKpKbdiTKvD9IwMspOCU5tT2K8mxkDeVXU6yZwCOaYTQAMwbQzvQPiX0I0EwK4rP
	 GSso/zQJ7jLieuAFvmLKet3/lPdpPJfgNXZDRFAbbG54SxSKp0XRcHJ56YRWzKWyQxbcr
	 /btxVoXUdmcoA9EHFAEM146/oocLZ7IsU83E81YmIE9DLYU36NhQsAznChZPwoT1dkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSRm3jdc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D381606A321
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSRm3jdc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0321F000C1;
	Fri, 30 Oct 2026 15:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373440;
	bh=Z3NRBBhJWC2AWTLQUW4o9YkhE4LhDx7m/dgwhggUNZs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bSRm3jdcbPxP5z2YpHLZlHJtIsear18U8Pa+d/oxmnWxHJPKLFiFxiJG+3Vew/mAp
	 j2hNoPR/jryps8Yq7/YtVZQra3HxZtkZsA5GsAeTyRg4FAZJOdXjXrBwYPfMXc5p0Q
	 X6bKzowDhWS++CvwzNPxEeYtM1Gg+mPAzWncXM6T/mUOvyKIGqKkTE4dIANu5WOzOX
	 wjHfPm3ZBbKFicZ+enM10hzC4HhED+b2MpcWFZ71q9c1/39Ta+T49iuP043RlE9cPS
	 j1YLkwI2Zeo9K9qJ9rWjpCTpbZzSVYjk6iJBjPBQ+dN+lQEdosJxDPtGk5R6QEsBWq
	 waBjs0ysTGi0Q==
Message-ID: <sashiko-outbox-191150@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/14] perf cs-etm: Centralize packet ISA
 initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-4-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
 <20261030-perf_cs_etm_fix_non_taken-v3-4-7629b52ab047@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:17:19 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Exception packets need their own ISA so the frontend can generate samples
> directly from them. Currently, ISA initialization is limited to instructi=
on
> range packets.
>=20
> Move ISA initialization into cs_etm_decoder__buffer_packet() and use a
> common helper to obtain it from the OpenCSD element. Populate the ISA for
> instruction ranges, context updates and exceptions, leaving it unknown
> for other element types.
>=20
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-perf_cs_et=
m_fix_non_taken-v3-0-7629b52ab047@arm.com?part=3D4

