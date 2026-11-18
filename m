Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020041;
	b=t988v78S11GBXXUhNE01CdaGZMWQ7YxVgXt6E4YkVE6WfLwzSbf1PnRhsT4z0qJVVFMS
	 IabK9ms1L+MC8Zc6j0a/YyrkUaaHtwlBcgDizgLx5pGyUuKckzQFrA8mU4nBJnR7dkPCN
	 Fzk9Oz533ImhovXwq1zVzjMQD2gS+mLrMvBrH/rthuiAyFO4+hAF6wUOoyXAQMnqvX3ZZ
	 hDSq6qjSqzXhSrJKlsbKBqo4wdGgFXV2K3Jw9ZV3WF56PH3Zf4dW5wWmY5LR5y4YGqgG1
	 XRDt+beAxGC7WRXOvDZnnNTTLe0H4SyRyeLsaSQsra/myEWqUKlc9EShQVoynGLtpzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020041;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tQOIOrhClxcnMDd+gpqlpvJHSwU93x6D+xyYufl3Gpo=;
	b=WfOcSVOhXNuwJA+E489m8OiSfLeBiWEqSlA4/vbmBZKeX2RPPfIxZPp7Xle/H3JxrKus
	 CHKbY2X7VJLNB5xS9Acj/CssR7Tmx/HA5ZmAWlwdkMHH+y2rlrUIjKuF8tbJTU/1x7jwn
	 Dpmhf2n+PzrZ/Oev0pGGQYve1t8khiZ4P3vQkWVpCsFGbX+vSIfOao8iwjZyC9NSeq5zt
	 Y7RHjv6kTVCFdXDVd7rBmlXXvvUZvnOIqgu5cHABylB0C5MPOFlnPVjjtAVacTkeOYRfo
	 wgjxsbhI17pcP+7GpSqKRNI4FqSj/CXr2zZW7ibQUFY7UvEnwBpgJsrMt9c8np96BwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAnprxeY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093FB60A2605
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAnprxeY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67AF1F000CA;
	Wed, 18 Nov 2026 16:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020040;
	bh=tQOIOrhClxcnMDd+gpqlpvJHSwU93x6D+xyYufl3Gpo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BAnprxeY3p9nL3/TZbkSSItWW701tNUDRPaXFipWHwVjfTjrQhriMlH8OMTtsr8e9
	 tRJLUl65MiUZ/cbMUMWijiW4Ip/wrTAJGcGmPX79GP10wj93PW9aP8UqsUmXQlIXi5
	 p3f6S/8WUvNFYBkzQrVFw7ZifmxtRy0WVgcfM/qQwL1Yzew0mXtydjjfnl3GF7J5JL
	 8aJf5B4cYDoW7YsavIvMPD2ylINscCHhkjbFzcBWXtkzhSgtTn1G6TVhtx9CJZHmwR
	 05f1uzEUWPyvkJMRzfi98W3aaLOV1UfhFmaAm5+BtA+8hnwG5kCtRvUDqaNS+u9JnB
	 ZzMsRoYj2e2Ng==
Message-ID: <sashiko-outbox-221525@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 22/34] perf cs-etm: Rename trace ID queues to trace ID
 contexts
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-22-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-22-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:40:40 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Now cs_etm_traceid_queue is a single decode context rather than a queue
> of packets. Rename the struct and related functions to match. Keep tidq
> variable names for a later cleanup.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D22

