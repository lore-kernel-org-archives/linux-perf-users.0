Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D94213D51B;
	Fri, 16 Aug 2024 23:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723852721; cv=none; b=TZ7Boo3PJ/5bdUZ0BmmFSducqu5i76BOI2ioRCpL7FiO2VQOKsCzCTPGpB01sIqYz+HA6iA8+uSIQ5DEBI4lBZPpUYbfSJYNJ0a42L7S2DOIOb688hh1+mNoL9vFdzEI3A0rmPdYkhFac8aa6gW219TGMf5kZTzshZVA0ejwGWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723852721; c=relaxed/simple;
	bh=RYhj6KtyzS/2o9wQDqksLAzI+C8xH/+NxyFHDCV0/34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K27p0R0TejowSKauZ0IK0xPdO62xfLN8fprbNl0QB+4KNaWnKabM+GjfR+93fStok0F7Isb5c8l3lFGwkxY51PEq2AACbBeZCKSH06o1n1UjHQTOaAnEDpmpeVApByzRm37cKoR8Mm+HPH3IcngDkisPXeRgX7rtuI3NKeKIRjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bt2feJiV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bt2feJiV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A41C4AF09;
	Fri, 16 Aug 2024 23:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723852721;
	bh=RYhj6KtyzS/2o9wQDqksLAzI+C8xH/+NxyFHDCV0/34=;
	h=From:To:Cc:Subject:Date:From;
	b=bt2feJiVZtgtFS/rtTdbr3X8OlCIJJ/P0sn667yK3z2qymhYCOWHuCsCNyF5xIyW8
	 dACCPdfkQqXblq2Ux+jDbGRrUc9Bv7CNShIxCCvy77mrYfITxKJB4PxRcnfvvXFGVL
	 P3PTaySwbzMX0EQHG2iaqDVIOpqJV9AMQwAjaVUFi8i/qYofCxbV0TdTjTy7E39T/3
	 Wchk7TPQ9JV4NFKbNqu0f4oR1U4xsBGGPc+jXsr3WSwblt0tvzZ+zpuMPbG/CaTxvW
	 mG9KcaNB5X3anwinepzTai36ho7gHSvKV3B4021oPDgTEsKGhP916CcHFOx0ofNPPg
	 CUPzscp8OC9ew==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCHSET 0/9] perf annotate-data: Update data-type profiling quality (v1)
Date: Fri, 16 Aug 2024 16:58:30 -0700
Message-ID: <20240816235840.2754937-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I've found a couple of bugs in the DWARF location handling and had
some updates to improve the quality of the type resolution.

The current code only checks the first variable it found in the
closest scope but sometimes it's not good because macro expansions
like container_of (which is used by many list/rb tree manipulation
routines) only gives a very limited information (like void *) with
type cast.  So it needs to lookup other variables in the upper scope.
See the patch 8 for more details.

Also sometimes it can have more information for the parent type if the
pointer is for an embedded type.  For example, a list_head is
typically a part of bigger struct.  Even if it found a variable for
the list_head, it'd be nice if it can tell which list it is.

To compare two type information in general, I've added a heuristic to
take a pointer to a bigger data type.

This is an example data, the portion of unknown type went down a bit
and the atomic_t turned out to be _mapcount in the struct page.

Before:
  #
  # Overhead  Data Type
  # ........  .........
  #
      37.24%  (unknown)
      14.40%  atomic_t 
       8.81%  (stack operation)
       5.54%  struct psi_group_cpu
       3.40%  struct task_struct
       2.99%  struct pcpu_hot
       2.99%  struct cfs_rq
       2.18%  struct audit_krule
       1.93%  struct psi_group
       1.62%  struct sched_entity

After:
  #
  # Overhead  Data Type
  # ........  .........
  #
      36.87%  (unknown)
      14.40%  struct page
       8.81%  (stack operation)
       6.00%  struct psi_group_cpu
       3.40%  struct task_struct
       3.36%  struct cfs_rq
       2.99%  struct pcpu_hot
       2.18%  struct audit_krule
       1.93%  struct psi_group
       1.62%  struct sched_entity

Also updated the debug message and the statistics to help debugging.

The code is available at 'perf/data-profile-update-v1' branch in
git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git


Thanks,
Namhyung


Namhyung Kim (9):
  perf dwarf-aux: Check allowed location expressions when collecting
    variables
  perf annotate-data: Fix off-by-one in location range check
  perf annotate-data: Add enum type_match_result
  perf annotate-data: Add variable_state_str()
  perf annotate-data: Change return type of find_data_type_block()
  perf annotate-data: Add is_pointer_type() helper
  perf annotate-data: Add is_better_type() helper
  perf annotate-data: Check variables in every scope
  perf annotate-data: Update type stat at the end of
    find_data_type_die()

 tools/perf/util/annotate-data.c | 359 ++++++++++++++++++++------------
 tools/perf/util/dwarf-aux.c     |   5 +-
 2 files changed, 230 insertions(+), 134 deletions(-)

-- 
2.46.0.184.g6999bdac58-goog

