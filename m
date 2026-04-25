Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4489F38F62A
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158721; cv=none; b=Zi5Cv65UOOFqYj9CAHOy+u+wl7ngVbuAbFEfN8B0AZC3P4f84auPvVr6iEnMKoRTBzJdphLIyCDhD3XQGTggOWsWcZ2e9fTLJFhboK4hC9zbMBZ9poaXFncISip7c9qZBRRHqEoiQDCCIwTPW0AMCFMW1skFjQ71BoKCbYupSfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158721; c=relaxed/simple;
	bh=Itb1gbdoztUOlqR3xvy1gPAkIJApP2D3Cvpahob/eJc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eTNVUne2PyUHhjPrgslUNH+g71e0WtkJS7wqThTaVk+QYIdMfsoYm9PMo07yZFk9z+yWq1IzZYeA98FCplrWnXvOthZfnMnRBEcb6dSdrf1OXP/kC5h6PKoPo4oQpRMKnWwS9AVWGJlg82+JJ4H6yQj5ebj4Bp+q2fDBLtPMb9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+mr8e+f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+mr8e+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C11C2BCB0;
	Sat, 25 Apr 2026 23:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158720;
	bh=Itb1gbdoztUOlqR3xvy1gPAkIJApP2D3Cvpahob/eJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=o+mr8e+frs0fTRpAftPmPHAjzLNvn+InbJi7QJZ4hTWpcJR3r5Vo4PQXJBfg+DBFA
	 TI7wtM1dfIxRlsYGWAjvs7S/OSCSERseiddCce1C0DjlvdJdbLVPH1C+SWpPFjGyE9
	 ipso+dtGuBrlv2sMQBT6U38Ikk36ta9SRqdQKN4lfM7n09SXxVeSToJG1R4TsPcmzD
	 9T4wyRLhkJuBwZXUx4n+WDm62mzfOAH8ZA8tQDOk8XKNNJ+UI2bwiKpQoSdaWuVXb+
	 z8wHjqHTfPPjKwSGbofgBYjDtENhB9r6rr+2FmteaS0xU14G0eAH+nsK4FBaAbGzCN
	 KPM6iIuKy4HZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 43/59] perf sched-migration: Port
 sched-migration/SchedGui to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-44-irogers@google.com>
References: <20260425224951.174663-44-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:12:00 +0000
Message-Id: <20260425231200.B9C11C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] O(N) rendering loop causes severe UI freeze when scrolling past th=
e end of the trace.
--

commit 07cc80943ab511e4ab9f7f60d5601a48a4f10e41
Author: Ian Rogers <irogers@google.com>

perf sched-migration: Port sched-migration/SchedGui to use python module

This commit refactors sched-migration.py to use a class structure and modern
directory layouts, porting it from tools/perf/scripts/python/.

> diff --git a/tools/perf/python/sched-migration.py b/tools/perf/python/sch=
ed-migration.py
> new file mode 100755
> index 000000000000..331278958763
> --- /dev/null
> +++ b/tools/perf/python/sched-migration.py

[ ... ]

> +    def fill_zone(self, start: int, end: int):
> +        """Fill zone in GUI."""
> +        i =3D self.find_time_slice(start)
> +        if i =3D=3D -1:
> +            i =3D 0
> +
> +        for idx in range(i, len(self.data)):
> +            timeslice =3D self.data[idx]
> +            if timeslice.start > end:
> +                return
> +
> +            for cpu in timeslice.rqs:
> +                self.update_rectangle_cpu(timeslice, cpu)

Can this loop cause a severe UI freeze when scrolling past the end of the
trace?

If the view is scrolled past the last recorded event, find_time_slice(start)
fails to find an enclosing timeslice and returns -1. However, the fallback
logic intercepts this and sets i =3D 0, causing the rendering loop to itera=
te
through every single recorded event in the entire trace.

Because the current view's end timestamp is strictly greater than all
recorded event timestamps, the early exit condition (timeslice.start > end)
is never met.

As a result, the GUI issues an update_rectangle_cpu call for every CPU of
every timeslice in the trace.

For traces containing millions of events, does this trigger millions of
off-screen draw calls on every paint event, freezing the application thread?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D43
