Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F307EC152;
	Thu,  4 Jul 2024 01:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720057390; cv=none; b=qAIRtGyUxNZfVdYRnX6gQv6wXATWZ1LkXZZqJWjRGCbf9MS7Px4J3+NB04HrHD6N7cZgmvCryH07C7IzaWVz+ajAYBWJy8MY8x5+AVstreyYPX+IMz0aXQ1963quqtH2mm+1glJ6NzCkOz1eeEE+nr4fEPTXwWEAUB/dx1jOmjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720057390; c=relaxed/simple;
	bh=ovAEM6Rvcy4XprFzuvo3MgKCDzwxloIVv7pcklQifpc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VEkiAEKB5c+GMVIus1PcylDc74cxveRwfIY46JCcXueXX6kj4dyXDWNHhJSRQUgt8EBswMjXds3LrkDhYkaVv7L9fPyTKrLct9XfGjUr8VDt4mNHh4CiCrIQcNiSUoMzVPBsCs9W+Rf5usrxVW9++O5tNP0uDIpG4QSPth720SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WDzrl0F3NzdfpT;
	Thu,  4 Jul 2024 09:41:27 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 72933180088;
	Thu,  4 Jul 2024 09:43:04 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 4 Jul 2024 09:43:04 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.034;
 Thu, 4 Jul 2024 09:43:04 +0800
From: duchangbin <changbin.du@huawei.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: duchangbin <changbin.du@huawei.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>, Nick Desaulniers
	<ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>, "Wanghui (OS Kernel Lab, Beijing)"
	<hw.huiwang@huawei.com>
Subject: Re: [PATCH v5 8/8] perf buildid-cache: recognize vdso when adding
 files
Thread-Topic: [PATCH v5 8/8] perf buildid-cache: recognize vdso when adding
 files
Thread-Index: AQHazDb6e2IQdcHaU0qwMDy1hVwfULHlIBIAgACubIA=
Date: Thu, 4 Jul 2024 01:43:03 +0000
Message-ID: <ec6b22fe1246427a80086e46fb34d765@huawei.com>
References: <20240702041837.5306-1-changbin.du@huawei.com>
 <20240702041837.5306-9-changbin.du@huawei.com> <ZoXcQunHBf0Z1JIW@google.com>
In-Reply-To: <ZoXcQunHBf0Z1JIW@google.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemd100011.china.huawei.com (15.02.1258.034)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53563D11EC803F4881F15B869C0FB87B@huawei.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi, Namhyung,
On Wed, Jul 03, 2024 at 04:18:26PM -0700, Namhyung Kim wrote:
> Hello,
>=20
> On Tue, Jul 02, 2024 at 12:18:37PM +0800, Changbin Du wrote:
> > Identify vdso by file name matching. The vdso objects have name
> > as vdso[32,64].so[.dbg].
> >=20
> > $ perf buildid-cache -a /work/linux/arch/x86/entry/vdso/vdso64.so.dbg
> >=20
> > Without this change, adding vdso using above command actually will neve=
r
> > be used.
>=20
> Can we handle /tmp/perf-vdso.so-XXXXXX too?
>
This temporary path is already handled by perf_session__cache_build_ids()->=
...->dso__cache_build_id().

> Thanks,
> Namhyung
>=20
> >=20
> > Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > ---
> >  tools/perf/builtin-buildid-cache.c | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-bu=
ildid-cache.c
> > index b0511d16aeb6..8edea9044a65 100644
> > --- a/tools/perf/builtin-buildid-cache.c
> > +++ b/tools/perf/builtin-buildid-cache.c
> > @@ -172,6 +172,30 @@ static int build_id_cache__add_kcore(const char *f=
ilename, bool force)
> >  	return 0;
> >  }
> > =20
> > +static bool filename_is_vdso(const char *filename)
> > +{
> > +	char *fname, *bname;
> > +	static const char * const vdso_names[] =3D {
> > +		"vdso.so", "vdso32.so", "vdso64.so", "vdsox32.so"
> > +	};
> > +
> > +	fname =3D strdup(filename);
> > +	if (!fname) {
> > +		pr_err("no mememory\n");
> > +		return false;
> > +	}
> > +
> > +	bname =3D basename(fname);
> > +	if (!bname)
> > +		return false;
> > +
> > +	for (unsigned int i =3D 0; i < ARRAY_SIZE(vdso_names); i++) {
> > +		if (!strncmp(bname, vdso_names[i], strlen(vdso_names[i])))
> > +			return true;
> > +	}
> > +	return false;
> > +}
> > +
> >  static int build_id_cache__add_file(const char *filename, struct nsinf=
o *nsi)
> >  {
> >  	char sbuild_id[SBUILD_ID_SIZE];
> > @@ -189,7 +213,7 @@ static int build_id_cache__add_file(const char *fil=
ename, struct nsinfo *nsi)
> > =20
> >  	build_id__sprintf(&bid, sbuild_id);
> >  	err =3D build_id_cache__add_s(sbuild_id, filename, nsi,
> > -				    false, false);
> > +				    false, filename_is_vdso(filename));
> >  	pr_debug("Adding %s %s: %s\n", sbuild_id, filename,
> >  		 err ? "FAIL" : "Ok");
> >  	return err;
> > --=20
> > 2.34.1
> >=20
>=20

--=20
Cheers,
Changbin Du
