Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C14E446BFC
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148351; cv=none; b=L4HcGdE3cwguGgt99Fdeno5iK0VK6IlM/IjaknYxo71ICHIAN6sZqYVQApjInZDwycp/2eUjArJQbEY07pGn0Ny2vXXmzkxZeySZofY0drr3imqfFrPRPD+4ZsizMQJLI9F6N6PMuSED4WPeo2fi8utdWuinoRfSnNNOmgPIcwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148351; c=relaxed/simple;
	bh=Pe+Audlce81x23q0OH4XsXo0I9ErI6bR1yHnoY3vbOg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rBX4pmUITL8xMurXvFuD0Dp6X97W7Q312C8SrhREgyiiVd63mtxyF/AlIa6801IgZRWLccHQrAIdH7dYcC7LGIlylj6CqL4xEeeVdc0cxcKDJ+yTyFmKh/J9BzpQpWIoMhljVRNPGKn/WvEtdBYkOGTd7OVHU9ypGW2OhL0e3sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCHq4Gnn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCHq4Gnn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9921F00893;
	Wed, 23 Sep 2026 07:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148350;
	bh=14LUBvAmzQ8CkPc8992ALYeMhAlDx5m9T0bGUiSEJbI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mCHq4GnnHJS2nrx+3A6w9ymTL4wiTd0rmKJP8UcT3AjftbpxY8EqGZOKjB1unM22d
	 Sf8BoH6zdjED54HfxyBnLku5fMeetNv1lYpdIjuFLolLUSkbiKnJwHerpZFfaNDVi2
	 Hu0jzFK/vOOaBjbrAVxoCU9vbnnGVNoXgqLd/7utNoN7z85RAFl+ZuFZt7edBG5Uug
	 lMeGsC7QL2FljprNzK71AH/jWfhsDGjAd8UldEy+z+gcUS+uVAW+nhdYaGqqQ8oF5r
	 fZhC8dfyeglxTi0+sJ9/NQeRlgYV8ev6lvZH7n7STyhss9wFEHtZdT40seVu7NCADc
	 LYJzLWlaq68ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/23] perf trace: Include the augmented arg header
 in nanosleep's payload length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <f022c34f984e5037f4f4bb0daa75963ff8912e4e.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <f022c34f984e5037f4f4bb0daa75963ff8912e4e.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:25:49 +0000
Message-Id: <20260923072549.DF9921F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: use of C99-style // comment violates BPF comment style guideli=
nes
--

commit fdd001e20d7e2bd912d88ce8d78d5f254e09e3cd
Author: Ian Rogers <irogers@google.com>

perf trace: Include the augmented arg header in nanosleep's payload length

This commit fixes how sys_enter_nanosleep() sizes its output record. It
includes the size of the augmented_arg header in the length calculation,
matching the behavior of other augmenters. This ensures the entire timespec
payload is correctly output to the ring buffer.

> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tool=
s/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -426,7 +426,8 @@ int sys_enter_nanosleep(struct syscall_enter_args *ar=
gs)
>  {
>  	struct augmented_args_payload *augmented_args =3D augmented_args_payloa=
d();
>  	const void *req_arg =3D (const void *)args->args[0];
> -	unsigned int len =3D sizeof(augmented_args->args);
> +	// the size + err in all 'augmented_arg' structs

[Severity: Low]
This isn't a bug, but does this violate the BPF comment style guidelines?
The BPF subsystem requires comments to use the standard /* */ format rather
than C99-style // comments, even for single lines.

> +	unsigned int len =3D sizeof(u64) + sizeof(augmented_args->args);
>  	__u32 size =3D sizeof(struct timespec64);
>  	int err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D2
