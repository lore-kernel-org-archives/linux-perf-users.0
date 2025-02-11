Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A181EDA38;
	Tue, 11 Feb 2025 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260131; cv=none; b=CROsJjKy8gUPvrSpIZ+jvGshjHHERrQ4sTBiGCqAbRKIufMeMZylwNIp1dhDg5eLjRLsRx7LLoqi8032doDxT3iCK5MimZY6bfIDg3/78Bt1jGzaXHVhV8M5B2GtsBu4qblSrpoJQZqSjOPfuqwow+8V8yvKd9aPV/bHxssu+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260131; c=relaxed/simple;
	bh=i9mApgRl/34Hvnr2FI4liwukHUzLOAV8H28W3dbsKYc=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bi+woWUmhKlvqWLEvJJmXC4iu7ciXbE0ByMCY7SX6f9JtHVg42qXsaWNkgV5KLGydw0CGys/+Zpy28KyOfRTxZ/sHjvkXXjWytuZZBzeLCUDuSFb8D7fFmrjuAFZllob1jJSnFSLUIrQb7MbwDd4RbZ7xE35400bDZUo80+36Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=2/HEGcR9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I4IxVtCn; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="2/HEGcR9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I4IxVtCn"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id B00B513802BF;
	Tue, 11 Feb 2025 02:48:48 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 11 Feb 2025 02:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1739260128;
	 x=1739346528; bh=ZxB3/5WwQz68fg3MoEi71/v426Fi20HIksm5loNdxsU=; b=
	2/HEGcR9OGOaAwRQO6L6sMF2KbOtsNplv7MNsDt/YCxHuhPRcqAYtEiGoZgIwOfc
	uL3sX3JSq1cawjwJkoxV3QTUgisQ3ya7PSS1ytut1LTD8PGj+BKk96+KJE65RNBW
	Tsphgr7hCXE4tVIJ34oYnPVbiB4vjSTfc9/NOGeoGbswiwgC1a+6NHKuopy+NWom
	W8Aye1T6NHlCILvx9Uo/L5Kan0YegyE5vRZFt0JnSxM/E7xAAFXkVMgaJLxHkNSW
	7vSPcFaDVUCUX03VcnEb5QcRWhgQe/5RuBfnXo/EPUTyYvPI+L0q+ljabvM280SI
	8+YYDn0Hmr5uRCF9PS3rqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1739260128; x=1739346528; bh=Z
	xB3/5WwQz68fg3MoEi71/v426Fi20HIksm5loNdxsU=; b=I4IxVtCnnAUwaMwdS
	HBPGl0s8Bs7N5OvfxUUj7rmVpwUDenuSUtoWA8qW7iOVzTrXUCYnMvk85s2z0xoR
	WwjfijsoIZ2gTZvqKVWotAOhcud1aPNGWjwV5EUeMHeY8JPZJfZ+Xl8EawFUVWba
	L3G6vsOf9tVmmeY9c0Wm3+WHg4QEmtkIr425BlwrsmYGhpE/Bmny9s4MR27hsZYL
	y6+mygr/MkXkIGwZMSloEQsmGVX47ObWdyppCTZAe/elBW2w3wJ2xxOqyqnb6WE1
	pUlHrn/PNj4fbO2AgIJp64uaid65I+6U3nPUa7F1LIYYVGTHDQvsRUDBL0TAlSC2
	PtUrg==
X-ME-Sender: <xms:3wCrZ2JHs4IEKLoCYrrqhDKpD0sECcz6XTbclk5k5JQOCStIbUrLoA>
    <xme:3wCrZ-KMxcrDJeRW5DKhBWQAbB8In_PeccU4ovCK8v_85BQrb0r0MSUwuSRA9sLTX
    4SX2c5Sd_RQzhV7q7Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegtdegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfekledtffefhffghfetteehuefhgfetgefhtdeu
    feduueeltefghedtjeeifffhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepfedu
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrg
    hssegrrhhmrdgtohhmpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgt
    ohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoh
    eprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopehhohifrghr
    uggthhhuleehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepihhrohhgvghrshesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtoheprggurhhirghnrdhhuhhnthgvrhesihhnthgvlhdrtghomhdprhgtph
    htthhopegrtghmvgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3wCrZ2tgaKZd-r19tJFBLx1c9olIzWTs4ZaRSponWadm2LzZ8pniRQ>
    <xmx:3wCrZ7abmJIQQGxBya7YEj5PHj7E42WKmlGvJuuqMoyGm5CmplJPQg>
    <xmx:3wCrZ9aU6yItPSC8xJtXsBq-fJNVShJH7DJB1OOPcE4_GM_L7YKmfw>
    <xmx:3wCrZ3A_NdBF4H9b_qRB98P-LNzrFo0iZkHCoC5kpllQIinlE4Y6uA>
    <xmx:4ACrZwlxbCT18wcLzBJjhR0WUz3hezoGAamIPURRlc7nthRHwLvQT-fx>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 374062220072; Tue, 11 Feb 2025 02:48:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Feb 2025 08:48:26 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ian Rogers" <irogers@google.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
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
Message-Id: <07c5c3ad-5a6d-4eda-95f2-ed16e7504d4c@app.fastmail.com>
In-Reply-To: <20250210165108.95894-4-irogers@google.com>
References: <20250210165108.95894-1-irogers@google.com>
 <20250210165108.95894-4-irogers@google.com>
Subject: Re: [PATCH v2 3/7] perf syscalltbl: Remove struct syscalltbl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Feb 10, 2025, at 17:51, Ian Rogers wrote:
> The syscalltbl held entries of system call name and number pairs,
> generated from a native syscalltbl at start up. As there are gaps in
> the system call number there is a notion of index into the
> table. Going forward we want the system call table to be identifiable
> by a machine type, for example, i386 vs x86-64. Change the interface
> to the syscalltbl so (1) a (currently unused machine type of EM_HOST)
> is passed (2) the index to syscall number and system call name mapping
> is computed at build time.
>
> Two tables are used for this, an array of system call number to name,
> an array of system call numbers sorted by the system call name. The
> sorted array doesn't store strings in part to save memory and
> relocations. The index notion is carried forward and is an index into
> the sorted array of system call numbers, the data structures are
> opaque (held only in syscalltbl.c), and so the number of indices for a
> machine type is exposed as a new API.
>
> The arrays are computed in the syscalltbl.sh script and so no start-up
> time computation and storage is necessary.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Howard Chu <howardchu95@gmail.com>

Your changes look fine to me, but I noticed one part that may
be wrong before and after your patch:

> 
> -const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;
> -static const char *const *syscalltbl_native = syscalltbl;
> +const char *syscalltbl__name(int e_machine __maybe_unused, int id)
> +{
> +	if (id >= 0 && id <= (int)ARRAY_SIZE(syscall_num_to_name))
> +		return syscall_num_to_name[id];
> +	return NULL;
> +}

The syscall numbers on mips (and previously on ia64) are offset by
a large number depending on the ABI (o32/n32/n64). I assume what
we want here is to have the small numbers without the offset in
syscall_num_to_name[], but that requires adding the offset during
the lookup. Can you check if this is handled correctly?

      Arnd
