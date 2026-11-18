Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794974317;
	b=ZGFSqy8XrDEMUB2SpFKws234KyYJukeksS2fsn8AdAHIAl74BFOfoqTnUfZwvtrF+BHN
	 SJkY+29Iq3POSlGqO1LOGRfxysaK2OUbhRqWhjTwvJdtz/2h22GkuotICC1Wm4glle7i1
	 /I78GzjvWQGEXALceNicOJ7RbWkzd8CSBOHjJdeOoxqp3b5y/iJLnoEMDFBnDMiCcgghN
	 qfm30Wx9ZfdyS/hkJtPX6HZBCnbYcXcOEZRivbijlnBBKv2+OsMXlRZ7/Rsmd/uY2rVHu
	 ObFmtPcb/Du7+kQUoodSsOR//otRbdu//faNvUnTppFOknWv7goAs0GT9XQsx/asZGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794974317;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZnDQ4zVmXuwpk6Fss25L7y/i55CAiaq4uY5lwr4wc1A=;
	b=MegD7LID7zi3s+2G9HTX1hURoYa6BMV6FnP8l9dTD9iCpMUiFpXc8OtNi4g3ox+a3dtj
	 Gw7yvqprrq7wBXQXgxTEOWbAxgiKtLTFgrzdleWOm2zDYcZgUgseZl6ed492vBKgfplOs
	 /UAjaIRADURqZN7Yv4t23lc1x3yu/lnkarkn1N5WyUGEqfn3uut/QU2C/FXLIPOlPdvB5
	 ZYg7BrqQ6G1MREaZM63HKN+Gnfof7QNEE47L4Y946X4etjAeVn7yCRHVMKTtzSgWrYXBu
	 eQRuLE9uWcWMSxZIasBxYMJUtdOpNL/EbD+BAxs4kO7s4v8u3MfQWfyLfHUgvLjiMGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YU7+htoS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE9D606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 03:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YU7+htoS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A601F000C4;
	Wed, 18 Nov 2026 03:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794974317;
	bh=ZnDQ4zVmXuwpk6Fss25L7y/i55CAiaq4uY5lwr4wc1A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YU7+htoSa3Z+WTOgD6Vkt7sFVafSlu4OptDerP5LNVpV69c4Lq0FAYiHVQiFCF1G5
	 xYmdS638VXGql9yqMF1KWfxLcnrYF8ZZTM8nMZUxjb8Vb3brXwAwI1gpsaDp+8lVgw
	 8YrPzejdY8ZxQdZ3PVo+0RwFbDEMrzj0hV/ymNc9dvCIoRMzP3oQi6KniWnQxs5rIr
	 R5ZS/Qv9U5ot6awTTqLGtQc50Sv8SHfva12lgiCjaVeUqbOZcYjInDURp6ueTGKnt3
	 BXK5eGRys4s9QO6EEXrZx8MJy4t1BEdkqb7+Zs1Ymt4vN/Q2CAYCQOKsWJeJzqh+PS
	 9yn8u2+QsuZFw==
Message-ID: <sashiko-outbox-220059@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 05/24] perf/x86: Add lbr_enabled to track LBR state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-6-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-6-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:58:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add a lbr_enabled flag to track whether LBR is enabled. This allows the
> branch snapshot callbacks to avoid blindly re-enabling LBR in
> perf_snapshot_branch_stack() without checking whether LBR has already
> been disabled.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D5

