Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D6025291B;
	Tue, 11 Feb 2025 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739291680; cv=none; b=gxkZxy75qyXJHFVXWGVPg9u4ZVHCKy79T8+x7VXRgNZ9cMOGurTJqw0T1vTXOow/+mpkJ1HSiExDZ9tQoOAORJA1YYNj+x7yRhMkz4yYNJe6bxQjnhFKxksYA7cV+CAtEu7jBtqSl7cdoE3MptR9zjfQKULQpqs3T4x2Or9NT5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739291680; c=relaxed/simple;
	bh=iyV+ip2EwdiMnne11AYK6ksYSwNQGVVeMNbaT6+KsiQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Myw+9UySCew6qq/skZWfKTam2l24rqq5ejlHlqYctD0dl+gt0nuTTe3ZuEzRcJUJ1eVVVNLMjq2xsBPyafOWxmEiBMOttLYeDAoC9wW1+ojB9hlLCZWyaVLOlCUHkWpIe8F3/H82WD3fmH4tjiEVmScTzPDFNNCcEjDVYVrZT5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=2PNp0Tpu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VOzk7pPV; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="2PNp0Tpu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VOzk7pPV"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C575625401A7;
	Tue, 11 Feb 2025 11:34:36 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 11 Feb 2025 11:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1739291676;
	 x=1739378076; bh=d5BwCvTiZ3qrlhVBFg5q2tte+PfUCaSlYpVNs8m646o=; b=
	2PNp0TpuncwFONiMcbpBK4M/zx0SSDekA/9pIC+cjylGukqoFIvRToiF7G+9hSeO
	Lrxtcb86BxSUbi5oxHvNGr4iFRiDSdSjGtmYOH7yPcbh+MSfREawz3FHqeJACFeH
	DOuBzwlIdP9e02fs2fikxkTU7+Tn21U9jmW3uG3VOlOCaK0+kC4uk7DADQLeqyXK
	Q7yw7nTgDYcXC8kGRSenmRfJ2MMKKKaEo5Zpd6KyTQ4nkVsfL9IObL20RumozGqu
	G2reGtG+5sHI/ldhJX+1bwKKBtOTrNPxha7IX0l3TqZCcxy9OKKYCbJOvK19G08k
	lGRRPWeLHjl1sNT+Ep4BJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739291676; x=
	1739378076; bh=d5BwCvTiZ3qrlhVBFg5q2tte+PfUCaSlYpVNs8m646o=; b=V
	Ozk7pPVP0h+2AgFpeLiu+lol0wO2ZOwZbLVqtS4KGk4Sv3t85E1mudIpDOEbXfQL
	kksCP0l0S7lLL12pN0nc08TxkUTAySh0HNLuXoaM/UMgiP5+1SjVWJ6zxcso6xgB
	DXx1A/PvuTqX0pHNffJwi/lYiwtgsvho07LVmJP0hGlnr8Pdg7om3k7lSU9KMbuQ
	JvHx3r1SIE6xCTyKz5ryBzOALXnitWKk9i72BizUxDkREmwuaT74owWu8j/1K9/2
	n/4maTuzyGNFP7eNX23yp21uiE2+6b9EhXmLH993y4ogPLwJ7mcqid0u5CPdydya
	kuSBAth4Bxik9i6KGDWig==
X-ME-Sender: <xms:G3yrZ0_1Q0FaY3Ee8S-xqosqwKaUdnqIkyLkedkcu-bNFNAb450W4Q>
    <xme:G3yrZ8uIHsfjJoL1mqa3ii6htsHiHG3Axxyp7vKd-WjvSr8OeI2pKDxvAJK8qv5QG
    umammks5eod-_0DqTY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeef
    uddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinh
    grshesrghrmhdrtghomhdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdr
    tghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtth
    hopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtohephhhofigr
    rhgutghhuhelheesghhmrghilhdrtghomhdprhgtphhtthhopehirhhoghgvrhhssehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhr
    ghdprhgtphhtthhopegrughrihgrnhdrhhhunhhtvghrsehinhhtvghlrdgtohhmpdhrtg
    hpthhtoheprggtmhgvsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:G3yrZ6D4alMOE8a4n5nNd47ja1Afft99h3C7U7t0sfArp3SwKp8zTQ>
    <xmx:G3yrZ0cIT9itAmmwv_nJYSaHkR9KXCJ7zp3EYddpHtGBzpLB3Uaj8Q>
    <xmx:G3yrZ5MUzop_mWBRb-SdG5t8q4ll4twTv6rZSd5xaHfEvJ5mHsow_A>
    <xmx:G3yrZ-lwpTINmJhziLmwbMkAZW-tz6V43rSWnjoB0CzV9r-nE8xyMA>
    <xmx:HHyrZxaR4B9VF91_YcucqNeu4wHHckuYASiugAG400-WBcAbej798u8y>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3A14C2220072; Tue, 11 Feb 2025 11:34:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Feb 2025 17:34:14 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ian Rogers" <irogers@google.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>,
 "Ingo Molnar" <mingo@redhat.com>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>,
 "Namhyung Kim" <namhyung@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
 "Jiri Olsa" <jolsa@kernel.org>,
 "Adrian Hunter" <adrian.hunter@intel.com>,
 "Kan Liang" <kan.liang@linux.intel.com>,
 "John Garry" <john.g.garry@oracle.com>, "Will Deacon" <will@kernel.org>,
 "James Clark" <james.clark@linaro.org>,
 "Mike Leach" <mike.leach@linaro.org>, "Leo Yan" <leo.yan@linux.dev>,
 guoren <guoren@kernel.org>, "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>,
 "Charlie Jenkins" <charlie@rivosinc.com>,
 "Bibo Mao" <maobibo@loongson.cn>, "Huacai Chen" <chenhuacai@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>,
 "Howard Chu" <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-riscv@lists.infradead.org
Message-Id: <8ed7dfb2-1e4d-4aa4-a04b-0397a89365d1@app.fastmail.com>
In-Reply-To: 
 <CAP-5=fV0AVEp1uEtKjAqOmwqKSRuUzTwrXnBiqc=Lopfj4hBSA@mail.gmail.com>
References: <20250210165108.95894-1-irogers@google.com>
 <20250210165108.95894-4-irogers@google.com>
 <07c5c3ad-5a6d-4eda-95f2-ed16e7504d4c@app.fastmail.com>
 <CAP-5=fV0AVEp1uEtKjAqOmwqKSRuUzTwrXnBiqc=Lopfj4hBSA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] perf syscalltbl: Remove struct syscalltbl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025, at 17:18, Ian Rogers wrote:
> On Mon, Feb 10, 2025 at 11:48=E2=80=AFPM Arnd Bergmann <arnd@arndb.de>=
 wrote:

>> The syscall numbers on mips (and previously on ia64) are offset by
>> a large number depending on the ABI (o32/n32/n64). I assume what
>> we want here is to have the small numbers without the offset in
>> syscall_num_to_name[], but that requires adding the offset during
>> the lookup. Can you check if this is handled correctly?
>
> Thanks Arnd! I agree the tables are large and can be sparse, they'll
> also be full of relocations. MIPS doesn't look like an outlier to me
> here:

Sorry, I should have been clearer what I meant, see
arch/mips/include/uapi/asm/unistd.h:

#if _MIPS_SIM =3D=3D _MIPS_SIM_NABI32
#define __NR_Linux      6000
#include <asm/unistd_n32.h>
#endif

and
arch/mips/include/generated/uapi/asm/unistd_n32.h

#define __NR_read (__NR_Linux + 0)
#define __NR_write (__NR_Linux + 1)
#define __NR_open (__NR_Linux + 2)

These offsets are 4000/5000/6000 respectively.

> ```
> #if defined(ALL_SYSCALLTBL) || defined(__mips__)
> static const char *const syscall_num_to_name_EM_MIPS[] =3D {
>        [0] =3D "read",
>        [1] =3D "write",
>        [2] =3D "open",
> ...
>         [465] =3D "listxattrat",
>         [466] =3D "removexattrat",
> };

This means the array is not sparse, but the numbers
here do not match the syscall number argument register.

The question is whether tracing on mips adds the same
per-ABI offset again, or if it tries and fails to look
up index 6002 for 'open'.

       Arnd
