Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43904377A9D
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054913; cv=none; b=ZBGdR6QQ/0aUP4hD7ErktZ7fwQyvCKoefN1rB966edloxCTtt1wLr0XlSyN7OaLCMbbLYkMvtbLnVWOykDUMvlHoQjP1XzbYDIfny63xwwfIPMQqwqyIS0zfq06S6L2OAd9wk0WA7C89mSY/z//6qLR88YhgW1Mu/3sMBxNClOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054913; c=relaxed/simple;
	bh=+/Cw+wyPr7I9T1qp40nXxNBSIYpOEuhMoXKuqhiRTQw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jCcyXdEd8l6saZi85sx66ULpBs8gHRTorHVEwCj2O+W3o6SzCccsu0tS+N7G83S4FccatmYgb1hvZhfT5V6UVAI32hMX82IvroDal41AimnF7/Zi4qFAzBtaLc6jOTEESymFPeAmey2r89bXXog7nX+USJ3gED+sp7eweVzUKHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWX+3UA1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWX+3UA1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485E31F000E9;
	Tue, 14 Jul 2026 18:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784054910;
	bh=ReoGPcl6l6dB2vuHHfk4sSkMRtPjD08bQfKkqI7BEa4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AWX+3UA1WPwRxLamO1pZ0FGQkntMQ5dRNMPx+uTY4xPV5JDOZ1VV51NFnU//t2gci
	 1aV8hGVoOLHyAqu+GeKZ4hVEATLcTD/afcqQM8GcwdXpRdoutIhbMcVJGBJruAUrMn
	 C1+ZXRI7ECK2KNJz3K4E4Vxtm57t6sjHsdWlb0KCf9Gq0fPxwI/epnnPOFfW8sWqjQ
	 NPnBJkijIguS1++Y4uxZHBmhOMqY+vOW1q4QNYjB7MiWjB7E9Ga1EVHEKACtcHonSH
	 cu6WaRFSP7XBF6ZG3RDyrSPsK1t1ZtgkUHkdZWjYMB1zHwljllXJfFDaE6IsHF4xrj
	 LjRhHE37Y+U8w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 10/13] mm/kwatch: add anchor thread for global
 watchpoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714183253.12848-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
 <20260714183253.12848-1-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 18:48:29 +0000
Message-Id: <20260714184830.485E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The anchor thread sleeps in TASK_UNINTERRUPTIBLE, artificially inf=
lating the system load average and risking hung task panics.
- [Medium] The thread's polling loop violates voluntary sleeping rules by c=
hecking the exit condition before setting the task state, leading to a lost=
 wakeup.
- [Low] The function `kwatch_auto_stop()` is called in the work handler but=
 is never implemented in the patch, leading to a build failure.
--

--- Patch [10]: [RFC PATCH 10/13] mm/kwatch: add anchor thread for global w=
atchpoints ---
commit e6c643e7bd2882c0ca1793a1b13c96d1e132942e
Author: Jinchao Wang <wangjinchao600@gmail.com>

mm/kwatch: add anchor thread for global watchpoints

Global variables have no function whose execution can bound the
watch window. Provide one: a kernel thread sleeps for the configured
duration inside a dedicated noinline function, kwatch_global_anchor(),
and the probe runtime hooks that function like any other target.

> diff --git a/mm/kwatch/anchor.c b/mm/kwatch/anchor.c
> new file mode 100644
> index 0000000000000..11da6aff94133
> --- /dev/null
> +++ b/mm/kwatch/anchor.c
> @@ -0,0 +1,82 @@

[ ... ]

> +static void kwatch_auto_stop_handler(struct work_struct *work)
> +{
> +	kwatch_auto_stop();

[Severity: Low]
Does this cause a build failure? This function appears to be referenced
here but isn't implemented in this patch, which could lead to an undefined
symbol linker error and break bisectability.

> +}
> +
> +static DECLARE_WORK(kwatch_auto_stop_work, kwatch_auto_stop_handler);
> +
> +noinline void kwatch_global_anchor(unsigned long duration_sec)
> +{
> +	wait_event_timeout(kwatch_anchor_wq, kthread_should_stop(),
> +			   duration_sec * HZ);

[Severity: High]
Does this use of wait_event_timeout risk triggering the hung task
watchdog? Because wait_event_timeout implicitly uses TASK_UNINTERRUPTIBLE,
long watch durations could trigger a panic (if the watchdog is configured)
and permanently inflate the system load average by 1.0 during the session.

> +}
> +
> +static int kwatch_anchor_thread_fn(void *data)
> +{
> +	unsigned long duration =3D (unsigned long)data;
> +
> +	kwatch_global_anchor(duration);
> +
> +	if (!kthread_should_stop()) {
> +		/* mark before scheduling; cleared under the control mutex */
> +		WRITE_ONCE(kwatch_anchor_expired, true);
> +		schedule_work(&kwatch_auto_stop_work);
> +	}
> +
> +	while (!kthread_should_stop())
> +		schedule_timeout_uninterruptible(HZ);

[Severity: High]
Can this loop also artificially inflate the load average? Sleeping
in TASK_UNINTERRUPTIBLE here will add to the system load while waiting
for teardown.

[Severity: Medium]
Could this sequence result in a lost wakeup? The stop condition is checked
before the task state is set. If kthread_stop() signals the thread
after the while condition is evaluated but before
schedule_timeout_uninterruptible() sets the state to TASK_UNINTERRUPTIBLE,
the thread might sleep for an unnecessary second before observing the stop
flag.

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714182243.1068=
7-1-wangjinchao600@gmail.com?part=3D10
