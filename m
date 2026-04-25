Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B313F38F248
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158715; cv=none; b=XwnRnaeiceVelfAHvNZBZupvyqKbTEFVW9VPwX/S98BqvhobR1EFHRfVHlYDthQJIf9rY4enp1U8Y9L8CpvOR+iuWPt6QR6TG6hVZw2jfKwMAVZbnsmhfobSM6XkkVek/EApoxdzWkPLRJjQHrpUCCvAQJOABcS9LRPruCppyeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158715; c=relaxed/simple;
	bh=HI2lj/n3rjlkkWYtDzjdsjD+mOh7k1gi3RVKHj3Zv4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y17avzSKDM0p5ZlDrN2BBkX0KPjjcr9ul9vbG5mYQ0+dIHt5rwDSnuBM3s+Ak0dk2si5uVLDe/m+CDZdizPrGQcFKwrSNVDrsHMW5W4Na1VVCt/JOpJtUMtTEt2Qv3Fo617baOrkKukjBIusB8jpSNcm3eIzYX0AZzgYTyrzVb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYO3eiq6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYO3eiq6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CFBC2BCB0;
	Sat, 25 Apr 2026 23:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158715;
	bh=HI2lj/n3rjlkkWYtDzjdsjD+mOh7k1gi3RVKHj3Zv4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mYO3eiq6/vdBcFmeioOvxJbm6GTpbiavRHUCfyQ5d+zKml7xh2THLTb00EAYQYg8i
	 BSh3EkvDHYf+wCushnk8fvLvfu/3pJXllpXtFOAVIrsJJB/Fo+KePE85d6zF9F8Y9q
	 JBGCIggmoDFMp3rXoOCOJhks70JKMvJcd8olRre8BMT3MSa5fz1mFBQKRFhTRuo1QL
	 hijX+7kFCUTUVzDgYJLx1qmsydgbG4rw9EuiScI+UzbEsZGPBD1uFeGOlU97pdcV87
	 5GpET8atgxS7pSe4ufs/owlNegSE3F1a+9lhEhYaXiXnjEeS5oJNXLTTdGIMgTgBmt
	 OSP25B9GjU2iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 29/59] perf futex-contention: Port futex-contention
 to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-30-irogers@google.com>
References: <20260425224951.174663-30-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:11:54 +0000
Message-Id: <20260425231154.E8CFBC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Silent omission of futex contention data for unresolved threads.
- [Medium] Silent bogus statistics when tracepoint fields are missing from =
the sample.
--

commit 1635cde526332c6725539102876bd82917ff0ff3
Author: Ian Rogers <irogers@google.com>

perf futex-contention: Port futex-contention to use python module

Rewrite tools/perf/scripts/python/futex-contention.py to use the python
module to improve execution performance.

> diff --git a/tools/perf/python/futex-contention.py b/tools/perf/python/fu=
tex-contention.py
> new file mode 100755
> index 000000000000..1fc87ec0e6e5
> --- /dev/null
> +++ b/tools/perf/python/futex-contention.py
[ ... ]
> +    def handle_start(tid: int, uaddr: int, op: int, start_time: int) -> =
None:
> +        if (op & FUTEX_CMD_MASK) !=3D FUTEX_WAIT:
> +            return
> +        if tid not in process_names:
> +            try:
> +                if session:
> +                    process =3D session.find_thread(tid)
> +                    if process:
> +                        process_names[tid] =3D process.comm()
> +            except (TypeError, AttributeError):
> +                return

Does this early return introduce a regression causing silent data loss for
unresolved threads?

If an exception occurs when resolving the thread name, the script returns e=
arly
and completely skips the start_times[tid] assignment below. Because the thr=
ead
ID is never added to process_names, subsequent events for the same thread w=
ill
hit this same branch and fail again, dropping all lock tracking for the thr=
ead.

Could the script instead ignore the exception and rely on the
process_names.get(t, 'unknown') fallback during final output?

> +        start_times[tid] =3D (uaddr, start_time)
[ ... ]
> +    event_name =3D str(sample.evsel)
> +    if event_name =3D=3D "evsel(syscalls:sys_enter_futex)":
> +        uaddr =3D getattr(sample, "uaddr", 0)
> +        op =3D getattr(sample, "op", 0)

Will this regression corrupt the contention measurements with bogus data if
tracepoint fields are missing from the sample?

If uaddr or op are not present on the sample object (for example, due to
missing libtraceevent support or unparsed tracepoints), getattr defaults bo=
th
variables to 0.

Because 0 exactly matches the value of FUTEX_WAIT, every sys_enter_futex ev=
ent
(including wakes and requeues) would be incorrectly treated as a wait
contention on lock address 0x0.

> +        handle_start(sample.sample_tid, uaddr, op, sample.sample_time)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D29
