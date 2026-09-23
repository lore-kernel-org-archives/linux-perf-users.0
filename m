Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2540D53A3A8
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188796; cv=none; b=FEjFwMeJIi/5WLHaX+OS3sThDR5hNhK2VilKHWuj7BfzINBHYTWqKoIeulVxGcWfAM1zBMDw3LNAuPHiKqzUOBlFKL+sXqF4BLYxt1wch066sa9rn3YshkHqicj67L8Q2iNSbn8KBs3UHzYAIBWKRQYS/tJTY5sqJWGbznna+A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188796; c=relaxed/simple;
	bh=dOBthr015EMAP2KJTHNLPZbgiqfo23bxox0hLWJYYIY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fhzyQ3+EJCnbQM/3k91FEN+fnuDnOq96EOmPyaq4jbANyIpscCoO4GBv3ovqg/+Tc9aTS41eNvMGoxPUi6Lryw6KX5ksXa9/71FK8toqQjfL/nOfaEbL02PJnjfDK8h8wgUBYr5hqfr4N5O90bpNLZZAr6JUk9Se/XELWuGuqcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8YIgdBa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8YIgdBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189801F00893;
	Wed, 23 Sep 2026 18:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188787;
	bh=1g3yii2knx5hedriTZPTc1QJw4gWBPWuAImzViUOTQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N8YIgdBaadP0z7LKMKft+R8ZvN4TujdRWDVLongsIIWbUO06j5aLuBJwAR6yqo8P3
	 KVgmcabvm3U2FS6b3bby2gZL0VkKgtzV9wQxTsSbDHYaVSeRUksIUo7IIfZxYkNNnV
	 lDNfoysjex3NETouXaOVEGh/Ue83AbEmgwXufyVHnhDrfmhXghg+axBb2b5kpj0PST
	 0ncuGZ4p9A7Prkfn952yDcS15ef+c/6IX+h9fiYflXZtBkgDYwXdKijmTxAlNVwtEw
	 okOiT0I5/sdwliHFv67X5OSTH0RlNWi7bI1blFCfNcf29zKgjp2I8FbpClHFpI34Us
	 trD9Lz0OBBTXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 36/49] perf python: Port netdev-times to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-37-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-37-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:39:46 +0000
Message-Id: <20260923183947.189801F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port netdev-times.py from tools/perf/scripts/python/ to a standalone
> script in tools/perf/python/:
> - Refactor the script into a NetDevTimesAnalyzer class with full type
>   annotations to encapsulate state.
> - Collect events via perf.session and sort them in timestamp order
>   before analysis so multi-CPU TX and RX packet timelines are
>   reconstructed deterministically.
> - Replace custom argument parsing with argparse (-i/--input, --tx,
>   --rx, --dev, --debug), extract tracepoint fields directly from sample
>   attributes, and remove Python 2 compatibility artifacts.
>=20
> Add a shell test (test_netdev_times_python.sh) to verify the standalone
> script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D36

