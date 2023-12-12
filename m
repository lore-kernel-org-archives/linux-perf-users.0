Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxFcJjjY"
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4C5D0;
	Mon, 11 Dec 2023 23:05:50 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cda22140f2so4626996b3a.1;
        Mon, 11 Dec 2023 23:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702364750; x=1702969550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cSrzQ4FDDeqPwfBNWP1LcLTFq/yFZjcBCmoTNQG3Jbc=;
        b=QxFcJjjYIDnXD8IUvnNAiAfryIkdOrPDGo0qH2/XA9/Fnk9ktbHEQ+njmVDnumjcab
         TtKaubL530F80z7dq8mYxVe6lfP6I+OZmZvtfjNstC7WjYxYdoDQxR/rTV5zJokyxTUe
         e6P2zoKRTNkzvu33ppDiLZd/+dur8eUzzMuZBcsVGoQ0ZN3o1wjYabqDqi1G98BtwhW5
         idKXyHgw/4GdNuGwQxUssfLHlWMvHu7Vd96VehhjoCD8gs5EibeEURkl/SXzTMfFS7Ds
         2oqBeZLiXP76zUYNdpvIRTYYUW+s/DUE+q7wExubnxOS2hFFe01VWhtFkQ/bZHs6Lv/q
         VZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702364750; x=1702969550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSrzQ4FDDeqPwfBNWP1LcLTFq/yFZjcBCmoTNQG3Jbc=;
        b=xSrCCpDKykl9PoyjOhkhWVC2McA7MZu7ofRpwdKegZIvll1ih1IaPAFccFINVT0ill
         w0l0DGwOah/gDAS3Y5DyDMlw1XCPgAptwnTslOTjHKhpx8q9zYuIP63jYdb08fgnkH6A
         L73uCMfiBbz384PhNuCmWXqsIfKmAziErzezO/06//6zYj9WxavHcg3b4zmMWv6pSt7c
         wyeSmWi4IlWSuI8mUX1OozZfx4zhkTvZZ/eSYW6C52Lhq14uWABRflfxfFYmDNlPwCRs
         FzYDTcm19tWUIg9IiH51yULWalxaj0Goh7xJmueomtFwa4jkxngqozcBEyYuIwbdNTTX
         iYTA==
X-Gm-Message-State: AOJu0YySjKOYrVxZMQrGXxL+PVIBOxy/cUoWqMOAndUVWJ0gokwOBiVL
	cccBhYZNdWDnS5lUga9I4wkbDYpO+KmO6w==
X-Google-Smtp-Source: AGHT+IECAOXD/0B+W79A1JJLZZXjjM6ziU0kkw9o9WVVRBBXjx1IEv5o3dwdJSk4XvSkOKpIiVt8zg==
X-Received: by 2002:a05:6a20:7d86:b0:18f:f86f:bcdb with SMTP id v6-20020a056a207d8600b0018ff86fbcdbmr6978625pzj.93.1702364749630;
        Mon, 11 Dec 2023 23:05:49 -0800 (PST)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:7da0:5ec4:de63:3cf4])
        by smtp.gmail.com with ESMTPSA id g17-20020a056a0023d100b006cb6e83bf7fsm7397491pfc.192.2023.12.11.23.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 23:05:49 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Milian Wolff <milian.wolff@kdab.com>,
	Pablo Galindo <pablogsal@gmail.com>,
	Fangrui Song <maskray@google.com>
Subject: [PATCH 0/3] perf tools: Random fixes for DWARF unwind
Date: Mon, 11 Dec 2023 23:05:43 -0800
Message-ID: <20231212070547.612536-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I've found a couple of issues on the unwind code while I'm playing with
the JIT-dump code for the CPython.  The code assumes normal DSOs mapped
from the beginning of the file and aligned to the page size.  But it's
not true for the JIT-dumped DSOs which are generated for each function.

Depending on the JIT implementation, the code address and accompanied
ELF info (like ELF file headers and unwind info) can be overlapped to
adjacent (JIT-dumped) DSOs.  So it should take more care when it
calculates the mapping address for the DSO.

It seems these changes need to go to the stable trees but they are
changed a lot since then so I'm not sure.

Thanks,
Namhyung


Namhyung Kim (3):
  perf genelf: Set ELF program header addresses properly
  perf unwind-libdw: Handle JIT-generated DSOs properly
  perf unwind-libunwind: Fix base address for .eh_frame

 tools/perf/util/genelf.c                 |  6 +++---
 tools/perf/util/unwind-libdw.c           | 21 +++++++++++++++++----
 tools/perf/util/unwind-libunwind-local.c |  2 +-
 3 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog

