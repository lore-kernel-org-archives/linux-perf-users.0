Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D424AC147
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 20:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108602; cv=none; b=iXybqP63crDSlKqyADuwYzcPADLb5kHamOQAVHi26XfQ5119gGh/b2xIbwb/L7itfRaz+QkLjSOc84KdH1AWkjLilmgwpeuG/t/v6P3iFoRwys+igJikgBnH251RLyrK5yX7LC2Un/BTHNWtoKjKz8Ya3phSd38LFQwqaB4/nxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108602; c=relaxed/simple;
	bh=dBqlF9i0/npK5rQ2aisbDliVIlI49Sw0OTe5758bzNI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l5GkjqFG0bLuBp/rJM2/y4gFuwuzDNfvqtLFgUI4nJEOikOy1Sfs56WINlQEB9+VeREenqGh7hLDN/FUzPeplhOYWa/SYGjRfIu6+Vpy9NQU7QnpM8f4XHPG3bgeS43+zwhJYUT/GewP1wI2z0Y43Lw/j5BxczJQ7TEnRzeWEn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cd0Ek9uR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cd0Ek9uR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25AA1F000FF;
	Tue, 22 Sep 2026 20:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790108583;
	bh=dBqlF9i0/npK5rQ2aisbDliVIlI49Sw0OTe5758bzNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cd0Ek9uR1xBVHMhn/rn+brHXuStaINCcLavanToRT2gpyaEnAYdTukUxH36s+Emy1
	 mxmBqVxcej5DsUmm/06e7dtLF23xIZL+NcL6M69qadfuIJdrkIL1wJijqEY2BRzGtw
	 WuZjVeGyyyG80joAlW4kjbzBgScZZOYrLqAmzTsbRP3F0ncNTW+sLLmv3bFO0Ej1qM
	 penCQIw06GDPkIBYCzSXoTk9WffbuQGMFvR1WvDCyLC3jkIZW/Bf2qYjRVmUOPkpEV
	 Sbru0MSgLthBpYFt58Ipg6YBTeG2oXfat57qIDwnURLT6hOhrtyMMpVv/p48FnEnuh
	 AVoM1KGk7/EQg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/3] perf/core: Let an arch prepare the user
 stack before it is dumped
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stian Halseth" <stian@itx.no>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260922201507.1719668-2-stian@itx.no>
References: <20260922201507.1719668-1-stian@itx.no>
 <20260922201507.1719668-2-stian@itx.no>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 20:23:03 +0000
Message-Id: <20260922202303.C25AA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> PERF_SAMPLE_STACK_USER copies the user stack as it is in memory, which
> assumes the whole call chain is there. On sparc the sampled window's
> %l and %i registers, including the frame pointer and return address an
> unwinder starts from, may still be in the register file: they only
> reach the stack when a window spills. perf_callchain_user() already
> handles this for the callchain by calling flushw_user() first; the user
> stack dump has no equivalent arch entry point.
>=20
> Add perf_arch_prepare_ustack(), a no-op by default, called from
> perf_prepare_sample() before the dump size is computed, so an arch can
> write back whatever part of the user's stack state it still holds in
> registers. Doing this in the arch PMU interrupt handler would not do:
> software events such as cpu-clock reach perf_event_overflow() without
> passing through it.
>=20
> Signed-off-by: Stian Halseth <stian@itx.no>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922201507.1719=
668-1-stian@itx.no?part=3D1

