Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9CF292916
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Apr 2025 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524717; cv=none; b=tqsLB3sNLDx6j61qvM/KCjYix/VxaemJxbTnKooyNdJ9GfIbXT+JAMvLH5+8CFjJv2NtygUAmf+Tk8RLOrtQj4IP3uo3+0DoBZ7e3ZUWBBRzv0gyTXIC6a32HdkDbiOxDETtR21dwB/GsIO8k/Z7YSXKG3iGiWReAQ9Ccov+Sdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524717; c=relaxed/simple;
	bh=+RY+q+hJwDOImCGmTObp5ZfX3k4NCCjexNpcM/rV9ow=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Qi5qdzDG1OQuhVOpXm4lA8usriuk/ffImNQAHjEP2rzQEhhrY+rKlkKtgcPlhO3lxcT9IAw7Ja9/rKCw23PMsYvBPkCUS75hiPU5Il7pCT3mx1wbmeZqFay4s+eFnQHU3lZMquFBB8hbjcRZU8A+n8iLocx5oT6y9lFY7yO3SCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dgNmfC/G; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dgNmfC/G"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736cd27d51fso1212132b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Apr 2025 12:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745524715; x=1746129515; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q7sNSlEoh3Ww7j5/GpP6XSkW5Nfndqm2bW7+y1NMx1s=;
        b=dgNmfC/GtTwkMj7e3L8uWrDWZm5J4JoTuXCnLy61dDd6fDxFP58OzwD+d7iofs5iWi
         tf4au9kQ5Qnpa0n1PcuBxHL7SFdvjy3UhRpNoxzMbVKjYJgGRvPXfjuGgEyhlXdxJV6U
         ZBm6ZyAePBWx8zrtqOq8poi3Xvh1G07rz7O/MYirj+A3qSy/ealq6fjKUMzMEYbbBXkE
         SNrkRFOPYvHTFar1dXJ0dy1Jcj54hTOCnbE30CcB8EnY4trI6HAtKEGvTnhWLoSkIyUQ
         3rSk8Vuwk0P6EqmMxrTCoN0SErn7mo4dRqh/6eZUSuXWUZEjjR9BbKELmuQfXTMLcR/J
         TvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745524715; x=1746129515;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7sNSlEoh3Ww7j5/GpP6XSkW5Nfndqm2bW7+y1NMx1s=;
        b=oYutsxSUdnR0sfLSfzYkBq2b35cvOEaamXUXhhnqWtcmMqgCgPFF9KUDo271Xg5FKq
         RaCWNd54/TCAl5pnfrCvhvSl8pCRZq103JWHj+q4HJ7tDOe0f1huOHGdgalCXR61GAoA
         8Te5q2qMZZIh2KuotFmhi3ZiGkrewYMWlgtQoRcq76Mihyvi/H2uAjdyEuCyziziXEBf
         BcSnQKWKBdjj4IH+CKydYKDrLnSGl0lxHf+QhzAxG9V5JqyHEBsWE5FP8fYU56cnGM1Z
         Wr2Mj2LttcpWSHRyUbvm9vDvefFxqOFtebQRX4EIImNhkpduT9iSvb28RLZH5yz7dGGb
         Zv+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX86Qdccr6u6KT+8I0LLSpfdayRYX97k4VBAx4OCcZYlUvagckY0aKa50ENhICVG5FrMjzKBIEgZcOhrZwnIf04@vger.kernel.org
X-Gm-Message-State: AOJu0YzPoWoJzN1TMc2d1vck8AK5WG18SQebDMKwSEefl2seHNEOkmYv
	uodY2lnguh6I7SHDqNBkomL98DAvWPnhxxV2nQJr1Vcii8nftykP0z/w5Gi8Z4RnfAm+GfYCJBU
	Vn2WZAg==
X-Google-Smtp-Source: AGHT+IFawFJI77cbJR22Buh8Gc3QU2W5Qpl5CiCQ8mIfHNOGIgryv+Il5hJbbZUqB7zx7RlHuHa2w3a4hR1q
X-Received: from pffk9.prod.google.com ([2002:aa7:88c9:0:b0:732:20df:303c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a86:b0:736:32d2:aa82
 with SMTP id d2e1a72fcca58-73e330c8b69mr1115793b3a.23.1745524715146; Thu, 24
 Apr 2025 12:58:35 -0700 (PDT)
Date: Thu, 24 Apr 2025 12:58:23 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250424195831.1767457-1-irogers@google.com>
Subject: [PATCH v2 0/8] perf: Default use of build IDs and improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, James Clark <james.clark@linaro.org>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Build ID mmap2 events have been available since Linux v5.12 and avoid
certain races. Enable these by default as discussed in:
https://lore.kernel.org/linux-perf-users/CAP-5=fXP7jN_QrGUcd55_QH5J-Y-FCaJ6=NaHVtyx0oyNh8_-Q@mail.gmail.com/

The dso_id is used to indentify a DSO that may change by being
overwritten. The inode generation isn't present in /proc/pid/maps and
so was already only optionally filled in. With build ID mmap events
the other major, minor and inode varialbes aren't filled in. Change
the dso_id implementation to make optional values explicit, rather
than injecting a dso_id we want to improve it during find operations,
add the buildid to the dso_id for sorting and so that matching fails
when build IDs vary between DSOs.

Mark the callchain for buildids and not just the sample IP, fixing
missing DSOs.

Fix sample__for_each_callchain_node to populate the map even when
symbols aren't computed.

Other minor bits of build_id clean up.

v2: Make marking DSOs still the default even with the defaulted build
    ID mmap. The command line option still disables this to avoid
    regressions. Add callchain patches and jitdump fix.

Ian Rogers (8):
  perf callchain: Always populate the addr_location map when adding IP
  perf jitdump: Directly mark the jitdump DSO
  perf build-id: Reduce size of "size" variable
  perf build-id: Truncate to avoid overflowing the build_id data
  perf build-id: Change sprintf functions to snprintf
  perf build-id: Mark DSO in sample callchains
  perf dso: Move build_id to dso_id
  perf record: Make --buildid-mmap the default

 tools/perf/builtin-buildid-cache.c            |  12 +-
 tools/perf/builtin-buildid-list.c             |   6 +-
 tools/perf/builtin-inject.c                   |  32 ++---
 tools/perf/builtin-record.c                   |  33 ++++--
 tools/perf/builtin-report.c                   |  11 +-
 tools/perf/include/perf/perf_dlfilter.h       |   2 +-
 tools/perf/tests/symbols.c                    |   4 +-
 tools/perf/util/build-id.c                    |  57 +++++----
 tools/perf/util/build-id.h                    |   8 +-
 tools/perf/util/disasm.c                      |   2 +-
 tools/perf/util/dso.c                         | 111 ++++++++++--------
 tools/perf/util/dso.h                         |  75 ++++++------
 tools/perf/util/dsos.c                        |  20 ++--
 tools/perf/util/event.c                       |   2 +-
 tools/perf/util/header.c                      |   2 +-
 tools/perf/util/jitdump.c                     |  21 +++-
 tools/perf/util/machine.c                     |  34 +++---
 tools/perf/util/map.c                         |  15 ++-
 tools/perf/util/map.h                         |   5 +-
 tools/perf/util/probe-file.c                  |   4 +-
 .../scripting-engines/trace-event-python.c    |   7 +-
 tools/perf/util/sort.c                        |  27 +++--
 tools/perf/util/symbol.c                      |   2 +-
 tools/perf/util/symbol_conf.h                 |   2 +-
 tools/perf/util/synthetic-events.c            |  42 ++++---
 tools/perf/util/thread.c                      |   8 +-
 tools/perf/util/thread.h                      |   2 +-
 27 files changed, 314 insertions(+), 232 deletions(-)

-- 
2.49.0.850.g28803427d3-goog

