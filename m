Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C99391828
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789767133; cv=none; b=musiz+7k8Li11ocvmrsFgoFD4vdW2kkML8V5sygj/khfMpoJNNmYayQwMwWRbYrW9ZTgWyryvDzkeuelrfkx4Q1QTkRwzZNzihupRNLK1Zbm+UB8qsIbBJEl/YKEHczQRiZeHiMAdW65nH/xjK3DDWT2acSDd5LGnQR/rSBraJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789767133; c=relaxed/simple;
	bh=P+BGPsU/X5+2NY7BsI1ueHxzE1uq063p+51ZZsUsFAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HvZkDYVD2B3g0g+2/kPoc0nslXRl1YdAe4dZpaG0/QKWGIwTQtWfAH4fR2ucrIOCxaIqeVQnknMUGKweyChc2qRqTH4UGwPz8LtKWmWqWQgyQQabCCoqJTi5byvsfO7d8WtM3kkXi45pUKRtSJk2CXCSKy7KjeU6nTfDGHh6+JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNafObxP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNafObxP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA481F000FF;
	Fri, 18 Sep 2026 21:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789767131;
	bh=P+BGPsU/X5+2NY7BsI1ueHxzE1uq063p+51ZZsUsFAg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DNafObxPAqfJjVkTtKabztOF/bn2My1Knf/t2HFDZJsH29Dl7/8SRMO9gyPzRY53B
	 Poys8ecodD9PV9mn6c9Ls0PGmjaF4yQaGpSaJ3KVFZ8noLX2XXX/A77o8+YXIQIIri
	 ZXwPw/i2FCi4huFYO8lgZdjjSHvjEyqlMgLXWYSJekwL6A2xQKuFGHx46MGyEMpzFc
	 LfZCBkVUn0fZ0FiRLQDDU+vQ5rLdiMboNG9VrfGVFZr7BLQy5WE0qvUJFT1BxGVUWN
	 Qiq7KAkq8CP0WFpvHyEsi3YUh7mqbmZZne3oZlUBk07f9nuAeBX9X5T1QSgTvRCz7B
	 YhM8XzEt6+80g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/18] perf trace: Enumerate the target again once
 BPF is attached
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918211932.2966061-10-irogers@google.com>
References: <20260918140659.2501976-1-irogers@google.com>
 <20260918211932.2966061-1-irogers@google.com>
 <20260918211932.2966061-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 21:32:10 +0000
Message-Id: <20260918213211.5CA481F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> evlist__create_maps() reads the target out of /proc, and the BPF
> sched_process_fork() program only sees what is cloned once it is
> attached. A task the target creates between the two is in neither, and
> since cmd_trace() drops the sys_enter evsel in favour of
> __augmented_syscalls__ there is no other source of enter events. Such a
> task, and in turn everything it forks, goes unreported for the rest of
> the session.
>=20
> Read the target out of /proc once more, after the attach. Whatever
> existed before the programs went live is there to be found, and whatever
> is created after it is sched_process_fork()'s to add, so between them
> nothing is left out. Doing this before the attach instead would only
> move the window rather than close it.
>=20
> The enumeration follows the same rule as the BPF programs, which is that
> [ ... ]
> N squared times. On a 64 thread target that is 4097 of them, against 65
> once the ones already read are left alone.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918211932.2966=
061-1-irogers@google.com?part=3D9

