Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FE7337BB5
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050922; cv=none; b=OekJOm9tOUJP2i3+DewAhoLvBOTEZBF8StAEGOAOvIfc9v1i44j7VwofWR3L3hauNlMyOGfyEza5xPmNUlbZEBf8DjVYJADm/XIic6SUe6s6efbhV08Lnlof4vLdHwP0J81hvphvyrFQzD///DABJuUFvefliaaXZWrxdKcnZM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050922; c=relaxed/simple;
	bh=kxLX41ZL4wGTwxCHBlaRiiUNv2VuHUQqILVu6wFysdA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nT5po+3wNRnKcEiCfQvxi79734SAHo9VhpERzlrZFjZIdxdl0nmpGIF98wyDQcHUBoZOJGCnjKAB6rQcTJc/9FGfJ9OvXqHu4BCPinS3vhdEffZIUeiz1//0YVBbi7PfCFMCRpdNu00IAijCcXhrUJhGygUHHW7WyNrJz6I75+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Evv7yHAv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Evv7yHAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF75C19425;
	Fri, 24 Apr 2026 17:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050922;
	bh=kxLX41ZL4wGTwxCHBlaRiiUNv2VuHUQqILVu6wFysdA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Evv7yHAvCJBZPF0XUYFotWIre3gIQmZ7xdta4jhgzLRp2ZWq/iNs6IfWefhX5fdZv
	 rhkihvAOKjSDUHihfhowRxkzMnKjWhk/MIZ+yp1+lFPJ3+qJw3WtT/aNJFKOgQjnk7
	 kATCq6NOSW8ytVcJIQAcPICqwA5YtUpXE5ZNdNYI7kNDC7hD7l/A3tbMCzDa6pMGey
	 DOSfatVYOIayT8VWyiR1o/mZkQLsdhixtPNDx6mUS8qEX/g5/9+iuv1PFWGUXj53vH
	 Bd2GCznUNEBpPVlfm6t1h9T7oSKQlUls9hxlwlOjglY4Ucg8pONq4n+gbfBiCe5WpP
	 eREzxWuW9n8jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 34/58] perf compaction-times: Port compaction-times
 to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-35-irogers@google.com>
References: <20260424164721.2229025-35-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:15:21 +0000
Message-Id: <20260424171522.6CF75C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] Unhandled TypeError when retrieving missing thread metadata abor=
ts event processing.
- [Medium] Directly accessing dynamic tracepoint fields on `sample` objects=
 can cause an unhandled AttributeError.
- [Medium] Filtering specifically for PID 0 behaves incorrectly and instead=
 includes all processes.
--

commit 3ab6430708ee13be91972c552a27a60bf585751f
Author: Ian Rogers <irogers@google.com>

perf compaction-times: Port compaction-times to use python module

This commit adds a port of the compaction-times script that uses the perf
python module directly. This approach is significantly faster than using
perf script callbacks as it avoids creating intermediate dictionaries.

> diff --git a/tools/perf/python/compaction-times.py b/tools/perf/python/co=
mpaction-times.py
> new file mode 100755
> index 00000000000000..153b47930e3ccf
> --- /dev/null
> +++ b/tools/perf/python/compaction-times.py

[ ... ]

> +def get_pid_filter(low_str: str, high_str: str) -> Callable[[int, str], =
bool]:
> +    """Returns a filter function based on PID range."""
> +    low =3D 0 if low_str =3D=3D "" else int(low_str)
> +    high =3D 0 if high_str =3D=3D "" else int(high_str)
> +
> +    def filter_func(pid: int, _comm: str) -> bool:
> +        return not (pid >=3D low and (high =3D=3D 0 or pid <=3D high))
> +    return filter_func

Does this filter behave correctly when specifically filtering for PID 0?

If a user explicitly requests to filter only PID 0 by passing "0" or "0-0",
high_str evaluates to "0", making high =3D 0.

Since high =3D=3D 0 is used as a sentinel condition for no upper limit, the
condition (high =3D=3D 0) evaluates to True. This simplifies the logic to
not (pid >=3D 0).=20

Since all PIDs are >=3D 0, the expression returns False for every PID,
bypassing the filter entirely and including all processes.

[ ... ]

> +def process_event(sample: perf.sample_event) -> None:
> +    """Callback for processing events."""
> +    event_name =3D str(sample.evsel)
> +    pid =3D sample.sample_pid
> +    comm =3D session.process(pid).comm() if session else "[unknown]"

Will this code safely handle cases where the thread metadata is missing?

In the underlying C API wrapper pyrf_session__process(), if the requested
thread is not found in the session's machine thread lists, it explicitly se=
ts
a TypeError.

Since this call isn't wrapped in a try/except block, the exception propagat=
es
back to the C caller. The C callback prints the exception traceback and
returns -1, which abruptly terminates the entire process_events() loop.

> +    secs =3D sample.sample_time // 1000000000
> +    nsecs =3D sample.sample_time % 1000000000
> +
> +    if "evsel(compaction:mm_compaction_begin)" in event_name:
> +        Chead.create_pending(pid, comm, secs, nsecs)
> +    elif "evsel(compaction:mm_compaction_end)" in event_name:
> +        Chead.complete_pending(pid, secs, nsecs)
> +    elif "evsel(compaction:mm_compaction_migratepages)" in event_name:
> +        Chead.increment_pending(pid, Pair(sample.nr_migrated, sample.nr_=
failed), None, None)

Can accessing these tracepoint fields directly on the sample object
cause an unhandled AttributeError?

These properties are resolved dynamically by pyrf_sample_event__getattro
using libtraceevent. If libtraceevent fails to resolve the field, it sets an
AttributeError.

Similar to the thread lookup issue, this exception would be uncaught and
propagate back to C, causing the loop to abort prematurely. Could this be
updated to use getattr() to safely retrieve the fields with a fallback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D34
