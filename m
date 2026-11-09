Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259145;
	b=vkWGnzl3TltPVIIK5AB91AkE2sePkbvnJjzFNZVDmLh1GKpeOGM2JOjWIayiIMzCwgA8
	 cir+uRXhh7N9MFoTzLrvKuFATVktORrFmAIQ5x4YyzmdbpPLBZaLIXOR6EarPb3dBi3lL
	 fyRiMPV6KC9G0PrBWYboSiy7jxzqXQxLrYdimFLwWyzPapKxHVQzowwIJUt1o5bRjsM8i
	 wHJJDHLT1ijZxHTAS0lG2rJ041IjP0Jt/ka4JUJhSrZxf2mviEi/okyI+NIYabmiWOcUO
	 CYPMdS7PeLyxPHIBmGIFelrEI4loI7cnwP9MIDLoW/3WDTtZObPRcDlh8q2qW07jd7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259145;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eMdBVkn8QI8/DIC0h/rmCVvLnYShqlIKulgwLgDOuNo=;
	b=H0ylQ6eVssRr1w16G+FS9+OSKbXTeHQyY2ZeZ09X+L+qkQ5ORRkZ/Iwp74CTqDKRAlxA
	 qejQ3dvJEFVXWseecLTSXV9pipWOkmPVF7FjN0PM/FIR+0gD5q3XLqV/SJx4VsfQgeXfA
	 XXZo9VLBiv5Wmr1DI5/cRlJSVa4G5iX5d5/iyB4FBZZK3CFj5tv0DFVATuk8/QKbgvF1s
	 T+iFGBKbJdngUYqOtRbQ0lqz2g8+R7xwaORl5pZ/lRG6fywMFw4RffI1ITEPD3pwPjHm0
	 x8triMuzVCOQEeXE0FCbn8KstjN9f+KjHF93n2AP5elg6RN2ZDAT8L+BbYqSqLBiK0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czcHekQV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDCC606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czcHekQV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCBA1F0089F;
	Mon,  9 Nov 2026 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794259144;
	bh=eMdBVkn8QI8/DIC0h/rmCVvLnYShqlIKulgwLgDOuNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=czcHekQVb+nYiqnoaWLKCJZeUhaJ8VSoCoX1hiZJTKUyNEJv+OiW1wmGSqnEeE9Rr
	 mCBRfMESLjxPTRNtZVAua77WFHqZt6K9yAT1hom5Aa3biOZPm9adz84p4V1aCcL90x
	 SN8wdLjXniB6VXBAXMxiM5Lm2PefmqZUJP4oToxq4aXmcJedTVG6S8JU1z5H7SOzhg
	 lDxifXfR0peG2O9n0zSOx4UNVThwGZ7Oo6kAMxFTj/ZlPltPe0Bz0jSIhYAneTMUz/
	 R4q/3bXZ0SzTsw4HUNftHMYKfJGTcr7kRuEoWKXtncPIG8t99PkjWGrNMBHzHE5FqQ
	 0zQKiMkbJD4jA==
Message-ID: <sashiko-outbox-205662@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 12/20] perf dsos: Use read lock fast path in
 dsos__findnew_id()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107044102.1506626-13-irogers@google.com>
References: <20261107044102.1506626-1-irogers@google.com>
 <20261107044102.1506626-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:19:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In dsos__findnew_id(), try finding the DSO under the read lock first and
> only acquire the write lock when a new DSO must be inserted or an
> existing DSO needs its ID updated (checked via dso__needs_improve_id()).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107044102.1506=
626-1-irogers@google.com?part=3D12

