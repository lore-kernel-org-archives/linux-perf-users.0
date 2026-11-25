Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795643572;
	b=IpOTlE03SNMdr8i/1fTAec8AQMJkW0qjKKvkIWDSaTaVc9MLB/W59MWwkeSKBZBkN20R
	 UWJq7SpwfUNsomlMofJgp8ztTedQVkYQ+zKF0XfXX6shqHMVWxDkgemSSDhlYhMmwwXOs
	 zf+kDS/bWV0+CPw15mTb8HRiP/swGcoTiCFTxnglK4z4EHVoEQ15kh+lB7ShLQfFAskjH
	 FEX9Uf6MAdnwoIlHifxzTjLlboHXMsqzO8YdOb1+QkcSZnvxrMnGGldXeHAqqA9PAY2oO
	 q6GTAjOyz+v4+lvxXCZLOHVQahwe7Z6pGgdMoiXCvTsV3PQkcuKw7ejM6WCwqPrbDng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795643572;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5HnZH2MwZjxj0Kwq5GS/xM9vZ0qt8lYOBffw065CdA4=;
	b=Uw0X871X0AAk292VmO6usoUuXnzLp8Tq8ehTHu7KCJib0Ay8fYUTCB1jJRauHhR3Q0X0
	 oLm66u8vLOt6lKdqh0iT+vRiurPkT5hGVa+R+VaTCryZlvLFyl883pkpkqYF4/fnXPTwP
	 LKjP26mQF6Ft+NUaANEPdem69A1tfYtIaZyUbiF4S9rFZhqybvEk9jSiAaopYsKVJKkgV
	 fG5fwJuvdKjeBew1uevKxc/oNRv71Ov0vmKcuGlj8HzmJeAdY5v/HERr5zcNBKFEZmcFh
	 X3urxGktsmelRACuUQR/H+JKyQoWsZhxBqc+OQdG64aHTKdfGupva+plpnZTgK7TzWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmyNqbR5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63FC606A32D
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmyNqbR5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D21A1F000D0;
	Wed, 25 Nov 2026 21:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795643572;
	bh=5HnZH2MwZjxj0Kwq5GS/xM9vZ0qt8lYOBffw065CdA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AmyNqbR5hEnUlH31PbO7odvQ4/nRIZEW5pxUfqdTJ3ayl9pnnOy+3en0oMcAPesAC
	 40ZpAQt12kbJaMFFvobCNmAVkRS+5GUdG5TuFtCKie4CFsl5x4+aDKA64vHAMDg7Nr
	 Mm6abKNcPFkn9OAowx/ANe03ryQfz+QhbOZuIh4L3g29CdFWb6hCAFHdPRGmuG1YRp
	 2foFg4dbOA945CISdV7yFWL7+AjVIi7rVkhfgG8RuRocFoPgioIj2c2voV8ADaieDw
	 OGVeAfvdbY0AEXzkq4mdNLNYlXlm/PsyzlqotmbuCdbMGjsT9jHg1PO3IBrgSvWhqv
	 1/dKHQpMwP4bw==
Message-ID: <sashiko-outbox-234216@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 00/11] perf tools: Enhance namespace and chroot
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261125212851.1792988-1-namhyung@kernel.org>
References: <20261125212851.1792988-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 21:52:51 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 11-patch series:

- Patches 1-5 and 7-11: no issues found.
- Patch 6 ("perf tools: Verify thread status and mount namespace..."): 2
  potential issues (1 Medium, 1 Low)

A detailed review has been sent as a separate reply to patch 6.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125212851.1792=
988-1-namhyung@kernel.org
