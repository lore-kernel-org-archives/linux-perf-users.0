Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C8256D
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965475; cv=none; b=fei23BpxjVddQigoNoVlNldCJIOUy6hMUKoGk0isEtdBLkkGKNJBpmzFJWd6CfW+/Gqeef2rHrow5qJY7CqTZSbDNlGJnRFmZY4RLCLtMh/OLVMxsmVz2C8smXUYyWlrHsZ1L0+UZF70eu7Po/xbn6Gz1EPiM6a1UZ5lIQffWrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965475; c=relaxed/simple;
	bh=hIWYQmgi+tTgEFG2lyUwORseyuXaCHVkCN7klhvZLdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxhFg+QjDTTbnwQmggYuQ5UHunwtib88RFPRA9sGX5JlWGNkYi+MgriRdMeZ4Y9Bbbmai4A90t7blK4dr4AjRv7Ic+9H0XdnKdCVCxRxfSKSzRSXrYlguy43C7+5VDbRBnXL/MYTt3m1Gx66oLj10RxAWHq4RHTJV3sF06ZITOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNxA8mwr; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNxA8mwr"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so32355ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 13:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731965473; x=1732570273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuhqAqfA2k3+QXec2SnmAIZqNnwk6Bh65zBb0ZhL35g=;
        b=iNxA8mwrgPSDhJXMhsvXlI5f0COmjEmI6e8eVLfDaWcE2Ec4QHFLZOiocyBriwC8gU
         hl6N4nAfJUOhuNxzYsHJSNMs/pszwgevAj4m81iSFKWL69xsL4+QFmRq1Nx4zvQqIaYG
         YoxUe3ZNfIFfDOO+RS/rjkoHwGL2BUSpt7uyd86A7i36clz/KTYx1pxXWVAk3kaaWbUy
         KOqNvGfMGz6ghyWntt/xypbcpPgGfHhqK1pFrBN0YrFUwVpb0lyH1nH8VtH6d3V+fTyY
         iejnIqvAapX1I9MK7SD6Y+lDyW/cnxrn9BcO5JFknUWgBhsPsBuc/GE9RBUAMvD2uRvT
         TJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731965473; x=1732570273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuhqAqfA2k3+QXec2SnmAIZqNnwk6Bh65zBb0ZhL35g=;
        b=eALEWBw6Tnpq2m1vzB2AGgVntrxQnbfGYlPc8j2s+g8VpDyDjJ8m3ia2eXNjjqXv5u
         tJoA70ltTidqUzl6C0tmU8eBEdIb/KiFgg7Gnor9ifJmLJUoIIq2oZim20zuktXQbswG
         iSRquOOfqrrXUdFYw7E2e3g6xjPShTb/5LvCv1jD2ABP8+GWGlM7qUgp4FHbC8SYem/h
         86lgEZlq99A7ER6P08d+2YxRH4lyQ9NRdo1ryc62TvrTd5SpIBCyo6WubT+aITfUdTRd
         8O8YoNN9lIYW1LiBNEXWnI+dsH0HFAnZ/hIFQL1qlrGWhWLtki6VI+A/jV9TTZbyA5t9
         0Tpg==
X-Gm-Message-State: AOJu0YzHSxvtw5vZMcCQvRQ7B8gQYf82MZBm6LRF1ZPldeenwWRPUuL9
	gMyjrIb83M+0H9flKzc8sitcO0RTNwLjw4PslH06uCnzRujQF3F4e/iWFUTs6rBs4dC9CCNlE9t
	hjAHF6EoYK2sXGHzyfLMvsjg7D3VdxCYXOiOD
X-Gm-Gg: ASbGncsbVoOFCa4VVFYlHWiWE+GVjuLRKQ8+NGw9jeWS87iPLpy722a1KZTF8zrDzJo
	7w0xPXhZbb5pjQsSF/fsVV+wsG/tHQjBghxnTba6SSmzCJ98f30Oj2HvVaX0nTwE=
X-Google-Smtp-Source: AGHT+IGvLP20vuIvv9mLw4xpYIF7WVVZC7Ts85FHTylNPXFsCqt1gtZHgS0UlpxBHirm3xoMDaaB9w0f2x6Ca3KmJ7I=
X-Received: by 2002:a05:6e02:1b03:b0:3a6:af68:667e with SMTP id
 e9e14a558f8ab-3a7782b1887mr948525ab.28.1731965472664; Mon, 18 Nov 2024
 13:31:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029144347.25651-1-vmolnaro@redhat.com> <CAP-5=fWAH1qzLrFhVjrJBu33NSfqktM30thUohC-zA+94_sf_g@mail.gmail.com>
 <e969a01b-b6c5-4632-b626-e1e3938989ba@redhat.com>
In-Reply-To: <e969a01b-b6c5-4632-b626-e1e3938989ba@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 18 Nov 2024 13:31:01 -0800
Message-ID: <CAP-5=fWfjB9O_oR7k5xCoKYHVL3t6tppvemZewW=q2PWh-da8Q@mail.gmail.com>
Subject: Re: [PATCH] perf test: Parse perf stat Topdown events for aarch64
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com, 
	mpetlan@redhat.com, peterz@infradead.org, mingo@redhat.com, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.co, kan.liang@linux.intel.com, 
	yangyicong@hisilicon.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 2:04=E2=80=AFAM Veronika Molnarova <vmolnaro@redhat=
.com> wrote:
>
>
>
> On 10/29/24 16:25, Ian Rogers wrote:
> > On Tue, Oct 29, 2024 at 7:44=E2=80=AFAM <vmolnaro@redhat.com> wrote:
> >>
> >> From: Veronika Molnarova <vmolnaro@redhat.com>
> >>
> >> The 'perf stat' output on aarch64 machines with topdown events wasn't
> >> counted for in the 'perf stat STD output linter' test case. Add the
> >> topdown metric to the skip_metric list as it is done for topdown event=
s
> >> on other systems.
> >>
> >> The Topdown events are also disabled on aarch64 KVM guests because the
> >> value of caps/slots is set to 0 due to the part of the system register
> >> being a stub. This prevents the metric for the topdown events from bei=
ng
> >> computed, leaving the 'perf stat' topdown metric without any value at
> >> all. Add the "TopdownL1" to the skip_metric list as well to handle thi=
s
> >> possibility.
> >>
> >> Before aarch64:
> >>
> >>     100: perf stat STD output linter:
> >>     --- start ---
> >>     test child forked, pid 403305
> >>     Checking STD output: no args Unknown event name in TopdownL1      =
           #      4.3 percent of slots  slots_lost_misspeculation_fraction
> >>     ---- end(-1) ----
> >>     100: perf stat STD output linter                                  =
   : FAILED!
> >>
> >> Before aarch64 KVM:
> >>
> >>     100: perf stat STD output linter:
> >>     --- start ---
> >>     test child forked, pid 404671
> >>     Checking STD output: no args Unknown event name in TopdownL1
> >>     ---- end(-1) ----
> >>     100: perf stat STD output linter                                  =
   : FAILED!
> >>
> >> After:
> >>
> >>     100: perf stat STD output linter:
> >>     --- start ---
> >>     test child forked, pid 404777
> >>     Checking STD output: no args [Success]
> >>     Checking STD output: system wide [Success]
> >>     Checking STD output: interval [Success]
> >>     Checking STD output: per thread [Success]
> >>     Checking STD output: per node [Success]
> >>     Checking STD output: system wide no aggregation [Success]
> >>     Checking STD output: per core [Success]
> >>     Checking STD output: per cache instance [Success]
> >>     Checking STD output: per cluster [Success]
> >>     Checking STD output: per die [Success]
> >>     Checking STD output: per socket [Success]
> >>     ---- end(0) ----
> >>     100: perf stat STD output linter                                  =
   : Ok
> >>
> >> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> >>
> >> ---
> >>  tools/perf/tests/shell/stat+std_output.sh | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/te=
sts/shell/stat+std_output.sh
> >> index cbf2894b2c846a04..0f7967be60afdc7d 100755
> >> --- a/tools/perf/tests/shell/stat+std_output.sh
> >> +++ b/tools/perf/tests/shell/stat+std_output.sh
> >> @@ -13,7 +13,7 @@ stat_output=3D$(mktemp /tmp/__perf_test.stat_output.=
std.XXXXX)
> >>
> >>  event_name=3D(cpu-clock task-clock context-switches cpu-migrations pa=
ge-faults stalled-cycles-frontend stalled-cycles-backend cycles instruction=
s branches branch-misses)
> >>  event_metric=3D("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" =
"frontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" =
"of all branches")
> >> -skip_metric=3D("stalled cycles per insn" "tma_" "retiring" "frontend_=
bound" "bad_speculation" "backend_bound")
> >> +skip_metric=3D("stalled cycles per insn" "tma_" "retiring" "frontend_=
bound" "bad_speculation" "backend_bound" "TopdownL1" "percent of slots")
> >
> > I saw similar issues and sent:
> > https://lore.kernel.org/lkml/20240417183219.1208493-1-irogers@google.co=
m/
> > but got distracted. A difference there is automating the generation of
> > the skip_metric list rather than hard coding it. Hard coding may be
> > the most pragmatic thing to do in the near term.
> >
> > Thanks,
> > Ian
> >
> Automating the skip_metric list generation would be great, but for
> the time being, we can stick with hard coding until there is such
> possibility.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
