Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC10482EA
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jan 2024 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705960902; cv=none; b=ChfYbzJodIXB88PPa80ctY/IEaC3Q/y6+IQ19eEv1k+DbxIq+AEWTBRsj/0FfS5iyQ7pc2W7nhfVWgSSL3dweDKZEyzQkAiJHnl+eHCsqb++WpsxOdgM7JdsuvzVm0z2Y/+jHdq6D6uuIq0//m4Q42vcfLQ8+Tat4W7vurC+igM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705960902; c=relaxed/simple;
	bh=RtWK9eFG5WEtiEpYTcLN/Kvy5pXwhJ9syXCwiflzg1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9Ldshs1Y7HG6sqoEhg9XvL4su16FRLq814dVhIBE38MIzeDemmlXkBSMP+AcOG9i6Qg0Ue9/v/rrQflknfnnsKTtZ/VIgg0+AV7UITgTdzHwu8+3DBhiPEoFFqssUeRpYzWfd0sWnYQr4I6d3xWIx4G1NJt1tLX2MJTswSfbIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=phIeEC+M; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phIeEC+M"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d72043fa06so9045ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jan 2024 14:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705960900; x=1706565700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4lz8M8R9hcSRgk4I9zwDHznsPx2IQneoiJpQWgCsk0=;
        b=phIeEC+MBoSEsSwKO5VuMqqc/sSVdpFH68Eus4FNFIMswJDpL7vjQBs9j4QkHULOeo
         YcHY0VUuLfb/yPYC1T8YeKWR1kWF/4wyKaMtwv3q5bFH9DciRY3zecFQzRPxvb5LRX0R
         2NXWS3PLrK1EOuVCmdf6OE0iH3x5Z2XVacMuHFzYp8HmIQF/7J+4uPGW0lAUj/C8Ss85
         tdLQ3IUuV+ZvdXZVWbaNQs6iwi/yD+HqJQU0IWKUpZqTXRrBHVcIX8iCZ7I2V7CCIvrG
         ffM55kNL+dx0WqNywlLWtBikcFqxfDXYwNmFIo8iIRG7U3DLw3HCTn2y0szAOV3l+uOz
         GZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705960900; x=1706565700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4lz8M8R9hcSRgk4I9zwDHznsPx2IQneoiJpQWgCsk0=;
        b=UNqu2cyFQLZHnVbqCmtDudUzpRX2o6oqlIXe0jGME+FkPilTNkvpPkCh/vqWE+fB/y
         b53a1B0mMeXCScQBsXRweVs5TDBQGC5dEyOL2qkXQ/HGGvFvsoFV2pm+LxzczjzDIS6z
         Jv7pr2jPn0cHnmX3rdA/CTTjARkV2YTkZgLIRFuK4+DEhujv50aitwXojZU+4wcnzwyx
         xn5rePsXeftNqMkDKWsT48qtOPpTyWdluHDd6Bh6/skobgkrjPq7/tom0YY6TzHrwYK2
         zJfRrC4y+ErKvdvyYnK/7FAdzgCTwtqYjfaWUsH/4buuCtnFzB9n8F1bvswaAfG/AcfF
         KCvQ==
X-Gm-Message-State: AOJu0YxtyHiq3eS7bItNK+t9S+56Qgpy2h0xXQMMDViFo3SGr6teno6g
	MVzS4FatJpz06z0iR14ZEE2O/Q0lMcB9CDtrYWLGNcvTo8hheFl7/BzIp9nf7mTgV0Aa1g1dL8d
	vcw0PAw1mhqFOUAonzTDb8VQBDbacHI1NBZGPGNIKCboO+pE9j2SIHw4=
X-Google-Smtp-Source: AGHT+IFpqY/vwWs7iYnszFX5OEq1hv6XSgkF+opReyG8j9NfGK+Fa5PwerQs9j1vezPjRcd6ZVhI5MaHbzGsD//GaUc=
X-Received: by 2002:a17:903:2342:b0:1d7:48ef:e239 with SMTP id
 c2-20020a170903234200b001d748efe239mr77063plh.18.1705960899466; Mon, 22 Jan
 2024 14:01:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122213806.19668-1-vmolnaro@redhat.com>
In-Reply-To: <20240122213806.19668-1-vmolnaro@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Jan 2024 14:01:28 -0800
Message-ID: <CAP-5=fXDcOiAF6M6VugXzah0gWGyzkf0-tNE+maFLNfwzCKRTQ@mail.gmail.com>
Subject: Re: [PATCH] perf test attr: Add back missing topdown events
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com, 
	mpetlan@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 1:39=E2=80=AFPM <vmolnaro@redhat.com> wrote:
>
> From: Veronika Molnarova <vmolnaro@redhat.com>
>
> With the patch 0b6c5371c03c "Add missing topdown metrics events" eight
> topdown metric events with numbers ranging from 0x8000 to 0x8700 were
> added to the test since they were added as 'perf stat' default events.
> Later the patch 951efb9976ce "Update no event/metric expectations" kept
> only 4 of those events(0x8000-0x8300).
>
> Currently, the topdown events with numbers 0x8400 to 0x8700 are missing
> from the list of expected events resulting in a failure. Add back the
> missing topdown events.
>
> Fixes: 951efb9976ce ("perf test attr: Update no event/metric expectations=
")
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> ---
>  tools/perf/tests/attr/test-stat-default    |  90 ++++++++++----
>  tools/perf/tests/attr/test-stat-detailed-1 | 106 +++++++++++-----
>  tools/perf/tests/attr/test-stat-detailed-2 | 130 ++++++++++++-------
>  tools/perf/tests/attr/test-stat-detailed-3 | 138 ++++++++++++++-------
>  4 files changed, 320 insertions(+), 144 deletions(-)
>
> diff --git a/tools/perf/tests/attr/test-stat-default b/tools/perf/tests/a=
ttr/test-stat-default
> index a1e2da0a9a6d..e47fb4944679 100644
> --- a/tools/perf/tests/attr/test-stat-default
> +++ b/tools/perf/tests/attr/test-stat-default
> @@ -88,98 +88,142 @@ enable_on_exec=3D0
>  read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
>  [event13:base-stat]
>  fd=3D13
>  group_fd=3D11
>  type=3D4
> -config=3D33280
> +config=3D33024
>  disabled=3D0
>  enable_on_exec=3D0
>  read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
>  [event14:base-stat]
>  fd=3D14
>  group_fd=3D11
>  type=3D4
> -config=3D33536
> +config=3D33280
>  disabled=3D0
>  enable_on_exec=3D0
>  read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
>  [event15:base-stat]
>  fd=3D15
>  group_fd=3D11
>  type=3D4
> -config=3D33024
> +config=3D33536
>  disabled=3D0
>  enable_on_exec=3D0
>  read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> +# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)

topdown-heavy-ops is a topdown level 2 event. I suspect these failures
are caused by the perf stat default output being different when level
2 events are present, inherently newer Intel architectures. The
behavior is expected as the level 2 events are part of the metrics in
the Default group:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json?h=3Dperf-=
tools-next#n641
The test failure isn't expected and we probably need to update the
attribute test for the flexibility added by the "Default" metric group
set up, maybe we can add the level2 events as other optional events.

Thanks,
Ian

>  [event16:base-stat]
>  fd=3D16
> +group_fd=3D11
>  type=3D4
> -config=3D4109
> +config=3D33792
> +disabled=3D0
> +enable_on_exec=3D0
> +read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
> +# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
>  [event17:base-stat]
>  fd=3D17
> +group_fd=3D11
>  type=3D4
> -config=3D17039629
> +config=3D34048
> +disabled=3D0
> +enable_on_exec=3D0
> +read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
> +# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
>  [event18:base-stat]
>  fd=3D18
> +group_fd=3D11
>  type=3D4
> -config=3D60
> +config=3D34304
> +disabled=3D0
> +enable_on_exec=3D0
> +read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
> +# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
>  [event19:base-stat]
>  fd=3D19
> +group_fd=3D11
>  type=3D4
> -config=3D2097421
> +config=3D34560
> +disabled=3D0
> +enable_on_exec=3D0
> +read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
>  [event20:base-stat]
>  fd=3D20
>  type=3D4
> -config=3D316
> +config=3D4109
>  optional=3D1
>
> -# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
>  [event21:base-stat]
>  fd=3D21
>  type=3D4
> -config=3D412
> +config=3D17039629
>  optional=3D1
>
> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
>  [event22:base-stat]
>  fd=3D22
>  type=3D4
> -config=3D572
> +config=3D60
>  optional=3D1
>
> -# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
>  [event23:base-stat]
>  fd=3D23
>  type=3D4
> -config=3D706
> +config=3D2097421
>  optional=3D1
>
> -# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
>  [event24:base-stat]
>  fd=3D24
>  type=3D4
> +config=3D316
> +optional=3D1
> +
> +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> +[event25:base-stat]
> +fd=3D25
> +type=3D4
> +config=3D412
> +optional=3D1
> +
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> +[event26:base-stat]
> +fd=3D26
> +type=3D4
> +config=3D572
> +optional=3D1
> +
> +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> +[event27:base-stat]
> +fd=3D27
> +type=3D4
> +config=3D706
> +optional=3D1
> +
> +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> +[event28:base-stat]
> +fd=3D28
> +type=3D4
>  config=3D270
>  optional=3D1
> diff --git a/tools/perf/tests/attr/test-stat-detailed-1 b/tools/perf/test=
s/attr/test-stat-detailed-1
> index 1c52cb05c900..3d500d3e0c5c 100644
> --- a/tools/perf/tests/attr/test-stat-detailed-1
> +++ b/tools/perf/tests/attr/test-stat-detailed-1
> @@ -90,99 +90,143 @@ enable_on_exec=3D0
>  read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
>  [event13:base-stat]
>  fd=3D13
>  group_fd=3D11
>  type=3D4
> -config=3D33280
> +config=3D33024
>  disabled=3D0
>  enable_on_exec=3D0
>  read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
>  [event14:base-stat]
>  fd=3D14
>  group_fd=3D11
>  type=3D4
> -config=3D33536
> +config=3D33280
>  disabled=3D0
>  enable_on_exec=3D0
>  read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
>  [event15:base-stat]
>  fd=3D15
>  group_fd=3D11
>  type=3D4
> -config=3D33024
> +config=3D33536
>  disabled=3D0
>  enable_on_exec=3D0
>  read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> +# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
>  [event16:base-stat]
>  fd=3D16
> +group_fd=3D11
>  type=3D4
> -config=3D4109
> +config=3D33792
> +disabled=3D0
> +enable_on_exec=3D0
> +read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
> +# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
>  [event17:base-stat]
>  fd=3D17
> +group_fd=3D11
>  type=3D4
> -config=3D17039629
> +config=3D34048
> +disabled=3D0
> +enable_on_exec=3D0
> +read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
> +# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
>  [event18:base-stat]
>  fd=3D18
> +group_fd=3D11
>  type=3D4
> -config=3D60
> +config=3D34304
> +disabled=3D0
> +enable_on_exec=3D0
> +read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
> +# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
>  [event19:base-stat]
>  fd=3D19
> +group_fd=3D11
>  type=3D4
> -config=3D2097421
> +config=3D34560
> +disabled=3D0
> +enable_on_exec=3D0
> +read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
>  [event20:base-stat]
>  fd=3D20
>  type=3D4
> -config=3D316
> +config=3D4109
>  optional=3D1
>
> -# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
>  [event21:base-stat]
>  fd=3D21
>  type=3D4
> -config=3D412
> +config=3D17039629
>  optional=3D1
>
> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
>  [event22:base-stat]
>  fd=3D22
>  type=3D4
> -config=3D572
> +config=3D60
>  optional=3D1
>
> -# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
>  [event23:base-stat]
>  fd=3D23
>  type=3D4
> -config=3D706
> +config=3D2097421
>  optional=3D1
>
> -# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
>  [event24:base-stat]
>  fd=3D24
>  type=3D4
> +config=3D316
> +optional=3D1
> +
> +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> +[event25:base-stat]
> +fd=3D25
> +type=3D4
> +config=3D412
> +optional=3D1
> +
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> +[event26:base-stat]
> +fd=3D26
> +type=3D4
> +config=3D572
> +optional=3D1
> +
> +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> +[event27:base-stat]
> +fd=3D27
> +type=3D4
> +config=3D706
> +optional=3D1
> +
> +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> +[event28:base-stat]
> +fd=3D28
> +type=3D4
>  config=3D270
>  optional=3D1
>
> @@ -190,8 +234,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event25:base-stat]
> -fd=3D25
> +[event29:base-stat]
> +fd=3D29
>  type=3D3
>  config=3D0
>  optional=3D1
> @@ -200,8 +244,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event26:base-stat]
> -fd=3D26
> +[event30:base-stat]
> +fd=3D30
>  type=3D3
>  config=3D65536
>  optional=3D1
> @@ -210,8 +254,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event27:base-stat]
> -fd=3D27
> +[event31:base-stat]
> +fd=3D31
>  type=3D3
>  config=3D2
>  optional=3D1
> @@ -220,8 +264,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event28:base-stat]
> -fd=3D28
> +[event32:base-stat]
> +fd=3D32
>  type=3D3
>  config=3D65538
>  optional=3D1
> diff --git a/tools/perf/tests/attr/test-stat-detailed-2 b/tools/perf/test=
s/attr/test-stat-detailed-2
> index 7e961d24a885..01777a63752f 100644
> --- a/tools/perf/tests/attr/test-stat-detailed-2
> +++ b/tools/perf/tests/attr/test-stat-detailed-2
> @@ -90,99 +90,143 @@ enable_on_exec=3D0
>  read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
>  [event13:base-stat]
>  fd=3D13
>  group_fd=3D11
>  type=3D4
> -config=3D33280
> +config=3D33024
>  disabled=3D0
>  enable_on_exec=3D0
>  read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
>  [event14:base-stat]
>  fd=3D14
>  group_fd=3D11
>  type=3D4
> -config=3D33536
> +config=3D33280
>  disabled=3D0
>  enable_on_exec=3D0
>  read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
>  [event15:base-stat]
>  fd=3D15
>  group_fd=3D11
>  type=3D4
> -config=3D33024
> +config=3D33536
>  disabled=3D0
>  enable_on_exec=3D0
>  read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> +# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
>  [event16:base-stat]
>  fd=3D16
> +group_fd=3D11
>  type=3D4
> -config=3D4109
> +config=3D33792
> +disabled=3D0
> +enable_on_exec=3D0
> +read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
> +# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
>  [event17:base-stat]
>  fd=3D17
> +group_fd=3D11
>  type=3D4
> -config=3D17039629
> +config=3D34048
> +disabled=3D0
> +enable_on_exec=3D0
> +read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
> +# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
>  [event18:base-stat]
>  fd=3D18
> +group_fd=3D11
>  type=3D4
> -config=3D60
> +config=3D34304
> +disabled=3D0
> +enable_on_exec=3D0
> +read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
> +# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
>  [event19:base-stat]
>  fd=3D19
> +group_fd=3D11
>  type=3D4
> -config=3D2097421
> +config=3D34560
> +disabled=3D0
> +enable_on_exec=3D0
> +read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
>  [event20:base-stat]
>  fd=3D20
>  type=3D4
> -config=3D316
> +config=3D4109
>  optional=3D1
>
> -# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
>  [event21:base-stat]
>  fd=3D21
>  type=3D4
> -config=3D412
> +config=3D17039629
>  optional=3D1
>
> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
>  [event22:base-stat]
>  fd=3D22
>  type=3D4
> -config=3D572
> +config=3D60
>  optional=3D1
>
> -# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
>  [event23:base-stat]
>  fd=3D23
>  type=3D4
> -config=3D706
> +config=3D2097421
>  optional=3D1
>
> -# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
>  [event24:base-stat]
>  fd=3D24
>  type=3D4
> +config=3D316
> +optional=3D1
> +
> +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> +[event25:base-stat]
> +fd=3D25
> +type=3D4
> +config=3D412
> +optional=3D1
> +
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> +[event26:base-stat]
> +fd=3D26
> +type=3D4
> +config=3D572
> +optional=3D1
> +
> +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> +[event27:base-stat]
> +fd=3D27
> +type=3D4
> +config=3D706
> +optional=3D1
> +
> +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> +[event28:base-stat]
> +fd=3D28
> +type=3D4
>  config=3D270
>  optional=3D1
>
> @@ -190,8 +234,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event25:base-stat]
> -fd=3D25
> +[event29:base-stat]
> +fd=3D29
>  type=3D3
>  config=3D0
>  optional=3D1
> @@ -200,8 +244,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event26:base-stat]
> -fd=3D26
> +[event30:base-stat]
> +fd=3D30
>  type=3D3
>  config=3D65536
>  optional=3D1
> @@ -210,8 +254,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event27:base-stat]
> -fd=3D27
> +[event31:base-stat]
> +fd=3D31
>  type=3D3
>  config=3D2
>  optional=3D1
> @@ -220,8 +264,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event28:base-stat]
> -fd=3D28
> +[event32:base-stat]
> +fd=3D32
>  type=3D3
>  config=3D65538
>  optional=3D1
> @@ -230,8 +274,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event29:base-stat]
> -fd=3D29
> +[event33:base-stat]
> +fd=3D33
>  type=3D3
>  config=3D1
>  optional=3D1
> @@ -240,8 +284,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event30:base-stat]
> -fd=3D30
> +[event34:base-stat]
> +fd=3D34
>  type=3D3
>  config=3D65537
>  optional=3D1
> @@ -250,8 +294,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event31:base-stat]
> -fd=3D31
> +[event35:base-stat]
> +fd=3D35
>  type=3D3
>  config=3D3
>  optional=3D1
> @@ -260,8 +304,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event32:base-stat]
> -fd=3D32
> +[event36:base-stat]
> +fd=3D36
>  type=3D3
>  config=3D65539
>  optional=3D1
> @@ -270,8 +314,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event33:base-stat]
> -fd=3D33
> +[event37:base-stat]
> +fd=3D37
>  type=3D3
>  config=3D4
>  optional=3D1
> @@ -280,8 +324,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event34:base-stat]
> -fd=3D34
> +[event38:base-stat]
> +fd=3D38
>  type=3D3
>  config=3D65540
>  optional=3D1
> diff --git a/tools/perf/tests/attr/test-stat-detailed-3 b/tools/perf/test=
s/attr/test-stat-detailed-3
> index e50535f45977..8400abd7e1e4 100644
> --- a/tools/perf/tests/attr/test-stat-detailed-3
> +++ b/tools/perf/tests/attr/test-stat-detailed-3
> @@ -90,99 +90,143 @@ enable_on_exec=3D0
>  read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
>  [event13:base-stat]
>  fd=3D13
>  group_fd=3D11
>  type=3D4
> -config=3D33280
> +config=3D33024
>  disabled=3D0
>  enable_on_exec=3D0
>  read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
>  [event14:base-stat]
>  fd=3D14
>  group_fd=3D11
>  type=3D4
> -config=3D33536
> +config=3D33280
>  disabled=3D0
>  enable_on_exec=3D0
>  read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
>  [event15:base-stat]
>  fd=3D15
>  group_fd=3D11
>  type=3D4
> -config=3D33024
> +config=3D33536
>  disabled=3D0
>  enable_on_exec=3D0
>  read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> +# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
>  [event16:base-stat]
>  fd=3D16
> +group_fd=3D11
>  type=3D4
> -config=3D4109
> +config=3D33792
> +disabled=3D0
> +enable_on_exec=3D0
> +read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
> +# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
>  [event17:base-stat]
>  fd=3D17
> +group_fd=3D11
>  type=3D4
> -config=3D17039629
> +config=3D34048
> +disabled=3D0
> +enable_on_exec=3D0
> +read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
> +# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
>  [event18:base-stat]
>  fd=3D18
> +group_fd=3D11
>  type=3D4
> -config=3D60
> +config=3D34304
> +disabled=3D0
> +enable_on_exec=3D0
> +read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
> +# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
>  [event19:base-stat]
>  fd=3D19
> +group_fd=3D11
>  type=3D4
> -config=3D2097421
> +config=3D34560
> +disabled=3D0
> +enable_on_exec=3D0
> +read_format=3D15
>  optional=3D1
>
> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
>  [event20:base-stat]
>  fd=3D20
>  type=3D4
> -config=3D316
> +config=3D4109
>  optional=3D1
>
> -# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
>  [event21:base-stat]
>  fd=3D21
>  type=3D4
> -config=3D412
> +config=3D17039629
>  optional=3D1
>
> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
>  [event22:base-stat]
>  fd=3D22
>  type=3D4
> -config=3D572
> +config=3D60
>  optional=3D1
>
> -# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
>  [event23:base-stat]
>  fd=3D23
>  type=3D4
> -config=3D706
> +config=3D2097421
>  optional=3D1
>
> -# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
>  [event24:base-stat]
>  fd=3D24
>  type=3D4
> +config=3D316
> +optional=3D1
> +
> +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> +[event25:base-stat]
> +fd=3D25
> +type=3D4
> +config=3D412
> +optional=3D1
> +
> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> +[event26:base-stat]
> +fd=3D26
> +type=3D4
> +config=3D572
> +optional=3D1
> +
> +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> +[event27:base-stat]
> +fd=3D27
> +type=3D4
> +config=3D706
> +optional=3D1
> +
> +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> +[event28:base-stat]
> +fd=3D28
> +type=3D4
>  config=3D270
>  optional=3D1
>
> @@ -190,8 +234,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event25:base-stat]
> -fd=3D25
> +[event29:base-stat]
> +fd=3D29
>  type=3D3
>  config=3D0
>  optional=3D1
> @@ -200,8 +244,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event26:base-stat]
> -fd=3D26
> +[event30:base-stat]
> +fd=3D30
>  type=3D3
>  config=3D65536
>  optional=3D1
> @@ -210,8 +254,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event27:base-stat]
> -fd=3D27
> +[event31:base-stat]
> +fd=3D31
>  type=3D3
>  config=3D2
>  optional=3D1
> @@ -220,8 +264,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event28:base-stat]
> -fd=3D28
> +[event32:base-stat]
> +fd=3D32
>  type=3D3
>  config=3D65538
>  optional=3D1
> @@ -230,8 +274,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event29:base-stat]
> -fd=3D29
> +[event33:base-stat]
> +fd=3D33
>  type=3D3
>  config=3D1
>  optional=3D1
> @@ -240,8 +284,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event30:base-stat]
> -fd=3D30
> +[event34:base-stat]
> +fd=3D34
>  type=3D3
>  config=3D65537
>  optional=3D1
> @@ -250,8 +294,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event31:base-stat]
> -fd=3D31
> +[event35:base-stat]
> +fd=3D35
>  type=3D3
>  config=3D3
>  optional=3D1
> @@ -260,8 +304,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event32:base-stat]
> -fd=3D32
> +[event36:base-stat]
> +fd=3D36
>  type=3D3
>  config=3D65539
>  optional=3D1
> @@ -270,8 +314,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event33:base-stat]
> -fd=3D33
> +[event37:base-stat]
> +fd=3D37
>  type=3D3
>  config=3D4
>  optional=3D1
> @@ -280,8 +324,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event34:base-stat]
> -fd=3D34
> +[event38:base-stat]
> +fd=3D38
>  type=3D3
>  config=3D65540
>  optional=3D1
> @@ -290,8 +334,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_PREFETCH        <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event35:base-stat]
> -fd=3D35
> +[event39:base-stat]
> +fd=3D39
>  type=3D3
>  config=3D512
>  optional=3D1
> @@ -300,8 +344,8 @@ optional=3D1
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_PREFETCH        <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event36:base-stat]
> -fd=3D36
> +[event40:base-stat]
> +fd=3D40
>  type=3D3
>  config=3D66048
>  optional=3D1
> --
> 2.43.0
>
