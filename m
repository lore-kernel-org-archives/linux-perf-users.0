Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019561;
	b=m0A7/MrFlHMxsICwP7pILKb5k329+QQPwfx23i0iNUahnzUJ8qHo2LUSItJV1gycZZlx
	 Ujgd4x+/52m47B+t7jmmvJOBK5uDZSfES6SmE9TMCvTznxUlJLc8Sn1J+skUq/B5xqP+S
	 +SjGf8VBi+tXjE+VWk3qA6cUJnme0SZ64jO9QAi7B0bIFeFsFLXEB0ogHwg7egvcFuNT7
	 +Ejc3Prns0WedBJUtXT0zQy/1U1/DfNkm7Idn38QIhu0O+AzMYdGDlluMgzMtAqz8pJrm
	 DSXV34zMrelgdMEL+HNYj3NmvnjO6WyQfIQZDl7dbf1cqrRRI/mj5yYkg/YyjWGzceA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019561;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gkDPq8IhSrMrCSnJWjTdccCDS6/PnO0C4XSoERITtaw=;
	b=WQE/6y4PYIlcSZKYIyzfWKnZaAhF8a3Q3C5bERb+13JngQXpPGj7naeSB/E8lDTX5ytW
	 67PB5JyU2rEK5PeTlQV3NWXCrrtzu3o/Zx5LFuMrEnZ+sWxeln7A/+NgsRYjGGdt/Eaz2
	 atIlu5kFJcCZYpKlMU6BKGzNaOdpPcUH+OUZAqRopECeGVUzw5fwRJj61rhxWOjyffref
	 cmdaGTQfXDmWVQr1oQl15DRIqe8B7lZvWS9gzwDoMtyID636aE+dlgr/ccKngBZEwBGOK
	 TdNonhtDKg5A2pPQk6SFviEQo4mjSPVUBVIDXL5Moxnuo2VOc31Cba4DRgSod4RQukw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FD95lJzl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13C3606A339
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FD95lJzl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EEB1F000C8;
	Wed, 18 Nov 2026 16:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795019560;
	bh=gkDPq8IhSrMrCSnJWjTdccCDS6/PnO0C4XSoERITtaw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FD95lJzlff8S6jPxWf4cxAsRjkS5unprftJNHY1WkCRuo9EsdcSCl4D0CL4x0RYak
	 oxGuRKYgaYmKzVRd4vkz9q3zz+GWxfssLTrPyV4UP29wgnZHwx9Qv0eXtqiPTXgoro
	 lpmczME0A2kvmN7u0feTd/3k8fk68QjrX8pS114IPHv/muLJtS1mcQ9gAPJeacBmvz
	 8QufxkiageMhz48KIDvBw0NSEFmzeuTBvge3HvVPcz26kIROtocpe5NTwrQn0QXeH/
	 ZMGdeBAADz4oYtVr+V0rxbHN50ELeBLdPYJpbCdlTPkiIxA8fzTUPS87VHZvE6mQPc
	 uMw4waeffk6qw==
Message-ID: <sashiko-outbox-221498@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/34] perf jit: Add name of clock in error message
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-2-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-2-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:32:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Use the full name in the error message. This is also a valid form of -k
> argument and says exactly what clock is needed rather than having to
> work out how these numbers map to clock names.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D2

