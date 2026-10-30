Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383024;
	b=US0m75r1h3aSCG0BqUnJtlP2RZI4VAdo1X15LlIKDnzpmUj0+N6c7reyVILd7cblDk6/
	 JPJ/OvydbpiclpImizoz9A4qQGidAEIPTdPCYV2D17nE0t6A9i6ybST67zDtZH2EtQ7wy
	 0Mk34ry0vO/YNSkC2JdtKA/i6Ux+3+wS/gFRquMcCyUSbjaFsVqE4GT09qaSilSAOp/yO
	 VPkyg7MfGjTBNEVc02mf/vQpLOTZKVt2sYPR/t9Dv/Xa/2eMqK6Kn7k+lM2/FJp5aMonM
	 p7GOmwJv5+hrPb2HcfwcHQ1o9r9AjiF9QgVAHa/LZAgoDrxW632CIS5ezqJpqvboo+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383024;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AbE/xJXLK7cFk4YcS6f6nph9/xlQ7Alk72gs0NdrYi8=;
	b=qVd4TobSGl4b4zzVWKQOaxgEU9i5NX57MHNTaBUerB0S+n18pmAWU/93K/fwDQIs0igC
	 6hgZUbkQyaWANZ/8AWOKr9OLZ4pkqJZo9fZUfoSNVAfYIHIGkPRWIdGV1g8KDJgwzcmZ5
	 fmDUFR3QhRqdZ9RozzS8GjmgzlMghA/KbAMX95yjWW1gPrk6l8VaYF1IhBBBLgwvxKW3x
	 mYRWjFJFL9GZHMe+REy5SGVjDm8wU4v1SNGHTMz93xvwYltdPeo8lfRdPRj729BRhifTt
	 sF+E5EOZ79vtaLwJ43M1TxtSJsrr6nDT0lgp2PCJj9Ouq8VWnGBSfu9WVMhg0qtIEcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kr6ksoct;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEC260A260B
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kr6ksoct
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E531F000C1;
	Fri, 30 Oct 2026 17:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793383023;
	bh=AbE/xJXLK7cFk4YcS6f6nph9/xlQ7Alk72gs0NdrYi8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kr6ksoctmANnyuKK0R/kGkSQj1hImSqqtmZo2K/Pz9eLYo5eDMyzPPvArVTtOCf14
	 4mTAn5VUFCfo3kxCYY5EjdMDhPFdC6SjuUxPzCJeZufopdrxBvXtW4v/ur6i8xqw+J
	 nAc1ZVBY4jfrq6Nad9HxPUB5DMoFni8do3N+YUtLJQR9zcpgIYuFs2UmdhrWYx6BRZ
	 hswp43lR9NHZc8ObWZdlEGje8LukOLr0wMg68XOc5yZ4DMZz4H379z+op1OqvitqBC
	 J0WMHqZVho33bFL5IgW5GhRrOfDtDkCKeTAVHnPpgHZxH3vLbyLOtbvJGXkJd2hKkf
	 owPpXkdxYYhLA==
Message-ID: <sashiko-outbox-191378@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/9] perf jevents: Add support for NVIDIA Tegra410
 C2C PMU aliasing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030174816.1544471-6-bwicaksono@nvidia.com>
References: <20261030174816.1544471-1-bwicaksono@nvidia.com>
 <20261030174816.1544471-6-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:57:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add alias support for NVIDIA Tegra410 C2C PMU events.
>=20
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030174816.1544=
471-1-bwicaksono@nvidia.com?part=3D5

