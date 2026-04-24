Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40C03DBD4F
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049359; cv=none; b=h3yWchsXZrHsqqKl2LK8JAVArZ3wlbMI+hHaNSRuPzdaTKCcCyaIetC8q2HYVY8jjzczCgSiWckjrHGChk4f33j1SXurQtvjzkJrm+VjPK5/d/KRbiHzfqrR5W74OTDSfmaGKw5FSQID+2wEt3yvyx9CItiIij+Dk4RWm5WMdo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049359; c=relaxed/simple;
	bh=wxQ7XBXwKkGoKBfzJmTM6BFvGs1xO0kKj7O3T2ZqZ4Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dyPgmQH95OUjX1W28Jjke3qa8RBeZFn7z3WQXBg1GUb5qiIPbm+elySAXFOxlxicUypqy48JkmI7BAwtJfXK0Li//9GaVTFA3bIn07pOl+WX1QqQN0u8uqcEnObfs2IOvgMNFtmLvcpKr0dqoPnFNFVfgGmSMQJk35paA2+F9VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nfWexL5i; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nfWexL5i"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c8d7d4a79so6121016c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049356; x=1777654156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SC9Z8TYU3FIlegbJKB+Rnykve8tItTwLd+p+lGKeOhc=;
        b=nfWexL5iA2jMdZ5x68O0+79qgObKDlmuKGcffiulHWr6hAuccBvQ0G3c3QIwM8oQCK
         3U9SHGPaQReqPMKOZLjguEKwTlbvx0v0Q4uHbhQLSMYQKvYVC51r/+vfNpVpjzmVd+yv
         gj2B7ssclFe0TWRChY9fewsrKanDRrt+1BDdWKPaOnhGBOSNMLcBntbgN2Lc62RK62ew
         B4Nn2RJmDOpW1D10vl89y8rV2x6j46/fx3/Wmqmsfizp/QyClZMLJGKbWrSObpCho2cN
         ICM7DoVwRX+uIgL1D0VNlD5EV8vCyddUuEo/35xKWLJU3ApS21TWiF42UKwNLY0nGkya
         bqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049356; x=1777654156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SC9Z8TYU3FIlegbJKB+Rnykve8tItTwLd+p+lGKeOhc=;
        b=innvVJiSHCSJQuHWzymHq6dnGnF9UyEm0enDjZ/jb9Zl/UFXymonLVJ3n/6S7iX8E6
         +zoB2ACLsSii8+WZo5n/Rgpfn3XZJHuohL2Axt1IYejJPkPOnwgj9wWc/kUYMBVA9Jl6
         0y/hmQ4bn2YCcaMkuU4ZB+ekOZcreOR0aMvErPI3sUndaDSm7odSmqpOj+4L6xgb/PuN
         LAhiQeAS0TUMcKSAReBWtfYeTf7GrHgSE46qnLfOxt76+CmDIM+10t33hy4HDiBVj+n0
         K9Odc3hIyhgwtC3pSTQRaNnDxM4pgvTMO9XQnx4zmMzFirhUCRl0LdHTVDfRHR/np4GR
         TLvw==
X-Forwarded-Encrypted: i=1; AFNElJ9BSKK2MmxIdCB2Xwb6vXH6vgTeiFMq6KrV6j/npSuPEzgInhp5yK0vymDEyroA1kxrT4KVQeiWnXnHWCa1wkUn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw94vUltzhKOCI5Z3MCMXArlvVAIBwc55gpkcLYqvviY03i+ixN
	3GQQbwt1PPX75MOz6irQ9b4+Eum1lDFBtWzJV0mz/7QgAKpnbcgz3RqHaft0nyI+//OWS9A6zER
	kP57dYjyQvQ==
X-Received: from dlbpu1.prod.google.com ([2002:a05:7022:e881:b0:12c:4955:b382])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6098:b0:12c:2ed4:62fa
 with SMTP id a92af1059eb24-12c73fca846mr19084001c88.32.1777049355508; Fri, 24
 Apr 2026 09:49:15 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:47:05 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-44-irogers@google.com>
Subject: [PATCH v5 43/58] perf sched-migration: Port sched-migration/SchedGui
 to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Ported from tools/perf/scripts/python/ and its Util lib.
- Refactored sched-migration.py to use a class structure
  (SchedMigrationAnalyzer) to encapsulate state.
- Used perf.session for event processing.
- Ported SchedGui.py to the same directory to keep it as a local
  dependency.
- Made wxPython dependency optional in sched-migration.py, printing a
  message if it's missing instead of failing with ImportError.
- Cleaned up Python 2 compatibility artifacts.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

tools/perf/python/SchedGui.py:
 - Python 3 Compatibility: Fixed TypeError issues caused by float
   division in Python 3 when wxPython expected integers. Used integer
   division ( // ) and explicit int() casts for scrollbar and size
   calculations.
 - wxPython Phoenix API Updates:
   - Replaced deprecated  SetDimensions()  with  SetSize() .
   - Replaced removed GetPositionTuple() with GetPosition() in
     on_mouse_down.
 - Fixed wx.PaintDC creation in on_paint to use
   event.GetEventObject() to ensure valid DC creation regardless of
   which window triggered the event.
 - Layout and Rendering Fixes:
   - Replaced static layout with a wx.SplitterWindow to physically
     separate the drawing area from the text area, preventing them
     from overlapping and restoring scrollbar functionality.
   - Adjusted the initial sash position to give 3/4 of the height to
     the drawing area.
   - Replaced wx.StaticText with a multiline wx.TextCtrl for the
     summary area to allow text selection and simpler value updates.
   - Added CPU labels ("CPU ") drawn at the left edge of the visible
     area in on_paint .
   - Added background clearing ( dc.Clear() ) in on_paint to avoid
     "ghosting" of old text and rectangles when scrolling.

tools/perf/python/sched-migration.py:
 - Fixed a bug where sharing a snapshot in find_time_slice caused data
   mutation across calls.
 - Added safety checks to handle empty data cases (e.g., when
   intervals have no events).
 - Fixed fallbacks in fill_zone when search conditions fail to find a
   matching time slice.
---
 tools/perf/python/SchedGui.py        | 219 +++++++++++++
 tools/perf/python/sched-migration.py | 469 +++++++++++++++++++++++++++
 2 files changed, 688 insertions(+)
 create mode 100755 tools/perf/python/SchedGui.py
 create mode 100755 tools/perf/python/sched-migration.py

diff --git a/tools/perf/python/SchedGui.py b/tools/perf/python/SchedGui.py
new file mode 100755
index 000000000000..6111f3e5f552
--- /dev/null
+++ b/tools/perf/python/SchedGui.py
@@ -0,0 +1,219 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# SchedGui.py - Python extension for perf script, basic GUI code for
+#		traces drawing and overview.
+#
+# Copyright (C) 2010 by Frederic Weisbecker <fweisbec@gmail.com>
+#
+# Ported to modern directory structure.
+
+try:
+    import wx  # type: ignore
+except ImportError:
+    raise ImportError("You need to install the wxpython lib for this script")
+
+
+class RootFrame(wx.Frame):
+    Y_OFFSET = 100
+    RECT_HEIGHT = 100
+    RECT_SPACE = 50
+    EVENT_MARKING_WIDTH = 5
+
+    def __init__(self, sched_tracer, title, parent=None, id=-1):
+        wx.Frame.__init__(self, parent, id, title)
+
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
+        return val / (10 ** 3) * self.zoom
+
+    def px_to_us(self, val):
+        return (val / self.zoom) * (10 ** 3)
+
+    def scroll_start(self):
+        (x, y) = self.scroll.GetViewStart()
+        return (x * self.scroll_scale, y * self.scroll_scale)
+
+    def scroll_start_us(self):
+        (x, y) = self.scroll_start()
+        return self.px_to_us(x)
+
+    def paint_rectangle_zone(self, nr, color, top_color, start, end):
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
+    def update_rectangles(self, dc, start, end):
+        start += self.ts_start
+        end += self.ts_start
+        self.sched_tracer.fill_zone(start, end)
+
+    def on_paint(self, event):
+        window = event.GetEventObject()
+        dc = wx.PaintDC(window)
+
+        # Clear background to avoid ghosting
+        dc.SetBackground(wx.Brush(window.GetBackgroundColour()))
+        dc.Clear()
+
+        self.dc = dc
+
+        width = min(self.width_virtual, self.screen_width)
+        (x, y) = self.scroll_start()
+        start = self.px_to_us(x)
+        end = self.px_to_us(x + width)
+        self.update_rectangles(dc, start, end)
+
+        # Draw CPU labels at the left edge of the visible area
+        (x_scroll, _) = self.scroll_start()
+        for nr in range(self.nr_rects):
+            offset_py = RootFrame.Y_OFFSET + (nr * (RootFrame.RECT_HEIGHT + RootFrame.RECT_SPACE))
+            dc.DrawText(f"CPU {nr}", x_scroll + 10, offset_py + 10)
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
index 000000000000..331278958763
--- /dev/null
+++ b/tools/perf/python/sched-migration.py
@@ -0,0 +1,469 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Cpu task migration overview toy
+
+Copyright (C) 2010 Frederic Weisbecker <fweisbec@gmail.com>
+Ported to modern directory structure and refactored to use class.
+"""
+
+import argparse
+from collections import defaultdict, UserList
+import perf
+
+# SchedGui might not be available if wxPython is missing
+try:
+    from SchedGui import RootFrame
+    import wx  # type: ignore
+    WX_AVAILABLE = True
+except ImportError:
+    WX_AVAILABLE = False
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
+        event = RunqueueEventUnknown()
+        if task_state(prev_state) != "R":
+            event = RunqueueEventSleep(prev)  # type: ignore
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
+        """Handle task migrate in in snapshot."""
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
+        raw += f"Duration : {(ts.end - ts.start) // (10 ** 6):6d} us\n"
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
+            i = 0
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
+        time = sample.sample_time
+        cpu = sample.sample_cpu
+        _pid = sample.sample_pid
+        _comm = "Unknown"
+
+        if name == "evsel(sched:sched_switch)":
+            prev_comm = getattr(sample, "prev_comm", "Unknown")
+            prev_pid = getattr(sample, "prev_pid", -1)
+            prev_state = getattr(sample, "prev_state", 0)
+            next_comm = getattr(sample, "next_comm", "Unknown")
+            next_pid = getattr(sample, "next_pid", -1)
+            self.sched_switch(time, cpu, prev_comm, prev_pid, prev_state, next_comm, next_pid)
+        elif name == "evsel(sched:sched_migrate_task)":
+            task_pid = getattr(sample, "pid", -1)
+            orig_cpu = getattr(sample, "orig_cpu", -1)
+            dest_cpu = getattr(sample, "dest_cpu", -1)
+            self.migrate(time, task_pid, orig_cpu, dest_cpu)
+        elif name == "evsel(sched:sched_wakeup)":
+            task_pid = getattr(sample, "pid", -1)
+            success = getattr(sample, "success", 1)
+            target_cpu = getattr(sample, "target_cpu", -1)
+            self.wake_up(time, task_pid, success, target_cpu, False)
+        elif name == "evsel(sched:sched_wakeup_new)":
+            task_pid = getattr(sample, "pid", -1)
+            success = getattr(sample, "success", 1)
+            target_cpu = getattr(sample, "target_cpu", -1)
+            self.wake_up(time, task_pid, success, target_cpu, True)
+
+    def run_gui(self):
+        """Start wxPython GUI."""
+        if not WX_AVAILABLE:
+            print("wxPython is not available. Cannot start GUI.")
+            return
+        app = wx.App(False)
+        _frame = RootFrame(self.timeslices, "Migration")
+        app.MainLoop()
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser(description="Cpu task migration overview toy")
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    args = ap.parse_args()
+
+    analyzer = SchedMigrationAnalyzer()
+
+    try:
+        session = perf.session(perf.data(args.input), sample=analyzer.process_event)
+        session.process_events()
+        analyzer.run_gui()
+    except KeyboardInterrupt:
+        pass
+    except Exception as e:
+        print(f"Error processing events: {e}")
-- 
2.54.0.545.g6539524ca2-goog

