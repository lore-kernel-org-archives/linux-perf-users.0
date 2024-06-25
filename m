Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D754918030;
	Tue, 25 Jun 2024 01:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719280078; cv=none; b=N/BFvuRnM5sq+fbdk4ePlZhuCBfvf6/apZ+kJYQU5SPE5kIvPMmAhLp9JRPI6sv9LDvPuNJ41cMdXt/KzjJUnGAarjVCPos8lrdSK97+LZrhvqQ8F0xP0cE4xFpRT8d6ACfI/GypUGQ89AHQ899ftWfI5z3MYD6l2HtGFjK7dUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719280078; c=relaxed/simple;
	bh=9Rsb31kwR8ngFnYt1tUrH4yXXEL3qfuG/Tay2QGDL1Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xx20V8PL+1wz9sldP0PhKGU3jeY6g4xgA/vBe2u5rTPL6Z0uj1XOko09cgA6PXpvQ3asbUiiDZZRlVLjJYsYClyjOyDom3v24W5Rp3mhsqMlzt94iwLjZEM1/eW3AHPhhF4c8EPSingoKES87aWV4UkETXebNpNOw9naF7AWBH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W7SKJ2fVBzZg0K;
	Tue, 25 Jun 2024 09:43:32 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id CB9C21401E0;
	Tue, 25 Jun 2024 09:47:54 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 09:47:54 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.034;
 Tue, 25 Jun 2024 09:47:54 +0800
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
	<linux-kernel@vger.kernel.org>, "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH v3 2/4] perf: disasm: use build_id_path if fallback failed
Thread-Topic: [PATCH v3 2/4] perf: disasm: use build_id_path if fallback
 failed
Thread-Index: AQHawSK1ifvJzOPE3ES+2w16NY3J17HXHy4AgACh0oA=
Date: Tue, 25 Jun 2024 01:47:54 +0000
Message-ID: <bfdcb5d8f0664f48a3d6be93954ebdb2@huawei.com>
References: <20240618015530.3699434-1-changbin.du@huawei.com>
 <20240618015530.3699434-3-changbin.du@huawei.com>
 <ZnoKcoHtjvJgjETL@google.com>
In-Reply-To: <ZnoKcoHtjvJgjETL@google.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemd100011.china.huawei.com (15.02.1258.034)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1063B9E35DDEF04BBCEB437215F3D84E@huawei.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Jun 24, 2024 at 05:08:18PM -0700, Namhyung Kim wrote:
> Hello,
>=20
> On Tue, Jun 18, 2024 at 09:55:28AM +0800, Changbin Du wrote:
> > If we can not fallback for special dso (vmlinx and vdso), use the
> > build_id_path found previously.
> >=20
> > To make change easy, this change first refactors the code by extracting
> > two functions read_buildid_linkname() and fallback_filename().
>=20
> Can you please split the refactoring from the actual change?  It'd be
> easier to review and to maintain the code.
>=20
Sure, I'll do it taday.

> Thanks,
> Namhyung
>=20

--=20
Cheers,
Changbin Du
