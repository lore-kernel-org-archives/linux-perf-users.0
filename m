Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12913BED5F
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148006; cv=none; b=SCS06rapRNOxQRdhTd/4xTsXp2wUNkBHg234sJlWT+EXI7bGyWfMDH+2q0pEOZpLdNBFb9koCCul56c4vh3GA7wpTYk9yqDm6s+y3k6sR2NbOtcBOIa7rMgqVunOxcXoZU+ryg4uJXF7aWHQ0bbf/CKF8MbXx2z77MnA5MM2kXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148006; c=relaxed/simple;
	bh=1fZc34nK/raKwcDOVYaPd2f1kYpEBceyYag/7gLqJ+Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QfB7YB+PUTE39oQfxkk+U/qQPpiextt7JISdVVPXlzAKNKYT4fhAlu+VfyX3jNNtd5yz5Yljw+IvEjL2i9gvx8Uxr+JIAYKfSDyOjBIS+WjaoZpmptuSMtNG8kB/xqg22hn0iT/tJfqkU7OqAESNYiA59UzAHATECnz1OgHjdCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AALEVGXH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AALEVGXH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B92E1F0089B;
	Wed, 23 Sep 2026 07:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148001;
	bh=1fZc34nK/raKwcDOVYaPd2f1kYpEBceyYag/7gLqJ+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AALEVGXHTObUKSf5nusa6PJfJAf5zX9OM6GZbCrwFWk3ULcCc4UqqxdxmT9ElM12F
	 aFDxKjv4IJM8DWCpNHA4vvDKLmbc6L611SGon1U7fihVl7End/wrJzmJQYc79XAccm
	 Xx5qEe7dqah3/Ap6SrO50C4g0QuechlMkHlBqasxErmwfsyVjmcUYwTfJozvNVpN7R
	 nf2otaUFxwUIcSk/9joUYL575Jsw+NJXhZ71BnBC+5WZl0Ql9QPPR1rqJ8CgR3fPWF
	 NcbUIvVtMgZLt54Wvd1sD6vMURKLn8SKxNBFcEG2O3WrK46SvpBo5IhhP+4wHOIyhz
	 zKm38GzkcMPAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/23] perf trace: Include the headers declaring
 pid_t, strcmp and assert
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <4add8796a95e7cabee2a8094d6babdb39290bfe8.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <4add8796a95e7cabee2a8094d6babdb39290bfe8.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:20:00 +0000
Message-Id: <20260923072001.6B92E1F0089B@smtp.kernel.org>
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
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D3

