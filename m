Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B6213D529;
	Thu, 13 Jun 2024 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271838; cv=none; b=Xh/qnngPf9SOp3ZdBcDFFI6I+ySDMDsOsopvDkm1qbTndo9yru0X50yHDok5/9EONJu7OcnIF/BMvzE/qxRNzS6LruvoXhp4gS2Gq2+Yl6Bx+yXRp4/iB+QkPlGwh5/uneid6OSzy53KTSZiGmAI18GMWL1yZhZW3Q2OVvEKJ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271838; c=relaxed/simple;
	bh=kQ9SNyo/+BrkPE7wtz1I5d20j0D1dHO8ar/GU0OUDHU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aSfCrUqWD9D6iWxDI47bP2VvRTH3z6FtOyGpz0ND2x+KKXnqQ5BxEmQXmuIWh0x83DsdU23U2iMbH7gqhkKRXO+bUC1B5CoPa/YRInOirMkaeu9BthtDGIjVRt9e3QrZRh3xnYVJQbL/NcxBgwEL5yx4l3jUpsnWfPhGIKTyPXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4W0HSh43jrz2Ck2M;
	Thu, 13 Jun 2024 17:40:04 +0800 (CST)
Received: from kwepemd200010.china.huawei.com (unknown [7.221.188.124])
	by mail.maildlp.com (Postfix) with ESMTPS id 00791140133;
	Thu, 13 Jun 2024 17:43:53 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd200010.china.huawei.com (7.221.188.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 13 Jun 2024 17:43:52 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.034;
 Thu, 13 Jun 2024 17:43:52 +0800
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
Thread-Index: AQHavVvh9tYwOTcSHEG6bdTlEhoGM7HE0t8AgACesgA=
Date: Thu, 13 Jun 2024 09:43:52 +0000
Message-ID: <39be46d6a5194b6390ed31be67689c6c@huawei.com>
References: <20240613063510.348692-1-changbin.du@huawei.com>
 <20240613063510.348692-3-changbin.du@huawei.com>
 <395cfff7-9692-4123-96b6-353752007f46@intel.com>
In-Reply-To: <395cfff7-9692-4123-96b6-353752007f46@intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemd100011.china.huawei.com (15.02.1258.034)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="us-ascii"
Content-ID: <687803AF4BE4D84498FD7C39AA55BAC4@huawei.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Jun 13, 2024 at 11:15:28AM +0300, Adrian Hunter wrote:
> On 13/06/24 09:35, Changbin Du wrote:
> > If we already found a debugging version when loading symbols for that d=
so,
> > then use the same file for disasm instead of looking up in buildid-cach=
e.
>=20
> In the past, there have been cases where the debugging version has not
> worked for reading object code.  I don't remember the details, but the
> symbols and debugging information was OK while the object code was not.
>=20
> In general, using anything other than the file that was actually executed
> for reading object code seems like a bad idea.
>=20
Is this a platform specific issue? AFAIK, the binary code in debugging and
non-debugging version should be identical.=20

>=20
>=20

--=20
Cheers,
Changbin Du
