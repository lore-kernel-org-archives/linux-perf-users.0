Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795757251;
	b=n8ySwoNGdsueRn6PXhEg2nEgcHBL6LnEFYDAYE4fmF3vE8Owfl2go3jSleri7kHiA780
	 OEzScP/6ZdKHb0jrTgLBW1q7NlK0fl38mV6E5xK5OkarDof5eqaHCrj1zeFw4mG7C/2Ki
	 /d6fI+RE9/T3TzAa0y3HZ0er58a2muaRcooIS0SQ8ytctNyfQpt42FNa0K1bciBHPnhiJ
	 pUzNWp5IyYr9BQxcsn7UCEKQ3sQX1zlA9zRYJxLR3J1I8DSrIK35Crt39HjXjWCpzQ1me
	 JTaemCXC1zgiboRdFt9/9PDbY8kEtLUeA/lW8vAE0AD6pkzwhBg6CsqjoF0u6Z+xZuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795757251;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g3L5o8UyhbKykfnvCL4x4JyEA/L6orf+5sgX1INWD0Q=;
	b=gIh0FmsQT/l6IDNFToFrw4BE3o9n0PJknrGVka58LpJZBvC2lt9aL+e8br9o1J184G8T
	 xYTeRR77jTgBfbvR1560kRWnzuyvyULujQtHWBNwkUeh2ST96MgIAJNHglBoHQJy+atbu
	 v4Hs88fL5qOx7JCP8bJ6XKo/Ooyq92/NPXFY29zGu+iZCUkbwtg8IGkh7PdW2gBQYwoOn
	 sK4ExwBQ2KOjLCmGN1LZtCUGLkweqWDw2lro55MRrg3zb13Pre8VBe8mq6LAt8CVh8jMo
	 EZU5PLwpY3O6CMX1LlCk4EgPRHGfgp5juOWTgoIW0kLifuFC757N+FfuEHwIcuZBO4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G04M/rTC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AE1606A321
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 05:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G04M/rTC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3C01F000C1;
	Fri, 27 Nov 2026 05:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795757250;
	bh=g3L5o8UyhbKykfnvCL4x4JyEA/L6orf+5sgX1INWD0Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G04M/rTCe+VTOTKjAmFtdYjsSW8Esqtd0mB7sycxtLBcQR/hPAHJ0lf0WQZeTrvcF
	 /fKwAeNBLF51Z0kAuCMqUToxlPYY9dvB0CA+cN+Jk/oBmGTozlIi+b3kxnLtXbe8OI
	 OG1rp3PbMyjHVasfs5zui2jfZU8s8G3wIS8lmC2ZJsGTY1Uxp32bNV+xu+qhS8ayNG
	 StqvHbSpwjTdGNSF0C9fmuPU4bv2x9qn2Zi9nxGG1J1bVyriWmktTcKiSeO99aCgSZ
	 63nviVfeImcnz96DPXomPJGPwujJMNcqpvrqpTG5l5VJfSERL8YUhj/PGaPvcVb1zt
	 i4VNq2klJsW7g==
Message-ID: <sashiko-outbox-236643@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 0/7] parisc: perf: fix the RDR tables and add
 PA-8800/PA-8900 counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261127-parisc-perf-pa8800-v1-0-4f3f077010ce@gmail.com>
References: <20261127-parisc-perf-pa8800-v1-0-4f3f077010ce@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 05:27:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 7-patch series:

- Patches 1-4, 6, and 7: no issues found.
- Patch 5 ("parisc: perf: add a perf events PMU for PA-8800/PA-8900"): 4
  potential issues (4 Medium)

A detailed review has been sent as a separate reply to patch 5.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-parisc-per=
f-pa8800-v1-0-4f3f077010ce@gmail.com
