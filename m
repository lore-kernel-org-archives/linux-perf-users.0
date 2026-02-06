Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28B52D0C63
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770415311; cv=pass; b=Buwg8chdeS3w8CA2FRpdTtftdiY18zUqpamLcuolOpLeBciNrxomq1p9WZm//3vA5zCx/z8GT+Dfhji9uPQcAbXn5FBMvH1iyKEDRnlwbA/oMN/S7YSMOCopm/qLedS1TIQU+yVz79gPo45hSmOCHMbQrsGJ47lpPJTOXBYh2aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770415311; c=relaxed/simple;
	bh=riKVq0nCiiXsIaTMP1jt4u1nWldRcaRTJKuJkfVC4Mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJJAmyxkFJ5N1QbDl+o3lXWPjrhXee366d6egWITLzs/29GB1Yxgw7xxuuKcT4S5g35eKD8o6e6Wyiw2Hozb3AHUAbhgQU87oj+zkhv63O4MQS7VkjloMLSAy1MHL8iwhZ8tc5OeEG0iYOJrUzKBJmxuewe36/U4wF8Cf6el+yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sZv8hxhc; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sZv8hxhc"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a964077671so675ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 14:01:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770415311; cv=none;
        d=google.com; s=arc-20240605;
        b=D8Xz+jSoj2XBGZaXiT+odT4q/+TWF6x7EP1IjEbAlCvySs/Ye7Oevlwpva7strTY0v
         pQfRN+fj5tFQp4y5xvYzL/Fqi+GtxTxfU6YwMaKrpx1gF9K/IxUzhKy5ImjzaQQUGotS
         Tx8f+g0rMmJAyeFQfoGvo/fOeXAdfP+ixmbMBXwDZPBXtt+6JLcmO+B39ZAGejV4/tvR
         cKkcHvMTzmR4ztviqN0q5t96OUDJKa317qgt3oIT5qQxpfVNf57PTGv9OYw5q2YEXNQN
         Js/fMcghW8VvuVHJRc1iCncfREfoFxWCHK2+cSeJ3srmX5pbg6FXv8EJX1uuIwvEhWi1
         LY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=imdPqUf5Brx7T2Iz/sa/rfWQH1OpmIoy6vm1ya4dgwM=;
        fh=XGEzqHm0MIQw4THR5ziJfh/cZTPVa+bJPu4yatOmE5A=;
        b=N+6yGSegXJQRRfc8zLgB3+jSQp9Ll5vSakM4tV2F3vURnrVva36wZML5PPAVrFkXl8
         VRd9N52tZ4hEuhPDxdZpCg/NRfPx8fhCF+d7ztBJl0L6DuO/QQQMuBEYfCnsevM9RX0y
         F4oVF1Bhn2CIjbSMBhEXJ1qKxypGeV4hYoiCbjgMQameO10R88IBJNZGR2mPj220G/7w
         geedSzpL/4oibbmu7g4v1EwiiMze0Lz9R29gsoN+p7D+ny4Ir/gIoYsOQlKHm6RpPgS/
         QVpZLK0JccDqfGWC1GEwgE8JR0msXfFkCxCD4zt1mliptFaD2UouXYR3ICHMUcauLUg0
         8ZEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770415311; x=1771020111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imdPqUf5Brx7T2Iz/sa/rfWQH1OpmIoy6vm1ya4dgwM=;
        b=sZv8hxhcJrJxHMcpjVpePMa4s502MMdD0/w+EE9iiHKbL8S4yKoPCsEkGYJbLrWA2q
         p6/qJF++bFNxnbrGzaXTSERPUCrv6iYxPHXzSclaWjy7MK5AhrPVICkXo2FDXpBtB/zN
         3HQgEaPwSKtogRC+AQAa9nCt3BL3mG679NHdHj+k23GvYi0g7NyBMBvRgOQqnI30Lhos
         YStDXH/iSED6rJWQK6kj+ZCkGuW1uYa5w7rRupK5vDyaDNg+hYQOrJRihKyb1xpiY2sc
         8yGs/WH7A/EhIcQFO1j+g0+VTOjDSkMbhkYtFJvU2ClQ8fa0xrLqniUuZ6m0ffwmREi4
         SIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770415311; x=1771020111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=imdPqUf5Brx7T2Iz/sa/rfWQH1OpmIoy6vm1ya4dgwM=;
        b=A74ka2ZqEjlJjrpxfVWm2Zit9q/zuA420n4HjuR5D40P94GfTsDMxOZ2eme2whda3y
         XOYKc2tuqBBpfuVPjDLaWZ9qU9891jStIoLAQeBfy2p0xfdPZa8s2d1UG1SrbwxrIf0U
         mppVs5Lq/w8V6Pc+mfp/mDOX8PWMq4prQ5vAoB/NCuIDPPfZmJxdB42/thQSMUUVMDYT
         6wedpQ+YcS6AhD1y9oPQSl+Y7PEXuCo/aQ6D/X6a7XeSfGmdxWQJKhT0SJ5J797MtGFV
         N5oFoeBN6d/ZMex5bAfjG+9WYTkf6ktWbw0/RuaL5lddHJXe2o/VwEXJWhbnA7hipt1e
         Jdeg==
X-Forwarded-Encrypted: i=1; AJvYcCXmykC6Z+9jzGlMXs0RaarC+1pIz0tpocluZ7beNAtwpNGldUK50E7Yo6BG8lG4dcVAMLxZSlWOQFOlpaEMTPKk@vger.kernel.org
X-Gm-Message-State: AOJu0YzqqU2h1PyBU90dFpGiioflAPLwCGV+ak0E0mddkyY68249fj/F
	Qe/dZHeRCCyV7M+pHtI5bEdOEhLHUfhUngC1fweSzvr7yALMumyZ6UJcpMy0/etuZIKYAiuv+2s
	FzR1kXLsXDDW1wlS4B39qwLylA5H7pdnntjPKRB9Z
X-Gm-Gg: AZuq6aLpdhTYK5PJRi8XVvMiQwTURNQAMTGrGeipS9hIbeQeDXvjrUCQGJ797DqMCi/
	cayFOP08xfq9tDYYfGOoH6p7rOK+2relVgu1/fW7ieJVYI02RZQ8yxL5nsZVePvanlJcsmORUQ3
	WbcGAQuGz5Vp+wW+OvvfEzpjICKeT0Utv2AnkULjr/j2tSQUUTbNDPT58x1RJ+oiDAlzlzfAm+G
	B1OeuoSR1bVMpv5GpG8KvyXBcrEpG6cjNKUot0cl7+n6l7e6EnTDJxKGEG68tJ192iFppaA
X-Received: by 2002:a17:903:17c4:b0:299:c368:6b1f with SMTP id
 d9443c01a7336-2a961ee4d1dmr770025ad.18.1770415310628; Fri, 06 Feb 2026
 14:01:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203225129.4077140-1-irogers@google.com> <aYZeuP5NlZ4gFacx@x1>
In-Reply-To: <aYZeuP5NlZ4gFacx@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 6 Feb 2026 14:01:37 -0800
X-Gm-Features: AZwV_QjBVApbOuPpRkCdNvvHNhxwdlN8IP4AKyDOdXTneIC47emecjMma3uwThc
Message-ID: <CAP-5=fVKn5HSxKPDBrmVXchRu9HAL3Nb7ikKptKejHMOxR-yMg@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] perf stat affinity changes
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, James Clark <james.clark@linaro.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Andres Freund <andres@anarazel.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 1:35=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Tue, Feb 03, 2026 at 02:51:23PM -0800, Ian Rogers wrote:
> > Change how affinities work with evlist__for_each_cpu. Move the
> > affinity code into the iterator to simplify setting it up. Detect when
> > affinities will and won't be profitable, for example a tool event and
> > a regular perf event (or read group) may face less delay from a single
> > IPI for the event read than from a call to sched_setaffinity. Add a
> >  --no-affinity flag to perf stat to allow affinities to be disabled.
> >
> > v7: Revert "perf tool_pmu: More accurately set the cpus for tool
> >     events" that caused issues with user specified CPUs (Andres Freund
> >     <andres@anarazel.de>). Fix a null test is prepare_metric so that
> >     missing events can't trigger segfaults (Andres Freund). Make the
> >     CPU map propagation improve the CPU maps for tool events that only
> >     read on index 0, this allows later setting when
> >     evlist__create_maps is called with the correct user CPUs. Rebase
> >     previous non-merged affinity changes that hadn't been picked up
> >     yet.
>
> Not applying to tmp.perf-tools-next, can you please check?

Will send a rebase on tmp.perf-tools-next shortly. Could I interest
you in some second servings of build improvements while you wait? :-)
https://lore.kernel.org/lkml/20260203164323.3447826-1-irogers@google.com/

Thanks,
Ian

> - Arnaldo
>
> > v6: Drop merged tool event change. Move TPEBS fix into its own patch
> >     1st.
> > https://lore.kernel.org/lkml/20260108212652.768875-1-irogers@google.com=
/
> >
> > v5: Drop merged changes. Move tool event reading to first
> >     patch. Change --no-affinity flag to --affinity/--no-affinity flag.
> > https://lore.kernel.org/lkml/20251118211326.1840989-1-irogers@google.co=
m/
> >     On v5 there was discussion with Andi Kleen who points out that
> >     affinities will work better with real time priorities but using
> >     this requires privileges.
> >
> > v4: Rebase. Add patch to reduce scope of walltime_nsec_stats now that
> >     the legacy metric code is no more. Minor tweak to the ru_stats
> >     clean up.
> > https://lore.kernel.org/lkml/20251113180517.44096-1-irogers@google.com/
> >
> > v3: Add affinity clean ups and read tool events last.
> > https://lore.kernel.org/lkml/20251106071241.141234-1-irogers@google.com=
/
> >
> > v2: Fixed an aggregation index issue:
> > https://lore.kernel.org/lkml/20251104234148.3103176-2-irogers@google.co=
m/
> >
> > v1:
> > https://lore.kernel.org/lkml/20251104053449.1208800-1-irogers@google.co=
m/
> >
> > Ian Rogers (6):
> >   Revert "perf tool_pmu: More accurately set the cpus for tool events"
> >   perf stat-shadow: In prepare_metric fix guard on reading NULL
> >     perf_stat_evsel
> >   perf evlist: Special map propagation for tool events that read on 1
> >     CPU
> >   perf evlist: Missing TPEBS close in evlist__close
> >   perf evlist: Reduce affinity use and move into iterator, fix no
> >     affinity
> >   perf stat: Add no-affinity flag
> >
> >  tools/lib/perf/evlist.c                 |  36 +++++-
> >  tools/lib/perf/include/internal/evsel.h |   2 +
> >  tools/perf/Documentation/perf-stat.txt  |   4 +
> >  tools/perf/builtin-stat.c               | 114 ++++++++---------
> >  tools/perf/util/evlist.c                | 156 +++++++++++++++---------
> >  tools/perf/util/evlist.h                |  27 ++--
> >  tools/perf/util/parse-events.c          |  10 +-
> >  tools/perf/util/pmu.c                   |  23 ++++
> >  tools/perf/util/pmu.h                   |   3 +
> >  tools/perf/util/stat-shadow.c           |   7 +-
> >  tools/perf/util/tool_pmu.c              |  19 ---
> >  tools/perf/util/tool_pmu.h              |   1 -
> >  12 files changed, 237 insertions(+), 165 deletions(-)
> >
> > --
> > 2.53.0.rc2.204.g2597b5adb4-goog
