Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94982358372
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740819; cv=none; b=Vw4BtINAXwT1hukzJGwVyaaHzGHiEQnAUCGYULiZ0BC++QbZnnozDYebdKTwrTuL0PlA5HHJadpU1k12UFHgx0RyeNxhJ0DSpbU2aPzhIGg16M/wqqGh8fmRCRBf0zJ6H06YzU6LqRNdnd8cWfL0gjK0OIhk8DHfjmpzY7UhmBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740819; c=relaxed/simple;
	bh=gDHiYnRSbivTanFjOZWz/WapsbhmA5Pu1c0lH+3rCxQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uIbyFUtITp/i9wTttASrsuJ+7dAvQHo1Z/JuA4/arMxg+ENltWvz5yxqlqo1ZG/htSkvIFMkG/uCme1Lna+mevywPV+XYNKpMZ9/uCnIs97OU8egT7/4F7mL84LEr4umNFsmJbsE1GacVbNZ8PTiJc14/bBkcKV7/A3RlSexqNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyQ526zH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyQ526zH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A55B1F000FF;
	Fri, 18 Sep 2026 14:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789740818;
	bh=gDHiYnRSbivTanFjOZWz/WapsbhmA5Pu1c0lH+3rCxQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dyQ526zHjIAvpW1c4DwJs5ty1SQlhOQRP6+vl+uREo/r+wBfQfz3vBw7R8i6FG4+D
	 NKtl+/OfEApGQ/jaWAzfKH24MePmWynB+o9ENGGlmG0W7B9S9EudFhecFwZk2e8Mky
	 NdHo//ggzTTl4/Y7VSaXCgfKOb8flkLQAQZHkjbcXv8juPEt+nPKGTDC1kDfLHOWuC
	 bMBBo+sRMdjBR5saxsGaXZ6D8Rjrn4Z3+3lkuKqvwmhJhIoiConJoI0uQJ/y2MXMqo
	 mmBWlyP0rQ8MOH5dCh8WNLl3NU00ooiltC3jLOGMOsEXSe4z93ZbatgCNoa/mBYhqT
	 a2NWy5OftU/oQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/16] perf trace: Include the headers declaring
 pid_t, strcmp and assert
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918140659.2501976-2-irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <20260918140659.2501976-1-irogers@google.com>
 <20260918140659.2501976-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:13:37 +0000
Message-Id: <20260918141338.1A55B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> trace_augment.h uses pid_t in the augmented_syscalls__set_filter_pids()
> prototype and in the !HAVE_BPF_SKEL stub. bpf_trace_augment.c calls
> strcmp() in augmented_syscalls__find_by_title() and assert() in
> augmented_syscalls__create_bpf_output(), but neither pulls in the header
> that declares what it uses. Both happen to build today only because
> something else in the include chain drags <sys/types.h>, <string.h> and
> <assert.h> in first, which is not guaranteed and does not hold on libcs
> such as musl that keep the POSIX namespaces strictly separated.
>=20
> Include <sys/types.h>, <string.h> and <assert.h> explicitly.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918140659.2501=
976-1-irogers@google.com?part=3D1

