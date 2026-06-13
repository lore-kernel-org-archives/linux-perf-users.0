Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E4D156C6A
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781336073; cv=none; b=lH9tNVB3gsmIOuYrA+y2gaOkqXXzlFZYe8Qun33LlXH6oCkWOlG6NIYAXwkxUzdPT1/NOLKsgYQz6XEz+sIA4bVYTdqwOhdbnJpN/suo0/v8QTQxXL2uzW+Bq8XhWl0HCzz8R3uo/ep0WsGRsHaswHAVlWHrVShhef6577Y/Xw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781336073; c=relaxed/simple;
	bh=a0nJPczihyF5bTzv/AnLHpkJS/5WBK4Tc5wxMjuXO6g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fz3uUm25HGgCURc6pCmyguYF3AUSJLFWhOBb5O5HPbvhNzxP1hdEj1RvW45Dwi7CORME2HuIxLhmNePAt3Gmf6s/TsUD/Hzp62bRzllfmzptfiqOSOkrC+E46TJBr6PEbBxi9AkqJr2RJcgwwNI14WL8lUeWGSA/WhZG3pMAWkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKJSNqzp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKJSNqzp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DEB1F000E9;
	Sat, 13 Jun 2026 07:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781336072;
	bh=URkIf8ObExvFZLX9rEIZOweST4aWtepzSyiLQ1P+cww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DKJSNqzpPuGI+BxYo9lveN7D2fbs1Yz0UfZoXpobpXqasCr5OQFHK/iee7bWjbQJo
	 X+lhQayB2umXNNJoEhVEtw4sJkPcKneL0kLDFk70KAvajYR9gRAEmFaPLHDlV0KoxC
	 H4bp6VQAnPn38mu8w2As6QHewO+JJD6//kd/ZkQkQk+xzHgTEspgy7gXvVrE6v14nk
	 PvfkXuMNV2S03G9O+jjXJlRttQYXLykf8sfjdUFxVWJWKOI4YFlfBQu9P1h9UkHSHj
	 ChMOVbNT5UsFUZNz9ANx3LiQFCSmCV79+icN+LwXNu87qOkG1lFchpObIpe6SksKk8
	 HSmiT22A/uFPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 20/20] perf python: Add LiveSession helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260613071100.1508192-21-irogers@google.com>
References: <20260613071100.1508192-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 07:34:31 +0000
Message-Id: <20260613073431.E7DEB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Masking generic TypeError when reading events hides legitimate e=
vent parsing failures.
--

commit 203596affbd21e12e1b627f6c4fba15a41df078c
Author: Ian Rogers <irogers@google.com>

perf python: Add LiveSession helper

This commit adds a LiveSession class in tools/perf/python/perf_live.py to
support live event collection. It uses perf.evlist and perf.parse_events
to enable running a callback for each live event without needing to fork a
separate perf record process.

> diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live=
.py
> new file mode 100755
> index 0000000000000..0052031b18d9c
> --- /dev/null
> +++ b/tools/perf/python/perf_live.py
[ ... ]
> +    def run(self):
> +        """Run the live session."""
> +        try:
> +            self.evlist.open()
> +            self.evlist.mmap()
> +            self.evlist.enable()
> +
> +            while True:
> +                # Poll for events with 100ms timeout
> +                try:
> +                    self.evlist.poll(100)
> +                except InterruptedError:
> +                    continue
> +                for cpu in self.cpus:
> +                    for _ in range(1000): # Limit to 1000 events per CPU=
 per poll to prevent starvation
> +                        try:
> +                            event =3D self.evlist.read_on_cpu(cpu)
> +                        except TypeError:
> +                            # CPU might be unmapped or offline, wait for=
 mmap event
> +                            break

[Severity: Medium]
Could this broad exception block mask legitimate event parsing failures?

The underlying C extension pyrf_event__new() also raises a TypeError for
unsupported event types ("Unexpected header type") or malformed data
("Unexpected event size").

By catching all TypeErrors and assuming the CPU is unmapped, does this risk
silently ignoring corrupted or unhandled events and prematurely breaking the
processing loop for that CPU?

> +
> +                        if event is None:
> +                            break
> +
> +                        if event.type =3D=3D perf.RECORD_SAMPLE:
> +                            self.sample_callback(event)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613071100.1508=
192-1-irogers@google.com?part=3D20
