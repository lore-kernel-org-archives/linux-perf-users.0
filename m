From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [tip: perf/urgent] perf/aux: Fix tracking of auxiliary trace buffer allocation
Date: Fri, 15 Nov 2019 18:06:59 +0200
Message-ID: <87bltddsyk.fsf@ashishki-desk.ger.corp.intel.com>
References: <20191021083354.67868-1-tmricht@linux.ibm.com> <157165050422.29376.10692255781840811810.tip-bot2@tip-bot2>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <157165050422.29376.10692255781840811810.tip-bot2@tip-bot2>
Sender: linux-kernel-owner@vger.kernel.org
To: tip-bot2 for Thomas Richter <tip-bot2@linutronix.de>, linux-tip-commits@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, acme@kernel.org, gor@linux.ibm.com, hechaol@fb.com, heiko.carstens@de.ibm.com, linux-perf-users@vger.kernel.org, songliubraving@fb.com, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
List-Id: linux-perf-users.vger.kernel.org

"tip-bot2 for Thomas Richter" <tip-bot2@linutronix.de> writes:

>  		/* now it's safe to free the pages */
> -		atomic_long_sub(rb->aux_nr_pages, &mmap_user->locked_vm);
> -		atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
> +		if (!rb->aux_mmap_locked)
> +			atomic_long_sub(rb->aux_nr_pages, &mmap_user->locked_vm);
> +		else
> +			atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);

This only works correctly when rb->aux_mmap_locked is either equal to
rb->aux_nr_pages or zero. Otherwise, it leaks

  rb->aux_nr_pages - rb->aux_mmap_locked

in the locked_vm permanently.

Regards,
--
Alex
