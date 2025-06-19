Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA1E1AA782
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750363853; cv=none; b=lLKBVnt7oyOgEZ1cwfnm+7upTh1qch6wqgm3PApaHdcA1iTPfr7RwjqzPPdkX2GL03K9Ca+4icP5pTIciICiT9fPgQOhpdO3SJAzPjZnVbyVhSbfUtBzQtNi4a62UfC0W2QowWm+3Nd6gxTCzc2xyeDBolSRQ1ZLI4yc8EFQqaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750363853; c=relaxed/simple;
	bh=prp8+GLdi67CCO/fTl7oCyzWJNCbpy4T9g54grijS6U=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SHDPWLLY5DiVbH94LinfC8VV06wDD2ZVr4IQ9VIpjo1UZxFs90U3IYtN4uRJqG2ggZ5O1j1kd4nuVacx2agX47JApAvpPvJ6dF42XtCCQuPZnw+rSyw5eIMka7vag0hC7Oap0ldKNByYe2YeuNg6GXQRS7mLi/aoXqkrpGRUu2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=DUNbfWbG; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="DUNbfWbG"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d38d562a55so149730385a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 13:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1750363850; x=1750968650; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eyEWuCHrvWHD9ansF7IHOjwzLU5pCleeooeAvqUkVs4=;
        b=DUNbfWbGQrz1bsNAIMVRla0bkP9l9YfNTTqEmhTY8AsOP2JDApxbL/5uMu9TvsHxdQ
         A8YqNzuZtf5CXKZziYnYDUVKSEOzlbplJHWYsAfEYLGONauarTy22cmmM2SqyZyH7+JX
         zelXM8T3k6Y2butHXPRGN6eO3s19yxVKyJZ58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750363850; x=1750968650;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eyEWuCHrvWHD9ansF7IHOjwzLU5pCleeooeAvqUkVs4=;
        b=VjQ29Fb1mWULAXYpuI52+I3JZjrNypuktlNLP3TFZY4Ltqi1dkrY+355u8RHFuhxlY
         q6VGgUoq8oxd2AbOGCcWK9htFk84RKVkPeFd2KIbz7bUFFJgYkZUnYnktMvNKBj6mqHP
         xDoy5d5TqX8rmrzkjHMfgruriGz2lMpM98vnTl01VYAA+gbdzJR46Y9QSwtFZRMDzqld
         4Mfyxlbr7JukJSNqaUsfdyBSpc1+TiEfDdw/LzdqU1kCfFIeTMtoANUZUG53ujzoRPSo
         j0l15JO/Gvvi0TXH43iOwjrCQbuD+PtxUPcYG/Jx3VWcd/Zi1Vqvad42HZ6gJR5+ckk2
         SlaA==
X-Forwarded-Encrypted: i=1; AJvYcCVwhc7aYtG1RX/4frgcmli1sd3aXfwLeZOLywOB441vMl3FV0dk4eTDwp6xXMVfjHrO0U0k1XH3md7fcvfjE65P@vger.kernel.org
X-Gm-Message-State: AOJu0YxlsB+E5kf7pgGgvDusjIaPyPNzPwRN/Ef3LKo5thoX+dOM6LBr
	wL0ASAuQAvFLO2p4EB4OY84KA/IZGzhLjTSmjfcbPvGMv3Bo1NuI3abilnuKSGYt4g==
X-Gm-Gg: ASbGnctNmzIRIaDsed2WEWE0GDYU0v0dZ2LYgkNrxm2joSL7wZjj8No4lniJpdEfn93
	M2hDZxQ4KnAD2xFTaZXgmzPMTDBg/Lqk2lyOUk4LzNjcq2OacOv7PnYwvy030cWx9ScgDGLeVkl
	xSvA24GtrWelZxCY1A71CYv9QQUEHDy3jA78+qIKEJbvkLCoY5jEoRh9QDBH4ephtXBjoHNWIWH
	QRPl4RARs1oCDoAnQHmXw2PQ4aFtLFghs11mns3CPR43L3UrxdWyXWjheSeLZydk88rf4IHxgrz
	9VToNQ/4wtxoCDenDKtNcGgZi8htZvk1OyOr2Utf1O3Cc9Q5R6KY+pEIUoHQikU/McHneTe8Ugt
	c/lWRhw==
X-Google-Smtp-Source: AGHT+IErhV7jdWq7SCgT4TlbfysCbhBy4dKg4Nmh4w5dfkj6o7aRao4G1P6Wi0AxksQu6FbcIncDMA==
X-Received: by 2002:a05:620a:7018:b0:7d3:e83c:951d with SMTP id af79cd13be357-7d3f98f0fd7mr94730985a.21.1750363850397;
        Thu, 19 Jun 2025 13:10:50 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99efae4sm14682985a.57.2025.06.19.13.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 13:10:49 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Thu, 19 Jun 2025 16:10:48 -0400 (EDT)
To: "Liang, Kan" <kan.liang@linux.intel.com>
cc: Vince Weaver <vincent.weaver@maine.edu>, linux-kernel@vger.kernel.org, 
    linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
    Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [perf] unchecked MSR access error: WRMSR to 0x3f1
In-Reply-To: <9aee2b65-e43a-4fcd-a929-a98269621315@linux.intel.com>
Message-ID: <d12d4300-9926-5e58-6515-a53cb5c7bee0@maine.edu>
References: <14d3167e-4dad-f68e-822f-21cd86eab873@maine.edu> <574b8701-9676-4aba-a85b-724c979b2efa@linux.intel.com> <7e8bb736-3955-c479-99de-e08efb494bdd@maine.edu> <8739c2c6-a27c-4ab6-ad74-8b95e258737e@linux.intel.com> <c04824b5-5697-1de5-0003-f2c5b73ed006@maine.edu>
 <52656281-ab73-baf7-0a80-ebcbe79dfca2@maine.edu> <9aee2b65-e43a-4fcd-a929-a98269621315@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 19 Jun 2025, Liang, Kan wrote:

> 
> 
> On 2025-06-19 11:17 a.m., Vince Weaver wrote:
> > On Wed, 18 Jun 2025, Vince Weaver wrote:
> > 
> >> On Wed, 18 Jun 2025, Liang, Kan wrote:
> >>
> >>> No, the error message doesn't say it. Just want to check if you have
> >>> extra information. Because the Topdown perf metrics is only supported on
> >>> p-core. I want to understand whether the code messes up with e-core.
> >>
> >> I can't easily tell from the fuzzer as it intentionally switches cores 
> >> often.  I guess I could patch the kernel to report CPU when the WRMSR 
> >> error triggers.
> > 
> > I've patched the kernel to get rid of the warn_once() and added a printk
> > for smp_processor_id()  (is that what I want to print?)  In any case that 
> > reports the warning is happening on CPU1 which is actually a P core, not 
> > an atom core.
> 
> Thanks for the confirmation.
> I've tried fuzzer in some newer machines (later than raptor-lake), but I
> haven't reproduce it yet. I will try to find a raptor-lake for more tests.

I've managed to use the perf_fuzzer tools to create a small reproducible 
test case that can trigger the bug.  It's included below.

Vince

---


/* WRMSR top-down reproducer */
/* by Vince Weaver <vincent.weaver _at_ maine.edu> */

#define _GNU_SOURCE 1
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <signal.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <sys/ioctl.h>
#include <sys/prctl.h>
#include <sys/wait.h>
#include <poll.h>
#include <linux/hw_breakpoint.h>
#include <linux/perf_event.h>
#include <sched.h>

static int fd[1024];
static struct perf_event_attr pe[1024];

FILE *fff;
static int result;

int perf_event_open(struct perf_event_attr *hw_event_uptr,
	pid_t pid, int cpu, int group_fd, unsigned long flags) {

	return syscall(__NR_perf_event_open,hw_event_uptr, pid, cpu,
		group_fd, flags);
}

int main(int argc, char **argv) {

	int i;
	for(i=0;i<1024;i++) fd[i]=-1;

/* 1 */
/* fd = 72 */

	memset(&pe[72],0,sizeof(struct perf_event_attr));
	pe[72].type=PERF_TYPE_RAW;
	pe[72].config=0xffff880000008000ULL;
	pe[72].sample_freq=0x49ULL;
	pe[72].sample_type=PERF_SAMPLE_TID|PERF_SAMPLE_ADDR|PERF_SAMPLE_READ|PERF_SAMPLE_CPU; /* 9a */
	pe[72].read_format=PERF_FORMAT_ID|PERF_FORMAT_GROUP|0x10ULL; /* 1c */
	pe[72].exclude_user=1;
	pe[72].exclude_kernel=1;
	pe[72].mmap=1;
	pe[72].comm=1;
	pe[72].freq=1;
	pe[72].enable_on_exec=1;
	pe[72].watermark=1;
	pe[72].precise_ip=1; /* constant skid */
	pe[72].sample_id_all=1;
	pe[72].exclude_callchain_user=1;
	pe[72].comm_exec=1;
	pe[72].wakeup_watermark=-1970634752;
	pe[72].bp_type=HW_BREAKPOINT_R|HW_BREAKPOINT_W; /*3*/
	pe[72].bp_addr=0x0ULL;
	pe[72].bp_len=0x2ULL;
	pe[72].branch_sample_type=PERF_SAMPLE_BRANCH_HV|PERF_SAMPLE_BRANCH_ANY|PERF_SAMPLE_BRANCH_ANY_CALL|PERF_SAMPLE_BRANCH_ANY_RETURN|PERF_SAMPLE_BRANCH_IND_JUMP|PERF_SAMPLE_BRANCH_ABORT_TX|PERF_SAMPLE_BRANCH_COND|0xbcbcbca800ULL;
	pe[72].sample_regs_user=4294967253ULL;
	pe[72].sample_stack_user=0x23008000;

	fd[72]=perf_event_open(&pe[72],
				0, /* current thread */
				1, /* Only cpu 1 */
				fd[114], /* 114 is group leader */
				PERF_FLAG_FD_NO_GROUP /*1*/ );


/* 2 */
	prctl(PR_TASK_PERF_EVENTS_DISABLE);
/* 3 */
// a 0 1 1
// which=0,num=1,cpi=1

#define MAX_CPUS 1024

	pid_t pid=0;    /* current thread */
        static cpu_set_t *cpu_mask;
        int max_cpus=MAX_CPUS;
        size_t set_size;

	cpu_mask=CPU_ALLOC(max_cpus);
	set_size=CPU_ALLOC_SIZE(max_cpus);


	CPU_ZERO_S(set_size,cpu_mask);
	CPU_SET_S(1,set_size,cpu_mask);

	result=sched_setaffinity(pid,max_cpus,cpu_mask);

/* 4 */
	prctl(PR_TASK_PERF_EVENTS_ENABLE);
/* 5 */
/* fd = 38 */

	memset(&pe[38],0,sizeof(struct perf_event_attr));
	pe[38].type=PERF_TYPE_HARDWARE;
	pe[38].size=112;
	pe[38].config=PERF_COUNT_HW_BRANCH_MISSES;
	pe[38].sample_type=0; /* 0 */
	pe[38].read_format=PERF_FORMAT_ID|PERF_FORMAT_GROUP|0x10ULL; /* 1c */
	pe[38].disabled=1;
	pe[38].precise_ip=0; /* arbitrary skid */
	pe[38].wakeup_events=0;
	pe[38].bp_type=HW_BREAKPOINT_EMPTY;

	fd[38]=perf_event_open(&pe[38],
				getpid(), /* current thread */
				22, /* Only cpu 22 */
				-1, /* New Group Leader */
				PERF_FLAG_FD_NO_GROUP /*1*/ );




	/* Replayed 4 syscalls */
	return 0;
}
