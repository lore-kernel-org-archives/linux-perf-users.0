Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4041C5782
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801698; cv=none; b=PfEzValEhEKw0c6aHxFBYfRTDL6cgforlHhNQXqgOICqDg3CKXbT3fk5v4SxQnIzFZ1g8BluX+F83bfhiHE7ik32IJfqkpFLKtwqUKLYV8V2w1Nd9+1UoTgEbGtmHXftV25bzGLNNByKccbZzBAYIXrWiovt4rUoL/xSUKSzAdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801698; c=relaxed/simple;
	bh=0Nw6VPyTtLNyNBQ87HrQgtrNAakIIM0qyhS+ca802ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKknflTW/w7B7WUbUei/VKQdan/8ZDYrxjgf8VUDaGqpQfrI/lkj8tyCyiFMUchWoqZFFF++WYY9nbSO4DUr+rrVtNdpvIZBBbe6RJejPp/sAAsSMwcCtHfHEHKIjE+HQX0V/lWDOWlFAnM6XaEid5oLMsX22JY2NfHbwclDpg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E5GigfA3; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E5GigfA3"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4582a5b495cso6081cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 09:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727801695; x=1728406495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRyTiiQ8bRdDWqlF388QTEZHlChlU339cNRzgYg+eOQ=;
        b=E5GigfA3lCS25ZSornppENMjdRgbAH/mIqm8P799kVnpyo+mjppWI5sNSqQp9Mz1I2
         x662NLWNTW5DmUXi4iAdk0N1WV72AxW6OaHcTO9//bHYYEWmwSxlbVtCK+FHvudSZfac
         S22IenQMqrlKfrzok4F729GHQWRxZh3X/c+KvCjHluRiWK+Mb3aIEgDN6spiD93WuwR4
         1NxP7tzI4n56408tYCgPtftb5Hbm/zT2/efBrShupGtap76em37JZkIZaAGepTwMBTrP
         dG6/b73kLVpYotz+NTNVb3a4Ci0qbHuC0wD/azO563iuEXEhrM77XjZ9UQjgCRmQjdhb
         bkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727801695; x=1728406495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRyTiiQ8bRdDWqlF388QTEZHlChlU339cNRzgYg+eOQ=;
        b=Q3lE71xFgDFuCIJS4NJFJYZ27QqpmgJ4paJF9GDtTqy8lf7UM3fu7WLtb6vtyvNg5S
         rMGDDuNyyrhf8nmlVCTlssjd9rnOb2Q24mt7zYoBkd8pigskdJzntM4trZGu8pMjMYET
         j9FfYlCzxzbWQQcq9t2L88gVYNil/y65uUe4R5qcRzBRvSwEy9oZ1JlCt5b9BI5qpZzE
         sPDNOnic9BiykAMsGSCgBY0c9nL6sr/+7aHOdVXqFLV+Otm/TLTgl1g+/5mjWEDFGscy
         umZ7c3si8CSvmBQl0CzGITV5slGZxumAR56g6LW1bA/me+MQD26oXvfhiKsmZNK7Wb7F
         nGYA==
X-Forwarded-Encrypted: i=1; AJvYcCUtIMP7eX5g9VBKx4KeA7jmFcTs85QbBPBsQglgKbnVD5mLEPGrhQmX0za5HKFpesJsp7+1LEElSW+pjM7VHKfj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1gytab5RnR+XwZnTUZoior6m5VUeQF8zLgEKGMBcoM3YtQgGD
	03McO64+tkeSUu2VYJgCxUM3zsui+76qDo4gZHelB8Khp17bM0n8W5F7m3R0Wld/Rlrm++p5/mF
	DWOGfNRHq5d4LvL8L1GEMUfRelVi9VaeChuae
X-Google-Smtp-Source: AGHT+IEEfQNcDV3rJE7zBYlhUqPS33JgGgYNCgEdW+X0HTXaZaAPjCV7Z4XJybAgTicNXnuhbpyVfoAe5NvwlfRCUfA=
X-Received: by 2002:a05:622a:5f09:b0:456:7513:44ba with SMTP id
 d75a77b69052e-45d7488f047mr4648591cf.4.1727801694514; Tue, 01 Oct 2024
 09:54:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311081611.7835-1-vmolnaro@redhat.com> <alpine.LRH.2.20.2403201314570.4040@Diego>
 <ZroNTkdA8XDFaDks@x1> <a9bf1065-462e-4ea0-920b-8358b54a33de@redhat.com>
In-Reply-To: <a9bf1065-462e-4ea0-920b-8358b54a33de@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Oct 2024 09:54:41 -0700
Message-ID: <CAP-5=fVixgw8yuPHygbugzMaZc4gr5GJ+jb-prmqSLNmtnbb0g@mail.gmail.com>
Subject: Re: [PATCH] perf test attr: Add back missing topdown events
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Michael Petlan <mpetlan@redhat.com>, 
	linux-perf-users@vger.kernel.org, acme@redhat.com, 
	Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 1:48=E2=80=AFAM Veronika Molnarova <vmolnaro@redhat.=
com> wrote:
>
>
>
> On 8/12/24 15:25, Arnaldo Carvalho de Melo wrote:
> > On Wed, Mar 20, 2024 at 01:16:48PM +0100, Michael Petlan wrote:
> >> Hello Ian,
> >> we've resent this patch, as the previous discussion about this
> >> was unfinished somehow, if I remember correctly. Is this fix
> >> acceptable?
> >> Thank you!
> >> Michael
> >
> > Ian,
> >
> >       I think this fell thru the cracks, do you have something to add?
> >
> > - Arnaldo
> >
> Hi Ian,
>
> do you have anything to add to this patch so that the issue
> could be resolved?
>
> Thanks,
> Veronika

Sorry for the delay. I always find these tests tricky to run so I'm
going to send a follow up series to resolve that.

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> >> On Mon, 11 Mar 2024, vmolnaro@redhat.com wrote:
> >>> From: Veronika Molnarova <vmolnaro@redhat.com>
> >>>
> >>> With the patch 0b6c5371c03c "Add missing topdown metrics events" eigh=
t
> >>> topdown metric events with numbers ranging from 0x8000 to 0x8700 were
> >>> added to the test since they were added as 'perf stat' default events=
.
> >>> Later the patch 951efb9976ce "Update no event/metric expectations" ke=
pt
> >>> only 4 of those events(0x8000-0x8300).
> >>>
> >>> Currently, the topdown events with numbers 0x8400 to 0x8700 are missi=
ng
> >>> from the list of expected events resulting in a failure. Add back the
> >>> missing topdown events.
> >>>
> >>> Fixes: 951efb9976ce ("perf test attr: Update no event/metric expectat=
ions")
> >>> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> >>> ---
> >>>  tools/perf/tests/attr/test-stat-default    |  90 ++++++++++----
> >>>  tools/perf/tests/attr/test-stat-detailed-1 | 106 +++++++++++-----
> >>>  tools/perf/tests/attr/test-stat-detailed-2 | 130 ++++++++++++-------
> >>>  tools/perf/tests/attr/test-stat-detailed-3 | 138 ++++++++++++++-----=
--
> >>>  4 files changed, 320 insertions(+), 144 deletions(-)
> >>>
> >>> diff --git a/tools/perf/tests/attr/test-stat-default b/tools/perf/tes=
ts/attr/test-stat-default
> >>> index a1e2da0a9a6d..e47fb4944679 100644
> >>> --- a/tools/perf/tests/attr/test-stat-default
> >>> +++ b/tools/perf/tests/attr/test-stat-default
> >>> @@ -88,98 +88,142 @@ enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> >>> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> >>>  [event13:base-stat]
> >>>  fd=3D13
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33280
> >>> +config=3D33024
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> >>> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> >>>  [event14:base-stat]
> >>>  fd=3D14
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33536
> >>> +config=3D33280
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> >>> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> >>>  [event15:base-stat]
> >>>  fd=3D15
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33024
> >>> +config=3D33536
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> >>> +# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
> >>>  [event16:base-stat]
> >>>  fd=3D16
> >>> +group_fd=3D11
> >>>  type=3D4
> >>> -config=3D4109
> >>> +config=3D33792
> >>> +disabled=3D0
> >>> +enable_on_exec=3D0
> >>> +read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
> >>> +# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
> >>>  [event17:base-stat]
> >>>  fd=3D17
> >>> +group_fd=3D11
> >>>  type=3D4
> >>> -config=3D17039629
> >>> +config=3D34048
> >>> +disabled=3D0
> >>> +enable_on_exec=3D0
> >>> +read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
> >>> +# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
> >>>  [event18:base-stat]
> >>>  fd=3D18
> >>> +group_fd=3D11
> >>>  type=3D4
> >>> -config=3D60
> >>> +config=3D34304
> >>> +disabled=3D0
> >>> +enable_on_exec=3D0
> >>> +read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
> >>> +# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
> >>>  [event19:base-stat]
> >>>  fd=3D19
> >>> +group_fd=3D11
> >>>  type=3D4
> >>> -config=3D2097421
> >>> +config=3D34560
> >>> +disabled=3D0
> >>> +enable_on_exec=3D0
> >>> +read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> >>> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> >>>  [event20:base-stat]
> >>>  fd=3D20
> >>>  type=3D4
> >>> -config=3D316
> >>> +config=3D4109
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> >>> +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
> >>>  [event21:base-stat]
> >>>  fd=3D21
> >>>  type=3D4
> >>> -config=3D412
> >>> +config=3D17039629
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
> >>>  [event22:base-stat]
> >>>  fd=3D22
> >>>  type=3D4
> >>> -config=3D572
> >>> +config=3D60
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> >>> +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
> >>>  [event23:base-stat]
> >>>  fd=3D23
> >>>  type=3D4
> >>> -config=3D706
> >>> +config=3D2097421
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> >>>  [event24:base-stat]
> >>>  fd=3D24
> >>>  type=3D4
> >>> +config=3D316
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> >>> +[event25:base-stat]
> >>> +fd=3D25
> >>> +type=3D4
> >>> +config=3D412
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> >>> +[event26:base-stat]
> >>> +fd=3D26
> >>> +type=3D4
> >>> +config=3D572
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> >>> +[event27:base-stat]
> >>> +fd=3D27
> >>> +type=3D4
> >>> +config=3D706
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> >>> +[event28:base-stat]
> >>> +fd=3D28
> >>> +type=3D4
> >>>  config=3D270
> >>>  optional=3D1
> >>> diff --git a/tools/perf/tests/attr/test-stat-detailed-1 b/tools/perf/=
tests/attr/test-stat-detailed-1
> >>> index 1c52cb05c900..3d500d3e0c5c 100644
> >>> --- a/tools/perf/tests/attr/test-stat-detailed-1
> >>> +++ b/tools/perf/tests/attr/test-stat-detailed-1
> >>> @@ -90,99 +90,143 @@ enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> >>> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> >>>  [event13:base-stat]
> >>>  fd=3D13
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33280
> >>> +config=3D33024
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> >>> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> >>>  [event14:base-stat]
> >>>  fd=3D14
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33536
> >>> +config=3D33280
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> >>> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> >>>  [event15:base-stat]
> >>>  fd=3D15
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33024
> >>> +config=3D33536
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> >>> +# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
> >>>  [event16:base-stat]
> >>>  fd=3D16
> >>> +group_fd=3D11
> >>>  type=3D4
> >>> -config=3D4109
> >>> +config=3D33792
> >>> +disabled=3D0
> >>> +enable_on_exec=3D0
> >>> +read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
> >>> +# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
> >>>  [event17:base-stat]
> >>>  fd=3D17
> >>> +group_fd=3D11
> >>>  type=3D4
> >>> -config=3D17039629
> >>> +config=3D34048
> >>> +disabled=3D0
> >>> +enable_on_exec=3D0
> >>> +read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
> >>> +# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
> >>>  [event18:base-stat]
> >>>  fd=3D18
> >>> +group_fd=3D11
> >>>  type=3D4
> >>> -config=3D60
> >>> +config=3D34304
> >>> +disabled=3D0
> >>> +enable_on_exec=3D0
> >>> +read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
> >>> +# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
> >>>  [event19:base-stat]
> >>>  fd=3D19
> >>> +group_fd=3D11
> >>>  type=3D4
> >>> -config=3D2097421
> >>> +config=3D34560
> >>> +disabled=3D0
> >>> +enable_on_exec=3D0
> >>> +read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> >>> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> >>>  [event20:base-stat]
> >>>  fd=3D20
> >>>  type=3D4
> >>> -config=3D316
> >>> +config=3D4109
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> >>> +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
> >>>  [event21:base-stat]
> >>>  fd=3D21
> >>>  type=3D4
> >>> -config=3D412
> >>> +config=3D17039629
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
> >>>  [event22:base-stat]
> >>>  fd=3D22
> >>>  type=3D4
> >>> -config=3D572
> >>> +config=3D60
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> >>> +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
> >>>  [event23:base-stat]
> >>>  fd=3D23
> >>>  type=3D4
> >>> -config=3D706
> >>> +config=3D2097421
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> >>>  [event24:base-stat]
> >>>  fd=3D24
> >>>  type=3D4
> >>> +config=3D316
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> >>> +[event25:base-stat]
> >>> +fd=3D25
> >>> +type=3D4
> >>> +config=3D412
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> >>> +[event26:base-stat]
> >>> +fd=3D26
> >>> +type=3D4
> >>> +config=3D572
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> >>> +[event27:base-stat]
> >>> +fd=3D27
> >>> +type=3D4
> >>> +config=3D706
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> >>> +[event28:base-stat]
> >>> +fd=3D28
> >>> +type=3D4
> >>>  config=3D270
> >>>  optional=3D1
> >>>
> >>> @@ -190,8 +234,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event25:base-stat]
> >>> -fd=3D25
> >>> +[event29:base-stat]
> >>> +fd=3D29
> >>>  type=3D3
> >>>  config=3D0
> >>>  optional=3D1
> >>> @@ -200,8 +244,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event26:base-stat]
> >>> -fd=3D26
> >>> +[event30:base-stat]
> >>> +fd=3D30
> >>>  type=3D3
> >>>  config=3D65536
> >>>  optional=3D1
> >>> @@ -210,8 +254,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event27:base-stat]
> >>> -fd=3D27
> >>> +[event31:base-stat]
> >>> +fd=3D31
> >>>  type=3D3
> >>>  config=3D2
> >>>  optional=3D1
> >>> @@ -220,8 +264,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event28:base-stat]
> >>> -fd=3D28
> >>> +[event32:base-stat]
> >>> +fd=3D32
> >>>  type=3D3
> >>>  config=3D65538
> >>>  optional=3D1
> >>> diff --git a/tools/perf/tests/attr/test-stat-detailed-2 b/tools/perf/=
tests/attr/test-stat-detailed-2
> >>> index 7e961d24a885..01777a63752f 100644
> >>> --- a/tools/perf/tests/attr/test-stat-detailed-2
> >>> +++ b/tools/perf/tests/attr/test-stat-detailed-2
> >>> @@ -90,99 +90,143 @@ enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> >>> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> >>>  [event13:base-stat]
> >>>  fd=3D13
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33280
> >>> +config=3D33024
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> >>> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> >>>  [event14:base-stat]
> >>>  fd=3D14
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33536
> >>> +config=3D33280
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> >>> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> >>>  [event15:base-stat]
> >>>  fd=3D15
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33024
> >>> +config=3D33536
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> >>> +# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
> >>>  [event16:base-stat]
> >>>  fd=3D16
> >>> +group_fd=3D11
> >>>  type=3D4
> >>> -config=3D4109
> >>> +config=3D33792
> >>> +disabled=3D0
> >>> +enable_on_exec=3D0
> >>> +read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
> >>> +# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
> >>>  [event17:base-stat]
> >>>  fd=3D17
> >>> +group_fd=3D11
> >>>  type=3D4
> >>> -config=3D17039629
> >>> +config=3D34048
> >>> +disabled=3D0
> >>> +enable_on_exec=3D0
> >>> +read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
> >>> +# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
> >>>  [event18:base-stat]
> >>>  fd=3D18
> >>> +group_fd=3D11
> >>>  type=3D4
> >>> -config=3D60
> >>> +config=3D34304
> >>> +disabled=3D0
> >>> +enable_on_exec=3D0
> >>> +read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
> >>> +# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
> >>>  [event19:base-stat]
> >>>  fd=3D19
> >>> +group_fd=3D11
> >>>  type=3D4
> >>> -config=3D2097421
> >>> +config=3D34560
> >>> +disabled=3D0
> >>> +enable_on_exec=3D0
> >>> +read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> >>> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> >>>  [event20:base-stat]
> >>>  fd=3D20
> >>>  type=3D4
> >>> -config=3D316
> >>> +config=3D4109
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> >>> +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
> >>>  [event21:base-stat]
> >>>  fd=3D21
> >>>  type=3D4
> >>> -config=3D412
> >>> +config=3D17039629
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
> >>>  [event22:base-stat]
> >>>  fd=3D22
> >>>  type=3D4
> >>> -config=3D572
> >>> +config=3D60
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> >>> +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
> >>>  [event23:base-stat]
> >>>  fd=3D23
> >>>  type=3D4
> >>> -config=3D706
> >>> +config=3D2097421
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> >>>  [event24:base-stat]
> >>>  fd=3D24
> >>>  type=3D4
> >>> +config=3D316
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> >>> +[event25:base-stat]
> >>> +fd=3D25
> >>> +type=3D4
> >>> +config=3D412
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> >>> +[event26:base-stat]
> >>> +fd=3D26
> >>> +type=3D4
> >>> +config=3D572
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> >>> +[event27:base-stat]
> >>> +fd=3D27
> >>> +type=3D4
> >>> +config=3D706
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> >>> +[event28:base-stat]
> >>> +fd=3D28
> >>> +type=3D4
> >>>  config=3D270
> >>>  optional=3D1
> >>>
> >>> @@ -190,8 +234,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event25:base-stat]
> >>> -fd=3D25
> >>> +[event29:base-stat]
> >>> +fd=3D29
> >>>  type=3D3
> >>>  config=3D0
> >>>  optional=3D1
> >>> @@ -200,8 +244,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event26:base-stat]
> >>> -fd=3D26
> >>> +[event30:base-stat]
> >>> +fd=3D30
> >>>  type=3D3
> >>>  config=3D65536
> >>>  optional=3D1
> >>> @@ -210,8 +254,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event27:base-stat]
> >>> -fd=3D27
> >>> +[event31:base-stat]
> >>> +fd=3D31
> >>>  type=3D3
> >>>  config=3D2
> >>>  optional=3D1
> >>> @@ -220,8 +264,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event28:base-stat]
> >>> -fd=3D28
> >>> +[event32:base-stat]
> >>> +fd=3D32
> >>>  type=3D3
> >>>  config=3D65538
> >>>  optional=3D1
> >>> @@ -230,8 +274,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event29:base-stat]
> >>> -fd=3D29
> >>> +[event33:base-stat]
> >>> +fd=3D33
> >>>  type=3D3
> >>>  config=3D1
> >>>  optional=3D1
> >>> @@ -240,8 +284,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event30:base-stat]
> >>> -fd=3D30
> >>> +[event34:base-stat]
> >>> +fd=3D34
> >>>  type=3D3
> >>>  config=3D65537
> >>>  optional=3D1
> >>> @@ -250,8 +294,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event31:base-stat]
> >>> -fd=3D31
> >>> +[event35:base-stat]
> >>> +fd=3D35
> >>>  type=3D3
> >>>  config=3D3
> >>>  optional=3D1
> >>> @@ -260,8 +304,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event32:base-stat]
> >>> -fd=3D32
> >>> +[event36:base-stat]
> >>> +fd=3D36
> >>>  type=3D3
> >>>  config=3D65539
> >>>  optional=3D1
> >>> @@ -270,8 +314,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event33:base-stat]
> >>> -fd=3D33
> >>> +[event37:base-stat]
> >>> +fd=3D37
> >>>  type=3D3
> >>>  config=3D4
> >>>  optional=3D1
> >>> @@ -280,8 +324,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event34:base-stat]
> >>> -fd=3D34
> >>> +[event38:base-stat]
> >>> +fd=3D38
> >>>  type=3D3
> >>>  config=3D65540
> >>>  optional=3D1
> >>> diff --git a/tools/perf/tests/attr/test-stat-detailed-3 b/tools/perf/=
tests/attr/test-stat-detailed-3
> >>> index e50535f45977..8400abd7e1e4 100644
> >>> --- a/tools/perf/tests/attr/test-stat-detailed-3
> >>> +++ b/tools/perf/tests/attr/test-stat-detailed-3
> >>> @@ -90,99 +90,143 @@ enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> >>> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> >>>  [event13:base-stat]
> >>>  fd=3D13
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33280
> >>> +config=3D33024
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> >>> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> >>>  [event14:base-stat]
> >>>  fd=3D14
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33536
> >>> +config=3D33280
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> >>> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> >>>  [event15:base-stat]
> >>>  fd=3D15
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33024
> >>> +config=3D33536
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> >>> +# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
> >>>  [event16:base-stat]
> >>>  fd=3D16
> >>> +group_fd=3D11
> >>>  type=3D4
> >>> -config=3D4109
> >>> +config=3D33792
> >>> +disabled=3D0
> >>> +enable_on_exec=3D0
> >>> +read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
> >>> +# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
> >>>  [event17:base-stat]
> >>>  fd=3D17
> >>> +group_fd=3D11
> >>>  type=3D4
> >>> -config=3D17039629
> >>> +config=3D34048
> >>> +disabled=3D0
> >>> +enable_on_exec=3D0
> >>> +read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
> >>> +# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
> >>>  [event18:base-stat]
> >>>  fd=3D18
> >>> +group_fd=3D11
> >>>  type=3D4
> >>> -config=3D60
> >>> +config=3D34304
> >>> +disabled=3D0
> >>> +enable_on_exec=3D0
> >>> +read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
> >>> +# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
> >>>  [event19:base-stat]
> >>>  fd=3D19
> >>> +group_fd=3D11
> >>>  type=3D4
> >>> -config=3D2097421
> >>> +config=3D34560
> >>> +disabled=3D0
> >>> +enable_on_exec=3D0
> >>> +read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> >>> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> >>>  [event20:base-stat]
> >>>  fd=3D20
> >>>  type=3D4
> >>> -config=3D316
> >>> +config=3D4109
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> >>> +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
> >>>  [event21:base-stat]
> >>>  fd=3D21
> >>>  type=3D4
> >>> -config=3D412
> >>> +config=3D17039629
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
> >>>  [event22:base-stat]
> >>>  fd=3D22
> >>>  type=3D4
> >>> -config=3D572
> >>> +config=3D60
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> >>> +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
> >>>  [event23:base-stat]
> >>>  fd=3D23
> >>>  type=3D4
> >>> -config=3D706
> >>> +config=3D2097421
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> >>>  [event24:base-stat]
> >>>  fd=3D24
> >>>  type=3D4
> >>> +config=3D316
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> >>> +[event25:base-stat]
> >>> +fd=3D25
> >>> +type=3D4
> >>> +config=3D412
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> >>> +[event26:base-stat]
> >>> +fd=3D26
> >>> +type=3D4
> >>> +config=3D572
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> >>> +[event27:base-stat]
> >>> +fd=3D27
> >>> +type=3D4
> >>> +config=3D706
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> >>> +[event28:base-stat]
> >>> +fd=3D28
> >>> +type=3D4
> >>>  config=3D270
> >>>  optional=3D1
> >>>
> >>> @@ -190,8 +234,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event25:base-stat]
> >>> -fd=3D25
> >>> +[event29:base-stat]
> >>> +fd=3D29
> >>>  type=3D3
> >>>  config=3D0
> >>>  optional=3D1
> >>> @@ -200,8 +244,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event26:base-stat]
> >>> -fd=3D26
> >>> +[event30:base-stat]
> >>> +fd=3D30
> >>>  type=3D3
> >>>  config=3D65536
> >>>  optional=3D1
> >>> @@ -210,8 +254,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event27:base-stat]
> >>> -fd=3D27
> >>> +[event31:base-stat]
> >>> +fd=3D31
> >>>  type=3D3
> >>>  config=3D2
> >>>  optional=3D1
> >>> @@ -220,8 +264,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event28:base-stat]
> >>> -fd=3D28
> >>> +[event32:base-stat]
> >>> +fd=3D32
> >>>  type=3D3
> >>>  config=3D65538
> >>>  optional=3D1
> >>> @@ -230,8 +274,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event29:base-stat]
> >>> -fd=3D29
> >>> +[event33:base-stat]
> >>> +fd=3D33
> >>>  type=3D3
> >>>  config=3D1
> >>>  optional=3D1
> >>> @@ -240,8 +284,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event30:base-stat]
> >>> -fd=3D30
> >>> +[event34:base-stat]
> >>> +fd=3D34
> >>>  type=3D3
> >>>  config=3D65537
> >>>  optional=3D1
> >>> @@ -250,8 +294,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event31:base-stat]
> >>> -fd=3D31
> >>> +[event35:base-stat]
> >>> +fd=3D35
> >>>  type=3D3
> >>>  config=3D3
> >>>  optional=3D1
> >>> @@ -260,8 +304,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event32:base-stat]
> >>> -fd=3D32
> >>> +[event36:base-stat]
> >>> +fd=3D36
> >>>  type=3D3
> >>>  config=3D65539
> >>>  optional=3D1
> >>> @@ -270,8 +314,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event33:base-stat]
> >>> -fd=3D33
> >>> +[event37:base-stat]
> >>> +fd=3D37
> >>>  type=3D3
> >>>  config=3D4
> >>>  optional=3D1
> >>> @@ -280,8 +324,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event34:base-stat]
> >>> -fd=3D34
> >>> +[event38:base-stat]
> >>> +fd=3D38
> >>>  type=3D3
> >>>  config=3D65540
> >>>  optional=3D1
> >>> @@ -290,8 +334,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_PREFETCH        <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event35:base-stat]
> >>> -fd=3D35
> >>> +[event39:base-stat]
> >>> +fd=3D39
> >>>  type=3D3
> >>>  config=3D512
> >>>  optional=3D1
> >>> @@ -300,8 +344,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_PREFETCH        <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event36:base-stat]
> >>> -fd=3D36
> >>> +[event40:base-stat]
> >>> +fd=3D40
> >>>  type=3D3
> >>>  config=3D66048
> >>>  optional=3D1
> >>> --
> >>> 2.43.0
> >>>
> >>>
> >>
> >
>
