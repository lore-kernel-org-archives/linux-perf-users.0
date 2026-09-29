Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FC43B0ACC
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 03:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653703; cv=none; b=ds2yN/6Kf10mveSLR1db1w50LMPjYyG8eakqT2m5OQLT4jitVkpdZ3rNUA5P8h42JCTDmZ81920vvnYZqjn+gWpx49Q7/TJ728JnorQisUxIFML4sYOsM0jDNEWF+ZgqY9chMyTarEexsO6EO4XwIbh5K14lzsd9QCjdbAUHgbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653703; c=relaxed/simple;
	bh=wL3z41kCH/1Dwi5Z747WsKlctJeOJADFy/m2OdDrDCk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s0YpKc6CbYVNGqUgpVzKcTTlFt5QPaSQZCxdG6TfwaHUKYYY04J3yZ+ol5yrQxm5/g4P/FIPxnCVoF20IemzUULBhwdih3BQwcaDdH6qXb0b/mynzsvMO4zIgY0FNYUEHKcZ35eTI7FGWYxDuX4lpVPVm2r4wtpX2eT/OIVBzc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBku4Jik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBku4Jik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000C51F000FF;
	Tue, 29 Sep 2026 03:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790653699;
	bh=ePPimuFv1q9OJywbXAU+hJ34T/GF40g39TwW9rcs4JQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hBku4JikO+i7WtoiNPnq6NS946ZPFgq/AGQ7hkiCs+12r6sCDXtXuwfV6jPsr1XIq
	 OMwJv1hGE2vpvqnuWZsHk715AV6Li0UnQqG+mD/076cAnGnX3SD8tuxOkhXupatqYL
	 /aECRAjhnhTpPq3j0utgtYNYCuf6xje9Siw9+BTBWsLd/yUcz5NHJ2PVjyxdTgodaE
	 he3mnmcafwuRsN/X5MELDioxkin7A5/oK//7LvskeKpOMi85u1acCa8Q9BhDcR1Epb
	 YlspMgNOyxqZ4rjIc3qHEVsKzCvWKngiHl///F361tlGz1lf8L2BL8NfgUC1R+Wt4E
	 kDXNzlz4pQ5EA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf tsc: Declare TSC support from the build
 system
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Pei" <cp0613@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929034133.2153-3-cp0613@linux.alibaba.com>
References: <20260929034133.2153-1-cp0613@linux.alibaba.com>
 <20260929034133.2153-3-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 03:48:18 +0000
Message-Id: <20260929034819.000C51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The "TSC support" subtest of the "Convert perf time to TSC" test decides
> whether the architecture is covered by matching compiler macros for
> x86_64, i386 and arm64.  That list has to be edited for every new
> architecture and can drift apart from the set of architectures that really
> provide a counter.
>=20
> Declare the capability where the implementation is, following the
> PERF_HAVE_JITDUMP pattern: an architecture with a usable counter sets
> PERF_HAVE_RDTSC in its arch Makefile, Makefile.config turns it into
> -DHAVE_RDTSC, and the test keys off that.
>=20
> x86 and arm64 keep the same behaviour, riscv starts running the subtest
> where the previous patch defines rdtsc().
>=20
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929034133.2153=
-1-cp0613@linux.alibaba.com?part=3D2

