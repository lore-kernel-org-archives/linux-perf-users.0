Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E45D220687
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734722219; cv=none; b=uBD/hTQY1hZ9Q/HwUIDiNWCNwaXk6rGeGYS5b8CsfPbawJMJBIXAzozzOl+sHUIiFqbaX+RphNs43sq7HChq7i+Ws117gBjemw35tST2w9pGiWE9h97+nqtVXWqET05JJdmzaxCKcI49e76mva8PGS3zDvISR0Mi3Qu7A/LfCD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734722219; c=relaxed/simple;
	bh=wWd7d2Htnbc0S0HvlUr/U/zr0ral5q90y0xwVom9jDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=En6jWobqU87TkGSm/x6ntZAUH3V21qteH/BJLTgGWrvH2l1xPfwONF9xjlm/0Bqnp6SBt612J1PhE3h6kLw+Lg2U/z/c/j9tQ3TetDEBk6X+YNlmny03yLn3wlhkyK3vgFn8ERw0oBM0bXmXfRuJE0ebsK81qRlAz6GCYan9zek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EjUy3J+r; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EjUy3J+r"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso178145ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 11:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734722217; x=1735327017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N82YQ2umVETAfBP08xivuLzlfhvpXA6F9FtDVd6PLw4=;
        b=EjUy3J+rbEtqWcD3+otxS0KQAANEYwGs9UUgdPqBVa4iM3WpBdHXrMkOa2ntQu3Ed0
         CFBG1BTrDxG78/XefVX1Na5perYNk7r/s58RIr3uCvJSza74TPVKe2MZXNN8WNEYLJjt
         fO8CLA7++qb214frx/5E/eOZYm5LymIAfxQNmbHA4eQ+0kVg5D4pnaR/+QSsl8rWTdZk
         zCkhX57ZbplPmYZ6HWAVWvRO5eQGZYzwFUPUax0BC0/diwfMrTZX+Ik5yAncLp7rhwXR
         ThnZsq/SvQXbE9izki7ocZ9wSafKEgz8KYiqBKS9RLt1ZiyVJrompruigzO1TWI9uW+N
         UsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734722217; x=1735327017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N82YQ2umVETAfBP08xivuLzlfhvpXA6F9FtDVd6PLw4=;
        b=JWejAnzY7Kb4OCZGadP5u1M1Dt5FbDtluJVJgRf7cZYXGQYGiL0Go4WaK6OLX64wK8
         I+9Tf2cC1xpD2kQh8aXrpyeJoMU6gxW69osv1OMUpVVuAROS68O5uGQBZWyIfe2th7cI
         PAygt8fXoyrXKql4T9N79+rMibbVa+i9mLA66gl/6NeWYNvIh+tj3QilzCQpm91O2cmE
         g7IXIoFYyz4C37xTxrPX9autZ+aTTAFe/jceWlsJ4rzCpeIXBJfvv/XRnFIil4ty64+m
         phnYi/Vzk++qM8wkDolfxAQN89lx/OU9DQJcLuapj8TdYECyiX2eOyWLjk2Td9HqdzOI
         DG3g==
X-Forwarded-Encrypted: i=1; AJvYcCWzIwkUvv4pZlvpVc5Vcyz9ekoaBUlbZWG5uodZ9fSWNjuxxMYqYAPrjtEImKC5XERgqz3uri5EVoD4Mf8ic7Dy@vger.kernel.org
X-Gm-Message-State: AOJu0YyDzFinzgz1jqYMP6OnPNg73JCC8xhCBz/t+AiKwNWfUdTPTJcu
	sREBFBxrg8YumgBfgX8qIJChEM+tZBtwpSrQQIEXqnyOxQvLYYxDWFacoEAQIesAIDmLkkgAeQg
	xe1VWtPaR1vuaqOpWDlUEvp2z/Zmo23rAJaNd
X-Gm-Gg: ASbGncuOUWJqGABrJYg86/d+72d6VvrjWWhAo4+9p/HSXUIMmx9uNWirYgRn65QkwXr
	6JkdnWoyia68PdKZokIzQAxR1I+4pyT9u4iQMVKc=
X-Google-Smtp-Source: AGHT+IHOg1KTizx6KXRiG8cpCl/aA6WE1DTbo1PP2+mTzFKwUfVq36r184m4NtN51mqFGkB0LyonTipGbY+RNtvwNM4=
X-Received: by 2002:a92:d785:0:b0:3a7:dea7:87a6 with SMTP id
 e9e14a558f8ab-3c331d3c64dmr2798245ab.29.1734722217216; Fri, 20 Dec 2024
 11:16:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606044959.335715-1-irogers@google.com> <c7d6eedb-7c5e-4411-a83f-4328dc75ec46@linux.intel.com>
 <CAP-5=fXY2Ofr_GRc7Mq7BfoR+2150o8e1JeyGctcGPRG70DqPg@mail.gmail.com>
 <060b220d-f7d6-4594-9b2b-e878a2ba98c6@arm.com> <CAP-5=fU+pigNLi+cTFwEmyG5tO+JHTGDgWh1sYbCiX5TppdLnQ@mail.gmail.com>
In-Reply-To: <CAP-5=fU+pigNLi+cTFwEmyG5tO+JHTGDgWh1sYbCiX5TppdLnQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 20 Dec 2024 11:16:46 -0800
Message-ID: <CAP-5=fVBsCxHbqQkEbG2zzATDYfN8bP6mN9ixkae7o9eNB5w+Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2] perf Documentation: Describe the PMU naming convention
To: Robin Murphy <robin.murphy@arm.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Tuan Phan <tuanphan@os.amperecomputing.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Bhaskara Budiredla <bbudiredla@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 9:21=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Oct 23, 2024 at 2:34=E2=80=AFAM Robin Murphy <robin.murphy@arm.co=
m> wrote:
> >
> > On 2024-10-23 5:06 am, Ian Rogers wrote:
> > > On Thu, Jun 6, 2024 at 11:15=E2=80=AFAM Liang, Kan <kan.liang@linux.i=
ntel.com> wrote:
> > >>
> > >>
> > >>
> > >> On 2024-06-06 12:49 a.m., Ian Rogers wrote:
> > >>> It is an existing convention to use suffixes with PMU names. Try to
> > >>> capture that convention so that future PMU devices may adhere to it=
.
> > >>>
> > >>> The name of the file and date within the file try to follow existin=
g
> > >>> conventions, particularly sysfs-bus-event_source-devices-events.
> > >>>
> > >>> Signed-off-by: Ian Rogers <irogers@google.com>
> > >>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> > >>> ---
> > >>>   .../testing/sysfs-bus-event_source-devices    | 24 ++++++++++++++=
+++++
> > >>>   1 file changed, 24 insertions(+)
> > >>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-event_sour=
ce-devices
> > >>>
> > >>
> > >> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > >
> > > Thanks for all the reviews. Could we land this?
> >
> > Hmm, it's not always going to be strictly true as written though - we
> > will also have cases where multiple PMU instances owned by the same
> > driver don't all support the same events/filters/etc., and/or are
> > entirely unrelated such that the same event encoding may mean completel=
y
> > different things. I've just landed a driver where not only are the
> > instances going to be heterogeneous (since it's for arbitrary bits of
> > interconnect), but for hierarchy reasons the most logical place to put
> > the instance ID in the name wasn't even at the end :(
>
> Right, I was trying to capture what the tool is doing and trying to
> encompass the problems hex suffix create. Another example of that
> problem recently burning us is ARM's PMU naming of armv8_pmuv3_a53
> means the a53 looks like a hex suffix. When ARM release a model with a
> 3 digit number will the naming break? Wrt filters, I wonder if there
> should be testing, bugs, etc. The wildcard matching will likely do its
> thing and I think the failures should be predictable and descriptive,
> like an event used a format that a PMU doesn't support, but I'm not
> sure if we should do improvements in `perf list` where we try to
> deduplicate PMUs. Perhaps the deduplication should be smarter.
>
>
> > FWIW I think if we want to nail down a strict ABI, it would seem more
> > robust to have an explicit attribute to describe underlying PMU
> > properties like whether instances do represent identical "slices" or
> > not. The hex suffix thing is already proving how fragile names alone ar=
e
> > liable to be.
>
> Agreed. Does this mean we shouldn't land this? I worry that LKML is
> the home of bike shedding conversations and we're likely to bike shed
> trying to achieve 'perfect' while something 'good' would have value
> today.

Ping.

Thanks,
Ian
