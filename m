Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C6C4C954D
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198906; cv=none; b=V89Vy53TNyy7asXKiYsOcqu0cuu/XF9R5jZf20D/5DItn6eK8TgACaJw9FAqMVsSB1ZExeWYuJQLUc+rMfGYHBBZka6fpQ+lR9SUo35hnJ1Y/KnqwiHUvIavgarAwTTWTyp/74FDMT4WYzkY4N3X735Ujf+TR6tZ0jjFqvSNeVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198906; c=relaxed/simple;
	bh=yMobTvAkc/FalfiwnAxISTog1HsnEDPWvCVhB4krSkY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fhm1ljdmC+UtgFDSCMdwJ5faNZs2TMvWGX7nj6cJbWtiiTcrtx5f3WG02dQRV001Pfm1pTVVb/hugtOUAH2LoIcy/ogmgdyX3G45H3ZkISoUlCC4ODEt+V/GqJTtNuPRWf00sR0hkGrpTKhZNzD9Qf1Wk0bO2zpnWxf2H4YUZOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9TaSdlN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9TaSdlN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1999F1F00893;
	Thu, 11 Jun 2026 17:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781198903;
	bh=PuP28waTLgoEgfrqLNjOT5A0HkJvLfyUJuVFva1Y9pc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O9TaSdlNrEsp8ltdTdqHu+UP0KMYG/Hyce+Y9U70XL/pIuajNDUsemL82HIGDC2kR
	 wioiNXaokSc3J3r9YJfeM1E4xtH/IR6nG41KPkV7EqgD9VU0G6zXUtPSQjVg2yNJgP
	 02AH/fnj9GdQg+Ic1KZ4FRVIF9zFPTJg+ioTfq1oZu3t4QIqDfyHsb6EQerNdqtZxI
	 MhaEB7gt7sJtDmlMQ4oghlDdCVgyT8JSrgUtXIDFecX97Vq7RccpZWlqp9sdm8pgYx
	 3SI/sWrykmrI1uL+rDyXeqKhO9hQXEQLrBVgPQN6O2J9WtGf+PAXjmqbZm3nLKuo1p
	 vY6RlyWdHAXlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 2/5] perf inject/aslr: Add ASLR tool infrastructure
 and MMAP tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611164122.3974068-3-irogers@google.com>
References: <20260611164122.3974068-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:28:22 +0000
Message-Id: <20260611172823.1999F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Heap out-of-bounds read/write in `perf_event__repipe_attr` via T=
OCTOU race condition
--

commit 0ecff6d57b51709063f6cde26a7febea45ab1d6a
Author: Ian Rogers <irogers@google.com>

perf inject: Add ASLR virtual address remapping

This patch introduces the core ASLR remapping tool infrastructure and
implements remapping/tracking for metadata events. Sample events are
delegated without remapping for now.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 75ffe31d03fe..8bb37095e2de 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -234,20 +237,36 @@ static int perf_event__repipe_attr(const struct per=
f_tool *tool,
>  	u64 *ids;
>  	int ret;
> =20
> +	union perf_event *aslr_event =3D NULL;
> +
>  	ret =3D perf_event__process_attr(tool, event, pevlist);
>  	if (ret)
>  		return ret;
> =20
> +	if (inject->aslr) {
> +		aslr_event =3D malloc(event->header.size);
> +		if (!aslr_event)
> +			return -ENOMEM;
> +		memcpy(aslr_event, event, event->header.size);
> +		aslr_tool__strip_attr_event(aslr_event, pevlist);
> +		event =3D aslr_event;
> +	}

[Severity: Medium]
Could this introduce a TOCTOU (Time-Of-Check to Time-Of-Use) race condition?

Since event points directly to the memory-mapped perf.data file contents,
reading event->header.size multiple times without READ_ONCE allows a
concurrent modification to change the size between the malloc() and memcpy()
calls.

This could result in a heap buffer overflow during memcpy(), or bypass the
earlier size validation done in perf_event__process_attr(). This would leave
malicious sizes in the copied event->attr.attr.size for
aslr_tool__strip_attr_event() to blindly trust.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> new file mode 100644
> index 000000000000..56fc444fbf54
> --- /dev/null
> +++ b/tools/perf/util/aslr.c
[ ... ]
> +void aslr_tool__strip_attr_event(union perf_event *event, struct evlist =
**pevlist __maybe_unused)
> +{
> +	u32 attr_size;
> +
> +	attr_size =3D event->attr.attr.size ?: PERF_ATTR_SIZE_VER0;
> +
> +	if (attr_size >=3D (offsetof(struct perf_event_attr, sample_type) + siz=
eof(u64))) {
> +		event->attr.attr.sample_type &=3D ASLR_SUPPORTED_SAMPLE_TYPE;
> +	}
> +
> +	if (attr_size >=3D (offsetof(struct perf_event_attr, type) + sizeof(u32=
))) {
> +		u32 type =3D event->attr.attr.type;
> +
> +		if (type =3D=3D PERF_TYPE_BREAKPOINT &&
> +		    attr_size >=3D (offsetof(struct perf_event_attr, bp_addr) + sizeof=
(u64))) {
> +			event->attr.attr.bp_addr =3D 0;
> +		} else if (type >=3D PERF_TYPE_MAX) {
> +			struct perf_pmu *pmu;
> +
> +			pmu =3D perf_pmus__find_by_type(type);
> +			if (pmu && (!strcmp(pmu->name, "kprobe") ||
> +				    !strcmp(pmu->name, "uprobe"))) {
> +				if (attr_size >=3D (offsetof(struct perf_event_attr, config1) + size=
of(u64)))
> +					event->attr.attr.config1 =3D 0;
> +				if (attr_size >=3D (offsetof(struct perf_event_attr, config2) + size=
of(u64)))
> +					event->attr.attr.config2 =3D 0;

[Severity: Medium]
If a malicious size is copied into the heap buffer due to the TOCTOU race in
perf_event__repipe_attr(), does this code perform an out-of-bounds write?

Since aslr_tool__strip_attr_event() implicitly trusts the attr_size read
from the heap copy, clearing config1 and config2 could overwrite adjacent
heap memory if attr_size is large, but the actual allocated
event->header.size was small.

> +			}
> +		}
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611164122.3974=
068-1-irogers@google.com?part=3D2
