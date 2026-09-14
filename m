Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC75240611
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 02:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789353385; cv=none; b=g+iNk65ZfRwYUXRj1ywVl0YNmP5gOm3W08dW9JT1R/EkNW4JVWh+AuCCayc0wv+nDyvSmhmF3tliOASJiVRVDmPMD9jZcsK6jlgvhZTw/rLP/TvEnETQeGLunMkGEGacOMdy5u4Nxxy3gzTc5euEgV69trz5MRk0hcERFznvgKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789353385; c=relaxed/simple;
	bh=maDbxUJ23jkZXT/lz1mFFWNOLWvb9jCCWKxhK5n/vsg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ROcPVXjUAUtvtYqc/jeX+uqZoKwK2ngVAG3MTQs74/cdNgfOl4aNdJ1gBUodc3A+ftHhk0/BGrxpmweqODBNSmkjrrONefylRdjurUpBdT+sMGudWx6WflTXxyM08QoeQFIRwU1DRNlDuM6sDgV2AiZnQbdxZCECE6zBWRYUM98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/sU5Hra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/sU5Hra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E3D1F000FF;
	Mon, 14 Sep 2026 02:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789353383;
	bh=maDbxUJ23jkZXT/lz1mFFWNOLWvb9jCCWKxhK5n/vsg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W/sU5HralWxeM5oKdob19jdOhZsclto8921TLaImxFiUzPL8iGFg9lDroDpVnR0Ew
	 TbpR4H0hOpLlfVJv7HmzVAR8oQgZpNqjkBGtMnoM57FJC6tatvoRwOi5kYrVYoyrGP
	 O2wyt0/DUPCm66YhwgxVjz+DZrSxuQksBPu8vLji6+HNbjN2KcmKi47s63yQ96lK1U
	 f5ZwnY+hgmFYT87prJerSZZxkY1T1kqgx3hGT82wtAL8eGWJGyhPXLTtJ1Xldi1Vrh
	 0kwYWWmtDUkTig7AqqnihOvf+cUK35z5M0khyb8ZAhIrYXAx7wSfS6AkVfFdOk7IPG
	 XAGoEoyFNXWGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/16] perf/ring_buffer: stop using PG_private as AUX
 page high-order marker
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zi Yan" <ziy@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913-remove-pg_private-v4-2-848550f7574e@nvidia.com>
References: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
 <20260913-remove-pg_private-v4-2-848550f7574e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 02:36:23 +0000
Message-Id: <20260914023623.76E3D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> A high-order AUX page sets PG_private on its first page and stores the
> order in first_page->private. Stop using PG_private and check
> first_page->private for AUX page order only in the ring buffer and its
> users. This is fine because page->private is 0 for order-0 AUX pages,
> matching the page order.
>=20
> It prepares for a future commit that remove PG_private.
>=20
> No functional change intended.
>=20
> Assisted-by: LLM
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> To: Arnaldo Carvalho de Melo <acme@kernel.org>
> To: Namhyung Kim <namhyung@kernel.org>
> [ ... ]
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Usama Arif <usama.arif@linux.dev>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913-remove-pg_=
private-v4-0-848550f7574e@nvidia.com?part=3D2

