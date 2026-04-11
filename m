Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AB1212FAD
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 07:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775893242; cv=none; b=BMYfb8MOp2PqyhhYHjcyS13n8a53Rl6ggVX1IDK5IQpKbYVYSwk006EvNIV2ilNLiTtycp8VydSUqQiy2Z9eBg3kIABiDwVF5uBzOzBB8XM+LB935N9+WrPBpXCcXGfN+aedre02scJGUUOfgFuMCpdx1GtLZ90uhoua100geGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775893242; c=relaxed/simple;
	bh=nACq7OApREvD5u1lby0hDBf6naB8gzaKXpW0rstwcHI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QozhksjY4gtMZ7l29p1sd35pq7KQ1Xmg8RFgUtYZGUgKsq1hTl3KCLQZ1Hda4XqX0GqifCJkV1szMSwriOyyEKRh0vID8S0RoFLV5Xsp11c3FbMfyLQzMYtevp9SNYzIooc/KylSHolDvVul+Dio+IWDevFwNv4XlQaeOkiIRLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCxEGwlZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCxEGwlZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352D5C4CEF7;
	Sat, 11 Apr 2026 07:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775893242;
	bh=nACq7OApREvD5u1lby0hDBf6naB8gzaKXpW0rstwcHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NCxEGwlZhbjhg2yYLVNj5q1a4D3bh4BjhiBNLog4IreIbF2W6Hd6jg4MF2TVYpavi
	 qCcJ/Dkvu7TxsLJeBGZPO0aayEW2WZEPp2QZjxBZOB/j+7ZqvExYgfFvyX6QKD7c+S
	 DmUGQS61+8M1Pb9X8d9rRFDmomtpMqkSoAkVIhT4rRJLdWe+PX/15udp397/+8AvuB
	 a5R44BfidANV6mBS3ranHdAgyWoogS5SURifcOmMSxWWL7HBYx3KNRf3t2ZLupDG1X
	 0TUPRH1h74kymHewQtZH/dUavO/mIYv8jM3bv62KHBy5p4kTxUxM72FMB0odbfpLS3
	 pdB+ZuSNIBKHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 29/29] perf kwork: Fix memory management of
 kwork_work
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260411065718.372240-30-irogers@google.com>
References: <20260411065718.372240-30-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Apr 2026 07:40:41 +0000
Message-Id: <20260411074042.352D5C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Memory leak of `tmp.name` in `add_work()` in `tools/perf/util/bp=
f_kwork.c` due to a change in ownership semantics.
--

commit 2e5446a0c1c5c4b87f2d9f4c0b6711cbb57d82a7
Author: Ian Rogers <irogers@google.com>
perf kwork: Fix memory management of kwork_work

This commit addresses several memory management issues in builtin-kwork.c
by implementing a global cleanup function and ensuring name fields in
struct kwork_work are properly managed with strdup and zfree.

> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index 8430a79a02ba8..1b8d4e216ae74 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
[ ... ]
> @@ -371,11 +371,58 @@ static struct kwork_work *work_new(struct kwork_wor=
k *key)
> =20
>  	work->id =3D key->id;
>  	work->cpu =3D key->cpu;
> -	work->name =3D key->name;
> +	work->name =3D key->name ? strdup(key->name) : NULL;
>  	work->class =3D key->class;
>  	return work;
>  }

Does this change introduce a memory leak of tmp.name in add_work()?

Looking at add_work() in tools/perf/util/bpf_kwork.c, it allocates memory
for tmp.name via get_work_name_from_map() which internally calls strdup().
It then passes tmp to kwork->add_work().

Before this patch, work_new() took direct ownership of the string pointer.
However, since work_new() now always duplicates the string, the original
tmp.name allocated in add_work() appears to be leaked for every BPF trace
record processed.

While work_push_atom() and work_pop_atom() were updated to free the
temporary key.name via work_exit(), add_work() seems to have been missed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260411065718.3722=
40-1-irogers@google.com?part=3D29
