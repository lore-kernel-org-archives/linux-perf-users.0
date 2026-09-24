Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D576415B6E
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269579; cv=none; b=sbb6eaZz1lRV9unjFJLfLgYWjoUXXvwEKTweUMkryRP4NijeJmRjwCKD2FdYXAsoD2rw0/h7++GjjMuEv8L77IfefcVR6AyEx3KraH7Z7+0UqL88eapt1aktgT/O0ZkRvJJrZ9iO9Va4QBJOz5NuEhugPv+qr900LiKLiEVoAbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269579; c=relaxed/simple;
	bh=3Yq7BQ+waB0Jp7R3aUPAtRPBXZ4KgMBMsG8au6ILHr8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iJd3iNzONFJxA3gXVUAm2v+LD0jN2xccZ7GHXMCfOIePXgcbUBVTF+d9+aMb3PeC+YwvbKD4I4ga0TXVfV5XsQre5Cm/kLVcNl/L6WW0b4908d0PSW/96RWMQjssIM+I1u5UbwLQJVwKwNJ2WnmjPbfbVTwpDZAGgtTS6cziGg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wj7+SKNK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wj7+SKNK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226E21F00898;
	Thu, 24 Sep 2026 17:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269578;
	bh=rytZxm9TPrRKHB4IpQr4q/HxFGqvvFFuuaE+gSxj9gQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wj7+SKNK2yFq28G94ITvntahV9SFMwn2SfWI3+xzojvyGFhM1gbA+7SIUmvJwu3dw
	 zlZslYlOndx7DNboeB9jB1PaA9XfDiUMsjB1j8aDsRUoT08Wt4Zu99UqO3PT3uEj6T
	 mES9nWCiPjLc4y2oXmq9DP5PoRqTm4GmSFsKEatWYVLUKBs5RcoUfEf3iKETUuMgax
	 u1eEZZ29H0Kyfv4urrkOtYeX0l6L1Ks8V1jHKV//rL+NAQMSqzyESToHbYEXsvp/lR
	 l7a4Q6B/IKDCdxH4HcaGxAO0b08ZD77Dw+c14CtovRy+xWQbr8PwInRCOlgGioUPnO
	 /LbFK873pCexA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/26] perf vendor events intel: Update alderlaken
 events from 1.40 to 1.41
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-3-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:06:17 +0000
Message-Id: <20260924170618.226E21F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/5d7b37d5671a49c72abf735dc81d147=
c7776119c
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D2

