Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656823DB311
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189363; cv=none; b=gAMUGk43N6Q2I8FeSsbJ2tqAxh/E02SNlfjaa4CKQv+VWOWm33Ub1i00NI5M9yq5cHxEuskhbsB5u3pD5PZ8R3iyOXLNK8lCEnEtgD+nr7B/Fvtyxy+v8Ryfj6t9Nf639O+abavi+OkAX8A7J0XjtwogNzmkCCzeML7ShdkWNjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189363; c=relaxed/simple;
	bh=mlS66ADCbbmh0XPau+u7c/Vl5OzzhOLIdoa6bQ3Z6pc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=W08A66AsXL+Jks3jYfC7+UdplNK85gRdGQKJNqGUe9bASrwH7cZ6Y3wtgCdfBqnEMuGr1COEaWeLn5+inWMFihILcUipFv6eBr4ZL4NNcVykir/RYscvkoivQi1S5cMvg14Gd1OFj1KTgqNTO9Tocbwntll5obeLHE3A+pLSP08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVBFBKRY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVBFBKRY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCD01F000C4;
	Fri, 16 Oct 2026 22:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792189362;
	bh=mlS66ADCbbmh0XPau+u7c/Vl5OzzhOLIdoa6bQ3Z6pc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DVBFBKRYOV90VEapZUYKwNgryKNkA0poqPRL0jn4i8X8lWNGwGU6ueowQCzyOhjsI
	 k1f7HtfRhAEjoU/armZKIlQLxCvOA2Rc+T9HFj9zLaZjPpxZ1IYl6CVls22d3xXyWY
	 CSasaMh1Qojd8/yNiJLdQZDqeILFWv/gA/K2ELuAM2AJGCXcCAIYMGPqRhYopRjR3V
	 Wq4Njf+nKXRLwz1ccFWqm1e1VMENlXMlFAimAi9wIcxGUoF/Xw/staZSyAdv2fd5r6
	 7g62py4qndwTg0VYCFwGWpoSDEXGZTlFmWnU7OFSKYgi0BLSEzLh/PJZAHCk0MnIcC
	 zyDBRw6yro/OA==
Message-ID: <sashiko-outbox-175010@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/17] perf build: Enable additional Clang
 thread-safety flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016221700.1282659-6-irogers@google.com>
References: <20261016173106.679725-1-irogers@google.com>
 <20261016221700.1282659-1-irogers@google.com>
 <20261016221700.1282659-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 22:22:41 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Align tools/perf's Clang thread-safety flags with the kernel's
> scripts/Makefile.context-analysis by adding -Wthread-safety-pointer,
> -Wthread-safety-beta, and (when supported by the compiler)
> -fexperimental-late-parse-attributes.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016221700.1282=
659-1-irogers@google.com?part=3D5

