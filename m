Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A08635F61E
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918274; cv=none; b=PnZ+UNNS6cVrww49sO1x4C5iNTEl8Fo4i/Ief8zF+XtKz9SOxMC6TLQ8iMhMWI4Amf2LfNfT8+k/9pkk8xb4PBAOgt2XoaUFA+G/tGok2BF2nie1lqdHhPaEaI8E89z6Be//kwq+aAsb66IJrwiQOncNN9kFkk+T5On1+pFsjbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918274; c=relaxed/simple;
	bh=Q7WKZ+UES6pOi01C3PjqbvXE1hYkVOSLyCx5i5/QJzI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KbP0fZ3eACbAjgI6OoMOTcBgvRVDSG1EIaQjCeUwVSt0m3RW8X92SfSc0BS6u12jwLlsu1opUcre/0GUsj/HVUi4Dd69ZIz3GHt16v8csu6YZyPdrRtfbYo2bbi0DNxg52sdNuG0BOFFidO84evGRUlwkg3LPK+gJWrGZgMjm0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNv6gU/X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNv6gU/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0974AC2BCB2;
	Thu, 23 Apr 2026 04:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918274;
	bh=Q7WKZ+UES6pOi01C3PjqbvXE1hYkVOSLyCx5i5/QJzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PNv6gU/XOabCJkcmtqUdyNds8vNgpz3L/3sMonRuf1SPQk7y0YgImwl6vk2mc5cOt
	 7pyk2Gr8+THHXJAT4sgKzte8c4zh/zzgYdLXuBVdc1mVFD7kDiLxx4XANBXQ7FciyQ
	 SfsaOdza1g0yYI5tXVTzegiOSsq0TCb+mFBDFtMw1RaAKeKdRfaq85XkOkMIVlyOC0
	 luCbULPd/vpGD1PStbhXElNnCOHIp4nwoHhgjfkEsMPhUoanqUFry+7znYcxjIKj6Q
	 u4y5v9hOZwXddPkVbVl9RwdhrMUChpDaGMkrIeNBX5MEVKYo3ZtI/3NLeGeIrvqqaN
	 kO4a1KXHQTJMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 34/58] perf compaction-times: Port compaction-times
 to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-35-irogers@google.com>
References: <20260423035526.1537178-35-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:24:33 +0000
Message-Id: <20260423042434.0974AC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Unhandled TypeError in `process_event` causes the script to cras=
h when encountering an unknown PID.
--

commit 4023b66297eca8ef0450545c5dcac6b276aa8674
Author: Ian Rogers <irogers@google.com>

perf compaction-times: Port compaction-times to use python module

This commit adds a port of the compaction-times script that uses the perf
python module directly. This approach avoids creating intermediate
dictionaries for all event fields, resulting in faster execution.

> diff --git a/tools/perf/python/compaction-times.py b/tools/perf/python/co=
mpaction-times.py
> new file mode 100755
> index 0000000000000..153b47930e3cc
> --- /dev/null
> +++ b/tools/perf/python/compaction-times.py

[ ... ]

> +def process_event(sample: perf.sample_event) -> None:
> +    """Callback for processing events."""
> +    event_name =3D str(sample.evsel)
> +    pid =3D sample.sample_pid
> +    comm =3D session.process(pid).comm() if session else "[unknown]"

If the thread for a given pid is not found in the machine's thread map,
session.process(pid) raises a TypeError from the underlying C extension.

Because this call is not wrapped in a try-except block, will this crash the
script when it processes an event from a pre-existing process that is
missing a comm event?

Could this be wrapped to catch the exception and fall back to [unknown],
similar to how the original script safely utilized the comm value directly
from the trace event?

> +    secs =3D sample.sample_time // 1000000000
> +    nsecs =3D sample.sample_time % 1000000000

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D34
