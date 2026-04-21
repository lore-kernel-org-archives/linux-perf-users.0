Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60091D54FA
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Apr 2026 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776731405; cv=none; b=RiajQaE/AuQa41gipkOhVaKQ05W+lqjU1wkBYNge4xDXoy4f3gZ2cpH537X2aqQUGYdkWupABVJLYEZba3HLrACK5E9p4nURxzuVEuaaaARkeOLw575LQQhKM/0+kmvJcAvntRwAR/Gb/OF4tahlyz4+PGHhvPT517b8Zb/QqK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776731405; c=relaxed/simple;
	bh=iBwA84b6o8whna4pDwTSJQe3ci4s8oneQjepbczxCHY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K7Mxx1LrT4V14rYVPozAEouwwSxFI9H8V9sHFWEEXpKoz7W8bSK2K7an3lWSaPCtK8yEzUC7w+gqPOPy4uVyLZGmDFDvBKHQbU+OURtkq/XxRxOzc0ALKQz4cuvDHtqWpfaj3bYHb/1Egf5DU1Dc8SsKa+kbZTtELfnfwr8t+Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mN4SA5gE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mN4SA5gE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E7CC19425;
	Tue, 21 Apr 2026 00:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776731405;
	bh=iBwA84b6o8whna4pDwTSJQe3ci4s8oneQjepbczxCHY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mN4SA5gEkJHpy2tfoOTy3KLZ/ekBBCckx0XOeWR0T9jMHUtgx3fe+eulPXmJ5FAjZ
	 CcOWuMTNTppVMZN5undYRyG1JyGeGWeaM+OFL09jZL8kJ/ZFpt3sI8cLnBflXDpdJ1
	 0PL6JTJ1qUI7iyWm0+C33sOElQeBg/oLrisF/GpXkmBWn6Pe0Gu0u2k/fpkpqn0nRX
	 LN9BQbnQYgc4be/DP3v5MzyIyootz6+7n2fFz0lze8zhxDLHA7pke1JyGiWw1q/MXx
	 4rYAVVe0ZySzfXwRhohIZFG9B8e9hQOCq1bgWBIZJfqc1i6YU43iHxBXeWQ/8iI77e
	 hbPOBUc9pf9fQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf build-id: Fix wrong return value checking
Reply-To: sashiko@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260420180858.129075-1-namhyung@kernel.org>
References: <20260420180858.129075-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 00:30:04 +0000
Message-Id: <20260421003005.38E7CC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Missing O_NONBLOCK during build-ID extraction enables indefinite h=
angs on FIFOs via TOCTOU race.
- [Medium] The strict length check rejects valid 16-byte build IDs (e.g., M=
D5/UUID), causing `perf buildid-list` to fail for them.
--

commit 7e5fc011b65e40f9f999c08196173059dcbc7f79
Author: Namhyung Kim <namhyung@kernel.org>

perf build-id: Fix wrong return value checking

This commit adjusts the return value checks of the build-id snprintf
functions to correctly account for the terminating NUL byte when comparing
lengths. This ensures perf buildid-list properly displays build IDs instead
of returning errors.

> diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-build=
id-list.c
> --- a/tools/perf/builtin-buildid-list.c
> +++ b/tools/perf/builtin-buildid-list.c
> @@ -60,8 +60,8 @@ static int sysfs__fprintf_build_id(FILE *fp)
>  	char sbuild_id[SBUILD_ID_SIZE];
>  	int ret;
> =20
>  	ret =3D sysfs__snprintf_build_id("/", sbuild_id, sizeof(sbuild_id));
> -	if (ret !=3D sizeof(sbuild_id))
> +	if (ret !=3D sizeof(sbuild_id) - 1)

Could this strict length check reject valid 16-byte build IDs?

The kernel and perf subsystem natively support shorter 16-byte build IDs
like MD5 or UUID. For these, sysfs__snprintf_build_id() would correctly
return 32.

Since 32 does not equal sizeof(sbuild_id) - 1 (which evaluates to 40), will
this erroneously return -EINVAL and cause perf buildid-list to silently
ignore valid kernel maps and binaries?

>  		return ret < 0 ? ret : -EINVAL;
> =20
>  	return fprintf(fp, "%s\n", sbuild_id);
>  }

[ ... ]

> @@ -72,8 +72,8 @@ static int filename__fprintf_build_id(const char *name,=
 FILE *fp)
>  	char sbuild_id[SBUILD_ID_SIZE];
>  	int ret;
> =20
>  	ret =3D filename__snprintf_build_id(name, sbuild_id, sizeof(sbuild_id));

Does the underlying build-ID extraction sequence miss an O_NONBLOCK flag,
potentially allowing indefinite hangs?

When filename__snprintf_build_id() processes user-supplied file paths, the
underlying open() call happens without O_NONBLOCK.=20

While there is an is_regular_file() check beforehand, could a time-of-check
to time-of-use race allow swapping the file with a FIFO or blocking device
immediately after the check, causing the tool to hang indefinitely?

> -	if (ret !=3D sizeof(sbuild_id))
> +	if (ret !=3D sizeof(sbuild_id) - 1)
>  		return ret < 0 ? ret : -EINVAL;
> =20
>  	return fprintf(fp, "%s\n", sbuild_id);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420180858.1290=
75-1-namhyung@kernel.org?part=3D1
