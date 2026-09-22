Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14803033DF;
	Tue, 22 Sep 2026 04:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051542; cv=none; b=FtvSgTkq7Y11D0FlVPBOwlj4TcpILUHahevYAKVj+J6DL1Nrb+sjF86hqOmNUg4LDrRW6aSjc8suh0Iyve+Ih2FeevW48siT2Zru6W6VIRfI+w2UhuBXeC+0UQo1NgWAF0mWCJBH36c/5nvfVGweqdME/9x7kf/GQhUG2DD6kKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051542; c=relaxed/simple;
	bh=7xRXPjI0yDc1CSW+IpUB9og5ItL6BXEzeHgCHnFpcuk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ox51npKexus1q0q14DHVQ0uDMTBzBkHxHBCcPtBY15YZaCFg/cgPhttCVGGiapSB5ls7/mw2QDyZWOL4o7trcN4TTj6rVPJnhLghBC492po5QsJQf+eIvALWMupaH0taG9G1ILIaGP/3lOg1ABGVTQvZvNKU42M6BIgPnBQolV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gawVD+ih; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gawVD+ih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20C91F000FF;
	Tue, 22 Sep 2026 04:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790051541;
	bh=7xRXPjI0yDc1CSW+IpUB9og5ItL6BXEzeHgCHnFpcuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gawVD+ihl18X3N6UUPQ/oujXwIxsavbamN8kxbw6R5crRbIOdWmU5depWZ5YnNvAe
	 LFdho4S3FymWKR8D96KJFPKiiHtAPN/U7c3jnKmOZlhTDk0jazOKis7lsqGNXgSSi/
	 WWT7quaDrxNKTR902viwHx7gF5DCwv5YhXOgAImzyA9gsNVnYNzU0rGc6S/nKMgAGU
	 RZF1qpMY36tzjpx0w7ZYz2VAR+6Gz8/cPVd4yXtntCNG7eSicgw2rL6Wc1VpfPxupt
	 FImF8R57Ns8tHndr5B0DopTVnGUNvT6eNHfs+vk7CZD88xfwBXFyiHBcd3A7VGIFsY
	 xQz2WKKWQaMuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 08/13] selftests: tracing: Add a basic testcase for
 wprobe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <179005117931.388919.6236117656921986202.stgit@devnote2>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005117931.388919.6236117656921986202.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 04:32:20 +0000
Message-Id: <20260922043220.A20C91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add 'add_remove_wprobe.tc' testcase for testing wprobe event that
> tests adding and removing operations of the wprobe event.
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179005108298.388919=
.4535333252892590932.stgit@devnote2?part=3D8

