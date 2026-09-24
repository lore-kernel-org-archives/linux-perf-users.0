Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892F840F73F
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285750; cv=none; b=P+fGegrrGhZkesKVi9K8cAvT8OTzCVPUcuD76KyyUJz9zgGEk8iJt01JRvHHrG2HiSoHKnuY45Wqthrro0OuNmKQG80hpn3DRx7G1/de5DKM3Brnyp9igBH/KvFVRkG0GLEnwUn6LNiyUZRUbA18QeMmHa8Ue/88+7dIA7FbpHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285750; c=relaxed/simple;
	bh=kBuyN6/rnM03q8JmFTC1jUq8+91ADHgIqi+XGJRWSfI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MRHAIP1QLf8f+d+lTLNn8C2umetJBPh8vDGu/W2upkDnldW0TllEbIMvUhdLT1U481DcGNZpEN2Rk8zATrOVOoP9NdaApBF9DpLHL4sRE0hO594wvCxJXnGMENwrom9rrDeF6y8ZAiMdW83HY+7zdun3LQlLQOq8rZbMY9ni5Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijnoGhED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijnoGhED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155A11F000FF;
	Thu, 24 Sep 2026 21:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790285749;
	bh=kBuyN6/rnM03q8JmFTC1jUq8+91ADHgIqi+XGJRWSfI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ijnoGhED76Pd/sp8cB1UlHw2JCGne3PFh82nOR+SwkikGVAbNCfArWuJApWVkWHH6
	 GAYx5cm8z3dx19rGMXUk/Sve0XPSZssCioXEeAkcKWhhKjrni+IpnD5JyqJpRhXzXv
	 O7ikK2HZa35yDNuxmrv6jxrEpkoLvJLtDbjKf8JB3JABr+A+7KPwLbLw5dhBvwxDVl
	 RDtiApMMC+zzdonKj8T6FRyexSvm7paAt9LI3KBd7VI/Cnuv8zqrRtE9MaPBShBucp
	 RBC/o2tjQF0fy1A4ayWbkpDyNrAmKE1vejRf7e7SBoHtlaUvi4o+SUwCnBKWgfoLGJ
	 uaDtzZeIhsUaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/6] perf dwarf-aux: Bound the type chases for broken
 debug info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924212809.1733663-2-acme@kernel.org>
References: <20260924212809.1733663-1-acme@kernel.org>
 <20260924212809.1733663-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 21:35:48 +0000
Message-Id: <20260924213549.155A11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A DIE parsed at an offset that is not the start of a DIE can have a
> DW_AT_type that refers back to itself, making the typedef/qualifier
> chases in die_get_real_type(), die_get_pointer_type() and
> die_get_typename_from_type() spin forever; 'perf report -s type' did
> that on the dwz compressed debug info of zlib-ng (libz.so.1).
>=20
> No sane typedef/qualifier chain is 32 DIEs long, so give up on the type
> with a pr_debug instead of hanging.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924212809.1733=
663-1-acme@kernel.org?part=3D1

