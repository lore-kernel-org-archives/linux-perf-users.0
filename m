Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CAC18C933
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969201; cv=none; b=sSLawMX7Vo0PUMmqAzB9MD7piSQaDBfIwqEF4ShLbRJApWIQoV36hhZsGPapwzhb3rXPzKaqCgsQEFi18jjLyXU4xv3rouYTgSsKQbT77rRlPSqCId4KkJ6Wii3qoEdmHBGH5xcTxyoUZAQ6hKpRjH+LfEtf8GXy4S0rx6+yUtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969201; c=relaxed/simple;
	bh=tTjDWbld3jC8nOJ6NFMJsMejGPXN668uTy7xFhSQHeM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KpraMRkzkqYH17Y8TkALfqODXdN1kvWZlBGatNLJX7VZucXALMGy+kyxtysFzcW8wUnwQNjs2svu/JXyDbl08Q1S8eWzzJhIRfvWpr5V+X/jvYa/KSsL75dQflAYWT2YGGb3rrbJibpdlVQ80nF1jpJ7wHbdxsUvKJP6CSa1P0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqPLd6dX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqPLd6dX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8301F000FF;
	Mon, 21 Sep 2026 05:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969200;
	bh=0DeBZDpICjZI144/1Hfi0wSTFepT2zdCYbrBeyFwYD4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QqPLd6dXzheS9TGu53dzVpkE6tvuNQJyOVZxvej2RLbgzqQlETv+jqewOn7Ui2NSA
	 u9ncb2Tbb4VKTzGWJItln6nmBi47hXwoWiXHVRFAF1QO1xHds7hVufW8jlgEOSM79s
	 2oLXRB6C2ckrkH2TXkS0w17LSyAy7kNRKu7GyxncNvgpGWuouK71uyeHHH4XtDWqmM
	 Na3wxfk6tuTjCnIiInooVPLB86vjC6Z0W+FrTVwY3RJsHNLNiGVpBs2EBSdYRS1mIQ
	 vZaLEJYKGI6YXT4zfqJYjjEP9yvYPIE8en2IQxF1LHIuIug31jqfxym/pOIMFRZmWh
	 LQ7kMPaVvdr0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 29/49] perf python: Port rwtop from Perl to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <86e60126f2e97659c60583883a31e2c3e390dffe.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <86e60126f2e97659c60583883a31e2c3e390dffe.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:39:59 +0000
Message-Id: <20260921054000.6B8301F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the legacy Perl script rwtop.pl with a standalone Python script
> in tools/perf/python/rwtop.py using the perf Python module.
>=20
> Improvements compared to the legacy Perl script:
> - Remove the dependency on libperl and Perf::Trace::Util.
> - Support both offline perf.data files (via perf.session) and live
>   recording (via LiveSession with --live), driving periodic interval
>   summaries from event timestamps rather than wall-clock SIGALRM timers
>   so both live and offline runs produce deterministic output.
> - Use session.is_64_bit (falling back to host bitness in live mode) when
>   checking for negative syscall return values so 64-bit byte counts in
>   0xfffff000..0xffffffff are not misclassified as 32-bit errors.
> - Sanitize non-printable characters in /proc/<pid>/comm to prevent
>   terminal control sequence injection.
>=20
> Add a shell test
> (test_rwtop_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D29

