Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602186;
	b=XzvIVFFuYwcM9AHgM4DZD9O9hP6slHsQlnkaEECd65VGHjcxupikNOX9Z1757FOZ7tJL
	 nvp/G0hgqXJQ5GLg/y5omSY4rb7JLv+4KT6BJxz/gEWF+DsJSah0f+EqFlpX/TmUvw8s3
	 B/mMryyPHiczMl8XdBjLULGc8zQLmVAVS1i1QEC8rZx3wqqtQ+uHVqkQ5Y2Msy+03kHWK
	 0tqU0did7sQy/qyN1emt5yBd3XHLClcsxqEHpPyBwYADL4iwYpHLOZagfw7pA3ShnChIH
	 6bowxGZFnDFqdG787R4uHJtj8SMJ24nB0YcoRjaVcnKpGWZcKrlIYcYx729huefyPeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602186;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n2NVE9K67EBFsfC9l67BOuUJAoxtt+q10CnINAecDGo=;
	b=PSjdvj4ZwPMBg7iI2VRFupQBAo8wbeMdH21yvQuxjnwpMw8Iv6k0/OAc3E6RGdOcyR5R
	 KgQrw6LM1FVk+Nez9JfRC+621PKtId8nLhahNvBaW4+bySoJl27etBo1Mpk0LinCZ1847
	 xOQwzSbFKO6PIwCNKiY3uQneaRDZE9BuQKl24y5gb27F3XvIgo2C1VvyUhiVUpEA83y/V
	 gfm/d7hivOoLSUFXR0cnh7f1CQE3o2ddaZ9mSL5BmI8g/RgK0D/zTG/qT1CS/f1UMgk+D
	 G2qoptoutpPZeNZHkLGxvU6xqZSfdg7eYCO8Iz5vksVVT+I6G5qO80jv1rKzpRNbsNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fEzPQ7Hp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0742606A335
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fEzPQ7Hp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1891F000C4;
	Fri, 13 Nov 2026 20:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602185;
	bh=n2NVE9K67EBFsfC9l67BOuUJAoxtt+q10CnINAecDGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fEzPQ7HpyHS2aP/ygvEzR7yU/YgczUkh2yFrITfVO6E64eRXzbOuQ8fErM28ZPMv7
	 o4ntW6gWvYwzWtLiuIjofDUEdrlg3nDjwz/EHSZtTnmROIGKiU6thO9fkTrHlIwubz
	 2zjQ8C3//MfKbg23DN7B4CS9Oez31cZTPeffV2Gz6T3hUNZ96xxT3j+mu9gCNtJIew
	 i2YtcJse7rE/dqk5uOt4jGDWmPv/uEeVlelXUL3B6LVeKIuKWF7uERX3Zk9NhCYtDg
	 KMoA7LiXoUmQ6xaSyf+iqJQf73ZOu3tLqT2XJtZ7Mxu1oto/s7yrksNRlNqA+xZxCp
	 PN4zcTlsFW45Q==
Message-ID: <sashiko-outbox-213655@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/30] perf pmus: Introduce struct perf_pmus and
 perf_env__pmus()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-9-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:36:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Move the static global core_pmus, other_pmus, read_pmu_types,
> num_core_pmus, and extended_type state from pmus.c into a new
> struct perf_pmus embedded in struct perf_env and accessed via
> perf_env__pmus().
>=20
> Rename perf_pmus__destroy() to perf_pmus__exit() to match the
> perf_env__init()/perf_env__exit() naming convention, and update it
> along with perf_pmus__find_by_attr(), perf_pmus__scan_for_event(),
> perf_pmus__scan_matching_wildcard(), perf_pmus__scan_for_uncore_id(),
> perf_pmus__pmu_for_pmu_filter(), perf_pmus__print_pmu_events(),
> perf_pmus__print_raw_pmu_events(), perf_pmus__have_event(),
> perf_pmus__num_core_pmus(), perf_pmus__supports_extended_type(),
> perf_pmus__add_test_pmu(), and perf_pmus__add_test_hwmon_pmu() to take
> struct perf_pmus *.
>=20
> To keep this commit reviewable, the high-fanout perf_pmus__find(),
> perf_pmus__find_by_type(), perf_pmus__find_core_pmu(),
> perf_pmus__scan(), and perf_pmus__scan_core() helpers are updated to
> take struct perf_pmus * in the next two commits.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D8

