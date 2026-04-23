Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B741635E937
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917649; cv=none; b=nePKQFg8XWyFAE2YrY8HMEvN7q/LO23YT7ds6PrhtbO4VC0Mi/2y3yBM3WR6Cs3dirT53fLJEuth0YoeviVF2N4xcSY9X72joQLO+QKZ+MdhDuUl/V0S5i5GhRB0bj07j1NPlIIQrkLK7fstxqymSZR7Na7ZpFs9myVMnQQxi3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917649; c=relaxed/simple;
	bh=1fsEcvNvIEwI2WGxJFynSWCGidQb/aL1P6hVwGQJ7uc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A6oD50jBN3TM/W7UcNgsdnIPAbhqf2Xeq/diRMc/WMQEDUku1tEiYqMQln+/YRT/j8SZDj08OV/3Nps8K5lTGiuz34K4Pb0SrRJbA1NhlkS5Kw1Q8E+tEv4mT9q+lWoUwu4FgWIgRGFUD2fLFea7bIArdKb2TvzlEjKRnFNRGSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd5QDBjN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd5QDBjN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC59FC2BCB2;
	Thu, 23 Apr 2026 04:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917649;
	bh=1fsEcvNvIEwI2WGxJFynSWCGidQb/aL1P6hVwGQJ7uc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Qd5QDBjNXy0rG3JZyKJk+KreksZZA3WnWFVeP9vtIyRz2VyOugZKQeuPuc3mPQoNv
	 jl/s7OCJlDOzPQxIRK0EywIz6ZhHtlhPKX3HiSQyS9/eT48nQUP1drznRwjX+6SYcY
	 QtmHJS7skwei8awtqQQbwWxPYxkuwNt93sE7lNg5bcB8wDqrwQEk88Lx8haqFVvR+d
	 3moLUslAPj+lWSOXzoR17BIJycdoZA42Zw/BpoEqOW19Tt2I8QNRYXG0I+lXhLJDyn
	 uch0rjXMry9T2NdRJoMFLjMnq6iotKiiGoQu0LemkJipQzLvm/ltGiC0di+WbaUKF4
	 Mua7JYEH/DYpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 28/58] perf syscall-counts-by-pid: Port
 syscall-counts-by-pid to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-29-irogers@google.com>
References: <20260423035526.1537178-29-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:14:08 +0000
Message-Id: <20260423041408.DC59FC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The script sorts the output by syscall ID instead of syscall fre=
quency (count), breaking the original script's behavior and contradicting t=
he commit message.
--

commit 528886abf734875e2f7dc5125908604b74355a46
Author: Ian Rogers <irogers@google.com>

perf syscall-counts-by-pid: Port syscall-counts-by-pid to use python module

This commit rewrites tools/perf/scripts/python/syscall-counts-by-pid.py to =
use
the perf python module. It improves performance by avoiding the overheads of
standard perf script execution.

> diff --git a/tools/perf/python/syscall-counts-by-pid.py b/tools/perf/pyth=
on/syscall-counts-by-pid.py
> new file mode 100755
> index 0000000000000..45a98e6e8e011
> --- /dev/null
> +++ b/tools/perf/python/syscall-counts-by-pid.py
[ ... ]
> +def print_syscall_totals():
> +    """Print aggregated statistics."""
[ ... ]
> +    print(f"{'comm [pid]/syscalls':<40} {'count':>10}")
> +    print("---------------------------------------- -----------")
> +
> +    sorted_keys =3D sorted(syscalls.keys(), key=3Dlambda k: (k[0], k[1],=
 k[2]))

Does this sort order match the original script's behavior?

The commit message example shows the output sorted by syscall count descend=
ing:

    perf [3886080]
      write                                      538989
      ioctl                                          32
      sched_setaffinity                              17

But the code here sorts by comm (k[0]), pid (k[1]), and then syscall ID
sc_id (k[2]) ascending.

Should this be sorting by the syscall count descending instead, so that the=
 most
frequent syscalls appear at the top?

> +    current_comm_pid =3D None
> +    for comm, pid, sc_id in sorted_keys:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D28
