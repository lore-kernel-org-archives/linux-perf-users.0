Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0714848A5
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912772; cv=none; b=deEfZ9kBXPRPbJBD9ynP4mjUsSnrJubG9uM2xzoPIT2azFDzqQV+hvUiGU/PJmgeSR9AAnEdBxJhLQNusPAQUChvsWSQW7uCL+kKq17izOtWVK/xue6gfwsikazyGehBBgZ2O5TeVt9D1lXPtIBzXrFBfbYrYwwfpti+JQGNXPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912772; c=relaxed/simple;
	bh=6KRNlrCFMbsf2eNTmeN6i41PBArLaUfeo9F3j8+RRsU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=g323hUc7XKLQ6lbaxpmn9P87uMqodMkBVZpC0UocLLfgb1xAxj1O2drovdKepvqk9/NsYDGqjjQXzqVXbdMHUpJsa6eTX2BhqyK2jaTeCV+YG7qVzpHwIs+jXoPtp/43fAF54w1wDODC6mOLgLBS2ndhY+FDNBQtq6UpFD784VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZaQObZP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZaQObZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBDF1F000FF;
	Tue, 13 Oct 2026 17:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912770;
	bh=/Tvg9LvVFv+ouhsMO9GvfgXup6oHNuxLFUY2dLrGwHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZZaQObZPmqTc6kYAWa3oj2jWVUiJETH7T39G0M7WxeAmqD/D9588tpjIkTq2kEmnk
	 ZkLhfivp4F3iUUIUhPcY/0z3cijBoqaXfMdeju89qXVAMkd332+HHWHkhk7HqAqoIY
	 ZEO1V/dONd8yTdiE7shx03Lbr4OsVOxipZq/n/JvPhKpMYXNFfRzgr52dCsILY7V9i
	 kxaOYrOvV2FIUqfJE/eEKekGZfZNBmh1p7Hjd9SpYWF3iJ816qM0LY+/fIbz/ZHDbY
	 2zbnI3IYxlUZqx2OXFQmV/AxwN8ydyk0V72OcTALwSg5U2RQnbvJD3NbuRlBT0KRDr
	 hsCFj4StqEBMw==
Message-ID: <sashiko-outbox-170234@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/11] perf symbol: Update symtab type of vmlinux
 from build-id cache
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013172155.160869-5-namhyung@kernel.org>
References: <20261013172155.160869-1-namhyung@kernel.org>
 <20261013172155.160869-5-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:32:50 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Currently dso__load_vmlinux() sets both binary type and symtab type to
> VMLINUX.  To precisely track the symtab type of the kernel dso, update
> the type to build-id cache if it's loaded from there.  It won't have
> any functional difference though.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013172155.1608=
69-1-namhyung@kernel.org?part=3D4

