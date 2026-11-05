Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885023;
	b=TQn7YMXQ/tZBvUgEaW1ZWQB/pEswyHGw/RcXZfbhPS6hwMyNBMN9K3ZBd7rEUKF+F07Z
	 /6srGOMksdwW3Yut2+0Tk3GAy3yjpB8lhgpY+qH0bnoHL+q19O9GbDzy0Qty5iq3d9yeU
	 oEdPV86TcsmEYtUG3S7r5YxLsbabkyN6joCziSG2lux8yZl9dmKWxQj0L5sb+6DGfcXR1
	 7YK+ZC9vprFrCbvIORiUNzrGtbOBGxv2P2RareIwZ6QZr3yZrCfQM1zUBGVY/ucbh3Mf9
	 LrgVTsGA4NH/JNrk2PE8rzlIFvei6iV/ceLIpXTmv8/YHs5nb1g3czNrXhCUhBxpIFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885023;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5k3yJbDzmPOeOJtAFW4LDnD1uM6/+nca+eCXNrAU5Fk=;
	b=avVi19OeLKo1rYDgkMrghDSLuDSe6SOOy2pfmIiHjbmRPc3lb21urvn7kOC+17EBuXfm
	 TQ6O58WEFk38ipNe2QbH+fB7pWA4sXPT52TKs/5NHg9dBEoF6TICuwTHvpkZMDr+27zzH
	 1fOTMeRIjK28F0BWf6m4Ad3MKuYoACjfdGx6GG/qUa74Az0cx/1kKnOgu3ACnj4+PGsZt
	 mquk6B322LtA7Kj9gU0jSdK8UG4V7FKYx0lvSKVE8DLJQeptRIXVegdgzI/VfByku1IPg
	 /fhWkFGgiztDD1dp5ADyYH7lqvFYOiiwiWZtaxlnfBr2L612HbDt/lZmU/4I9B0oI/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YAS56CkS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2319B606EE83
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YAS56CkS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01541F00A15;
	Thu,  5 Nov 2026 13:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793885023;
	bh=5k3yJbDzmPOeOJtAFW4LDnD1uM6/+nca+eCXNrAU5Fk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YAS56CkSOM82LGBoD/gZvcTAY9MimG++NycYGe/HOMYbjciFoKCHUBzNxfIkxB9ai
	 s55OgLJBZKSGIJle5H1YzaSR/BLzOlYXmIU80RqrTLHKMRvyvz4iLmZXOPf86ysnMS
	 JMDGegMVasr+z8roVeo1N7w1hVg0az7dHpngldmRMvY9GRKRfpKzWMlY9eFTNHuokg
	 Y59dEQNx7LULBcPltPGGAJgWSCFl0xo88C+ZJ2IWReoxX/9W5zhR0Q+pOudTrdHQ9Q
	 DiQ9zkxxwJ+0DOfyeVvsUbWjz+Uz6tYFpYFPXHhInl/RVpP6Mwg91iyuTXpbSO8q7M
	 qkcCv7eoD2X6g==
Message-ID: <sashiko-outbox-199135@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/19] perf cs-etm: Queue partial AUX records
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-13-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-13-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 13:23:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In snapshot mode AUX records may straddle the boundary of multiple trace
> buffers. Currently we only queue AUX records whose range is contained
> wholly within a single buffer.
>=20
> Fix it by queuing any partial AUX range that overlaps any buffer.
>=20
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-cs-u=
nformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org?part=3D13

