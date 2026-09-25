Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA3F4C753C
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349293; cv=none; b=G/89e26M+AhyMJ11PQaJpLb73wNqUNyhEsDcsni8mrHF8Sodb0ogfdHjTQBtkLBEwrZPkEv3xlcIZczmqzWcX8XoVgdYsF1knyK3coVRQXm26X+SBdutwVX8sbCRzwSSMFucaMLGz6Ba8+T9+3g99RPtIbPeIMYCA/wyNoUu8vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349293; c=relaxed/simple;
	bh=Tf9jFdO999IqEW7VYO3cobVk/Lqk/RW/PoFawOkc+ek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cHmoULd3kxZidAQ3M0HYQo7phCJqE+V1MtL+89AAIVNrFudx6yIag/29/ec3uAL3u2jCFH6s68zoB5QbdJfLS8LNhVGjQL16C5Mpjg+q58QLSxvfst/ToFuE0UfS9yPWcFd34bOS4MLJovhyGMpwJMdEQhaSjuzatp/JeZQbglA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brtabP/H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brtabP/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DA01F000FF;
	Fri, 25 Sep 2026 15:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790349263;
	bh=Tf9jFdO999IqEW7VYO3cobVk/Lqk/RW/PoFawOkc+ek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=brtabP/Hkq6JQxiIHqU4nA1lN+tuXpgn3vSfH2k49+3d5XY+Wt5QHmInegXR6Dqo6
	 a7qMKmV2vAFTa0DtR16GHqhg6Svvc5s1X/GFiAXIj5PbGxxi4z7pnnGGoBZvi0iqMP
	 M73l/iZ58RivCiVz/EG/EQyiB9Vf7k/vL/fPbg+R9tC6pz34flAlxuWEXW9q/Ubwfq
	 EW39/Bw0bBFNqM/9vHguGucqo9KoxMOu9MmH1zEO4+2/l+YPe/WZefAT6Mwxibo5oe
	 UU6VKZ0BpshG0vSXY8bkJlCDB2UCRhnIag+4JS/HSSqlvOVpf9SV5BErDaQYnAwp04
	 XvZw042o5o5HQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] perf annotate-data: Bound the member nesting
 recursion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260925150657.1826942-5-acme@kernel.org>
References: <20260925150657.1826942-1-acme@kernel.org>
 <20260925150657.1826942-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 15:14:22 +0000
Message-Id: <20260925151422.E7DA01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Members are added recursively, and a broken DIE can make a member's
> type point back at one of its own ancestors, recursing until the stack
> is gone; nothing usable comes out of nesting members 32 deep anyway, so
> stop there, marking the member as truncated and giving up on member
> types that don't resolve.
>=20
> The check is where the children of an aggregate would be expanded, so
> only struct/union members are marked as truncated.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925150657.1826=
942-1-acme@kernel.org?part=3D4

