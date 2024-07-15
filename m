Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7B2D53C
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721058891; cv=none; b=ED+lgO9vGkL0IaHmeq/L9AhCHKeXimUaA1m8QzopJrBd6EJ74csiRuCugNW4mSTwmTvAhaoXSvqFLY3hFv0JO0phknDT3L59pYOSlc6RDlwrBlLhyoZDLvIvrH/xjtnjpr5jFND153e2o8KV9tDqnocSZqfvoX/xuhKI8xyp5KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721058891; c=relaxed/simple;
	bh=yEMo9owmZMqLi6P3+x4e0kjjz6iCdshJkjvR7JTJ5z4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HVWRlqykoWqURIt3CVt7y2iXQraKwWM5LW5cDC6M0xJjXmzMOcs2ufrh9JyckD8NoPaQ0sYGfx1PsEg3TMZS8A9PilKA4YVaP3yOzEjFDNh2/GST3q2MzCA3GsX8d5Oqsq7xQCBlplveFLs01fFGZP3bo7/Tzgs8rFmLX63AiE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1sTO1n-0001QL-9s; Mon, 15 Jul 2024 17:54:15 +0200
Message-ID: <ac1d9124e497a1667e7cbc340f923cb4449764bb.camel@pengutronix.de>
Subject: Re: [PATCH] perf jevents: return potentially empty metrics table
From: Lucas Stach <l.stach@pengutronix.de>
To: James Clark <james.clark@linaro.org>, Ian Rogers <irogers@google.com>, 
 Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@linux.dev>, James
 Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,  patchwork-lst@pengutronix.de,
 linux-perf-users@vger.kernel.org,  kernel@pengutronix.de, Kan Liang
 <kan.liang@linux.intel.com>
Date: Mon, 15 Jul 2024 17:54:13 +0200
In-Reply-To: <b3a4282a-91b6-49a0-83d1-470cc4873dc1@linaro.org>
References: <20240531194414.1849270-1-l.stach@pengutronix.de>
	 <8b31bc0823df42e1ef4c22eac159fa58694887c7.camel@pengutronix.de>
	 <ZoXRr9wcE98ijyFA@google.com>
	 <CAP-5=fWxuPW1WGSOV-wqYXJ-4kiwefujprnGn3YfVzO+62-i-Q@mail.gmail.com>
	 <b3a4282a-91b6-49a0-83d1-470cc4873dc1@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-perf-users@vger.kernel.org

Am Montag, dem 15.07.2024 um 16:12 +0100 schrieb James Clark:
>=20
> On 12/07/2024 10:54 pm, Ian Rogers wrote:
> > On Wed, Jul 3, 2024 at 3:33=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >=20
> > > Hello,
> > >=20
> > > On Mon, Jul 01, 2024 at 07:19:55PM +0200, Lucas Stach wrote:
> > > > Hi,
> > > >=20
> > > > has this patch fallen through the cracks? It fixes a functional
> > > > regression where the DDR controller metrics are completely unavaila=
ble
> > > > on all i.MX8M* systems and thus would be nice if someone could have=
 a
> > > > look.
> > > >=20
> > > > Regards,
> > > > Lucas
> > > >=20
> > > > Am Freitag, dem 31.05.2024 um 21:44 +0200 schrieb Lucas Stach:
> > > > > Don't return NULL when a empty (num_pmus =3D 0) metrics table is =
encountered,
> > > > > as this causes many of the users to bail out, which will skip mat=
ching any
> > > > > potentially existing sys metrics later on. Instead return the emp=
ty table
> > > > > which will be handled properly by the iterators and allows matchi=
ng to
> > > > > continue.
> > > > >=20
> > > > > This fixes metrics reporting on systems where only the sys, but n=
ot the
> > > > > core PMUs have metrics defined.
> > > > >=20
> > > > > Fixes: f20c15d13f01 ("perf pmu-events: Remember the perf_events_m=
ap for a PMU")
> > > > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > >=20
> > > Looks ok to me.  Ian?
> >=20
> > Sorry I missed this, I expect to see patches on LKML and so my email
> > filters placed this elsewhere.
> >=20
> > The change doesn't make sense. A search is requested with a PMU and
> > you return success (the table) when there is no PMU match. If this
> > behavior were expected then NULL should be passed as a PMU - this is
> > the behavior in util/pmu.c and ARM is the only architecture to pass a
> > PMU. The ARM pmu_metrics_table__find also specifically breaks
> > heterogeneous (BIG.little) systems and this change won't impact/fix
> > that. Perhaps there is some context I lack.
> >=20

The missing context is probably the call chain that I somehow omitted
and needed to piece together again right now. The issue I'm try to fix
here is perf stat not being able to measure metrics from a system-wide
PMU (the i.MX8M* ddrc) only.

The underlying issue is that when there is no non-systemwide PMU,
perf_pmu__find_metrics_table will return NULL after f20c15d13f01. This
causes metricgroup__parse_groups to drop out early. However, we need
this function to call the chain parse_groups() ->
metricgroup__add_metric_list -> metricgroup__add_metric, as only at
this point system wide metrics, like the ddrc, will be added to the
list.

It is correct to drop out early, as those functions can not be called
with a NULL parameter. Before f20c15d13f01 and after the patch
discussed here perf_pmu__find_metrics_table() will simply return a
table with 0 entries. The called functions are fine with this, as they
iterate the entries and the execution flow is able to reach the point
where the system wide events are added.

> > Thanks,
> > Ian
> >=20
>=20
> Yes it looks like the fix should possibly be higher up in the arm64=20
> pmu_metrics_table__find().
>=20
Maybe someone can figure out how to fix this in a better way higher up
the call chain with the description above. However, my fix looked quite
straight forward to me, as it simply restores the behavior before
f20c15d13f01.

> Which set of JSON files are you seeing the issue with exactly Lucas? I=
=20
> see that there are multiple versions of i.MX8M metrics.
>=20
It was first observed on a i.MX8MP, but the issue is also reproducible
on i.MX8MM. I guess it doesn't matter which SoC is used specifically,
the key point is that the sampling isn't able to match any specific
PMU, but there are still system wide metrics.

Regards,
Lucas

> James
>=20
> > > Thanks,
> > > Namhyung
> > >=20
> > >=20
> > > > > ---
> > > > >   tools/perf/pmu-events/jevents.py | 2 +-
> > > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-ev=
ents/jevents.py
> > > > > index e42efc16723e..0a1ed9ee1429 100755
> > > > > --- a/tools/perf/pmu-events/jevents.py
> > > > > +++ b/tools/perf/pmu-events/jevents.py
> > > > > @@ -1081,7 +1081,7 @@ const struct pmu_metrics_table *perf_pmu__f=
ind_metrics_table(struct perf_pmu *pm
> > > > >           if (!map)
> > > > >                   return NULL;
> > > > >=20
> > > > > -        if (!pmu)
> > > > > +        if (!pmu || !map->metric_table.num_pmus)
> > > > >                   return &map->metric_table;
> > > > >=20
> > > > >           for (size_t i =3D 0; i < map->metric_table.num_pmus; i+=
+) {
> > > >=20
> >=20

