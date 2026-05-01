Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181443F0A85
	for <linux-perf-users@vger.kernel.org>; Fri,  1 May 2026 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654474; cv=none; b=aziwsv9LyASejJQqdWTkafXWhPhyrUa9JHCzrFx6HHTTeI6jKz7KER9Mtx2INnPIVLdQNNRAW//zF6KiN/o2hy9+m4ISytRndVqGsxFuNLK70hsM9iuLt9YiLBS7bUWu8m6o8/rEP4q5CtkepdktVMNMEc2zrUFuWzkzzqqSpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654474; c=relaxed/simple;
	bh=+K8MmTBikTSyUTpQNJUN80b+sHdqeZFXCzVSWSNfXkg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k606LD3vVkFI2D6fRp0Z2qjQS1LGgk9I7lkhkc+QDRsZHHyhhzhL+NUCOe4IWAgaKl6NL/bOzRSseIlRjhenJPjoOUbzdHJkh7iEBgbre+DaSXN296yQPISf8SJl2uUPz4ksp8iun1XeLGD/b98lj4uYIY5qiLdNiBFMLkLtskA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAnR/TNO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAnR/TNO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CADC2BCB4;
	Fri,  1 May 2026 16:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777654473;
	bh=+K8MmTBikTSyUTpQNJUN80b+sHdqeZFXCzVSWSNfXkg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YAnR/TNOTqfYH7gdrTpx3yQs4Ta9TU31MLWgy40W3paePtx1k+iKidYfV+4ojQ/Nx
	 UV6paUppmuULAnlrij7YSmxcjEbBaDgTxzfrvDgPRzg85y8z5SU6xuazHQjaF+xK+h
	 N5MxqiMDjxWcBFJ0zT5r/VEq778xKyAS5XSH5P7kqujvJ+GXhZnHcWjdpZlS7WF4di
	 keVnrsbfi7FpO/MbjR8NMX+HYUPtlCJ0xc02VAB3do5XsF2wms5cDG6GT2Jg2yW8OS
	 aAuWrwnlQagWBY5BAN22wI9hrqCRhO90mXfmg6yNH6my2xd8zS4+bXS/kGI0jweiXB
	 WngxbMqyz4cFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 2/2] tools/perf: Add kernel-doc comment to
 auxtrace_record__init() function
Reply-To: sashiko@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260501145436.1327-2-atrajeev@linux.ibm.com>
References: <20260501145436.1327-2-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 16:54:32 +0000
Message-Id: <20260501165433.60CADC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The added kernel-doc comment incorrectly documents a NULL return va=
lue as strictly a failure, which contradicts the actual API behavior and th=
e implementation directly below it.
--

commit 32a1e931b50aecc6b395f4170e1b7ccb2ad1db6c
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Add kernel-doc comment to auxtrace_record__init() function

This commit adds a kernel-doc comment for auxtrace_record__init() to
describe its parameters and return value. It also rearranges the
__maybe_unused attribute to fix a kernel-doc warning.

> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c

[ ... ]

> +/**
> + * auxtrace_record__init - Initialize an AUX area tracing record.
> + * @evlist: The list of events to check for AUX area tracing event.
> + * @err: Pointer to an integer to store return code.
> + *
> + * This function looks through the @evlist to determine which AUX area
> + * tracing hardware is being used and initializes the auxtrace_record
> + * structure.
> + *
> + * Return: A pointer to the struct auxtrace_record on success, or NULL on
> + * failure (@err needs to be set).
> + */
>  struct auxtrace_record *__weak
> -auxtrace_record__init(struct evlist *evlist __maybe_unused, int *err)
> +auxtrace_record__init(struct evlist __maybe_unused *evlist, int *err)
>  {
>  	*err =3D 0;
>  	return NULL;
>  }

Does this kernel-doc comment accurately describe the return value
expectations?

The weak implementation of auxtrace_record__init() directly below this
comment returns NULL and sets *err =3D 0. Returning NULL with a zero error
code appears to be the designated success path to indicate that no AUX area
tracing hardware is available, rather than a failure.

Could the documentation be updated to reflect that returning NULL with
*err =3D 0 is a valid success condition?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501145436.1327=
-1-atrajeev@linux.ibm.com?part=3D2
