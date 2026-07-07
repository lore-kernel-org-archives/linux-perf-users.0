Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61F63F1ACF
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jul 2026 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434279; cv=none; b=cTlXc3d6Py4oF8M9XBIloczK+8Vt4fUN46ZQsMFh9UZKDMbcUqSUo7t/6MUredSFcbEWGOEw1iJ0gN58yaZOltvMzmW94VdgnrON7mf09Q9LXs4UegJj9yKhX/sruZ/HqHloMWTSRjuhUTN6MqfbMghQkJNgnvCr4oSWHwQB3iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434279; c=relaxed/simple;
	bh=N9iAT2nJOVW7IcRQdfg39n3FdybruoF+l/MZSwlYXbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8W1fXNXOPYQylws6fpKlLNwqSVsIoYA6FIbUB/OpnQdnPSl8c7Zim2UANk4KxvmeVKI1hnYzMW/4CgXqSQ5k5ShYDIE0aHwFpyO6PZg25SZ9PN+sfFwQtbJyYNbTpowR/32JjhENTRm1oXgWOWjDjSEU2Mm2gTJm9/8dWq8RR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DfqxHamD; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DfqxHamD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783434272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+T/Jggvqz6cZ+zi/SQhTFIKS0RfRSrRiwzkzIBLZwg=;
	b=DfqxHamDlz5qcPAWYuuHVuYkYYUJwZ96BSHL0ZJrhPEGwqr6ZvD6DuUNw8//aiTXYUKYbz
	pXgnmUU6kS8cFmiu4vA/Z+2KN//6fnfdJH89gNnoiR4XFd72NE2dyRouZUlX3Id9Pi50JK
	g0iQ4ZR4nlKToLXxtJXAO4ePYkZWsWY=
From: Usama Arif <usama.arif@linux.dev>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	bpf@vger.kernel.org,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Leo Yan <leo.yan@arm.com>,
	Rob Herring <robh@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Stephane Eranian <eranian@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v5 2/4] perf/core: Clear the whole branch entry in perf_clear_branch_entry()
Date: Tue,  7 Jul 2026 07:24:22 -0700
Message-ID: <20260707142424.1687033-1-usama.arif@linux.dev>
In-Reply-To: <20260616155716.2631508-3-puranjay@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Tue, 16 Jun 2026 08:57:07 -0700 Puranjay Mohan <puranjay@kernel.org> wrote:

> perf_clear_branch_entry_bitfields() resets the bitfields of struct
> perf_branch_entry one at a time and deliberately leaves from/to alone,
> since callers overwrite those immediately. The list of assignments has to
> be kept in sync with the struct by hand, and it has already drifted:
> new_type and priv were added to perf_branch_entry but never cleared here,
> so stale values can leak into the records handed to userspace.
> 
> Clear the entry with a single struct assignment instead:
> 
> 	*br = (struct perf_branch_entry){ };
> 
> Every caller writes from/to right after the clear, so zeroing them as well
> is harmless and the dead stores are elided on the x86 LBR read paths.
> There is no longer anything to keep in sync when a field is added.
> 
> The helper no longer touches only the bitfields, so rename it to
> perf_clear_branch_entry() and update the callers, fixing up the
> br+nr/br+out spacing on the touched lines while at it.
> 
> Fixes: b190bc4ac9e6 ("perf: Extend branch type classification")
> Fixes: 5402d25aa571 ("perf: Capture branch privilege information")
> Suggested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  arch/x86/events/amd/brs.c   |  2 +-
>  arch/x86/events/amd/lbr.c   |  2 +-
>  arch/x86/events/intel/lbr.c |  6 +++---
>  drivers/perf/arm_brbe.c     |  2 +-
>  include/linux/perf_event.h  | 16 ++--------------
>  5 files changed, 8 insertions(+), 20 deletions(-)
> 

Acked-by: Usama Arif <usama.arif@linux.dev> 
