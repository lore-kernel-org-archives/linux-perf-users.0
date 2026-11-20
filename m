Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138746;
	b=aVI18WIsLK3XLPnHyRwF/8IQRhfnX1r/43bDI9Mqa5uVUxus9sc+iw+bx6siOFHPSIxS
	 eDoKR5sQmw18PY3SOjakb+RKraqc4/+kN8fC7Mp19TW0X35qzRpz/0qeGBGMN7w+18xtd
	 /ovh0DBQerjnMyntWodnE2UuS9yOteT5DWDkMwWm/+srDIdzIQ91IRyZYXqGWsE+aeKPb
	 TLnx9o/Vndpw09T2fzybOJ6gs9/yQpFuRtB6mMED2/iMnwdQHe3SdmDpfNj4x+3pFmip2
	 o9WMR2X8oGm4xLh+k0uuFfTr9tMCbWmJRWA88QVLUXdgCLB8pBPl4YAoqB2ZIWGgL2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138746;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=87MO32GZsbGu/gvVdfTnJjgqtaV4h5XBwjTP5PL39p4=;
	b=ei87I+cmOXDQ2aCefcFEM5wNseJrFOCPuY8U3mdt4MNBmJW81uIFtNoSKC1ZeIbthk2C
	 b8FA7IpcNeeWXWI3J+Knc4IYariMrszj1pBhQbBhXylbQNGtQX2rLrP2TGDtylvWITu+S
	 2ORP3opq9S8IeXfw+Q2/9vdK39msmytNn5cpBOcY2ZzqaWzMD86xd7P+76aW7GyYyfp5b
	 rCHDN5EoGfrbeHP5tm9o3cmU90IdEINXXX47e4X7hcf4FD3wpNNhNhSoNOeudB2ibjJXy
	 YsqSnz6q9rj2VZpT6i+IZGUhvTVd3o4b+LvTQdSmZkxCKYVNEGWyZsTpYCad/cGTGBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Htc0yxZ5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DEE606A325
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 01:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Htc0yxZ5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2521F000C6;
	Fri, 20 Nov 2026 01:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138746;
	bh=87MO32GZsbGu/gvVdfTnJjgqtaV4h5XBwjTP5PL39p4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Htc0yxZ5VaqFjc5IsZeyMU9oAodQzp5HuUc8X8e42rYEDd2ncNS45IHyt/eQAtyyS
	 FX6Ipaz4rYjVecw69i4XYq45n38RIJJ30Qj2GFueTsDdwxH+puo3YzXqR2lSXjxxI/
	 eHR1f04ZxVn7uETttR8JPKuHLZn6xFI/qBtfV462E8M9BVdRYoIF7z7sFGo+WO0J6u
	 piJPJHf0u0Lpi4K6GSLCYNhT6gb4w+Dgyb0UXDydHrUoda4ebP8LAM0l07KfZrgXP6
	 MALPASxDPLhavf5eBrU0jSJh6Nk6/pesq+aPqhNgxhunwm+6IiQjJ+wrsunXCiXqFd
	 POt33tp2O606A==
Message-ID: <sashiko-outbox-224329@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/13] perf tests: Exercise data type resolution from
 a register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261120013211.1510-8-acme@kernel.org>
References: <20261120013211.1510-1-acme@kernel.org>
 <20261120013211.1510-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 01:39:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> At -O2 a struct pointer lives in a register (with DWARF describing it with
> a register location on register-argument ABIs), while the unoptimized
> workloads the data type tests profile keep their variables on the stack.
>=20
> Add a regptr workload with a noinline function that takes the pointer from
> a volatile global, so the compiler cannot constant-propagate the object
> address, and check that its three member accesses are resolved from that
> register.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120013211.1510=
-1-acme@kernel.org?part=3D7

