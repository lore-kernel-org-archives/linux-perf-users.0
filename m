Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0444543C063
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781201261; cv=none; b=AxGvVdwn24alxJjG1jqgkvyctsJn7trICqXxiIU0w27ZjkVQIHRCDXK3KjeoIbKu3mfywMNddgj/0MDaE8xq6hgC9nUdPrN63/7qgmnL2boCJXBXrKuvsjduwmUkmSU4iiVrmsGEPtzMmQf8C60FC8z2E4wqWN5TwURGY7EFOWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781201261; c=relaxed/simple;
	bh=89oiEoagwwMnPY3XuE5cVt/dq7gILC7icxz2ZWanZb0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tlxncHvK9gTp7oM2V3fDvNgzqq/Zbm2L7wtCLLBVoCu+Mems3lg7czW5yX5BBEx80ZXD2Rlk2peeidYa0Vosq92n742jz/hbmJCMg81zRjldI9RRN+8gr21xwH1oeNtknh1d2BEHlFY+X4CQPSzkI6cMl8vhvetAHFGaQWKF72Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oA2+MMw6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oA2+MMw6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AF61F000E9;
	Thu, 11 Jun 2026 18:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781201259;
	bh=aVDtZtrJ248hGCWO2jjGNPaug9Vz8HyNkfxtfo3/YJk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oA2+MMw6+DZvzwcb4TFVcgoXEOzbg7ji+A9LElk4jM4zouVNzN9aAzYoPSLSHdaLj
	 7Lmy8DZiJKK34cy9ei0KGlN6KFcqteN0meyks7trbCAwZ1ivNZ3oHsxGCxWsN8ILIx
	 Jieg/d+t0nxxACIQbdumQPDzqUXtySJYV7tUpSUPYvtZwnvKhc4J9mLlHdTkCwig79
	 50YaDqJ69cs9HSUuEYACNnlbAF/Tr00OVHztKX+a0k+xoKcXw+UXijwaxUUcrgGMvI
	 X3spllf3KDWXUi+whlmt5U1DuCSYKCLpHzxcpLkiZvfe17vZbPil7XigKgMDBD6n7Z
	 ep34OJoMHE4DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 19/19] perf python: Add LiveSession helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611171756.4008769-20-irogers@google.com>
References: <20260611171756.4008769-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:07:38 +0000
Message-Id: <20260611180739.58AF61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Uncaught OSError crash when reading empty buffer due to missing =
errno attribute.
- [Medium] Handling of `TypeError` causes 1000 redundant exceptions per unm=
apped CPU per poll interval.
--

commit bf853fc992a19eb853b3feaadf1ec029496e810b
Author: Ian Rogers <irogers@google.com>

perf python: Add LiveSession helper

This commit adds a LiveSession class to tools/perf/python/perf_live.py to=20
support live event collection. This allows event processing using perf.evli=
st=20
and perf.parse_events without requiring a separate perf record process.

> diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live=
.py
> new file mode 100755
> index 0000000000000..7455f60d21157
> --- /dev/null
> +++ b/tools/perf/python/perf_live.py

[ ... ]

> +                for cpu in self.cpus:
> +                    for _ in range(1000): # Limit to 1000 events per CPU=
 per poll to prevent starvation
> +                        try:
> +                            event =3D self.evlist.read_on_cpu(cpu)
> +                        except TypeError:
> +                            # CPU might be unmapped or offline, wait for=
 mmap event
> +                            continue

[Severity: Medium]
Does this continue erroneously target the inner for _ in range(1000): loop
instead of skipping to the next CPU? If read_on_cpu() raises a TypeError due
to an unmapped CPU, this will uselessly catch the exception 1000 times per
poll interval. Should this be a break to escape to the outer CPU loop inste=
ad?

> +                        except OSError as e:
> +                            # Ignore -EAGAIN on empty buffer
> +                            if e.errno =3D=3D errno.EAGAIN:

[Severity: Medium]
Will this check crash the loop on empty buffers? The underlying C extension
pyrf_evlist__read_on_cpu() raises the exception using
PyErr_Format(PyExc_OSError, ...), which does not explicitly set the .errno
attribute.=20

Because e.errno will evaluate to None, e.errno =3D=3D errno.EAGAIN will be =
false.=20
This causes the script to unconditionally re-raise the OSError on the first=
=20
empty buffer instead of breaking.

> +                                break
> +                            # OS/mmap errors are unrecoverable
> +                            raise e
> +
> +                        if event is None:
> +                            break

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611171756.4008=
769-1-irogers@google.com?part=3D19
