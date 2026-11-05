Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793912211;
	b=QQdngN8twvPIbRH3wvAIh9WrAGUykeICaBvyRZKHUbFXn3dJri3lfJ8oQpHyX4SH2EjI
	 kbUR1nbYOEou77qqf4FGltGuTh8Ho+qBiVQ+rOKVkdJr6tyAbXqsbpJ/sh1qq1rSf5Zp7
	 FtUntpc0IyxqjRO7Z9HTK1a8wLcia6X6OrUWMr8L6irS2VAuWNhoRJVY+6zFljJddtFMu
	 EQqLTLVuKluJjrbeY7/5HBVpxWIvFm/ubLMm2DqmZNNHGN8704ZYf9ipoZRJsM7pnEH0g
	 Pi9AhZ7rI4BIbuWCBvFPSY/dAz6+Rt29f6zTvXmLMa7hyqR+b4QPY3XIe6J6lTPWyKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=WGoZuMVGY05nnj5jEcHY1A/dTWiWvBXOjK8y3tFjCB0=;
	b=TZ8blbQOY2o9825Y1HpYom/N9kzRGR+cNCP+9et1YcpVfBC3dX2oBNui9gkzpfT0ytn/
	 8A0FQs8I765bkKG/rraHDL+2GbOvqxBT7BYkPkZJhMUTphYlgUoVgHQmVYgYv/VY09BJw
	 3FHUmnpFp+ylkOwMjoD08jWLImL8sj1BuNhgmhJfyLTutIJJFojmMyqYee0bhSDk1zWTO
	 W4e9l0Oqc28Sxxx91ms/jmdA16qcPuDomag29Y9LBVIF5HU/FlihO8IRSzIpgfmpZSXz3
	 XnMFQbtvbSRWwAj5BiRF9FHaCQLfmYT7MmadOyBDdxfT+4CG98RgdapORpEPa6wn+jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sPalGy8H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED13C606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 20:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED13C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sPalGy8H
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c247f6687dcso401835466b.2
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 12:56:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793912209; cv=none;
        d=google.com; s=arc-20260327;
        b=l2pFCPcEzHaT6cIJd391D7YsbHUqsoPs16TiYu4kqOP7DisBeBmQyozSCKW3GN68Cs
         aZq8LxWks0pyALF5Q1QToXmpF1cXP2d3W+PQik3aEue1HMTCvbMve8uxyXeT3DgNiWE3
         hn9KJGys7WadLVm5qIhxglndoCuDhmQrqSP0cIUVjgt035ba859vUbjslhAjM8g0lJYk
         KmH7NChTP3coDgFcXX4ZPLr1hVW0eDGeNtNzq8ovO1z3ufW7k91TxFE1GyxrPiATVFPb
         D8h5fde4sA9yeZHXEW1cV2sR8VsccnL014EKv0B1XgS3yza0PcJP5CEBjHXIx6ScVdsa
         nM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=WGoZuMVGY05nnj5jEcHY1A/dTWiWvBXOjK8y3tFjCB0=;
        fh=nKvoEnGxxMm/J/asxJcAGFd8iUYrGaewxDPY3lJsKqY=;
        b=PywddVKiLqYpLQMEH35XiSrV2EEfpy8+jo8ZhvVcVQ9xiRSnHsYQDCnq1C6DL75xnO
         BTOjskdsIJ+YPvKmS37zYwJhH0LFB+Gx6U/6wyX4CPWm7DsrUmaKtj4wYdGFIF5Oti43
         LqcKtr0nAArNoHC7QQEmZIVLdAmJypuXEt0qYExLI2nh/WVoyZrFAcDLO5dd/xHyE+/K
         Wv3KBQyBlvNENysIh0MX/53LV7CQzKDXqQOr9PFotvShJG1IUFdn2NLAxC0kWJ1zwQiC
         aDoi/cPZmLLkRuf+uqyE+p966EBLxAoBbIow7O959L5tqMhOzu2U36f7qtWkrKX8mVo2
         F6tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793912209; x=1794517009; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WGoZuMVGY05nnj5jEcHY1A/dTWiWvBXOjK8y3tFjCB0=;
        b=sPalGy8HN0bt3CXnPnn1r4oGGGYlfiBDIrG5RKaUO7cNq1Fm5zfbvtIBTWqC9u6nqr
         5niOXQ0HPD4u9+TVhmbCS/KjNsHAmv3B9pKVOj/wO3aWOjA0QnJjWE5mAJEZoEsg1KOo
         FsgYtfUVz0OIXazNGeSblFwZ+OvjRV4uPjtc7pRAst3t9Tc0gAXaL+rNiozp8XfCGAfc
         zGDYJteKNGDV237yc42QUO6EiMBGx+M7OsVGzXtoAK+mIIevWbJpfYaOfCGYr/taGxox
         OFfYAGVulSs6B/MYGjwP/gfZ/0eMEXllc8/mk4EBzzd1NcNW7vGE+M+TYlaqr2Dp9n7V
         OJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793912209; x=1794517009;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WGoZuMVGY05nnj5jEcHY1A/dTWiWvBXOjK8y3tFjCB0=;
        b=Q0ZXCsV9GNeTCbDobJyW+9RwZEhLUqBIApi6O3WMWPCHuW8MZqLqJlqaIn4nvggzci
         F881Jtl6/ARoNYKikJrNzFp/aW4lIl5TNlqVzVi7T9eDNGuxQXuzhkUdM74IBvspkLsQ
         lv2IqnsmvZwA3wn3081Q1OIuRqzvPZQFyNcTTb4x62P0/4TcPSFSvVlAy5MREK3OOM6d
         0yeGbx391W9gVL0lmlzb8XVLPm0cVPUEX1Ir8425XZ/LWKe6XtfsNPbo01MivCCL4bU5
         r0pQDfjdnaSQIrm09XW/E0fDKh/+pc3sUvk0JH+McOzz3lj15oJX4/t+Mka4GlYWBs+t
         lizA==
X-Forwarded-Encrypted: i=1; AKwUvBygAyIejKQO0mh33VRigQovUieiRgAtlDnIBPYtN2XNfDwhTEEFeezoV1w98AH+RyCzN4OQKwzVfs/Xc65R2nmh@vger.kernel.org
X-Gm-Message-State: APuU4Z9JBHWF3rNAyV7Vv4JrBaQmyoX+zZzRsVykDnr+RiCROLyFdXJK
	4KtBBVh0w/6WShKN8p3UX3N2EI8p6PQtgK5FHsEYEiAMvfWfwGhH6ldDcN5eochg0RGrw/iPI71
	Nxu6LkVsDAmiWPSKEZUOxL6RU5nGRbKjlngdhwQY=
X-Gm-Gg: AYBFou0/fqsfxvu38sKIHtVHU1pa2OEXG4SR6N84Y7T1f78tjUVdWv7JhRIweDkYSh4
	88UmNlF0I3VuhxSFBbfUMJ1KW1Du+mIFnptqMKaYTjy66/cpN5w0ohcji9OUE4DcdDRrxazniHL
	12gjOC92jtqASYtjWI9XtPCUwHwGkch2U+gLrJvYC90MDk66A5GmrshwGlxezfnEguJL3/okEb+
	UptfRzzOlDWDeKUl+EBPOHJu6BGGrgcfZgTAXT9N4ygB20QuNvPoFi//I4oe5lGCwKjLCPQ+Fj6
	UVrq4uAEFkX2mpuNCwE5mqoC3zjrw3AG1XEr43ahePedz6rjf0c3EukNpjAkt99SHLkL9d8DMjj
	5d6vNmu5Alxo1ENOoxaag5nB+0jZxNp4Vz14Tcg==
X-Received: by 2002:a17:906:ef0a:b0:c46:b9b0:8e8f with SMTP id
 a640c23a62f3a-c4d355a3d07mr46072266b.41.1793912209080; Thu, 05 Nov 2026
 12:56:49 -0800 (PST)
Received: from 374130946952 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Nov 2026 12:56:48 -0800
Received: from 374130946952 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Nov 2026 12:13:46 -0800
From: Joshua Warren <joshua.s.warren@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 5 Nov 2026 12:56:48 -0800
X-Gm-Features: AclHuK9lvkZRlRsFRNuSAFqcvnK6plKLOjHdTWawATlg660tQrYN_fDRv4dGBfs
Message-ID: <CADjP6_CC-jv6nyEHaLj=Z0eyjubOJZuiKESqszW3LgTJTTQ_Aw@mail.gmail.com>
Subject: [PATCH 0/2] perf/core: fix perf_mmap alias charging and the
 redirected-event AUX mmap
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Two perf mmap() fixes in kernel/events/core.c.  Both defects are
present on torvalds/linux master 05441d697f7f9a927264f4058cbbc6a03dfcac9d,
the tree this series is based on.

Patch 1 stops duplicate alias mmaps of the ring buffer and of the AUX
area from charging the perf mlock gift (user->perf_mlock) twice: the
charge is taken once, at first allocation, and released once at final
close.  The excess was never removed, and perf_mmap_calc_limits()
clamps the recorded perf_mlock at the budget, so an inflated counter
pushes later allocations over into the RLIMIT_MEMLOCK side of the
accounting.

Patch 2 handles the first AUX mmap of a redirected event
(perf_event_set_output()): perf_mmap_aux() refcount_inc()s the event's
mmap_count from zero, which saturates the count and reports
REFCOUNT_ADD_UAF through REFCOUNT_CORRUPTION() (a WARN_ONCE(), or a
BUG() with CONFIG_BUG_ON_DATA_CORRUPTION=y).  A saturated count is
never released: a later AUX mmap() reports REFCOUNT_ADD_OVF once, while
perf_mmap_close() takes the saturated count silently and therefore
never detaches the event from the borrowed rb.  The AUX mmap
of a not-yet-mmaped event is now rejected with -EBUSY, matching the
ring mmap() stance.  The ring-side fix was
commit d06bf78e55d5 ("perf: Fix refcount warning on event->mmap_count
increment").

That is an observable behavior change: the first AUX mmap() of a
redirected event now fails with -EBUSY where it previously reported a
refcount error and saturated the event's mmap_count.  Only flows that
are already broken on this base are affected.

The patch 2 defect is availability only: the count saturates fail-safe,
and no use-after-free was found.  It is reachable by an unprivileged
user through perf_event_set_output() (PERF_FLAG_FD_OUTPUT) on AUX-capable
PMUs where userspace can create the AUX-owning event.  On a default
kernel the first such mmap() prints one warning; with panic_on_warn=1
that first warning panics the kernel, and with
CONFIG_BUG_ON_DATA_CORRUPTION=y the BUG() oopses the task regardless of
panic_on_warn.  The ring-side twin was fixed the same way.

Validation used source-level host harnesses that compile perf_mmap,
perf_mmap_rb, perf_mmap_aux, perf_mmap_close,
perf_mmap_account/unaccount/calc_limits straight from the tree and
drive full single-user, single-mm, single-thread lifecycles over them;
nothing runs in a kernel, and no runtime kernel reproduction was
performed:

- 22-case mmap-charge harness: the base fails 13 (per-alias
  user->perf_mlock charge leak), patch 1 alone passes 22/22, the series
  keeps 22/22 passing.
- redirect-lifecycle harness (33 scenarios): the base fails 22, patch 1
  alone fails exactly the 9 redirected-AUX scenarios (the redirected
  AUX mmap saturates mmap_count), the series passes 33/33.

The harnesses are tooling, not part of these changes.  The series is
compile-verified with a focused x86-64 defconfig build of
kernel/events/core.o; the kernel was not booted.

Kunwu Chan's "perf/core: add AUX buffer kernel-consumer API" (v2,
9 Oct 2026, <20261009160010.1829642-1-kunwu.chan@gmail.com>) is not
merged upstream, and its series changes no perf_mmap_rb()/
perf_mmap_aux() alias or mlock accounting line, so it does not overlap
these two fixes; both defects described here remain on the base named
above, with or without that series.

AI coding agents in the omp harness wrote the patches, the reproducer
and the measurements. I read every patch in this series before sending
it.

Joshua Warren (2):
  perf/core: Avoid charging mmap aliases twice
  perf/core: handle first AUX mmap on redirected events

 kernel/events/core.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

-- 
2.39.5
