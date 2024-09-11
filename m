Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D59C14E2FA;
	Wed, 11 Sep 2024 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726048837; cv=none; b=VUkPEUW+LzMAh0nOLRdFTIy1e5I61bbE9Fm9KgorZoDUhYJ2kLCPpA/mGzPeIxZbIT3HbYubvzIXWL2i1LiZ++mPvDdKstxktz563pUHCKOH4uwGB2iFnZSlaBhIn2a62uvic+aoFm+D0N51/80PIn0jtjAQ4HNyxi/OlXMHN5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726048837; c=relaxed/simple;
	bh=1fAuAau3KeCX4d6czJwKqjuWe2UtNbEs6ol1CeoQCAw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YKEUzV0WqQKUYjelQ0tfaahsv2eVypRdyhWCeK/f+sSx+U3FBEhnw566cl5FyGpVttnep/KizVM+A7/F+2KQBj9HGQm/dQ+d7Hg7vFaSQRQaNGW8YlUIRDXyY1ah2zgxk0Agbp19H5jyRb3fWg5WEAP6xzEPLtIFQ02X4XgRaCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X3bfd3ZbQz69RR;
	Wed, 11 Sep 2024 18:00:25 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F92D1800D1;
	Wed, 11 Sep 2024 18:00:31 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 11 Sep 2024 18:00:31 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.034;
 Wed, 11 Sep 2024 18:00:31 +0800
From: duchangbin <changbin.du@huawei.com>
To: James Clark <james.clark@linaro.org>
CC: duchangbin <changbin.du@huawei.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf ftrace: Detect whether ftrace is enabled on system
Thread-Topic: [PATCH] perf ftrace: Detect whether ftrace is enabled on system
Thread-Index: AQHbAzKr1ZAjTKZ7QkCmqTLETkKdPLJR0hoAgACKOgA=
Date: Wed, 11 Sep 2024 10:00:31 +0000
Message-ID: <526bf9fecede4effa859214683201518@huawei.com>
References: <20240910033625.3569729-1-changbin.du@huawei.com>
 <4fa0229e-630b-4b6e-8882-3d8a5793a9dd@linaro.org>
In-Reply-To: <4fa0229e-630b-4b6e-8882-3d8a5793a9dd@linaro.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemd100011.china.huawei.com (15.02.1258.034)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8756EA23FA9A584AABCFC1959882858F@huawei.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 11, 2024 at 10:45:16AM +0100, James Clark wrote:
>=20
>=20
> On 10/09/2024 04:36, Changbin Du wrote:
> > To make error messages more accurate, this change detects whether ftrac=
e is
> > enabled on system by checking trace file "set_ftrace_pid".
> >=20
> > Before:
> > ~ # perf ftrace
> > failed to reset ftrace
> >=20
> > After:
> > ~ # perf ftrace
> > ftrace is not supported on this system
> >=20
> > Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > ---
> >   tools/perf/builtin-ftrace.c | 24 ++++++++++++++++++++++++
> >   1 file changed, 24 insertions(+)
> >=20
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index eb30c8eca488..e1dc2768bc0f 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -1112,6 +1112,24 @@ static int parse_graph_tracer_opts(const struct =
option *opt,
> >   	return 0;
> >   }
> > +static bool is_ftrace_supported(void)
> > +{
> > +	char *file;
> > +	bool supported =3D false;
> > +
> > +	file =3D get_tracing_file("set_ftrace_pid");
> > +	if (!file) {
> > +		pr_debug("cannot get tracing file set_ftrace_pid\n");
> > +		return false;
> > +	}
> > +
> > +	if (!access(file, F_OK))
> > +		supported =3D true;
> > +
> > +	put_tracing_file(file);
> > +	return supported;
> > +}
> > +
> >   enum perf_ftrace_subcommand {
> >   	PERF_FTRACE_NONE,
> >   	PERF_FTRACE_TRACE,
> > @@ -1254,6 +1272,12 @@ int cmd_ftrace(int argc, const char **argv)
> >   		goto out_delete_filters;
> >   	}
> > +	if (!is_ftrace_supported()) {
> > +		pr_err("ftrace is not supported on this system\n");
> > +		ret =3D -ENOTSUP;
> > +		goto out_delete_filters;
> > +	}
> > +
>=20
> Very minor nit, but you could probably put this earlier next to
> check_ftrace_capable(). It didn't look like it used any of the config or
> parsing results.
>
Thansk, I will rebase this on perf-tools-next branch.

> Either way:
>=20
> Reviewed-by: James Clark <james.clark@linaro.org>

--=20
Cheers,
Changbin Du
