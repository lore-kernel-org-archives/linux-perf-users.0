Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677B24432E4
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627758; cv=none; b=XN7+V9jvo6/nzKx0u8L5WjiX3mlbPpfS4XfLx0F5ks/JzvH4yskSPPA1ptIRt0mSzpO1qDYmKJHtXfYfrFBJ6UmYrfI6n5PL73yPM54Uv90OCneKRacw7W8TqRTB39s7XM0WrtgSXHGn8m8er7ubk7B6AecSghRhE14wAuAYUpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627758; c=relaxed/simple;
	bh=ooWIsZJlv4IFJI2GBde6njD5C6vjD+K+cTemA7w8bbw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tw33Pj60v172Ayzsnnyllfup9JUrBXHa2+sCw5YncPDJVaY2TstIJUFNLz4aUz+xkRQmPtZEFtcHFq4xquDjXWdRbNIiHzxjafNiq2KNJpoUidPZD8UBmFQrJ38ho9gVLOD9avLjvDaFTsO91I0/w1C7tNgf/TiRbrjODizhnCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agDqL03d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agDqL03d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDC51F000FF;
	Thu, 17 Sep 2026 06:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789627756;
	bh=ooWIsZJlv4IFJI2GBde6njD5C6vjD+K+cTemA7w8bbw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=agDqL03dTgNMFDRsnQQnyz4XcI1yy0ajKVnCbJLevdmY2keSCsLt1aVtOSEwvpSbF
	 hYQ96OTV2piJJFSvgNj1NwAxI5mzCUZ5P17II36GToJFyjCfHP0dBVMzHEOMqvVZqI
	 WOJPObXynF9i4D7dmsFkfCNAwg3RoLqYa0W12m2vrqGNnwT962pQEC0nCoaYvafDj2
	 VwYveZx4HiPtJea2m5ps4b3ms+g7U+gW9k9Yczjry37Sm+XxIndDskIWqDbgtfhkeG
	 b7587FiHPBbuPKAEV3VcuX3FOBI5PnQS8/nynOLoQ/21CnTa50rguHTziNA75zB7s+
	 RFy1byr4zzNRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 10/13] perf test trace_summary: Improve error
 diagnostics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <048255184fea635f244bc8af71c34339085150b7.1789626978.git.irogers@google.com>
References: <cover.1789626977.git.irogers@google.com>
 <048255184fea635f244bc8af71c34339085150b7.1789626978.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:49:16 +0000
Message-Id: <20260917064916.8DDC51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When pattern matching fails in test_perf_trace(), print the command
> that failed along with the actual match count, the matching lines
> found, and the first 15 lines of output to aid debugging.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789626977.gi=
t.irogers@google.com?part=3D10

