Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3289A4EBAED
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559727; cv=none; b=UMz7t6ZowasfaYeWNcjYLxIx0lEPnd5mDBgN1hxK3a864FP/Jfv5UEtNJ41czIu/e2iXoY8rxsL03JBHQOag5JnEyXzVhJhzoTJrQsLDrRKv9eR8cnczGP4Ha7DGWEmaWG++nz3XF2Q5WYOsO9hNZBg5L2tsJbfM5cA1fqC8kWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559727; c=relaxed/simple;
	bh=l9J8N+/hAZ/ex/J7bBIRUxx208wRemQNZf5JLxX2mZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PXzJEHBMyfXDYmuvkiwgcrO8sh5/gtxSz/g95TcAGLZB+P1iT3GT4mBIyf1UieVyuto1w5/NVx76l7lVUehQUGEvdHIBmpJ/yi7ENWrp5RaO4nn48ApFFQLqgyR0aDOFyQZ75wuOQ9lnKUtn5FOdDq++h5GE90oGY0hLJV0dxmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbBWQSsP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbBWQSsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B581F000FF;
	Wed, 16 Sep 2026 11:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789559717;
	bh=l9J8N+/hAZ/ex/J7bBIRUxx208wRemQNZf5JLxX2mZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AbBWQSsPPwddKXxt+Yq2MV2LvoHhMBRXV1BcOcAsle+Z6bQqIvh6/Kg8kO1grcIbG
	 pnoE+0oRTLW3RQEBWbYGE6mcYTeKkAOu2HpT+01JHXk936Zyi/2/c5wXlZzz5hRHb1
	 p/FkGm8gRXEXp4m+FFaq+pJEWlj5Zd8M58kdGjhpBhva2HFPwpfy1/tTB+hlZVSmku
	 QnD3tHEOa4fYH2X4qAOlo2Su7M0fRjmFxFWitQd8wOts0Fk8MntN5fhnSE56u4wKns
	 UetxUPsUvn5oVIXA30zcID7iAGXoCEU6iQJDeQ203WlDidKrbDC6TFWEtbzz48iyFK
	 OapSi4eAJ6tjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/12] perf annotate-data: Show the sample count in the
 data-type browser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916114740.48230-8-acme@kernel.org>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 11:55:16 +0000
Message-Id: <20260916115517.58B581F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The data-type browser has a samples view, selected with -n (or with
> annotate.show_nr_samples), in which browser__write_overhead() prints a
> local nr_samples variable that is initialized to zero and never
> updated, so every member is listed as having no samples while the
> period and percent columns for the same entry are filled in.
>=20
> Print the histogram entry's own count instead.
>=20
> This predates the load/store counter split, so fix it ahead of that
> patch: the split then only has to adapt a line that is already correct,
> and this fix can be picked on its own.
>=20
> Fixes: d001c7a7f4736743 ("perf annotate-data: Add hist_entry__annotate_da=
ta_tui()")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916114740.4823=
0-1-acme@kernel.org?part=3D7

