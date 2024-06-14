Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3353146582;
	Fri, 14 Jun 2024 03:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718336909; cv=none; b=XfAGUtWrOCxyn4nsvCcgPXJULywCwS/dBxiXFJ0RPeWKX/4PgLg9tZsvBWUawV8anWD4tJrXLjglGDzG+k9Nerw5mjJ+zV7JhChEzvkFr4YXrLA7IX9eRIAsg14HRXD2+wU+uyCEFS4O2VuRyBk0ii+rZS3sryL+Cmq5MLOB11k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718336909; c=relaxed/simple;
	bh=tOdcNuf2kRMwiFSwcr6k9xuklL/HpB+Iw5uNR7FPc44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ruJNm9QnpKNWJnK6biH+ETb2QEupoSaqIU7i0bE2btlzzFl23SVZkQAc0aIQNyIcPe2bHnldDpiYeeTBc0qXKozuWu4YKoDgnm/h9T6jzFPZcptZPBCw9PD8aY0HbVkdkgxfBcoJe51jo660i1N+I1gz9FHLfZt3m9P5BW0s6a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W0lVx4w1pzmYsS;
	Fri, 14 Jun 2024 11:43:37 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 1BAD318007C;
	Fri, 14 Jun 2024 11:48:24 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 11:48:23 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.034;
 Fri, 14 Jun 2024 11:48:23 +0800
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
Subject: Re: [PATCH 2/2] perf: disasm: prefer symsrc_filename for filename
Thread-Topic: [PATCH 2/2] perf: disasm: prefer symsrc_filename for filename
Thread-Index: AQHavVvh9tYwOTcSHEG6bdTlEhoGM7HE0t8AgACesgD//4X1gIABqREA
Date: Fri, 14 Jun 2024 03:48:23 +0000
Message-ID: <4b420b265a6d4c298315807725734a31@huawei.com>
References: <20240613063510.348692-1-changbin.du@huawei.com>
 <20240613063510.348692-3-changbin.du@huawei.com>
 <395cfff7-9692-4123-96b6-353752007f46@intel.com>
 <39be46d6a5194b6390ed31be67689c6c@huawei.com>
 <6abf540f-5f11-4b2b-b8c1-69783a71277b@intel.com>
In-Reply-To: <6abf540f-5f11-4b2b-b8c1-69783a71277b@intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemd100011.china.huawei.com (15.02.1258.034)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C4B1CA3441B83140B661C4C905215D26@huawei.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Jun 13, 2024 at 01:26:39PM +0300, Adrian Hunter wrote:
> On 13/06/24 12:43, duchangbin wrote:
> > On Thu, Jun 13, 2024 at 11:15:28AM +0300, Adrian Hunter wrote:
> >> On 13/06/24 09:35, Changbin Du wrote:
> >>> If we already found a debugging version when loading symbols for that=
 dso,
> >>> then use the same file for disasm instead of looking up in buildid-ca=
che.
> >>
> >> In the past, there have been cases where the debugging version has not
> >> worked for reading object code.  I don't remember the details, but the
> >> symbols and debugging information was OK while the object code was not=
.
> >>
> >> In general, using anything other than the file that was actually execu=
ted
> >> for reading object code seems like a bad idea.
> >>
> > Is this a platform specific issue? AFAIK, the binary code in debugging =
and
> > non-debugging version should be identical.=20
>=20
> "should be" !=3D "guaranteed to be".  Simpler to avoid the issue and
> stick with the file that was actually executed.  We already support
> having separate symbol sources, so there should not really be a
> problem.
>
ok, so for vdso I think we can flow the kernel part in dso__disassemble_fil=
ename.
I'll add vdso processing here.

>=20

--=20
Cheers,
Changbin Du
