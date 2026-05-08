Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DB735C1B1
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243458; cv=none; b=GDivzkb0CNG0yhmXcNPzoHQfrnEU1QS6/qAIC8oDHhpxcsZkOE4yrqxlzpS29be5PZe0L4754mdeMQsCAHLcg+BNPWI4r8z0rPOTR3z7P41AiV6EBo4jKOXFiGcksGHQjVSVbHHosgJASMo/9PV1UrokANm90EAI007wjAomLJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243458; c=relaxed/simple;
	bh=uuhX0NAF8dj3e6JcXJ3S3701D6C+E0mVVNI9MRhgG8M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a8YApV8bnX2HB1MqpaQS5iwF4ricYX1MAxzY0OiL81UlXSupjOsol8tIMRpKKh+g3skSNROXD5kKilKJkSCbj1hmX53xKQqYpG79b18rDJFeQE8V5zlf+6565h9cevP5PmXmFGzGi8ZywpEI4piv8pLys4DLTGCUdynvWWjp9yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RS7HPs4q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RS7HPs4q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CBBC2BCB0;
	Fri,  8 May 2026 12:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778243457;
	bh=uuhX0NAF8dj3e6JcXJ3S3701D6C+E0mVVNI9MRhgG8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=RS7HPs4qCH5Ps9Ovkr7Tg2KYpoLbc8zBhOHq8rR8vu7BnAuVpxi635lFhCAnH3S57
	 ttpLrGTuD0RUU9Lg0BLUI+We4J54Wf6XtxgPI3tTAydGHF04NKwqaIvcXzKSnbhonb
	 SRADjpvGtUm9R2J9ukQPeAGZh2eZMsTFXOkDH1ynxbwzD4yhaVQ8CCrwvMUb7VVdIT
	 P9bCB5ms/IRYBYkH9AT6lR8hhFBfvz6yBxyjRIeURw0n2eZpk8E2s9o6WBpgX9G59s
	 1HNxkx1gOA+D260vp6pBIecBjVpZFyQxSrWXfi35WLKm8XVzN79NGYyJnm2mQ59Pcu
	 5g1AQQEunglkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] perf trace: Sync uapi/linux/sched.h with the
 kernel source
Reply-To: sashiko@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260507072632.37152-5-namhyung@kernel.org>
References: <20260507072632.37152-5-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 12:30:57 +0000
Message-Id: <20260508123057.98CBBC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Build Script Regex Regression
--

commit 95b9a74eb48111bfe1440ab1eb342b9d9108af43
Author: Namhyung Kim <namhyung@kernel.org>

perf trace: Sync uapi/linux/sched.h with the kernel source

Syncs the tools copy of uapi/linux/sched.h with the kernel source to pick up
changes related to clone3 and unshare flags.

> diff --git a/tools/perf/trace/beauty/include/uapi/linux/sched.h b/tools/p=
erf/trace/beauty/include/uapi/linux/sched.h
> index 359a14cc76a40..33a4624285cd4 100644
> --- a/tools/perf/trace/beauty/include/uapi/linux/sched.h
> +++ b/tools/perf/trace/beauty/include/uapi/linux/sched.h
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

Does changing these flag definitions from hexadecimal literals to bit-shifts
break the beautifier script?

Looking at tools/perf/trace/beauty/clone.sh, the script relies on matching
hexadecimal literals like (0x[[:xdigit:]]+) to extract these flags. Without
updating the regex in this patch, the script will silently fail to extract
these modified and new flags, causing them to be excluded from
clone_flags_array.c.

While a subsequent patch in the series attempts to fix this by replacing the
regex with one that exclusively matches 1ULL << X, this drops all standard
32-bit clone flags (like CLONE_VM and CLONE_FS) which remain defined as
hexadecimal literals in the header.

Could the script be updated to support both formats?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507072632.3715=
2-1-namhyung@kernel.org?part=3D4
