Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5B8340283
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789622324; cv=none; b=F0hDTw6NOmJ2hC/svBiYF1PcPFNYOYmqkGXQub2xAtTc8lmORXNh9e4nKWavtQ2TrTXAYKa+hiyj2bWHEF355gmy2UjPMcvBINI+ksxH5Wf+wcZ2oAej1ChzvxLlTRy8SPb/rf047m9bH1R910sDKI/Wwi642/BzDByscy0dIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789622324; c=relaxed/simple;
	bh=6QRY7vi83VjRuo0Va3undgozlwmyVeDFAREwKXxGV2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dSjM6Y+hQoypt9e3VFyCLmhVThNdNOulDFtVLrOJCxQEE+avs/D7wXnOUhtHKmMq/8g++Kxq/Zu2aQEsgR7CEU2Tdpuwn+RR7riutWvjBe3ssqzlxlYNjSBCQvQnEwu4KJzraQs1KS0gZBerTQq39CqyiBFJSe/8ljFTuAeWq2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLpVSXkI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLpVSXkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742581F000FF;
	Thu, 17 Sep 2026 05:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789622322;
	bh=6QRY7vi83VjRuo0Va3undgozlwmyVeDFAREwKXxGV2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SLpVSXkIr+RNd6vx0pP0WlEQOF424QZqVhOq8oiX42XWp/dhJ/whkTXaxfANKFvfB
	 BA5XDVWZmdvym3szSqOCoXChG1f10OoxDc8CbJeTLZMwyDS0iJCq7/oHfzFna6ktxe
	 Xq+hO9/KkDtJNsLmKiQcokSAxYBHj8ksvNOk3L0mLJ8dF5FRDJSHUv/AjZq250TjEt
	 KrxFuBDjHFliZcParQDBbsVGVV2RPG3veuqE87sNJknMhSrsjlW+fVdpdDRjwQ6lx0
	 CP4DSMwkA1jSQKuPNASYpaFXjHMyyGzqvdcUOuBW06D0PCHuHQMQ4nViGGfuw3RfxJ
	 OzB2Ij1gr+O1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/9] perf test: Expand tests for --hybrid-merge
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917050708.704702-9-irogers@google.com>
References: <20260916234652.439778-1-irogers@google.com>
 <20260917050708.704702-1-irogers@google.com>
 <20260917050708.704702-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 05:18:41 +0000
Message-Id: <20260917051842.742581F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add a "Hybrid event merging" test that checks evlist__can_merge_hybrid()
> and evlist__merge_hybrid() directly, covering the events a wildcard
> expanded to over two core PMUs, the same over three, and events that
> must not be merged.
>=20
> Add a report_hybrid_merge.sh shell test that records and then reports
> with --hybrid-merge, and extend top.sh to cover perf top with it.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917050708.7047=
02-1-irogers@google.com?part=3D8

