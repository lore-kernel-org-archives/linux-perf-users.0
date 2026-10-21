Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792600634;
	b=lA1t+uqnEf0kIi/XaShCWyFWzJwdv2ptcDM9nviuwq0cQSkEj7fvm/T0LFWAF0ozkmOJ
	 VSGfITwNHTDWbOFnjTDEglzKsgO190V4ITUhpKiA/Kpo2ViWE1Vx1DEvOX/nMcObCSreM
	 nEv7GTqJiFsV83bDds/j97BaakjnlxHdFlmYnXEk6MGjeg9fhXAdUC2MJ7JcEGsd5KWK3
	 5Y6MdFunZScxoAVelasOBh2sWIzyZgH7tVYdTz1ALQqCvaEFaz7KA3dMwX67z4VTkOihm
	 Vz7hz9b0YXX9AfzPfK/3BkGftJmBX4MnPV5FABNK5V5P6HjREd5KLlXm/UlcT48znLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600634;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zP9Muf+MYilb4BYiCx/EAnDIG/oBcn6Y/HsIeFeiBIA=;
	b=rM/4r+WB2+eoqDsn7DFQUk9wPHKPHpkXyOPqO1/uDXdb0DFuK4KzGf1sI3l7d8yYurnL
	 OY7xM4ZO8J8cKKc1HhcDkDjzL7KXuN+PMxsoBKOQGQKRXD1l2e75CAruGmG/kzcSZg1Z1
	 WTUwHMdjgFUe96IjihI+/h9WS3zfsfPR6CfKwPYQ24dNyrWt4NIr9tNHxZImdF6pbhrO4
	 yeeqj51MxlfuFFDmEuZZQ7dt1vacGQxkpbWs401lv097+Ur2FrqvOTZXEeqMw7Pz6vD2Q
	 sDLdqWaavzxbzCgAR73/HKOumwW1zf6UeEXtkcJR6uWwFMEiLyscPRxI/XjapK+eloQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Xgjr1+Sc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02368606A326
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 16:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02368606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Xgjr1+Sc
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2db33db4de9so77115ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 09:37:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792600633; cv=none;
        d=google.com; s=arc-20260327;
        b=bHIhpyMroD3qlJ+ZK73gM2CcxvLB+sEJT05XD2RZYz2NY/KSSaoPBV36K1CkYghT6e
         smmO+NRgHTrQWcHmABolTnbqftf7+MeJWyIbOpRJYNT8cqjUsBKAWzi3/NjwGoy/b3YF
         qLvu4m57BNTgB9vBlfXK9VN8N0TS9xzOACqvvdiGE7/G7AXQ1MnXbnV1UG9NG4nSpdzr
         UokKY2TWsI7sbBSelDDhWypgKXYdoSuQw+/4R5BvB1jd/O+xCqsAQVKtvpe+joI5sCjl
         R+/+ew7wWyBSxamKZpzpZ1f5exN+IQN3rwTdXAYbQ9aHJjb0FjLBQoCfT6Cdyh8cnrBQ
         //4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zP9Muf+MYilb4BYiCx/EAnDIG/oBcn6Y/HsIeFeiBIA=;
        fh=Qu6sEgJyNiImy7Q3ayVYCRhFnLtYSfURInuzJ1Elqv0=;
        b=i+l+GZEmbVwUplifpbyVfiJ4zJp7l9smo+TksrIVL3kHruwhSlG0SC9dBP3CeSa30h
         qJsLL+/9VY7jf7l2EPnWtmbTqpSHwAIOofaDyR8lrXBDccxGQgpc5xnzPBU1C6G3JZAz
         DdGSjzBFmPUBMgcOTExD75a3UZSHh+HzwfSGshnxEb43qLklJLOG2s1DBtR0TRv13yG3
         JcHBRqkUPS4I6QgCKaRZ8ynPYJlMN2sZoaOJq5ww8ZdURoUaJIV0bCT8J8WXEtu1Q1ce
         M12dTHWseCdZ3beb7wtqjznmTM5sWS/zZMsQmWv/TjzlRP2CgEfrKlJX7BKpUUwbK4H5
         Mmpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792600633; x=1793205433; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zP9Muf+MYilb4BYiCx/EAnDIG/oBcn6Y/HsIeFeiBIA=;
        b=Xgjr1+ScQwXxdZIiMN5iBW3+RDno/ba+XzBPiYT+g79T2NLYiIq/wBYM+/3vWjYyRU
         iiIAP63AZVOwaCmhv7+Xxf7Wh2RWolIg80SzhhxoAkxtDRP5V6urR1ZlOXrdU8wPCxAb
         TdQDNkL/3bOVbTVgfyMjpY9IwJ9Nyxem9Xslmj67T0EArm2pni++Q3fmHkv/BSStDYy7
         1fzFOZ/L/gf086+EFbCh+k7Q0c3tx8jbrF+MtNz7gzmzbCgx0OzCTt5psv7/qq5g+BGL
         /fQiDDFVjRzr+/Kc0U4vhM5sJNnEZELAh7VCyO5B3WVM2D7I1wS+s8aXlAdnbJ70/rGe
         ayJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792600633; x=1793205433;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zP9Muf+MYilb4BYiCx/EAnDIG/oBcn6Y/HsIeFeiBIA=;
        b=vRww4RT26m8j0kuHY5HTVZBgBaL1OVat69DMNIGqfEIrXMS23q5mGdWl0akRCT3lx7
         LIqhYfylUOLylmk5qSqilJfJTlDPPysHdyIAc0gQ2qtSkZTkboI8ihpTum2zZ3BeJvdo
         WdWqit04DA3pXoBLhFlu6IEKSMf+PDhx9QZlQRIRSVNioyqU0cVk7FiAiYHt2yCf+zEr
         bzqPFzFSzWcp6uiglVIMixue4qe7ZsTgzkmFnqHtAtawVyTZqP+xwqEgnwNu6kiAjfHc
         0sz48h+UnIiJcKgMZC9HJAtW5Pd9dj5tojtZNnnBJRZOYAZ1vU2/gnJiOq/S1sHDxktP
         PpmQ==
X-Forwarded-Encrypted: i=1; AKwUvBwSE674n9VoToDPjihwzKBOLnOWAk2OH+sndUJcNRLAStcufzUsLj2eZhGcUwCneDGqThlday/e2ykjJnU3HthX@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9QV/nS7puQR+mKcJcCmq9eZQGwRIK8c723g2Aw150WFzWYK5D
	yJ2ZMF0iwA4TyiYrwSwObmSsr8xC1cXr5DbR5s34oMB26w1FZCtalJBlqgFs/JzRbj7kdkAuzgp
	eUXlsF5w0zcmhszCaV1rNnHyWHip9eTyKZpSVJtTT
X-Gm-Gg: AYBFou2Qa1sSCwdIoViB9qmRLGl+ER64GyaAFsmM+oYDagbmPqvB/1RMPoz8TTfTXuj
	TkM4vjKQxxVZYdb7VRnZ+w8073A9aqdWZEK1Rxx5xWYhAR81y/LGLNtIB4M9dhl5NkESz9VYEe5
	6FQsiyD+sm1Cnk7ubzn6Y/9tXRjMFE3+5D6zx+hnUmsTSQcrMOL1NO32fSUHBo6bdRoylBZ0LXx
	L1Nxdr3edEqxM2pyDc8qDaQ/SMme7PkFgSZT52X8BSXiFjQvwGXLaoQ6oUgx//tGV7cN0NGgHSU
	ZG5wikYjOGJCENgUz1ZRl0wOLi06THL7ZpYeIITP0XZFIZ+oow8MEOKbpBz/CT8ZRFdsV7bcTVo
	+xIUJMKNuf10beS49MypN/9uFY7bK83OepJ74ek8823dZAUo3h6iRO7orEfYwnuXxcA==
X-Received: by 2002:a17:902:e84f:b0:2e6:344:7bc4 with SMTP id
 d9443c01a7336-2ea1e4ab20emr8909755ad.15.1792600632440; Wed, 21 Oct 2026
 09:37:12 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021023337.809936-1-atomlin@atomlin.com>
In-Reply-To: <20261021023337.809936-1-atomlin@atomlin.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 Oct 2026 09:36:59 -0700
X-Gm-Features: AclHuK_4kWLSrTFUgLHc3Agc7TGhfERibyWzUe_HPiiUS-OwrbU1tyOk_YippmY
Message-ID: <CAP-5=fXx-0OmT4q0Y_nMGVQ35zOKaJ+bSLgHBvGJ7CFZVxL1cQ@mail.gmail.com>
Subject: Re: [PATCH perf-tools-next v9 0/6] perf ftrace: Support inlined
 functions and display enhancements in function graph tracer
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 7:33=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
>
> The Linux kernel's function graph tracer operates at the machine
> instruction level via compiler instrumentation
> (-fpatchable-function-entry), recording entry and return events for
> physical function calls. Consequently, functions inlined by the compiler
> are invisible in the resulting call graph, as no discrete call or return
> instructions are emitted for them. While technically expected, this
> omission frequently obscures the logical execution flow when analysing
> kernel subsystems heavily reliant upon inlining (such as the scheduler,
> memory management, locking primitives, and RCU).
>
> When the kernel is configured with CONFIG_FUNCTION_GRAPH_RETADDR=3Dy, the
> funcgraph-retaddr trace option records the caller's return address on eac=
h
> function entry, manifested in the trace stream as a comment
> (e.g. /* <-wake_up_new_task+0x1d1/0x3e0 */). By interrogating DWARF debug
> information from the kernel image (vmlinux) utilising libdw, perf ftrace
> resolves this return address to its inlined callchain and synthesises the
> intermediate inlined frames directly into the streamed call graph.
>
> This patch series addresses these challenges through six focused commits:
>
>     1.  Stack frame optimisation in __cmd_ftrace()
>
>         Replaces the 4096-byte stack array in __cmd_ftrace() with
>         dynamic heap allocation alongside struct strbuf streaming,
>         reducing the stack frame footprint by over 96% (down to
>         ~160 bytes) whilst ensuring complete line-delimited records,
>         explicit NUL termination, and robust error unwind and EOF
>         handling.
>
>     2.  Return address comment filtering
>
>         Introduces ftrace_parse_retaddr() and ftrace_filter_retaddr()
>         with --filter-retaddr and --graph-opts filter-retaddr to strip
>         caller comments from trace output, accompanied by an initial
>         unit test suite in tools/perf/tests/ftrace.c.
>
>     3.  Preparatory vmlinux lookup helper
>
>         Introduces vmlinux_path__find() in tools/perf/util/symbol.c and
>         symbol.h to search standard vmlinux paths and return the first
>         accessible kernel image, providing a generic helper across
>         tools/perf and avoiding hardcoded access() checks in tests.
>
>     4.  Inlined function call graph reconstruction
>
>         Introduces --inline and -k/--vmlinux, dynamically synthesising
>         inlined frames marked with /* (inline) */. Correctly matches
>         bare closing braces when funcgraph-tail is disabled, clamps stack
>         depth to prevent indentation drift, and expands the automated tes=
t
>         suite to verify inline resolution, comment filtering, and stack
>         saturation recovery utilising vmlinux_path__find().
>
>     5.  Execution duration suppression
>
>         Introduces --graph-opts noduration (accepting noduration=3D[0|1])
>         to toggle the kernel's funcgraph-duration tracing option,
>         omitting the duration column when the user is focused purely on
>         call graph topology and inlined hierarchy. Rejects noduration
>         when invoked under 'perf ftrace profile'.
>
>     6.  Extraneous function filtering in function graph tracer
>
>         Introduces userspace call graph filtering when targeted
>         tracing (-G or --graph-funcs) is active. Suppresses transient
>         unrelated entries arriving before filter activation as well
>         as detached callee trees (such as ring-buffer wakeups)
>         originating outside the target hierarchy. Dynamically resises
>         the synthetic call stack to eliminate saturation edge cases and
>         accurately suppresses detached subtrees without orphan exit name
>         collisions.
>
> Synthesised inlined functions are rendered with an explicit /* (inline) *=
/
> annotation at both entry and exit:
>
>     # tracer: function_graph
>     #
>     # CPU               FUNCTION CALLS
>     # |                 |   |   |   |
>      0) enqueue_entity() {
>      0)   update_cfs_group() { /* (inline) */
>      0)     calc_concur_shares() {
>      0)       tg_cpus() {
>      0)         cpuset_num_cpus() {
>      0)           class_rcu_constructor() { /* (inline) */
>      0)             rcu_read_lock() { /* (inline) */
>      0)               __rcu_read_lock();
>      0)             } /* rcu_read_lock (inline) */
>      0)           } /* class_rcu_constructor (inline) */
>      0)           cgroup_e_css();
>      0)           class_rcu_destructor() { /* (inline) */
>      0)             rcu_read_unlock() { /* (inline) */
>      0)               __rcu_read_unlock();
>      0)             } /* rcu_read_unlock (inline) */
>      0)           } /* class_rcu_destructor (inline) */
>      0)         }
>      0)       }
>      0)       __calc_smp_shares();
>      0)     reweight_entity();
>      0)   } /* update_cfs_group (inline) */
>      0) }

Lots of tests, Sashiko is happy and a useful feature!  I'm not sure
"--filter-retaddr" is the best name for an option to disable comments
on return addresses, but naming things is hard.

Tested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian


> Changes since v8:
>
>  - Preserved funcgraph-retval return value comments when filtering
>    funcgraph-retaddr comments (/* <-caller ret=3D0x0 */ ->
>    /* ret=3D0x0 */) in ftrace_filter_retaddr()
>
>  - Enhanced vmlinux_path__find() helper in tools/perf/util/symbol.c:
>     - Avoided redundant memory allocation in vmlinux_path__init() when
>       vmlinux_path is already initialised
>     - Ensured symbol configuration is initialised via symbol__init() prio=
r
>       to path resolution
>     - Guaranteed vmlinux_path memory cleanup by invoking
>       vmlinux_path__exit() unconditionally in symbol__exit()
>
>  - Tracked raw (pre-inline-expansion) indentation on synthetic stack
>    frames, ensuring bare closing braces ("}") are accurately matched
>    against corresponding non-inlined frames without indentation
>    distortion
>
>  - Unwound stale frames on untracked caller entries (caller_idx < 0) whos=
e
>    raw indentation is greater than or equal to the new entry, and closed
>    trailing open inlined frames resulting from dropped exit events
>
>  - Pre-bound single-PID tracing across all CPUs in
>    perf_ftrace__setup_inlines(), ensuring consistent synthetic call stack
>    tracking across CPU migration when kernel context-switch banners are
>    suppressed (verif_pid prev_pid =3D=3D -1)
>
>  - Strengthened error handling during DWARF/vmlinux initialisation in
>    perf_ftrace__setup_inlines(), checking load return codes, emitting
>    diagnostic warnings, and safely freeing ftrace->machine on failure
>
>  - Recognised interrupt/IRQ entry and exit markers ("=3D=3D=3D=3D=3D>" an=
d "<=3D=3D=3D=3D=3D")
>    alongside context-switch markers under --graph-opts noduration,
>    preventing non-function lines from corrupting function column detectio=
n
>    or popping active stack frames
>
>  - Handled leaf function lines with trailing comments
>    (e.g. funcgraph-retaddr or funcgraph-retval comments) in
>    parse_func_duration() for 'perf ftrace profile', ensuring parentheses
>    are stripped cleanly and leaf records match non-leaf entries in durati=
on
>    tracking
>
>  - Preserved tracked ancestor frames on cs->stack across dropped target
>    root exits by verifying caller provenance
>    (caller_idx < cs->target_root_depth) before checking indentation bound=
s
>    in ftrace_check_target_caller()
>
>  - Purged stale non-target frames below target root upon target root entr=
y
>    when caller_idx < 0, preventing unrelated ancestor frames from
>    prematurely terminating subsequent target calls
>
>  - Prevented cs->orphan_depth lockouts when both an orphan exit and
>    enclosing target root exit are dropped by resetting cs->orphan_depth o=
n
>    any line at or outside target root indentation
>    (leading_spaces <=3D cs->target_root_indent), and allowing ancestor ex=
its
>    to fall through to match frames on cs->stack
>
>  - Preserved interrupt/IRQ markers inside active target callgraphs while
>    suppressing those outside target filters under -G or --graph-funcs
>
>  - Fixed test_stack_saturation() to avoid premature frame unwinding,
>    ensuring depth clamping and recovery are tested as intended
>
>  - Expanded automated test coverage in tools/perf/tests/ftrace.c:
>     - Added test_context_switch_handling() for CPU migration and task
>       tracking
>     - Added test_column_layouts() covering standard, verbose, and
>       noduration formats including IRQ and context-switch markers
>     - Added regression tests in test_graph_target_filter() covering doubl=
e
>       dropped exits, ancestor frame preservation, leaf duration parsing,
>       and deep orphan recovery
>
>  - Link to v8: https://lore.kernel.org/lkml/20261018023753.584873-1-atoml=
in@atomlin.com/
>
> Changes since v7:
>
>  - Rebased onto latest perf-tools-next/perf-tools-next (commit 1c90f0a3c8=
a1
>    ("perf kvm: Cast tv_usec to long to fix build on MIPS 32-bits"))
>
>  - Link to v7: https://lore.kernel.org/all/20261018021346.582845-1-atomli=
n@atomlin.com/
>
> Changes since v6:
>
>  - Expanded the series from 5 to 6 patches by introducing a standalone
>    preparatory commit ("perf symbol: Introduce vmlinux_path__find()
>    helper") in tools/perf/util/symbol.c and symbol.h to locate accessible
>    kernel images via configured vmlinux paths, replacing ad-hoc
>    access("vmlinux", R_OK) checks in unit tests (Ian Rogers)
>
>  - Explicitly included stdio.h in tools/perf/util/ftrace.h to declare the
>    FILE type for ftrace_process_fgraph_line(), ensuring clean compilation
>    under musl libc and non-glibc environments
>
>  - Prevented name collisions between orphan callee exits and active targe=
t
>    frames in ftrace_process_fgraph_line()
>
>  - Allowed dropped-orphan exit recovery on closing braces only when the
>    exit explicitly names the target root function itself, ensuring that
>    lost orphan exits do not swallow the target root's exit while protecti=
ng
>    intermediate callee frames from collisions
>
>  - Replaced the fixed-size array in struct ftrace_task_state with a
>    dynamically resized stack grown via realloc(), completely eliminating
>    cs->overflow_depth and its associated failure modes:
>     - Fixed skipped filter teardown when a target function begins at the
>       stack limit, ensuring standard teardown runs upon root exit and
>       preventing subsequent sibling functions from leaking into filtered
>       output
>
>     - Fixed orphan filter bypass during deep call stacks by preserving al=
l
>       caller frames on the stack, ensuring unknown callers (caller_idx < =
0)
>       are accurately identified as orphans and suppressed
>
>  - Link to v6: https://lore.kernel.org/all/20261016040310.482876-1-atomli=
n@atomlin.com/
>
> Changes since v5:
>
>  - Prevented call stack desynchronisation on dropped orphan exit events b=
y
>    clearing orphan_depth when a named exit matches a tracked frame or an
>    entry descends from the target callgraph
>
>  - Fixed premature target filter termination on child exits by capturing
>    cs->target_root_depth after unwinding stale frames above the caller
>
>  - Ensured synthesised caller inlines above cs->target_root_depth are
>    cleanly closed upon target function exit before resetting filter state
>
>  - Prevented legitimate deep calls exceeding FTRACE_MAX_STACK from being
>    falsely dropped as orphans by checking cs->overflow_depth
>
>  - Expanded unit tests to cover dropped orphan exits, target root depth
>    synchronisation after stale siblings, and deep call stack overflows
>
>  - Provided support for glob pattern matching with -G or --graph-funcs
>
>  - Link to v5: https://lore.kernel.org/all/20261015011155.414667-1-atomli=
n@atomlin.com/
>
> Changes since v4:
>
>  - Handled non-fatal EAGAIN, EWOULDBLOCK, and EINTR in __cmd_ftrace()
>    polling and draining loops to prevent premature session termination on
>    non-blocking reads or signal interruptions
>
>  - Eliminated an unused local variable endptr in ftrace_parse_retaddr() b=
y
>    passing NULL to strtoull()
>
>  - Prevented stack buffer overflows in make_blank_prefix() by clamping th=
e
>    blanking loop bounds and end pointer to the destination buffer length
>    when processing trace records with exceptionally long prefixes
>
>  - Tracked call stack saturation with overflow_depth to prevent untracked
>    function exits with bare closing braces from prematurely popping track=
ed
>    frames from the parser stack on deep call chains exceeding
>    FTRACE_MAX_STACK
>
>  - Ensured stale non-inlined callee frames resulting from dropped functio=
n
>    exits do not block inactive inlined frames from being closed upon
>    subsequent entries by unwinding the stack down to caller_idx + 1 +
>    common
>
>  - Fixed filter state not resetting for targeted leaf calls when --inline
>    is active: synthesised inline frames inflated cs->depth beyond
>    cs->target_root_depth, causing subsequent sibling functions to be
>    falsely classified as detached orphans and bypassing inline unwinding;
>    resolved by tracking target root entries (is_target_root), explicitly
>    unwinding all synthesised inlines, and resetting filter state upon lea=
f
>    completion
>
>  - Expanded unit test coverage to verify recovery across dropped exit
>    events and bare closing braces, and to verify that targeted leaf calls
>    with synthesised inlined frames properly close inlines and reset filte=
r
>    state
>
>  - Link to v4: https://lore.kernel.org/lkml/20261014161457.373253-1-atoml=
in@atomlin.com/
>
> Changes since v3:
>
>  - Explicitly rejected the noduration option when invoked under the profi=
le
>    subcommand, since profiling inherently requires function duration to
>    compute timing statistics
>
>  - Fixed make_blank_prefix() clobbering the comm-pid column in verbose mo=
de
>    by searching backwards for the preceding "|" delimiter, and returning
>    early when graph_noduration is active
>
>  - Fixed filter state not resetting for targeted leaf calls at non-zero
>    call stack depths by checking cs->depth <=3D cs->target_root_depth and
>    clearing cs->target_root_depth, preventing subsequent non-targeted
>    sibling functions within the parent frame from leaking into trace outp=
ut
>
>  - Expanded unit test coverage to verify comm-pid preservation under
>    verbose and verbose-noduration inline modes, and to verify that target=
ed
>    leaf calls at depth > 0 properly reset the target filter state.
>
>  - Link to v3: https://lore.kernel.org/lkml/20261012003016.263063-1-atoml=
in@atomlin.com/
>
> Changes since v2:
>
>  - Expanded the series from 4 to 5 patches by adding a dedicated commit
>    ("perf ftrace: Filter extraneous functions in function graph tracer") =
to
>    enforce strict target callgraph boundaries when -G or --graph-funcs is
>    specified
>
>  - Suppressed unrelated top-level functions that leak through the transie=
nt
>    tracefs filter initialisation window before RCU synchronisation
>    completes
>
>  - Filtered detached/orphan calls from appearing as nested children withi=
n
>    the target graph by validating caller return addresses against the
>    active target stack
>
>  - Tracked nested orphan scope depth (cs->orphan_depth) to cleanly suppre=
ss
>    child calls and closing delimiters of detached subtrees without
>    desynchronising the target stack
>
>  - Added automated unit test coverage in tools/perf/tests/ftrace.c
>    (test_graph_target_filter()) validating top-level suppression (both wi=
th
>    and without --inline) and detached orphan wakeup suppression
>
>  - Link to v2: https://lore.kernel.org/lkml/20261006232756.65620-1-atomli=
n@atomlin.com/
>
> Changes since v1:
>
>  - Modularised the implementation into a 4-patch bisectable series rather
>    than a monolithic commit
>
>  - Resolved potential infinite loop on poll() upon trace_pipe EOF
>
>  - Fixed stuck call stack frames when funcgraph-tail is disabled by
>    supporting bare closing delimiters matching LIFO stack frames
>
>  - Prevented unbounded indentation growth on deep call trees by clamping
>    inline expansion and synchronising cs->inlined_depth to frames
>    successfully pushed onto cs->stack
>
>  - Added dedicated unit tests covering bare closing braces and stack
>    saturation recovery
>
>  - Refined option documentation in perf-ftrace.txt
>
>  - Link to v1: https://lore.kernel.org/lkml/20261005211518.26786-1-atomli=
n@atomlin.com/
>
> Aaron Tomlin (6):
>   perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming
>   perf ftrace: Support filtering return address comments
>   perf symbol: Introduce vmlinux_path__find() helper
>   perf ftrace: Support display of inlined functions in function graph
>     tracer
>   perf ftrace: Support omitting execution duration in function graph
>     tracer
>   perf ftrace: Filter extraneous functions in function graph tracer
>
>  tools/perf/Documentation/perf-ftrace.txt |   20 +
>  tools/perf/builtin-ftrace.c              |  212 +-
>  tools/perf/tests/Build                   |    1 +
>  tools/perf/tests/builtin-test.c          |    1 +
>  tools/perf/tests/ftrace.c                | 3271 ++++++++++++++++++++++
>  tools/perf/tests/tests.h                 |    1 +
>  tools/perf/util/Build                    |    1 +
>  tools/perf/util/ftrace.c                 | 1634 +++++++++++
>  tools/perf/util/ftrace.h                 |   28 +
>  tools/perf/util/symbol.c                 |   38 +-
>  tools/perf/util/symbol.h                 |    2 +
>  11 files changed, 5180 insertions(+), 29 deletions(-)
>  create mode 100644 tools/perf/tests/ftrace.c
>  create mode 100644 tools/perf/util/ftrace.c
>
> --
> 2.55.0
>
