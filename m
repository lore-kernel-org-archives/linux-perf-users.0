Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746326;
	b=eIk8TJivkDttmj0v6TGAnQNJAoSa9ToKSyuZOYkRuC7t6GWjK8GhDD7P/BV53bbJMD6N
	 3kI/pPIDhCA68jmOp6i6H2I4SY57Sn37xMaZeqo/VICVw+Yv6HZqplHzKMQ1681vM7p56
	 T+5KjpcWDFIVk+KU/Ih2vJMJmcV8iMGRtczIBPJfIkEY6DHeWtLa17EMmTe6d0JzkRPAe
	 1mZK4dXCyYu66VWbIP/O/z4zRWv8rN8MM4KELWx04Y1h6C/vkLbD2hoh1wUhPSnJKefc0
	 4Bh86BmVaRzrRS3RGrLQPnvphkrOR1wB8gptABzGtHiCoXmqpodZRuikpcfvlF83xlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746326;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g+ijXcprygCWiaK0QAn6sWYgzjY0LnHBQ4RUGwoIdv4=;
	b=B1mrPsuCb1ibsgpM50Nd0kzXCfAx764iiTj3NPHtIRCRonFYDwDB85ZmN9WUwWioGHdD
	 LtNhizuiNGBePu9jvmXYbpP29CgGTUdYkz6LSvcXc0/7V8wqPydbUaIE3d1WBWKKkjJik
	 RwlR4gyDY/gx+W/bPI8iJRaTxAaO1+cTdLH1W6MFqmLN3repZGGzYXDEnwkn0QzZJValp
	 MZcGZj/OsFYgLgwAsPnH17ujJxOTsI24zgCTM8lpC7oRm7WXqsGJTxCR/nFWlEMzhS4oC
	 CWcUOUgTm9jBUhIddi7UUVrofaOVjYpcrcKV2FCj59FIXdvy65ZfwdkQbmLvbA2Cb5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VI4Jrpvl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A3D606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VI4Jrpvl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8F31F01825;
	Fri, 23 Oct 2026 09:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792746325;
	bh=g+ijXcprygCWiaK0QAn6sWYgzjY0LnHBQ4RUGwoIdv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VI4Jrpvleoo2b1MBCWb3HwpY9gxo0bEBhoHXUh4JXPDD2lfl4QPF0p3ciVoE4Jyog
	 AclGqDeIADG2ZLyuIqjL3t4eio59ueuWUcu4suCjmumc6KEkGOt1qtB6HJwaAOJXR2
	 C7u0a624RfjAHvGSHwYjDJ39fb4cM7yqBkNdhgGwPxXNAI13K50pms/e9g0Im9ypzX
	 QOUqMZ2etwDfb+c/hAHKXUK77klfUod/d4yQX3euL+ikft42FVRA4EnVsXoxVzRcHT
	 71xIVIhv0DuybJif48IUpzZGdOIkRGqi1NmAlrOLR8Okj5v3O+XU1HJLQmYKkWPw1O
	 tHXYpscdGI6kw==
Message-ID: <sashiko-outbox-182548@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf test: Factor out the --skip check and its
 output
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023-james-perf-test-skip-v1-1-b6c11bdafd46@linaro.org>
References: <20261023-james-perf-test-skip-v1-0-b6c11bdafd46@linaro.org>
 <20261023-james-perf-test-skip-v1-1-b6c11bdafd46@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 09:05:24 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> __cmd_test() checks the --skip list and prints the "Skip (user
> override)" line and its junit entry inline, and
> perf_test__shares_mlock_budget() repeats the check, with the list passed
> to both from cmd_test().
>=20
> Make the list static, like the other options, check it in
> perf_test__skip_suite() and move the output to
> print_suite_user_override(), so that the --skip-name option added next
> can hook into the same places.
>=20
> No functional changes intended.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-james-perf=
-test-skip-v1-0-b6c11bdafd46@linaro.org?part=3D1

