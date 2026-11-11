Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426865;
	b=RBIdL4tOi0MfSBWXx/V0zmLB7klIp3go3p89GWiKmL8epClVe1dUtQTIR8OS7l3WQuiJ
	 /cKht++a+BgulEEAs6QYn3t0D83iTRypxVB39rO02XA+AjcVNv3rFsnth/3iACxrM63JV
	 0xMI2jkQR/L3qo3k2JCutKUKEJm4TV2jFx7wr36XLry9VJZU4KetRTxlVqPe/L08DtuUC
	 4lANLDFDfcvpNZCZFVbz50SLqf5GmNzGO+FP+atnzFlnmV80CWxV+v/rLYYbcoz0/w2Rz
	 lqfrVwdnW+YgmJZQWYPplmwy4tm0h0HWYCoVWTJf7YuONDAeOTQEoaPXQkGPiUrG4Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426865;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=unPnIt7C2M/LGnLXYVJgMvHWMcjbHxtCQjnZD5UwxO8=;
	b=BPnwu1F6AWZx9zvO52HqLodUd9Zf5clBh+jrL5mmAobeRhLXmkYo3PU2nCH4phYt1jWQ
	 ylePc83fvVv6/S53++kzdhA1Xgddi5WHv8672H+ik/heMT+MtVAmm4tht7IDIr83f720l
	 Z4iVgZQEd6tJ6tESxq512SHf2nDcASzKAFi60bWCPaKGqDFDnFa9p+5VmJItTuhvGIA/d
	 vRTbzvGWJzeUD4/l5PpqEIsjq16pcBkbhP8Fwrg48IyiJy25FZEeG5ezXkhPfNja+FY1T
	 3J7qQPBZipK8R/a8C17VD1ZZYFpEqDzaAtPeWvHInBzCedIR90ZHkwSLaYFSgDpNF8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPo7GCPy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5E3606A330
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPo7GCPy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB781F00A05;
	Wed, 11 Nov 2026 19:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426865;
	bh=unPnIt7C2M/LGnLXYVJgMvHWMcjbHxtCQjnZD5UwxO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FPo7GCPy3bQv0+juARwMlhCJM4I5o7nYtOeRB33J8Am9VaeqdsNIEX1DPYJ+T51/h
	 HjmqC7s0QNKnSHNOhyFTOSmVovv22NJMv1MXTSGTzvri/8VqM8xBvHGqJlpdYRxrzq
	 u+hMrCvxnMkb9WLUh/kRPAB3lc3zhA2rSKzOz2prvZdgQggWnRadPdMaK+Jc62shUa
	 B+3eC4QNloMSYK6P24PQDr3Y6ROHaAFbe0VP03kLVoehhnhHV18Ah89IU3RX3NYXJC
	 H4ZCUkhy91ghowqL1PPn79wlVhWqAA9h7uuk4mXtZ3dydWIA45hqLH/vTv4f5FXUj4
	 2lo4SSUChNEyQ==
Message-ID: <sashiko-outbox-209596@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf record: Do not fail with an exiting thread
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111192328.3917311-1-namhyung@kernel.org>
References: <20261111192328.3917311-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:54:24 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When a thread in the target process exits during the synthesize, it
> can fail due to the missing /proc entry.  So __perf_event__synthesize_
> thread() ignores the return value of __event__synthesize_thread().
>=20
> Do the same in the perf_event__synthesize_thread_map() too.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192328.3917=
311-1-namhyung@kernel.org?part=3D1

