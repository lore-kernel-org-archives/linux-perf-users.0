Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6B27080D
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781484794; cv=none; b=iM4uRs9gzGvQulS4wkPg5hGginIrlojUG0egMvqw1genCE8PpKEmuXexhizf+GvUJyev603GMQgF3L6fZFKBDvHo++7bv82WxVjK0nirDQ0rPt0X4+JvX9RFxxzUbdCpRseqQ97hpZANFQArfTFfhvSmcvIDUOQ0o3oQ5jOPg/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781484794; c=relaxed/simple;
	bh=smtgK8Pzih9TU/QmAG2w3jC/vlUkOovzp4Jk9qwKwrI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lDR4pSWK5pnkbJYQAPLgeJOzuFxoaEv5hBtCa85JlN6Xgx1b2ussNdJSXo9GMP1g9gV0OBgYjKP7KL4qjxolL3l5+/FDNn9tOMMZbeiGEKcMlMdojzynfA/1H9Kgp6DFfdu60KokNOvmlsYz/8plBt7cE4iYcqe3YCi8Y28CtXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWOJYtWa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWOJYtWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6AE21F000E9;
	Mon, 15 Jun 2026 00:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781484792;
	bh=FDO29Nq5UfdjpCe0rI0AomRaUWZ46HfLMva3HBm1E40=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UWOJYtWajQQHlhu18xPhgdLrthPwqLiCj+hasRsmiVHEn7O9m/rV4FBP3B7z5PMxI
	 Bp/xIZlQRzg4X5fn1sucssPfQ1PHtC9YZ1kFM2GPwGH+492Qic4kH0I7UY/vBMioRG
	 7ijT3TC3/omVO4wbWWg49tX4QFM64xnCjv1Un9LT3+dXNaPw2Kgvy+CtfcPiWhfs8Q
	 bm3H7wZaq1unDX4tdNDIeEdktpACxyKdK/pOQjsS4KepqPUTPDUaLz0G3kFs7s4IbW
	 YbnB5BYx5ZWWYSfc/lBr7ChLlKzifeCuUoVdsqK4gya4GE13zOVDKLTf0Son2vovhO
	 LmCySSYGqgwPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 20/20] perf python: Add LiveSession helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615002812.2234795-21-irogers@google.com>
References: <20260615002812.2234795-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 00:53:12 +0000
Message-Id: <20260615005312.B6AE21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unhandled TypeError for unsupported event types causes LiveSessi=
on to crash.
--

commit c227e1443773f2d037c5cf7f801f78d6c52b9b64
Author: Ian Rogers <irogers@google.com>
Subject: perf python: Add LiveSession helper

This commit adds a LiveSession class in tools/perf/python/perf_live.py to
support live event collection using perf.evlist and perf.parse_events. This
avoids the need to fork a separate perf record process.

> diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live=
.py
> --- /dev/null
> +++ b/tools/perf/python/perf_live.py
> @@ -0,0 +1,56 @@
[ ... ]
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
> +                        except TypeError as e:
> +                            if "Unknown CPU" in str(e):
> +                                # CPU might be unmapped or offline, wait=
 for mmap event
> +                                break
> +                            raise

[Severity: Medium]
When the perf Python C extension encounters an unsupported perf event type =
in
the ring buffer, it raises a TypeError with the message "Unexpected header
type %u".

Will re-raising the TypeError here cause the polling loop to crash when it
encounters valid but unsupported event types like PERF_RECORD_ITRACE_START?

Since the loop only processes perf.RECORD_SAMPLE events below, should it
ignore these unexpected header types rather than crashing the LiveSession?

> +
> +                        if event is None:
> +                            break
> +
> +                        if event.type =3D=3D perf.RECORD_SAMPLE:
> +                            self.sample_callback(event)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615002812.2234=
795-1-irogers@google.com?part=3D20
