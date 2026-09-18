Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A1C52FE35
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766716; cv=none; b=DFuqYOq8rR45snhDWE/RGGXdgUDOEOQ2e0qfEjKpk5ipneN+jPZyi5WjI7nUIVDb1C9T0e9pA4MMWU80WUJqQCrJcgEP05EMraQrq1rb76mv4cvq1IldWt+Dz/NgHvnqDfJIndj73u8DHy9fDCjV8u3lbTG2webiCaVMZ0mIr4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766716; c=relaxed/simple;
	bh=YlShMXYnvTv5/dDcL0swJjYG8iOxqCxUiUCRKA8OIoQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MGom8Ote12Y4gAYnJPsbSGN89DpHGb3UIfcu9sqQv9SoAZ1jR30QRv5LUM6pghv0F4zTiiSfP8184M/n67Emk6Nm+e2TpinCQmkoVAtBx5rLxD4PhW5mm5yvOq5WgoMK49hW+3yXLUlkpW1ZpD3zpKBNRyrUUNNPvKqsY4aHn0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTTu2CkX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTTu2CkX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961A81F000FF;
	Fri, 18 Sep 2026 21:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789766714;
	bh=YlShMXYnvTv5/dDcL0swJjYG8iOxqCxUiUCRKA8OIoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FTTu2CkXAyJKwoeF37HL2tymmZwgX+tHZjSWSXy/Q/ApkvEx8CnZBVevI1/Tr0Akl
	 8Lbx0gZxo3Ao4+7e36biGA66NKvMWiZA90eDa2Xu6nvR35yW1iAFnD7953quRdEIPW
	 XurnnHNXpWH223yiLenNXc7CKmmeoFST4EaXLUv6FRrtlfeJ+7odhAPENDkX0NAfiG
	 yHXEH21PreeUYMVIKukjtl7aQ7Y94E86/HSWxr1xX+PmEY2NacJ0fvwOtH7ucPHluF
	 /xHGg4sewR54clpaR4eSf+CSdVCRLWfBx2RBvJKCdvGFFhbWTgMxDUnrCQLH7pmg8m
	 5w0COPBRmlrXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/18] perf trace: Include the headers declaring
 pid_t, strcmp and assert
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918211932.2966061-2-irogers@google.com>
References: <20260918140659.2501976-1-irogers@google.com>
 <20260918211932.2966061-1-irogers@google.com>
 <20260918211932.2966061-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 21:25:14 +0000
Message-Id: <20260918212514.961A81F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918211932.2966=
061-1-irogers@google.com?part=3D1

