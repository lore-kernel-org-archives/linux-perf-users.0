Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4C72FFDCB
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158346; cv=none; b=Cq1zAmZbu30izucj9j/r1HH/soPdYG8QY86B4qh/7voYk4O4nHsiZqynHYW5hugJyv4mma6Cfc0ij2QMYD4LW2hAmIwpnTHwVOVQUZXpJASwMMjVYzbaTTACxztrqjEhIunhPqBqGaWuhitckPyVS4oFv7E/7rKe7X15EZ00v+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158346; c=relaxed/simple;
	bh=LdU3NCTbYRjhhaSeZZTbBCDcIAkptfed6tX4pQjo9KI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FFF3bdsoNSfPhpoKWiv1Va2VObq87+ajqtfqY6Jq5rKS7nJeA4iyiSYK4QJsO+U6xmvPL2XR2qw28IqG5ZJ2ycsaMU/GsIGePgwF6a1d5bk+QGxHVjP9MtICST+wzAXzLNbwTInywQlDIkvlkCzp0NOt+Lbz7ZRLoranZP/1h3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWzmFOoe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWzmFOoe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C72BC2BCB0;
	Sat, 25 Apr 2026 23:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158346;
	bh=LdU3NCTbYRjhhaSeZZTbBCDcIAkptfed6tX4pQjo9KI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kWzmFOoeqQGzJ5fyI9lATDap+mUFWOHNV9MPLQOd/AqGwmpnfdZXk47aDtTo7rfd+
	 iXSlhUQ51vcH28TkJhtwj8MD0sj7DwswgXX8lcxYsJ2F4v1RUH3cSlza7SmZds205J
	 O7Q1OVa7I52mzAarjGfUXfj6OQtgmu1hw2RTXQSRzGTrm3BkCn32s7+WiFzvtf96nA
	 6L6AKfoou5fx73Ng8aKW+C675jfKTp/gpTUoIq+MQR5Gbb3qWndq0C3CxzO3CQirmo
	 2QJ/7L35I56DPVX66sqDqWxSYmZrnP9UAjp6mETdvVq/OCA+ZSm88LTf020XuYN5fe
	 nCkj8psWZoWOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 28/59] perf syscall-counts-by-pid: Port
 syscall-counts-by-pid to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-29-irogers@google.com>
References: <20260425224951.174663-29-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:05:45 +0000
Message-Id: <20260425230546.6C72BC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] The new script sorts the syscall output numerically by syscall I=
D instead of descending by frequency, contradicting the commit message.
- [Medium] Filtering by PID 0 fails and incorrectly aggregates all processe=
s, bypassing the filter entirely.
--

commit c3142c05615edbdf9215f073db18a13c7a7e116c
Author: Ian Rogers <irogers@google.com>

perf syscall-counts-by-pid: Port syscall-counts-by-pid to use python module

This commit rewrites the tools/perf/scripts/python/syscall-counts-by-pid.py
script to use the new perf Python module. By bypassing the perf script
execution overhead, it improves performance significantly while displaying
system call totals broken down by syscall and optionally filtered by comm or
PID.

> diff --git a/tools/perf/python/syscall-counts-by-pid.py b/tools/perf/pyth=
on/syscall-counts-by-pid.py
> new file mode 100755
> index 000000000000..ff962334a143
> --- /dev/null
> +++ b/tools/perf/python/syscall-counts-by-pid.py
> @@ -0,0 +1,88 @@
[ ... ]
> +def print_syscall_totals():
[ ... ]
> +    print(f"{'comm [pid]/syscalls':<40} {'count':>10}")
> +    print("---------------------------------------- -----------")
> +
> +    sorted_keys =3D sorted(syscalls.keys(), key=3Dlambda k: (k[0], k[1],=
 k[2]))

Does this sort order match the expected output?

The commit message demonstrates the syscall output being sorted descending =
by
frequency count (e.g., 538989, 32, 17, 2, 1).

By sorting on the keys, it looks like the syscalls are printed in ascending
order of their syscall ID instead.

> +    current_comm_pid =3D None
> +    for comm, pid, sc_id in sorted_keys:
[ ... ]
> +def process_event(sample):
[ ... ]
> +    pid =3D sample.sample_pid
> +
> +    if for_pid and pid !=3D for_pid:

If a user filters by PID 0 (the idle task), will this logic bypass the
filter?

Since for_pid evaluates to False in Python when it is 0, it seems the script
would incorrectly accumulate events for all PIDs instead of restricting them
to PID 0.

> +        return
> +
> +    comm =3D "unknown"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D28
