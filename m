Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980555221EA
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577194; cv=none; b=DyrFDdP8ZZ7y4vy99W2z66x0JvbSql7hWzrTZ8Y6a294MCTWCUiHX6zwR7sv+0t5B0pSUqbOiWXs9FetwVwTt2umButTvoAT2QsqYi9Ao2ipUDfVkIgOqhylofbGLoAgxi4+w1YCb61b8day4eDrfZlpRoRhgidfyMsqfl7C6+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577194; c=relaxed/simple;
	bh=yncWyk66OXn1hjtIQx0JXW4TYDl+U2LcyjIOp9QN7ms=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f5PeZ38nsiplR+K7MrfHaIHbsr0uD2MuOgLMvuu3fy0ZTXnZmUBB9CKH1PtC0Mt6q46t9W0xRUYR/5C/ujBPjOkYdd2t2lyzw0v4TX6ZHzr8+qXY3YYWL5c8/FvnVGIyxSXW+q0CI8iwJWg+D1eX+JnQizDKyjE7bgSaQfS0Oig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlwESQaO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlwESQaO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B591F000FF;
	Wed, 16 Sep 2026 16:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577179;
	bh=yncWyk66OXn1hjtIQx0JXW4TYDl+U2LcyjIOp9QN7ms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HlwESQaOUrvo/LRSICp0BW6APdkVVmnktwAt27Z+WLnkhb3fvdw+WcAyqfytIcBFl
	 pWx/3w3Xh8sDCSd/ucOMgeS87o61I8kipchAUh767gGc/HjaN8taePbvnkmKB/8ELZ
	 D0ncXqmO1HoOo8pcLuisVCc086dY9DuuMbCjVAZBdcx3ebZgFKKvktjCTJblwmkUzf
	 S6CaNiZNNikZWl95rXGVdRJjMoKeF55OGNSO7/bWkoXXdYZgpTmZmi3Fu5dWtQpNmv
	 l/xC+i+pCeu3ofAB+XG4bNLlh+3kqJI8GztRZaxc3Aiw1EZDFT8Crr6Jcn/2urUOZO
	 RmqHCEWB4rZ1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/6] perf mem: Add support for printing
 PERF_MEM_LVLNUM_L0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916163127.318885-3-thomas.falcon@intel.com>
References: <20260916163127.318885-1-thomas.falcon@intel.com>
 <20260916163127.318885-3-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:46:18 +0000
Message-Id: <20260916164619.67B591F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>=20
> Add support for printing PERF_MEM_LVLNUM_L0 in perf mem report.
>=20
> The L0 cache is newly added a small piece of cache which is
> the closest, lowest-latency memory cache tied directly to the
> execution pipeline.
>=20
> The table "Table 9-4. Data Source Field Encodings for Panther
> Cove and Coyote Cove Microarchitectures" in the ISE doc chapter
> "9.2.1 Panther Cove and Coyote Cove Microarchitectures Memory
> Auxiliary Field Layout"[1] indicates the code "01H" means the
> "L0 Hit - Minimal latency core cache hit. This request was
> satisfied by the L0 data cache."
>=20
> [1]: https://www.intel.com/content/www/us/en/content-details/922690/intel=
-architecture-instruction-set-extensions-programming-reference.html
>=20
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Thomas Falcon <thomas.falcon@intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916163127.3188=
85-1-thomas.falcon@intel.com?part=3D2

