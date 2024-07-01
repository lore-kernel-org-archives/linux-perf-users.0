Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EC116EB44
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jul 2024 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854421; cv=none; b=acAASDLfX1pzk1sBOoXIPZPGAk3pVjcFEuNkQ9H064aEIpKUfEZ9xIrppbF32NttWTVCXp4Z30e09gjVkH/ChcoW6KPd6AyyXNy3I32jbfzOfxusRhWVuJfOOK3NlJ3exLDMrBg4VD7clGpXuM1dJ+5mmVeuayTtQOgHQUybWz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854421; c=relaxed/simple;
	bh=3/DVu8wcnFGGBOqzKTIW/5cJ/Lga+TPhcr1OySCyoxs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hvBOJ1g9m6EkbnJbjjDkK1sXb3WreflNRnBqHBByoQNsXtcXP+paGQ+TmftXPEZ33vwBkLjh5mRqhOM9EZIcK1z6nYyE8yArZ765Guv71Naq+W9VU5WMEYF19y+B2ak1QsYVS3Us04gtkLwmaCD5lYVmhLDw5hIPTQw4teiWBUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1sOKh2-0003Us-IL; Mon, 01 Jul 2024 19:19:56 +0200
Message-ID: <8b31bc0823df42e1ef4c22eac159fa58694887c7.camel@pengutronix.de>
Subject: Re: [PATCH] perf jevents: return potentially empty metrics table
From: Lucas Stach <l.stach@pengutronix.de>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo
	 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	 <irogers@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 patchwork-lst@pengutronix.de, linux-perf-users@vger.kernel.org, 
 kernel@pengutronix.de, Kan Liang <kan.liang@linux.intel.com>
Date: Mon, 01 Jul 2024 19:19:55 +0200
In-Reply-To: <20240531194414.1849270-1-l.stach@pengutronix.de>
References: <20240531194414.1849270-1-l.stach@pengutronix.de>
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

Hi,

has this patch fallen through the cracks? It fixes a functional
regression where the DDR controller metrics are completely unavailable
on all i.MX8M* systems and thus would be nice if someone could have a
look.

Regards,
Lucas

Am Freitag, dem 31.05.2024 um 21:44 +0200 schrieb Lucas Stach:
> Don't return NULL when a empty (num_pmus =3D 0) metrics table is encounte=
red,
> as this causes many of the users to bail out, which will skip matching an=
y
> potentially existing sys metrics later on. Instead return the empty table
> which will be handled properly by the iterators and allows matching to
> continue.
>=20
> This fixes metrics reporting on systems where only the sys, but not the
> core PMUs have metrics defined.
>=20
> Fixes: f20c15d13f01 ("perf pmu-events: Remember the perf_events_map for a=
 PMU")
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  tools/perf/pmu-events/jevents.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index e42efc16723e..0a1ed9ee1429 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -1081,7 +1081,7 @@ const struct pmu_metrics_table *perf_pmu__find_metr=
ics_table(struct perf_pmu *pm
>          if (!map)
>                  return NULL;
> =20
> -        if (!pmu)
> +        if (!pmu || !map->metric_table.num_pmus)
>                  return &map->metric_table;
> =20
>          for (size_t i =3D 0; i < map->metric_table.num_pmus; i++) {

