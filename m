Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F312D758
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Feb 2024 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711310; cv=none; b=YNVb8rCiETJ64v12+LvawGu3ZrGL9vPDNC9CvaIfXrhDumztL85TmORZxVl5pdu6YHIRtItwExuat936pAqddx4k14mMZc2HtBfzR9h7Rle3gFSyx+bT+vkWjY+BQReB9DwrLj6dNNTSB/NB2DqVk1Dpgcv2mn7OYxGgDUgxYYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711310; c=relaxed/simple;
	bh=d93vKEyBUqSMfgszb7nKKMpMuQ2x+DYfOVS+gdJdKpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofiR/5S0wqB5NybThijeanaAkFuFOvQOgRPtshxL//lCpmHHSX40xL4UhGZJNUsV5wVSf2yTLVSnwfDdzwnx3eO9Qvq95bjyUNTzbH5qmj9eZrkSSMaNdkPG0sGr1LwyjiYKksILhH/aCONSwlRly/IeIwVRWA9Kg+M1t0kPw84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LIIedOCC; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LIIedOCC"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-428405a0205so8441cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Feb 2024 10:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708711307; x=1709316107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRHX8SRb/g3ONTdNjk+xLg/313XUSVGYWCF8v1RW8cY=;
        b=LIIedOCCrQrCTDIanKbTBDa5M9KBgSXuJ/EG7ZzTJXsxtM8xhV6vDvZAQfjuRWik0a
         j4z9cNJBlSAihXOo6+UnxUek8YdjLhmbcSgDa/Tzyu3a8MkCCNGPfSN4GG22ngqjyBZK
         6Ra58W77OaRgUhECT3wkEzBaLWTIaPjuPpBFyPgr2qOWK6z9pG0wcfK6g2sr9o3iRaFH
         cJzLAamxTStMPINA4dpCA38ERWR5sJrreJWKMAcyQVWQOUh3nybgdBelSzOWEmqxYQD0
         lzAlONAbbMOBwpnC/YAbJMeEOpEIImrt6pR3oBrNpsCogngeznjahSgwLgqoz+f0WW5U
         JAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708711307; x=1709316107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRHX8SRb/g3ONTdNjk+xLg/313XUSVGYWCF8v1RW8cY=;
        b=mF88lnzij6Q15YsQaZth9sAPLwbhyv8eseFotdyZiyk2VrrFZ44IafpWEAJCBF34lq
         jL15aB1jlmit5y8fHfHh/ieHhYCx5laIZCQ5LKxYrCADltlo/ALb9ffbr+AS7pzcpq+d
         pY9gKC1uoFbJbtQwdTTS29hTAdeULgOu0LeIklrQH2DPEEROO8cnmWQP9yaNTFYML5i1
         RO/rRjMzr1OrMUnAGFHC0tqPuK9nHtOgIV9DuNAGCkwqjSgZIosiJcFyRnsUnG9w3rZG
         FQBGzeOVDmhUzv9DXh0furDIEVs5rjCrOG2OVZWLDbRRP88C2BmyWaD3byCVx8cteHII
         PsaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU60snV8w7XPoYHWii68RnDcLk5LhwPA7uRC6iFp6+W0P/EU5/nf/VgyqWIxqR8eDY8t5CtR/w3z/z4+2lSV9CVnyqYxiR+Zj3DBZFVYu5b/w==
X-Gm-Message-State: AOJu0Ywwqs/j2iYzhCGL+nD40MjmrNKEyC76+Rc9EHOuC8sL0IsOHvpd
	aUk/Rj2OyeZBl1E8h7EpNviBYeW46FgHCepjiTtnZQ6uR2g8o2Gx40+4GOjrbByUTqfC/OGnfsy
	tpsT9kirJQdJtva/MlkyQTDbZkhhCm9uojYT3
X-Google-Smtp-Source: AGHT+IFjd7LBMxrromnLqLyLXYjRoUlQc0+pZBSVa08jNHz7xjSQcCyQ/TFpeC7YkZ+vu00vxgg0LSWFAqtuVSa+nzc=
X-Received: by 2002:ac8:58d0:0:b0:42d:fb39:def4 with SMTP id
 u16-20020ac858d0000000b0042dfb39def4mr10595qta.24.1708711307057; Fri, 23 Feb
 2024 10:01:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221175210.19936-1-khuey@kylehuey.com> <20240221175210.19936-2-khuey@kylehuey.com>
 <CAP-5=fXsv7TJ_SVOZc38fN0gn+7cWBcMWt3FdVLcs5v0_vO=uw@mail.gmail.com>
 <CAP045AoSHWoOP3TN=6Hf2wZj7X9Y41sThBQWCDZ3BEP68qeTBw@mail.gmail.com>
 <ZdemibZepMqWvv6U@x1> <CAP045Aqc6woHGYKJG4d=x4gPd0=PmrLeFv25Rkts1a8xFuocOQ@mail.gmail.com>
In-Reply-To: <CAP045Aqc6woHGYKJG4d=x4gPd0=PmrLeFv25Rkts1a8xFuocOQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 23 Feb 2024 10:01:31 -0800
Message-ID: <CAP-5=fXzidk9hLm5bek3q1crds4mEjdgpq=s0YCSzLCj1GtvzQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Test FASYNC with watermark wakeups.
To: Kyle Huey <me@kylehuey.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kyle Huey <khuey@kylehuey.com>, 
	"Robert O'Callahan" <robert@ocallahan.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 9:35=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrote:
>
> On Thu, Feb 22, 2024 at 11:54=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Thu, Feb 22, 2024 at 09:55:36AM -0800, Kyle Huey wrote:
> > > On Wed, Feb 21, 2024 at 10:36=E2=80=AFAM Ian Rogers <irogers@google.c=
om> wrote:
> > > > On Wed, Feb 21, 2024 at 9:52=E2=80=AFAM Kyle Huey <me@kylehuey.com>=
 wrote:
> > > > > +       if (fcntl(fd, F_SETFL, FASYNC)) {
> > > > > +               pr_debug("failed F_SETFL FASYNC %d\n", errno);
> > > > > +               goto cleanup;
> > > > > +       }
> >
> > > > Thanks for the work! The perf tool and perf test should run on olde=
r
> > > > kernels ideally without failure. I'm assuming this would fail on an
> > > > older kernel. Could we make the return value skip in that case?
> >
> > > Ah, hmm, I wasn't aware of that. This would fail on an older kernel,
> > > yes. It's not possible to distinguish between an older kernel and a
> > > kernel where this fix broke (at least not without hardcoding in an
> > > expected good kernel version, which seems undesirable), so that would
> >
> > Take a look at:
> >
> >  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/tools/perf/tests/sigtrap.c?id=3D650e0bde43f35bb675e87e30f679a57cfa22e0e=
5
> >
> > To see how introspecting using BTF can be used to figure out if interna=
l
> > data structures have what is needed, or if functions with some specific
> > arguments are present, etc, for sigtrap we have, in the patch above:
> >
> > -       TEST_ASSERT_EQUAL("unexpected sigtraps", ctx.signal_count, NUM_=
THREADS * ctx.iterate_on);
> > +       expected_sigtraps =3D NUM_THREADS * ctx.iterate_on;
> > +
> > +       if (ctx.signal_count < expected_sigtraps && kernel_with_sleepab=
le_spinlocks()) {
> > +               pr_debug("Expected %d sigtraps, got %d, running on a ke=
rnel with sleepable spinlocks.\n",
> > +                        expected_sigtraps, ctx.signal_count);
> > +               pr_debug("See https://lore.kernel.org/all/e368f2c848d77=
fbc8d259f44e2055fe469c219cf.camel@gmx.de/\n");
> > +               return TEST_SKIP;
> > +       } else
> > +               TEST_ASSERT_EQUAL("unexpected sigtraps", ctx.signal_cou=
nt, expected_sigtraps);
> >
> > And then:
> >
> > +static bool kernel_with_sleepable_spinlocks(void)
> > +{
> > +       const struct btf_member *member;
> > +       const struct btf_type *type;
> > +       const char *type_name;
> > +       int id;
> > +
> > +       if (!btf__available())
> > +               return false;
> > +
> > +       id =3D btf__find_by_name_kind(btf, "spinlock", BTF_KIND_STRUCT)=
;
> > +       if (id < 0)
> > +               return false;
> > +
> > +       // Only RT has a "lock" member for "struct spinlock"
> > +       member =3D __btf_type__find_member_by_name(id, "lock");
> > +       if (member =3D=3D NULL)
> > +               return false;
> > +
> > +       // But check its type as well
> > +       type =3D btf__type_by_id(btf, member->type);
> > +       if (!type || !btf_is_struct(type))
> > +               return false;
> > +
> > +       type_name =3D btf__name_by_offset(btf, type->name_off);
> > +       return type_name && !strcmp(type_name, "rt_mutex_base");
> > +}
> >
> > > mean the test would always return ok or skip, not ok or fail. Is that
> > > ok?
> >
> > It should return:
> >
> > Ok if the kernel has what is needed and the test passes
> > Skip if the test fails and the kernel doesn't have what is needed
> > FAIL if the test fails and the kernel HAS what is needed.
> >
> > 'perf test sigtrap' also checks for the presence of the feature it
> > requires:
> >
> > static bool attr_has_sigtrap(void)
> > {
> >         int id;
> >
> >         if (!btf__available()) {
> >                 /* should be an old kernel */
> >                 return false;
> >         }
> >
> >         id =3D btf__find_by_name_kind(btf, "perf_event_attr", BTF_KIND_=
STRUCT);
> >         if (id < 0)
> >                 return false;
> >
> >         return __btf_type__find_member_by_name(id, "sigtrap") !=3D NULL=
;
> > }
> >
> >         fd =3D sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cl=
oexec_flag());
> >         if (fd < 0) {
> >                 if (attr_has_sigtrap()) {
> >                         pr_debug("FAILED sys_perf_event_open(): %s\n",
> >                                  str_error_r(errno, sbuf, sizeof(sbuf))=
);
> >                 } else {
> >                         pr_debug("perf_event_attr doesn't have sigtrap\=
n");
> >                         ret =3D TEST_SKIP;
> >                 }
> >                 goto out_restore_sigaction;
> >         }
> >
> > - Arnaldo
>
> I think perhaps I'm barking up the wrong tree here. This seems like a
> ton of work just to write a regression test. Maybe I should be doing
> this in tools/testing/selftests instead?

The problem is detecting support for the feature in the kernel. The
BTF approach isn't that bad, a couple of finds, but I think in this
case there isn't anything to be found to indicate the feature is
present. I like the perf test as perf tests are a form of
documentation. Perhaps just using TEST_SKIP here (rather than
TEST_FAIL) is best and the skip_reason can be a presumed lack of
kernel support.

Thanks,
Ian

> - Kyle
