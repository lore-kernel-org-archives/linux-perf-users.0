Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114582;
	b=UxcoCe+CcXAonu7xTJ5cMvUFSe4inZiP8XAMpQ3J3bgSoz4XCjf7KjkU/B7Y6jG/BMC+
	 T4STOvMh0YaCraZhte3fLo1cLy3IvHf40p5opWnDgqBC/fuaWuE6uU2StQ+Op+ANpSec8
	 X5kujoSZMGe1z9P/RkesRppLvRlIeOadCTWQRvudtuGgxyFMdN1upgLq9nkszJ3RS2P1Q
	 6r89o9Fryyjt1GiZuKvfsXSwy/CXRKculk6GGb8CINyDo9pL2x106FHNCnYduCUQiPb8q
	 66T8KscRoDoVqhbgnMT1RenFkTZiUjJyFv6/0a6PXVKa3Ggo95lYnv5f/qwPnXybP3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114582;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l8+mQwo1FMn0zmqHCL01yIakFIBkEl/qG+F4ApzfO4E=;
	b=mDI9Kl/6jeXkA3bNfuEWPUnHopWW0GT3NRzJg3+jpVAWGK+7taS7jT1o5wkfR+72nddk
	 sBwMJXopfkIM//3dPh6tvlOW9QydupORG/rv4bgtPZYlJVogrRxuNx3prfanDE8EtWRAL
	 CuCDQO5yQ8fvpIVUIHy3s51enii3sh/86YoGOreYUsUFoXes53fqwTMF4xB8RsI4E124M
	 +MnJsaVAcqoocfdDK4QwoetYG4VnL+KrorBmKJyU9uE4XDm4VvmW1L/mNuvLwUWoAVJT6
	 ZkyDqtA/ye+tBH0WLeJgXPAISopezD3FfTdr7XWqG5oRmwHhC8GHe1v3t2jukZguxRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F/Rfv4ml";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B585F606A32A
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F/Rfv4ml
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CA01F000C5;
	Thu, 19 Nov 2026 18:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795114582;
	bh=l8+mQwo1FMn0zmqHCL01yIakFIBkEl/qG+F4ApzfO4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F/Rfv4mluHUjixjeOuDNI6qJJ5gQsERIG8wljSfQ27EDr5vYr7s262nZKarJDcOIj
	 BLqr3nGpaAzj53ww2D0sSqPlg5UVPW4F5+DhgmKK6wQAeYS9vUUIIS3JfEKIMeWvZ+
	 feb3OGBPBiFfj5P8OOzjN9O7TjFhlOWL0VVrwSb/VfezmkSb5zZutucp8SvGbX2gBa
	 nYvoWYQKb/Y83NO+e59PHoqXlGZJFGFSNGOZgN78bAOCHlQm0U/Dn7G2uPaDGJed1j
	 qf7pQRqBRQyunLB+89mrfQBYmJrRtJEF7RgpHf8t/l3zbcJ5w2tr9Pqr7peO2nBjuA
	 ts7rVQN5gmnsg==
Message-ID: <sashiko-outbox-223810@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 15/33] KVM: arm64: Construct mdcr_el2 in a local
 variable in kvm_arm_setup_mdcr_el2()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-16-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-16-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 18:56:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Construct the new MDCR_EL2 value in a local variable before writing it
> once to vcpu->arch.mdcr_el2. This avoids exposing intermediate states in
> vcpu->arch.mdcr_el2 to interrupt or NMI handlers that may inspect it,
> and simplifies upcoming Partitioned PMU modifications to MDCR_EL2.
>=20
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D15

