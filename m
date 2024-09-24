Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65336282F4
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727207268; cv=none; b=N9KBiSSnqWBOj70YGdrlz50/51wrsr4q6vOa9Kdur6/4fdztgZdyes3L8fwd3j/EMlgJ++96s63d3NQ6Iniz26PWnZXs6iMCX685acORI/yZj4UQs6X+dQFWAclhBpnSlX5WcfBD9CB5L5XhPRlUp7EW0I655gshMEvGJHp/LoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727207268; c=relaxed/simple;
	bh=QClgoslELJ0tXsri/9j512t9Q7F9GKSu5A9+Hq+3HcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1xVXfMezgaDi+sP3EKWEFHtaqHuibSaDmvuU1lFURPblkp5BrzCrVyG+ZGvvR24A6cQFhcY2OBupjS/SWbAqyqfnmp09iyRyQXPsJYZ1CM0UnmZW3de2Mps0k8V4ZCeSjaAjTqB4YU7n8aHnkIs4AWMw76BBVWd/efBN2czCv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oZG3Klzm; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oZG3Klzm"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a045f08fd6so37275ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 12:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727207266; x=1727812066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJqKovxYFTQndPXWLlrenLbPbcsd/HugwQeMg+Pp7+g=;
        b=oZG3KlzmrGJsp3C8vhK8bCdiCUPKmkIKrVXsDjcUk5Aek0uldhCiRTGsdJi9VpKVF0
         1PQzHtXCApr29xCFmXFV1cJlbPfwqOgVu1d7gVK1pD3rai/0cirPhVV8/HZ1vx/iECoA
         jdn3pzx1VBtJHDTFKCfsK6gfumicIZ32g+DxaI48/nNG10SGkW4CDge6w00i4X4uwGnj
         g1lD5uGxhmTq0PcDBpyTtTdEi64OzfTWgPtGVGEaL79o2jon+efjaFJhtmalJjQD7fYC
         O5RstP3uK74/oA2FQnSjmoebeeCCtJVe4XoriEm0SPEJsFz7buz5OFSf2CCmFYYDCuK3
         7Fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727207266; x=1727812066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJqKovxYFTQndPXWLlrenLbPbcsd/HugwQeMg+Pp7+g=;
        b=aVgGVwUSmjeFj71ffLecB/BVQmzcHrCDolt1mACGyzMJoAExPCN93TDLjPe1fEQnqe
         Ce8wwfTEDBsYCklV5+zO8+g2eCnxRhAVx+ODt1pn+0M3cIHcEbOvyRyRtCk1v1K6VyED
         1Vtp2+2gGRbemMTCHtI7gRKZqRnEtkIWfaFB1r8vUhNpHq52YsteMebz5jUvmKfiFmpt
         TKpxws0LXZqq0217H9S+eohBXK/cZ63Ox+t5dLo1SfhbJ+jyWBlpd5j2efHBlffATIQ+
         9fsLR21GCnm7/Cf+PfMd09svCOOhfDxizxtcVV9d2wvbiO2aA7o8XwZEQuXJRScZC0UI
         GsjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuMtWP7eGtEHbCQZCHxaC4bWfEUhECJLDof3vEyfIcmCSJSulX30yOgBajaZaigaUIDnYD+fZkH/2ovgYurTw6@vger.kernel.org
X-Gm-Message-State: AOJu0YwgYfI8zFJar6TGPlGq2q4f2Bur34bhdlXVRfLMefWaQAt3Qu4L
	6xYTnaZJr34vqF4ldNp+LWaPgfwp1U7uLfHAwdK2W+TtsnNvBZ+C00vYE4aSzBbNuZKCpUgPRRL
	rAFxLNhUEoocNl9n+xOr7iI8HH2ZAgBct8JZU
X-Google-Smtp-Source: AGHT+IEVbTgG75x9ZykfAl2vL+tTJI2I6ssfKY8z1aRWgoi72aWmvRo6IYVtV/fp3mesZrSlY5No1RB9vwyXUZrvC8A=
X-Received: by 2002:a05:6e02:1185:b0:3a0:926a:8d35 with SMTP id
 e9e14a558f8ab-3a26e513d7amr444805ab.17.1727207266300; Tue, 24 Sep 2024
 12:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924003720.617258-1-irogers@google.com> <20240924003720.617258-3-irogers@google.com>
 <de38a809-1968-4d6d-b1ed-1f47e8762ee2@linaro.org> <ZvMHfB1f_GbtRqSp@google.com>
In-Reply-To: <ZvMHfB1f_GbtRqSp@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Sep 2024 12:47:33 -0700
Message-ID: <CAP-5=fXCtcHiA0SgEZNe6KQBq+rFb2b8ar7awjvUiDOB+0M_SQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] perf probe: Fix libdw memory leak
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Hemant Kumar <hemant@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yang Jihong <yangjihong@bytedance.com>, leo.yan@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 11:40=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Sep 24, 2024 at 10:17:08AM +0100, James Clark wrote:
> >
> >
> > On 24/09/2024 1:37 am, Ian Rogers wrote:
> > > Add missing dwarf_cfi_end to free memory associated with probe_finder
> > > cfi_eh or cfi_dbg. This addresses leak sanitizer issues seen in:
> > > tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> > >
> > > Fixes: 270bde1e76f4 ("perf probe: Search both .eh_frame and .debug_fr=
ame sections for probe location")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >   tools/perf/util/probe-finder.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > >
> > > diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-f=
inder.c
> > > index 630e16c54ed5..78f34fa0c391 100644
> > > --- a/tools/perf/util/probe-finder.c
> > > +++ b/tools/perf/util/probe-finder.c
> > > @@ -1379,6 +1379,11 @@ int debuginfo__find_trace_events(struct debugi=
nfo *dbg,
> > >     if (ret >=3D 0 && tf.pf.skip_empty_arg)
> > >             ret =3D fill_empty_trace_arg(pev, tf.tevs, tf.ntevs);
> > > +#if _ELFUTILS_PREREQ(0, 142)
> > > +   dwarf_cfi_end(tf.pf.cfi_eh);
> > > +   dwarf_cfi_end(tf.pf.cfi_dbg);
> > > +#endif
> > > +
> >
> > I noticed that c06547d converted an _ELFUTILS_PREREQ(0, 142) into
> > HAVE_DWARF_CFI_SUPPORT. But there is still a mixture of both in the cod=
e
> > (unrelated to this patch). The commit message doesn't say why it is bet=
ter,
> > just that it could be changed, so I'm not sure which one is right.
>
> I think HAVE_DWARF_CFI_SUPPORT is better since it reveals the intention
> clearly.

Let's just nuke the conditional compilation, the CFI support is in
libdw (calling it dwarf is just actively confusing) is 15 years old:
https://lore.kernel.org/lkml/20240924160418.1391100-7-irogers@google.com/
https://lore.kernel.org/lkml/20240924160418.1391100-8-irogers@google.com/

Thanks,
Ian
