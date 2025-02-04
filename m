Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A479E2147F6
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Feb 2025 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684758; cv=none; b=FH4B3puWcg6pKqj8TJjYVvUHsjDeLitInh1Ypp4aTH45Irffel2ZLmNX84A1JfnxHZDpgm6WCh+v/EJQLfwNBlqTBWRsUCwMTD2cf5AePQrc0AxwsURFz7cdpRxkaPGZaRhCZjzVpuTeB1u2SKoDQC2iS/BBr9vOJaA5AlxOpAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684758; c=relaxed/simple;
	bh=5i/Y8zvwma5m0qjxbZ1Fo7U5gAawdWdvzgbemBgeKNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrNiCnJiA4mRPXPPSDcUMqV0ZEYUc7TdEKqGOjY8ZE8yRT8VcF49McwofPUdtA469bYyCqabAddOFsikP5Lj/kAQ/LMTFFNCsEIvcttvCOS8MyrZOZGuqj+r+j5BT1XYHiu0UwANebdy9rvqEgbM/nWveUkOJ5x5GaN0LfLExYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YWiqzRJr; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWiqzRJr"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d04b70fe79so30965ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Feb 2025 07:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738684753; x=1739289553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8roB2k/aXo76JhJB8t9pm/ESNWX82k0droQLLf7sA0=;
        b=YWiqzRJrPa+le/18cMtxj73t3RhUUBQICmNIcXNjQ6+M1JErvlcjui3e5ZMD6WCIJC
         udZetOHgjjOTW8BUmfXIs/DNZ/9+qMNXNji8g6ZTxW+DKqFaqXH5U0T4Nn64ViG3Kkw5
         wDf5wwzHMAhAjfEKurCuoJ9k54C4uADF72RIwGPWMRmng9V7kd2FwoN3kuV4bmuECIbr
         Y9ZFiPhnKRWubYmJRbDaTHIV8SeeQjp8oTK25vP+UWwwyYKNn+0pcRRj4YWq8vpFrEoK
         myhN6XRQoFsUaoz17kjQD0EAQw1B/+sdF/IFtpmvMF83o4+xpNwKcYvJf0IpyPesbgyv
         eFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738684753; x=1739289553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8roB2k/aXo76JhJB8t9pm/ESNWX82k0droQLLf7sA0=;
        b=ALqxqZmKQ+axfbUwAYXp5G2HN++UGGPRzoADs0IFc9CBudhTqP5r31+ds80lY27PLE
         072roJxILQc+6RYXo1L5wn4GXSdIfkNNNCMjyAYcGWbMIHNgtjmrj+Bdsh4DrxqL8xiC
         OsZQ+Q+JDHQHXElwjxFlPvzsH+7zbCk075vvnNd0uqR8wXzyM/AEwnHNcZWyzuGr7Ef6
         W8OgoEcJWvaqVEmd0oYHB9AH4xRUSmcAF1l/HynAseln/C2JYYZg5Ko8bshXgBFFI/Ka
         XvXRx69SosRGBl0mkEj5uoKlosEveQdLYFb7gi2t0s1/fN+LANYpRRFp3Nu8bMH2Iqyy
         nO5w==
X-Forwarded-Encrypted: i=1; AJvYcCVuFz2vDOM1wdBOdoUZ9ZCunh6mscl3AZkvtCBK9DYPTZURZYf20OgduoiyeQ18l4D1/CBL+OOjfglQjcdtzJnh@vger.kernel.org
X-Gm-Message-State: AOJu0YwaTeZ13WYrACGVJTqWjrjCJB68tuErkg4Bs5Ws4AKlVZmhMxoE
	yFnrbL21BdYlqEsv/dfD4qakUilypjRfSwmE+vXkCOCXupO2QVIEF+43zertAho5o9gf4xYF3uX
	vJNwkK7EP+PISlFOdUoOgNmhKe58J7SD56mxv
X-Gm-Gg: ASbGnctNzuhPD0Ui8/X6BBEauO8X3tPVc1qzpniVBoQ/kVtgZmi7Z8jvVWrRtHc0PN8
	H611siWy3b0tN8kT4Asb9TT9He4LROdxYgFk/vLfcH2Ow/GiDztVX95wbmRGzl35uZPHz57etB6
	PSYD9nSQh5j5v+lIr28OIwtkQ=
X-Google-Smtp-Source: AGHT+IFn3oe3TOYlUvP1hm251ItKyjv+s3unlb/z1vl69ZziybSzR14r3BFMyL/cDl56jqIbUMQYbzxO5y9V9kTP4z0=
X-Received: by 2002:a05:6e02:1a86:b0:3ce:79c5:56e0 with SMTP id
 e9e14a558f8ab-3d040f53289mr3523025ab.9.1738684753587; Tue, 04 Feb 2025
 07:59:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130030525.1482498-1-namhyung@kernel.org> <20250130030525.1482498-2-namhyung@kernel.org>
 <CAP-5=fVJDi2UuhTYk5g-QaLqZC29tAprKWs_0PKNmd+y=iugjA@mail.gmail.com> <Z6GCde4XqCuEZlgz@google.com>
In-Reply-To: <Z6GCde4XqCuEZlgz@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Feb 2025 07:59:01 -0800
X-Gm-Features: AWEUYZmurQeFx436MfzVGQG1Cg-n0O0xRTM7xFqFOWVQYWuKHdbwPWICSKvdmgI
Message-ID: <CAP-5=fVrFzxcLZG8DyYh2rbd3u4133V6hhrQFCHsq_QMVVW=9g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] perf trace: Allocate syscall stats only if summary
 is on
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 6:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Sat, Feb 01, 2025 at 10:57:00PM -0800, Ian Rogers wrote:
> > On Wed, Jan 29, 2025 at 7:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > The syscall stats are used only when summary is requested.  Let's avo=
id
> > > unnecessary operations.  Pass 'trace' pointer to check summary and gi=
ve
> > > output file together.
> >
> > I don't think this last sentence makes sense.
>
> Thanks for your review.  I'd say:  Pass 'trace' pointer instead of doing
> 'summary' option and 'output' file pointer separately.

This still doesn't make sense. There is lazier initialization:
```
-               ttrace->syscall_stats =3D intlist__new(NULL);
+               if (trace->summary)
+                       ttrace->syscall_stats =3D intlist__new(NULL);
```
and there are functions that take a FILE* but now we're going to use
the one in trace instead:
```
@@ -1568,7 +1569,7 @@ static struct thread_trace *thread__trace(struct
thread *thread, FILE *fp)

        return ttrace;
 fail:
-       color_fprintf(fp, PERF_COLOR_RED,
+       color_fprintf(trace->output, PERF_COLOR_RED,
                      "WARNING: not enough memory, dropping samples!\n");
        return NULL;
```
So why does the one passed to trace still exist? Unfortunately names
like "fp" and "output" are not intention revealing.

Anyway, from the commit message and the code I don't understand what
this change is trying to do.

Thanks,
Ian
