Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4976A314D26
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158551; cv=none; b=Spabrr3RucD9+0m/NGv91FhxuZDcF9PwWLnOxJ4sWlH1vQGkK3XDgl3KwhZblRrcbJMlqP2Qn/Y1Cf4OBozoltFifOlV/O3Pv3PV/cjRCKmdcRpj/HWQqQavoTtAiId+rU1V41K/KicF/MWT/+b5dJfzBTGRGFwDXqQYLqY4SRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158551; c=relaxed/simple;
	bh=dnz7qrLz9SAnTIFprAIaA9kOf9wrko6GxC8JjDROf7A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rGtzZRM2GsjLUk0nVkeY/WeKDkxj0kOYxHF26XcmQfmIFXo2th3H0FgJQoYWUcEjvvbdz6V9+MMOZpICfEg9Y3vyppvFW2XPwHFuXIf2mG+k5drs1mjg1LLYNPA9WnfwXzQoS6QLWlwl7r7mr443gA4GAEEkotSiSPeaueuau1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyaN5PTR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyaN5PTR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47F6C2BCB0;
	Sat, 25 Apr 2026 23:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158550;
	bh=dnz7qrLz9SAnTIFprAIaA9kOf9wrko6GxC8JjDROf7A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GyaN5PTRW/w4E+B+SO8jNr8O2z3Vo+0wa7HtvNOQ1PeVefrLl3RHnCCtmXTJ4kdDs
	 Cs6G7/56on7A94bdHgEIzk+baS1XfFFmoH5YfuHi5psHHhRdTuXT7W2NqZJZ9O6ZCN
	 hhJykP/frxppAVi9tw9Oly08F1RFTTmN+P+pkBC87ivel328Dq5nVmEnC5cW9jvUIA
	 ghcVJfS1urVGfJgr+u1oJ5//BzUC29FcNlG/hAPtA+2WfCesfbv9W2Sy4tQM68Wf0V
	 R4I42X5TsKpbUm6R9wZPq1yoLTpQelY1WqClI0bIYCPJ/NUQYoXQfCLLgmVV8etTYy
	 V2Zg8dld6PXVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 45/59] perf stackcollapse: Port stackcollapse to use
 python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-46-irogers@google.com>
References: <20260425224951.174663-46-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:09:10 +0000
Message-Id: <20260425230910.C47F6C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Unhandled exceptions during thread and comm resolution silently =
truncate event processing.
--

commit 51781e2de9d088f1f729d3ac01beec1a4a11ff21
Author: Ian Rogers <irogers@google.com>

perf stackcollapse: Port stackcollapse to use python module

This commit modernizes the legacy stackcollapse.py trace script by refactor=
ing
it into a class-based architecture. It uses perf.session for event processi=
ng
and aggregates call stacks to produce output suitable for flame graphs.

> diff --git a/tools/perf/python/stackcollapse.py b/tools/perf/python/stack=
collapse.py
> new file mode 100755
> index 000000000000..996c73246ebc
> --- /dev/null
> +++ b/tools/perf/python/stackcollapse.py

[ ... ]

> @@ -0,0 +1,126 @@
> +#!/usr/bin/env python3

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Collect call stack for each sample."""

[ ... ]

> +        if self.args.include_comm:
> +            if hasattr(self, 'session') and self.session:
> +                comm =3D self.session.find_thread(sample.sample_pid).com=
m()
> +            else:
> +                comm =3D "Unknown"
> +            comm =3D comm.replace(" ", "_")

What happens if the sample PID cannot be resolved by the perf session?
Will self.session.find_thread() raise a TypeError?

Also, if the thread is found but has no comm string, will .comm() return No=
ne,
causing the .replace(" ", "_") call to raise an AttributeError?

If these exceptions propagate unhandled to the C-level callback, it appears
the event processing loop is aborted. Because the script ignores the return
value of session.process_events(), could this silently truncate the flamegr=
aph
data and exit with a success status?

Would it make sense to wrap these lookups in a try...except block catching
TypeError and AttributeError to allow a fallback to "Unknown" for the comm
string?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D45
