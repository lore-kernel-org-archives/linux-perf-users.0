Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C67376481
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050434; cv=none; b=leFyq5GQvIQ68A+qUIEHhOymyiQsX/cS7kuULxvwNImJmLQk315s8aDfiQoBWomT3bLO4hAybmi57L7YPSOE4EhxT/bifL8J5Nrq2HRnc0mA7sWXCZ3Bvgq6rZj4jPzb1mIvNUj5xgIGUZMmlohMQcBDPlVxH91sWJULBQdevjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050434; c=relaxed/simple;
	bh=PJX46QcOixcvd364/YUuLfP4zqtg13d4gwaM+RLoRdc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DxZKxmPwhzY1ynn112seAU6ofoA4HNzM0yMwS08mtr81wx9v/OOFws5YZxcpY/FVQMM1qXegMFD6caaGrq2w9FUl9qYYCQ9e7Bpz/yoCYg1pPLhLw9xp/njhIkukVpy3SeljeyRdiHN9sGzyiqVbduPbrcjK7tQp0B6PtbL8E/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPgWE+yt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPgWE+yt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D16C19425;
	Fri, 24 Apr 2026 17:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050433;
	bh=PJX46QcOixcvd364/YUuLfP4zqtg13d4gwaM+RLoRdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DPgWE+yt5IfqsqEIE688vtGO44ztnGi2q6kmfd6mdWI335mVAsvuGy9iCKemNNJpm
	 3PVRwyzMNgZze/5RD28aSaAie7sdheS9itIjV0vTVQ95CXCB+1lP6UJobrL/w9uNN+
	 anlCrt72OsrjnP2zLOavqsn3Gjvfc3mFsn+hbR+f5yo8lZHGFPk7HE11pE1F1qCVu+
	 LBhfpKblunW+nND9MylEIbqS5DVl9Bt1NOkI4hI+CDRLRSdnScCVOGmVMK5M42SeB7
	 +0Nx6anHpq7fzttIU6G1kg+ic0fA9G/1AMaizrXDJBmeSE5qBiYZmCGt0mlOp8RcTU
	 59DCAKcgl1atg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 38/58] perf failed-syscalls-by-pid: Port
 failed-syscalls-by-pid to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-39-irogers@google.com>
References: <20260424164721.2229025-39-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:07:12 +0000
Message-Id: <20260424170713.70D16C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Chaining `.comm()` directly on `self.session.process(pid)` is unsa=
fe and prone to crashing due to an unhandled `TypeError`.
- [Medium] Filtering by PID 0 is ignored due to a falsy condition check.
- [Medium] Meaningful code and commit message mismatch regarding nested sta=
tistics aggregation.
- [Low] Unhandled events are aggregated but silently discarded without bein=
g displayed.
--

commit 76816da881d00075e4983b987c755a57bd2cf9b9
Author: Ian Rogers <irogers@google.com>

perf failed-syscalls-by-pid: Port failed-syscalls-by-pid to use python modu=
le

This commit ports the failed-syscalls-by-pid script to the perf Python
module API. It updates syscall name resolution, error string resolution,
and adds support for command-line filtering by comm or pid.

>     - Used standard collections.defaultdict for nested statistics
>       aggregation.

Is this description accurate? The implementation uses a flat dictionary
keyed by a 4-tuple rather than nested aggregation.

> diff --git a/tools/perf/python/failed-syscalls-by-pid.py b/tools/perf/pyt=
hon/failed-syscalls-by-pid.py
> new file mode 100755
> index 00000000000000..1a8c9bb7e90c48
> --- /dev/null
> +++ b/tools/perf/python/failed-syscalls-by-pid.py

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process a single sample event."""
> +        event_name =3D str(sample.evsel)
> +        if "sys_exit" not in event_name:
> +            return
> +
> +        pid =3D sample.sample_pid
> +        if hasattr(self, 'session') and self.session:
> +            comm =3D self.session.process(pid).comm()

Could session.process(pid) raise a TypeError if the PID cannot be resolved
in the thread map? If so, this might crash the script when it encounters
an unresolved PID instead of safely falling back to "Unknown".

> +        else:
> +            comm =3D "Unknown"
> +
> +        if self.for_comm and comm !=3D self.for_comm:
> +            return
> +        if self.for_pid and pid !=3D self.for_pid:

Will this bypass the filter if the user intends to filter by PID 0 (the swa=
pper
task), since self.for_pid evaluates to False? Would it be better to explici=
tly
check if self.for_pid is not None?

> +            return
> +
> +        ret =3D getattr(sample, "ret", 0)
> +        if ret < 0:
> +            syscall_id =3D getattr(sample, "id", -1)
> +            if syscall_id =3D=3D -1:
> +                syscall_id =3D getattr(sample, "sys_id", -1)
> +
> +            if syscall_id !=3D -1:
> +                self.syscalls[(comm, pid, syscall_id, ret)] +=3D 1
> +            else:
> +                self.unhandled[event_name] +=3D 1

The script populates self.unhandled here, but it doesn't appear to be used
in print_summary() or anywhere else. Was the intention to display these
unhandled events in the summary?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D38
