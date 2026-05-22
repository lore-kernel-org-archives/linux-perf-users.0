Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502FA38D412
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487837; cv=pass; b=WJVMf85IgO4mbgQ8hihd0BjpACJDdeDXU6I+Oa3FWV2FizXvH9mOXexu+oML5bEcUa/URwTHT13yaYQ1zV4lJ83HsdNwK8Gzxo/OPhPNyGDFfgz55nv6SBWbbDBVFeQhT2H8d95MMLBnNen3CcmWv4ZjRH67gU1OCfrzQZ3x8bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487837; c=relaxed/simple;
	bh=OWKPtM+HZbO3Sgq+JKRV67253lK0yjust8OzrGPHuS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlZkNGMuWoA2wLMtkeF3Je6ggkdtZ14QMQ9aJ80NCI0kizy4XQDt7shUjXJOmQIiZO7aVjuZZL421BBXVIy40rG4aXsjdjqKoKf88+aQN6oUTCwXMe+5XU1vEr29cxJa266mnmbgzMzIH6DhfZLEEEIOIFMvwfrkYq/qeto2tlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f9xLH6SR; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f9xLH6SR"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba180a022dso1335ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779487835; cv=none;
        d=google.com; s=arc-20240605;
        b=LFb6X6F+Ealc2SSmjoHDbd8kxwz2sBG5+W3FFRzLdrl6DzZ2pkEK4+tagHmPchrnua
         mvFg/us1e+x/uHBtLg2LJJTeScbV2IibrEabJlIlbRDQoEdSpqWsOSsVl4B6giTflkPy
         QI0TLJ8VoN16PVcwdHSKH4OjZdR9WXyVsGu3i2rJQVMbh9G7QyCTdhbw5TMLTCLaCc4o
         yN9RnQ4tUAD+JN1wQinZotNijwApky+4TOAA5GUOpJwwTNw2XUIAhc2c4FravNX/9rWT
         OCZEzcJFEECHZ2J5PBOVqcjHV48Ps2ULGBJdJxNVOwBO/y6ZrLcWpgvaUZckUzfUmwq9
         jLoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=714r4DbTYSTOMaiyV3SbO3v9P113Cx4M83M6XOGkIvg=;
        fh=3y8lEn3j38Y305qbYvU2JVsrEWNrnfsZdUDS4tTQqAE=;
        b=gsCNbVL7RHDBz2XHGzDGfqCIRlZMmbRJFqETE6pl5siHWwymqP5FdX1GHzkAtEPsp1
         vM9DYkMYWjn3j8fTyAngsFudR8MMqGrJCRq6V1be8qJE64JotM62UHCcXMwKV25K+Q0V
         EKVH7k183kYMkjUZKFBd6cr49MN58gA292Xktu7C4Sx4sIbn54lz/hPExQ/fM1BSMn9+
         Q+wmA+dl+Bw8z7Cy1kqM6ZjW5RtM+VHasBjs2WApavIViKJTL11QOMqXUP8fGBc1eEDr
         pWgIlAXOSmeSKNwcPh1+1h6KeYjInS07iv8rLAsmhh2v5lzAXKQQxLpfDi9L7OYmQ5hK
         Eakg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779487835; x=1780092635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=714r4DbTYSTOMaiyV3SbO3v9P113Cx4M83M6XOGkIvg=;
        b=f9xLH6SRdtMcYCteCSVjgQF09vyp2S6NwU3ZcY/XtBm9rCVzRDKMAQU+Am1aP8/rJ9
         D3P1LFPHfT03wQ8r8Btm3RpX0KpyJNerhS9WC1rw0jq7Cv+pm/w1dehL+3Wlt1o4+zAB
         d3Lnnc0v5UnOM0XFlyKEOrja1ktYOlOGK/rWKN1EDtbT5XgeeC6vR79mxPM5TsnTLzLK
         7BaEUDpmfBIxyKPN1ew63bwtmiaWbcKXrZhe248Hy6u2oikIqRyIVpdB3Rn+dGogHPIV
         4nnlpxK8U01YZvnrqJ+qbKIS7x0GisVDcPRqwxa8fFafzMAemWOPOwVCyXdHpvWJKyV8
         btFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487835; x=1780092635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=714r4DbTYSTOMaiyV3SbO3v9P113Cx4M83M6XOGkIvg=;
        b=M+8MxOJvIKiTFkTCbxjJyC8V53Jzzf+Ck4ktZ7npx1g6xoCyqKMfFE5Zkj8x1+ROfs
         T6uN4NOBqEAnWbFZIXyLUlypXMiacHBxWf6L3VF1oNf8x2q+I/nVrpf7bE+8iQjgJRX9
         zKdKS2K/Q9B3xR72S+W2A9P1rytNTZqEY4sSw064/RqgOdgfNQ1+J/4WCYyy2uj8HgXD
         iTQ/2j4gMrYb3qNeGb4UonLQMd6OF70L3DH5KHz3GOBT22uWy2/DaRvTAiGFvEri6SWV
         0pm5daCno4Oa4s76/W1BvuX1+D7VTPtchTOVJEcKBk134PeAyK1BbNoAvopzs98fVSsp
         gcNA==
X-Forwarded-Encrypted: i=1; AFNElJ8nX7ZbgrlTcsHqKPYNa9rWrTiVF72bFPeTkb4FsK2VECWucjheM+hrA2bdXzpCWOT6elWiBS/i9qHaLh4YNPzV@vger.kernel.org
X-Gm-Message-State: AOJu0YxL8f9Ou9VUSX4gd4TViBd4bNXQX1Uif3Vi938oIN7hkNYdDbRd
	AMJWIfDiRarbsFQq3HuRN53a1BYjj5yS+vMvmboEIHxirV5fc1w/zRCLmhWc/hB82KNq6t47a3w
	VQWZcAeXU4lKG5/84+8DAuI8gn4IXNBkhU5W/SfUL
X-Gm-Gg: Acq92OFOfLHeoZ9OTaeu2gW8KG/TbQXAVBh9d0BFNyRb3ao/enF9WBj5ka2vmD7vCpN
	4brPTprqmsGTqPkZXEv/QfO/QpoIa6/VejnyHxY+lwHpCDQU9NATkmgxwC27k7UzpsyiCpoRDyG
	QiVRuUG5gcFZof+wkEJJ+ehwvpbl/3oeqWf25/1uvN4cEVR0c2Xo66J5muIB3OkohT22NeC6cRy
	h/BX2O4NXO3njaAb2POCKcI2lxT23/k5rydsmOXdXgmI5RgtTzxKkd4VSXUZ3gRo5SHjmMxK88V
	arxrRzW8Za4sn1U+5yHb7peNH6xlWclMxoj6I2/K7iWuf8OQ
X-Received: by 2002:a17:903:1a2c:b0:2a7:87c2:fcde with SMTP id
 d9443c01a7336-2bec11c156amr366015ad.15.1779487835021; Fri, 22 May 2026
 15:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518223733.3034897-1-irogers@google.com> <20260519014106.3089452-1-irogers@google.com>
In-Reply-To: <20260519014106.3089452-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 22 May 2026 15:10:23 -0700
X-Gm-Features: AVHnY4I-GWy8lih--FiFA6WojaJXnX2yHhIFbkhVPXimGU3fZOSEQMjhMLV6rew
Message-ID: <CAP-5=fVUXxenM-6bdf0Y1cct2G80HxT22tOaQ=DzZ3g4fVoz7A@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] perf tool_pmu: Support enable/disable for tool PMU events
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, nigro.fra@gmail.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 6:41=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> A regression in perf stat was reported where tool PMU events (like
> duration_time used in CPUs_utilized metric) incorrectly included the
> delay period when using the delay option (-D).
>
> This series fixes the regression by making tool PMU events
> (duration_time, user_time, system_time) behave more like regular
> counters by implementing proper enable and disable support. They now
> correctly accumulate values only when enabled.
>
> The first patch implements the core enable/disable support for tool PMU
> events, and the second patch adds a shell test to verify that
> duration_time correctly excludes the delay period.

Would be nice to get this reported bug fix landed.

Thanks,
Ian

> Changes in v4:
> - Update evsel->disabled immediately after the leader's own enable/disabl=
e
>   succeeds in evsel__enable() / evsel__disable(), preventing state
>   inconsistency on early return if a member fails.
> - Remove evsel->disabled state changes from within the CPU loops in
>   evsel__tool_pmu_enable_cpu() and evsel__tool_pmu_disable_cpu() to
>   prevent __evlist__disable() from skipping disable_cpu calls for other
>   CPUs.
> - Make *start_time =3D INVALID_START_TIME unconditional in
>   evsel__tool_pmu_disable_cpu() to ensure safe inactive state invalidatio=
n.
> - Address a checkpatch warning regarding unnecessary braces for a single
>   statement if block.
>
> Changes in v3:
> - Refine group handling: only manually enable/disable group members when
>   the leader or member is a non-perf-event open PMU, as the kernel allows
>   grouping of software and hardware PMUs.
> - Fix a file descriptor leak in evsel__tool_pmu_open() on error paths by
>   explicitly closing the successfully opened fd before exiting.
> - Synchronize the 'disabled' flag for all group members in enable/disable
>   paths (both per-CPU and batch loops) to prevent stale disabled flags.
> - Add explicit early exits to evsel__tool_pmu_enable() and disable() base=
d
>   on evsel->disabled to protect internal metric state.
> - Add an upper bound check in test_stat_delay to verify that the delay wa=
s
>   actually excluded.
>
> Changes in v2:
> - Implement evsel__tool_pmu_enable() and evsel__tool_pmu_disable() to
>   avoid ioctl failures in batch evsel__enable() and evsel__disable()
>   functions.
> - Correctly iterate and enable/disable tool PMU events configured as
>   non-leader members of event groups.
> - Correct the lseek() arguments order in the read_stat helper:
>   lseek(fd, 0, SEEK_SET) instead of lseek(fd, SEEK_SET, 0).
> - Introduce INVALID_START_TIME (~0ULL) to prevent erroneous large delta
>   accumulation in evsel__tool_pmu_read() if /proc/<pid>/stat fails to
>   read in enable_cpu (e.g., process exited).
> - Improve test parsing to use LC_ALL=3DC and cut to be robust against
>   different locales, and use awk to dynamically compare duration_time to
>   time elapsed with a 200ms tolerance (avoiding loaded CI false failures)=
.
>   Also added a lower-bound check.
> - Fix style warnings from checkpatch.pl (line lengths, braces, and blank
>   lines).
>
> Ian Rogers (2):
>   perf tool_pmu: Make tool PMU events respect enable/disable
>   perf tests: Add test for stat delay option with duration_time
>
>  tools/perf/tests/shell/stat.sh |  53 +++++++
>  tools/perf/util/evlist.c       |  10 +-
>  tools/perf/util/evsel.c        | 197 ++++++++++++++++++++------
>  tools/perf/util/evsel.h        |  15 +-
>  tools/perf/util/tool_pmu.c     | 250 ++++++++++++++++++++++++++-------
>  tools/perf/util/tool_pmu.h     |   4 +
>  6 files changed, 430 insertions(+), 99 deletions(-)
>
> --
> 2.54.0.631.ge1b05301d1-goog
>
