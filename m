Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6751E9B37
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415874; cv=none; b=mPTTLKIHPXtsX0m+aHauQaboSCgYw1V8v+5JMa90L5x9MLf8dGkiJmBiEv4gEXHxu643H1/PfhttqOSdKNM7QdmmVBvPes2pveFNAFRGI116Py4TDMjIo8OofPiZTY7K2S7be3pcsj0Ln2pBw/W57wd+Gfm8hccVoituDs96/yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415874; c=relaxed/simple;
	bh=MzKhabOQN9D9LhNytwpXvHXM2jhqz25JqUct6U/Z/YA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pqvMDhFNSeCMG6j3ti02CcLMrBxqMc1zyNFE+/KKUlwmMvVij4cIp/NMiSWgkN0FmVnci3sqw4hXauXYvG+1yiF6WvZ4EHq+jCYXxOvh93N5W69Gpj5sS1GsDrToZt576pmbUH8VwvxA/f3bMiL8qyhgFF6CN5FoXwZFjOEFeHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgRl7qtI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgRl7qtI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538051F00893;
	Tue,  2 Jun 2026 15:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780415873;
	bh=Y+xFIvtEU/3HjAr56iFg/2cgMU4aFFLFE8Nviq4OK1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FgRl7qtIWZCeq/LEskchhS70YUYCMc/vapMpSVRy7U+/Rcs/4JVdhkFCy2W47L0da
	 FigHHyrMjPVgXqvl78UWJfFEPaOKMgLRysTEioBkcrwGw9y05KQ4iRmtku87rFgIXN
	 Tn/qsGfj2XXPn6rYblBLLvFLPjCsge/6AG4Twjkls4xzvJCuAQDLB+VRArQkvWu96q
	 m44g+/WBK3h1/Eh45+VPxyCVegGG3O38fS5KyodNcSTNDmBADKCtYenFWSYeszAORh
	 mGG7G1Q2i81GhG/JwiPh1PdDQxSYvckSFnRsTaiKqIadB6aymq9fuKkGg0ZZQK0IAj
	 dpjDhaAAjaOMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 16/19] perf env: Add mutex to protect lazy
 environment initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602152516.2831152-17-irogers@google.com>
References: <20260602152516.2831152-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 15:57:52 +0000
Message-Id: <20260602155753.538051F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The introduced `env->lock` is not used to protect `perf_env__e_m=
achine()`, leaving a data race on `e_machine` and `e_flags` initialization =
despite the commit message's explicit claims.
--

commit 2c2484a173309974342a90986d80903317702365
Author: Ian Rogers <irogers@google.com>

perf env: Add mutex to protect lazy environment initialization

This commit adds a mutex to struct perf_env to protect lazy metadata
initialization from concurrent data races. It includes the addition of the
lock field and the mutex_init() and mutex_destroy() lifecycle calls.

> Introduce a mutex to 'struct perf_env' to safely protect lazy
> metadata setup, such as os_release or e_machine resolution,
> preventing concurrent initialization data races and memory leaks
> during multi-threaded profiling or symbol loading.

> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index 83e74328798f1..6aaf80c640bd0 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
[ ... ]
> @@ -156,6 +157,8 @@ struct perf_env {
>  		 */
>  		bool	enabled;
>  	} clock;
> +	/* Protects lazy environment initialization (e.g. os_release, e_machine=
). */
> +	struct mutex		lock;
>  };

[Severity: Medium]
The commit message and comment state that the new mutex safely protects lazy
e_machine resolution, but is the lock actually utilized for this?

Looking at tools/perf/util/env.c:perf_env__e_machine(), the caching
mechanism writes to env->e_machine and env->e_flags sequentially without
acquiring env->lock:

	if (env && env->arch) {
		env->e_machine =3D e_machine;
		env->e_flags =3D local_e_flags;
	}

Could a data race still occur here if Thread A sets env->e_machine and
context switches before setting env->e_flags, allowing Thread B to observe
env->e_machine !=3D EM_NONE and read the uninitialized env->e_flags? Should
perf_env__e_machine() be updated to use the new lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602152516.2831=
152-1-irogers@google.com?part=3D16
