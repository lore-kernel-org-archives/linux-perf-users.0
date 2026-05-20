Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDA635F199
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307154; cv=none; b=VQEVesg5DKepkCCb5CUpREpwQJotTkRL2FnwsBV6OgjBgSxlcgjLOvDH0TfLnD/OfXhabaXb4vekeYU2f2rhPcHToYON2+tH7T+RZRFBQzo2gYcmyXd7Iy5u3WXsSZztB7L50aVqwvi6mF+tZJrVEk9Hiu84j4CymVk0sPBsUNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307154; c=relaxed/simple;
	bh=Xbw2De2eAEpaMvCoKcskhvxE6VLAQQLVL3x3BPp9VGQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sroony5UbWnQEbwiU/cA/hfpuobGwse+5o4f+BAZOHIugSc84vkJ8G5DZP8OI5tQZZ1y+vB14jIaVR/rPrIqu5OYCRS94yGkYx4UK1n2E5Jwwf+tLWM/jDgbC8qAIDHQgQ6ve0wUwsGt5F14mayihypI/FY2pge3Dg5QChc5EiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSjKFtIa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSjKFtIa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408DD1F000E9;
	Wed, 20 May 2026 19:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779307151;
	bh=ceIIOfZtyx4gsHFRV8ssZQYkYTdVLzdanT88ksdvTVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cSjKFtIaA6tZ1Le96tFbH4Jf8PWk5dZ0r5ELbfy8IZRY1Ftf9GTTNjrqmGEYxLL49
	 BEZ+Qen9xWVE51XwyEvNjK0MFM0HZtQXHMBimdAIoRAyIAhkwbL9tppEFfIYXRMyQh
	 a0CZWkF7J+8hp8sgJ/5kX8T5ZOOHpxLVveBDtiwATJ29inAFazapsCKE9JWnqszTz9
	 wkmnChqKQyNt82g5bvQR0zfZDF4PZ98vx1bWQ4h/xagctFJNkpsPGmfO8yzae0V/Ci
	 164EvhT/WhuSH8p3JuV5YwwvxIS5OEMRRhuZ1U5Yi6HQxSdUGf0/m3YxQ1v7BuHKkU
	 GfkkgtYZXo8Kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 31/32] perf kwork: Fix address sanitizer issues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260520190538.142018-32-irogers@google.com>
References: <20260520190538.142018-32-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 19:59:10 +0000
Message-Id: <20260520195911.408DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double free and memory leak vulnerabilities in `builtin-kvm.c` com=
mand wrappers.
- [High] List corruption and infinite loop when duplicate events are specif=
ied.
--

commit 603fea0ed7e7d37e22b905275e056a33548f710e
Author: Ian Rogers <irogers@google.com>

perf kwork: Fix address sanitizer issues

This commit fixes a double free in the record array caused by parse_options
mutating the argument array. It introduces a separate array to track the
original pointers so they can be safely freed.

> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index 59a54d11f7fa6..a4604e1520023 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
> @@ -2295,16 +2295,27 @@ static int perf_kwork__record(struct perf_kwork *=
kwork,
> =20
>  	BUG_ON(i !=3D rec_argc);
> =20
> +	/* Save the pointers as the array will be mutated by cmd_record. */
> +	to_free =3D calloc(rec_argc + 1, sizeof(char *));

[Severity: High]
This isn't a bug introduced by this patch, but does the exact same memory
corruption vulnerability fixed here exist in tools/perf/builtin-kvm.c?

Functions like __cmd_record(), __cmd_report(), __cmd_top(), and
__cmd_buildid_list() allocate arguments dynamically in rec_argv and pass the
array to their respective cmd_*() functions. These downstream functions call
parse_options(), which mutates the rec_argv array in-place by shifting
non-option arguments.=20

The subsequent cleanup loop then double-frees any duplicated pointers and
leaks overwritten ones. Should a similar fix be applied there?

[ ... ]

> @@ -2463,7 +2475,7 @@ int cmd_kwork(int argc, const char **argv)
> =20
>  	if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
>  		setup_event_list(&kwork, kwork_options, kwork_usage);

[Severity: High]
This is a pre-existing issue, but does setup_event_list() cause list
corruption and an infinite loop if duplicate events are specified?

The user-provided event string is tokenized by comma. For each token, the
code finds the corresponding kwork_class from kwork_class_supported_list and
unconditionally adds its class->list node to kwork->class_list using
list_add_tail().

Since class points to a statically allocated structure, adding the same eve=
nt
twice (e.g., perf kwork -k irq,irq record) calls list_add_tail() on a node
already linked in the list. This corrupts its next/prev pointers, creating a
circular list and causing subsequent list_for_each_entry() loops to hang
indefinitely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520190538.1420=
18-1-irogers@google.com?part=3D31
