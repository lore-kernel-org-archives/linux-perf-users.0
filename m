Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB7C54EEC5
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187289; cv=none; b=KpNszu/VBJosqJ9nei11Mj+WobajYgsVJLJN+S2mXS2l7rYrOlYgSAQGH0EYBq1QfWMeeIg5RPA2emKQKUMy/bIfhX6Xo/6+NHsytE68BR6GBNNjerI0OgdAVoBMjojwmx2BZXA8ERElrNq7SZzDgRvR6LI7UmyVYv5dzkjtBpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187289; c=relaxed/simple;
	bh=ndDTc+4GS7DcpKJFqZ/hQKF6sToKaY2L8As/gxU2g38=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a4/oSmqq8W+kt94/dY0gHjurC1g6LMnjRLKqNo6xm5TaecJcPHVMD2Zo5kylShAhT18t+qim66DE5TsH9Pcxu2fWlDHlwfOy8S0ON66DmT+9mrgxJZI43Uwzc9veKDtqFhxz4VPU1tLJE/Enb7MfH6xK2z3vrpBEJH7o2sphc+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QiCi8l0k; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QiCi8l0k"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33310847fcaso2106713eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187275; x=1790792075; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H5ND4FKwMFR7aZC9PoS/rQUk5KnvdAHVmxyy74Fp8mo=;
        b=QiCi8l0kaGRrJm+NTHX4QK3OrewmKwhkA05ffz1PeVNdNASEtRAESzz0EocbNNYY1B
         vdRgppAMkx/EeeDo6cDU69B2fktfuw+Ghen0wJCQCTBlTIl2D+cOq3mityDtY3DdahvU
         KM3eN6oN0I9a44rnI3oxJ3jhBZMVSe/XMvVjAzbID7/ewtHff2YrerqsOlnsrcI4Qazu
         INm1qwPHkEUj2GPmtv6sYKRwixRwxQn1vgonCVDVmCoXZeY3aCgcvR6vjquFbN2UiFk5
         V58BcO/SQcIh6uL9SMP/stnSlQAp4+9e81ajwcwsdOt6jEf7F0ib0bETXL7aPoiO+S+U
         6x9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187275; x=1790792075;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H5ND4FKwMFR7aZC9PoS/rQUk5KnvdAHVmxyy74Fp8mo=;
        b=OcpPtut2+qWOhEEEpvw/B4VYRopdxWupMkpSjP9JQGaPxdv+z29os67ySpYvQZOnqR
         G8troM2Cn+TIbMFUN3bVxdna6iVxokJcq6FLFk1FeqMk+u5BM2KGnlftsth2utKjm8Y2
         owpVCL6NJlVx9k6Lh8hEj7TQ+pa5V/ogll0VGDP+tf5VYT30JP+OPng7UGqDgAX+KOsT
         Tqao72BSGcxzo0C5gYygWfThm979bat/GVgwzIwVIyAE7fqWkm2rmcQPeSNv0QDVbCwN
         Pel+3j0I0Y/1gzb4kZ6/4b0Duzfo9+9j5QqAkTRhrctwKsiUJb+LcTYydBhh5PXJQpOj
         sPhw==
X-Forwarded-Encrypted: i=1; AKwUvByCd81HqvMWXGgDyNHb9u0Xl7pKYR777a3I2XIMICgn+5IiIpMOdAbrkKYEdVTYkncUfeVbwNIl0Ddbg/iYOpI5@vger.kernel.org
X-Gm-Message-State: AFuF++nGxtHTboF0hcV9xGH9PW8pY+yN340jRyqUHsu7Pyd44lZfqpfT
	PsGOQv7Tt9F03scHkQ3LHLbMZXYpGjf+384Xsz/rzs9mREGdXpIYT/UuEJka7ymbvYy98L4xGLm
	Tl5/10bN5/A==
X-Received: from dybpi12.prod.google.com ([2002:a05:7301:420c:b0:33e:529f:6f40])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4208:b0:33c:2457:bdb2
 with SMTP id 5a478bee46e88-33ffe74cd9emr19106eec.6.1790187274672; Wed, 23 Sep
 2026 11:14:34 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:11:55 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-33-irogers@google.com>
Subject: [PATCH v3 32/49] perf python: Port sched-migration and SchedGui to
 perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Port sched-migration.py and SchedGui.py from tools/perf/scripts/python/
to standalone modules in tools/perf/python/:
- Refactor sched-migration.py into a SchedMigrationAnalyzer class using
  perf.session for event processing and add argparse CLI support
  (-i/--input, -v/--verbose, --gui, --no-gui).
- Port SchedGui.py to tools/perf/python/ as a local module dependency.
- Load wxPython dynamically via importlib only when GUI mode (--gui) is
  requested so text-mode analysis, testing on headless systems, and
  static analysis (mypy/pylint) succeed without wx installed.
- Remove Python 2 compatibility code.

Add a shell test (test_sched_migration_python.sh) to verify the
standalone script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/SchedGui.py                 | 246 +++++++++
 tools/perf/python/sched-migration.py          | 496 ++++++++++++++++++
 .../shell/test_sched_migration_python.sh      |  72 +++
 3 files changed, 814 insertions(+)
 create mode 100755 tools/perf/python/SchedGui.py
 create mode 100755 tools/perf/python/sched-migration.py
 create mode 100755 tools/perf/tests/shell/test_sched_migration_python.sh

diff --git a/tools/perf/python/SchedGui.py b/tools/perf/python/SchedGui.py
new file mode 100755
index 000000000000..fa0d010fe528
--- /dev/null
+++ b/tools/perf/python/SchedGui.py
@@ -0,0 +1,246 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# SchedGui.py - Python extension for perf script, basic GUI code for
+#		traces drawing and overview.
+#
+# Copyright (C) 2010 by Frederic Weisbecker <fweisbec@gmail.com>
+#
+# Ported to modern directory structure.
+
+"""SchedGui.py - Python extension for perf script, basic GUI code for traces drawing and overview."""
+from __future__ import annotations
+
+import importlib
+from typing import Any
+
+class _DummyWx:
+    """Dummy wx module fallback when wxPython is not installed."""
+    Frame = object
+
+
+try:
+    wx: Any = importlib.import_module("wx")
+    WX_AVAILABLE = True
+except ImportError:
+    wx = _DummyWx
+    WX_AVAILABLE = False
+
+
+class RootFrame(wx.Frame):
+    """Main window frame for scheduling trace visualization."""
+    Y_OFFSET = 100
+    RECT_HEIGHT = 100
+    RECT_SPACE = 50
+    EVENT_MARKING_WIDTH = 5
+
+    def __init__(self, sched_tracer, title, parent=None, win_id=-1):
+        if not WX_AVAILABLE:
+            raise ImportError("You need to install the wxpython lib for this script")
+        wx.Frame.__init__(self, parent, win_id, title)
+
+        self.dc = None
+        (self.screen_width, self.screen_height) = wx.GetDisplaySize()
+        self.screen_width -= 10
+        self.screen_height -= 10
+        self.zoom = 0.5
+        self.scroll_scale = 20
+        self.sched_tracer = sched_tracer
+        self.sched_tracer.set_root_win(self)
+        (self.ts_start, self.ts_end) = sched_tracer.interval()
+        self.update_width_virtual()
+        self.nr_rects = sched_tracer.nr_rectangles() + 1
+        self.height_virtual = RootFrame.Y_OFFSET + \
+            (self.nr_rects * (RootFrame.RECT_HEIGHT + RootFrame.RECT_SPACE))
+
+        # whole window panel
+        self.panel = wx.Panel(self, size=(self.screen_width, self.screen_height))
+
+        # scrollable container
+        # Create SplitterWindow
+        self.splitter = wx.SplitterWindow(self.panel, style=wx.SP_3D)
+
+        # scrollable container (Top)
+        self.scroll = wx.ScrolledWindow(self.splitter)
+        self.scroll.SetScrollbars(self.scroll_scale, self.scroll_scale,
+                                  int(self.width_virtual // self.scroll_scale),
+                                  int(self.height_virtual // self.scroll_scale))
+        self.scroll.EnableScrolling(True, True)
+        self.scroll.SetFocus()
+
+        # scrollable drawing area
+        self.scroll_panel = wx.Panel(self.scroll,
+                                     size=(self.screen_width - 15, self.screen_height // 2))
+        self.scroll_panel.Bind(wx.EVT_PAINT, self.on_paint)
+        self.scroll_panel.Bind(wx.EVT_KEY_DOWN, self.on_key_press)
+        self.scroll_panel.Bind(wx.EVT_LEFT_DOWN, self.on_mouse_down)
+        self.scroll.Bind(wx.EVT_KEY_DOWN, self.on_key_press)
+        self.scroll.Bind(wx.EVT_LEFT_DOWN, self.on_mouse_down)
+
+        self.scroll_panel.SetSize(int(self.width_virtual), int(self.height_virtual))
+
+        # Create a separate panel for text (Bottom)
+        self.text_panel = wx.Panel(self.splitter)
+        self.text_sizer = wx.BoxSizer(wx.VERTICAL)
+        self.txt = wx.TextCtrl(self.text_panel, -1, "Click a bar to see details",
+                               style=wx.TE_MULTILINE)
+        self.text_sizer.Add(self.txt, 1, wx.EXPAND | wx.ALL, 5)
+        self.text_panel.SetSizer(self.text_sizer)
+
+        # Split the window
+        self.splitter.SplitHorizontally(self.scroll, self.text_panel, (self.screen_height * 3) // 4)
+
+        # Main sizer to layout splitter
+        self.main_sizer = wx.BoxSizer(wx.VERTICAL)
+        self.main_sizer.Add(self.splitter, 1, wx.EXPAND)
+        self.panel.SetSizer(self.main_sizer)
+
+        self.scroll.Fit()
+        self.Fit()
+
+        self.Show(True)
+
+    def us_to_px(self, val):
+        """Convert microseconds to pixels."""
+        return val / (10 ** 3) * self.zoom
+
+    def px_to_us(self, val):
+        """Convert pixels to microseconds."""
+        return (val / self.zoom) * (10 ** 3)
+
+    def scroll_start(self):
+        """Get scroll start position in pixels."""
+        (x, y) = self.scroll.GetViewStart()
+        return (x * self.scroll_scale, y * self.scroll_scale)
+
+    def scroll_start_us(self):
+        """Get scroll start position in microseconds."""
+        (x, _) = self.scroll_start()
+        return self.px_to_us(x)
+
+    def paint_rectangle_zone(self, nr, color, top_color, start, end):
+        """Draw a rectangle zone for a CPU."""
+        offset_px = self.us_to_px(start - self.ts_start)
+        width_px = self.us_to_px(end - start)
+
+        offset_py = RootFrame.Y_OFFSET + (nr * (RootFrame.RECT_HEIGHT + RootFrame.RECT_SPACE))
+        width_py = RootFrame.RECT_HEIGHT
+
+        dc = self.dc
+
+        if top_color is not None:
+            (r, g, b) = top_color
+            top_color = wx.Colour(r, g, b)
+            brush = wx.Brush(top_color, wx.SOLID)
+            dc.SetBrush(brush)
+            dc.DrawRectangle(int(offset_px), int(offset_py),
+                             int(width_px), RootFrame.EVENT_MARKING_WIDTH)
+            width_py -= RootFrame.EVENT_MARKING_WIDTH
+            offset_py += RootFrame.EVENT_MARKING_WIDTH
+
+        (r, g, b) = color
+        color = wx.Colour(r, g, b)
+        brush = wx.Brush(color, wx.SOLID)
+        dc.SetBrush(brush)
+        dc.DrawRectangle(int(offset_px), int(offset_py), int(width_px), int(width_py))
+
+    def update_rectangles(self, start, end):
+        """Update rectangles in the given time window."""
+        start += self.ts_start
+        end += self.ts_start
+        self.sched_tracer.fill_zone(start, end)
+
+    def on_paint(self, event):
+        """Handle paint event."""
+        window = event.GetEventObject()
+        dc = wx.PaintDC(window)
+
+        # Clear background to avoid ghosting
+        dc.SetBackground(wx.Brush(window.GetBackgroundColour()))
+        dc.Clear()
+
+        self.dc = dc
+        try:
+            width = min(self.width_virtual, self.screen_width)
+            (x, _) = self.scroll_start()
+            start = self.px_to_us(x)
+            end = self.px_to_us(x + width)
+            self.update_rectangles(start, end)
+
+            # Draw CPU labels at the left edge of the visible area
+            (x_scroll, _) = self.scroll_start()
+            for nr in range(self.nr_rects):
+                offset_py = RootFrame.Y_OFFSET + (nr * (RootFrame.RECT_HEIGHT + RootFrame.RECT_SPACE))
+                dc.DrawText(f"CPU {nr}", x_scroll + 10, offset_py + 10)
+        finally:
+            self.dc = None
+
+    def rect_from_ypixel(self, y):
+        y -= RootFrame.Y_OFFSET
+        rect = y // (RootFrame.RECT_HEIGHT + RootFrame.RECT_SPACE)
+        height = y % (RootFrame.RECT_HEIGHT + RootFrame.RECT_SPACE)
+
+        if rect < 0 or rect > self.nr_rects - 1 or height > RootFrame.RECT_HEIGHT:
+            return -1
+
+        return rect
+
+    def update_summary(self, txt):
+        self.txt.SetValue(txt)
+        self.text_panel.Layout()
+        self.splitter.Layout()
+        self.text_panel.Refresh()
+
+    def on_mouse_down(self, event):
+        pos = event.GetPosition()
+        x, y = pos.x, pos.y
+        rect = self.rect_from_ypixel(y)
+        if rect == -1:
+            return
+
+        t = self.px_to_us(x) + self.ts_start
+
+        self.sched_tracer.mouse_down(rect, t)
+
+    def update_width_virtual(self):
+        self.width_virtual = self.us_to_px(self.ts_end - self.ts_start)
+
+    def __zoom(self, x):
+        self.update_width_virtual()
+        (xpos, ypos) = self.scroll.GetViewStart()
+        xpos = int(self.us_to_px(x) // self.scroll_scale)
+        self.scroll_panel.SetSize((int(self.width_virtual), int(self.height_virtual)))
+        self.scroll.SetScrollbars(self.scroll_scale, self.scroll_scale,
+                                  int(self.width_virtual // self.scroll_scale),
+                                  int(self.height_virtual // self.scroll_scale),
+                                  xpos, ypos)
+        self.Refresh()
+
+    def zoom_in(self):
+        x = self.scroll_start_us()
+        self.zoom *= 2
+        self.__zoom(x)
+
+    def zoom_out(self):
+        x = self.scroll_start_us()
+        self.zoom /= 2
+        self.__zoom(x)
+
+    def on_key_press(self, event):
+        key = event.GetRawKeyCode()
+        if key == ord("+"):
+            self.zoom_in()
+            return
+        if key == ord("-"):
+            self.zoom_out()
+            return
+
+        key = event.GetKeyCode()
+        (x, y) = self.scroll.GetViewStart()
+        if key == wx.WXK_RIGHT:
+            self.scroll.Scroll(x + 1, y)
+        elif key == wx.WXK_LEFT:
+            self.scroll.Scroll(x - 1, y)
+        elif key == wx.WXK_DOWN:
+            self.scroll.Scroll(x, y + 1)
+        elif key == wx.WXK_UP:
+            self.scroll.Scroll(x, y - 1)
diff --git a/tools/perf/python/sched-migration.py b/tools/perf/python/sched-migration.py
new file mode 100755
index 000000000000..d92c1a80d42f
--- /dev/null
+++ b/tools/perf/python/sched-migration.py
@@ -0,0 +1,496 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Cpu task migration overview toy
+
+Copyright (C) 2010 Frederic Weisbecker <fweisbec@gmail.com>
+Ported to modern directory structure and refactored to use class.
+"""
+from __future__ import annotations
+
+import argparse
+from collections import defaultdict, UserList
+import importlib
+import sys
+from typing import Any
+import perf
+
+
+# Global threads dictionary
+threads = defaultdict(lambda: "unknown")
+threads[0] = "idle"
+
+
+def thread_name(pid: int) -> str:
+    """Return thread name formatted with pid."""
+    return f"{threads[pid]}:{pid}"
+
+
+def task_state(state: int) -> str:
+    """Map task state integer to string."""
+    states = {
+        0: "R",
+        1: "S",
+        2: "D",
+        64: "DEAD"
+    }
+    return states.get(state, "Unknown")
+
+
+class RunqueueEventUnknown:
+    """Unknown runqueue event."""
+    @staticmethod
+    def color():
+        """Return color for event."""
+        return None
+
+    def __repr__(self):
+        return "unknown"
+
+
+class RunqueueEventSleep:
+    """Sleep runqueue event."""
+    @staticmethod
+    def color():
+        """Return color for event."""
+        return 0, 0, 0xff
+
+    def __init__(self, sleeper: int):
+        self.sleeper = sleeper
+
+    def __repr__(self):
+        return f"{thread_name(self.sleeper)} gone to sleep"
+
+
+class RunqueueEventWakeup:
+    """Wakeup runqueue event."""
+    @staticmethod
+    def color():
+        """Return color for event."""
+        return 0xff, 0xff, 0
+
+    def __init__(self, wakee: int):
+        self.wakee = wakee
+
+    def __repr__(self):
+        return f"{thread_name(self.wakee)} woke up"
+
+
+class RunqueueEventFork:
+    """Fork runqueue event."""
+    @staticmethod
+    def color():
+        """Return color for event."""
+        return 0, 0xff, 0
+
+    def __init__(self, child: int):
+        self.child = child
+
+    def __repr__(self):
+        return f"new forked task {thread_name(self.child)}"
+
+
+class RunqueueMigrateIn:
+    """Migrate in runqueue event."""
+    @staticmethod
+    def color():
+        """Return color for event."""
+        return 0, 0xf0, 0xff
+
+    def __init__(self, new: int):
+        self.new = new
+
+    def __repr__(self):
+        return f"task migrated in {thread_name(self.new)}"
+
+
+class RunqueueMigrateOut:
+    """Migrate out runqueue event."""
+    @staticmethod
+    def color():
+        """Return color for event."""
+        return 0xff, 0, 0xff
+
+    def __init__(self, old: int):
+        self.old = old
+
+    def __repr__(self):
+        return f"task migrated out {thread_name(self.old)}"
+
+
+class RunqueueSnapshot:
+    """Snapshot of runqueue state."""
+
+    def __init__(self, tasks=None, event=None):
+        if tasks is None:
+            tasks = (0,)
+        if event is None:
+            event = RunqueueEventUnknown()
+        self.tasks = tuple(tasks)
+        self.event = event
+
+    def sched_switch(self, prev: int, prev_state: int, next_pid: int):
+        """Handle sched switch in snapshot."""
+        if task_state(prev_state) == "R" and next_pid in self.tasks \
+                and prev in self.tasks:
+            return self
+
+        event = (
+            RunqueueEventSleep(prev)
+            if task_state(prev_state) != "R"
+            else RunqueueEventUnknown()
+        )
+
+        next_tasks = list(self.tasks[:])
+        if prev in self.tasks:
+            if task_state(prev_state) != "R":
+                next_tasks.remove(prev)
+        elif task_state(prev_state) == "R":
+            next_tasks.append(prev)
+
+        if next_pid not in next_tasks:
+            next_tasks.append(next_pid)
+
+        return RunqueueSnapshot(next_tasks, event)
+
+    def migrate_out(self, old: int):
+        """Handle task migrate out in snapshot."""
+        if old not in self.tasks:
+            return self
+        next_tasks = [task for task in self.tasks if task != old]
+
+        return RunqueueSnapshot(next_tasks, RunqueueMigrateOut(old))
+
+    def __migrate_in(self, new: int, event):
+        if new in self.tasks:
+            return RunqueueSnapshot(self.tasks, event)
+        next_tasks = self.tasks + tuple([new])
+
+        return RunqueueSnapshot(next_tasks, event)
+
+    def migrate_in(self, new: int):
+        """Handle task migrate in snapshot."""
+        return self.__migrate_in(new, RunqueueMigrateIn(new))
+
+    def wake_up(self, new: int):
+        """Handle task wakeup in snapshot."""
+        return self.__migrate_in(new, RunqueueEventWakeup(new))
+
+    def wake_up_new(self, new: int):
+        """Handle task fork in snapshot."""
+        return self.__migrate_in(new, RunqueueEventFork(new))
+
+    def load(self) -> int:
+        """Provide the number of tasks on the runqueue. Don't count idle"""
+        return len(self.tasks) - 1
+
+    def __repr__(self):
+        return self.tasks.__repr__()
+
+
+class TimeSlice:
+    """Represents a time slice of execution."""
+
+    def __init__(self, start: int, prev):
+        self.start = start
+        self.prev = prev
+        self.end = start
+        # cpus that triggered the event
+        self.event_cpus: list[int] = []
+        if prev is not None:
+            self.total_load = prev.total_load
+            self.rqs = prev.rqs.copy()
+        else:
+            self.rqs = defaultdict(RunqueueSnapshot)
+            self.total_load = 0
+
+    def __update_total_load(self, old_rq: RunqueueSnapshot, new_rq: RunqueueSnapshot):
+        diff = new_rq.load() - old_rq.load()
+        self.total_load += diff
+
+    def sched_switch(self, ts_list, prev: int, prev_state: int, next_pid: int, cpu: int):
+        """Process sched_switch in time slice."""
+        old_rq = self.prev.rqs[cpu]
+        new_rq = old_rq.sched_switch(prev, prev_state, next_pid)
+
+        if old_rq is new_rq:
+            return
+
+        self.rqs[cpu] = new_rq
+        self.__update_total_load(old_rq, new_rq)
+        ts_list.append(self)
+        self.event_cpus = [cpu]
+
+    def migrate(self, ts_list, new: int, old_cpu: int, new_cpu: int):
+        """Process task migration in time slice."""
+        if old_cpu == new_cpu:
+            return
+        old_rq = self.prev.rqs[old_cpu]
+        out_rq = old_rq.migrate_out(new)
+        self.rqs[old_cpu] = out_rq
+        self.__update_total_load(old_rq, out_rq)
+
+        new_rq = self.prev.rqs[new_cpu]
+        in_rq = new_rq.migrate_in(new)
+        self.rqs[new_cpu] = in_rq
+        self.__update_total_load(new_rq, in_rq)
+
+        ts_list.append(self)
+
+        if old_rq is not out_rq:
+            self.event_cpus.append(old_cpu)
+        self.event_cpus.append(new_cpu)
+
+    def wake_up(self, ts_list, pid: int, cpu: int, fork: bool):
+        """Process wakeup in time slice."""
+        old_rq = self.prev.rqs[cpu]
+        if fork:
+            new_rq = old_rq.wake_up_new(pid)
+        else:
+            new_rq = old_rq.wake_up(pid)
+
+        if new_rq is old_rq:
+            return
+        self.rqs[cpu] = new_rq
+        self.__update_total_load(old_rq, new_rq)
+        ts_list.append(self)
+        self.event_cpus = [cpu]
+
+    def next(self, t: int):
+        """Create next time slice."""
+        self.end = t
+        return TimeSlice(t, self)
+
+
+class TimeSliceList(UserList):
+    """List of time slices with search capabilities."""
+
+    def __init__(self, arg=None):
+        super().__init__(arg if arg is not None else [])
+        self.root_win = None
+
+    def get_time_slice(self, ts: int) -> TimeSlice:
+        """Get or create time slice for timestamp."""
+        if len(self.data) == 0:
+            ts_slice = TimeSlice(ts, TimeSlice(-1, None))
+        else:
+            ts_slice = self.data[-1].next(ts)
+        return ts_slice
+
+    def find_time_slice(self, ts: int) -> int:
+        """Binary search for time slice containing timestamp."""
+        if not self.data:
+            return -1
+        start = 0
+        end = len(self.data)
+        found = -1
+        searching = True
+        while searching:
+            if start in (end, end - 1):
+                searching = False
+
+            i = (end + start) // 2
+            if self.data[i].start <= ts <= self.data[i].end:
+                found = i
+                break
+
+            if self.data[i].end < ts:
+                start = i
+            elif self.data[i].start > ts:
+                end = i
+
+        return found
+
+    def set_root_win(self, win):
+        """Set root window for GUI."""
+        self.root_win = win
+
+    def mouse_down(self, cpu: int, t: int):
+        """Handle mouse down event from GUI."""
+        idx = self.find_time_slice(t)
+        if idx == -1:
+            return
+
+        ts = self[idx]
+        rq = ts.rqs[cpu]
+        raw = f"CPU: {cpu}\n"
+        raw += f"Last event : {repr(rq.event)}\n"
+        raw += f"Timestamp : {ts.start // (10 ** 9)}.{ts.start % (10 ** 9) // 1000:06d}\n"
+        raw += f"Duration : {(ts.end - ts.start) // (10 ** 3):6d} us\n"
+        raw += f"Load = {rq.load()}\n"
+        for task in rq.tasks:
+            raw += f"{thread_name(task)} \n"
+
+        if self.root_win:
+            self.root_win.update_summary(raw)
+
+    def update_rectangle_cpu(self, slice_obj: TimeSlice, cpu: int):
+        """Update rectangle for CPU in GUI."""
+        rq = slice_obj.rqs[cpu]
+
+        if slice_obj.total_load != 0:
+            load_rate = rq.load() / float(slice_obj.total_load)
+        else:
+            load_rate = 0
+
+        red_power = int(0xff - (0xff * load_rate))
+        color = (0xff, red_power, red_power)
+
+        top_color = None
+        if cpu in slice_obj.event_cpus:
+            top_color = rq.event.color()
+
+        if self.root_win:
+            self.root_win.paint_rectangle_zone(cpu, color, top_color,
+                                               slice_obj.start, slice_obj.end)
+
+    def fill_zone(self, start: int, end: int):
+        """Fill zone in GUI."""
+        i = self.find_time_slice(start)
+        if i == -1:
+            return
+
+        for idx in range(i, len(self.data)):
+            timeslice = self.data[idx]
+            if timeslice.start > end:
+                return
+
+            for cpu in timeslice.rqs:
+                self.update_rectangle_cpu(timeslice, cpu)
+
+    def interval(self) -> tuple[int, int]:
+        """Return start and end timestamps."""
+        if len(self.data) == 0:
+            return 0, 0
+        return self.data[0].start, self.data[-1].end
+
+    def nr_rectangles(self) -> int:
+        """Return maximum CPU number."""
+        if not self.data:
+            return 0
+        last_ts = self.data[-1]
+        max_cpu = 0
+        for cpu in last_ts.rqs:
+            max_cpu = max(max_cpu, cpu)
+        return max_cpu
+
+
+class SchedMigrationAnalyzer:
+    """Analyzes task migrations and manages time slices."""
+
+    def __init__(self):
+        self.current_tsk = defaultdict(lambda: -1)
+        self.timeslices = TimeSliceList()
+
+    def sched_switch(self, time: int, cpu: int, prev_comm: str, prev_pid: int, prev_state: int,
+                     next_comm: str, next_pid: int):
+        """Handle sched_switch event."""
+        on_cpu_task = self.current_tsk[cpu]
+
+        if on_cpu_task not in (-1, prev_pid):
+            print(f"Sched switch event rejected ts: {time} cpu: {cpu} "
+                  f"prev: {prev_comm}({prev_pid}) next: {next_comm}({next_pid})")
+
+        threads[prev_pid] = prev_comm
+        threads[next_pid] = next_comm
+        self.current_tsk[cpu] = next_pid
+
+        ts = self.timeslices.get_time_slice(time)
+        ts.sched_switch(self.timeslices, prev_pid, prev_state, next_pid, cpu)
+
+    def migrate(self, time: int, pid: int, orig_cpu: int, dest_cpu: int):
+        """Handle sched_migrate_task event."""
+        ts = self.timeslices.get_time_slice(time)
+        ts.migrate(self.timeslices, pid, orig_cpu, dest_cpu)
+
+    def wake_up(self, time: int, pid: int, success: int, target_cpu: int, fork: bool):
+        """Handle wakeup event."""
+        if success == 0:
+            return
+        ts = self.timeslices.get_time_slice(time)
+        ts.wake_up(self.timeslices, pid, target_cpu, fork)
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Collect events and pass to analyzer."""
+        name = str(sample.evsel)
+        if name.startswith("evsel(") and name.endswith(")"):
+            name = name[6:-1]
+        if name.count(":") >= 2:
+            name = ":".join(name.split(":")[:2])
+        time = sample.sample_time
+        cpu = sample.sample_cpu
+        _pid = sample.sample_pid
+        _comm = "Unknown"
+
+        if name.startswith("sched:sched_switch"):
+            prev_comm = getattr(sample, "prev_comm", "Unknown")
+            prev_pid = getattr(sample, "prev_pid", -1)
+            prev_state = getattr(sample, "prev_state", 0)
+            next_comm = getattr(sample, "next_comm", "Unknown")
+            next_pid = getattr(sample, "next_pid", -1)
+            self.sched_switch(time, cpu, prev_comm, prev_pid, prev_state, next_comm, next_pid)
+        elif name.startswith("sched:sched_migrate_task"):
+            task_pid = getattr(sample, "pid", -1)
+            orig_cpu = getattr(sample, "orig_cpu", -1)
+            dest_cpu = getattr(sample, "dest_cpu", -1)
+            self.migrate(time, task_pid, orig_cpu, dest_cpu)
+        elif name.startswith("sched:sched_wakeup_new"):
+            task_pid = getattr(sample, "pid", -1)
+            success = getattr(sample, "success", 1)
+            target_cpu = getattr(sample, "target_cpu", -1)
+            self.wake_up(time, task_pid, success, target_cpu, True)
+        elif name.startswith("sched:sched_wakeup"):
+            task_pid = getattr(sample, "pid", -1)
+            success = getattr(sample, "success", 1)
+            target_cpu = getattr(sample, "target_cpu", -1)
+            self.wake_up(time, task_pid, success, target_cpu, False)
+
+    def run_gui(self):
+        """Start wxPython GUI."""
+        try:
+            wx_mod: Any = importlib.import_module("wx")
+            sched_gui: Any = importlib.import_module("SchedGui")
+        except ImportError:
+            print("wxPython is not available. Cannot start GUI.")
+            return
+        app = wx_mod.App(False)
+        _frame = sched_gui.RootFrame(self.timeslices, "Migration")
+        app.MainLoop()
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser(description="Cpu task migration overview toy")
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    ap.add_argument("-v", "--verbose", action="store_true",
+                    help="Print parsed migration summary")
+    ap.add_argument("--gui", action="store_true", default=True,
+                    help="Start the GUI (default)")
+    ap.add_argument("--no-gui", action="store_true", help="Do not start the GUI")
+    args = ap.parse_args()
+
+    analyzer = SchedMigrationAnalyzer()
+    session = None
+
+    try:
+        try:
+            session = perf.session(perf.data(args.input), sample=analyzer.process_event)
+            try:
+                session.process_events()
+            except KeyboardInterrupt:
+                pass
+        finally:
+            # Release the perf.session reference before launching the long-running
+            # wxPython GUI event loop so the underlying C session and callback
+            # reference cycle are freed immediately.
+            session = None
+        if args.verbose:
+            start_ts, end_ts = analyzer.timeslices.interval()
+            print(f"Timeslices: {len(analyzer.timeslices.data)} "
+                  f"(interval: {start_ts}..{end_ts})")
+        if args.gui and not args.no_gui:
+            analyzer.run_gui()
+    except KeyboardInterrupt:
+        pass
+    except OSError as e:
+        print(f"Error processing events: {e}")
+        sys.exit(1)
diff --git a/tools/perf/tests/shell/test_sched_migration_python.sh b/tools/perf/tests/shell/test_sched_migration_python.sh
new file mode 100755
index 000000000000..f243e86c6700
--- /dev/null
+++ b/tools/perf/tests/shell/test_sched_migration_python.sh
@@ -0,0 +1,72 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# sched-migration python test
+
+set -e
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+if ! "$PYTHON" -c 'import perf' > /dev/null 2>&1; then
+	echo "Skipping test, perf python module not found"
+	exit 2
+fi
+
+script_dir="$(dirname "$0")/../../python"
+script_path="${script_dir}/sched-migration.py"
+
+if ! perf check feature -q libtraceevent > /dev/null 2>&1; then
+	echo "Skipping test, libtraceevent is disabled"
+	exit 2
+fi
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, sched-migration.py not found at $script_path"
+	exit 2
+fi
+
+err=0
+temp_data=""
+temp_out=""
+
+cleanup() {
+	rm -f "${temp_data}" "${temp_out}"
+}
+trap 'cleanup' EXIT TERM INT
+
+temp_data=$(mktemp /tmp/perf.data.XXXXXX)
+temp_out=$(mktemp /tmp/perf.out.XXXXXX)
+
+echo "Testing sched-migration.py..."
+
+# Create a perf.data file. Force dropping a packet if tracepoint is available!
+ev="sched:sched_switch,sched:sched_migrate_task"
+ev="${ev},sched:sched_wakeup_new,sched:sched_wakeup"
+has_sched=1
+if ! perf record -e "$ev" -a -o "${temp_data}" \
+	-- sleep 0.1 >/dev/null 2>&1; then
+	has_sched=0
+	perf record -e cycles -o "${temp_data}" \
+		-- perf test -w noploop >/dev/null 2>&1 || \
+		{ echo "Skipping test, perf record failed"; exit 2; }
+fi
+
+if [ ! -s "${temp_data}" ]; then
+	echo "Skipping test, perf record failed to create data"
+	exit 2
+fi
+
+# Check that the script executes
+if ! "$PYTHON" "$script_path" -v --no-gui -i "${temp_data}" > "${temp_out}"; then
+	echo "sched-migration.py test failed"
+	err=1
+elif [ "$has_sched" -eq 1 ] && ! grep -q "Timeslices:" "${temp_out}"; then
+	echo "sched-migration.py missing Timeslices output"
+	err=1
+else
+	echo "sched-migration test passed."
+fi
+rm -f "${temp_out}"
+
+exit $err
-- 
2.56.0.rc1.310.g51773c2048-goog

