Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661880;
	b=o9rbI0sY5Lybi9P0Ua6l8bsybrsfSA7GCYUVPyPWi7CFxL5H05J8ZcnilbYhHuc3T6n2
	 KWCTmVr4dLNjbJWmRH64j011gkBsxO8lFAebOC4VhE72kSf/aoyhB9U8jFwYB7jid+JhQ
	 U+aF+er8bjjl0cbfZe1JBmHTX1R1e3M3JzSOrVu48E/Af002p8SzArSAoIr8TOsfUn5i5
	 xkJKNXQZGuj0TOmoNbOIgs6eR7Ox+F298FuXSFKolXpTk8PSMr5CiZLFKcRiv1pTR92fA
	 oTiplNcVc2nkPxiTVnb95c4cOoJxhmdHV0tfXV+F4fE6UIhHQ+rWZHhCz25g7LRNIyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661880;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mzEa30faBKS6t57JgR/W9x1Jd+nbKlv2SWUAisrTSUU=;
	b=bGIFytzQjcgAqrglhS481J7F1gPDkPQ4u4UNHjcKdOCNmiOOWANFSx6tSDwgLxI/GqnJ
	 FtYMzfjKmJYWnnKtttGE0sEdFWfT9R9rVznmY9dBl7K0/1P9H90GEelS0vAX7N/JMrIBo
	 JvXsXX6AEC+ewwQRsxh62hRETWtHAGTmCcapYZTH9ad2sljDhsPy+1XPzVMSWG9tYp/Jh
	 e9pJj0AaKWcWa+yYFqSZPpNGuUK12faunXLnj896vO2+2UnzFKNUhPpd0JI9cF7Kqp07Z
	 MadEs1BGkLesdcZ8/1XSpI750UEanzF9drV7IFvkakaIy6+DXgZxljQd+IPaHQs3Pzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UvQrfbga;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38F0606A327
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 23:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UvQrfbga
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C381F00A1C;
	Mon,  2 Nov 2026 23:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793661879;
	bh=mzEa30faBKS6t57JgR/W9x1Jd+nbKlv2SWUAisrTSUU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UvQrfbgaq3ZKD5AlSQed9YDygHyUaFBFZ80zXfBLWdmV5zkj3rzbJ8mrLbbklZ03D
	 Z+QQ/OEI54L0JOnAo48uDxnqVHa80+F+iIrwr/lLs/uE8GM0scwRJq+zZIQ/yYNAMo
	 mGQoHoxhtXeyZYH77dHzqhl7ruJeIAgsi6Ipl4UYkh0qRicrO+4hLSe06gJHXtgM5F
	 H3a5Q9A9a/Ip+b9LFDsAIV6PFJ+ZNDOJlTyjPPXyXtPGS2Ox3LybZ/+lcezfPVMtTP
	 RTlvXb+354H3PjnA8Z05kqGX3yithTbkvkyzoDxosxE1Vly+x3pYo3bL91nH/g/svn
	 vgCSiizPgnw5w==
Message-ID: <sashiko-outbox-194330@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: fix racy update of cpc->hrtimer_interval
Reply-To: sashiko-reviews@lists.linux.dev
To: "Benjamin Segall" <bsegall@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <xm26se1ihlqb.fsf@google.com>
References: <xm26se1ihlqb.fsf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 23:24:38 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Updates to cpc->hrtimer_interval can race with reads either in the
> hrtimer itself, or other calls to perf_mux_hrtimer_restart. This is not
> exactly expected to be a common config change, but it's easy enough to
> fix.
>=20
> Since there's already an IPI to each cpu to restart the timer, and all
> reads are with irqs disabled, just move the update onto the target cpu.
>=20
> Fixes: 62b856397927 ("perf: Add sysfs entry to adjust multiplexing interv=
al per PMU")
> Signed-off-by: Ben Segall <bsegall@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/xm26se1ihlqb.fsf@go=
ogle.com?part=3D1

