Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA87256D
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Apr 2024 01:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712279806; cv=none; b=QGJPkL0OHwixsHZlpOpV1mAMi05T4JN9s+6lYx/AMSmegkv0QKTf3azUVu61ydPdNlIW8BAMOhG4ZasBALp3A5hOZtJ6HXvisyHeHd1nZribxypIvvgoE0gIHSp74C6PguossOijALAPc89Xm00UUFnCgQcYV2Y3D6IxZMljnuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712279806; c=relaxed/simple;
	bh=2/2Kj338jH+uBPSbzYrJGs8uligsmRJYmh5N5iDFTMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6d0hmVqcIwYZDb0Kn4F/PmeG9giwVDvsz1EEWx+NBet3ct0hFdNi/fD9ui3RSgfNv5PLkazm+M/KGm1WBPhoDRrtv3fveKlj+6QutYDSIMfuSLPH4S2+CjZ+KeVTTD+1WS6esf4dcw37e9iPgHjFY6rAS0QRk2/jRT2KQ5OAY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MZDZJFjB; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZDZJFjB"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-432d55b0fa9so109221cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Apr 2024 18:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712279803; x=1712884603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fz47VsQ4PR0UnZ5hKlGOlqLoTfw+m5you2mPgmtXA/4=;
        b=MZDZJFjB1JtRnH1aqC9xvOQuxmNrvgHmqYDOAMXscp6qB+/qDg3wR1DKv9UufBUHid
         OL6Mt/cR6bxoeEd2Mw114w5vZakkfGf9YVndAOSQJk3RdjjMHh9jF0dO+gFEfjxRET/I
         QwJbKrg/23mQotcTMI2UqEf94/RJDU4RMWuToPETO5UjeE/370T4u0taF3xV1iq6Mbpo
         Kn5+YLkXkyyrtseDXJXuWEge5PQT+vMODTPZdQG3tz+UrwnHZMzAj12D+vXhiuO4QYMw
         pVObRgn0Gjazsb4+l1+piO9TyWkRWB+xqCov6KPzfUJfxVtPGRKOM15NnEUZQx+dOVNu
         iKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712279803; x=1712884603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fz47VsQ4PR0UnZ5hKlGOlqLoTfw+m5you2mPgmtXA/4=;
        b=Kea1yH6bGFkbfIUrphtIrsS9nkSZBv1Lhufy6qQEyUIGSVHXKcozsQ3RdhiIfnbgX2
         F2mFehHuJ542CSiubsB+Tp7k6oApIFBtixwRfIQ0bbOhaqrzKTWF4pk+T12LJRqMydct
         07Poy3IcZfT3/DSdVkmaR4lib4G+vEuvmu8Eir99GP2ZnlBRekXR7xiOeyNWSJLoQ++z
         NKbuwsDHKPhIZ5cDmVbxIR50fxOWzt+yS5ev9wJUrrex6ZEo3TMw5MSFqZid/5d6O8YO
         NMiog+/UuHlWQfOFhnxKoP8zCTynqVvkM0cGUTu/dodREdcvLchs9FpNjLBUu6yn+yC9
         ESvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyaxADXvqr0JQYpSuYhSJ/TUfKaph6fV1RGSA1qiFVIVaMy5dSHs3IvwFSZP+LAQY6vEfJbdpS0qnX9J08GzK9DHLkEag/kRp8400fjhD0Rw==
X-Gm-Message-State: AOJu0YyDoAESJ+NZQep0NIyHxzidx2ZN8sWuGvVPCoc1HIo7pqEFxAAZ
	F0fhY68WILXgKse8Hw8Vuj9Qc7UfkCYhfi1rM2+eT7d943mDGKHe4IOLwn/+lULhYcowe4vLLeq
	mXHwnlF9klLzTkDlKBQyORMsPqzDkzPkrEYaA
X-Google-Smtp-Source: AGHT+IFUq9vJBzX6fyePrn42Vhylhz/H9PviQBjHEDP52yrzxEujRAw4KtQPEpY2WIpMRGhwGJAsgB7TUS3MOds3rkA=
X-Received: by 2002:a05:622a:4296:b0:434:5ea8:2eef with SMTP id
 cr22-20020a05622a429600b004345ea82eefmr29925qtb.7.1712279802902; Thu, 04 Apr
 2024 18:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403164636.3429091-1-irogers@google.com> <dcb0121f-611d-4104-80b9-941d535c5fd2@linux.intel.com>
 <CAP-5=fUgiafmLEKEUJ5r5_tK+jqv30P0TGFCMvR8DkW7J4qYsQ@mail.gmail.com>
 <b9868e97-e353-45e0-83b7-aa28bc35dd67@linux.intel.com> <CAP-5=fX+YuEgD4pF-2YRcqgD2cwLw_7Z4ak+wszctvagPS+Xbw@mail.gmail.com>
 <ceca5922-6b83-464f-9e64-e8999068f734@linux.intel.com>
In-Reply-To: <ceca5922-6b83-464f-9e64-e8999068f734@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 Apr 2024 18:16:27 -0700
Message-ID: <CAP-5=fUA_SZVHtO82pUgL+MT0XQFVyuLw=Sd_s10W-XvcNqaDQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf metrics: Remove the "No_group" metric group
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 1:29=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-04-03 4:26 p.m., Ian Rogers wrote:
> > On Wed, Apr 3, 2024 at 11:57=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >>
> >>
> >> On 2024-04-03 2:31 p.m., Ian Rogers wrote:
> >>> On Wed, Apr 3, 2024 at 10:59=E2=80=AFAM Liang, Kan <kan.liang@linux.i=
ntel.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2024-04-03 12:46 p.m., Ian Rogers wrote:
> >>>>> Rather than place metrics without a metric group in "No_group" plac=
e
> >>>>> them in a a metric group that is their name. Still allow such metri=
cs
> >>>>> to be selected if "No_group" is passed, this change just impacts pe=
rf
> >>>>> list.
> >>>>
> >>>> So it looks like the "No_group" is not completely removed.
> >>>> They are just not seen in the perf list, but users can still use it =
via
> >>>> perf stat -M No_group, right?
> >>>>
> >>>> If so, why we want to remove it from perf list? Where can the end us=
er
> >>>> know which metrics are included in the No_group?
> >>>>
> >>>> If the No_group is useless, why not completely remove it?
> >>>
> >>> Agreed. For command line argument deprecation we usually keep the
> >>> option but hide it from help with PARSE_OPT_HIDDEN, so I was trying t=
o
> >>> follow that pattern albeit that a metric group isn't a command line
> >>> option it's an option to an option.
> >>>
> >>
> >> Perf list has a deprecated option to show the deprecated events.
> >> The "No_group" should be a deprecated metrics group.
> >>
> >> If so, to follow the same pattern, I think perf list should still
> >> display the "No_group" with the --deprecated option at least.
> >
> > Such metrics would be shown twice, once under No_group and once under
> > a metric group of their name.
> You mean with the --deprecated option?
> Yes, that's because the old/deprecated metrics group (No_group) is not
> complete removed. So both the new name and old/deprecated name are shown
> with the --deprecated option. The metrics which belong to both groups
> will be shown twice.
>
> Without the --deprecated option, only the new group and its members are
> shown.
>
> > With deprecated events this isn't the
> > case, you can only see them with --deprecated. Given we can see the
> > metric without the No_group grouping, what is being added by having a
> > No_group grouping? It feels entirely redundant and something we don't
> > need to advertise.
>
> I just want to have a generic pattern for deprecating a metrics/metrics
> group that everybody can follow.

Currently there is no concept of a metric group in the json except for
descriptions. Metrics and events share the same encoding, and the
deprecated flag belongs to the event.

> I treat the "No_group" as a normal metrics group name. So this patch is
> to introduce a new name, and hide the old name. Both new and old names
> can still be used.

Why are you using No_group? I stand firm that it has no real use.

> If it's for a deprecated event, the expectation is to only see the new
> name by default, and see both new name and old name with the
> --deprecated option.
>
> Now, if it's a generic deprecated metrics group, what's the expected
> behavior? I prefer to follow the same pattern as a deprecated event.
> If we do so, yes, there will be some redundancy with the --deprecated
> option, since some members may belong to both old and new groups.
> But I don't think it's an issue. It's normal that metrics belong to
> different groups.

What you are requesting here isn't something that is unreasonable, it
is just something unconnected with this change and requires a
reorganization of the json to facilitate. As such I consider it to be
something for follow up work.

I think if we're going to restructure metric groups it would be nice
to add a more tree-like structure which could be used to visualize
metrics better. For example here:
https://lore.kernel.org/lkml/20240314055919.1979781-11-irogers@google.com/
the metrics could be shown under a tree like:
ldst
 - ldst_total
   - ldst_total_loads
 - ldst_prcnt
   - ldst_prcnt_loads
   - ldst_prcnt_stores
 - ldst_ret_lds
   - ldst_ret_lds_1
   - ldst_ret_lds_2
   - ldst_ret_lds_3
 - ldst_ret_sts
   - ldst_ret_sts_1
   - ldst_ret_sts_2
   - ldst_ret_sts_3
 - ldst_ld_hit_swpf
 - ldst_atomic_lds

but again it is follow up work to do this. In this change I just
wanted a way to list all sensibly grouped metrics or metrics in a
group just on their own which doesn't require some kind of analysis of
metric groups. No_group has no use so let's just get rid of it.

Thanks,
Ian

> Thanks,
> Kan
