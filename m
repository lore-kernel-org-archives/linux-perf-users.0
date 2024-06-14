Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2AE146A90;
	Fri, 14 Jun 2024 03:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718337309; cv=none; b=g9SKzfpvh3rbgGbEH7bo2926GKlMWmK58uN7lrK7y2CxRse4dDY/a/E4YinYz/6rbfUFPhJTKQo0/I/W8KSen9g5MgYlpJGiAObwEd6G/vwmiLWnnjW3sVzjTOvmn3aNmq4zbJ83Uqs7USN68abVRZdBojW57W7m/lTYAmtIXzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718337309; c=relaxed/simple;
	bh=DRCCeEjTSrpOxV55wmObarqnuntQRUzJ2p5ODapp/eo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UjukrLt2xFatNQvIP0/A6niTL1AddaGeOfckUSAAt8DY7xBAI7o9JoSg2ZWZXnXLG725hhi9oFuIhfqzIAgNavLlqC0LSiNTxBH0EDUcmAX6wKgXT7RQhYwwpPDJc5Q28DPb0GAhUkshTq4IrMZBHaJ/Y6nK0qqaQWFkKEfUyTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W0lgQ0DKHzwS3s;
	Fri, 14 Jun 2024 11:50:58 +0800 (CST)
Received: from kwepemd200010.china.huawei.com (unknown [7.221.188.124])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E0B114059F;
	Fri, 14 Jun 2024 11:55:06 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd200010.china.huawei.com (7.221.188.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 11:55:05 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.034;
 Fri, 14 Jun 2024 11:55:05 +0800
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
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH 1/2] perf: support specify vdso path in cmdline
Thread-Topic: [PATCH 1/2] perf: support specify vdso path in cmdline
Thread-Index: AQHavVvgPApptK0OsE6+S63iYUbWKrHE1RgAgACeKQD//4I5AIABrPmA
Date: Fri, 14 Jun 2024 03:55:05 +0000
Message-ID: <d5309643a85144b4abbb8705b6e7bd8e@huawei.com>
References: <20240613063510.348692-1-changbin.du@huawei.com>
 <20240613063510.348692-2-changbin.du@huawei.com>
 <961fe800-7160-4c53-a3a0-f16700c433cd@intel.com>
 <1e17854b16fe46a4b384b6ddec05029a@huawei.com>
 <dfc9a604-6857-46af-a778-5c354fe199be@intel.com>
In-Reply-To: <dfc9a604-6857-46af-a778-5c354fe199be@intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemd100011.china.huawei.com (15.02.1258.034)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4469B8DA2F78264E8F076DE6BAD8C2B3@huawei.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Jun 13, 2024 at 01:19:20PM +0300, Adrian Hunter wrote:
> On 13/06/24 12:49, duchangbin wrote:
> > On Thu, Jun 13, 2024 at 11:23:26AM +0300, Adrian Hunter wrote:
> >> On 13/06/24 09:35, Changbin Du wrote:
> >>> The vdso dumped from process memory (in buildid-cache) lacks debuggin=
g
> >>> info. To annotate vdso symbols with source lines we need specify a
> >>> debugging version.
> >>>
> >>> For x86, we can find them from your local build as
> >>> arch/x86/entry/vdso/vdso{32,64}.so.dbg. Or they may reside in
> >>> /lib/modules/<version>/vdso/vdso{32,64}.so on Ubuntu. But notice that
> >>> the buildid has to match.
> >>>
> >>> $ sudo perf record -a
> >>> $ sudo perf report --objdump=3Dllvm-objdump \
> >>>   --vdso arch/x86/entry/vdso/vdso64.so.dbg,arch/x86/entry/vdso/vdso32=
.so.dbg
> >>>
> >>> When doing cross platform analysis, we also need specify the vdso pat=
h if
> >>> we are interested in its symbols.
> >>
> >> We already have logic to find debug files, and to deal with a symbol s=
ource
> >> (syms_ss) and runtime symbol source (runtime_ss).
> >>
> >> Can't we make that work transparently for vdso so that the user does
> >> not have to.
> >>
> > For Ubuntu, we can find the debug files of vdso in
> > /lib/modules/<version>/vdso/vdso{32,64}.so. These two are debug version=
.
> >=20
> > For local build, seems vdso{32,64}.so.dbg are not installed in /lib/mod=
ules/ nor
> > other locations.
>=20
> Isn't there /lib/modules/<version>/build symbolic link to follow?
>=20
hm, we can try /lib/modules/<version>/build/arch/x86/entry/vdso/vdso*.so.db=
g.
Other arches are similar.

So, we will try these pathes internally. And keep '--vdso' if someone reall=
y
want a special path. (just like vmlinux)

--=20
Cheers,
Changbin Du
