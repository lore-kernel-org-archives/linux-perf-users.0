Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F875568FDA
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200840; cv=none; b=LT4vA5+TvQ1AwpwAohMfO731fhIDSFMylbN3uy+FAN4SpDDOzQ+77La9ttoaacoMd9RlmEAYK/cmwMqA/5S7P45R9RKr6F4qNy4yXY+eftcz3ksTooG/84J6NLusKdd7nyRzNpFbVH747KOiNbmjHdZFmcmaQBR4xxkeqwB0+8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200840; c=relaxed/simple;
	bh=x2GacvwHMsGdsxZY/3X2b9OOZDI8E6v7pr50f6RsrVs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j/DkHhBhvI52HEJ3wC2d7IsIAugNlQzz6aBrQJ/mWch65KD6q4L+YJm7PUlDzixfO0+qzcuN8PSdtx8pZyM8Bejht9UR+DkkXFMACA2YelQBM5JuTaFsh0vPwiDgBHBlmST5s+bg8BJ0KlpLCM8wT+DhY0Tel4F72/+3LRBpPq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=er59ciY8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="er59ciY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED4B1F000FF;
	Wed, 23 Sep 2026 22:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790200838;
	bh=QlubqE09ZHJwoMeGywUwfcKqXWc6/3bjWw1aPssgI1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=er59ciY8tcJjnI+2kBg5HTaCMSaToIn8rQ8O7yKNdahomprFPORm9D6FGvrdp1VQT
	 hmQm17riR+NePQQlrCYNIIwb1SU2bI+PTKQ9PVz24WL9Q//nMIf5tSkITzW7UnQxVY
	 /MPpGDXQTI6jCNvZdx2hy3j9PM4HWOghVgJRbP2jKj/wEZoK2r6EglCNLlYtN5wyxL
	 YPnwWYHBfsqV6Pe1IDwzdWDkFCczl9QYJvtffmfNlwa4BvOPbiAg8ZQHutBgz5Xjtw
	 0u1Y3vzVQ/ERuoZtFuw2kkoaCW6mkbv+i0sOXzyo6LkyS3n7QgaHt3gnG9qDD9s266
	 oCM20WtWut2PA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf test: Fix errors when deleting data in perf
 record tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923215255.3329181-1-namhyung@kernel.org>
References: <20260923215255.3329181-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 22:00:37 +0000
Message-Id: <20260923220038.5ED4B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> perf record with multithreads would create a data directory instead of a
> file.  But the cleanup and retry logic expect a file and try to delete
> them with 'rm -f' which would fail.  Add '-r' flag to remove directories.
>=20
>   rm: cannot remove '/tmp/__perf_test.perf.data.ZVHTw.old': Is a directory
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923215255.3329=
181-1-namhyung@kernel.org?part=3D1

