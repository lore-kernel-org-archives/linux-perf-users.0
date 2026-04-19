Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E45733F8A8
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643265; cv=none; b=k96lyWOiIA0Z+C2j0+uhAlWKYdOWoYcqBeJ0PZ+XHIRBk0srD8YOX9EQDKBSjy6XSeqe6Vl/sXEJ7Sqw/AuIZMB/fQQa1ulu/IkS8sJgBBKRdFI8PVtmvoF2QS7i8Vr19SHyXtqmoWXc8jv8M78rmB2hgOBK96XcAadkCpXnqJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643265; c=relaxed/simple;
	bh=U5SsJhtRg55HY9C39AHmLouHEkWPTsMy7Hh/f3p52/A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hT/i/acWmIGPPFzpImXtUU3ukXMejEzredcgfcKki75jhJay44H6NnHyeEm6QdHTz/8XYtNIUx7U3M8/CzhP8h33WNRN+SohDd+jP772eJxyFqpSL86fu/4xNwO+hSG6xLTVW2gojn1rOtYuoOO5MY0Ar5HbEEelVt7LS8LydPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bYvJdfQW; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYvJdfQW"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bce224720d8so1195476a12.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643261; x=1777248061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1F+J8ZAOIrThpD/EVQpEC70A8P+kc04fQwNlUmvFsG4=;
        b=bYvJdfQWpelgPxJ2pthmO3vjzCv9NBQw5JNYTEv3HYY1uFjVJYvqiHw2eDuDq1Zr5G
         KGz3E99HpsWlihe4ijNrQZUhpZee4K6Frirv5Cz65eY1BDPqCAwjbf+uClxaTPFGQGlv
         FUy/fC8hsB2lRsmLzdtaHizhIvBrL4jFGg/z2QsrMejyE+xo4dG8kD2+R4EtPNXZSNS0
         FU3Lj5yQ+wYvCpNug39bwGtNQI2wrnoqtmarAnGdE8CHZVGoUxOLIU0+0mqjtb9FEgCy
         EJ5Yu+TaX9ZUC7mHSCHp9vLMFKxVjD/08hHRdKnoFopN+K+LRHM3Maw4dHSfNzx8CVsy
         JqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643261; x=1777248061;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1F+J8ZAOIrThpD/EVQpEC70A8P+kc04fQwNlUmvFsG4=;
        b=h16cFjJHGiCdS66km+1L03gV0W9h3e85s+Z3dHn2Qy+C/bqCHGAkd5bD0tPoj8p0jh
         Z0CBDvZ1Irm0vwSPuakusDrj6FIyHcRSnZ62YjUSFSLmrIR+IqZwN2E16S/3gjxmomxk
         2B2Sd7ATBrUJP3FY3vVmvtqJs41yLB00opgKtueVljwz6oMCEyAtDMJXX0u7n6r+yVPU
         yZcBDTZVFT/wp7Hi3cSuW6TcyJfNgDxhz+olCdScGBs/MM7oRwyeoiq9HajenaizjZyV
         WDSkInQXUdnG8MBXEmSjZUjT0jEwdbdDGe4g7i+1ivXiScjkVysbSJAEg/xWZxO+7Uvr
         u9eA==
X-Forwarded-Encrypted: i=1; AFNElJ8jbKzh3u+I2mdRNZXTPGpRR83SHgehSnJdU8k0uUr/VElJBVeUSOLUeK8QmkhCywh/pHPmNDTVBWVJm5jGDFRI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3L7CrNbHjJDbOHITls8aNmbvMFHB+aiPtM2Tg41vg+/0T///C
	sZyPeSrKdMzYZiaWqQsDZCQUo4I1ebwzLG+2VwgtIma5+K4ijem0buXsumlNUEJoOl1GFzCrJGB
	QaWtdbZ4xHA==
X-Received: from pfbil7.prod.google.com ([2002:a05:6a00:8d47:b0:82f:9e73:207b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b4f:b0:82a:780f:a187
 with SMTP id d2e1a72fcca58-82f8c94425bmr11081018b3a.36.1776643260915; Sun, 19
 Apr 2026 17:01:00 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:55 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-44-irogers@google.com>
Subject: [PATCH v1 43/58] perf sched-migration: Port sched-migration/SchedGui
 to use python module
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Pan Deng <pan.deng@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Zecheng Li <zli94@ncsu.edu>, tanze <tanze@kylinos.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"Tycho Andersen (AMD)" <tycho@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Aditya Bodkhe <adityab1@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
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
 tools/perf/python/SchedGui.py        | 180 +++++++++++
 tools/perf/python/sched-migration.py | 466 +++++++++++++++++++++++++++
 2 files changed, 646 insertions(+)
 create mode 100755 tools/perf/python/SchedGui.py
 create mode 100755 tools/perf/python/sched-migration.py

diff --git a/tools/perf/python/SchedGui.py b/tools/perf/python/SchedGui.py
new file mode 100755
index 000000000000..321b25854883
--- /dev/null
+++ b/tools/perf/python/SchedGui.py
@@ -0,0 +1,180 @@
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
+    import wx
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
+        self.height_virtual = RootFrame.Y_OFFSET + (self.nr_rects * (RootFrame.RECT_HEIGHT + RootFrame.RECT_SPACE))
+
+        # whole window panel
+        self.panel = wx.Panel(self, size=(self.screen_width, self.screen_height))
+
+        # scrollable container
+        self.scroll = wx.ScrolledWindow(self.panel)
+        self.scroll.SetScrollbars(self.scroll_scale, self.scroll_scale, self.width_virtual / self.scroll_scale, self.height_virtual / self.scroll_scale)
+        self.scroll.EnableScrolling(True, True)
+        self.scroll.SetFocus()
+
+        # scrollable drawing area
+        self.scroll_panel = wx.Panel(self.scroll, size=(self.screen_width - 15, self.screen_height / 2))
+        self.scroll_panel.Bind(wx.EVT_PAINT, self.on_paint)
+        self.scroll_panel.Bind(wx.EVT_KEY_DOWN, self.on_key_press)
+        self.scroll_panel.Bind(wx.EVT_LEFT_DOWN, self.on_mouse_down)
+        self.scroll.Bind(wx.EVT_PAINT, self.on_paint)
+        self.scroll.Bind(wx.EVT_KEY_DOWN, self.on_key_press)
+        self.scroll.Bind(wx.EVT_LEFT_DOWN, self.on_mouse_down)
+
+        self.scroll.Fit()
+        self.Fit()
+
+        self.scroll_panel.SetDimensions(-1, -1, self.width_virtual, self.height_virtual, wx.SIZE_USE_EXISTING)
+
+        self.txt = None
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
+        width_px = self.us_to_px(end - self.ts_start)
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
+            dc.DrawRectangle(offset_px, offset_py, width_px, RootFrame.EVENT_MARKING_WIDTH)
+            width_py -= RootFrame.EVENT_MARKING_WIDTH
+            offset_py += RootFrame.EVENT_MARKING_WIDTH
+
+        (r, g, b) = color
+        color = wx.Colour(r, g, b)
+        brush = wx.Brush(color, wx.SOLID)
+        dc.SetBrush(brush)
+        dc.DrawRectangle(offset_px, offset_py, width_px, width_py)
+
+    def update_rectangles(self, dc, start, end):
+        start += self.ts_start
+        end += self.ts_start
+        self.sched_tracer.fill_zone(start, end)
+
+    def on_paint(self, event):
+        dc = wx.PaintDC(self.scroll_panel)
+        self.dc = dc
+
+        width = min(self.width_virtual, self.screen_width)
+        (x, y) = self.scroll_start()
+        start = self.px_to_us(x)
+        end = self.px_to_us(x + width)
+        self.update_rectangles(dc, start, end)
+
+    def rect_from_ypixel(self, y):
+        y -= RootFrame.Y_OFFSET
+        rect = y / (RootFrame.RECT_HEIGHT + RootFrame.RECT_SPACE)
+        height = y % (RootFrame.RECT_HEIGHT + RootFrame.RECT_SPACE)
+
+        if rect < 0 or rect > self.nr_rects - 1 or height > RootFrame.RECT_HEIGHT:
+            return -1
+
+        return rect
+
+    def update_summary(self, txt):
+        if self.txt:
+            self.txt.Destroy()
+        self.txt = wx.StaticText(self.panel, -1, txt, (0, (self.screen_height / 2) + 50))
+
+    def on_mouse_down(self, event):
+        (x, y) = event.GetPositionTuple()
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
+        xpos = self.us_to_px(x) / self.scroll_scale
+        self.scroll.SetScrollbars(self.scroll_scale, self.scroll_scale, self.width_virtual / self.scroll_scale, self.height_virtual / self.scroll_scale, xpos, ypos)
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
index 000000000000..299c8b44064b
--- /dev/null
+++ b/tools/perf/python/sched-migration.py
@@ -0,0 +1,466 @@
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
+            self.event = event
+            return self
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
+        _comm = getattr(sample, "comm", "Unknown")
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
2.54.0.rc1.513.gad8abe7a5a-goog

