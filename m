Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB11377ABD
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055514; cv=none; b=liAtqDDzJ8DiRsL4I3R/6+YlYfIt1u7eIPYIsedGTc6ZIx+5tvuaQjHIUxUQtAuoeN8iOrQK8HywIeQ7dUnI6SKvutu8riXRSd7ITzg/tlnat72hdvc660Nz29ZttC23vw1yQJyGbjVtazkXeJn8tcUuSnWU4hPWIYzR3mMp5vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055514; c=relaxed/simple;
	bh=TiWxL+ACM3Uw5T+mwF7id8+c5prarw7ChLRnH/cVio4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XZEWAzW+dFNw1KpTWKoUMVfup5D7wSfELRGJjsbwebKYxf9wVX/HsTc3XItyNTqsXW/BVasFnfqr54mUXzGmDHsDo3ClO97bsM9F94oULg9A92ScR5idzBOyQ+hjMpH7dJxEyWcWK+Qwa41tcru4W57f6MA6UdNHsYiw1zrcav8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtqn0ahB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtqn0ahB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6E71F00A3A;
	Tue, 14 Jul 2026 18:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784055512;
	bh=pj3MOqe4Wa7bYJ5pb64UnA3zrlcNAgbihyRbzSfVH1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dtqn0ahBWABFzyuwlRxoSKrU1s2F+qB8MLEAPIg8VLIWLMJumoK8N2n1GfsRJfuQX
	 oDSTXSi3u3D3mrXYiksJM6cfMk6OnSxnemrBPfKBSfm1F/5qNeBIEXihQZgQJ1fpz9
	 fH5x/9QZes0S1Chpah0x27b4jNkM1GsePVmw/U+DuUgmELPfPBym1j14c9rYW07gNw
	 evEie/Gt6pPi6DeqnSSsoHd8EHcu3IDvWRCO9xo+gZmQyjZ0ReF6Ag2aXEKMn4UF+D
	 +CotHFUn9Yn8t6K0Urc5GZSxLB1kZRK7hcqmt4PNRAohhnG9NyoNBviuKhBsbsWX0g
	 o2WWVzwXRTMig==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 11/13] mm/kwatch: add debugfs control plane
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714183316.12964-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
 <20260714183316.12964-1-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 18:58:31 +0000
Message-Id: <20260714185832.5E6E71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Tasks that exit or are killed while inside a probed function perma=
nently leak their kwatch_ctx_pool slot and leave their hardware breakpoint =
globally armed.
- [High] Missing kernel lockdown check allows root to bypass confidentialit=
y restrictions by setting hardware breakpoints on arbitrary kernel addresse=
s.
- [Medium] Lockless access to the global `kwatch_config` and `watching_acti=
ve` variables in `kwatch_dbgfs_read` causes data races and torn reads.
- [Low] The KWATCH config entry selects KPROBES, KRETPROBES, and STACKTRACE=
 without inheriting their architecture-specific dependencies, causing unmet=
 dependency warnings.
--

--- Patch [11]: [RFC PATCH 11/13] mm/kwatch: add debugfs control plane ---
commit fe07df22dbe76645eaac13880523515d1694aec8
Author: Jinchao Wang <wangjinchao600@gmail.com>

mm/kwatch: add debugfs control plane

Wire the pieces together behind a single debugfs file,
/sys/kernel/debug/kwatch/config. Writing a key=3Dvalue configuration
string stops any active session and starts a new one; reading shows
the active configuration and the nmi_rejected counter. An open-count
guard keeps the file single-open and a mutex serializes
start/stop/auto-stop against each other.

> diff --git a/mm/kwatch/Kconfig b/mm/kwatch/Kconfig
> new file mode 100644
> index 0000000000000..b1c37a829dd53
> --- /dev/null
> +++ b/mm/kwatch/Kconfig
> @@ -0,0 +1,17 @@
> +config KWATCH
> +	tristate "Kernel Watch Framework"
> +	depends on PERF_EVENTS && HAVE_HW_BREAKPOINT && DEBUG_FS
> +	depends on HAVE_REINSTALL_HW_BREAKPOINT
> +	select KPROBES
> +	select KRETPROBES
> +	select STACKTRACE

[Severity: Low]
Should this Kconfig entry inherit architecture-specific dependencies for
KPROBES and STACKTRACE?

Selecting these without depending on HAVE_KPROBES and STACKTRACE_SUPPORT
can cause unmet dependency warnings and potential build failures on
architectures that do not support them.

[ ... ]
> diff --git a/mm/kwatch/core.c b/mm/kwatch/core.c
> new file mode 100644
> index 0000000000000..548d0cdd08126
> --- /dev/null
> +++ b/mm/kwatch/core.c
> @@ -0,0 +1,325 @@
[ ... ]
> +static int kwatch_start_watching(void)
> +{
> +	int ret;
[ ... ]
> +	ret =3D kwatch_hwbp_prealloc(kwatch_config.max_watch,
> +				   kwatch_config.access_type);
> +	if (ret) {
> +		pr_err("kwatch_hwbp_prealloc ret: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D kwatch_tsk_ctx_prealloc(kwatch_config.max_concurrency);
> +	if (ret) {
> +		kwatch_hwbp_free();
> +		return ret;
> +	}
> +
> +	ret =3D kwatch_probe_start(&kwatch_config);

[Severity: High]
If a task exits or is killed while inside a probed function, could this leak
the kwatch_ctx_pool slot and leave hardware breakpoints permanently armed?

When a task terminates, the kretprobe framework flushes instances without
executing the exit handlers (like kwatch_lifecycle_exit() in probe.c).
This skips the kwatch_tsk_ctx_put() call, leaving the slot occupied
and the HWBP armed until the kwatch session is manually stopped.

[ ... ]
> +static ssize_t kwatch_dbgfs_read(struct file *file, char __user *user_bu=
f,
> +				 size_t count, loff_t *ppos)
> +{
> +	char *out_buf;
> +	size_t len =3D 0;
> +	ssize_t ret;
> +
> +	out_buf =3D kzalloc(MAX_CONFIG_STR_LEN, GFP_KERNEL);
> +	if (!out_buf)
> +		return -ENOMEM;
> +
> +	if (watching_active) {
> +		len +=3D scnprintf(out_buf + len, MAX_CONFIG_STR_LEN - len,

[Severity: Medium]
Is it safe to access watching_active and format kwatch_config here without
holding kwatch_dbgfs_mutex?

Since concurrent writes (via kwatch_dbgfs_write) zero out kwatch_config
while holding the mutex, this lockless read could result in data races
or torn reads of the configuration state.

[ ... ]
> +static ssize_t kwatch_dbgfs_write(struct file *file, const char __user *=
buffer,
> +				  size_t count, loff_t *ppos)
> +{
> +	char *input_alloc;
> +	char *parse_str;
> +	int ret;
[ ... ]
> +	ret =3D kwatch_config_parse(parse_str, &kwatch_config);
> +	if (ret) {
> +		pr_err("Failed to parse config %d\n", ret);
> +		goto out;
> +	}
> +
> +	ret =3D kwatch_start_watching();

[Severity: High]
Could a missing lockdown check here allow root to bypass confidentiality
restrictions?

Since this enables setting hardware breakpoints on arbitrary memory address=
es
provided by userspace, it might allow inspecting kernel memory in violation
of LOCKDOWN_CONFIDENTIALITY. perf_event_open() normally enforces
security_locked_down() checks, but register_wide_hw_breakpoint() does not.

> +	if (ret) {
> +		pr_err("Failed to start watching with %d\n", ret);
> +		goto out;
> +	}
> +
> +	ret =3D count;
> +
> +out:
> +	mutex_unlock(&kwatch_dbgfs_mutex);
> +	kfree(input_alloc);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714182243.1068=
7-1-wangjinchao600@gmail.com?part=3D11
