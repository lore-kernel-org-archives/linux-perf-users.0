Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18AA37C916
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438389; cv=none; b=M22BVsdsH00/cHqjabTibxaFyV/woelkYDqxR1NacoF3Q6dMtIu/xubaMLbd7n1+5e6/LjXxRoXRD/liOtr2Rzlj3IMRK7wJmzJiMa6YjpQD00IRo2xnImjh8n1Z3Rz90veHj8+Riekqso+elJfC5T8N3aXYASTa6CTRMAcsuqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438389; c=relaxed/simple;
	bh=xZGmwKY+DHs4nfJyYJLfriOXR01UwEjxfi2hVJQIC1o=;
	h=Content-Type:Date:Message-Id:Subject:References:From:Cc:
	 Mime-Version:In-Reply-To:To; b=rffpgHeSgjr/lBNjTTPCDSUZr2dfWtPTKjeh7rk4+h1dViOTSxWlIXdR+5Y5wJhjc8l33jC+bgqf8QBCAXXHEWvlXFXaJfEv5Gzu1XwSyuLL6xwWwurRVJ0rxAZNTSBnIP5ReA8UnxhrBHN5URHi47qTf3HRe0oVYZgVlhqAPNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cSAzcx/U; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cSAzcx/U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779438381; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=3MJU/Kq0Y82slIKcHQIjfR1fVotTqC/55pra9suCazg=;
 b=cSAzcx/U9SIstnRBFk9ynwM0a+n8T3ghTQGe/SszOrry/MjHyC9mzsIbqApKmWDwwtTv56
 3XLfYFO66lCEmcD/CcufzWo1Uf4SKB5Q/Xo6BvT/SMplmtrUPeiFH7rUWhCVd/FpFxbO5n
 YKvS/bHuj15cM59EzdQx5MV5IA9XHDc5BPbmVBRWRlblr9knha2/U1CjZIkqn6fndF1Hke
 lv1079pSmWSIHV/D9wXBXD/WMogL0xp9+B6GrVbntygpqPKy31/YXjB4dQxIRRH8BMJ7X/
 IPQyho8x5LV6qxJQNBq5sehkR3yg6YhoMLED6bIzK6zapJDxtLUIDmcT4qEmOQ==
X-Original-From: Rui Qi <qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 May 2026 16:26:02 +0800
Message-Id: <20260522082604.89447-1-qirui.001@bytedance.com>
X-Lms-Return-Path: <lba+26a10132b+693339+vger.kernel.org+qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit
Subject: [PATCH v4 0/2] perf: Add is_ignored_kernel_symbol() for kernel symbol filtering
References: <20260507071103.2772577-1-qirui.001@bytedance.com>
From: "Rui Qi" <qirui.001@bytedance.com>
Cc: "Mark Rutland" <mark.rutland@arm.com>, 
	"Alexander Shishkin" <alexander.shishkin@linux.intel.com>, 
	"Jiri Olsa" <jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>, 
	"Adrian Hunter" <adrian.hunter@intel.com>, 
	"James Clark" <james.clark@linaro.org>, 
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Rui Qi" <qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260507071103.2772577-1-qirui.001@bytedance.com>
To: "Peter Zijlstra" <peterz@infradead.org>, 
	"Ingo Molnar" <mingo@redhat.com>, 
	"Arnaldo Carvalho de Melo" <acme@kernel.org>, 
	"Namhyung Kim" <namhyung@kernel.org>

The perf tool currently has ad-hoc logic to filter out ELF mapping
symbols scattered across multiple files. ARM, AArch64 and RISC-V each
have their own inline checks in dso__load_sym_internal(), and kallsym
processing has yet another check for ARM module symbols.

This patch series introduces a single is_ignored_kernel_symbol() inline
helper in symbol.h and converts the kernel symbol handling paths to use it.
The helper covers the existing "$" prefix used by ARM, AArch64 and RISC-V,
and also adds the x86 local symbol prefixes so that perf stays consistent
with the kernel's own is_mapping_symbol() logic.

Changes in v4:
  - Rename the helper from is_mapping_symbol() to is_ignored_kernel_symbol()
    to make its purpose clearer.
  - Split the single patch into two logical patches:
    - Patch 1 introduces the helper and applies it to kallsyms and ksymbol events.
    - Patch 2 applies the helper to the ELF loading path for kernel DSOs.

Link (v3): https://lore.kernel.org/all/20260507071103.2772577-1-qirui.001@bytedance.com/

Changes in v3:
  - Add is_mapping_symbol() check for kernel modules in dso__load_sym_internal()
  - Add is_mapping_symbol() check in machine__process_ksymbol_unregister()

Link (v2): https://lore.kernel.org/all/20260506073820.2419087-1-qirui.001@bytedance.com/

Changes in v2:
  - Only apply is_mapping_symbol() filtering to kernel symbols (kallsyms
    and ksymbol events), not to user-space symbols from ELF files,
    BFD libraries, or perf map files.  This avoids incorrectly
    discarding valid user-space function names that start with '$',
    which is a legal character in identifiers for many languages
    (e.g., Java, Scala) and compilers (GCC).
  - Move the mapping symbol check in machine__process_ksymbol_register()
    to the beginning of the function, before any map/dso allocation
    or insertion, to avoid leaving empty maps in the kernel map tree.

Link (v1): https://lore.kernel.org/all/20260504090609.1801880-1-qirui.001@bytedance.com/

Rui Qi (2):
  perf: Extract is_ignored_kernel_symbol() for kernel mapping symbol
    filtering
  perf: Apply is_ignored_kernel_symbol() filter in ELF loading path for
    kernel DSOs

 tools/perf/util/machine.c    | 18 +++++++++++++++++-
 tools/perf/util/symbol-elf.c | 10 ++++++++--
 tools/perf/util/symbol.c     |  4 ++--
 tools/perf/util/symbol.h     | 15 +++++++++++++++
 4 files changed, 42 insertions(+), 5 deletions(-)

-- 
2.20.1
