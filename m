Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E7730F957
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140486; cv=none; b=OjlnPcU04EC/Rw+HJ6iDpzI05hn7SFPA77TQDIpwEh9OoB2fDHpn59sHGneXlw9Bk3d3Q6K9rTU0lhBa132cehx3SZx5EvS5kmRQ73MjDhMY6ntQprPZ3ecGYKzE0NJ8JHWD2Kr8ghBN34HkjJEY8dQLPE92slJ3bqGzIFRrAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140486; c=relaxed/simple;
	bh=dE9Y0eDvQwAi3X8MwG/EOcYiFhnRgwiXVQuXA7wY6f4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TsVPzGR4zZPfrK63YUPCogIPEBJKlhodFd3xEnU9EEqMLf3HLfRSKS6dSavyvq8o1z6ZHhEeXl2Nk7HihB8uvc1Klgpq+O9gty+EcP0CDsnRH/Z9GoOND1uDVc/SzMHxxne+ZPKcbOXkHx8LC8HnAQ9759Iz/KvFWFP/YfE9bjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pz0fNIne; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pz0fNIne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E09C2BCB3;
	Sat, 25 Apr 2026 18:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140486;
	bh=dE9Y0eDvQwAi3X8MwG/EOcYiFhnRgwiXVQuXA7wY6f4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pz0fNInefvCuyXh799Oj0H1q59ZRPreSaf5HvTtpURIpR3EFNv8rNtLI7BiVIFbAr
	 Hzz/ltO7OcDM+ST+NLxoYznm52cUZ609C/0nD+6DjQAI6d6O+sHAzY4K7FNMJ3sc1G
	 HsbvOrHl9UUx3qOrYy/tbc0/PUGaLMU21sIOUXaRF/ZLaDu+tekO52m6CSQ9e+8dpc
	 VEEnSdJPNhk3IfqM0dbYkmpQTTiV3n8iF1KM6wE5ndpSoLl6tCSdBjCJ/xGCamQn8O
	 EA5mXJ+allAqCzXdeix287FBSUAMeV0UEEUBiiGZg3d44yPy1jGjZyoUDxMIIFj57n
	 sE1J3u3zzIfQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 45/59] perf stackcollapse: Port stackcollapse to use
 python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-46-irogers@google.com>
References: <20260425174858.3922152-46-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:08:05 +0000
Message-Id: <20260425180806.20E09C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Unhandled TypeError in stackcollapse.py when resolving unknown t=
hreads causes the script to crash.
--

commit 702f12c8a01187fcead25d5d7f9e4ce41f1f01ae
Author: Ian Rogers <irogers@google.com>

perf stackcollapse: Port stackcollapse to use python module

This commit modernizes the legacy stackcollapse.py trace script by
refactoring it into a class-based architecture. It uses perf.session
for event processing and aggregates call stacks to produce output
suitable for flame graphs.

> diff --git a/tools/perf/python/stackcollapse.py b/tools/perf/python/stack=
collapse.py
> new file mode 100755
> index 000000000000..996c73246ebc
> --- /dev/null
> +++ b/tools/perf/python/stackcollapse.py

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:

[ ... ]

> +        if self.args.include_comm:
> +            if hasattr(self, 'session') and self.session:
> +                comm =3D self.session.find_thread(sample.sample_pid).com=
m()

Will this crash the script if the thread cannot be found?

The Python extension function pyrf_session__find_thread() in
tools/perf/util/python.c raises a TypeError if the thread lookup fails:

tools/perf/util/python.c:pyrf_session__find_thread() {
    ...
    thread =3D machine__findnew_thread(machine, -1, pid);
    if (thread =3D=3D NULL) {
        PyErr_Format(PyExc_TypeError, "Fail to find thread for mac %d and p=
id %d",
                     machine->pid, pid);
        return NULL;
    }
    ...
}

If perf.data contains samples with unmapped or unresolved PIDs, won't
calling self.session.find_thread() without a try-except block result in an
unhandled TypeError and terminate the script?

> +            else:
> +                comm =3D "Unknown"
> +            comm =3D comm.replace(" ", "_")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D45
