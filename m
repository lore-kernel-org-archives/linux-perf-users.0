Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.141
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097350;
	b=RNn1J5RTamQKJPHiMBD9MPXSA7aju0tmP2umUycCeUjyWYBWAcMCC+x9HzqJ0SZ2Ujo1
	 MrBwkVU/ugu24sPTQVUGqru+0FFEg7oFvR7f93F8pkOxmJld1AOEI9LkQO3A6BLV4DKGL
	 qwD75Nsx7wLG5bXtkOCERtIM9hLQLx9QBIafglPg+QpT6FKq4Q4ljJotNi77Y7Ql2L52h
	 jfiHvwdd9BRafW6yCHo82/EhtIegDufIFWMPzwtHdU9L1lT4LJ2j/l4ntOAnzEBnK6JZN
	 szosuIHaFry1BupyIiu6c2Q4Gbjg4NqBDR7hlbAcMxiPgRXm86Ct6zqxSn3IhFid6/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097350;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=cD96WCdctpe4xqBu48fVzWQv2mdj+Q39Vw8+UuE9NOY=;
	b=4XzL7snhjrQls7cCT9wDGnf08XpyDCeYoMS6fq4mwhsKgbv+T3I5sr+sUZqjd2+V1HRi
	 o1wXeUvEjpUesmap4iRSoL1s1DD8GDpQcrkpyK/lQspml3+FoQVMy9Qhh30BXUufEU/2x
	 nr0ufkMTb07VrTecr17vA/acG7FTNtGj796JQG2pGYXATJASOYOgcmmNQQuW+/hzlHt1q
	 sdwj47MB4h/IauSVrIzOliQGEjenYKU4eVl9jLFBN/otJLcuotrw771qg2/J6bxC5dbWx
	 wX/GBYvXqmfTME38yOytjhrqXHxlXxi/rbPmNktddk0o5SxJcMTnZNkG/Pa2e/OrieA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=g0poesKL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wMaGvRgN;
	arc=none smtp.remote-ip=202.12.124.141
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87DA606A326
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 10:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E87DA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=g0poesKL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wMaGvRgN
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.stl.internal (Postfix) with ESMTP id 348B5130298C
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 06:35:49 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 27 Oct 2026 06:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793097324;
	 x=1793104524; bh=cD96WCdctpe4xqBu48fVzWQv2mdj+Q39Vw8+UuE9NOY=; b=
	g0poesKLuQGMaU7v25wYb164Iof879cLQ+jrS7Vw6CuhEsyJqwn7PFMO9TEgL555
	salmD3V/ClUhsKzYPi0e1twlBEQsUQgTWR1AZ4ucxcvSWh0tFF+QsAmR7kyrExiD
	rs8QFLT2d4K3gWpb7cbvYPqhV9WNtc7sDvVFrq/AeZGLbrsDceBV0QVq1catnKNP
	0vZraw8GdX+eRczyZn9JW2/ZNbjBM4QFUKd6YGV2yTzJi2ns5fiipJSmFKiJF3sN
	GoBWeR4K6FMeN3rQg7Q7I4UT9hD0E+qvVgrEVdMfqW0b8abtf0o6SMw5UbAH+FLg
	hVWbTZEFzS2/5wF4AlN9FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793097324; x=
	1793104524; bh=cD96WCdctpe4xqBu48fVzWQv2mdj+Q39Vw8+UuE9NOY=; b=w
	MaGvRgN74SqlQokg0yGoa0qHrxHvnpo1EgRYl+NAZ2HGjyf2DoHqc5uAKC9rWw6/
	vV5njRj3VAjVsozr2QciajWKilgp9EVdkzTxKpA/MsGbxExu52PceTGPRcPZsISB
	KpYKodw2SCDSr9uGfucfgcGE2SA0UG7iid20bXHmKysdvynyqnnRbJjpSNwQ33N1
	0pa9wUuAxjPIT/YsNOqCEmHDj7Qibp8Oyln4Wr2lT6g2YFOhW7GTB1NdlTnD6Y/N
	mqImDReIq39YA7WkoOuwESu2xsiCrgirovD+YpK1k72+skpa4xR6mPYjJvlLn92L
	+KFpP5vjxlM5S0xUcBdYw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793097324; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:jrTra7FA1hIQJRg6MulJgntqoye1o4zz6cC3g54crkqBWZE
	ZrR5BZXkelBrXWVBaIS+uVn+o4IV/bT7pfKXt/N/2ACJq/Z9o1Iqk+PsHZtMfdOJ
	1iqltW21HRy6do+TFC4Eo261UuN2WiQ18Tu78XjV254IoX6Mmn0+5b7VAFQKHhof
	IAyhGspN3G1Zz8D1+rsq0k4nirJy/OWybVj0La65W3u0HwVFtJuLRzDmONHEwNkI
	gnsTjToKZjXjwlTJ9Zm3s77ojY+J9W2j0WQfAGsFqmwF+zWBIHWnYz0GaEFCRd+R
	EI6RFCP4jzLaVZfcAw4sZC4+jsd5mjwLCXna1dg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:cKjetnoeFjJorNH+mroEPI71xZFnj0iEAx7opE2N30E=:+7cbM9Ly9xGwj1eAsvoI2B7rTf1bDojBouGfp8ZZDqA=;
X-ME-Sender: <xms:Yn7gauJPeu1PinbCI2gYx0_jlj2PnQL9uVqEmxziDToBSgj9D_xRbA>
    <xme:Yn7gag_jv3yDvc0KG6xNU0a3i3tsXlBRwgQXJ5nMfcMcUHLemzagppJ4LiVff77wd
    kWfJ0mG4Cc1YdeleyjjRgNmR8bhi_EzFH5DKuKtc6zsMLGUhHUiVHY>
X-ME-Proxy-Cause: dmFkZTFn5p5gNfTa2ln7Ur1M8HLGH3FByI3bMffV+IVuNBxFNqZT4qibdV0911N+HRUSXj
    K07q1nctC5A6CcFfeLY7jBaLOsZKNIqYeTCeDTItiSfcD8KPMq3RagWnzHGWxZYBxWAiCm
    A3VT2o0IozuPu/s7pvPmuxDhNCPVlHQtdJeKAQbZtM/B41WPfEm0WHEt7Z4VBmU7Awz3r2
    CW1Ic84f68hqkyPgXyGKcQw2wWDeenYkz/P7wEtiFmdUVM0amFmkVyW6og0RqG5tm89hZw
    aKjqOAwHgBmvujhKmrOmxUKnEU58c+GvStpS1gjFmbH3Cw9L2zocbcI2nShgNxT4DZbAQR
    wgaSkDdcdMc/d9G+mxaz1POpKC9kteRE12RXj5cBt5pww+0ny7yXHoqz13E7ttwMLwV2Zx
    irGvBcy8nzFHGZLzVSm2bc8v02AbCF8YXzUkvfzziFLvAHlSLPGQdoNZ9j8Z+n4FuXVzNX
    YX6+5h5244zwOTl9aQiqLa2ox4HvDWrM9qIOP1ddj/Qc6TrOohBTM5knyFzE2y92EKQkba
    jTOi3P5IOCM4Xz9GLVwUPx/34MQnZ46TWseR6J3W3XI63DkzQUPhI7lmU3qjmL7/C1LwgY
    Sem/AhqkedQIukr61kUqtibtpdY8TqVUBtJQynB3XFjVXPk3rqiMNJFlIJrQ
X-ME-Proxy: <xmx:Z37gapHvcVHvMaM3ipgnYUZzm2Ryqqq0XCp7NdxFgDjKT2zqjSy1vg>
    <xmx:Z37gapt5WD8JfcDqZC3gZOEaTUAl0efsI8damzFuxdzMc9AsHa6DBA>
    <xmx:Z37gao4LOQoh_k9Rjo00qqoo4baOxCcq29WjL83ZgQ6XABea2d3MPA>
    <xmx:Z37galm2wjPgXkNjyPJ3HOpQNs8U8c25nqH_wkaWl6-1QurrUIflow>
    <xmx:bH7gapzWCUwwKYEsxCX9776XutFUkBaJpOGzr7ZN12X60l-MCDK0DRme>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id A3C9932A0093; Tue, 27 Oct 2026 06:35:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AUJ1OXWu3nCJ
Date: Tue, 27 Oct 2026 11:33:08 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "James Houghton" <jthoughton@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>
Cc: "Thomas Gleixner" <tglx@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Kees Cook" <kees@kernel.org>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "Lorenzo Stoakes" <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 "Mike Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>,
 "Michal Hocko" <mhocko@suse.com>, "Sean Christopherson" <seanjc@google.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, "Jim Mattson" <jmattson@google.com>,
 "Jens Axboe" <axboe@kernel.dk>, "Pavel Begunkov" <asml.silence@gmail.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <mkp@kernel.org>, "David Sterba" <dsterba@suse.com>,
 "Chris Mason" <mason@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Ingo Molnar" <mingo@redhat.com>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>,
 "Namhyung Kim" <namhyung@kernel.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <3c125ff6-5426-4f19-8e34-fb564d4b6387@app.fastmail.com>
In-Reply-To: <14f5f919-55bd-47c6-a1c8-6f1445cce733@app.fastmail.com>
References: <20261026215226.3713941-1-jthoughton@google.com>
 <14f5f919-55bd-47c6-a1c8-6f1445cce733@app.fastmail.com>
Subject: Re: [RFC PATCH 00/10] uaccess: Refuse and warn on user accesses when
 current->mm is NULL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 27, 2026, at 01:12, Arnd Bergmann wrote:
>
> E.g. on arm64 with CONFIG_ARM64_SW_TTBR0_PAN, the page table base for
> the current process is only set in user_access_begin() and would
> not point to any task here. Without ttbr0_pan, it should be
> covered by cpu_set_reserved_ttbr0() turning off all user space access
> for kernel threads.

correction: for non-sw_ttbr0_pan, enter_lazy_tlb() does nothing
on arm64, so it is the same as x86 and the others.

     Arnd
