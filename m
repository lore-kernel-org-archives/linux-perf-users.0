Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E3B33987E
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 20:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850812; cv=none; b=YNMuZNNr0KQNGw488QO7Tndqzrf9qkWa37TWZ/b0WovTAYI8uTx6ekpupaXRRj/zPXYjeDhav9BVFL69L3UzILXOZcLreUeXk7S5OIVvXki78cdZw7FbD6tRcYOc//0FzWigrhmeYnIMM7951k7ii6G36pLNPV0dUQlMxj2DTXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850812; c=relaxed/simple;
	bh=ZsLuqvqek7xecAeimTalz2COvzbXBUOTnRmI0gaKDK8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rODETEVM+NYuZEu0bpakeDWg93RmEPJImsi0iJN/oCD8q3POREr4vcIJQHYgC/ZL/Ad5+b9Oh4oLzlhcOPqbtalquAF3eJmMniveqoZyiTdizTlqHqQBVbs4mO/VOr71iAP9Zf0x2pqSY58eyF2iLvonjJLY44WFGqJ9+06Uawg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrverDCP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrverDCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631081F000FF;
	Sat, 19 Sep 2026 20:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789850810;
	bh=ZsLuqvqek7xecAeimTalz2COvzbXBUOTnRmI0gaKDK8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hrverDCPtGhKYwIKWIY97CQStEXUFlAJ7nPOBvzCPZFYuuBHbgtxDcGRs6G1VUuPH
	 dFig8ZAHyIIqJ1VwaskRSZsjedhUop3aKZgZr7Y7mJ02UinAubiwmkLYPWaNKVCSTm
	 uLOeaKxlPcSgDBRaeJ1cQgW4lU3mJomyzTuecbdNsNfriT3Y9cpTvZ1oQs4VI85njS
	 2TVRaQkdWyGhgns1qmriW2X1j4HvGJSFTbcRpDw+HX/xJxlqWI/mtuEJ5IVHfkeOmg
	 fIiAbDzMj3wBQ27fYYpwFqLPsd3rreZiOqNWD5oyER/9PCu4U2/mSirv2Yz1+Q5RHu
	 XI6KUYi7UjwzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] perf annotate-data: Bound the member nesting
 recursion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919204027.8504-5-acme@kernel.org>
References: <20260919204027.8504-1-acme@kernel.org>
 <20260919204027.8504-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 20:46:49 +0000
Message-Id: <20260919204650.631081F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Members are added recursively, and the same kind of broken DIE can make
> a member's type point back at one of its own ancestors, recursing until
> the stack is gone; nothing usable comes out of nesting members 8 deep
> anyway, so stop there, marking the member as truncated (reported by the
> JSON exporter added in a later series) and giving up on member types
> that don't resolve.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919204027.8504=
-1-acme@kernel.org?part=3D4

