Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AC24AF678;
	Thu,  3 Sep 2026 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441788; cv=none; b=rV4ObvRRXVAduvFpfiJoW5WQ83auPA2PoxDkx1pziqV7aRIkS0J+fSd3DgM2fd1atAK1+aRRwjUtqWGLBG6GfkVvUAFCJ27Vg/YjLRpiuoXkVS8GFeofqTAlK058DaR6pPMYhLoCvn15pnjdPc/sivCahZNlV+7SKdZ3CLoW858=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441788; c=relaxed/simple;
	bh=gIJtLhlgJM7KBSOKEfCfZkj2XHSVffgyEIAQwx1e0rM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ym7qLo7PhETmkuvgGsQBTc7PvEl113wASFkbFcfLc9UEK/H88FpuFzc9kFl4I5u2KaRrB8QrGGXc9mNm442WcFxux3mFXhGs3jPg8Y0gZPwKoca95g+Qi9azC6eu3JfaXL2iXOksp1iv8Xjeoso5r2sMxZKw5yaxqsjHCwR0pZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHh+JE8k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHh+JE8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB141F00A3D;
	Thu,  3 Sep 2026 13:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788441777;
	bh=Gsirv0Gl4YJr+LZNCGgx5Qz5H3FpTfl1/W3QJqauukE=;
	h=From:To:Cc:Subject:Date;
	b=fHh+JE8kQ+E0HI3NuD2I7DVPybjxCcZKUUUV4lkJ8zT8pzcY059Jk2+LMo/90z1MS
	 5AQEWMbI/R2yp6IUJarAEvH4lGD7delJ4kHK73MPp+OVRBkdwheuV1Uz4i0l6BT1AK
	 awx9ncXnuZoPqsY79hlOLqqhcPl6haHjWeCLkaEehrGgxoFIOvf2akp/otmL1yzrm7
	 7FF+F/xfyUFa/OUgQQUgygovwy7KLmjuFaOoC8NLBQoUvGuXYhl0RdqtPkNHxBHQaP
	 iZ+JT8EnKN//SZEWU4W0SN37OT0WrctpF+L0D+3cuKJOV1r2h/gYnyKws5UEBFC3Jc
	 lKqX2m6Ah2Lfg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v1 0/5] perf tools: Fix jitdump and dso handling
Date: Thu,  3 Sep 2026 10:22:46 -0300
Message-ID: <20260903132251.237029-1-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series addresses five small fixes in the perf jitdump and dso
code that were found by sashiko-bot during automated review.

Patches 1 and 2 - unaligned-safe debug entries:

  - 1/5 perf jitdump: Byte-swap debug entries via unaligned-safe accessors
    The byte-swap loop in jit_get_next_entry() did 64-bit loads/stores
    through struct member access.  This seems to be UB when entries are
    unaligned after the first variable-length name[].  Use
    get_unaligned()/put_unaligned() for each field, as was done in the
    earlier bounds-check hardening.

  - 2/5 perf genelf: Use unaligned-safe accessors for debug entries
    The same packing issue on the native path.  As far as I can tell,
    jit_process_debug_info(), get_special_opcode() and
    emit_lineno_info() all read u64 addr and int lineno through struct
    access.  Convert them to unaligned-safe accessors, matching the
    layout the jitdump writers (LLVM, JVM agents) emit.

Patch 3 - stale unwinding state:

  - 3/5 perf jitdump: Free unwinding data even when eh_frame_hdr_size is zero
    jit_repipe_code_load() only cleared jd->unwinding_data when both
    unwinding_data and eh_frame_hdr_size were set.  If a record carries
    unwinding_data with eh_frame_hdr_size==0, so the answer would be that
    the check fails and the state is applied to all subsequent records.
    The record is validated upstream so eh_frame_hdr_size <= unwinding_size
    always holds.  Free based on the data pointer alone.

Patch 4 - event sizing:

  - 4/5 perf jitdump: Size code_move event allocation with idr_size
    jit_repipe_code_move() allocated event as sizeof(*event)+16 but
    computed header.size with +idr_size.  When idr_size>16, I believe
    header.size exceeds the allocation and perf_data__write() reads past
    the heap, leaking adjacent heap into perf.data.  Size with idr_size
    like jit_repipe_code_load() does.

Patch 5 - open list deadlock/race:

  - 5/5 perf dso: Defer dropping the open list reference until after the lock
    The reference taken by dso__list_add() cannot be dropped while
    holding dso__data_open_lock: dso__put() may call dso__data_close()
    which takes the same lock, deadlocking.  This seems to be the cause
    of the inconsistent list/counter state under REFCNT_CHECKING.  Fix by
    transferring the reference to a deferred node drained by
    dso__put_deferred() after every unlock.  Since the counter is now
    decremented under the lock, do_open()'s close_first_dso() no longer
    races with a stale count.

Regards,

- Arnaldo

Arnaldo Carvalho de Melo (5):
  perf jitdump: Byte-swap debug entries via unaligned-safe accessors
  perf genelf: Use unaligned-safe accessors for debug entries
  perf jitdump: Free unwinding data even when eh_frame_hdr_size is zero
  perf jitdump: Size code_move event allocation with idr_size
  perf dso: Defer dropping the open list reference until after the lock

 tools/perf/util/dso.c          | 75 ++++++++++++++++++++++++++++++++--
 tools/perf/util/genelf_debug.c | 30 ++++++++------
 tools/perf/util/jitdump.c      | 20 ++++++---
 3 files changed, 103 insertions(+), 22 deletions(-)

-- 
2.55.0
