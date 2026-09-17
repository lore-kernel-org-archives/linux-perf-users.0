Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B89518155
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664399; cv=none; b=Arqic/kj3C8qoFzzuNc0R5U/DV1Zivcv4MdzQPWBMKAypbvF5kHQrke1LKBVpMfoj6RgUQYcyFHwZ4CekWTrlo6mUFJt+u4WZS+CksAcNtlheUOujJ8OibUTgKgpwYZApQYIixdzwVihEcZznybZVJ4OgdjQqx9CSwpp6+ViY4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664399; c=relaxed/simple;
	bh=IAMUKkTX03oW9pI9HrtD2mlMKA8oPTTrlcCDLf05U+g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r9s8EqcUuIrYawqfpqvnkT6Na02W2AwNeZV9/Y1+WWpBwQLgozh/I4ODSKxTBIfgaxueScDFwKn/bbpIEAS+Gypok4H+mpCCO58v4IwfO9LbF7uGuUFFWtZTJ56DEjZZf4tmBfSxredrjlPW9E6l/iYufDGIEUeonT74E/0d/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmIX/2k4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmIX/2k4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867A61F0089C;
	Thu, 17 Sep 2026 16:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789664397;
	bh=Yl7jq1LoIDi4UZPSJE7iTnbShgNQN0a/I7lTLXccyfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HmIX/2k4bHwyDHz7sO9Ih47F88XjharNFQSoCfaZnkvBk6VHVwxJkiLSm710oOLeW
	 ksWdapywfPOgytZHyA3OUgpKNI4lddtzAiHOX7RcLMSOVDubFWczoToM3R2M0hHjvi
	 2A+MtYaTWtWULG4/vp+rFAo4e0sPcI9dpdnfsnMUcf5YIVnwUEfnXBQdmEBQn0WYPk
	 WUxfGDc9yFDvIF+R17MsOcSkJO0nwM8G7gGelgoK2r2cw8YsnMp+ZQ8cEJ31vhiANB
	 lQee8OwF+6sR8UAxeJ7H9+nuzzJigUeI6mNDUd2JwFnAWmC4I9YEShJjVXszUHIWFY
	 MdBcI1MK/w0nQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/14] perf trace: Handle fork and exit directly in
 BPF filter maps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <9e8dbcce45595142d9374b5af2d2db6014049986.1789662556.git.irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <9e8dbcce45595142d9374b5af2d2db6014049986.1789662556.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:59:57 +0000
Message-Id: <20260917165957.867A61F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf trace: Dropped sys_enter events for children in attach wind=
ow
--

commit f502bbaf61708b9eab3d9d484a0f81359acb4676
Author: Ian Rogers <irogers@google.com>

perf trace: Handle fork and exit directly in BPF filter maps

This commit moves PID tracking from userspace (processing PERF_RECORD_FORK
and PERF_RECORD_EXIT events) directly into BPF programs attached to schedul=
er
tracepoints. This addresses latency issues between event occurrence and
userspace map updates by immediately updating BPF maps from kernel space.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 9bb8316e334c8..f876f0df06a56 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2055,23 +2055,6 @@ static int trace__process_event(struct trace *trac=
e, struct machine *machine,
>  			      "LOST %" PRIu64 " events!\n", (u64)event->lost.lost);
>  		ret =3D machine__process_lost_event(machine, event, sample);
>  		break;
> -	case PERF_RECORD_FORK:
> -		if (trace->raw_augmented_syscalls &&
> -		    (augmented_syscalls__has_target_pid(event->fork.ppid) ||
> -		     augmented_syscalls__has_target_pid(event->fork.ptid))) {
> -			augmented_syscalls__add_target_pid(event->fork.pid);
> -		}
> -		ret =3D machine__process_fork_event(machine, event, sample);
> -		break;

[Severity: Medium]
Does removing the PERF_RECORD_FORK handling create a silent blind spot for
tasks forked during the attach window?

The commit message states that a child forked in this window is still
traced unaugmented because the BPF sys_enter program returns 1:

tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c:sys_enter() {
    ...
    if (has_pids_to_trace && !pid_to_trace__has(getpid()))
        return 1;
    ...
}

However, cmd_trace() explicitly removes the raw_syscalls:sys_enter evsel
from the evlist during initialization:

tools/perf/builtin-trace.c:cmd_trace() {
    ...
    augmented->handler =3D trace__sys_enter;
    evlist__remove(trace.evlist, evsel);
    evsel__put_and_free_priv(evsel);
    ...
}

Because this evsel is removed, there appears to be no userspace listener
attached for it. Consequently, when the BPF sys_enter program returns 1
to allow the kernel to emit the tracepoint, the event is silently dropped
instead of falling back to unaugmented tracing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789662556.gi=
t.irogers@google.com?part=3D6
