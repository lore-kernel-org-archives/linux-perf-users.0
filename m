Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2C72D836D
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778782700; cv=none; b=LVlU79K+RkK4qB9Hpxc3PqLyro4iDoxsRpb82DnAIqjZ7rInHjBqWd5q0xbECUJqFdZE00TCsH887cE4mFESW5Wqe1zbDb6AWqP2zNrxzIVJIyxXYx4zEkQCK6xhy5f8pAcbVRMM3Qy8/BdG9dMraUS+RuqEzh2eynYTTtpXKEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778782700; c=relaxed/simple;
	bh=046HVd/IJMN4MEDQEVXjx869rYGDyFMCiq8Ll7HV+oQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=En7koSjNAOfoLTu1Bh9fXCaR3bUOJkw9zbbN0ngseKMf6fluVvRAcjJTfesAOhI9V5xzeyKDJKMgEtT1+8tqPKCSRIpjFzhKEXzBhttwY8eHUQwJbIwaTDkwpoc2O5nEQAA+iTNVrTo1ychKB/mHWh4SwOCp9WX2KtKvIIUP+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6wemSxj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6wemSxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0713C2BCB3;
	Thu, 14 May 2026 18:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778782700;
	bh=046HVd/IJMN4MEDQEVXjx869rYGDyFMCiq8Ll7HV+oQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=E6wemSxjsSDPRtdxdNn4YhTzDFHz6+07UAQWoP+4NFDwoii1qRN9dgBr4px8Py4l/
	 gA91fGywkIstniZRlLE/mURaQFAUsHUDP/ug1Wokta6LkJcw5fHOR6jvly2AypLFBc
	 qJWZA9zs4JAaLOA+wbcdEWgR8pB0Lqe80bGJ7XueVdx/lm5ACTgDm1OZ6J89ujek8v
	 MJVJPY9nES56o7I4vUMQN+XstKbMohG5fcz5+Z3B7kyK/+CIv3VALJU7ssUX6r8fIW
	 OI49pc+Z+zeEKbI9pf34QGRqIB4A7CEEwoOOQTkQmPXtHKzReoQgsjRI19YyHwBtqn
	 MKbYbp23JTmNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] lib/tests: test_ratelimit: fix stress test thread
 lifecycle and leak
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia He" <justin.he@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260514050455.2954509-8-justin.he@arm.com>
References: <20260514050455.2954509-8-justin.he@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 18:18:19 +0000
Message-Id: <20260514181819.C0713C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Use-After-Free in kthread_stop() due to uncontrolled child thread =
exit
--

commit cb9c7c9c5b3cf7b61d434d8dc2e4e72ebc4cfd3a
Author: Jia He <justin.he@arm.com>

lib/tests: test_ratelimit: fix stress test thread lifecycle and leak

This commit changes the stress test to use kthread_create() and
wake_up_process() instead of kthread_run() to properly handle creation
failures. It adds an out_stop label to clean up successfully started
threads if a subsequent thread fails to start, and resets doneflag
before spawning threads.

> diff --git a/lib/tests/test_ratelimit.c b/lib/tests/test_ratelimit.c
> index 33cea5f3d28b2..64f26260c0d85 100644
> --- a/lib/tests/test_ratelimit.c
> +++ b/lib/tests/test_ratelimit.c
[ ... ]
> @@ -105,26 +105,44 @@ static void test_ratelimit_stress(struct kunit *tes=
t)
[ ... ]
>  	schedule_timeout_idle(stress_duration);
> +
> +out_stop:
>  	WRITE_ONCE(doneflag, 1);
> -	for (i =3D 0; i < n_stress_kthread; i++) {
> +	for (i =3D 0; i < n_started; i++) {
>  		kthread_stop(sktp[i].tp);

Could this trigger a use-after-free if the child threads exit before
kthread_stop() is called?

When WRITE_ONCE(doneflag, 1) is executed, the child threads running
test_ratelimit_stress_child() observe the flag and return, which invokes
do_exit() and drops the task_struct reference.

If a child thread exits completely before the parent loop reaches its
kthread_stop() call, kthread_stop() will attempt to access a freed
task_struct. This appears to affect both the new error path and the
normal teardown path.

Would it be safer for the parent to take an explicit reference via
get_task_struct() during creation and use kthread_stop_put(), or
alternatively, have the children spin on kthread_should_stop() instead
of exiting immediately on doneflag?
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514050455.2954=
509-1-justin.he@arm.com?part=3D7
