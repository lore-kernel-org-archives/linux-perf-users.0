Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD1B2DF719
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882618; cv=none; b=fcN0SgNNIBZkiPB7vnqUWzaAavfYQJ+Z06tDWQRCQ+dbe1NPbmYj/eXTXsTGJzrMRkSuL73bnR4G4ymm4/HrtrV0gxN7dpMLvdcga1WMMs6JdCo9bdoRyBDoOfrHBg0MUGE3wOJC0zhYQjt0KTts4/B55MhcFg9R8iWnc9VTlrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882618; c=relaxed/simple;
	bh=5QFuG/HGRBXtmHV11lmzM+jkuPKqbCvh4BIfI0fpmro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hg+9rbKyR300HO+xksI67/cQpBEpyR4vAYCB6GlR9kXnAX7QQVuZqRhwD1xmdZ+sF2tbicc8wattINtcdfyd03GyaBCC8wWAZLQWu2KUfZSnfYEyEHBjxfQon5XDZZOBMi7w3g/BaQvFUiBVTz1iM/UFQdiwuge/9LeJ7rZxiVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+ldqR6o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+ldqR6o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57801F000FF;
	Sun, 20 Sep 2026 05:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882616;
	bh=dtIPmJhyI5gr7IqsuwsUeGVsjGZALG9WPnOdKycdeBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I+ldqR6oyBdBgxh18CqyebtPiHOjj20pEehCgTm29TPbWuNTrX39qdeBme5qxn3RR
	 nFqsQodps7SuKuPVnYz33l2D+3rHzqi3deQ1u7PRl0nzRFbWC1xqqvcdVZfQdz0aw1
	 x0DTv4N/o3i5H6fBqYHAFy7sEQ1Qlz8XtxW9/8330NyEpd6uZmfOxjeG/ThXvkiY+e
	 gKDoaUer33SZcmOZn/XZxXuLZQQS2OoY/9Xt5bLfYqiI6RbADeowLkZMYyYYFZ6/oc
	 E9dI2OYqaS1my7v9PHn3xUab3V1UEYeU2ulYLY6YBlXZEXWogFvPhAYds+TcWwdOf8
	 3QrMld8G+V3iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 34/49] perf python: Port compaction-times to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <0577f22cc2dd147f8afdcdab789dfae835d3b187.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <0577f22cc2dd147f8afdcdab789dfae835d3b187.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:36:56 +0000
Message-Id: <20260920053656.C57801F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port compaction-times.py to a standalone script in tools/perf/python/
> using the perf module directly to analyze mm_compaction tracepoints.
>=20
> Improvements compared to the legacy script:
> - Replace Python 2 constructs (such as sys.maxint and raw integer
>   bitmasks) with Python 3 enum.IntEnum (Popt) and enum.IntFlag (Topt)
>   types.
> - Access tracepoint fields directly on perf.sample_event and add
>   -i/--input CLI option support via argparse.
> - Add full type annotations passing mypy and pylint without suppression
>   comments.
>=20
> Add a shell test (test_compaction_times_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D34

