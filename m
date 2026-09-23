Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9334C51CF68
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188739; cv=none; b=Nl7RG3s8m9sKH/Ji4DNbqcZXOaVbiAiYzAuE4/sBrodA+nQ0hHvrkF5nZZIS1Lq2JCzatUJsC7SkCh34eQ+3bZlOvPEiiYpD3s+I8Df8kWXe78X/wkUQ2jNf6dS+XWmvG8U2KOPo8AZ1XLux+xh7e0EGILXU/1gtz9bC5nZRZ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188739; c=relaxed/simple;
	bh=T4WfIqTXxg1f9mjEoeJ+ZisJKFWAoYX+A2WmAMCNThw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dha9kn+l3IKdIoSyu9AUWyoAHQxJpHc/v6QwJcpIS9qUjRn2buDsCnC34xprhPrBqjLBqJiKuWUzRUaVBZKvEbTwx3oSDRmAe67PD6VdaMhXH7eqRHSOIloUyzonpEVBYV0fiG2p0HyaJIP+XBkV9TxSkjcw9uZDvjOgQYvJj6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7CMbH1m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7CMbH1m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052FB1F000FF;
	Wed, 23 Sep 2026 18:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188738;
	bh=VEWkexUAfHnwKeUCumSfoESVl+dYf1ae7EOh2QYjU/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R7CMbH1mKHqyTJFIENUDe6b17+sZAdwLyYXNWevAuySBmhpigQBfUD3uIY5J7ZI+Q
	 UNhgfurPgXj1Ax5uJHKPzjqGQboFpI8y7DIPC84QrMRUvdvptXJXtRw1guclemvUx+
	 3KmRsEDfFMgTW8X8TpgHkqaPUKwOgkPZM3MEjP5toq9eDs9vt6yyGsKE/f2XWrDMis
	 u3C2e0XJR70vIvQEVixJ7NZ5SGBmbR3TPN7f98Cghembvs3KByeqKvyBwJuRlHIN3G
	 MlIF4S8OmNz/d4O9GJ0v7BCtq6YFLXYLvk4xMAXWE8pWHX2ciCMFQgb7oVNTUE1oeX
	 RIwp900P+mlrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 37/49] perf python: Port check-perf-trace to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-38-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-38-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:38:57 +0000
Message-Id: <20260923183858.052FB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port check-perf-trace.py to a standalone script in tools/perf/python/
> using the perf module directly.
>=20
> Improvements compared to the legacy script:
> - Access tracepoint fields directly as attributes on perf.sample_event
>   instead of per-event dictionaries and legacy Perf-Trace-Util helpers.
> - Decode symbolic flag and enum masks for irq:softirq_entry and
>   kmem:kmalloc directly in Python and add -i/--input CLI support via
>   argparse.
> - Add full type annotations and clean up Python 2 idioms.
>=20
> Add a shell test (test_check_perf_trace_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D37

