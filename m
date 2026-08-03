Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ADF3AFD19;
	Mon,  3 Aug 2026 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747769; cv=none; b=jb0RtC9G9UR1hXO5EEmSOusyfa0I6f0mGtU+ZGbSXlmAARCci3zNPl/H+6W/r+wkEUo8Ck+3qPiKWjDh1h85BkScL2z8QhrvYK6vnw+QR45A0N0veTDLdi4ydGL8jd6Krh2gwMWz9Q0+UzyOCxUMFuf+NhVm7YkDHiJEsqsNgWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747769; c=relaxed/simple;
	bh=xiGz42PFIL8bCNj5vPqOL4TeTi+5tnz7pkEDDqpFp4s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kXGNf+YzVODFAotAJn6Ves9hhmwBCyKR9+GPR6OIZkxEQgn5LAgjnCaWXRSEN+osVdUAD6FCiuprjEONSPPn3Bh0Z+/fWPpSSHnfvZTeUdPKD0bszF5OBbKC7uV+Or+QrL5qTpEhuHDW2L2rhIP4FKz/tX0RlPFaH1kzjwkZlSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=qXRqHd+i; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="qXRqHd+i"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6735Rrc6027890;
	Mon, 3 Aug 2026 02:02:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=+UUe0PyDK
	6tuicC2KrGKRi9zSihQwNnXSE/D8m2YEXU=; b=qXRqHd+iKHEN8GAIKcn4lsHdv
	zXRU87DZS59mKYW79Ti4id0Pex8lKcQvo9xLQuY5JtjoIIssJRQqeJsUlKHF9HPp
	SRJDuD0E5bnhXVlMsPwuv79sP/eRnlsX43AJsHWeqPSa3Y3Jt8aSrYSlWES5zjzH
	Ll8Yuh7hFmsME8yWsYHt9NzZzwd4tfSgrX62EBDdqENbY0MKiE8tCHY8M721L7qA
	bp3kDrcArwnU49hqvhoktw9zGBz++nE7ZlBTVTZ7bxYmeNcJ0WgVsCxEkOB2wpm/
	RFSd6HWXK2Vy3EmjpwjzcK8Yj+Hbg3XMoDgzMxPnZBwDfa1w24uw06vPKu2bw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4fsc9q8mdx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 03 Aug 2026 02:02:08 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.45; Mon, 3 Aug
 2026 09:02:07 +0000
From: Amir Ayupov <aaupov@fb.com>
To: <linux-perf-users@vger.kernel.org>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        James Clark <james.clark@linaro.org>, Leo Yan
	<leo.yan@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim
	<namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>
CC: <linux-doc@vger.kernel.org>, Mike Leach <mike.leach@arm.com>,
        Jonathan
 Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Swapnil
 Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH 0/9] perf cs-etm: Add branch history to existing samples
Date: Mon, 3 Aug 2026 02:01:53 -0700
Message-ID: <20260803090202.2324641-1-aaupov@fb.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=DtpmPm/+ c=1 sm=1 tr=0 ts=6a705910 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=855S8uPTkML1Oy45N9_h:22 a=axNnc2LJDcEVcFH0QQkA:9
X-Proofpoint-GUID: yDUsO4gfDXBGr2c08-1MdmnfzIQYnF4O
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA4MCBTYWx0ZWRfX22+EUbsmVN9b
 5tTSfYz1BUtkaSwARUFU32/C9VNbI7+S2hsphm1elzMv2gjtlhhHibb3XSgW1lR4CA7h6Q7TQQK
 W2GQG7QBzQSYk+/t6YM1XN6RztE6pL0=
X-Proofpoint-ORIG-GUID: yDUsO4gfDXBGr2c08-1MdmnfzIQYnF4O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA4MCBTYWx0ZWRfX4kYTgkUiP3L1
 ZoPehi/7Qpu8bediNfHWCyeBX+jyEWuhyEf3VHKJybPS1Prej8Y5HEoaI5Fhrdty6/58DnuFLX1
 KE8QbtrlCu06T5TGiOOV1DxAVz8zIDoZesHsCkZKf4TbK0bvhZiTO8ps6+Fzg88SH7cC36x66re
 n/HO2ukcxYAsZxXRbK4iWYpMkd2y3H/Whk8Mk9j4etxdKjxwiNcF/mPu3fX8Rxj8aQY1C8rFDfo
 5iJVtZU+tUd83ViMcGiQl+bEFv/iVKm5XCJUpJ/XTf6KICqBKy6/9t5QwTYofVWls+naAPvu2HS
 PCPqsgxaBRaSgaJSE2p8UWMg6G8ZSmcauN6yNKxJoh+Qa+YMwMFRSQGamygOsRyKQyjrJoKanJq
 JyMM9UPqhkSqOjim3reRXllT1+pGh8XowHs7UezhNniwtbnqJqFymqgw1XvIAcVpB91Dz+zE44s
 w1FNY4IUu/KcKNZaQbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01

This series implements --itrace=L for Arm CoreSight ETM: decoded branch
history is attached to the PMU samples already present in the recording,
rather than to synthesised instruction samples.

The motivating use case is context-sensitive PGO, which wants a callchain
and a branch stack describing the same point in time. Recording a cycles
event with call-graph=fp and aux-action=pause supplies the callchain, and
the ETM trace leading up to that sample supplies the branch stack, without
having to trace a long-running process continuously.

Intel PT has had this since commit f0a0251cee80 ("perf intel-pt: Add
support for synthesizing branch stacks for regular events"), so this
deliberately follows intel-pt: the same --itrace=L option and the same
thread_stack__br_sample_late() call.

Patches 1 to 4 are independent fixes and infrastructure the feature needs:

  1  makes an inconsistent HEADER_GROUP_DESC non-fatal. AUX recordings
     using aux-action pause/resume produce a group descriptor the strict
     reader rejects, which makes an otherwise readable perf.data
     unreadable, so without this the recipe in patch 9 cannot be decoded
     at all. Useful on its own.
  2  reports hw_idx as -1 rather than 0 in reconstructed branch stacks,
     since they have no hardware index.
  3  bounds a wrapped memcpy in thread_stack__br_sample(). Latent today,
     reachable once a caller keeps a ring larger than the requested output
     depth.
  4  adds a dlfilter that drops samples with an empty branch stack.

Patch 5 is a no-functional-change refactor splitting
cs_etm__process_timestamped_queues() into its three parts. Heap seeding
moves to cs_etm__update_queues(), gated on queues.new_data and mirroring
intel_pt_update_queues(); the end-of-session flush moves to
cs_etm__flush_timestamped_queues(); and the decode loop is left on its own
so patch 6 can drive it once per sample. Neither seeding nor flushing can
be repeated, which is why they have to come out first. The moved code is
unchanged, so both loops appear as context in the diff.

Patch 6 is the feature and patch 7 adds a shell test.

Patch 8 is where review attention is most useful. --itrace=L attaches
whatever the thread stack holds when a sample is processed. With a duty
cycled trace most samples fire while the trace is off; they have nothing
newly decoded, but the thread stack still holds the previous window, so
they were being given branches that ran an arbitrary amount of time
earlier. On a 12 s capture with pause period 100003 and resume period
8350251, of 335291 samples that received branch history only 3371 were
backed by trace decoded for that sample.

A trace window belongs to exactly one sample, and with AUX pause and
resume the sample is what stops the trace, so the pairing is one to one by
construction. Patch 8 therefore takes the branch history when attaching it
instead of copying it, and a later sample with nothing newly decoded finds
an empty branch stack, which the dlfilter removes.
thread_stack__br_sample() is unchanged, so lowercase --itrace=l keeps the
overlapping branch stacks it produces today.

Patch 9 documents the workflow.

Because the sample is what stops the trace, the history attached to it
lines up well with the callchain: on a brstack capture the leaf of the
callchain matched the function containing the newest branch stack entry's
target for 93.5% of attached samples. The residual comes from the decode
loop stopping on interpolated timestamps, so a few branches that ran just
after the sample can still be included. Trimming those with the sample ip
raises it to 96.8%, but that matters far more for free-running ETM
strobing than for pause and resume, so I have left it out of this series
and will send it separately.

Patch 8 could be squashed into patch 6, since patch 6 on its own produces
mostly stale history. I kept them apart so the decode mechanism and the
attachment policy can be reviewed separately, but I am happy to fold them.

Testing
-------

Built with:

  make -C tools/perf NO_LIBELF=1 NO_LIBTRACEEVENT=1 CORESIGHT=1

Every patch builds individually. checkpatch reports only "does MAINTAINERS
need updating?" for the two new files and "quoted string split across
lines" for the dlfilter description string, which matches how
dlfilter-show-cycles.c already writes it.

Tested on Arm Neoverse V2 with CoreSight ETM:

  - perf test "CoreSight branch history on existing samples": Ok, 3 for 3
  - captures from 5 MiB to 2.5 GiB decoded with --itrace=L64, no decode
    errors
  - the other CoreSight tests are unchanged by this series; four of them
    fail identically at the base commit on this machine

Amir Ayupov (9):
  perf header: Tolerate inconsistent HEADER_GROUP_DESC
  perf thread-stack: Report branch stack hw_idx as not available
  perf thread-stack: Bound wrapped branch stack copy
  perf dlfilter: Add non-empty branch stack filter
  perf cs-etm: Split up cs_etm__process_timestamped_queues()
  perf cs-etm: Add branch history to existing samples
  perf test cs-etm: Test branch history on existing samples
  perf cs-etm: Consume branch history when attaching it to a sample
  Documentation: coresight: Document context-sensitive PGO workflow

 .../trace/coresight/coresight-perf.rst        |  62 +++++
 tools/perf/Makefile.perf                      |   1 +
 .../dlfilters/dlfilter-nonempty-brstack.c     |  26 ++
 .../tests/shell/coresight/add_last_branch.sh  | 175 +++++++++++++
 tools/perf/util/cs-etm.c                      | 242 ++++++++++++++++--
 tools/perf/util/header.c                      |  42 ++-
 tools/perf/util/thread-stack.c                |  21 +-
 tools/perf/util/thread-stack.h                |   1 +
 8 files changed, 544 insertions(+), 26 deletions(-)
 create mode 100644 tools/perf/dlfilters/dlfilter-nonempty-brstack.c
 create mode 100755 tools/perf/tests/shell/coresight/add_last_branch.sh


base-commit: da85966dfd23a3b03e00ee3bce6ad301f0a2b229
-- 
2.52.0

