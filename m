Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A4368296
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621244; cv=none; b=q9LFGtR9RvTNFcl9+eLWLV/k6N2qIkWGbhweCWeOCA5uukpbllrnaHUfAkF1yYF95RnQ7gIR+oJrtnIdA/jXT8NkF/vTAANRiCRp0bMcTK1BWQdF/dt0QisyvFJ4Dn8f8CShhJoFxq1lriJQypP1OyG3ik7v1qUcumFokOPcXHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621244; c=relaxed/simple;
	bh=xBOoEe8Y4XUveIM7LBxqePLdkD8s3OMtbxPFKOdt7KI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lm2WzcCzBTGoqF5OJEvy06X4+szDWFeq53yAaXeFXqfJd/wiTXV0JvtvW728zo4vmp2/PU7GcEYoX0lJonv441gTkTBD9dqQMWhSm+qz11/ZHaJe633ddf0XHzjJGpYuCwZwpS3SFn8QZ0MGH4MoBFVFHXMHFE32rwF3cAD4wPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVwxQ/KL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVwxQ/KL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A631F000FF;
	Thu, 17 Sep 2026 05:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789621242;
	bh=wbsy+cxCE3E02mkIxxUZG/vuT6pT+R8RKo5Z/9pjKw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CVwxQ/KL6/tykmKKibPuw0UFAtTd/6GhUnRjr5hJAPefMIX5rkJ9nGOaXkj7d+YkO
	 N25LioBLCg+N/szRZoMDYXs9MDQ81PXt5rjyB/wReUIIJ367NBELEoe9wgieftkTO+
	 g1CJwjrP1UNsxAD30E+oK38PmNB1FUYL0mT3phQ9N/FkU9uaoC5uqoRcjqlzjTStVb
	 HdVfoswzwQZtvJNFBIPiWxMCHW/p1mTJ0c4JMjjkEcuEDV7L3St5ccU4i2R1GJFBsz
	 yF6Hx/zD7rd5N0klEFmpZ77c3ximqkDNmUPDQ1VDzQRohbqPfsmMYanW89HJC1NpUh
	 Lqes11sRNP0ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 01/11] perf aslr: Add missing includes and sort
 headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917045326.63601-1-irogers@google.com>
References: <20260917045326.63601-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 05:00:42 +0000
Message-Id: <20260917050042.C7A631F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Sashiko reported:
>=20
>   When building the perf utility against strict C standard libraries
>   such as musl libc, compilation fails in tools/perf/util/aslr.c due
>   to missing explicit inclusions of <stdlib.h> and <string.h>.
>=20
>   The implementation relies on standard memory management and string
>   functions like malloc(), free(), memcpy(), and memset() in routines
>   such as aslr_tool__findnew_mapping(), aslr_tool__process_sample(),
>   and aslr_tool__delete(). Because the required headers are omitted,
>   the compiler must resolve these calls via implicit function
>   declarations. While glibc may transitively provide these definitions
>   via other headers, musl libc does not. This violates strict C99+
>   standard compliance and triggers fatal build errors under modern
>   compiler configurations.
>=20
> Add the header files and use git clang-format to sort.
>=20
> Reported-by: sashiko-bot@kernel.org
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917045326.6360=
1-1-irogers@google.com?part=3D1

