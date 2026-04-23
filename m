Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1303D8119
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 23:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776985811; cv=none; b=cMhiy4tVF6wQJ5tVV+zHX6O7IXDysWBajZOexsiETpmrW72APz8gbfMcBRL+S9RJ1MkPmYhMKQi9i/FQJIDxWnRyQz/JxrPZFSQjuzNBNFypaWdN4L8RNQ3Pbwr9El8eWYzXjgCqF+kbgO5cDraTywnX6/2mMWec4s9GCaCVgKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776985811; c=relaxed/simple;
	bh=0ZhZV1M+dVR1kq4pZE9pUSetZ7NLoElZcHmx7qYtJ0w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H8yuIeIfMyFCb/mPph7VtTQjKFSJlD6lzQB8BbOmRMiG9tKdka6auPEAdwL2h1U0bmt4ObHTLsSVmkOfKPxBLrvW4fyK/R29bsxWwNhikS2No8MQyIk7zRaJqBmbD/W+nrDyJP7WJZg8kDvIV66Ld9Y0g+6hD1jbu/Rxp9ggkHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgP2qBvI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgP2qBvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615FCC2BCAF;
	Thu, 23 Apr 2026 23:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776985810;
	bh=0ZhZV1M+dVR1kq4pZE9pUSetZ7NLoElZcHmx7qYtJ0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QgP2qBvIVdtVRdZ1lTZnOyxxDGqEZhttiQpJM/ISzSZ9dg5phRnH++022B3QA6szr
	 2Zg+b68mI+Bbmbc1gcpLseP5isvUhERwb2fxcCJ6JYZK6tuRZZjRVIz34O2OaD1XJR
	 1jvnutJVI1WT08frh/jCLvoZ0nR2LuSvsniFEKddvlcpFdIvEFT0lV3Y/Y2KPkGTSL
	 Yyph10wTcQyrmZCPc3hY5nJQPYM46zRc8U1+9/EVNNX2TAMBjC3f4GZGCApPwEGQur
	 o91uAOgrA2tRClfDeFGt/y5Gx5YSAZjyFJgQckXdLX3jPXlo0/n2zWRA3yAvtgYoCO
	 oqgHythFcmS7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] perf: enable unprivileged syscall tracing with
 perf trace
Reply-To: sashiko@lists.linux.dev
To: "Anubhav Shelat" <ashelat@redhat.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423151746.16258-3-ashelat@redhat.com>
References: <20260423151746.16258-3-ashelat@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 23:10:09 +0000
Message-Id: <20260423231010.615FCC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Unconditional rejection of unprivileged tracepoint counting breaks=
 perf_event_paranoid functionality and creates an inverted security policy.
--

commit 741720c90ed77115c5603e05c7d2cdfc3f218082
Author: Anubhav Shelat <ashelat@redhat.com>

perf: enable unprivileged syscall tracing with perf trace

This commit allows unprivileged users to trace their own processes' syscalls
using perf trace without requiring CAP_PERFMON. It loosens the condition in
perf_event_open() for task-attached events that do not expose kernel addres=
ses
and makes format and id files readable for TRACE_EVENT_FL_CAP_ANY tracepoin=
ts.

> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_p=
erf.c
> index a6bb7577e8c596..e8347df7ede5c2 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -73,8 +73,18 @@ static int perf_trace_event_perm(struct trace_event_ca=
ll *tp_event,
>  	}
> =20
>  	/* No tracing, just counting, so no obvious leak */
> -	if (!(p_event->attr.sample_type & PERF_SAMPLE_RAW))
> +	if (!(p_event->attr.sample_type & PERF_SAMPLE_RAW)) {
> +		/*
> +		 * Only allow CAP_ANY tracepoints for unprivileged
> +		 * task-attached events in case kernel context is exposed.
> +		 */
> +		if (!p_event->attr.exclude_kernel && !perfmon_capable()) {
> +			if (!(p_event->attach_state =3D=3D PERF_ATTACH_TASK &&
> +			      (tp_event->flags & TRACE_EVENT_FL_CAP_ANY)))
> +				return -EACCES;
> +		}
>  		return 0;
> +	}

Does this new check unconditionally block unprivileged tracepoint counting
even when sysctl_perf_event_paranoid is set to allow it?

Before this patch, if sysctl_perf_event_paranoid <=3D 1, unprivileged users
could count any tracepoint. It appears this check now returns -EACCES for
counting events without exclude_kernel, breaking tools like perf stat for
unprivileged users.

Additionally, if sysctl_perf_event_paranoid =3D=3D -1, doesn't this create =
an
inverted security policy?

An unprivileged user requesting simple counting would be rejected here,
but if they request full raw event data via PERF_SAMPLE_RAW, execution
bypasses this block entirely and reaches perf_allow_tracepoint(), which
would succeed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423151746.1625=
8-1-ashelat@redhat.com?part=3D2
