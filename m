Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDB22E5B29
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787094550; cv=none; b=UHveKCUq17neXlfLTLeby7TNZ47ptYn0Dr+ih3F4iZsH/4ip4KuEDh5ocFhpxiBeTqXBfWEs/jQ2fVg9url9ss6y6jjtD8EsANY68KcDQ6KOHJq6TKYr74/Ryd28lg/sKE2nNPqjm1qteG6cNwyvtB+zrBRaIRapMdYe2ECz/gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787094550; c=relaxed/simple;
	bh=7B5syoWmNfxwchuEv8IUKHYFj75mpn+tiv9jAc4z330=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=btbeWcESJ4WSxfaqEdBtwZ4Tl9v9pIqzE/IPkcN/6UpK28h0HXb/ZK/kS2q3UFfvCuSb+Qg39So3OxjUsnOtjQook8u8nC0XMCxUYqwMVRzLhCBt/LvEd3ARPC6U6tLwbvpKdpm0vPOmknHRo/1SUNZmYLNQDsa/7aSGwLjbYaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJMQxS1G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJMQxS1G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0081F000E9;
	Tue, 18 Aug 2026 23:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787094548;
	bh=7B5syoWmNfxwchuEv8IUKHYFj75mpn+tiv9jAc4z330=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NJMQxS1GntFS+kuGlp+H4Ysij5Z2ZUlGQZaBc4aZ2dql3k/NImmX5164Zex1/T2zN
	 fqqWWUSkHVFUnv+/iY545YW8UFk5i+JKesppwalZhJ4EXPGKCvT1TPD7O+QDUS4CoN
	 pWqEC9ff1nvfLyCbLoeJPfv1E+HtqF4USqKwNRqLlDvdawoYPB4bwiRGqpBrfwTLAm
	 c87ch1/194z5TfUKvXnrfeqzQQfJz/FnJ2tFjwm5tgmmOYLq0wPk4QzwBLCOL/D2ux
	 Go7ih3isOwp5SuMt9Q+c/zbVOxcgZ0u4eBjq4EaWiLlWvcYEPXdvQFDgSzvvNER+GT
	 Wnz4cWZ9Q0k6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] perf tools top: Add --weight option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260818230229.1491871-3-ak@linux.intel.com>
References: <20260818230229.1491871-1-ak@linux.intel.com>
 <20260818230229.1491871-3-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 23:09:08 +0000
Message-Id: <20260818230908.8A0081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add a -W/--weight option to perf top to collect weights too. Useful with
> follow on patches.
>=20
> Assisted-by: omp:GPT-5.6-Luna
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818230229.1491=
871-1-ak@linux.intel.com?part=3D2

