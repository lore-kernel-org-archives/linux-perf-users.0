Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D592D136351
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968970; cv=none; b=e9gIUXrR3efkjmRhRP3Zb8yJqn/X0F+QLO/d1II96hndhpQp5s2bJNVF5jXUieAELzgXJcJ7/IZYaq/AFe8u0BB9M1mY+ipfPSTNrC17mKgfx7TqWXn1dIzwHG/MqTl3ENi4oIoX18gLZFO2WdejnvtcSC+3EI9g4vNkgUm87+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968970; c=relaxed/simple;
	bh=wsEjee3Fq+Ba7FHwM9YMucVbtpSt5DQevSFgHlkCdiw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tNmfwmHCjJLm926/12i8mJ2REZwdDMRES4vMv5BtId5/v1ZGPNEjOAsXxftAQ9qaWtSz01L6nbY6P2ImFI9FRCKPl7hJ0m2O87OwPIslV9yKdzjtMW3tY9+m+uA1tjhuTJ3GxmzqBAlwonzQ2j0BpatofF/DSZwdkrWGlzMNAj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlgdUGt2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlgdUGt2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302C01F000FF;
	Mon, 21 Sep 2026 05:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968969;
	bh=TNKwi9PdVzVZsAtVtOapbkNw+5eVIWtZdqjh2QfHUKw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mlgdUGt2fLW/dv2pfQ+Qi4Bqug/Ry4leAiToMdd9mYO4+ogP91ViyPSayoSbFAVmR
	 jNYKxDBS0cpo33KPi1FKaCKwNiL/HzvbYoQOkvtebQAvwPWHZUqasfFFypBxcNYCcm
	 BR468NTwYIRXrbxyIXQ/cdrUG4xyR1iJznnRGo1Tl1lp0lJkjIX+00z0d/6P4eum5e
	 ImuMQSyKoDl4vHzlfPiLjojLO5B7UjX1Cs66gfXftAiVnGzD7zpx+leZTGCZE5rQ0Y
	 eBdR6SH6r6s41WbUzdwolNI4vI0KJZk+I7zJU4Pp1WbPPOIT5pcqqS/ZQ9Dhh9Bp58
	 WhrAIe/8Q5Y/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 21/49] perf python: Port event_analyzing_sample to
 perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <dd5d083461aa41e9a88e36bb079f223e17edfb0f.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <dd5d083461aa41e9a88e36bb079f223e17edfb0f.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:36:08 +0000
Message-Id: <20260921053609.302C01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port event_analyzing_sample.py to a standalone script in
> tools/perf/python/ using the perf module and standard library sqlite3
> module.
>=20
> Improvements compared to the legacy script:
> - Encapsulate database state in a _DB container instead of mutating
>   module-level globals, and ensure temporary SQLite database files are
>   cleaned up on exit.
> - Add argparse CLI options (-i/--input and -d/--db) while preserving
>   PerfEvent, PebsEvent, and PebsNHM binary raw_buf unpacking and
>   symbol/DSO histogram reporting.
> - Remove Python 2 compatibility code and add type annotations.
>=20
> Add a shell test (test_event_analyzing_sample_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D21

