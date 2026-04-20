Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2214D54652
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645230; cv=none; b=LtyyNaMx9hx+BU0Y4FkeUSZbhaRPcHlRZzVGeJOLDb4U3PaR+1PMnwQEekukiOaK+mRxwD2bbfg7/FB7mfQVRKGl1iqbpGexET2nYaGpuN7RsPdZ151p7K0dAghVObH9Q3v35lOwUsWOKpXrCbuCi0ygARkhbf6+Ndgnw4Dw92M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645230; c=relaxed/simple;
	bh=29USBnv0wYM2EXD+lKhDIktl+biifmcWniueS2ME9+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cOUHLg/w+AvuCx3rMzQ2YCU2ePKnhCjev+FXEh51ZDGLaIcKAHZcrT9ChszWAaeKE0ajcSeeHHLTWquuMsze+PY685T762l5QHY2h1cOit4BQJYZ8V+gokzoASpW8jg697lKZyTuJmzUNeekYtxnZqYWI+YDAmdM10scn8IaBFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QinE16xb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QinE16xb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBC8C2BCAF;
	Mon, 20 Apr 2026 00:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645230;
	bh=29USBnv0wYM2EXD+lKhDIktl+biifmcWniueS2ME9+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QinE16xbJuM2F9fzdvi7vBLIEVzUUSGNfDMJA085/7aOx2Lnl54efVaozOP/XqyhF
	 3FlNreMjMfZrj5qJ8vHkrpwC16y1o2OWrXmyTwsxaFAZonxMEaJ/7pitGW/3NA0C7A
	 WtwnAWJM+Ui6lTym183sKGvTdzDHRDoFYVU9d8rJFD865xweA8pMUsE4RXOEyt14+0
	 8eVR/KZ+rTCrhfY18rbM6BYYKEJBiT/PfPjpM0PXeRIQekc/SPn2JgZNXtM80j7UXX
	 DA9wcjE89fRJJTfPLY2u8v3uHTfDERI2HWOHYboJnxezpMPK3e1Z9h3SnIX+5x4Fhm
	 GfYQSntrQ9HNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 43/58] perf sched-migration: Port
 sched-migration/SchedGui to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-44-irogers@google.com>
References: <20260419235911.2186050-44-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:33:49 +0000
Message-Id: <20260420003349.DBBC8C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [High] Python 3 float division causes TypeErrors in wxPython UI layout an=
d generates invalid fractional CPU keys, breaking click functionality.
- [High] The application crashes with an `IndexError` on startup if `perf.d=
ata` lacks scheduler events.
- [High] Event rectangle widths are calculated incorrectly, causing them to=
 stretch and overlap across the timeline.
- [High] `__migrate_in` incorrectly mutates a shared `RunqueueSnapshot` ins=
tance, retroactively corrupting the event history of previous timeslices.
- [High] Trace rendering completely disappears if the view's start time is =
requested slightly before the first recorded event.
--

commit da3c00ae67ea12adb65dbfb69aac20ceea3931bb
Author: Ian Rogers <irogers@google.com>

perf sched-migration: Port sched-migration/SchedGui to use python module

This commit ports sched-migration and SchedGui to use the perf.session
Python module structure. It refactors the tool to use class encapsulation
and cleans up Python 2 compatibility artifacts.

> diff --git a/tools/perf/python/SchedGui.py b/tools/perf/python/SchedGui.py
> new file mode 100755
> index 0000000000000..321b258548838
> --- /dev/null
> +++ b/tools/perf/python/SchedGui.py

[ ... ]

> +        # scrollable container
> +        self.scroll =3D wx.ScrolledWindow(self.panel)
> +        self.scroll.SetScrollbars(self.scroll_scale, self.scroll_scale, =
self.width_virtual / self.scroll_scale, self.height_virtual / self.scroll_s=
cale)
> +        self.scroll.EnableScrolling(True, True)
> +        self.scroll.SetFocus()
> +
> +        # scrollable drawing area
> +        self.scroll_panel =3D wx.Panel(self.scroll, size=3D(self.screen_=
width - 15, self.screen_height / 2))

In Python 3, division (/) returns a float. Does wxPython Phoenix strict
type checking cause a TypeError when a float is passed for the height here?
Should this use integer division (//) instead?

[ ... ]

> +    def paint_rectangle_zone(self, nr, color, top_color, start, end):
> +        offset_px =3D self.us_to_px(start - self.ts_start)
> +        width_px =3D self.us_to_px(end - self.ts_start)

Does this calculate the absolute distance from the start of the trace to the
event's end time, rather than its duration?

If so, will this cause the drawn rectangles to be excessively wide and over=
lap
across the timeline? Should width_px be calculated as self.us_to_px(end - s=
tart)?

> +
> +        offset_py =3D RootFrame.Y_OFFSET + (nr * (RootFrame.RECT_HEIGHT =
+ RootFrame.RECT_SPACE))

[ ... ]

> +    def rect_from_ypixel(self, y):
> +        y -=3D RootFrame.Y_OFFSET
> +        rect =3D y / (RootFrame.RECT_HEIGHT + RootFrame.RECT_SPACE)

Since this uses float division (/), will it return a fractional value?

When this is used in mouse_down() to index into ts.rqs[cpu], will it fail to
find the integer CPU key, resulting in an empty runqueue snapshot on click?
Would integer division (//) be more appropriate here?

> +        height =3D y % (RootFrame.RECT_HEIGHT + RootFrame.RECT_SPACE)

[ ... ]

> diff --git a/tools/perf/python/sched-migration.py b/tools/perf/python/sch=
ed-migration.py
> new file mode 100755
> index 0000000000000..299c8b44064b2
> --- /dev/null
> +++ b/tools/perf/python/sched-migration.py

[ ... ]

> +    def __migrate_in(self, new: int, event):
> +        if new in self.tasks:
> +            self.event =3D event
> +            return self

Since TimeSlice instances share RunqueueSnapshot objects to save memory,
does mutating self.event here corrupt the recorded event history for all
previous timeslices that reference this same snapshot?

Should this return a newly instantiated RunqueueSnapshot instead?

> +        next_tasks =3D self.tasks + tuple([new])
> +
> +        return RunqueueSnapshot(next_tasks, event)

[ ... ]

> +    def find_time_slice(self, ts: int) -> int:
> +        """Binary search for time slice containing timestamp."""
> +        start =3D 0
> +        end =3D len(self.data)
> +        found =3D -1
> +        searching =3D True
> +        while searching:
> +            if start in (end, end - 1):
> +                searching =3D False
> +
> +            i =3D (end + start) // 2
> +            if self.data[i].start <=3D ts <=3D self.data[i].end:

If the parsed perf.data file lacks scheduler events, self.data is empty.
Will this loop fail to break out when searching is set to False, leading
to an IndexError when attempting to access self.data[i] here?

> +                found =3D i
> +                break

[ ... ]

> +    def fill_zone(self, start: int, end: int):
> +        """Fill zone in GUI."""
> +        i =3D self.find_time_slice(start)
> +        if i =3D=3D -1:
> +            return

If the user scrolls such that the requested start time is slightly before
the first recorded event, find_time_slice() returns -1. Does returning
early here cause the timeline to abruptly go completely blank, even if the
end timestamp still overlaps with valid data?

Should it fall back to starting at index 0 instead of returning?

> +
> +        for idx in range(i, len(self.data)):

[ ... ]

> +    def nr_rectangles(self) -> int:
> +        """Return maximum CPU number."""
> +        last_ts =3D self.data[-1]

Similarly, if self.data is empty because no events were parsed, will
accessing self.data[-1] raise an IndexError and crash the application on
startup?

> +        max_cpu =3D 0
> +        for cpu in last_ts.rqs:
> +            max_cpu =3D max(max_cpu, cpu)
> +        return max_cpu

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D43
