Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9211A3B83E1
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960160; cv=none; b=UR29gwJt3v7jGnFwsukymdKq8U+iwVJhKwexY3bNylIlAfZwolizmA5JNaFlbDnhdnwGQ4DlSxWgDpD0eCAovOGhIZZlrkvN3crPp3v7Et5NnGPtU4a9wlDCZfFt36M40/O//kP5cEeuSM+KKs/Xxh2a0JfUPNaFXJmA6tL2rR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960160; c=relaxed/simple;
	bh=tuWBv3cjUT73nXkpG4TplpogyjWefZYWswNKPdw5uoE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YuXtIE9ttqaF9uEQSIDs37BQ7huTU7jD0lseRNAeTImesZJ+RRzbwC9Y6tJmCKJWZRIsQLwHIcP1BTAKd97Xr14LrzUm91HQyQbdgrWzEnn9tl8WQQshx2s5Y3gi21yKv4H2GzeEJc8PZ3Kq7ug/DynQQO5Igk3LMNERY8iSI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrS5eJLX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrS5eJLX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE7C1F000E9;
	Mon, 17 Aug 2026 09:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786960159;
	bh=tuWBv3cjUT73nXkpG4TplpogyjWefZYWswNKPdw5uoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HrS5eJLXyDK24wYXX9VjBaeo3ySgr8L6GbbRFKclqe++uS+AOi5+K6LvlpXMAaiHl
	 LRE81+agIGXLOKS8HbZ/rXOfYbeyirzypO3tqKykfvFsbQc8l/FkYwE/AgDyIGzn2H
	 9P9IotSkt3E9qoaDduXTKYCDqPLUVH65k0VbUf9lSIODiPz4b/v8yeXpJnMyOlpQA0
	 TocdmNWeMqeAl0K5HCS7eN9FxfuDRY3Nq0HA4fGSnODVnTNYSJlbPPdh9nYiAjZLrB
	 6vg/NZwpcZpnHjTfcJVz9DXrV/8Y/PXchoBWQBy3RzPEYob1bYC8FXjc04bDPyJSqQ
	 wRzMTtFABnabg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 9/9] perf c2c: document function view in perf-c2c man
 page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260817094623.3288456-10-jiebin.sun@intel.com>
References: <20260817094623.3288456-1-jiebin.sun@intel.com>
 <20260817094623.3288456-10-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 09:49:18 +0000
Message-Id: <20260817094918.DFE7C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Describe the function view hierarchy (read-side function -> contending
> writer function -> shared cachelines), the per-level indentation, and the
> keys, with a worked example.
>=20
> Document that reliable function attribution requires `iaddr` in
> `--coalesce`, that the reader and writer may be the same function, and why
> the coalesced function view cannot distinguish same-thread from
> different-thread accesses in that case. Also document that verbose mode
> includes code addresses in function rows.
>=20
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817094623.3288=
456-1-jiebin.sun@intel.com?part=3D9

