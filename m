Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C7C52F8B
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776646235; cv=none; b=dWQ8CJ8FhjOHKE2h1VyLZSUbGLD5e10xaOzQGoOz+zHwwfOWk6M7XnWr1kvufjWJEsjqx63gojAVn04VA/JacNGe2f+FMUfzRht6mNQ4Ajj7PIwGQ8XMEYle6wHzM9GmcK2dOKK73nCQLotOhzSs7cy5prttddUuG/bL873K99Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776646235; c=relaxed/simple;
	bh=4Eli2SNE28sxpdQyllREpGmvcknawV/Krr2XyJeg1x8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WKFkVuabk6RiY9iupLB3S1xrDzypm29iN41yTUjfJ96rBvYFcPptJ0ugvDdrnJcKRQ6zyLvPXCb2ec8vSjq7OV3izigj9RA982bOTfRTOHqik7VfB9rIXZpd8Qmq7mO6Dg+kIaFqNkSiQasd87yYfVYm6HfocrF03MXRRYLuhG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNoBgg7B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNoBgg7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF53C2BCAF;
	Mon, 20 Apr 2026 00:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776646235;
	bh=4Eli2SNE28sxpdQyllREpGmvcknawV/Krr2XyJeg1x8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VNoBgg7Bm5/WYkbOaxRWDp6qWuge5fG1yZ2lWL6xuRYq1Y++PmTFGcQQYS3G2BRPH
	 mTw6doKcApAyGEhO4Rp4gJToeCTh8Wbfx13hwmW5JrrVkTzPUrmfhGUvR/egO0deTL
	 GeKFZFkWGQvHaYIGpd9JYqsijJUwEyWxXjG89s0c2o9edvAATy1pK+TgF1+mk0mKjF
	 xFD2+GENvuOqGftctm1HClj2Ae2Of0aHxGtIoo1/PEKLmBuf+4fQzFd3IctnXVkZtg
	 VDCzI8Aa2lae1J1T1LOCKvcCEU8UO4N7r8EDFXs59mw52NXNQIn4qVK+z9Zrf3eKLk
	 xBS82XB8NzHoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 48/58] perf rw-by-file: Port rw-by-file to use python
 module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-49-irogers@google.com>
References: <20260419235911.2186050-49-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:50:34 +0000
Message-Id: <20260420005034.CCF53C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Events missing expected fields (like `fd` or `count`) are silent=
ly dropped instead of being logged as unhandled.
- [Medium] Inconsistent syscall substring matching leads to some variants b=
eing silently dropped while others are correctly marked as unhandled.
--

commit 5972219e821f09bb793ad6f36fe0a7dd43826dc1
Author: Ian Rogers <irogers@google.com>

perf rw-by-file: Port rw-by-file to use python module

This commit ports the legacy Perl script rw-by-file.pl to a Python script
using the perf module in tools/perf/python. It leverages the perf.session
API to track read and write activity by file descriptor for a given program.

> diff --git a/tools/perf/python/rw-by-file.py b/tools/perf/python/rw-by-fi=
le.py
> new file mode 100755
> index 0000000000000..4dd164a091e2f
> --- /dev/null
> +++ b/tools/perf/python/rw-by-file.py
[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process events."""
> +        event_name =3D str(sample.evsel)
[ ... ]
> +        if "sys_enter_read" in event_name:

Does this substring check inadvertently match variants like sys_enter_readv
or sys_enter_readlink?=20

If these variants are matched but lack a count field, they will trigger an
AttributeError below, whereas other variants like sys_enter_pread64 would
correctly fall through to the unhandled block.

> +            try:
> +                fd =3D sample.fd
> +                count =3D sample.count
> +                self.reads[fd]["bytes_requested"] +=3D count
> +                self.reads[fd]["total_reads"] +=3D 1
> +            except AttributeError:
> +                return

If an event is missing expected fields (such as if the user did not record
trace fields, or if a syscall variant like sys_enter_readv is matched),
should it be added to the self.unhandled tracker instead of silently
returning here?=20

Silently dropping these events could result in misleading statistics without
alerting the user.

> +        elif "sys_enter_write" in event_name:
> +            try:
> +                fd =3D sample.fd
> +                count =3D sample.count
> +                self.writes[fd]["bytes_written"] +=3D count
> +                self.writes[fd]["total_writes"] +=3D 1
> +            except AttributeError:
> +                return

Similarly, is it intended for write events missing the fd or count fields to
be silently dropped rather than tracked as unhandled?

> +        else:
> +            self.unhandled[event_name] +=3D 1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D48
