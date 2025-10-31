Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2371A348860
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938757; cv=none; b=RcIJfWG+ixaH9VGETVtR5jwnlSMr01cJ0vmUlGU+GFcqNwpiJ16g3sLp4dZdqh9xVQC8Qq4gSs8JBlzkdaV6u+41/IRwr4XFH425EpSNkoB5l/B0cHoHoYCc7dwBNFrlXIgqryWC6WKt5cvsyqHGWqfjZdpexnHoOn7God/5bJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938757; c=relaxed/simple;
	bh=c2TsvyTWrVZGTaIImbvIOApNfjq5iJ1Dmw+puLX+QkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duqmW/JlbrHIg12eE3OOUz7A3y7J9yaGboqAfues+xru7BW7q7UWOmfO95aa1WIX40FvgQvIEsHCsQu7XXezyBkILSKTLTd+xO8rwEs2n0GSbEvyz69I92impxKbE4rVz0DDY4mCCcEoK2Nz9HN7yA8dpsOu+W3YNaIu3jk3OC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F1H+K7aI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F1H+K7aI"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27eeafd4882so40975ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 12:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761938754; x=1762543554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXN3QSneAV+LtUTQM86o2HjgAq6280HmRY0Dttiu0qk=;
        b=F1H+K7aIPM+VOp6T5+XHuiSuUAyq9gXmXob6zhi9SfSmnKkbnCtZGMwsLYN1mTrX3n
         EsQT/gQRk6xYzPFs7iplcHDgudbY4/1VECCzEEwbTUB5puHPcb+lFYTh6y8dDm2ENOzi
         15e97OD/NEFY411q4eftWt+6vxZIFDzHp3RnPQ5Qiha46XiCapcTzi9bhHuyRw4/MQJy
         HIXZ1s3994/jvmyJ6dyN0zFx0s0HlJofiUhhBDO5dMmueIUlC+UNvtqUQnvKh3yF9F9G
         +9T0BKRkIcqjyfTaLw5DK9tE7twisvE/lH7x/oSfoMmX8L2bipPhq6Hzbv2F+sFfSb/p
         l1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761938754; x=1762543554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXN3QSneAV+LtUTQM86o2HjgAq6280HmRY0Dttiu0qk=;
        b=ZsW2zKn8ZWWImA6Yq8H1n8/V112UMABjbu1FfwUSphM1xhc+AjgbKv7PQSbu3TgBiE
         LFzDqc50v9SwuenwT5cf7TChm6YjThrMuaihjGe/LK8i0yhhmQ2dlmMfAvj+oKU8y/2D
         J8FqemH0LKOMntBS2flz8Q/RiRYcocUcc93eeanJ6IR4b9LpAPVTNvNGjirXDKYfSg12
         MQt0DhUH79bJwBI6WT/KlnE2kiyNpEXdXUajFEbalImtWh37nRHE01F3fsYEXQ41lu/i
         IJxu1hGna/wpCcxDs4QMRAwJS6hkmQjTdFmO/O2PXxxOnmUwEAi+atZ2vaF0XmGxB8tQ
         nOVg==
X-Forwarded-Encrypted: i=1; AJvYcCWDlPwmRvcZVVH2f3Vys1w+cHuvk9ouft4s780M/vdX1XqNSheHyr5eMo8OQUGFMDPQBFdw369WjQfe2dM3x6+2@vger.kernel.org
X-Gm-Message-State: AOJu0YyJDCewVlqugSJhV71M/3RBKwjntq6qsfyYxU67gPPPBK2dk+lq
	IAbBjLLfhHpqsY8+kSmZCN990g+QLDTIJe9FVxMcYE6ArrW1k9RedoIJQ2BBW85msWeK7qki7qX
	T0UMtsN9mWaRThKO05Mecerh6rI4gW83NTFs/V1N6
X-Gm-Gg: ASbGncs4nAHw9kKZR8d7u+OF9Rhj7dFBcOHRs3D0aQqloKv5/M4HSbfDtq6v60WJLKX
	tSLvvZQdXeEwlKgNI17grspGX0ETF2JBMxQe0NEeGBwyg1HROINHwtreS1rei6iLqXrKXrPb6dh
	y6uLff8N9ououAnlKa71y0Zb4+qJzPt78RlF02HUtR6IxbTn9tTDUSSLYwEQIBIknZ52OOd5rrQ
	PnaCeIuH8IO3QTH6Q/Pt0p7BGlDXwmXO1e5byJZJtdeig2bgpOgN07yRqWJMXmmU3dp7vHZ/N1Q
	gjunq6/j9osgGq4=
X-Google-Smtp-Source: AGHT+IF2ZnhzO0PkICUSI/4JWGimVXMbvArpvXSNHUCaMw2KOYfAr/qaZF+O3CeI7714Yuq1nPrt8dEzX0C0A63a2SM=
X-Received: by 2002:a17:903:2341:b0:271:9873:80d9 with SMTP id
 d9443c01a7336-29554cb25cdmr634865ad.7.1761938753853; Fri, 31 Oct 2025
 12:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519232539.831842-1-namhyung@kernel.org> <CAH0uvohxb4gvHYswCZMvCrrOn=0qSOeOaYyDVPEFb4GPhwntgw@mail.gmail.com>
 <CAP-5=fWZectSpLzkfJUj-W-_oxhDJdnnOE18ET_iPb+bjmTdHw@mail.gmail.com>
 <aCz-wD2Syq8mj2_0@google.com> <CAP-5=fVNgN5Budwaao_GqrZRN2wSrvo7CQySU-D9eEpnwBhY2A@mail.gmail.com>
 <CAP-5=fXyxrM4eEjo1AMjBTuC2duqxZLcOPpdqudYQeWQfUiVuQ@mail.gmail.com>
 <CAP-5=fVBXUeEH2oi6NU2Hs5GCBUqW7BMVUJ6=LDTBfmb=xoL3Q@mail.gmail.com> <aQUJHMtTQ5IVBQ2x@google.com>
In-Reply-To: <aQUJHMtTQ5IVBQ2x@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 31 Oct 2025 12:25:41 -0700
X-Gm-Features: AWmQ_bmldGhhoXMlvtjine70xYyfBm0JQuTKlaPirFn6fgNogVNJ3HwOSePtvvU
Message-ID: <CAP-5=fWumaLVt4DbSXXHmJ-9Y-hTyj9K61s2E8m_xZY+ux5nLg@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Increase syscall handler map size to 1024
To: Namhyung Kim <namhyung@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 12:08=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Thu, Oct 30, 2025 at 01:47:55PM -0700, Ian Rogers wrote:
> > On Mon, Oct 13, 2025 at 1:22=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Thu, Aug 21, 2025 at 9:45=E2=80=AFAM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > On Tue, May 20, 2025 at 3:14=E2=80=AFPM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > Hi Ian,
> > > > >
> > > > > On Tue, May 20, 2025 at 08:05:37AM -0700, Ian Rogers wrote:
> > > > > > On Mon, May 19, 2025 at 4:36=E2=80=AFPM Howard Chu <howardchu95=
@gmail.com> wrote:
> > > > > > >
> > > > > > > Hello Namhyung,
> > > > > > >
> > > > > > > On Mon, May 19, 2025 at 4:25=E2=80=AFPM Namhyung Kim <namhyun=
g@kernel.org> wrote:
> > > > > > > >
> > > > > > > > The syscalls_sys_{enter,exit} map in augmented_raw_syscalls=
.bpf.c has
> > > > > > > > max entries of 512.  Usually syscall numbers are smaller th=
an this but
> > > > > > > > x86 has x32 ABI where syscalls start from 512.
> > > > > > > >
> > > > > > > > That makes trace__init_syscalls_bpf_prog_array_maps() fail =
in the middle
> > > > > > > > of the loop when it accesses those keys.  As the loop itera=
tion is not
> > > > > > > > ordered by syscall numbers anymore, the failure can affect =
non-x32
> > > > > > > > syscalls.
> > > > > > > >
> > > > > > > > Let's increase the map size to 1024 so that it can handle t=
hose ABIs
> > > > > > > > too.  While most systems won't need this, increasing the si=
ze will be
> > > > > > > > safer for potential future changes.
> > > > > >
> > > > > > Do we need to worry about MIPS where syscalls can be offset by =
1000s?
> > > > > > https://lore.kernel.org/lkml/8ed7dfb2-1e4d-4aa4-a04b-0397a89365=
d1@app.fastmail.com/
> > > > >
> > > > > Argh..
> > > > >
> > > > > > We could do with a map that combines BPF_MAP_TYPE_HASH with the=
 tails
> > > > > > calls of BPF_MAP_TYPE_PROG_ARRAY.
> > > > >
> > > > > Right, it'd complicate things but I think it's doable.
> > > >
> > > > Should we merge the x32 fix while waiting for the hash fix?
> > >
> > > Just a reminder that this is still not resolved.
>
> What do you mean by the x32 fix?

This patch is the x32 fix. Your commit message says:
"Usually syscall numbers are smaller than this but x86 has x32 ABI
where syscalls start from 512."

We started discussing a hash table based fix because of MIPS, etc.

Thanks,
Ian

> Thanks,
> Namhyung
>
