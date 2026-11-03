Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738514;
	b=ZpqN1MMoQ+OnMSZp3virIR9Kyw18t4BCDwIyf5ODQ+4kSXzdp/oF20lKur/SaEVYyQGV
	 jaIebvT1VqvWIbTjqGV8DfyZ3sAkhFTMJNEJNcEYpvfHNZqbYCjsUTZaWLfpijZ5pTjkQ
	 OUTMLr99R8yPRb8Ctmzafr34rVnCBEZlXkpLDDXmpSetCNKysU17EyVzLhMdUnul+X7CN
	 i7lfgUtWVXy7fZ1XoyntTIrZCjLvCynsxeAEdM1F2Ts/i3Piq+r4nh+67fHCRC/AeU7KQ
	 FjW1/AVMdzZ3n1/eewN4avBeFBq3hq9tgelrILfs/8nh9jpiSHjXLEyAPsfVMWCbVKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738514;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TPgMUGSiRpK7d1BLv/kcMDHY/ZLsWAWgrgvGoAPbTL8=;
	b=Ectzl5kHor7on82eJCPMPSZ9Z+Mklbw6zqf1wRuZKY7KNJQ2PnDfiltozeIc6K9SS2y6
	 E/a6G2EpjIysHSOEBd6P9QZFYPyEFF3ZFPNo5UE7WI1c8Tcb6H8Hg5rXSm5daQBIU25ji
	 Ps4z5QztWml4p9+GioNTVBq4HKKgoC4m2q2M2T6SNSeVcH1MYXrtIPnp+oT+E/8snct2k
	 dkub6VdJnwUuHDwVRVWa0vCSupdJKia1PUy/ohe8qieTGZwP12EKZxbugIDVyDTcptUwM
	 TK869mXpwmygeEG/0ommkL3TJMUAYVPqBvYCYBZmsdY/u3UZbDS51skrBsUYaFhzJyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I7ja1kK1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FC0606A31B
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 20:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I7ja1kK1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3501F000C1;
	Tue,  3 Nov 2026 20:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793738513;
	bh=TPgMUGSiRpK7d1BLv/kcMDHY/ZLsWAWgrgvGoAPbTL8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I7ja1kK1OiijmWhmEFBRHq92+HdhoWhaOBDhdA/QNlSrilet4zAaD0QaCDWYKin5n
	 N29qm/maBu2YM7xjPtfiaG/3PemIu5Cg1wLO6fH43ttAUsFGirjtI48dMmeHW3MohA
	 pExq9j0jOlkQAlVH4l9wHihTu6x2cwDYWfTHGDQWUl1/SOdPfKjozagReAWqt7ox+P
	 a4bGHLoSXEYs4c3z/oA2TNTJgG8FsQ78bPWStHw1NnEKhdKeTBwhBaI5aaZjkB8sRk
	 Q12v7bXz8/5OMmZBUGBZ2Zv7t9F1QYmSmHzR652/wW6zawWZLI0ZRqWzIUfDSb2Ayh
	 QD7dVT99FH3qw==
Message-ID: <sashiko-outbox-196003@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/11] alpha/perf: report the ProfileMe window count
 as the sample weight
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103-alpha-profileme-v5-8-bbe3937fbf3a@gmail.com>
References: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
 <20261103-alpha-profileme-v5-8-bbe3937fbf3a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 20:41:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> What PCTR1 counted during the ProfileMe window, the inum retire delay for
> cycles:p or the window length for instructions:p, is only available in
> the PERF_SAMPLE_RAW data.
>=20
> Report it in var1_dw of the sample weight, which the weight and
> local_weight sort keys read. It is 20 bits, so it fits. As Alpha is
> little-endian, this is also the right value for plain PERF_SAMPLE_WEIGHT,
> which is what perf record -W asks for. Samples that fall back to the
> interrupted PC get no weight, as it belongs to a different instruction.
>=20
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-alpha-prof=
ileme-v5-0-bbe3937fbf3a@gmail.com?part=3D8

