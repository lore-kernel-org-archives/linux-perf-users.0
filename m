Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C8838C2B3
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158037; cv=none; b=AC7QKqMjQuKaX/taimgyduiHdQllQdud0b7LQE7LU/GwJnZ2S4TGdn4B1NSfMRXWRVHmZgG+21Lv2JcovHHzdNfuCvMV9GiGYLdgNvLUY9OapndP/GvUkmb/lnnseWA1kT2TWBSvaw1MR5FTiUIn8cK6SAAoPLkNPyoyHalfsEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158037; c=relaxed/simple;
	bh=0zS7Bcus2QbIMHT+UPQUP3sKWPUvNNudBh6KeTKiUpY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kPB6GYCH7ElmqfJunSpKTv9tcyrlTyIMAPGchTGNk3kZCag+vkm1bVbaML/rdyLJTTTg6PZ2/clyLMYMvkDxU+0vf9KJiI/vYjIOQIb7eaQ8kEHOrQoqETxAsz62tuxCMJ+YT1Q68cLmLsgbRNRJLef9h7i/vpe12Ew1P8Mu1ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEKsOagw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEKsOagw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C02BC2BCB0;
	Sat, 25 Apr 2026 23:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158037;
	bh=0zS7Bcus2QbIMHT+UPQUP3sKWPUvNNudBh6KeTKiUpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=UEKsOagwTSPmVOlOmf5EaEaPAVGEy3BE8Z02yJZPxELKHJfRM8915eTx+UEmM1MwB
	 N1gWxw5HSbBjxdikzDPwn15LN4iboR4ViS/KQpdnX3CLF5yZcKsQmTumapOb4QAPkO
	 ZeAWsaYUIVuhJON8z5V5O9SpZMqSCRx9BR4P5K5aO02ujY4NhVhE8qu/Bf+Vger9Oa
	 YCUpcOoPz+yDNzRIQhwclGcOhoKjP8RxZKIPMbSDN1WiVoXr+7MJb6HOfVeZRHY7ic
	 mzMbiJNlt2d1w12WU5xoqKY47HFaKzisrPwxAaVAYF7go2A4yno/QviAn1h33DLIyq
	 T1yA6JWouOLcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 40/59] perf net_dropmonitor: Port net_dropmonitor to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-41-irogers@google.com>
References: <20260425224951.174663-41-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:00:36 +0000
Message-Id: <20260425230037.5C02BC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Functional regression and complete loss of tracepoint payload reso=
lution for packet drops.
- [Low] Unreachable exception handler and unused state.
--

commit edf996a7ae15bad5d7cd695a6cdfaedcc992dd17
Author: Ian Rogers <irogers@google.com>

perf net_dropmonitor: Port net_dropmonitor to use python module

This commit ports the net_dropmonitor script to use the perf python module.
It encapsulates the state in a DropMonitor class and processes events
using perf.session.

>     - Maintained the manual /proc/kallsyms reading and binary search for
>       symbol resolution as in the original script.

Is this description accurate? The manual /proc/kallsyms reading and binary
search logic appears to be entirely missing in the provided script.

> diff --git a/tools/perf/python/net_dropmonitor.py b/tools/perf/python/net=
_dropmonitor.py
> new file mode 100755
> index 000000000000..25ea2a66ed3c
> --- /dev/null
> +++ b/tools/perf/python/net_dropmonitor.py
[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process a single sample event."""
> +        if str(sample.evsel) !=3D "evsel(skb:kfree_skb)":
> +            return
> +
> +        try:
> +            symbol =3D getattr(sample, "symbol", "[unknown]")

Does this resolve the actual drop location? The skb:kfree_skb tracepoint
logs the actual caller responsible for dropping the packet in its payload,
while the event's instruction pointer (which sample.symbol resolves) usually
points to the tracepoint itself. This could result in all dropped packets
being erroneously attributed to kfree_skb rather than their true locations.

> +            symoff =3D getattr(sample, "symoff", 0)
> +            self.drop_log[(symbol, symoff)] +=3D 1
> +        except AttributeError:

Can this exception handler ever be reached? Because getattr is called with
default values, it will return the default instead of raising an
AttributeError if the attribute is missing.

> +            self.unhandled[str(sample.evsel)] +=3D 1

This isn't a bug, but it doesn't look like self.unhandled is ever reported
or used anywhere else in the DropMonitor class.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D40
