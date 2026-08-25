Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEBF11CA9
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 04:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787630486; cv=pass; b=lXIeqozABOX1jaJOsIOTWRk/E74Xc9wrUPXha9u8YMp8fkMdEI0uMEDDbNj9O66JsoNPxlHpkdlJuXxRgT7xSw44Kqmlk9zoo8+swt8j12s7fyy2nFCUpvhBmP+F3FdF3g62pn5GLhvHtQ9GagxLmnFiAAh/BeaABtidefJ5SfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787630486; c=relaxed/simple;
	bh=1hsAs+4HXoxPeMgfnNAJkiTHFkaslrxFaBUOhjTULkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HV/FEsjpe1O7NopOVfoZqFH4fBmmN1/e5/qMg+gNHNCtz4ka8lMwqLw9nHwAU2LccFbbhZYtO8My9dMpDkbY5a9SeXqX/9cHQy35omVYqzG9tD0YmMq/dN9IGa2y9KTbH8mGLbvbcHJz7ZCrML2qj00k9j4eNkv0D4zl8WU/Z+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a06JnEYr; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a06JnEYr"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c15a5b265so156091cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 21:01:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787630483; cv=none;
        d=google.com; s=arc-20260327;
        b=U9KYPQ7FaoCCkc17HwnTZKl+BUyGMpMpY5SxN+aYNqe651fKlM/2EKhwM5JgYiTmed
         N2kOSSO5NnBeEL7W/SS0mLmTAcqPA9g5Rs8+pbHoAuNfU6uR6sH9etgiOolLyEi4tLE0
         8WJHT85T5HnYxzGyJJd9E2FUVNx5xSm/zYcn0GTCZdesG8btONAtomRPUQ7NHdQjmIOY
         t2sy8n1UlTk3MU6DtgC/w17FgVnEg1sRAgWD1MK2YyzIZ+vbCxa1V/sdrllWdIkvh63e
         KBytKbF7K1xMoJXVnIPBj4Ka2u3eQ2SSynip3ANTERAr2r/c15AmpflSr5qTqg20/loB
         SwJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1hsAs+4HXoxPeMgfnNAJkiTHFkaslrxFaBUOhjTULkE=;
        fh=thnt9HEPe35/hh5FGu+uEdCxvyNZycYuXgyjT0cOvIk=;
        b=ImAzXBSDTEhdZJ9XlfQvqmGi1wdpy0faJbcDocfDDlGig2LqKryCnqSbQKLxp5LWWH
         8/UiUI7WNygYAFv4w0b93cIxAvFNdOWd4YKgmK/2KoSl2JqEGbKf94xZjvAXjRvJ+5yO
         P3K3C7DUwtQR6ya4CMc39BYaq67eJ69Kpf84GvSOWemAWkLZO+DmU/c2eAfAqZO39CeZ
         l+oGyOwLKYaN/5u+RgvpJJufNcAiH9zcB9WJzN2/SrZUUzsePHzPp8+YdSxpNwMK4ZMW
         c/xXJbWi2O3cljfUFsFAFKBTWclo0KAlQ8bmSLXI+n9iS/jiSDA+/8IpmFJVlEnqvd9U
         ILFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787630483; x=1788235283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1hsAs+4HXoxPeMgfnNAJkiTHFkaslrxFaBUOhjTULkE=;
        b=a06JnEYr9XiYxADW1weOHipSMqCTZHG9LSyhrUPguXW5QdtMO3IAmnCc6EDqO6LLNh
         TGiFZDwAGBvXraH3ZumbYTw4AyyGBdEDcobMpShCpT1jXHk9sJYCiuX7a+xXv3e1IYw0
         gxegeIKZzfoifkWFJKw9UU6O8Yzhjq8X34I8t9kxfsUOGr+P+oGnpSwJn14pgo+3Dxy8
         t6FiqrNGeKb3hd4OZA8xQszboi8HA4ILxtrgmj5b/BagUcbbTZ+RJ1Dpb3osbFO+lAZc
         6Jbv6Gd0QeqA6dW5L4cteBZ+bRpnr6qkKBpMBMseWOBGOBvRwmwcoErYDx4RqcAzD8EP
         C6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787630483; x=1788235283;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1hsAs+4HXoxPeMgfnNAJkiTHFkaslrxFaBUOhjTULkE=;
        b=E8YVTtaHfossJ36CMEunIypPhDNsQRgHNpbxegEoZAiraexBLwjNLuciAuY1C/Z1iv
         Cvxo3ymYZHvHEFCqamm31TYMiiI+fByoz9bx9mLUbb6gr9CagvKnaPceCfHnqwoGlCKH
         LoOOicdJS6jcoFJIvU4K1qycVxCm17V52ZLLuBEXJnNcn3sooNYTQdRiGs1pt2FcjjrV
         aK5YpNKBCjwB92fvyvyelkfM5ryoFvfvNSsJGa5YvGTlj/boicq+sM+OiaZIAK+rUUG8
         VEh4qhjpellerwZIpUluSs+l7D9ls3N6yBDQEXSQUy0Hf07cRBJzJxlQ9cTn+Cb4ROjf
         R4ug==
X-Forwarded-Encrypted: i=1; AHgh+Rokh1GSY9ZfODgdcVvXu6STSkfdvLT4hMefIgjkPcBYE66IAeGNGpsStmVH78fVo63LqvHNkxINMG8Rce0pEu+f@vger.kernel.org
X-Gm-Message-State: AFuF++lJGk7c3Afq4KgUZ8aXMz3W0bkJotJ8Frp/UIqLlen/u1NBw6Zz
	Fgf4sT8PSX4KtNRrB/dJJ9I/KSOHN9Wy4DLQOtMoEjblokqH1cteMiCejV7J3hrQDb5R7R6awfu
	26/5BiqHfC32MEUB7JxO6tTaWYwa5Dc9bPAU37stM
X-Gm-Gg: AR+sD12uo3S9PJcvVmwxdPw/sjqrQ3gm/C9gFDf1+ZZtKGspxoN9sUzY2Vi3nInWwNA
	IMBzG3ASl57R7VMNCTjpPjuNusxwkU+bTrUWa0SgXILtdJ5uHOjSg5pxXdCtwAYt1GCIHzxoFDy
	zdpAajloPLbB+qLFo/uxizP/VBELGsFwI6GI0mK2q8E4QJR55K3i8fw5eisKgBhyzNFwKoWIJo2
	y9lTi/l/mWEck/cim0P9IpzdxRUT7wjk8j8LPA6cjILtNsUo7ZCXUW5hWR6EDRtQCuplnK500s1
	SewAWDJO463RcOWMQ1ndylagISqtOwenACGxeQ3SG+xTXA==
X-Received: by 2002:a05:622a:1c09:b0:52d:9d62:6163 with SMTP id
 d75a77b69052e-52e30936070mr9858121cf.9.1787630482652; Mon, 24 Aug 2026
 21:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813132519.4099508-1-andi@firstfloor.org> <20260824063744.1533837-1-irogers@google.com>
 <20260824063744.1533837-2-irogers@google.com> <aozKea7UWmKNSED8@firstfloor.org>
In-Reply-To: <aozKea7UWmKNSED8@firstfloor.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Aug 2026 21:01:11 -0700
X-Gm-Features: AcwNN1WnbaZE-cWOARz2NPFqRylM01pON6_qhheKQiJ7np4fadC2j2xla5NeR7c
Message-ID: <CAP-5=fVomzznYEYHG=Y9wYLdznFhH7JhgyixVLazOUwcikuMzA@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] perf evlist: Implement evlist__can_merge_hybrid
 using first_wildcard_match
To: Andi Kleen <andi@firstfloor.org>, acme@kernel.org, namhyung@kernel.org
Cc: ak@kernel.org, ak@linux.intel.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 3:49=E2=80=AFPM Andi Kleen <andi@firstfloor.org> wr=
ote:
>
> On Sun, Aug 23, 2026 at 11:37:38PM -0700, Ian Rogers wrote:
> > Add logic to dynamically identify mergeable events spawned from the sam=
e
> > wildcard alias via first_wildcard_match, breaking reliance on hardcoded
> > PMU metrics or type IDs.
>
> I'm not fully sure what first wildcard match is. That means just
> matching on the name? FWIW I think it's ok for common cases, but there
> are definitely also cases where the same event doesn't quite mean the
> same on hybrid cores.

So you've pretty much got it from the name, which I'm glad about. The
first wildcard match originally came from events like data_read on
memory controller PMUs. We have 1 evsel per PMU, and the first PMU the
wildcard-ing (originally done with fnmatch) hits is special due to the
aggregation of counts in perf stat. Now it doesn't make sense to say
aggregate memory controller events with data_read say from a storage
device PMU, so there is fix up of things done in
parse_events__sort_events_and_fix_groups:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n2126
parse_events__sort_events_and_fix_groups is too complicated but a
large part of that is down to perf metric events and we've covered it
in tests. I think we should revisit the one PMU per evsel at some
future date and change it to multiple PMUs per evsel, as that more
closely matches the command line parsing. The code is slowly evolving,
and I believe the memory controller PMU aggregation logic I carried
forward originated with Kan Liang.

One thing this series suffers from is determining the first wildcard
match in `perf report`, as that data isn't recorded in the perf.data
file. In that case, the 'M' logic tries to infer the first wildcard
match from the event names. If someone did `perf record -e
cpu_atom/cycles/,cpu_core/cycles/ ...` then this would look identical
to `perf record -e cycles` and so this would be an argument in keeping
the existing non-merging logic first.

> but anyways as long as it works for "cycles" it's fine because
> that's nearly everyone uses with perf top.

Well, I think that may be misguided, as users might think cycles is a
proxy for wall clock time. The lower frequency and IPC on an e-core
mean the lower counts aren't representative of wall clock time. For
this reason, I've included individual percentage breakdowns for each
event along with the total. However, since we are sorting by total,
things may still be misleading, so I've added the text in the tips.txt
file.

Anyway, this series involves a lot of work and isn't as user-friendly
as I'd hoped. For example, pressing escape from the merged view
doesn't unmerge events in perf top. I think this change is preferable
to your change because it is more generic in how events are handled
and supports `perf report`. That said, if I'm about to go 12 rounds
with Sashiko over these changes, it would be nice to have some
positivity from people who could lend the patches their tags. For me,
the status quo is tolerable, and my reason for sending these changes
was to show the direction I think the code should take. Sending a v2
of these changes is low on my priority list.

Thanks,
Ian

> -Andi
