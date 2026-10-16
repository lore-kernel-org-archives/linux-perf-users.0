Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAA2274B53
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 00:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110325; cv=none; b=KH0j9VigWSYmSwlsetxCFt+CnHGj3hQ+7V9DcEMgyLOe7A3//gnOAO/4TVB4INtdnS8ael31HzC9D+onaR9/tPqOmvmB3qDsBi0hnpTNOaBixe/nvQBTur/amPYXDSxP8ICPPufzCV0zh6wTTEZWtlJ3Am7Y5jS4zuic8O+lZ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110325; c=relaxed/simple;
	bh=AZ4IXdCpqGLhHLLc2LIaz1tOxsxV/6YWAweEkY0MJVY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Z2OTyeVa7JY/vhrXlrw2JiBSy2nYAqFELD8+1Q2uC1K9bN18xluapL5n75Ydg5SzAC0eZHNK+aNdfiCXudVP/F9PXdTxV63FEkxwD/bZkfmDQ6XZBxDWmm4eCpqwCHxc9anHjNUk/EVSdpS5hlOWDuy1FkE+xjP02GmlwsEVqRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRjNEYGJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRjNEYGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C58F1F000C4;
	Fri, 16 Oct 2026 00:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110324;
	bh=9uK/ptsP70dHRp8C4WBis5xW3LrB9h6jmEyLZ1O1jPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZRjNEYGJAaTtJQLxVkQrR3sIzPUJSiLsEr4cVA9PyRKBA3KVvn7Nb46FjPyZuX3Ii
	 ba56AmoWKHuQf437hBBJmEl6DCf7CRpLdO8soTi2hP4MbSt6gDkN2yXUYjruJdADq7
	 j7zHZvh/RKM5yehmxjy+lgkH54MFpxgdXi9JMM9EqAVYf2ktiV2if4wDKq81h5PI00
	 ydRLAFEuaif4ziFQqfW99cq0TWdUVahqCP1T6IKtdP4PU3VItifvP89kpERWYoU3AJ
	 aS/3A8GiT2gaWCJ7IlbapjWzd2Zm6mHcNnvFnv5OO04DgQPZBX6TYWo9jK8lQETmrs
	 V0DbNQSV5NZjQ==
Message-ID: <sashiko-outbox-173522@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/19] perf test attr: Ignore the dummy tracking
 event and the terms it carries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016001843.71978-12-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
 <20261016001843.71978-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 00:25:23 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> With more than one core PMU the requested events can't cover all the
> CPUs, each cluster has its own PMU, so perf opens the software dummy
> event to carry the tracking terms (mmap, comm, task, mmap_data), leaving
> the requested events without them:
>=20
>   expected mmap=3D1, got 0
>   expected comm=3D1, got 0
>   expected task=3D1, got 0
>=20
> That dummy event is not part of what the expectations are about, so
> leave it out of the comparison, unless the expectations ask for one,
> like system-wide-dummy and test-record-dummy-C0 do.
>=20
> And when perf used it to carry the tracking terms, those terms can't be
> matched on the requested events, leave them out of the match as well.
>=20
> The terms are left out only where the dropped dummy actually carried them,
> from the sample_type it was opened with, a dummy that didn't is no reason
> to stop verifying them.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016001843.7197=
8-1-acme@kernel.org?part=3D11

