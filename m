Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB815FB9C;
	Thu,  8 Aug 2024 03:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723089519; cv=none; b=SyleEVp6rdqSmOJhPEXfFFDe49wZmzokE0Q6KYC0HL8gxaIpK1tiNt/gKzkY+1+X3On3LrNYpMGpndbkumDJ7ZuPah0PhbFD/g6fygNNIvsV8vts6arcf7WYplKog0BfVEIFmcS5/1xaWkkowes4XzFMQYNH6HPNjRMkUAVCO38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723089519; c=relaxed/simple;
	bh=Ko4WY2u2LKJaZw4KMHOzOZ0DLZctoeMfEWI4iTxs8Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emojo+MHl80ciPCfWVDjWcmtIoOMoWpbwO2PSvhOnSpPYBR+xeBeGkDSnBkO1QsRl8vMLu39e+UMUD65f+2lf/PiP1CmkjEx9d93UonZisUjicVcg6sc6TXmhLdr2OHr6WBE39YCO7p7yfODPSn4tihcu44G53fCcxI4vBsAnmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlGAPmfU; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlGAPmfU"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dff17fd97b3so503768276.2;
        Wed, 07 Aug 2024 20:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723089517; x=1723694317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6H+J7gyW248YbZemlc+1uERhUVoaYKarFsZhFfXjhg=;
        b=TlGAPmfUvKiQ+sClgwv1TrxO8Jv9O4DTTal4lbn1lXN1mRsPClqa249FMygZSC/s9c
         byCQzoQ9tzcpfMK3I7h9kbtXyBUYa5X4K6SvWN6v8YqjeW7pgvs+xC2jP2rm3Sozy1Kw
         w7moQpkUXYn92bebc/gLyffSToztZzUv2C8Oor7kn5xmLVmow0kQTV6nH0danBSISifG
         VCd7+cVW94ppoxUiWUGr8JO5p5mYgXb6eP1tWH7JGbj4Whh4Z334zQ0wTLM/0AZdw4Sy
         q0Pfl711yDPImm/PPLoaCD0sfEMIAB18mpbWgV1cdKtps4RiazD64sO+DkWp8IhMiN95
         zsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723089517; x=1723694317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6H+J7gyW248YbZemlc+1uERhUVoaYKarFsZhFfXjhg=;
        b=onRPBBxhZLNVRHDg3oAyJJNfc7wbZ7LlNOZg/DCIdhkTe9G5C3z1Y2j85ga9u3Surx
         DxWc5MVOb0obpd1buOvZXeA330U4mDOebNXDMhgu3kSUbNHI7YK0QnMJ7UXTzV3PQUKC
         PL+9kkCPl/Ttdo65xjbFn2XY6ZHJzdsVhhOPLi1BfBxjvbxm8ZZ9iXYTvj5plLMJBOSm
         C+GJLXoh6SuPbjaEBvMiz5q/3ImsudH/flf14PnBhjFdldIuEJpF1NU6gEPFmNV56hh4
         KFFMg/RFDWFug7mSmXW/7M9DYz89Xf2+P6iIZ+2hUMwbyH8hprpbXfeDmSr78HnwqYiK
         2RvA==
X-Forwarded-Encrypted: i=1; AJvYcCX7V4HFSIK2odxF3g0cIPkZDyswjEB7fkitOrymmgeESIO7UeESs83rfBjSpoaOpOoWoSEmfCSypPkMTPn/PGd4qmakS0/CtG735Uc6/f/VBFSl28uYLlogMS8eOcoOnTFWe5bOUCapiEK3z5Ge1Q==
X-Gm-Message-State: AOJu0YzuRw3zbCS+AkcDsCytDL3SqEiB4s0YbtTp5r0aM/h8LfpnpXu/
	rniAXnWNweHuPEFFAQAj3yIUPKFwn5RTy6xiZ3i1RR99SGZnK4cnTSvuDYPXIVM1hp9Eq7QGeeR
	/rlkT9633iXbe7zTWbUz8r8cWA8Y=
X-Google-Smtp-Source: AGHT+IFtX/TH+DhR5ZlVXkh35kFjDykqjTAVEcs0mIVtd1h8WlOvpjmXonMige64j7m6yUfqbXVLw/0q23IYe7UEKuo=
X-Received: by 2002:a05:6902:2b0c:b0:e0b:f0cf:5ef2 with SMTP id
 3f1490d57ef6-e0e9dbc2040mr874481276.47.1723089516728; Wed, 07 Aug 2024
 20:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807153843.3231451-1-howardchu95@gmail.com>
 <20240807153843.3231451-2-howardchu95@gmail.com> <ZrQBbMiIt1NCvxbY@google.com>
In-Reply-To: <ZrQBbMiIt1NCvxbY@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 8 Aug 2024 11:58:26 +0800
Message-ID: <CAH0uvojQORE2WJziQ4Ru8vsZzr6OLsnn3HOVRkWHW4VFzpKkEg@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] perf evsel: Set BPF output to system-wide
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

The event does open, but bpf_perf_event_output() in BPF will return
-95(-EOPNOTSUPP), so no output. I think this EOPNOTSUPP is not in
bpf_trace.c's __bpf_perf_event_output(), but in perf_event's
perf_event_output() called by BPF.

          <idle>-0       [001] d..4. 154921.079230: bpf_trace_printk: err -=
95

This is also a bug in perf trace -p <PID>.

Thanks,
Howard

On Thu, Aug 8, 2024 at 7:21=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, Aug 07, 2024 at 11:38:35PM +0800, Howard Chu wrote:
> > pid =3D -1 for bpf-output event.
> >
> > This makes perf record -p <PID> --off-cpu work. Otherwise bpf-output
> > cannot be collected.
>
> I don't understand why it's necessary.  Why isn't it collected?
> Is it the kernel to reject the BPF output event to open?
>
> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/util/evsel.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index bc603193c477..b961467133cf 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -2282,6 +2282,10 @@ static int evsel__open_cpu(struct evsel *evsel, =
struct perf_cpu_map *cpus,
> >
> >                       test_attr__ready();
> >
> > +                     /* BPF output event can only be system-wide */
> > +                     if (evsel__is_bpf_output(evsel))
> > +                             pid =3D -1;
> > +
> >                       /* Debug message used by test scripts */
> >                       pr_debug2_peo("sys_perf_event_open: pid %d  cpu %=
d  group_fd %d  flags %#lx",
> >                               pid, perf_cpu_map__cpu(cpus, idx).cpu, gr=
oup_fd, evsel->open_flags);
> > --
> > 2.45.2
> >
