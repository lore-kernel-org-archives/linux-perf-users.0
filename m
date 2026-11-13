Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602266;
	b=f1CZotQkNRHfsJen386TbFxyV7uMSHhFMhnBKfw/de0+KKxdw8UEDDJkHWKjqhaUn5ii
	 7azLh6KOUOg1QPcFEW7WmlZWd+Mk6iMQ5ra14XCEQZT0GoHgl3R3Od9foGz36a+TYFIG/
	 E1o4XdTuUlurST9t35CHi5YIyQpCXmJEahAtVTa6O+XC/cwCNhelPuTPRHnEBvg2T0rpI
	 wAJYeCVWepWEJRFey2gXxn1+wzPg2p5FDmePnxK1S5yYZ5Asf6lmkxZhGjzMUdLREs/RH
	 X+Y/XU5AtA61aUHORaEBp8Y04JhIZ+d4LgXr/mTFImgFcoMnSTRMgDr1I8vGiKCHUwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602266;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DTuxe+dlHO47IgEyitWXf2JSK2ZTU4ij9QQciQeQagY=;
	b=1a+o/hfVLDj6ZEpBxZDp/+hiHnUJkBmi8h+N58ihBYUcI0lgWaI/94cOW5LVCS7s5mfJ
	 cxsRG02/byQcUn5YMPvtdHM8j3/KNhEXOKRMY0vmuBVB86T0zETtB+DdcpircSTiqGDzd
	 5nCOzDRCFvBv9JTKPddFw1XcxSrT4/72o8MKVeW06dXTk2GjwcpK7BpIdmpNyRIDWeqdK
	 F31rixk1JTiAVAR668lXRwIe0cCQGdyotGSH/cxaEE5+1iDO6AJr4FZncE+6Qf05i5g+Z
	 Zxuiqi9meEOOwBxYEcRmFcZcyUtoUPPraKXmWRWkZpNU4GTBJsuTr2i+aJx1CaaNSzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XdlXdZcr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A45606A338
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XdlXdZcr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC1B1F000C5;
	Fri, 13 Nov 2026 20:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602266;
	bh=DTuxe+dlHO47IgEyitWXf2JSK2ZTU4ij9QQciQeQagY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XdlXdZcry4SR1j5YdFsjOpOO7qsnYop5g9gDFFJ3HrCoqWMLmfLz7uesHkOEhmUzw
	 wdn0y1HDUONvT8QK0qVgW1uZIzEOGUfLsMFXI+q6AsEA4CRNBUdyqqQlKVsFn773md
	 RPU54pxfZjBvMmIUn4lXwWEFYMUWGIjc93qMl3ggmXfkDniP/DPLOnfEOe2mU4LxGx
	 shJPejRWEVsbZ9XITDo8ijiAYWpQ4kTVBUrCO4FEwb+aFC10NYqoVfsaHwPAqKzgOW
	 duLgId+2pPW62Rk7vqqWc0TNeZTjoIJr4OEoVZG9SIPob/1MsQohIPAe8iYx5jDRZd
	 A/Vvt4b7veRXw==
Message-ID: <sashiko-outbox-213660@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 26/30] perf metricgroup: Improve matching of metrics
 to recorded events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-27-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-27-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:37:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Matching metrics to the events of a perf.data file compared only the
> perf_event_attr type and config of events, which failed for common
> cases:
>=20
>  - Legacy hardware events, such as "cycles" with "perf record -e
>    cycles", didn't match the sysfs event, such as "cpu_core/cpu-cycles/",
>    that metrics are parsed to. Use the evsel matcher, as used for metrics
>    sharing events, which compares the PMU name and counter encoding,
>    converting legacy hardware events of core PMUs to the equivalent
>    sysfs event's encoding. Add an EVSEL_MATCH_RECORDED mode to the
>    matcher that tolerates the exclusion bits evsel__fallback() may have
>    changed when recording, skips unsupported events and prefers events
>    with counts.
>=20
>  - A recorded event could be used by only one metric leader, as metrics
> [ ... ]
> where the json metrics use sysfs and json encodings of the events, such
> as cpu_core/INST_RETIRED.ANY/, that now match the recorded legacy
> events.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D26

