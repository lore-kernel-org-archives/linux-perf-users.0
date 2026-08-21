Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCAD337BAB
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 05:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787288552; cv=none; b=pHs2uHlwSQCVtBUHCIo7qHOBIHPMQFKhfI0QR4e20MFbhXJjcoeNKOexj7PYjtdncSUUcRB82csinYGEQKhd23sGDHM2CbaIZkecNOBOxO3KYhNYLdwu8HSby4bFjH7ZkSJwi+Ai66FOAxf/RA5uZeOay5NcPH/6W9HQtWf/X6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787288552; c=relaxed/simple;
	bh=hEUzDFLxpFzoS2ZgCC3toI+S3yIMas9EPrNtbAPyapU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iKNavxxK/fU7hCNh8oKwcEzy8JlCqKSScr8q1lJ36TOAGKQ5KdLTfCkdL19gQ4O1PODZcqlH2Xqa6uEF2yX0foUYzVtYUpLyFcbRNcYQW5aWjTPnaBrxl2U9xMs5QN6mL2GD8OkcXrR/o2ulyPZP8pJ/OHXQKaEussEd5YaaWr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=OZLAZTQJ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="OZLAZTQJ"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c08df8513so3479371cf.3
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 22:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1787288549; x=1787893349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F1M/+Grf+rkfSTbenrOF9B1LHPq+jzZ2PC91gwKO1G4=;
        b=OZLAZTQJJrG396Wh2ODPLKgUekwsVEDP3fVb1Z+3mfva+gdXrvAEyOMFGAzx8TCRQN
         7DKFIxje+zyoSu940CEAqFqnOBe6IIHRou0rTB2XMi1a+6xd6sp1MxnitjZQf66swlOF
         wb0+7qLz5ZK84W16L+4Zhrve5d6L7Rx2UYSLirFz3jPjo+nT5y5w6sn+2DKX2elhQtKO
         pcwpl2pzSlj22uHu6ii8Vbo7SkdvAAL5zi5Ff4tQ9nno5Sshm6aEo9ETs446pFcYr3IQ
         R7okZmKGm/b99Ofo20ESpzmSxz/rUrvP1UPhACFOW7t6UUAKSPkpEP2hjp41HMj3SUeF
         9bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787288549; x=1787893349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F1M/+Grf+rkfSTbenrOF9B1LHPq+jzZ2PC91gwKO1G4=;
        b=Bu79RAocRWXWtlaKUAX3YhSwqd+ZdoyRct2ml6a1UpKpCjocsDDeLlA3/TJjflYE6C
         tKZHO7SAnHZcj7C36BuEHLv6wm8a7W4BRhwWGzYneIFrqz0bFoa0zEIuPdSIpfW4OxVY
         Dha20I9eJJ16+6kYq3Es3wKbxnYvEjoheoTxY1Ns54mGjUX5NnYWIi7Ik+geMSDpq+pB
         EGqhgoIzd+7F+rAgJix9NzDRhPggp90nQBRxeddvP9WXWEkr86svzJjk1UqirefOhpV1
         0IlQWmrJDJUpninEmKL6Szx7CNqh6RgGqVA7v4EryHOEpglkf85W1Rob/4BCQRYbiqbr
         Z8CQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp1sc6oQfPS34hzILrwCVl2SrxvUGbXe2K8aBuMPto6nLWpa/KWLy6WrSoHtFY8ePJb7FbXCOeSNPuGa2Du3pAL@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn78n8iSKMTYWhdwSq4S5OHyTRTGT57QKZwAyjxWTUn/C+gGYj
	6koq/4X+t60eeBKzRQvzqja6NL96aHNLw0onKw5ecS1oTkO3dwiPcnc3KuA8VCtKGA==
X-Gm-Gg: AR+sD10DvjQrsPZFRpxolJZePHcNUeGxDgjeJsAqIzBAY8ARq7mwqMamgQqSZbaoTNc
	TFohK+UfcM0G3UwOLCnNKTJwrYWwqIKAxl5RW0EiKMRNsaf2vjheWerh/5PTozjwUH0aR8d2nao
	U1yysMbYVieX5eyvCOR5M4Xyv9M4iyjTJb5/mRKAx6fQGlsZrpQcaeF9m5+b3vhcgQtZ+AvJYKs
	P9GaHa7MHmd6zIM9qOpQoxftx1mNA7v3vEMY9xYaVduBi+tkWng+gbRofIF6m1BLcRFh9Gn8DDL
	TsG6nvtytI2j0lG/68tiQy7ksj+8F7RZnn+9qSuKf79lkc5gIAYjJHjJeTbTwXMxdI3h4B1s8b8
	o9qWjUMo/e+w18hBUgTtFyCk/acXMIgdGYaOwjs5D1ISHvq6gbOYk/mtGIidG/3AjCjspPbMduZ
	P+8c3ktMxVsdL4O+ws+yyt0a5vzjWNePoL+p/RJAj/pLUCvUvD26QpA9Zmh7d8KK/ETcrO4NXnu
	o4Mp3729G+TE/mgDaGU
X-Received: by 2002:a05:622a:4c0a:b0:52d:f4fb:8baa with SMTP id d75a77b69052e-52df5a57d2amr32611581cf.35.1787288549038;
        Thu, 20 Aug 2026 22:02:29 -0700 (PDT)
Received: from home.localdomain ([136.61.118.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5eec1e7fsm54368116d6.12.2026.08.20.22.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 22:02:28 -0700 (PDT)
From: Yanbo Zhao <yzhao62@ncsu.edu>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Zecheng Li <zli94@ncsu.edu>,
	Xu Liu <xliuprof@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yanbo Zhao <yzhao62@ncsu.edu>
Subject: [PATCH 0/3] perf annotate: Data type profiling support for C++ classes and virtual calls
Date: Fri, 21 Aug 2026 01:02:04 -0400
Message-Id: <20260821050207.4517-1-yzhao62@ncsu.edu>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Data type profiling currently only understands C struct/union types.
For C++ workloads, member accesses on classes cannot be resolved, and
virtual function calls (indirect calls through the vtable) break the
instruction type tracking entirely: the call target is unknown, so the
return type is lost and register states get invalidated.

This series extends data type profiling to C++:

Patch 1 introduces die_is_compound_type() covering
DW_TAG_structure_type, DW_TAG_union_type and DW_TAG_class_type, and
converts all existing open-coded struct/union checks in dwarf-aux.c
and annotate-data.c to use it.  It also accepts DW_TAG_inheritance in
the member lookup callbacks so offset-based lookup descends into base
class subobjects.

Patch 2 adds the C++-specific DWARF helpers: CU language detection,
base class and vtable index inspection, virtual function lookup by
vtable index (recursing into base classes), and vtable pointer
(_vptr) member identification.  Fallback definitions are provided for
DW_AT_vtable_elem_index and DW_LANG_C_plus_plus_17/20 so the code
builds against older elfutils.

Patch 3 wires it up in the disassembler and the x86 instruction
tracking: a load of a '_vptr' member marks the destination register
as TSR_KIND_VTABLE_PTR, and an indirect call through such a register
is resolved statically via the vtable index, recovering the return
type and updating the receiver ('this' pointer) register to the class
type.  The receiver register number comes from the new
type_state::arg0_reg field initialized per arch like ret_reg.
Caller-saved register invalidation is moved after the target operands
are read so the state needed for resolution is not lost.

Only the primary vtable is handled for now; multiple inheritance is
left as a TODO.  Updating the receiver register for any method call
that passes a 'this' pointer (not only resolved virtual calls) needs
a callee DIE lookup by linkage name and is planned as a follow-up on
top of this series.

Verified on an x86-64 C++ workload with virtual calls in a hot loop
(built with -O2 -g): the vptr loads are tracked, the indirect calls
are resolved, and 'perf report -s type,typeoff' attributes the
samples to 'struct Base +0 (_vptr.Base)'.  Also passed 'perf test'
annotate basic tests and checkpatch on all three patches.

Yanbo Zhao (3):
  perf dwarf-aux: Add die_is_compound_type() to handle C++ class types
  perf dwarf-aux: Add C++ class, inheritance and vtable helpers
  perf disasm & annotate x86: Track C++ vptr and resolve virtual
    function calls

 tools/perf/util/annotate-arch/annotate-x86.c | 103 +++++++--
 tools/perf/util/annotate-data.c              |  36 ++--
 tools/perf/util/annotate-data.h              |   3 +
 tools/perf/util/annotate.c                   |   4 +
 tools/perf/util/disasm.c                     |   1 +
 tools/perf/util/dwarf-aux.c                  | 209 ++++++++++++++++++-
 tools/perf/util/dwarf-aux.h                  |  27 +++
 7 files changed, 342 insertions(+), 41 deletions(-)

-- 
2.25.1

