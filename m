Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEC13A5E98
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051280; cv=none; b=Rp2Q0wZGO3R/hFjzY/nBDpnqvJjxkAWJZMe98RJdwG18q+NRFl2tkKxz+0mycv7f+84EBgOutH2S0em/g3FO08WbqmQ4yD7pmW0mzrN/LXt+ilsHKblGHFh+GuHu3MxivN9gDq4sQZPYozkEnB3oGtwxL0X5XJQLWZGTzDbzzng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051280; c=relaxed/simple;
	bh=v05QzMt5UrGganQeuRYF1gp8w++WY3UxJtdDzlCKWWw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=scs0WX2CldsGOM8Dee4Qg7APZB1Q6JYAuwuxSBKUSlKzHV0zaUoQyZ8iYZOzqb8urAyanV8obNr02zFJx3eduZ7NoQi0qcPzPmaVntWMykhHI+Q+VI1K/hKSeWGdfWtMzWBedDxlb/Ec8DYF6uXixQEfZlUEoLeGgkqh20gLge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyaNXIt0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyaNXIt0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116F9C19425;
	Fri, 24 Apr 2026 17:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051280;
	bh=v05QzMt5UrGganQeuRYF1gp8w++WY3UxJtdDzlCKWWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cyaNXIt0pmHCWQGzfuKhfhn/NV/iMCm0CLQvaoE7O9HhiJpVE0lHK0oRQLkkeHqdK
	 yERtsD3xdC2Uu8h+NJCSKzGtaqc41WU3dNtgzHh7n6GOsgoozEvYtOaIFJe4LyBfcT
	 ivfv20gda5bCJmFbPHKJAIFxztJuSQ4duXTm1M2H5K/5oIx/sB+TvgFRd7l2TZcT23
	 0Xw/Ga6erAOqA0ZNNamdTTe+whIlFfXVTlIPFtzNqbVA4mMrOQUXCH+kkbOmQHFU6v
	 tfIJOodDirBNm1qtHv53ESw6dqWHsXhRRAlvms4LLqJWvAAL4gk47tRWe403XRFtFN
	 acYMcsRC5BT7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 49/58] perf rw-by-pid: Port rw-by-pid to use python
 module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-50-irogers@google.com>
References: <20260424164721.2229025-50-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:21:19 +0000
Message-Id: <20260424172120.116F9C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] The script will crash immediately with an AttributeError when atte=
mpting to access `sample.evsel.name`.
- [Medium] The commit message claims a refactoring was performed that is ab=
sent from the code.
--

commit fa022167cb73c3a8cdc423dc6ad08d78d2de4be7
Author: Ian Rogers <irogers@google.com>

perf rw-by-pid: Port rw-by-pid to use python module

This commit ports the legacy Perl rw-by-pid script to Python. It introduces
a class-based architecture that uses the perf.session API to track read and
write activity by process ID.

> Complications:
> - Refactored process_event to extract helper methods
>   (_handle_sys_enter_read, etc.) to reduce the number of branches and
>   satisfy pylint.

Does this portion of the commit message accurately reflect the changes? It
mentions extracting helper methods like _handle_sys_enter_read, but the
implementation uses a single monolithic method with a pylint disable comment
instead.

> diff --git a/tools/perf/python/rw-by-pid.py b/tools/perf/python/rw-by-pid=
.py
> new file mode 100755
> index 00000000000000..53e16b373111a4
> --- /dev/null
> +++ b/tools/perf/python/rw-by-pid.py

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:  # pylin=
t: disable=3Dtoo-many-branches
> +        """Process events."""
> +        event_name =3D sample.evsel.name  # type: ignore

Does the perf.evsel object expose a name attribute?

Looking at the python C API bindings, it appears only attributes like ids,
config, and type are exposed. If this raises an AttributeError, the script
will crash on the first event.

Additionally, if this were bypassed by using str(sample.evsel), which retur=
ns
a string like evsel(syscalls:sys_enter_read), would the subsequent string
matching in the if/elif branches fail? The branches check for exact matches
like "syscalls:sys_enter_read", so the events might be silently ignored.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D49
