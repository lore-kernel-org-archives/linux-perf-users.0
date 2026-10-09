Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCB739B944
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Oct 2026 03:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791517334; cv=none; b=Edg9hxovk3LGDKBbj8dGzR/hCMFVDcI8tyBGpa8IaGPHYK8n3WkUodmiazUCBOUKmXOlj6su9bp2LG9yRv98KEF9zeqqP8eHhw+AMXUSPlhkhWsJJ9/gQphCxjj3gLDy/HCW7tGvW/KkswNJUmbuWpT+pOlymJhiesHn1TnPdcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791517334; c=relaxed/simple;
	bh=H+1LiaMVUbWHan40ERfhYAx2md4DMOM54CU0x8Jjhqw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=s3pgBlnyDxsE2UZzgBVuWON/22O+AAe43Y+XXGUzP9rLdC5tDudPdEDudr3j2mU5ljcTOZRQImBB1g/hF7gNgDDj/DaPYCCrDldLt8EhtNQYZNxpvzOX+iUD3EEGliUy2KkycFvOtJ3reWm6OTtJlfV8hKu9/RBvh9QDz19EMV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hL4gM5zx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hL4gM5zx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9583B1F000FF;
	Fri,  9 Oct 2026 03:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791517321;
	bh=6l9Vc0lMK5IWBuJa0GCz8jL/vaZg2nlJrBKgw1fjFuI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hL4gM5zxOg66pJBVyiKvGbTcBmlLFSa0WYQdDn976a0p4AYLiYF5KOuQ8cVknF43i
	 sOfrejLzBxedCRaE80xLztMQ4i8eAJ9bI7pmrENlqUxfhkc+jTQuqeBZ9i7Mb2zsuv
	 +pjMPZMoWlQMZDv8cbAk5NPBIgluJaOV5a3RZjD04sdLL5/OwHl2X3jCNO8xpO9n7N
	 2+gdFmi9mU1Km6Ku4h6Q4EXaCdbCAKPHwis0hTp2mKanF72ChC5s6nmAk1diKIq9En
	 hxQNNu9RYCeqeciSKnFcp0zxbuG/mcK0qQwhHjUE6n/mGq+JsCbb6wJD9D/Y1Xn1tX
	 L0/8Z0TA+zasA==
Message-ID: <sashiko-outbox-164784@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] perf tsc: Declare TSC support from the build
 system
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Pei" <cp0613@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261009032715.2841-3-cp0613@linux.alibaba.com>
References: <20261009032715.2841-1-cp0613@linux.alibaba.com>
 <20261009032715.2841-3-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 03:42:01 +0000
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
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Paul Walmsley <pjw@kernel.org>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009032715.2841=
-1-cp0613@linux.alibaba.com?part=3D2

