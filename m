Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A23D333C
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882937; cv=none; b=iJmFIxRyLpeayCuwQWc8Q0i6z9c8QJSAWouY+w5xkGb+x6pI4403OVw94dYREGfokVvnoP6rkyzOxfOGYoGK8Ip7kYsP5ghGJ5gIgf12uH7++DNnkqtXxjar3CTUcA4Sw3yOXhy/V/sUvjtXMIuVKKxfevdmuNRb7FQvGFwaXII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882937; c=relaxed/simple;
	bh=yrNbS4FOu3Gjf8bTBXwthzkwmpfFHVDhhPhRptXth0g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zka8PTDl+o4YIvDO5UB0RWjpVTsadwOFhn7T1uW6NEt2BUAe7YGlJAqG8+lKSa7tBrUkqrSQNZonqtaVOW4GIxHitdW/OogQUpYVa3+0gnh06bj7CZKeOLY8nyF5dlT8RROEaBXDZ16l9ZD9EUgwM8awnnD/PQ7Z4F7SQSyv25w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYqF+gjU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYqF+gjU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DC31F000FF;
	Sun, 20 Sep 2026 05:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882936;
	bh=/LLSPaHRjUvgK8WJKlEM8iIW/ItzSqItSI3c7+XI4AE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VYqF+gjULGIkkXSi9AvnQzIXG5N/9O0FhYCSCf6thGyl/ixGDpnGFbaKmxZ8AiF2X
	 L4l101s6Df1RtDQfu2sWMQFnJp0lFJLzrdwbuVWHREvpqBfgKygLkb4zTIjqgIyU91
	 Gx0RsXBOsnrXzWAIfFLcY4rcTD+SGIlbcGt3aW+e9vYoqMqKkOtIZE1PX8cVaIsanF
	 HgInlL1j0bLfJmPijBLZI1w6bkmpzc7cgRtREfOFf11K33rmpaioShRJALa3/K0NRv
	 +dwyElVEltdwZ+a+HP7YOSyewihoTckKp8N3JBu4AY179H9Iew+2vM75mcxKMIFMX1
	 vyEnoSxdTabSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 40/49] perf python: Port intel-pt-events and libxed
 to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <ce8ab79149d6909298269a441156fca322eea452.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <ce8ab79149d6909298269a441156fca322eea452.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:42:15 +0000
Message-Id: <20260920054215.D4DC31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port intel-pt-events.py and libxed.py from tools/perf/scripts/python/
> to standalone modules in tools/perf/python/:
> - Refactor intel-pt-events.py into an IntelPTAnalyzer class with full
>   type annotations to encapsulate trace state and stashed output.
> - Configure instruction trace decoding directly via perf.session's
>   itrace option and context_switch callback.
> - Dynamically select 32-bit vs 64-bit disassembly mode in libxed.py
>   using session.is_64_bit and annotate instructions with source lines
>   via sample.srccode().
> - Rename methods in libxed.py to snake_case (instruction, set_mode,
>   disassemble_one) and remove Python 2 compatibility code.
>=20
> Add a shell test (test_intel_pt_events_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D40

