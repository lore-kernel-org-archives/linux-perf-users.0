Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C68139CEE;
	Tue, 23 Jul 2024 01:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721699480; cv=none; b=KeM233Q1IWfnKHk3XYYOIE35ANF1oNRn8p958YZo9A+Q7D6OS3iHzRqAyl/WMTQN5n7JiC5nr1a7KTTWsYHxiKKkuJ6wIueFusB5q5ThC+NfIq6EqptOJC6i4Pe3HurvMkZE+3PLldPITbgft442pKw0q/+aILEsPUgqgJq8IKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721699480; c=relaxed/simple;
	bh=5LiQPHIwYBb1eBYWiM2k4mKF98UwqsjReBTe6Fg2DKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lL4aJOromcxuGa1NjTtzemynpTd8v1tBnRusNZhy0AU2Az2t0andXra/C1PF1tFOLZRE7XgizT3926dS1d07xBjEwoiAtDyIutVMY6vuh/+al6IarORF50Af5iIZL0LcVDyZFsnYlJXGcwVJxhvq8xvtRqily83EXzAL46i0RSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WSg8P5V8Sznc5l;
	Tue, 23 Jul 2024 09:50:29 +0800 (CST)
Received: from kwepemd200010.china.huawei.com (unknown [7.221.188.124])
	by mail.maildlp.com (Postfix) with ESMTPS id 73FBE18005F;
	Tue, 23 Jul 2024 09:51:16 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd200010.china.huawei.com (7.221.188.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 23 Jul 2024 09:51:16 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.034;
 Tue, 23 Jul 2024 09:51:16 +0800
From: duchangbin <changbin.du@huawei.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: duchangbin <changbin.du@huawei.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>, "Liang, Kan"
	<kan.liang@linux.intel.com>, "Nick Desaulniers" <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, "Wanghui (OS Kernel Lab,
 Beijing)" <hw.huiwang@huawei.com>
Subject: Re: [PATCH v5 4/8] perf: build-id: name debugging vdso as "debug"
Thread-Topic: [PATCH v5 4/8] perf: build-id: name debugging vdso as "debug"
Thread-Index: AQHazDb2iq3pHVuvbEa2f6W9l9N6m7H8Si6AgAZ9IID//45bAIABV2YA
Date: Tue, 23 Jul 2024 01:51:15 +0000
Message-ID: <0d7e5c9b27044e6eac89708d407c08fe@huawei.com>
References: <20240702041837.5306-1-changbin.du@huawei.com>
 <20240702041837.5306-5-changbin.du@huawei.com>
 <14afba8e-cb85-4d7d-96e4-d65fd8ebc2d5@intel.com>
 <8a7156281b45450ebf0511373f65afa7@huawei.com>
 <22bee274-23e1-4298-a936-50bebd802482@intel.com>
In-Reply-To: <22bee274-23e1-4298-a936-50bebd802482@intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemd100011.china.huawei.com (15.02.1258.034)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="us-ascii"
Content-ID: <002BCEC86177134BB94BC88C6D86F367@huawei.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Jul 22, 2024 at 04:21:46PM +0300, Adrian Hunter wrote:
> On 22/07/24 15:08, duchangbin wrote:
> > On Thu, Jul 18, 2024 at 08:03:07PM +0300, Adrian Hunter wrote:
> >> On 2/07/24 07:18, Changbin Du wrote:
> >>> As normal objects, we will add debugging vdso elf to build-id cache l=
ater.
> >>> Here we name the debugging one as "debug".
> >>>
> >>> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> >>> ---
> >>>  tools/perf/util/build-id.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> >>> index 83a1581e8cf1..15530af2bad9 100644
> >>> --- a/tools/perf/util/build-id.c
> >>> +++ b/tools/perf/util/build-id.c
> >>> @@ -259,8 +259,8 @@ static bool build_id_cache__valid_id(char *sbuild=
_id)
> >>>  static const char *build_id_cache__basename(bool is_kallsyms, bool i=
s_vdso,
> >>>  					    bool is_debug)
> >>>  {
> >>> -	return is_kallsyms ? "kallsyms" : (is_vdso ? "vdso" : (is_debug ?
> >>> -	    "debug" : "elf"));
> >>> +	return is_kallsyms ? "kallsyms" : (is_debug ? "debug" : (is_vdso ?
> >>> +		"vdso" : "elf"));
> >>>  }
> >>> =20
> >>>  char *__dso__build_id_filename(const struct dso *dso, char *bf, size=
_t size,
> >>
> >> To actually add "debug", this also needs:
> >>
> >> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> >> index 15530af2bad9..b5bd02a1ad0f 100644
> >> --- a/tools/perf/util/build-id.c
> >> +++ b/tools/perf/util/build-id.c
> >> @@ -701,7 +701,7 @@ build_id_cache__add(const char *sbuild_id, const c=
har *name, const char *realnam
> >>  	 * file itself may not be very useful to users of our tools without =
a
> >>  	 * symtab.
> >>  	 */
> >> -	if (!is_kallsyms && !is_vdso &&
> >> +	if (!is_kallsyms &&
> >>  	    strncmp(".ko", name + strlen(name) - 3, 3)) {
> >>  		debugfile =3D build_id_cache__find_debug(sbuild_id, nsi, root_dir);
> >>  		if (debugfile) {
> >>
> >>
> >>
> > This is done by later patch named "perf: build-id: try to search debugg=
ing vdso
> > and add to cache". I split the changes into two patches.
>=20
> With the above, the split is more functionally logical:
> 	1. Add support for build-id cache vdso debug
> 	2. For vdso, extend build_id_cache__find_debug() to find
> 	local kernel build files
>
Sounds good for me.

> >=20
> >> With that perf will populated the "debug" entry in the build-id cache.
> >> Currently, when adding to the build-id cache, perf only looks in
> >> /usr/lib/debug/.build-id (refer build_id_cache__find_debug()), for
> >> example:
> >>
> >>
> >> $ sudo ln -s /lib/modules/6.9.2-local/build/arch/x86/entry/vdso/vdso64=
.so.dbg /usr/lib/debug/.build-id/cf/702469f4637840fd6ba1a8d8a628ff83253d04.=
debug
> >> $ ls -l ~/.debug/\[vdso\]/cf702469f4637840fd6ba1a8d8a628ff83253d04/
> >> total 8
> >> -rw-r--r-- 1 ahunter ahunter    0 Jul 18 13:33 probes
> >> -rw------- 1 ahunter ahunter 8192 Jul 18 13:33 vdso
> >> $ perf record uname
> >> Linux
> >> [ perf record: Woken up 1 times to write data ]
> >> [ perf record: Captured and wrote 0.010 MB perf.data (2 samples) ]
> >> $ ls -l ~/.debug/\[vdso\]/cf702469f4637840fd6ba1a8d8a628ff83253d04/
> >> total 40
> >> -rwxrwxr-x 2 ahunter ahunter 32760 May 27 17:42 debug
> >> -rw-r--r-- 1 ahunter ahunter     0 Jul 18 13:33 probes
> >> -rw------- 1 ahunter ahunter  8192 Jul 18 13:33 vdso
> >>
> >>
> >> Note, perf will anyway find the debug object in /usr/lib/debug/.build-=
id
> >> so the benefit is if perf-archive is used to copy from the buildid-cac=
he
> >> to take to another machine.
> >>
> >>
> >=20
>=20
>=20

--=20
Cheers,
Changbin Du
