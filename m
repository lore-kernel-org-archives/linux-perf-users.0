Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9989C448B97
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148573; cv=none; b=tG3lpVyYzMcVc5q9E+yxqH8nquAGBiLtSRk0qdpqIu11Ki/Xq69NecHVOBSsl4LdOWH34Ybit1XlhfuSKhXTJHYbi/E6uMPT1ki0vJ1gqWYXIkaP+ki4fn60Lf3OgSEQkQsqFF53N63Mi6H0iIHd5EXW4L1oKYbirMtyZZi5Fps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148573; c=relaxed/simple;
	bh=sTgi/OhRMGn0ne5AZw+wVSDnbujQCKsNrYCIA6c5+ww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k+d+GnPPgbadohB5XYBzVYRG2Q8jVT1kprr1m7Pf5PgFKqX/PcsgLcJZRWYZnVxuGWEwwYxlvNBIJ3OxAqcUA/gDAuXWYHIOqiMIu5qIw4J1rO1gAxdzEd1Dpwyfr4lLVLTAsOegYu+C+BB/Mnrp3eCNTm6p5HioJ84VXPmgUUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lut2MHM1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lut2MHM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE251F000FF;
	Wed, 23 Sep 2026 07:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148572;
	bh=27gYrlob9S7iEeWq3JCtXF+wIMCMRbLuuOtDBqaT8gs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lut2MHM1oO7Bvvec2HuHkwyshKd4Cu9b8svfUMPdaB29pHD84M7m+I5Rz4yIFPh7h
	 uyUwSP3/yQzKg7hoEngjWCquCtnwRJJqhgk2ZIxcQcnysCoW5IFIpel4cbnRymzhPl
	 fbQO27jjpd6UZpaMnOoQoCvGhL8KGjUVZIZPd7ve9O04UOq8HGvc3kwH/DrjpvNRqJ
	 hYmuQ5K8c0w4dwRnqh66kXFi5AOblnVyaAVi2yYGYON4LVVjl3bqIoN1PjnUz222+2
	 e1iHTOXnV3tvcJOQBkRg6BSdtBrYpQqlL/3PEANBR+xw0Fofn3dW4Zf0LGnU8tBRPo
	 vKn8abTlYzaBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/23] perf trace: Enumerate the target again once
 BPF is attached
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <f5bac55bce2ca58eec592de327907d7bd3aa61e6.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <f5bac55bce2ca58eec592de327907d7bd3aa61e6.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:29:31 +0000
Message-Id: <20260923072932.0FE251F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf trace: invalid procfs path in pid_list__add_children misses=
 child threads' descendants
--

commit 1823e747d15e463dac6663bf4d27392bbba3f047
Author: Ian Rogers <irogers@google.com>

perf trace: Enumerate the target again once BPF is attached

This commit adds logic to re-enumerate target tasks from procfs after BPF
programs are attached. This ensures that any tasks created during the
startup window, between the initial enumeration and BPF attachment, are
not missed by the tracing session.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index ddbe1c8ec1dd4..6b52f0d408dd4 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c

[ ... ]

> @@ -4691,6 +4696,247 @@ static int trace__set_filter_pids(struct trace *t=
race)
>  	return err;
>  }

[ ... ]

> +/*
> + * Append the tasks tid has forked to tgids.
> + *
> + * task->children holds what a task forked, and a forked task leads a th=
read
> + * group of its own, so each is something to expand in turn. New threads=
 are
> + * not listed: copy_process() gives a CLONE_THREAD child the real_parent=
 of
> + * its creator rather than the creator itself, so a thread is a sibling =
of the
> + * task that created it. Those are enumerated from the task directory in=
stead.
> + */
> +static int pid_list__add_children(struct pid_list *tgids, pid_t tid)
> +{
> +	char path[PATH_MAX];
> +	pid_t child;
> +	FILE *fp;
> +	int err =3D 0;
> +
> +	scnprintf(path, sizeof(path), "%s/%d/task/%d/children",
> +		  procfs__mountpoint(), tid, tid);

[Severity: Medium]
Does this construct an invalid procfs path by using the thread ID (TID) in
place of the thread group leader (TGID) at the root level?

Since Linux procfs only exposes thread group leaders at the root level,
a non-main thread's TID will not have a corresponding /proc/<TID> directory.
This can cause fopen() to silently fail with ENOENT when=20
pid_list__add_children() is called for non-main threads.

Could this result in entirely missing the descendants forked by non-main
threads during the startup window when using -t with a child thread or
expanding a process group?

> +	fp =3D fopen(path, "r");
> +	/*
> +	 * Absent if the task exited, and on a kernel built without
> +	 * CONFIG_PROC_CHILDREN. Neither is worth failing for: what is missed
> +	 * is a task that has gone away, or descendants the kernel will not
> +	 * name.
> +	 */
> +	if (fp =3D=3D NULL)
> +		return 0;
> +
> +	while (fscanf(fp, "%d", &child) =3D=3D 1) {
> +		err =3D pid_list__add(tgids, child);
> +		if (err)
> +			break;
> +	}
> +
> +	fclose(fp);
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D14
