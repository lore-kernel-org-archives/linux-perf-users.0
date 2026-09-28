Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E1E391828
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620853; cv=none; b=lHeKjIdZgoNGydw6ckenevJjPg6Jl0JaPhK05bc6XEeF9hPfivJDnZv0nSByF4n8FY+Z+nBPywBsk1FSSYg/sW3EsoiNkE5+YK+Babb8LcevbZBlXz3wzRubkTAeTzJydDRJXYD5+Pf+4CKg36ymNZ/rsWm+GTgvYz1Opyovtic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620853; c=relaxed/simple;
	bh=hMEGmUJkHQkTt/KD51ZSMBZltZDDIrBN6/x3c7Y4uds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C1cmHd+d7vIZgVjw7jmFb4+/EwxLzQahvrWynUa2n1HqFSbo6MxWzVvzH322g2h1QYVRamDsHqI4eG1jdtR5tYGXNc12izZt8OT4zEy9urdSVpdph//gRTw+TNZjBVMehSD/rQ97mxgYM4v8oFVYEzgNSu7USV0FT1/P+2HVh+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlCx8P+L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlCx8P+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB88E1F000FF;
	Mon, 28 Sep 2026 18:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620851;
	bh=rPQv79Q9xOCVHn98VlWSRH8F7pWUODT5OC5tWRN78vk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dlCx8P+L2dysesU5HIMM6kstYgqga+yqMngKrjY9tgxXsf/2Og8A05teDOcNsa3Ho
	 6ojvjoP9WqYeGLjt9voOmUNc77ZDELV8+T5QixVdaVb3hoo1QOlrBZ1T7Xmmw7Hqcm
	 h0bP4GJctXw+qIEy+fQXHW5b+28nvAupaKC5gG0pKH0Hn5p1l/u4pYXa+mVReWMaoo
	 hsk0DmIejXVaBTJQpX3yUZDOc4O4MieLcxJLMTIKwRWZuhGVOahLTvo8ZmuZuikbzj
	 Ut77DI3CpLnlcRjoCotTsTRq0QHi5gpBbZpne7kCJAODPvc+X5u4/ZJ0Gr4XHjJAb2
	 ldCuUj8ALvKyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 25/26] perf test: Remove exclusive tag from perf
 trace tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-26-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-26-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:40:51 +0000
Message-Id: <20260928184051.BB88E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Namhyung Kim <namhyung@kernel.org>
>=20
> Now it's safe to run multiple perf trace commands at the same time.
> Let's make them non-exclusive so that they can run in parallel.
>=20
>   $ sudo perf test 'perf trace'
>   113: Check open filename arg using perf trace + vfs_getname          : =
Skip
>   114: perf trace enum augmentation tests                              : =
Ok
>   115: perf trace BTF general tests                                    : =
Ok
>   116: perf trace exit race                                            : =
Ok
>   117: perf trace record and replay                                    : =
Ok
>   118: perf trace summary                                              : =
Ok
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/r/20250814071754.193265-6-namhyung@kernel.o=
rg
> [ irogers: Keep trace+probe_vfs_getname.sh exclusive, as without BPF every
>   perf trace opens its probe:vfs_getname* probe. ]
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D25

