Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5B03A3E8C;
	Wed, 13 May 2026 05:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778649718; cv=none; b=uPbDWbHZO+Q6f6NPirhtgStMBP+1RfmAjjdT4ZL8ydZ7U5a1f/Y0XsAVJcQsH+nmgE8MbzMRIyhO39gqL5qaHMGjU5SA925OPA/gNeXrEQNlk/4U5pwECLY8keR243V0Coyg1RlMjufM3rk1damHMQcBlWGmUK7xn0MTPywa06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778649718; c=relaxed/simple;
	bh=HfM2DR9A7SNbC0hHigUn6V3W2TthJ86Xztd/eDVmE8Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q9aWl2C9d3OQ41FKZThqJ8Ky3O7y8ZB56rR6o0H35IwGD70cTk55itxQWs4OEtUR8fuTQOKrse4fOfCSDNNQ7IitIxBCKbj7B7Ve+Ijm1viFPn0xfjTBJ9uhYCEj5PwQliwdAsPpr2nJ5XoEotdzO+94CzodlMGR53KgQqsa1MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utOBHXXc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utOBHXXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17D3C2BCB7;
	Wed, 13 May 2026 05:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778649718;
	bh=HfM2DR9A7SNbC0hHigUn6V3W2TthJ86Xztd/eDVmE8Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=utOBHXXcVX6sUk710Z45GDOgQhTxwvv2jXDFSV6Jl2ZDSFdcjGi+og1yDyL/B6ej/
	 wFpmED7CHlGtji1+FA+txEk6PacvwrmphmUwpGqJ6nTtP3sFr1Pa7RQ9AHiGpfPyr4
	 DNs0wZ+jH8t49ZP6iDiwWWaoFM6RAZUvh+b7pXDvZRb95nCkFuXwOQ/K+7cxzC1SGr
	 7LsEeZAcfBLYqPMpWW9j73SshO5uCk5XClpfmLnCkAegtZogxjYc7TPyalazlPoOPU
	 tgI9D152fbj1tq46aB4TY7gfbNMhCHzBQg2WIvBhc0TQtH81AVvKuuY2JqUgpofKKb
	 s+OP83XuAyyzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 02/14] perf trace beauty: Make beauty generated C
 code standalone .o files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260512053539.3410189-3-irogers@google.com>
References: <20260512053539.3410189-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 05:21:57 +0000
Message-Id: <20260513052157.D17D3C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message incorrectly states that it uses a conditional=
 kbuild hook for `CONFIG_TRACE`, but the patch adds it unconditionally.
--

commit b8d8fe14745ce243d9ff4d75f580a2b157dc3294
Author: Ian Rogers <irogers@google.com>

perf trace beauty: Make beauty generated C code standalone .o files

This commit refactors the perf trace beauty framework to compile generated
code as independent standalone objects instead of inline inclusions. It also
moves generation rules locally into the target Build files to improve paral=
lel
build startup.

> 2. Create fsconfig.c and flatten embedded beauty .c files to compile as
>    independent standalone objects via trace/beauty/Build, exporting their
>    formatting functions via beauty.h and env.h. Switch arch_errno_names.o
>    and syscalltbl.o assignments directly to perf-util-y and add a top-lev=
el
>    recursive kbuild hook (perf-util-$(CONFIG_TRACE) +=3D trace/beauty/) to
>    compile them into libperf-util.a, resolving remote linkage for standal=
one
>    python extensions.

Does the description regarding perf-util-$(CONFIG_TRACE) match the code? The
commit message mentions a conditional kbuild hook, but the patch below
adds it unconditionally.

> diff --git a/tools/perf/Build b/tools/perf/Build
> --- a/tools/perf/Build
> +++ b/tools/perf/Build
> @@ -34,6 +34,8 @@ ifeq ($(CONFIG_LIBTRACEEVENT),y)
>    perf-$(CONFIG_TRACE) +=3D trace/beauty/
>  endif
> =20
> +perf-util-y +=3D trace/beauty/
> +
>  perf-$(CONFIG_LIBELF) +=3D builtin-probe.o

Since this is an unconditional assignment to perf-util-y, could the commit
message be clarified here, or was the assignment intended to be conditional
on CONFIG_TRACE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512053539.3410=
189-1-irogers@google.com?part=3D2
