Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03CC3FADF6
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 19:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777923215; cv=none; b=KKfqaKK4SiVCrS5Y4j9nrTwgia4frzasohHeUR6rUOjTR+HzzXQnCUbhK6ENe2WGKOF6bCorWTNHaNi7v4bjlps4832C5hmrsTMbyxn7mS+pcvZ3PF+bF0Y2R36tssa+HEgf6uc9oPCHvgRtvrTDKZsHjvF3HbSinoSK7Fdwb7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777923215; c=relaxed/simple;
	bh=iOZAHTLua9pTqz3VisUx4BFrbT8gl/cw7U/SwfKSevE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h6idRFwKNr1ngfXjwbAGdwngpIUCnLxvz4LULaATidbbdYoEFUhJNLkxYhJE/z8o4yoedVoPhfG8KMji5gkxcKv4HpgPda61cz7cNYnYSETNS/Dby0S7+ueviN5VLjKxgJqJ5v2O3zDwDBviiuHtLhFTXuCzPDitV9H7YB9TAlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFScb9qt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFScb9qt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F978C2BCB8;
	Mon,  4 May 2026 19:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777923214;
	bh=iOZAHTLua9pTqz3VisUx4BFrbT8gl/cw7U/SwfKSevE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kFScb9qtXbzVSHFVSLgDGzwqC+ol9x/tGxYlyZo/Uy7fCXUO0DVHq4I5lzP6GWqgd
	 2oeOZawiGHlY7mYcmvMvDZSmWbASnrfRGeC5YzHGtPBjXvqN0R4r9w5067rRqffer9
	 S3YdO00FaUKWTkxZP7uAxo/zEYx8ScH1QBQoznweTSPZ1RZgK3uwDB3yWEbfMnAQoa
	 3RejA/yWZjR9XDPe3oWVB1iVhg5RQlIngBpeW0E0Gr0hG2bow9TLG8jiqLl/Lh+56y
	 e+P0sckaWTqDmoRwd3EXhkm/ITHjIyDc98inMuuHGRYB+zuw8Jsorx5NmZD25vQGxe
	 0pa/QJCV/lt7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] perf trace: Sync uapi/linux/sched.h with the kernel
 source
Reply-To: sashiko@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503193137.27465-5-namhyung@kernel.org>
References: <20260503193137.27465-5-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 19:33:32 +0000
Message-Id: <20260504193334.9F978C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `clone.sh` beautification script fails to parse the new `(1U=
LL << X)` format for `CLONE_` macros, resulting in missing syscall argument=
 translations in `perf trace`.
--

commit 21b4f549d315112f3b383339c5af0152f585767e
Author: Namhyung Kim <namhyung@kernel.org>

perf trace: Sync uapi/linux/sched.h with the kernel source

This commit synchronizes the tools/perf uapi sched.h with the kernel source
to pick up new clone flags for beautifying scheduler syscall arguments.

> diff --git a/tools/perf/trace/beauty/include/uapi/linux/sched.h b/tools/p=
erf/trace/beauty/include/uapi/linux/sched.h
> index 359a14cc76a4..33a4624285cd 100644
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

Will this format change cause a regression in the clone flags beautifier?

Looking at tools/perf/trace/beauty/clone.sh, it uses a regular expression
expecting hexadecimal values to extract the flags: (0x[[:xdigit:]]+).

Because these updated macros now use a bitwise shift format instead of hex
values, they might be silently ignored by the script during parsing. This
would result in perf trace failing to translate these flags, printing raw
numeric values instead.

Does the regex in clone.sh also need to be updated to handle the new
format?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503193137.2746=
5-1-namhyung@kernel.org?part=3D4
