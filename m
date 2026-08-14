Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06E2F9DA1
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 01:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670651; cv=none; b=TOVKRISImKHO/fLpRxLXQIXJfR2VvPEclMj3AgKv4DDNjcZtQ2pGXgmECmbGJ1F6aUlqnBMSK5u9eQG5L8fjTd+mQbf1KFA8MtXtnrhwRQGHjRI4sJK0QvjESyyLjy7KzRrN7fBoKIAHO1hgWk+cAEs+7FifK5VzjSDPCJ4aAGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670651; c=relaxed/simple;
	bh=bi7e3HYOQSWqriYRLqGmX19z+mhPdcsZrCw7+uPLWh4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=akdSyMAdv/Ot6/aEOl9aFU+3YWCk9wawQowwEUF1wmkmVxp1JHBwj0nP8XznST+RQ6jrZwEiCh5PQporEOzEFfrkaL/sjwJvstuQA1RXoj6qXRKH5iwOZaKuTFviRkNZA0AKyBRrbe1HFrTK+e2Whi5FRJe7DyyHt42LbfeUvoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3K1EHos; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3K1EHos"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D401F000E9;
	Fri, 14 Aug 2026 01:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786670649;
	bh=bi7e3HYOQSWqriYRLqGmX19z+mhPdcsZrCw7+uPLWh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G3K1EHosg6ZzQGKIErMZPa2byoNyXfDneKFgYtSkXHrI2leklzM8SObAuK3pLJMXR
	 uIomwPvDWtBdxd0vZdWrlen6dJMhggZsxj5IUMNLAx9GKZxjc+H77e6On/we+JlN31
	 jrwpFIIFR/0IoNS2BBfb9dWh+3bHcFmHs5sgja6nnpxF5Ud2Cqao7tYMAvr1GBsQoM
	 ktogwTfC3NeFm0Nwy80eYzmcjCt7RDRSbJXlRWsQpYWRNNnLAwoCKu0zCYFK/TfK0b
	 vH3ekLYbPBdwwxGxdLIa1Y3VBLHTfE4JJfqSrRM5NzWb+a0NYcOUgT6V+0ahIEN1nD
	 5mvTajW5VEKeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 21/33] perf s390-sample-raw: Don't pass evsel or its
 PMU with sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413041143.1736055-22-irogers@google.com>
References: <20260413041143.1736055-22-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:24:08 +0000
Message-Id: <20260814012408.C7D401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The sample contains the evsel and its PMU so it is unnecessary to pass
> the evsel as well.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413041143.1736=
055-1-irogers@google.com?part=3D21

