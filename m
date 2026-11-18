Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020131;
	b=3gawauyV1ouLKZzrtSNVh3MgmXpBBAe2mGnotMYo+Z8H5Xjv1MB6lMf4g4C3/qa/5aXw
	 XC7XCh2TUkJxPhvDhljroDrFzWBe3qSm7N+A0zZlSvfDN9WC3khbocT96u5Wd1UBbmU1+
	 esZXFazN/oR8lFPmes9zLbBHa+o4Iy9lh6JFzytnbDwFIvyyB9ohHO8uxuH1RPsXzO069
	 JRLN6bm8V0Nry9V8WmzlQAV1Cdfd2CmL83/QLaD3RO4chB3LkDz3IXN4u9lB1hhr6xIdP
	 1oTJhAcA8PejJptb8mdw7d/19L0AHbFKKv1Xh5DKL4gEBKWwYF+Dla2UBoQlMGpDmlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020131;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Wxvurcdb+lrKes9JqMX/Hn6qqRpb4e9bD2bBsxH9h88=;
	b=QyJOz8/jaHyIAAVucwwLuRhy3Qf9oCTOYwnVEQG8spIlK6C6edcgwHFO4PJxgzz57VcH
	 LpsGRELDRGI7oTecTu/dzMIKpxh/F5h1Hpg4qL6YyuQk3xrGdVVmT9wGUh2SJl3BkHrWF
	 QaNgk65se1g1VFbCm+0tkxkxVe94Jxvbw1nykmLyCjXt2aCqov5p6Gfuv/oONO42zwMOb
	 RIzwGx7uWsJULel7HRxCGQqnjgL5aNbAcf/aR95afSuDDnD8UUCvl8Qz7q6CZuVO3OeH6
	 iRW7aRixHw3ITQgwXtEks3DfUXGDnHAFZDLtV0+U59+VXNwLucZP0r462eLNHeY9KXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mu2cy4SY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BFA606A337
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mu2cy4SY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609361F000C7;
	Wed, 18 Nov 2026 16:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020131;
	bh=Wxvurcdb+lrKes9JqMX/Hn6qqRpb4e9bD2bBsxH9h88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mu2cy4SYd9GoNj8m8/fPqBuNzFNBmNoNk1atYlQLiPi8MLy/ApMd7QuttdNoFtPt4
	 ac1g8+7C+Of1G2+HIX5ZvbaYs5KQJHMQTtTTErvCKRVwrRI6zl7l9yWLRnyEIB2kBa
	 8zmKjw+PvDctX82HCLBOzrr3WhIGtVQwj5k19lrpq5nAZblYer5ff2vI4EZvjNbsAh
	 tQCBtgtaIBvcCwj41k5SAFDUUb3Wc2OczO/eH8uKsZMiXxM7piuf5F2f5vGJZ83BNA
	 bMaPQLaZt/ZJw3AZBugOZ3DDXEeuLNiYfGcSb50YwvDXzZjj3MIYsD8J3xpYjfA11B
	 2Nrg5cDMcUYSQ==
Message-ID: <sashiko-outbox-221534@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 27/34] perf cs-etm: Add packet-only timestamp decoder
 ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-27-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-27-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:42:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add OpenCSD packet-processing callbacks that find the next timestamp
> without fetching instructions or producing instruction ranges. Bound the
> search with CS_ETM_TIMESTAMP_SEARCH_MAX packets.
>=20
> Keep the timestamp search state in cs_etm_timestamp_decoder, separate
> from the full packet decoder. Each source's callback context identifies
> its protocol. The frontend continues to use the existing full decoder.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D27

