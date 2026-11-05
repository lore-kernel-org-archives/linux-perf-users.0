Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885520;
	b=NI0zvbg43Y7BdVxQqyJ/zdcY3feX9EqRC86Dhvo+Bql6UHkGnfS61yCt6XPxWyrYAIle
	 OvEdrqwFGRijAKpqDZufoacYThHDMpTP8YClKrvYS0KdHxSuwBwf9cbfIhYroovA1/XJ9
	 ZTB+alp0WwigupKVCLMqBYPCD6eci9mtOOyK1r+dUwL6SYcUQzy9Xx2N76KcIFhNCl/Oi
	 nqlr8OSIbFSK55m7XZ2NHN0WyhxpCxju/apmCYDJXU7xP1YQqUumzSsNmnjijFPxA9/KR
	 CS2AIqe9ltT+d49hf6b7Xzt475X88qLCDN4Z2cMSraZ8rYIbSr5s8toZsLZwLLJGdng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885520;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8wltWlLMoS+bp9CXjVrOMwbugugLIHNZGMU+E/69oHQ=;
	b=iyYrIRXFBv4khTQ4sWG98Kjl3lVC9AzWQLffLxDAPProYSX8z8sHykG6WRfWPD+79oY2
	 3i/3CvBhqVeXNHZY8OmRvZpQhx5Dbxr72VPvkSkv37+L1A3FauIvokPjpGGaQUmlGfKdq
	 Zamt/ndGeflLsXR86t0P2Z3SJjYpObc5qZQqfynXsqt4IJv7CzwqnlEQOAPkQ1dKNhpTa
	 L3UASdtyQYkEsMJqKocm3hBPtsQz6eb/mDlm9XilOAGcWoW17ETDKE+CKpgS5jBfCueRM
	 /67QQs2/tbR9PTZUJUm+NNxX0pYMZPFtoc06RV0cjYhyVtqEme5kfCScJDtCY6oPjKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6QqMvSa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C60606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6QqMvSa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1A61F00A1D;
	Thu,  5 Nov 2026 13:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793885519;
	bh=8wltWlLMoS+bp9CXjVrOMwbugugLIHNZGMU+E/69oHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f6QqMvSaJoa8cRn2t4vJt4aoyhFgqZScn4U+iAw/FQ/ft8FxKxASdRG++ET9rFDl5
	 sz4YF/avqCRDqVlKYl6baTEcVZ2B8AxRZf6eRt1YE/qJ3TAWLPJBgO8e9WLiTH+9l3
	 VmlckxxknSrpKGxrY9bzT1pLnE909LcoWGUxZS54c35xH3o6DLeO8PrJmcLQ9DYmZD
	 UrQM0Y0on8OWgYr3cr0x73/YRUKS3jqiIkcCpNAFO/gkEBV11GDJ4BO97Is8TQuFaW
	 IBK/4BeEMNy7S367QEyG2Lkdg7d1jtV4w26SD6UCwE8BYC3vWJ0Y280wYfO+PEUaZa
	 s7cuaffeptn2w==
Message-ID: <sashiko-outbox-199156@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/19] perf test: Allow infinite named_thread loops
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-16-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-16-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 13:31:58 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The following test will want this to run forever, so add support by
> treating 0 loops as infinite.
>=20
> Convert i and named_threads_work to be unsigned to avoid undefined
> signed overflow behavior in infinite loop mode.
>=20
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-cs-u=
nformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org?part=3D16

