Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D90F48097D
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602526; cv=none; b=hraJ/eWSqD1Bfs62IZmpTcHasdFv7V3hqWJs849F30mzgnIGcMylzmQjm85jxehTpK7wtaiwOSpLCWwzBS9amMasAO5gLE/h+BDMSBrSmJRRpXTpHwQR+JYmHLiQRAg0rCexPmHVIQtn+oWHJaI6G1bi/SH0//vNxQyzq8fbHFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602526; c=relaxed/simple;
	bh=VEdo0XYkd1qwbAECKezAvPI0ZpI139asF/wPl8PF0Og=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KS6yIpjkeg4HTsiJMJxcSB9FKVpDQbxaCMXpwicUIS/9WYOy7YkNltMe2rGz+ZG+r3EayKOWYds//ouoRixDnSceK/QzOorY4ldW82Zg1k92+LKKvMNlQtL6Eo3IaYMsqe9G2sJk8ft6IfodIKgXfNoeiq7aE9deIMHYATgPZGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RY+om/YY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RY+om/YY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CED1F000FF;
	Wed, 16 Sep 2026 23:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602524;
	bh=VEdo0XYkd1qwbAECKezAvPI0ZpI139asF/wPl8PF0Og=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RY+om/YYJUsuuC2dFSUfRvpzEiMQPeDNa392lfGeoZYfpz8btsMrmhI68ORoFreTH
	 i3O0F+Q5WKEdgt+hvB7gZwUgYlWRGMDH4nzemn42FJo4MjIZdcqf8GTt0MheTgF/wM
	 UDizzc/eeMP4KSBH/UNlrAUVs8tKzu6YzNHthMBdBp9/6GpO+wlCL40fGqalp2es06
	 qKZnK4PTO77dOjYnxSXb5duWyilbRGFGhyHAYi8JDdb1TbmmYs7zEEcZHQZXcr+DCx
	 zqNp4vStXLK4NxsSpCQ9lFghO7XzaFj3V8s22IsOrcayffBa2K03N7yPHJsQrYMYSy
	 6GJ17/WMKPr9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/9] perf Documentation: Add tip for hybrid event
 merging
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916234652.439778-5-irogers@google.com>
References: <20260916065248.3153556-1-irogers@google.com>
 <20260916234652.439778-1-irogers@google.com>
 <20260916234652.439778-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 23:48:44 +0000
Message-Id: <20260916234844.81CED1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add informative text outlining the IPC imbalances associated with
> merging cross-hybrid core events like cycles.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916234652.4397=
78-1-irogers@google.com?part=3D4

