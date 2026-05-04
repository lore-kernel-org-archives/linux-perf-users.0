Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3051A2DEA9B
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883019; cv=pass; b=gQGnMaWDttoN3QJs7HOcEd6wnpWLnVXkXQVOMhmQ70I+3WsZLjQZ3Gpg4Cm6AP5SrW4Fa4adpsAjEXQpJ/2HAHmGpZvSUGwmIkRk3rvtBrSUawAGLm1l0I8LSHZJ/UN3IPu93tCQzND0oE29IxCW5wqe1TX2QDDjx6Ln4xID1B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883019; c=relaxed/simple;
	bh=2giNBq33cqgVvyhmooPQZeviEaC0mKgQDIeF20tHCVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ue+vR/v+3oKfE5WQKVR+vIpsyZWSB7TimkGbk66JlSjE8CDeadBcUEzX1NDMZXvIXiPP8vCPUqHdwRns8YkTzinQXs7oGeWlYGzOLcPqMiWKUpyESjETIVhtzOrkYnEZhkXeha+q3MNOPW1GP5L0TtKlEUzi6p5D6qat+M/fP80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uJRJSbS8; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJRJSbS8"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b46da8c48eso116505ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 01:23:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777883017; cv=none;
        d=google.com; s=arc-20240605;
        b=cRERxLpZn1WULo8Pj5+hzHhtE4itDdJDdb9UCIweBHNDkc36o47t2SiUANQaBK6b3t
         VrFogeWYZPLadKd4V0UJ1rdSwONl5peCGHEf8tPn3A9pSkkPLyb9TkEUK7+GWWDvbPE4
         rsie0Dp/yWQxO7bSyOasqdblz3dWPwymeIG41S10mBc1IkQeG1pghzlmuP9kgqdCiWbt
         rOu7cOCOMChxA2oYmjF/Zhde0An1wrDhTGJLan6MvWDNyeLvzyFGKd0oy/E7LJvtL10h
         XFX+a7OdR453iLoxFsBjf6rkrAaz23gdynPhCR2wRdmynCLmLz9andgZ2B+PiWcVLMqm
         kZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W/QUZiESPFOxaEM35q1RW/4cHOriexJyul/kNKLKBIk=;
        fh=KPhkFfI0WcTNq9LrbUQDwzBkbO+XrXGj+7Mz5lPSBi4=;
        b=EzJX4XeYTVTjL9osX//7O1V49S2N/bRCFpPBGQzallyMaeCJYROTEKLoIMDD4sl2DE
         QjmXgVQ2wjLEk4LsDw270ccmWjPU/MqRbo4rHVDgeabs29S8rjnCF7DH9NjGrsDEUrzw
         gGtKPcaQ9an2a8bfHqzrlhfErd6yxBv1tkskPsMrraWDI0nh6AGXGOgd5xN/1Pmfr7+E
         yzIyZVKS1vlBeLochb6Ql58cy0qeQ17Vhd4xXAkUK4Vlh+hwXoQgGqxY0tH7PoP+myYN
         pOk79yTWTYJFw520h9r8s+grKu30VReCeJxfvdAO4ca+SCV+rjjtOsRpzpFnL0XpWFvh
         fFNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777883017; x=1778487817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/QUZiESPFOxaEM35q1RW/4cHOriexJyul/kNKLKBIk=;
        b=uJRJSbS8P/mTXEsS2aJ3Cqb/bx8qJ5tKsCSVq+uIv2+fI3t3tHWbxpnILQTCYMcfd+
         wZ2c4f0+AT4bwKC4Sj47q00F+gT+0gHdvLJaW8y6x4AchfExb1OcFXRPC0/QoyojDFJg
         krCOMsHvs4xQNQeVL4ELywzByOmtxanLoD2J+V7adzQ3taExxp4BI/lu6x7J+Kw4Sg/j
         CdgGzEmYGZPvJzhmrqPGSbLniFXR+baLoTg0BO3r9CE5Oyz7vc9zubwa/SeOQiWfzq9G
         fWl2iAKF1J5GATIH7FLRoG8acpgsc4W3m7KTx9sCrqp6cwKqB0HWuIiB8N4BXMc7VgEp
         YA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777883017; x=1778487817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W/QUZiESPFOxaEM35q1RW/4cHOriexJyul/kNKLKBIk=;
        b=Dtz8QE3ZWuO7oC3cuXdIV8P4RDXq1tjO0gLa4y5/HqyjxQdx5n7W8hGLoczGefidVO
         7SXEWSxobyZL5n0BQo0H+tk+GPNAXrVFB5Ssqw3iXK429HE9m/qMUqaFCXBLZJP2MfTT
         JlWL6HbU1SXpYiU9swKDT9p6N7o3RLFESpLZZzvH0tRACSwiFmIbzKqsF5csf4tnccpH
         Pp7MGPWJyNTbzC2D7MJaCVRwTL2Cbgcz28oV/hyzqpmKIrlPUyyQH9XbMGsJQsWUzukB
         TLR7xn9W8p/NJP6x1MPYpWkfS1mmBOYXUyev2KktYNAOgP7TjFFoIyL7+9WKROdgJMNd
         RVYg==
X-Forwarded-Encrypted: i=1; AFNElJ+kQT4yRzr92MOw9xYmgoFBzM8SWVnjQZVNRMEYEUHJHkr6UcZNhCtchyoE9q52QnheYWSWiBbF88/mRKyhkjKH@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeu+lSTlK2TSUSgUQqxh20GwFW52ivmfu3o0yfM9mkUv6dd/a4
	iolh6M3puQccsZUAcRRi0ja66lEtGqfGlFu84xCwa3aM1jibC230U92SI4QLIvUXymaA/32Rn2+
	rj0wjKVNKVOGPqrLHcToT584s6NzS3nqtVA+SDMIB
X-Gm-Gg: AeBDiety5hh6J1UQOEYbyilT/+Ab1uk/eEXv6+Hn/SUDsuCIMjsxUt68asJ1NBrfkd0
	LZs58mrDGVs6az+mEyv1X/EJRfkhrm13JFnoTleqQBJR1RQj1eJZaMAKtejPMBGffbcxCXq1u0+
	G7TeRNWVXUoBmbVnFGcToLn0ENXC50wxybhm+pi6w4qriQgAmxGIqZRfUsN56jwqqbJIiWuUX0i
	Aw1h1ez9QXORAJPkXhxwOmli0Piq7p2p62p53h0Qt+fkoiBHfH5oggT5u2q91SSOAJRvtk/ZmPy
	QG5RdWvokzEWgQ/TD5UnpvlJK8pYnw==
X-Received: by 2002:a17:903:2990:b0:2b4:6130:f63d with SMTP id
 d9443c01a7336-2b9f25ec5cfmr3739075ad.0.1777883016563; Mon, 04 May 2026
 01:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504035125.1851720-1-irogers@google.com> <20260504072937.2103453-1-irogers@google.com>
In-Reply-To: <20260504072937.2103453-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 May 2026 01:23:24 -0700
X-Gm-Features: AVHnY4JCE3f1fecQ8aALiKqq_VyyT8MIGWwsUkuJhLJffqhjMPSdqYj3-ttjDbo
Message-ID: <CAP-5=fWE-egJJDy2N1yy=Dc_QpZaWabWgVWRj3O1fEWpP5sS8w@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] perf tools: Add inject --aslr feature and
 prerequisite robustness fixes
To: acme@kernel.org, gmx@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I found a regression when testing as root, so please ignore.

Thanks,
Ian

On Mon, May 4, 2026 at 12:29=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> This patch series introduces the new 'perf inject --aslr' feature to rema=
p
> virtual memory addresses or drop physical memory event leaks when profile
> record data is shared between machines. Bundled with this feature are two
> independent, critical bug fixes inside core event dispatching tools that
> harden perf session analysis against dynamic crashes and callchain mappin=
g
> failures.
>
> Core Feature: 'perf inject --aslr' (Patches 3 and 4)
>
> Transferring perf.data files across environments introduces a potential l=
eak
> of virtual address footprints, weakening Address Space Layout Randomizati=
on
> (ASLR) on the originating machine. To mitigate this, we introduce the --a=
slr
> flag into perf inject. Unknown or unhandled events are dropped conservati=
vely,
> while handled samples and branch loops undergo systematic virtual memory =
offset
> obfuscation.
>
> To ensure comprehensive memory and error-path safety, the ASLR tool imple=
ments:
> - Machine namespaces ('struct machines') to safely interleave host mappin=
gs and
>   unprivileged KVM guest virtual address mappings.
> - Resolves VMA split map failures (caused by overlap fixups during map
>   insertions) consistently by anchoring mappings on DSO and memory
>   invariants.
> - Guards against integer overflows in branch stack loops via
>   subtraction-based bounds arithmetic.
> - Prevents heap buffer overflows by computing safe word limits on
>   userspace stacks and dynamic hardware tracing (AUX) sizes.
> - Prevents key collisions/ABA lookups by correctly managing DSO
>   reference counts (dso__get/put).
> - Cleans up error paths to avoid inconsistent hashmap mappings on
>   OOM failures.
> - Optimizes performance by removing redundant hot-path memory
>   allocations.
> - Cleanly advances session readers past dropped auxtrace streams
>   using pipe-stream I/O skip helpers.
> - Scrubs breakpoint addresses (bp_addr) from output event headers
>   and dynamically synthesized events for pipes via a custom pipe
>   repipe wrapper to prevent unscrubbed address leakage.
> - Remaps kernel memory maps linearly to maintain secure base
>   obfuscation bounds.
> - Hardens guest cpumode lookups against corrupting host/guest user and
>   kernel mapping boundaries during sample fallback searches.
> - Synchronizes ksymbol map tracking invariants using precise VMA
>   offset math rather than raw addresses to prevent unique base leaks
>   on every function symbol.
> - Blocks trailing heap padding byte data leakage vectors in userspace
>   stacks and AUX tracking frames via targeted tail-word clearing.
>
> Verification is reinforced in Patch 4 with a new comprehensive POSIX shel=
l
> suite ('inject_aslr.sh'), hardened against SIGPIPE signal exits with stre=
am
> consuming awk loops and robust 'set -o pipefail' assertions. The suite in=
cludes
> a new dedicated scenario validating pipe stdout injection attribute stabi=
lity.
>
> Prerequisite Bug Fixes (Patches 1 and 2)
>
> During development, two core event delegation issues were identified and
> resolved to prevent crashes and data-loss during analysis:
>
> 1. perf sched: 'timehist' registers standard MMAP, COMM, EXIT, and FORK s=
tubs,
>    but completely omitted registering MMAP2 callbacks. Because modern env=
ironments
>    output maps primarily via MMAP2 frames, this caused timehist sessions =
to silently
>    drop shared library mappings, causing dynamic callchain symbol resolut=
ions to
>    fail. Patch 1 corrects this by properly registering perf_event__proces=
s_mmap2.
>
> 2. perf tool: Patch 2 fixes missing copies of schedstat callbacks inside =
delegated
>    wrapper tools (which caused segfaults on NULL stubs) and properly init=
ializes/copies
>    the 'dont_split_sample_group' grouping parameters to prevent stack gar=
bage from
>    triggering silent non-leader events drops during split deliver streams=
.
>
> Changes since v3:
> - Feature integration: Pass a dedicated 'perf_event__aslr_repipe' callbac=
k to
>   perf_event__synthesize_for_pipe() to scrub synthesized breakpoint attri=
butes.
> - Feature core: Loop through and scrub event evlist breakpoint attributes=
 right
>   before writing file headers in __cmd_inject().
> - Feature core: Linearize kernel map base obfuscation and remove redundan=
t pgoff
>   delta adjustments that leaked kernel layout calculations.
> - Feature core: Fix host/guest cpumode mappings in sample fallback lookup=
s.
> - Feature core: Sync ksymbol tracking keys onto VMA offset invariants.
> - Feature core: Zero out trailing padding word bytes in user stacks and A=
UX blocks.
> - Validation suite: Add 'test_pipe_out_report_aslr' validation case.
> - Validation suite: Upgrade kernel report checks to strict sorted line-by=
-line diffs.
> - Style: Wrap all commit description lines to under 75 columns and fix co=
de formatting.
>
> Ian Rogers (4):
>   perf sched: Add missing mmap2 handler in timehist
>   perf tool: Fix missing schedstat delegates and dont_split_sample_group
>     in delegate_tool
>   perf inject/aslr: Add aslr tool to remap/obfuscate virtual addresses
>   perf test: Add inject ASLR test
>
>  tools/perf/builtin-inject.c           |   52 +-
>  tools/perf/builtin-sched.c            |    1 +
>  tools/perf/tests/shell/inject_aslr.sh |  459 ++++++++++
>  tools/perf/util/Build                 |    1 +
>  tools/perf/util/aslr.c                | 1161 +++++++++++++++++++++++++
>  tools/perf/util/aslr.h                |   10 +
>  tools/perf/util/tool.c                |    6 +
>  7 files changed, 1689 insertions(+), 1 deletion(-)
>  create mode 100755 tools/perf/tests/shell/inject_aslr.sh
>  create mode 100644 tools/perf/util/aslr.c
>  create mode 100644 tools/perf/util/aslr.h
>
> --
> 2.54.0.545.g6539524ca2-goog
>
