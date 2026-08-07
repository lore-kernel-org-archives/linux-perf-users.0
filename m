Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE61F3D5227;
	Fri,  7 Aug 2026 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115326; cv=none; b=E53IykwyRPo5sN4wd7GwpvE+ATrDmrZNH9WZ75RefysISnBnFTIZdXFrIbeOHBu8+y+9emlosGN7HJ8s+BM7vLI+XGka2OQPQdX12V43Uc6NPWUtEogw/y+0sbcdcMwvSGXlu2gCwpsrMCVzS9r+z4s6zmLA6qXkjBd6qoBmQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115326; c=relaxed/simple;
	bh=BHA3+Rt/h9hO4k8Qd/Pj/QaxedFkcQ4kEZKMxZwFlwo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HGz6bh1dEyU/VS//pC2THjF2RsU4u8Pm/rc0rOW6D5xjobGAc1ZMqgaEVlRbPKDp+z0uivdwsd5ZNgHYROie9ootU+zhiV/y0Yl8D8gNXLZESMjWCKO2UmMHyyXNV8BwS9B9PgD3cIxe358aHIAAfpxwMSGJCZbuDIdh2gt+PdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bh+k+/JD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bh+k+/JD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6168CC2BCC7;
	Fri,  7 Aug 2026 15:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786115326;
	bh=BHA3+Rt/h9hO4k8Qd/Pj/QaxedFkcQ4kEZKMxZwFlwo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Bh+k+/JD6DM9pNXOkLNN/PZd4tDWZ1Gr1goHyFs4x1SskR9iFSpUPhfrDlAzQz0pz
	 rFc04LM+7F51uTl+qwsB+Mfja+elmoMtJB4Q0G8hHfl3QlRfFQS2mSnYlLkNuhma/J
	 qv1RKd4LPFUzTW4VfxdfPg4h/wELeTyei+gw6dmjpH2Pwmutb/dPdhLXBlb7ruJ7bE
	 7CM7UviEcmX0adlEmGEuf+W4CDvi/A40+7sk4ErUg+9aoBj63qIYNxWyf+O4jNrCUf
	 /CvP2L6YUW0YMoqlYQlVZr9buKMKMBw534jqjYKoH+IGUSbNrIytQpINhfRVzhuEYU
	 VVPnjJfdD6LtQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF5AC5AC82;
	Fri,  7 Aug 2026 15:08:46 +0000 (UTC)
From: Michalis Niarchos via B4 Relay <devnull+michael.niarchos.gmail.com@kernel.org>
Subject: [PATCH 0/2] perf kvm: Fix memory leaks
Date: Fri, 07 Aug 2026 17:08:34 +0200
Message-Id: <20260807-perf-kvm-leaks-v1-0-7b5e2f97905a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCwNz3YLUojTd7LJc3ZzUxOxi3bTU5ERLAxOTROOUJCWgpoKi1LTMCrC
 B0bEQfnFpUlZqcgnIFKXaWgBd0meycgAAAA==
X-Change-ID: 20260807-perf-kvm-leaks-feca9044a3db
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michalis Niarchos <michael.niarchos@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786115324; l=8222;
 i=michael.niarchos@gmail.com; s=20260731; h=from:subject:message-id;
 bh=BHA3+Rt/h9hO4k8Qd/Pj/QaxedFkcQ4kEZKMxZwFlwo=;
 b=cs9ivVNTXKa0DsY1EuYkYWzHujm8p/LBdNLlBg8/B+vMxqIH6tUx0nBBZQ5Dxns5391+PEMr8
 w40xHkzj0icBfcA1ufQ9wMM+DaTUUhj+W8pGXyZAmdgIaSjGEYxMSaB
X-Developer-Key: i=michael.niarchos@gmail.com; a=ed25519;
 pk=/LBZRQzfuxTnSaZhgZE8EP7mHr0poyqlKeFssNqkzFE=
X-Endpoint-Received: by B4 Relay for michael.niarchos@gmail.com/20260731
 with auth_id=912
X-Original-From: Michalis Niarchos <michael.niarchos@gmail.com>
Reply-To: michael.niarchos@gmail.com

Running ./perf kvm stat report with ASan, revealed some memory leaks:

==206006==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 72 byte(s) in 3 object(s) allocated from:
    #0 0x7ff86bf2bea9 in calloc (/usr/lib/libasan.so.8+0x12bea9) (BuildId: 7f2845989b820f536270e19ec47df085ae89a675)
    #1 0x55f42795a0d5 in zalloc ../../lib/zalloc.c:8
    #2 0x55f42782d7f4 in per_vcpu_record /home/mike/git/linux/tools/perf/builtin-kvm.c:929
    #3 0x55f42782dab7 in handle_kvm_event /home/mike/git/linux/tools/perf/builtin-kvm.c:950
    #4 0x55f42782fa80 in process_sample_event /home/mike/git/linux/tools/perf/builtin-kvm.c:1159
    ...
    #14 0x55f42783236c in read_events /home/mike/git/linux/tools/perf/builtin-kvm.c:1591
    #15 0x55f4278326f8 in kvm_events_report_vcpu /home/mike/git/linux/tools/perf/builtin-kvm.c:1636

Direct leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7ff86bf2c0c1 in malloc (/usr/lib/libasan.so.8+0x12c0c1) (BuildId: 7f2845989b820f536270e19ec47df085ae89a675)
    #1 0x55f427d78fe5 in thread__get util/thread.c:137
    #2 0x55f427c4f1fc in thread__find_map util/event.c:703
    #3 0x55f427c5001e in machine__resolve util/event.c:819
    #4 0x55f42782f84a in process_sample_event /home/mike/git/linux/tools/perf/builtin-kvm.c:1145
    ...
    #14 0x55f42783236c in read_events /home/mike/git/linux/tools/perf/builtin-kvm.c:1591
    #15 0x55f4278326f8 in kvm_events_report_vcpu /home/mike/git/linux/tools/perf/builtin-kvm.c:1636

Indirect leak of 256 byte(s) in 1 object(s) allocated from:
    #0 0x7ff86bf2bea9 in calloc (/usr/lib/libasan.so.8+0x12bea9) (BuildId: 7f2845989b820f536270e19ec47df085ae89a675)
    #1 0x55f42795a0d5 in zalloc ../../lib/zalloc.c:8
    #2 0x55f427d78857 in thread__new util/thread.c:46
    #3 0x55f427d7c083 in threads__findnew util/threads.c:116
    #4 0x55f427d2957c in __machine__findnew_thread util/machine.c:553
    #5 0x55f427d29734 in machine__findnew_thread util/machine.c:577
    #6 0x55f427d29a07 in machine__process_comm_event util/machine.c:616
    ...
    #16 0x55f42783236c in read_events /home/mike/git/linux/tools/perf/builtin-kvm.c:1591
    #17 0x55f4278326f8 in kvm_events_report_vcpu /home/mike/git/linux/tools/perf/builtin-kvm.c:1636

Indirect leak of 112 byte(s) in 1 object(s) allocated from:
    #0 0x7ff86bf2bea9 in calloc (/usr/lib/libasan.so.8+0x12bea9) (BuildId: 7f2845989b820f536270e19ec47df085ae89a675)
    #1 0x55f42795a0d5 in zalloc ../../lib/zalloc.c:8
    #2 0x55f427d40e37 in maps__new util/maps.c:270
    #3 0x55f427d78718 in thread__init_maps util/thread.c:30
    #4 0x55f427d295d8 in __machine__findnew_thread util/machine.c:563
    #5 0x55f427d29734 in machine__findnew_thread util/machine.c:577
    #6 0x55f427d29a07 in machine__process_comm_event util/machine.c:616
    ...
    #16 0x55f42783236c in read_events /home/mike/git/linux/tools/perf/builtin-kvm.c:1591
    #17 0x55f4278326f8 in kvm_events_report_vcpu /home/mike/git/linux/tools/perf/builtin-kvm.c:1636

Indirect leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x7ff86bf2bea9 in calloc (/usr/lib/libasan.so.8+0x12bea9) (BuildId: 7f2845989b820f536270e19ec47df085ae89a675)
    #1 0x55f42795a0d5 in zalloc ../../lib/zalloc.c:8
    #2 0x55f427d75f07 in comm__new util/comm.c:194
    #3 0x55f427d78a2f in thread__new util/thread.c:67
    #4 0x55f427d7c083 in threads__findnew util/threads.c:116
    #5 0x55f427d2957c in __machine__findnew_thread util/machine.c:553
    #6 0x55f427d29734 in machine__findnew_thread util/machine.c:577
    #7 0x55f427d29a07 in machine__process_comm_event util/machine.c:616
    ...
    #17 0x55f42783236c in read_events /home/mike/git/linux/tools/perf/builtin-kvm.c:1591
    #18 0x55f4278326f8 in kvm_events_report_vcpu /home/mike/git/linux/tools/perf/builtin-kvm.c:1636

Indirect leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7ff86bf2bea9 in calloc (/usr/lib/libasan.so.8+0x12bea9) (BuildId: 7f2845989b820f536270e19ec47df085ae89a675)
    #1 0x55f427d731a1 in nsinfo__alloc util/namespaces.c:146
    #2 0x55f427d73275 in nsinfo__new util/namespaces.c:160
    #3 0x55f427d78ac9 in thread__new util/thread.c:74
    #4 0x55f427d7c083 in threads__findnew util/threads.c:116
    #5 0x55f427d2957c in __machine__findnew_thread util/machine.c:553
    #6 0x55f427d29734 in machine__findnew_thread util/machine.c:577
    #7 0x55f427d29a07 in machine__process_comm_event util/machine.c:616
    ...
    #18 0x55f4278326f8 in kvm_events_report_vcpu /home/mike/git/linux/tools/perf/builtin-kvm.c:1636
    #19 0x55f427833d77 in kvm_events_report /home/mike/git/linux/tools/perf/builtin-kvm.c:1764

Indirect leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x7ff86bf2bea9 in calloc (/usr/lib/libasan.so.8+0x12bea9) (BuildId: 7f2845989b820f536270e19ec47df085ae89a675)
    #1 0x55f42795a0d5 in zalloc ../../lib/zalloc.c:8
    #2 0x55f42782d7f4 in per_vcpu_record /home/mike/git/linux/tools/perf/builtin-kvm.c:929
    #3 0x55f42782dab7 in handle_kvm_event /home/mike/git/linux/tools/perf/builtin-kvm.c:950
    #4 0x55f42782fa80 in process_sample_event /home/mike/git/linux/tools/perf/builtin-kvm.c:1159
    ...
    #14 0x55f42783236c in read_events /home/mike/git/linux/tools/perf/builtin-kvm.c:1591
    #15 0x55f4278326f8 in kvm_events_report_vcpu /home/mike/git/linux/tools/perf/builtin-kvm.c:1636

Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7ff86bf2c0c1 in malloc (/usr/lib/libasan.so.8+0x12c0c1) (BuildId: 7f2845989b820f536270e19ec47df085ae89a675)
    #1 0x55f427d7540f in comm_str__get util/comm.c:58
    #2 0x55f427d75ec5 in comm_strs__findnew util/comm.c:189
    #3 0x55f427d76056 in comm__override util/comm.c:215
    #4 0x55f427d796d1 in ____thread__set_comm util/thread.c:259
    #5 0x55f427d797c2 in __thread__set_comm util/thread.c:283
    #6 0x55f427d29b7a in machine__process_comm_event util/machine.c:629
    ...
    #16 0x55f42783236c in read_events /home/mike/git/linux/tools/perf/builtin-kvm.c:1591
    #17 0x55f4278326f8 in kvm_events_report_vcpu /home/mike/git/linux/tools/perf/builtin-kvm.c:1636

Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7ff86bf2c0c1 in malloc (/usr/lib/libasan.so.8+0x12c0c1) (BuildId: 7f2845989b820f536270e19ec47df085ae89a675)
    #1 0x55f427d40f8d in maps__get util/maps.c:288
    #2 0x55f427d7875f in thread__init_maps util/thread.c:35
    #3 0x55f427d295d8 in __machine__findnew_thread util/machine.c:563
    #4 0x55f427d29734 in machine__findnew_thread util/machine.c:577
    #5 0x55f427d29a07 in machine__process_comm_event util/machine.c:616
    ...
    #15 0x55f42783236c in read_events /home/mike/git/linux/tools/perf/builtin-kvm.c:1591
    #16 0x55f4278326f8 in kvm_events_report_vcpu /home/mike/git/linux/tools/perf/builtin-kvm.c:1636

Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7ff86bf2c0c1 in malloc (/usr/lib/libasan.so.8+0x12c0c1) (BuildId: 7f2845989b820f536270e19ec47df085ae89a675)
    #1 0x55f427d731b6 in nsinfo__alloc util/namespaces.c:147
    #2 0x55f427d73275 in nsinfo__new util/namespaces.c:160
    #3 0x55f427d78ac9 in thread__new util/thread.c:74
    #4 0x55f427d7c083 in threads__findnew util/threads.c:116
    #5 0x55f427d2957c in __machine__findnew_thread util/machine.c:553
    #6 0x55f427d29734 in machine__findnew_thread util/machine.c:577
    #7 0x55f427d29a07 in machine__process_comm_event util/machine.c:616
    ...
    #17 0x55f42783236c in read_events /home/mike/git/linux/tools/perf/builtin-kvm.c:1591
    #18 0x55f4278326f8 in kvm_events_report_vcpu /home/mike/git/linux/tools/perf/builtin-kvm.c:1636

SUMMARY: AddressSanitizer: 576 byte(s) leaked in 12 allocation(s).

Signed-off-by: Michalis Niarchos <michael.niarchos@gmail.com>
---
Michalis Niarchos (2):
      perf kvm: Fix memory leak in process_sample_event()
      perf kvm: Fix memory leak in cmd_kvm()

 tools/perf/builtin-kvm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)
---
base-commit: 7c39d92d52c28686e7ae21eb726dc008fa1b2f0b
change-id: 20260807-perf-kvm-leaks-feca9044a3db

Best regards,
--  
Michalis Niarchos <michael.niarchos@gmail.com>


