Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756D6202C3E;
	Fri,  1 Aug 2025 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068503; cv=none; b=Dsy8TyuJLM9+IL2j0Dg6NYTEjRwWsmJZLYNSikjBZH/JVHb7tBFynsq+WES6Rahq2eTm/NfDO4+Bq9EO7mo79Mt7o3emZ3xZ35seEs7kCzK7Xws/cVoObq2XufJjo+NBNIKlr+OqPFLga94fEfls7sqvQ3w+ZOwA26sVFs8qAAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068503; c=relaxed/simple;
	bh=fm9FSGdQ8aBXWIkvQuiZZ2mFIbMCNCRpgEAoKdwzvaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXJc/VG7rpUi3wBW6aN2IDUckZlZEe1LlQEV6LAvm00bfVzrZiAH0vmmRAhPQbs4FvrSgnFGqjZnOPMjU9KYDTUM0mqQQozDkKs/tWbWCi4CIBoEh9ig5X5HssFnsqTFU47cr8dbOpni0WmjsvMe4Bp+q9HXrilijt2hsLrBBOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b1fd59851baso1305049a12.0;
        Fri, 01 Aug 2025 10:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754068502; x=1754673302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anVai9RwNeOh1S9jP71MYxNE6adlG4MgcT+N0OnSJy0=;
        b=J0QdWJcgo1NuSuprQ7pahcfRlKGuQ5mELF5INgsKoS8qefVvRrOBAeocm3wNM2jyC1
         CILUpFfy/mDPEP5XKlkIpAZe7avH2m+Dkl6tmo7upHeA8xToQ8V5ONfUFvtn+gLLYbxE
         b69sZt09qAt1SytZTyImrTZwLUuky2A9AvegBdIsd5gVIROf6R14S+MPZYsgFRa8Hn2T
         cw3jRTQwZxPmQaqe2IqPr3/B5npHz3D8HLyuPcLhA5SqU2c3G90FgkutEwa0AsEj0O/j
         03mY99SNHZxPWzjfiWAVLX4A8n/2Z4eH8PkJcL4v8LBzV6NB9DhPRcAMssfciC9u9fOh
         GqKg==
X-Forwarded-Encrypted: i=1; AJvYcCUOVYXYXseQPXIRWufhOpKjCDHlSQPZGTyDZJT1tj83DcqDWLqjbeSCuDaM0kuiGp2HpfzvdOL5ziYmFxgXmp3ccA==@vger.kernel.org, AJvYcCWsqhqqRoG8yLXiMjf8+Rk6Ft6477l4/IYILXamu2P1oirHM07hPnn9B4BekuP5q75luOIaZXcEHKy4EnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAIO4kt4L6jtHM+x36SVgwxtBoAEkWIiEX+Y9VwmUszslYdxmQ
	cMsNVCCL61WYewKbBOFOMylbzpqsAs+0FdXZxgfyQDyBo3SZsf5S0EGMQQZlzGA9b52Si4l6e99
	/XJDKrmK3mRaAIaQYvJPgLLvqvTfeYkI=
X-Gm-Gg: ASbGncsw98Gj5huhLVlZVZhCmc2bNY3E08RPZszujwT8MYVkityX//PIQuZaLt7s0R0
	dbTHrVlyfy9K4ZJhA6NthVeZQey+XnppxzGU/hV3M3ADiILnc+jsinaLqMMhjnvsbR8MwBkAaOV
	V082W3d0Tlff9bbvZkir8GeJlPBa7Zf+ee7b3F8C3jhx/COpuNHl99PUYNe5OzuQLIpmTuSlFni
	vQl+stafnqzvI3Nynl1xWosh7RDSZVndbAC4If2
X-Google-Smtp-Source: AGHT+IFk0qmUqcXFOzPH+qq0vtHSa9cKcU9Z09DZMB/cMDqNJRPSnC02lRUNNXUrj9UiE2gR58BNdOYACfJY6eVk+Lw=
X-Received: by 2002:a17:90b:1350:b0:313:2754:5910 with SMTP id
 98e67ed59e1d1-32116207254mr772758a91.15.1754068501505; Fri, 01 Aug 2025
 10:15:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731070330.57116-1-namhyung@kernel.org> <aIt9bTQhAo8G3oqH@x1>
 <aIuoDHBGeoFYF2fh@google.com> <CAP-5=fVeCriJk5OSEdr0poREL3QNZOO4XDAbbuBPPtczv54d8Q@mail.gmail.com>
In-Reply-To: <CAP-5=fVeCriJk5OSEdr0poREL3QNZOO4XDAbbuBPPtczv54d8Q@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 1 Aug 2025 10:14:48 -0700
X-Gm-Features: Ac12FXxrbnIsyeaC8qmdiEYTzXfz7NwURB4PCMzz-O6IQTOID3O8OG40BmMnGjU
Message-ID: <CAM9d7ci__tkn5qo9B00jvt=WXmM1czMGX1-mc=8m=xsOFw3VYQ@mail.gmail.com>
Subject: Re: [PATCH] perf record: Cache build-ID of hit DSOs only
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Thu, Jul 31, 2025 at 5:10=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
>
>
> On Fri, Aug 1, 2025, 1:29=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>>
>> Hi Arnaldo,
>>
>> On Thu, Jul 31, 2025 at 11:27:57AM -0300, Arnaldo Carvalho de Melo wrote=
:
>> > On Thu, Jul 31, 2025 at 12:03:30AM -0700, Namhyung Kim wrote:
>> > > It post-processes samples to find which DSO has samples.  Based on t=
hat
>> > > info, it can save used DSOs in the build-ID cache directory.  But fo=
r
>> > > some reason, it saves all DSOs without checking the hit mark.  Skipp=
ing
>> > > unused DSOs can give some speedup especially with --buildid-mmap bei=
ng
>> > > default.
>> >
>> > > On my idle machine, `time perf record -a sleep 1` goes down from 3 s=
ec
>> > > to 1.5 sec with this change.
>> >
>> > Good stuff, and this is in line with the original intent, don't cache
>> > uninteresting things.
>> >
>> > But now I have do some digging, as this should've been the case since
>> > the start, why would we go to the trouble of traversing perf.data,
>> > processing all samples, yadda, yadda to then not look at it when cachi=
ng
>> > files?
>> >
>> > The whole process of reading the build ids at the end is done here:
>> >
>> > bool dsos__read_build_ids(struct dsos *dsos, bool with_hits)
>> > {
>> >         struct dsos__read_build_ids_cb_args args =3D {
>> >                 .with_hits =3D with_hits,
>> >                 .have_build_id =3D false,
>> >         };
>> >
>> >         dsos__for_each_dso(dsos, dsos__read_build_ids_cb, &args);
>> >         return args.have_build_id;
>> > }
>> >
>> > And that dsos__read_build_ids_cb thing specifically looks at:
>> >
>> > static int dsos__read_build_ids_cb(struct dso *dso, void *data)
>> > {
>> >         struct dsos__read_build_ids_cb_args *args =3D data;
>> >         struct nscookie nsc;
>> >         struct build_id bid =3D { .size =3D 0, };
>> >
>> >         if (args->with_hits && !dso__hit(dso) && !dso__is_vdso(dso))
>> >                 return 0;
>> > <SNIP>
>> >
>> > So it will not try to read the build id if that DSO has no samples.
>> >
>> > But, that was written before PERF_RECORD_MMAP* came with a build-id, s=
o
>> > it _will_ have a build-id and thus checking if it has hits is needed.
>> >
>> > In the past DSOs without hits wouldn't have a build-id because
>> > dsos__read_build_ids_cb() would not read that build-id from the ELF
>> > file.
>>
>> Yep, I think that's the reason.
>>
>> >
>> > Ok, now that makes sense:
>> >
>> > Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>
>> Thanks!
>>
>> >
>> > This could have a Fixes attached to it, one that doesn't fixes somethi=
ng
>> > that is not working, but speeds up processing by overcoming an oversig=
ht
>> > when adding build-ids to MMAP records, so I think a:
>> >
>> > Fixes: e29386c8f7d71fa5 ("perf record: Add --buildid-mmap option to en=
able PERF_RECORD_MMAP2's build id")
>> >
>> > Is worth.
>>
>> Sure, will add.
>
>
> Sorry for the issue, I hope the market dsos is correct. I'm not sure the =
fixes is correct as that patch called out not populating the .debug. we sho=
uld make sure that's still the case for people already using --buildid-mmap=
, they shouldn't have the .debug filled in. Sorry for my lack of a plain te=
xt email.

That's guarded by rec->no_buildid so it shouldn't change the behavior.

Thanks,
Namhyung
