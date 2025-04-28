Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6095D477;
	Mon, 28 Apr 2025 12:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844455; cv=none; b=RbbgQg8ov+by9Yjp/kmcGeGkzR0oPfimW8FccnQ+2TKKIOJrw6zLj0U5HNqX3wslvj0V/G7jAjjylhbAEyKxjvHOpYGR/auhT9RVvUUrd7D7IUghvmRD2D4MmuMzp2MG6xejGO1e2SXmkQL1QTnFLJ+gxttp+xDw9xcCquYz1cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844455; c=relaxed/simple;
	bh=5tMjk79ViuaMPIJS0ozsIRLq0s0QRfWBrHGIrb8AZvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lv4Kjqvx7e7ES5o4uT1Qm6xhueiT4RV0KWahYsyfNAaFsvi9NDhXynRHSLcvYDyWiIhgkt+CkWAZBBA1HxpPFJCZdIejOiLRi0G1FEKiwyn5VCJpHEt+JNGvnJk2oSXHtcNYbkRrohJZoy5Tyw+xe6RXI6rEdIftb1BciadsG3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52EEC1007;
	Mon, 28 Apr 2025 05:47:26 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61DF63F66E;
	Mon, 28 Apr 2025 05:47:32 -0700 (PDT)
Date: Mon, 28 Apr 2025 13:47:27 +0100
From: Leo Yan <leo.yan@arm.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Wander Costa <wcosta@redhat.com>
Subject: Re: [BUG] perf segfaults when combining --overwrite and intel_pt
 event
Message-ID: <20250428124727.GE551819@e132581.arm.com>
References: <CAP4=nvTab7BnT4uu0iCuFJpZ-_MdY-MYU+Q25QnpygEZKmsQ8A@mail.gmail.com>
 <20250428101234.GB551819@e132581.arm.com>
 <CAP4=nvQ_7oS5ZAsKmOd_ORg0tyHS=B+i2m63K=TLg22rTEiRGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP4=nvQ_7oS5ZAsKmOd_ORg0tyHS=B+i2m63K=TLg22rTEiRGQ@mail.gmail.com>

On Mon, Apr 28, 2025 at 12:45:41PM +0200, Tomas Glozar wrote:

> Thank you for looking at this. The initial segfault on writing to
> read-only page is fixed,

Thanks a lot for testing, Tomas!

> however, perf now segfaults in a different place:


> (gdb) r
> Starting program: /home/tglozar/dev/linux/tools/perf/perf record
> --overwrite -a -e intel_pt/cyc,noretcomp/k sleep 5
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
> [Detaching after fork from child process 424037]
> [New Thread 0x7ffff2df46c0 (LWP 424038)]
> [ perf record: Woken up 1 times to write data ]
> Thread 1 "perf" received signal SIGSEGV, Segmentation fault.
> intel_pt_info_fill (itr=0x7a1e40, session=0x794ef0,
> auxtrace_info=0x7cdfd0, priv_size=144) at arch/x86/util/intel-pt.c:361
> 361             pc = session->evlist->mmap[0].core.base;

Yes, this is a different issue, it would be fixed by:

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 8f235d8b67b6..42f0dbfa973c 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -322,7 +322,7 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 	struct intel_pt_recording *ptr =
 			container_of(itr, struct intel_pt_recording, itr);
 	struct perf_pmu *intel_pt_pmu = ptr->intel_pt_pmu;
-	struct perf_event_mmap_page *pc;
+	struct perf_event_mmap_page *pc = NULL;
 	struct perf_tsc_conversion tc = { .time_mult = 0, };
 	bool cap_user_time_zero = false, per_cpu_mmaps;
 	u64 tsc_bit, mtc_bit, mtc_freq_bits, cyc_bit, noretcomp_bit;
@@ -358,7 +358,11 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 	if (!session->evlist->core.nr_mmaps)
 		return -EINVAL;
 
-	pc = session->evlist->mmap[0].core.base;
+	if (session->evlist->mmap)
+		pc = session->evlist->mmap[0].core.base;
+	else if (session->evlist->mmap_ovw)
+		pc = session->evlist->mmap_ovw[0].core.base;
+
 	if (pc) {
 		err = perf_read_tsc_conversion(pc, &tc);
 		if (err) {

I would leave this fix to the Intel-PT developers, who know this part
best.

Thanks,
Leo
