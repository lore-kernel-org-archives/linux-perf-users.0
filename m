Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2FC346A14
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968394; cv=none; b=MxWiX/kEPIrYmqMnOZJfdIdKEiXgwx8KxVhc8+xSrL/ImPkpxQNWXbKfZ17Qr48qX/xEKgwLyFSMQt6F0XNIUwGNiWKmz4uiI6RaU8cRhsxjLB5rT7cSSzIjAyqJFhUclZlyNTNP8Y/svghmFN0nivxAS0/eLqUAAmHkR0uYrXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968394; c=relaxed/simple;
	bh=jK39WpLpIeRjl5VxEU7Wv+lxxkhcnRPVJqf767+Qb5c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AC9NtaojSlo2zi9bIrNG+d0I0h3tOMeti4g13RzwcoQFtTp7m5fnnpB1gT5VU+D1JCS4zA0paQsREngm6o5nti9ud/UBwzOpTKlIBhCqNl1N5mrblw38tn4GvMmKjX4gqrXrRfpDR0DGbBZDq+O+m6xCIo7ZUmkf3i3kxpD4UMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4Egc4/n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4Egc4/n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885981F000FF;
	Mon, 21 Sep 2026 05:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968392;
	bh=tMzCmxc2vCZ1DoxjZ50Z27pcJ6f6/9foG+5O1LBoBKw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h4Egc4/nB/OUOgTHvWU642mTGh3lvwsuSo6oWYWzpZtZgIO2RdZroN1h0Eu3Nmysw
	 yHuKBkk5++0NgC9+wszcPRJWQM9CGFggOJEXJBcm1hdWvudQXtt6/KGNZvjTCG/XgB
	 hH5bOBWjPgNhFYp4/maZOGW74E2buSclOsU8IjGYDUcryx/tp/uX0NxjgpzPh38c6L
	 BJqjW96ag1Gz7vGEm/C6EI+5lbjOquwia5NP6ldXQgrXpJk73R9OPHkm3PBu1XmAm6
	 aAhBTD03/FCPMWDpqycY3buEdDtg42+/WFeZ7yRjNrWCArzT6vtw/mKwYhRhrUVPe5
	 FSB0syK4+Czrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/49] perf test: Clean up mypy and pylint issues in
 shell test libraries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <bea01e4fc180d6e92361f034ca304033b319da97.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <bea01e4fc180d6e92361f034ca304033b319da97.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:26:32 +0000
Message-Id: <20260921052632.885981F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Clean up mypy type errors and pylint errors/warnings in
> tools/perf/tests/shell/lib/ (attr.py, perf_json_output_lint.py, and
> perf_metric_validation.py):
> - Fix E0606 (possibly-used-before-assignment) in perf_metric_validation.py
>   by importing sys at module level.
> - Add type annotations for stack, second_results, collectlist,
>   get_bounds(),
>   and main() in perf_metric_validation.py.
> - Avoid assigning -1 to list[int] expected_items in
>   perf_json_output_lint.py,
>   rename shadowing variables, and remove redundant lambdas.
> - Remove unnecessary semicolons, use lazy logging arguments, specify
>   exception types and file encodings, and initialize module-level logger
>   in attr.py.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D12

