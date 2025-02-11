Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91CD1E5B6D;
	Tue, 11 Feb 2025 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739298387; cv=none; b=Ukl6ncz3J0TM3aiwvw1VmpeVHVY0yxi1QMvVXSAeDtV4yDSLLN2LXVeQKoKhj5vGDvThiBMnVJwL9HJV+phKATWjQan/6BWDuWygwWK5tZitr9UPwWPhxIn8b3pxVDL082OuE7tzpi3MK36tOpPbMsNn92S/eSNBRTXE7Hr3SLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739298387; c=relaxed/simple;
	bh=uGHUCJID/jW/mOz/BTl2NMPaZREwpEySxZBYFI4a5mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4cePM7s3J0hNsEW+PlJ5MM7wdjGMPybytz1o/QMcLvOUDeAY94oPbAZiYs/BBDY7C4bU7Y4K2gXNcDM5ezp6IzzFMndnsk6ymVwyQLluCxYmHey2+UH3yUUtjGfkSVvkpeKaVq968UMpY5WUVAsX+PTXu0XYKuI+gyJ3r1OrbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHiPECwF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHiPECwF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84F6C4CEDD;
	Tue, 11 Feb 2025 18:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739298387;
	bh=uGHUCJID/jW/mOz/BTl2NMPaZREwpEySxZBYFI4a5mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DHiPECwFg9kTfgPW9Jwyo7PrSrveGmM/QOA+ymevfNSoflkiTJBgVmhNFG45y/r1P
	 fuWpIe3+WfSU9bcPRRRw7k8E/+wiFlS3FsvPG0C7aUvUKZHs3ZNl2hysul2979em4p
	 JHXjKaoE70SPf4w15lk+/GZn13pAn9kfbKVBTG9JoINnkYKyxrQYfFWKvF6V+rDQT6
	 9WUngaLvW39Er3bsyMpDhSOKtV6nCbIkH9ve/FOGlAgCvcOAVCrvrcEcXaSnpILDBN
	 rFwAcDeqHYVf03/57R+c1dHr/s2ew59HOuVimPm7kD5rpI7WFPMINLDCfvq7h0NOYt
	 +xKQUHczXyfOA==
Date: Tue, 11 Feb 2025 19:26:24 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 00/10] perf record --off-cpu: Dump off-cpu samples
 directly
Message-ID: <Z6uWUMLOG9uBDb3L@x1>
References: <20241215181220.754822-1-howardchu95@gmail.com>
 <Z2CJW0vFT005gmIe@google.com>
 <Z6uQmcLllm1wR3-h@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6uQmcLllm1wR3-h@x1>

On Tue, Feb 11, 2025 at 07:02:04PM +0100, Arnaldo Carvalho de Melo wrote:
> When running just one workload:
> 
> root@number:~# for a in `seq 10` ; do perf record --off-cpu sleep 1s ; perf script | grep offcpu-time ; done
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.037 MB perf.data (13 samples) ]
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.037 MB perf.data (16 samples) ]
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.037 MB perf.data (14 samples) ]
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.037 MB perf.data (12 samples) ]
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
> root@number:~#
> 
> Have you tested it like that? Is this a known issue/current limitation?
> 
> I'm reading the patches to see I understand this better.

Ok, if I go back and use the example Namhyung added to the commit
message introducing off-cpu profiling:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=edc41a1099c2d08ccfd4ed7d59688501e3749015

We get offcpu-time samples:

root@number:~# perf record --off-cpu perf bench sched messaging -l 1000
# Running 'sched/messaging' benchmark:
# 20 sender and receiver processes per group
# 10 groups == 400 processes run

     Total time: 0.244 [sec]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.182 MB perf.data (43600 samples) ]
root@number:~# perf script | grep offcpu-time | wc -l
867
root@number:~# 

But they are all at the end:

sched-messaging  469373 17707.960698:    1055439 cpu_atom/cycles/P:  ffffffff8a49a453 mod_objcg_state+0xb3 ([kernel.kallsyms])
 sched-messaging  469373 17707.960944:    1057379 cpu_atom/cycles/P:  ffffffff8b222cf9 native_queued_spin_lock_slowpath+0x209 ([kernel.kallsyms])
 sched-messaging  469274 17707.961299:    6311728 cpu_core/cycles/P:      7fa751a510f1 __cxa_finalize+0x151 (/usr/lib64/libc.so.6)
         :469374  469374 [000] 18446744069.414584:   43388310       offcpu-time: 
            7fa751b1c1c4 [unknown] ([unknown])
                  4fb0e8 [unknown] ([unknown])
                  4faa29 [unknown] ([unknown])
                  495700 [unknown] ([unknown])
                  495a1b [unknown] ([unknown])
                  413473 [unknown] ([unknown])
            7fa751a38088 [unknown] ([unknown])
            7fa751a3814b [unknown] ([unknown])
                  413ac5 [unknown] ([unknown])

         :469518  469518 [000] 18446744069.414584:   22436206       offcpu-time: 
            7fa751b1c1c4 [unknown] ([unknown])
                  4fb0e8 [unknown] ([unknown])
                  4faa29 [unknown] ([unknown])
                  495700 [unknown] ([unknown])
                  495a1b [unknown] ([unknown])
                  413473 [unknown] ([unknown])
            7fa751a38088 [unknown] ([unknown])
            7fa751a3814b [unknown] ([unknown])
                  413ac5 [unknown] ([unknown])

         :469663  469663 [000] 18446744069.414584:  180198700       offcpu-time: 
            7fa751b1d304 [unknown] ([unknown])
                  4faa29 [unknown] ([unknown])
                  495700 [unknown] ([unknown])
                  495a1b [unknown] ([unknown])
                  413473 [unknown] ([unknown])
            7fa751a38088 [unknown] ([unknown])
            7fa751a3814b [unknown] ([unknown])
                  413ac5 [unknown] ([unknown])

possibly the threshold?

Tried:

root@number:~# perf record --off-cpu --off-cpu-thresh 10 perf bench sched messaging -l 1000

Didn't help.

When doing a system wide session with that 10 threshold I get the
offcpu-time samples intermixed, i.e. not just at the end:

root@number:~# perf record -a --off-cpu --off-cpu-thresh 10 perf bench sched messaging -l 1000

sched-messaging  472324 [007] 18587.393976:    1371787 cpu_core/cycles/P:  ffffffff8a7864d2 avc_has_perm+0x92 ([kernel.kallsyms])
         swapper       0 [023] 18587.394111:     286156 cpu_atom/cycles/P:  ffffffff8a16aacb do_idle+0x14b ([kernel.kallsyms])
 sched-messaging  472532 [016] 18587.394210:     294672 cpu_atom/cycles/P:  ffffffff8b4000ab entry_SYSCALL_64_safe_stack+0x0 ([kernel.kallsyms])
 sched-messaging  472324 [007] 18587.394226:    1371903 cpu_core/cycles/P:  ffffffff8a3f6308 copy_page_range+0x12a8 ([kernel.kallsyms])
          podman    3935 [012] 18587.394310:   10106482       offcpu-time: 
            5630f6bf2457 [unknown] (/usr/bin/podman)
            5630f6bc49e5 [unknown] (/usr/bin/podman)
            5630f6bbb1f5 [unknown] (/usr/bin/podman)
            5630f6bbb136 [unknown] (/usr/bin/podman)
            5630f6beeb65 [unknown] (/usr/bin/podman)
            7f4474032088 start_thread+0x3b8 (/usr/lib64/libc.so.6)
            7f44740b5f8c clone3+0x2c (/usr/lib64/libc.so.6)

 sched-messaging  472534 [016] 18587.394434:     279374 cpu_atom/cycles/P:  ffffffff8a3826c9 get_callchain_entry+0x9 ([kernel.kallsyms])
 sched-messaging  472324 [007] 18587.394476:    1371988 cpu_core/cycles/P:  ffffffff8a43d264 __kmalloc_node_noprof+0xd4 ([kernel.kallsyms])
         swapper       0 [016] 18587.394717:     276534 cpu_atom/cycles/P:  ffffffff8a1d2ef4 rcu_preempt_deferred_qs+0x4 ([kernel.kallsyms])
<SNIP>
 sched-messaging  472674 [013] 18587.414755:    6576247 cpu_core/cycles/P:  ffffffff8b222d7d native_queued_spin_lock_slowpath+0x28d ([kernel.kallsyms])
 sched-messaging  472625 [022] 18587.414760:   10699110       offcpu-time: 
            7f6b1a71d304 __GI___libc_write+0x14 (/usr/lib64/libc.so.6)
                  4fb0e8 bench_sched_messaging+0x218 (/home/acme/bin/perf)
                  4faa29 cmd_bench+0x2f9 (/home/acme/bin/perf)
                  495700 run_builtin+0x70 (/home/acme/bin/perf)
                  495a1b handle_internal_command+0xab (/home/acme/bin/perf)
                  413473 main+0x2f3 (/home/acme/bin/perf)
            7f6b1a638088 __libc_start_call_main+0x78 (/usr/lib64/libc.so.6)
            7f6b1a63814b __libc_start_main@@GLIBC_2.34+0x8b (/usr/lib64/libc.so.6)
                  413ac5 _start+0x25 (/home/acme/bin/perf)

 sched-messaging  472623 [023] 18587.414763:   10911814       offcpu-time: 
            7f6b1a71d304 __GI___libc_write+0x14 (/usr/lib64/libc.so.6)
                  4fb0e8 bench_sched_messaging+0x218 (/home/acme/bin/perf)
                  4faa29 cmd_bench+0x2f9 (/home/acme/bin/perf)
                  495700 run_builtin+0x70 (/home/acme/bin/perf)
                  495a1b handle_internal_command+0xab (/home/acme/bin/perf)
                  413473 main+0x2f3 (/home/acme/bin/perf)
            7f6b1a638088 __libc_start_call_main+0x78 (/usr/lib64/libc.so.6)
            7f6b1a63814b __libc_start_main@@GLIBC_2.34+0x8b (/usr/lib64/libc.so.6)
                  413ac5 _start+0x25 (/home/acme/bin/perf)
<SNIP>

So I'm guessing that running just the 'sleep' workload we are missing
the sample at some point while with the 'perf bench' we have way more
samples, etc.

Also the intermixed entries have backtraces resolved to symbols, while
the ones at the end don't have, something else to investigate.

- Arnaldo

