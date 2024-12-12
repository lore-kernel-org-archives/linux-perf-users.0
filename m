Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AEB1D0E20;
	Thu, 12 Dec 2024 23:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046044; cv=none; b=OvshWdXqysw4SizV7ieT1aauFMyKvhwcAgKvElO6l88+Lt1xcb8uHiK4yYS2bdOOO0BtUAuRaYoPbb2kjaM8V5NeQQiRASWT7s95CMCU63p9GXkOdD53ToBiS4XYxi9Wej5NLNHeqTjw5muUK1V0AL8M6nTm9edWWDvb3f/FtxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046044; c=relaxed/simple;
	bh=8LdzRiSDPtaXhwRnNzwZFPm4gm09hBYEAH8DFxrDflg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FpcjrJA+IO4N7ULWX7TtuIvcJciBHqfgY3FFonDmSfPFmgyiwmeZWJIkVDijp3R/h264qEtThphUhyk+Qj+xmyRF3iPmVeyoUzporLA+fgnowSo0Qghei2Enr9ttr/Bf4Uv5R8m4/YmDTbKidP42deIaYVvBc+VEVWmvrLnIvcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+DSLd3I; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+DSLd3I"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-725ee6f56b4so1027471b3a.3;
        Thu, 12 Dec 2024 15:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734046042; x=1734650842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IgGg259kjlTWiahamCtKKddQo9B/Gf9055puQFIr9qc=;
        b=V+DSLd3IkO0CQx+F99nsP0IDiQje9RjciNzhZ7qLlcVyUB9KyZbBG1OBUYo+tVuM6/
         bTOoaZhFku4Z/HhOaimybRI2mJnNaxqvbvoRk8ycJE09CnQyIJEU9XKLln2Vpog+eElO
         CzAlNEVUkfOGF+afPo5EDqSBBeYSkr9UmutNUPAkjn2BOXy1qtpr2S9sS3QalLEOEnzw
         t1Ra5mO1bB40a6DPBZfqSOyL0RtH6CQ3WLilhrwCdeQYj+GnistCVBvIEcJUvFQFWV/z
         78K0Xq+iQ+jadCQOEV79981De6rqwSePC+l+Ub0858VXuXmQ1HT63ysXdApR6Hqb3HvC
         7yUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046042; x=1734650842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IgGg259kjlTWiahamCtKKddQo9B/Gf9055puQFIr9qc=;
        b=TgMwqNrIeli+DmpcZuefG02RghoQiArrUEEkaMqC30IFCm/dmuzRbZb2N/fAnNq216
         LLfPOJqb3LtWhPIb1WZry5Jo+QZqzPvoovCkZ7k0Zb2qpWZ5fiozTRKQpqJTU3oDvJV6
         dWTbZ65OrDQgmNrFhUAcoCXq2mSKzElDnlg0GjEBeu6M8iP0AT9y56md/LvkpEIfi2gl
         05q0L7ivreEWPffmlbIIyWTR6Ygt0h9aVsQ4Wk7cKFlcViusawiq5b1xfAnGyz1trGwR
         Nk/e3SvK7z3Y0eTYxq60sxE3zKLoKGenKZyxnLOGNQmsNBT/Ll5fgI/bJSDU3KLVVNPS
         EIEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu5389hU5ypH6w2WxKsp3lKt1jJ3FC0NLjeAADqOSFKXtCqkhIZpChcbF7+vrcSkNl+yXZCdpKs7Nw5LE=@vger.kernel.org, AJvYcCXmUJU2fOjHpwSmJxfffkkeC0EltVTzDR4gKok8boIG+feo4zROhEW76mXNEwv8r2o+rnimUik3fn+GaZ0JqMGlLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAXBAARhu3nP8OTW7EPZL74ARz/YHzPnE7Sx9PeWZG0FOkin8K
	6sPwxrECISyjOL9lkCiEO+2NkAqcNxVTz2ILPrPRgBCgNCvmQ6tO
X-Gm-Gg: ASbGncuwjnhbLKWD2xciBDELUsEEQynlBlpLP+hJUkGO47upabATW+L+Fh3cqWqwSC6
	Rys+7bve9IsHw+FbjgsEiipT0Jng/GEe3f+TEvIBGBxbkQvjbUXKOtkUTeY1dPdx2hu3o/2eBgH
	c6upeOAqKJQKGroeTIkPvjvJU7YEMsdSDHO5DY7Y/HAfKh/Crq2deSx7+eWvQ3y1iRXWfEIWMwY
	cagezeJYHomR8T3VcQ8koZmDz5mjvqz+OdkJZKoAPQYiV5vZ2pSKKQKuA6l7+DMHp1wwXn5X7xW
	fjFZN+pj0Clm
X-Google-Smtp-Source: AGHT+IFHyQE/vp+sQeZXIjR2ao7GgUF5ZYknWugjO8dydPeMvmOB36MVadLdwG5XDhFkk8oGCp0Y5A==
X-Received: by 2002:a05:6a00:301a:b0:725:e015:9082 with SMTP id d2e1a72fcca58-7290c0e17dcmr681894b3a.5.1734046041593;
        Thu, 12 Dec 2024 15:27:21 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4e202e9asm7324674a12.72.2024.12.12.15.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 15:27:21 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v13 00/10] perf record --off-cpu: Dump off-cpu samples directly
Date: Thu, 12 Dec 2024 15:27:07 -0800
Message-ID: <20241212232717.232507-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v13:
 - Move the definition of 'off_cpu_thresh_ns' to the same commit as
   dumping off-cpu samples in BPF, and give off_cpu_thresh_ns a default
   value before the --off-cpu-thresh option is parsed.

Changes in v12:
 - Restore patches' bisectability, because the ordering of patches has
   changed.
 - Change 'us = ms * 1000' to 'us = ms * USEC_PER_MSEC'

Changes in v11:
 - Modify the options used in the off-cpu tests, as I changed the unit
   of the off-cpu threshold to milliseconds.

Changes in v10:
 - Move the commit "perf record --off-cpu: Add --off-cpu-thresh option"
   to where the direct sample feature is completed.
 - Make --off-cpu-thresh use milliseconds as the unit.

Changes in v9:
 - Add documentation for the new option '--off-cpu-thresh', and include
   an example of its usage in the commit message
 - Set inherit in evsel__config() to prevent future modifications
 - Support off-cpu sample data collected by perf before this patch series

Changes in v8:
 - Make this series bisectable
 - Rename off_cpu_thresh to off_cpu_thresh_us and offcpu_thresh (in BPF)
   to offcpu_thresh_ns for clarity
 - Add commit messages to 'perf evsel: Expose evsel__is_offcpu_event()
   for future use' commit
 - Correct spelling mistakes in the commit message (s/is should be/should be/)
 - Add kernel-doc comments to off_cpu_dump(), and comments to the empty
   if block
 - Add some comments to off-cpu test
 - Delete an unused variable 'timestamp' in off_cpu_dump()

Changes in v7:
 - Make off-cpu event system-wide
 - Use strtoull instead of strtoul
 - Delete unused variable such as sample_id, and sample_type
 - Use i as index to update BPF perf_event map
 - MAX_OFFCPU_LEN 128 is too big, make it smaller.
 - Delete some bound check as it's always guaranteed
 - Do not set ip_pos in BPF
 - Add a new field for storing stack traces in the tstamp map
 - Dump the off-cpu sample directly or save it in the off_cpu map, not both
 - Delete the sample_type_off_cpu check
 - Use __set_off_cpu_sample() to parse samples instead of a two-pass parsing

Changes in v6:
 - Make patches bisectable

Changes in v5:
 - Delete unnecessary copy in BPF program
 - Remove sample_embed from perf header, hard code off-cpu stuff instead
 - Move evsel__is_offcpu_event() to evsel.h
 - Minor changes to the test
 - Edit some comments

Changes in v4:
 - Minimize the size of data output by perf_event_output()
 - Keep only one off-cpu event
 - Change off-cpu threshold's unit to microseconds
 - Set a default off-cpu threshold
 - Print the correct error message for the field 'embed' in perf data header

Changes in v3:
 - Add off-cpu-thresh argument
 - Process direct off-cpu samples in post

Changes in v2:
 - Remove unnecessary comments.
 - Rename function off_cpu_change_type to off_cpu_prepare_parse

v1:

As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=207323

Currently, off-cpu samples are dumped when perf record is exiting. This
results in off-cpu samples being after the regular samples. This patch
series makes possible dumping off-cpu samples on-the-fly, directly into
perf ring buffer. And it dispatches those samples to the correct format
for perf.data consumers.

Before:
```
     migration/0      21 [000] 27981.041319: 2944637851    cycles:P:  ffffffff90d2e8aa record_times+0xa ([kernel.kallsyms])
            perf  770116 [001] 27981.041375:          1    cycles:P:  ffffffff90ee4960 event_function+0xf0 ([kernel.kallsyms])
            perf  770116 [001] 27981.041377:          1    cycles:P:  ffffffff90c184b1 intel_bts_enable_local+0x31 ([kernel.kallsyms])
            perf  770116 [001] 27981.041379:      51611    cycles:P:  ffffffff91a160b0 native_sched_clock+0x30 ([kernel.kallsyms])
     migration/1      26 [001] 27981.041400: 4227682775    cycles:P:  ffffffff90d06a74 wakeup_preempt+0x44 ([kernel.kallsyms])
     migration/2      32 [002] 27981.041477: 4159401534    cycles:P:  ffffffff90d11993 update_load_avg+0x63 ([kernel.kallsyms])

sshd  708098 [000] 18446744069.414584:     286392 offcpu-time: 
	    79a864f1c8bb ppoll+0x4b (/usr/lib/libc.so.6)
	    585690935cca [unknown] (/usr/bin/sshd)
```

After:
```
            perf  774767 [003] 28178.033444:        497           cycles:P:  ffffffff91a160c3 native_sched_clock+0x43 ([kernel.kallsyms])
            perf  774767 [003] 28178.033445:     399440           cycles:P:  ffffffff91c01f8d nmi_restore+0x25 ([kernel.kallsyms])
         swapper       0 [001] 28178.036639:  376650973           cycles:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
         swapper       0 [003] 28178.182921:  348779378           cycles:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
    blueman-tray    1355 [000] 28178.627906:  100184571 offcpu-time: 
	    7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
	    7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
	    7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-2.0.so.0.8000.2)
	    7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.0.8000.2)
	    7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
	    7fff24e862d8 [unknown] ([unknown])


    blueman-tray    1355 [000] 28178.728137:  100187539 offcpu-time: 
	    7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
	    7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
	    7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-2.0.so.0.8000.2)
	    7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.0.8000.2)
	    7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
	    7fff24e862d8 [unknown] ([unknown])


         swapper       0 [000] 28178.463253:  195945410           cycles:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
     dbus-broker     412 [002] 28178.464855:  376737008           cycles:P:  ffffffff91c000a0 entry_SYSCALL_64+0x20 ([kernel.kallsyms])
```

Howard Chu (10):
  perf evsel: Expose evsel__is_offcpu_event() for future use
  perf record --off-cpu: Parse off-cpu event
  perf record --off-cpu: Preparation of off-cpu BPF program
  perf record --off-cpu: Dump off-cpu samples in BPF
  perf evsel: Assemble offcpu samples
  perf record --off-cpu: Disable perf_event's callchain collection
  perf script: Display off-cpu samples correctly
  perf record --off-cpu: Dump the remaining samples in BPF's stack trace
    map
  perf record --off-cpu: Add --off-cpu-thresh option
  perf test: Add direct off-cpu test

 tools/perf/Documentation/perf-record.txt |   9 ++
 tools/perf/builtin-record.c              |  26 +++++
 tools/perf/builtin-script.c              |   4 +-
 tools/perf/tests/builtin-test.c          |   1 +
 tools/perf/tests/shell/record_offcpu.sh  |  35 ++++++-
 tools/perf/tests/tests.h                 |   1 +
 tools/perf/tests/workloads/Build         |   1 +
 tools/perf/tests/workloads/offcpu.c      |  16 +++
 tools/perf/util/bpf_off_cpu.c            | 118 ++++++++++++++---------
 tools/perf/util/bpf_skel/off_cpu.bpf.c   |  97 ++++++++++++++++++-
 tools/perf/util/evsel.c                  |  41 +++++++-
 tools/perf/util/evsel.h                  |   2 +
 tools/perf/util/off_cpu.h                |   3 +-
 tools/perf/util/record.h                 |   1 +
 14 files changed, 297 insertions(+), 58 deletions(-)
 create mode 100644 tools/perf/tests/workloads/offcpu.c

-- 
2.43.0

