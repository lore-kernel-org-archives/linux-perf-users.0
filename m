Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EC1183CC3
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158415; cv=none; b=csZ0WQaWy5MLrlipcxPCa1AMqDKDqKQE6C4Txe1LGPssjFVFbXkF4987QCDrpMEzzE8TbwnRvYtFWy4gDadENC5DTJHRV+iHhjN/OPFNo7/httNkmREd/L616B5kE7YUUfOJygbsp9e1YORIhDH1IlD38/Jq4/BLj/CER1u/7FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158415; c=relaxed/simple;
	bh=H4damUE7CCz1ChANrgakId1KXcY5y8zIJ6ip9/H5Zzc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ca2AVhGJX2IgU+pXbyheU0+iFMGEX0t+6LB/yZMtt/9/oNl+Bo9M/DLUvjmnW09jgzJepwyiSn/Wnh4GZMs9GIfIo3MnSM54qgrIG23va4bvKJOxXuem7vpa+U4hGXO0kguLKDCZ87jgzBP6MCmFx/OEx+I5MqLYY5JkT5YI7nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ1thTca; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ1thTca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41398C2BCB0;
	Sat, 25 Apr 2026 23:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158415;
	bh=H4damUE7CCz1ChANrgakId1KXcY5y8zIJ6ip9/H5Zzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PQ1thTca6x3Q47kUAvcRzvL82KKPcDA/Ok51QS6xQqkqvis2CVwnkt7hoyM3E+HKS
	 9KsCsKku87BqXzzoTc98wRMAyvIUGkKJHzQRlEWv84SLFpKtBkAhcKiuSs/mIIIHtn
	 Dq9hENVuraKDVuFPLZ9cWiQbGufY8vjgDl8sKdARWEw2LGT9QJkGJRLy+J9grOaRMf
	 HOCwJPTUGt/uHg/XoMkPmgVJZ6Zu1yW8t8TH1Jf9jW3VjUw1voamwW/0mX9DNPxXEm
	 FF4vuA5HXsBDoI3zHL+PtHW6pRaYmxzzzSHhCG95qfboqYaW0WZEUuoebQJfBqKKuj
	 +Ag3AE716MqLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 38/59] perf failed-syscalls-by-pid: Port
 failed-syscalls-by-pid to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-39-irogers@google.com>
References: <20260425224951.174663-39-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:06:54 +0000
Message-Id: <20260425230655.41398C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] The script aborts event processing prematurely if `perf.session.fi=
nd_thread()` fails to find a thread.
- [High] The script crashes with a TypeError during summary sorting if a th=
read's command string is missing.
- [Medium] The script fails to group errors by system call and loses freque=
ncy-based sorting, directly contradicting the commit message.
--

commit 0c01206d74ebfd6bae49fe56d591c99446342a80
Author: Ian Rogers <irogers@google.com>

perf failed-syscalls-by-pid: Port failed-syscalls-by-pid to use python modu=
le

This commit ports the failed-syscalls-by-pid script to use the new perf Pyt=
hon
module API. It updates syscall name resolution, error code strings, and adds
filtering by COMM or PID.

>     - Used standard collections.defaultdict for nested statistics
>       aggregation.

Does the implementation actually use nested statistics aggregation as descr=
ibed
in the commit message?

Looking at the initialization of self.syscalls, it is defined as a flat
dictionary with a 4-tuple key: (comm, pid, syscall_id, ret).

Linear iteration over these flattened keys prints redundant syscall headers=
 for
each distinct error code of a single syscall, instead of grouping them. This
flat structure also breaks the frequency-based sorting of error codes by co=
unt.

> diff --git a/tools/perf/python/failed-syscalls-by-pid.py b/tools/perf/pyt=
hon/failed-syscalls-by-pid.py
> new file mode 100755
> index 000000000000..eecd553cbf8f
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
> +            comm =3D self.session.find_thread(pid).comm()

Can this cause a regression where the event loop aborts prematurely?

If find_thread() fails to find a thread, the underlying C extension raises a
TypeError.

Without a try-except block here, this exception propagates back to the C ca=
ller
and causes process_events() to abort the entire event loop, stopping the tr=
ace
processing instead of gracefully defaulting to 'Unknown'.

[ ... ]
> +    def print_summary(self) -> None:
> +        """Print aggregated statistics."""
[ ... ]
> +        print(f"{'comm [pid]':<30}  {'count':>10}")
> +        print(f"{'-' * 30:<30}  {'-' * 10:>10}")
> +
> +        sorted_keys =3D sorted(self.syscalls.keys(), key=3Dlambda k: (k[=
0], k[1], k[2]))

Could this trigger a TypeError crash regression during summary generation?

The thread command extension can return None if a thread lacks a command st=
ring.
This None value is then used as the first element in the tuple key for
self.syscalls.

During this sort operation, Python 3 will raise a TypeError when attempting=
 to
compare None with a string, which happens in normal traces.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D38
