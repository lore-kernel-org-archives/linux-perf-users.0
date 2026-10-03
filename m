Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FF03C07A
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991203; cv=none; b=Dzba6q7jPptppzT2tLz7Ga8r5e8jmP4lXjVLHRXjJEvS/WkpjEImVTXPqcT9horC2zAUfuJ9JbcEtmMM9fxUd8S0zP+VzM9HSnHdfRbwvjnlbGJGlcYCmjD/iYSEFpcCgV9eZRvXpsjxhO5LqZut4UkYrKeJtqwBV4SmbvTXW8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991203; c=relaxed/simple;
	bh=MMqQzqUoheghZTBlfyQITvDaG1jCtRZBW0rVQLlfaaQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=npni4FFCly0z+o/KF8eglVx6odguvH+jyUqd5+blIQHDPQNaYY3UUzOqfcQr6cy1ruqKUXPtJUwZj+sRtSftFd2u33BFncltybYh+wWtCiEiUdRl0XAzZltLweWGHHPrM2rlmB+BsseBq1/Bp9iJWLriX9F/819lV10DlTw5/OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zhms0tif; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zhms0tif"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA0A1F000FF;
	Sat,  3 Oct 2026 01:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991202;
	bh=MMqQzqUoheghZTBlfyQITvDaG1jCtRZBW0rVQLlfaaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zhms0tifgXKVemAk3ZVqFOQ7PCmZCUqcwUYsxjzSj5nPArCK5yJFSgZs9o1+A++Gs
	 C/Qq6Ne1r2QtY/Nb8UzPTPM87YnQP5MuvpxQep07QEpm+dNHEU9ZZzoBNJlC8ZgvPH
	 jCRc/+N4Tz2hCb3VCZ+1e7hcUmSZFNX+6HFSwyGPedg5ZPzeFSq8paiALn5cJGulp5
	 ER1w7iVLxLrggTJ+iI7FCz25sSNwZTfQR0wOaqpDKdx044rK7prht0ry2JCfbNNfbg
	 +YGiOjp/n09V8aXZwZGAf9BrFl8Ulyp/GjfQZiVc1vzvRNu7V6yP4qEF3/aD8EkCcK
	 BJ577THu66VCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8] perf tests: Add build_id_offset test coverage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002173848.3228217-9-irogers@google.com>
References: <20250424061943.1321025-1-irogers@google.com>
 <20261002173848.3228217-1-irogers@google.com>
 <20261002173848.3228217-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:21 +0000
Message-Id: <20261003013322.0FA0A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Test the kernel interface using sys_perf_event_open, test perf inject
> --sample-buildids with pipe mode and callchains, and test perf record
> --buildid-offset across multiple sampling modes.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002173848.3228=
217-1-irogers@google.com?part=3D8

