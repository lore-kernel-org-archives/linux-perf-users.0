Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054D340DFCE
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776644563; cv=none; b=f9F+/qmYCFcbYpYNvAf+9PvvhhMG05IbwXHWrnswA7prMX0lU+3Kmykr5IM61YVYUiiMGnmu+milrA7esROAH246ztnDDY4Pp4KIEE1zQQNaRk9omDVy68yHSmxNrPCCwLMgGIsde90QDCsctZZCRk2FLq26M2fI/8J8tVDOkPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776644563; c=relaxed/simple;
	bh=o91V7QoyGnMUVVP31itJtKh4uG5qz/qyO3TbV9ujO3Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CLvPPobw83lc8WDHSHEdA5v+zIAqZveLH2kKdI/UNAhIJIq6t/0oBUbhiq/Z2qX2sI/029Ykq3FBB3v3OJeeBgqVCV/SnQ7tWlDLxvnA4QBjWsholT+uCfVZxJbG0cH2swTXK3olpn76c9/ISPzwXUmFBSrtkvSFumCXD3LY1VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiPmBpuW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiPmBpuW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830F9C2BCAF;
	Mon, 20 Apr 2026 00:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776644562;
	bh=o91V7QoyGnMUVVP31itJtKh4uG5qz/qyO3TbV9ujO3Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=TiPmBpuWBUvzdgWuyJPYHBBfE6hrBewD/lN6w6fyI5A8rS/csrHJoTbsg0x8VhvYb
	 I5YdvfOmy1UoXq6pEPI0ugmd7z/irC4UQ8HBuwx6buo7dOMRzOterC352y8rCn2otB
	 eqXeLrCvuXw2W543aMGmtpbrV3OfP0q+T7Z4syVzbYtZHiuq1yqKLKTFx5nHluIhwk
	 GQAfNLEpw8aVMXSSJUAWGOKTP4dZlOSCIIPdaPTI3h5FctQl9vGbSEOcruwFLhQraD
	 a+7PRq8XOrADfEDyuKM6iX++NBrkhRdlQXUHc6txxWf8oD+PZP9LB/4i8NXYCll0NK
	 RDXnRvADIBN2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 40/58] perf net_dropmonitor: Port net_dropmonitor to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-41-irogers@google.com>
References: <20260419235911.2186050-41-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:22:41 +0000
Message-Id: <20260420002242.830F9C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] The `KeyboardInterrupt` exception handler unintentionally restar=
ts the cleanup phase, leading to duplicated data.
- [Medium] Drop locations are incorrectly sorted lexicographically as strin=
gs instead of numerically.
--

commit 944cd5b52d19260b42c7e0a2807670526ba16f3d
Author: Ian Rogers <irogers@google.com>

perf net_dropmonitor: Port net_dropmonitor to use python module

This patch ports net_dropmonitor to use the python module by encapsulating
state in a DropMonitor class. It replaces legacy global handlers with
perf.session for event processing and removes Python 2 compatibility
artifacts.

> diff --git a/tools/perf/python/net_dropmonitor.py b/tools/perf/python/net=
_dropmonitor.py
> new file mode 100755
> index 0000000000000..474b616725b8f
> --- /dev/null
> +++ b/tools/perf/python/net_dropmonitor.py
[ ... ]
> +    def print_drop_table(self) -> None:
> +        """Print aggregated results."""
> +        print(f"{'LOCATION':>25} {'OFFSET':>25} {'COUNT':>25}")
> +        for i in sorted(self.drop_log.keys()):

Since drop_log stores string keys, will sorted(self.drop_log.keys()) order
the memory locations lexicographically rather than numerically?

[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
[ ... ]
> +        slocation =3D str(location)
> +        self.drop_log[slocation] +=3D 1
[ ... ]
> +    try:
> +        print("Starting trace (Ctrl-C to dump results)")
> +        session =3D perf.session(perf.data(args.input), sample=3Dmonitor=
.process_event)
> +        session.process_events()
> +
> +        print("Gathering kallsyms data")
> +        monitor.get_kallsyms_table()
> +        monitor.print_drop_table()
> +    except KeyboardInterrupt:
> +        print("\nGathering kallsyms data")
> +        monitor.get_kallsyms_table()
> +        monitor.print_drop_table()

If a KeyboardInterrupt occurs while gathering kallsyms data or printing the
table, will this exception handler execute the cleanup phase a second time?

Looking at get_kallsyms_table():

    def get_kallsyms_table(self) -> None:
        ...
                    self.kallsyms.append((loc, name))

Because it appends to the kallsyms list, could restarting this phase lead
to duplicated entries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D40
