Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068E2393DE2
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 21:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622841; cv=none; b=pgiCWUW2sDMUQnsp+4OVh39J8H1GdIjVvUnJsr2Gxoali+etiAkXmsw1lzOPqY+wMOmsasAxE0Yy7x+0XAC3SEhxufITcrCsJP1JiFdwmzSPq9bf4A04sgw/3cd6UjJG8fOfiN+x5JGeOL7E8/nClkt2KwSD0c8sRW+VDSj+cis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622841; c=relaxed/simple;
	bh=bRgzZ2ml3WYm+GjSGtb2RLcCs4Zv27790EQm7ZfbUJA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R7A7FlcTEN9kxOilyEfD3dy6YIFW0WuS9yAPIHY1S97KUd+SImsxEScEcz2NpvIb4dgUxixehf4PrAmZbHPPe/xj+bwjHfwjI+ZlWKw/f1QbYLrSuUip1Uu7On+wX8di+SlbVp3qPuBERbv9XvmBoFLK62gA91frKpB8istEBE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfLZcz4e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfLZcz4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1D2C2BCB0;
	Tue, 12 May 2026 21:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778622840;
	bh=bRgzZ2ml3WYm+GjSGtb2RLcCs4Zv27790EQm7ZfbUJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pfLZcz4eZabrXxb/ZYtcxTu5VFAnQz+3fRkEScUYF39diT4N05J9oQqaVBPuxDT7e
	 vGquxRGJLKZab/4uLP6mM0etg4zVfKFZ5Q1WACzuVlQfl76dgmKtr+LjP7GRNWLoC2
	 iF5dumUfvybn0IpUUEW1gmjLUxIhKmkXmOPbY2p3kMVsUN5vslZ3tzf5KxGk8VA9bX
	 PzX/yHHnNF/9Acxk6T350+F/8wlmdQ+GKet6UH7l8Pzzq+MfdqzgYOD257IKZBN3Dm
	 xd03BdPcLnoWD5G9BnvvSh+but/HzVIxsG/+lpSS+8LNFpQkJAbIrvuK78Tn+5Ht7c
	 56/ddcAKW2mBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] perf trace: Sync uapi/linux/sched.h with the
 kernel source
Reply-To: sashiko@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260510202346.49853-5-namhyung@kernel.org>
References: <20260510202346.49853-5-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 21:53:59 +0000
Message-Id: <20260512215400.7A1D2C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The perf trace beauty script fails to parse the updated CLONE_ f=
lags.
--

commit e023642b20fe09480cd6197b5038b768b3c71c47
Author: Namhyung Kim <namhyung@kernel.org>

perf trace: Sync uapi/linux/sched.h with the kernel source

This commit updates uapi/linux/sched.h to pick up changes related to clone
flags and mount namespaces. This is intended to beautify scheduler syscall
arguments in perf trace.

> diff --git a/tools/perf/trace/beauty/include/uapi/linux/sched.h b/tools/p=
erf/trace/beauty/include/uapi/linux/sched.h
> index 359a14cc76a40..33a4624285cd4 100644
> --- a/tools/perf/trace/beauty/include/uapi/linux/sched.h
> +++ b/tools/perf/trace/beauty/include/uapi/linux/sched.h
[ ... ]
> @@ -34,8 +34,12 @@
>  #define CLONE_IO		0x80000000	/* Clone io context */
> =20
>  /* Flags for the clone3() syscall. */
> -#define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler a=
nd reset to SIG_DFL. */
> -#define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup=
 given the right permissions. */
> +#define CLONE_CLEAR_SIGHAND	(1ULL << 32) /* Clear any signal handler and=
 reset to SIG_DFL. */
> +#define CLONE_INTO_CGROUP	(1ULL << 33) /* Clone into a specific cgroup g=
iven the right permissions. */
> +#define CLONE_AUTOREAP		(1ULL << 34) /* Auto-reap child on exit. */
> +#define CLONE_NNP		(1ULL << 35) /* Set no_new_privs on child. */
> +#define CLONE_PIDFD_AUTOKILL	(1ULL << 36) /* Kill child when clone pidfd=
 closes. */
> +#define CLONE_EMPTY_MNTNS	(1ULL << 37) /* Create an empty mount namespac=
e. */

Does this change break the beautifier script that parses these flags?

Looking at tools/perf/trace/beauty/clone.sh, it appears to rely on a regex
that strictly matches hex constants like (0x[[:xdigit:]]+). Because the new
flags use bit shifts instead of hex values, the grep command in the script
might fail to match these lines.

This could result in both the newly added flags and the modified existing
flags being silently ignored by the script, causing perf trace to fall back
to printing raw hex values instead of the beautified flag names.

I noticed that a fix for this regression was provided later in the patch
series in commit 640ffc6a21fbc.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510202346.4985=
3-1-namhyung@kernel.org?part=3D4
