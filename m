Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F113728FD
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Dec 2024 00:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733444078; cv=none; b=qSSbQD6keKSpbsnXHx8v4BMa3i4yNwwebZy4xxM7l+7/EZNIrJV8Khz6SiQi35/s9D5ofHAI4t3AfBvB4XP5y8l/ZFMf1tV76nlQbOrKnt0iUOikALMm+b/uod4dgcOHQjEO6p+ShsHOg1QSVXAoipvCtdxhCEU1dYl3W4U7sVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733444078; c=relaxed/simple;
	bh=fXX8jxovVy8UhuUNkpLzZi+RefrdRHaoNOfPZ9eC5eA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LqbSOBIHJ1T15AweFPkxqv9WwAGgvFo0udBwN68MRS0IO8zA30jPGZRO9NzNbjRGDzUsBVHripOuqewIy23ebcSIoFflKM76+xpgUVnmwgbRIdQ//OPsrbBnIkT5PmkSTCdO7AcZ7FQGMqNWq+lftA8v0d0XYI5ugeIWrfLUhKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI8dDfQL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI8dDfQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6273DC4CED1;
	Fri,  6 Dec 2024 00:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733444077;
	bh=fXX8jxovVy8UhuUNkpLzZi+RefrdRHaoNOfPZ9eC5eA=;
	h=From:To:Cc:Subject:Date:From;
	b=bI8dDfQL9eOZA6DCy4bZ1QLcXYmZrRG0XCFIOwEbSDiveWxIROLyKjPUvKur7ahWu
	 QxB5CxL14kQI0mge5viwdM057lCmGPVOZ1gunPYhaQxtXYpzTUT1wQF4ldLXw+xK8x
	 891/z3onJfnXs4Mh2J67XM9FpuKBJRT5EnpDx1IGZsQQ7LQbDcFDFjpgpzmkICrDLH
	 yVOQ6a2U5JAQTDzZ0Gb2Ie273ahDg+k0bPL6v/+8W2cpHRlpOxkseesH9q1AGRAkrC
	 07XOkClRrUx84ZHYLZuJRiFUlPVAB59TphMFfUg0t6Pxrpnsx96IqUxfq/BXQFjq9x
	 DTKii9bBfLafA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Howard Chu <howardchu95@gmail.com>
Cc: linux-perf-users@vger.kernel.org
Subject: [BUG] perf trace: failed to load -E2BIG
Date: Thu,  5 Dec 2024 16:14:36 -0800
Message-ID: <20241206001436.1947528-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I'm seeing the following error in the current perf-tools[-next].
Do you see you the same?

  $ sudo ./perf trace -a sleep 1
  libbpf: prog 'sys_enter': BPF program load failed: -E2BIG
  libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
  0: R1=ctx() R10=fp0
  ; int sys_enter(struct syscall_enter_args *args) @ augmented_raw_syscalls.bpf.c:527
  0: (bf) r7 = r1                       ; R1=ctx() R7_w=ctx()
  ; return bpf_get_current_pid_tgid(); @ augmented_raw_syscalls.bpf.c:423
  1: (85) call bpf_get_current_pid_tgid#14      ; R0_w=scalar()
  2: (63) *(u32 *)(r10 -4) = r0         ; R0_w=scalar() R10=fp0 fp-8=mmmm????
  3: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
  ;  @ augmented_raw_syscalls.bpf.c:0
  4: (07) r2 += -4                      ; R2_w=fp-4
  ; return bpf_map_lookup_elem(pids, &pid) != NULL; @ augmented_raw_syscalls.bpf.c:428
  ...
  140: (79) r7 = *(u64 *)(r10 -48)      ; R7_w=ctx() R10=fp0 fp-48=ctx()
  141: (79) r0 = *(u64 *)(r10 -56)
  BPF program is too large. Processed 1000001 insn
  processed 1000001 insns (limit 1000000) max_states_per_insn 28 total_states 37670 peak_states 330 mark_read 16
  -- END PROG LOAD LOG --
  libbpf: prog 'sys_enter': failed to load: -E2BIG
  libbpf: failed to load object 'augmented_raw_syscalls_bpf'
  libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -E2BIG
  libbpf: map '__augmented_syscalls__': can't use BPF map without FD (was it created?)
  libbpf: map '__augmented_syscalls__': can't use BPF map without FD (was it created?)
  libbpf: map '__augmented_syscalls__': can't use BPF map without FD (was it created?)
  libbpf: map '__augmented_syscalls__': can't use BPF map without FD (was it created?)
  Not enough memory to run!

The git bisect found this but I couldn't find anything suspicious.

395d38419f1853decab84acc16176b3fa5c96690 is the first bad commit
commit 395d38419f1853decab84acc16176b3fa5c96690
Author: Howard Chu <howardchu95@gmail.com>
Date:   Thu Oct 10 19:14:02 2024 -0700

    perf trace augmented_raw_syscalls: Add more checks to pass the verifier
    
    Add some more checks to pass the verifier in more kernels.
    
    Signed-off-by: Howard Chu <howardchu95@gmail.com>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alan Maguire <alan.maguire@oracle.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Ian Rogers <irogers@google.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Link: https://lore.kernel.org/r/20241011021403.4089793-3-howardchu95@gmail.com
    [ Reduced the patch removing things that can be done later ]
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

 .../perf/util/bpf_skel/augmented_raw_syscalls.bpf.c  | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)
bisect found first bad commit

Thanks,
Namhyung

