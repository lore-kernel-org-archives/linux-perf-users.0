Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2072339185E
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777159540; cv=none; b=iuTNf046YzSbUGyR2CFFCmjsEiFvcmUkmMSamtgJ9AE7qWQmT/cof/91LtXl3koZBjWalYP5OFiNHVUF4qcFxhij4v5w6mLZTjZlPUr+37XmDy5WtuLwWwzs9vjKp4rsXfcjujrUFKeR6Ju8DXjRCx6oW889NXjCOKf5TN39RI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777159540; c=relaxed/simple;
	bh=mphElbVrfvInzyIIPsADvmhcasfMi2hi0mCM9g65mE0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y+TthdEEcL5ITuQTSNWn2kGGAEtGj3AmIeXExR/5B8G0OAEkgkwucmlSs6J0tGMCpKqkawZp1cnZEoIh5rRAdejIuR8Nyj/cqdynbJRepc5cmwof72WYaizNf/k3v8u08hmKdVh9TMpYceb84RPSJBTfAHl0OX3mIVKhY0ef0m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI8+vsu1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI8+vsu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7303C2BCB0;
	Sat, 25 Apr 2026 23:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777159539;
	bh=mphElbVrfvInzyIIPsADvmhcasfMi2hi0mCM9g65mE0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GI8+vsu17c22NVvSFFcV4YjnyqNWbon6ORJZI0j+WyWjJJv0izCAXmEIX8Rzev/cs
	 yZahQ8q7gTiwZh/t+V7ctSYwQLtPBZwDUhoGgzbkkrDmC8yN5NSYvcLZ9ah9y9V5Cl
	 uyAtezK4YRScRBQAFA6uUeUqTE55k6he7hJ77aN2vlX1oC57sqSBfqHZshZzXYETMz
	 0j8S408qSrQ1CRI2MHgyv1cvafMXmDViQYG6NUFwdChqKNPRbhpUxNGS/x2GygS6sd
	 J4pQfB6Y1ESoHpzFHtbHTNt3XVzGZg44uPywndBBoOYrar4yuOGGnhSfZyshahD09/
	 g6wbze2W7O+xQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 23/59] perf python: Add LiveSession helper
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-24-irogers@google.com>
References: <20260425224951.174663-24-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:25:39 +0000
Message-Id: <20260425232539.C7303C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] The over-broad `except Exception:` block silently catches and ig=
nores all exceptions raised by the user-provided `sample_callback`.
- [Medium] The event collection loop fails to drain the ring buffer, readin=
g only a single event per CPU per poll iteration.
--

commit e2eca1dd7f39c083ae56a20fe3f81a6dda3a902c
Author: Ian Rogers <irogers@google.com>

perf python: Add LiveSession helper

This commit introduces the LiveSession class in the python perf module to
support live event collection using perf.evlist and perf.parse_events,
avoiding the need to fork a separate perf record process.

> diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live=
.py
> new file mode 100755
> index 000000000000..d1dcbab1150b
> --- /dev/null
> +++ b/tools/perf/python/perf_live.py

[ ... ]

> +    def run(self):
> +        """Run the live session."""
> +        self.evlist.open()
> +        try:
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
> +                    try:
> +                        event =3D self.evlist.read_on_cpu(cpu)

Does this code need to fully drain the ring buffer on each wakeup?=20

Currently, it reads only a single event per CPU and then goes back to=20
poll(). Under moderate to high event rates, processing them one by one=20
per poll iteration might cause the utility to fall behind and drop events.=
=20

Could this loop until read_on_cpu() returns None before moving to the=20
next CPU or polling again?

> +                        if event and event.type =3D=3D perf.RECORD_SAMPL=
E:
> +                            self.sample_callback(event)
> +                    except Exception:
> +                        pass

Since this except block catches all exceptions, could it accidentally swall=
ow
exceptions raised by the user-provided sample_callback?

If the user's callback contains a logic error or raises a ValueError, catch=
ing
and ignoring it silently here might make it very difficult for them to debug
their scripts.

> +        except KeyboardInterrupt:
> +            pass
> +        finally:
> +            self.evlist.close()

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D23
