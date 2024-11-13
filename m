Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D2515AAC1;
	Wed, 13 Nov 2024 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731531024; cv=none; b=UbG852vwxPiA2qx/N5OVFwyCBSpq0Kzg65h1c4MGMWJXcbOOfuObzV02paPEU++bvJRzNWbM10Nw6A+UiYIm38RtcSk2K28QRF9SaKFytiNcWEkrHenrgRw7xjiaXhkS4i1WUyuDSQ8b+AaBVOoGCIneObG0EiuBIrKuKY6Ydms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731531024; c=relaxed/simple;
	bh=WmIbPAYl/ZC8V/Y4pNLGsWB1rlzwt7GQTHsbr9TpUa8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4WdMuEKXZH2ti0stGtf9UBNlpamhtlyd89GTBUaMWokinC84dIduTT6vSxVNEsFhgOzyAUP8Pta27If+df1m5CPVI+2IVigZ0x+9mnk8rscJFM9wsgP0BTX5ZEjTfM47//wJ+J6LTuy7QgMuIN3uSV4greU63CJiV64xy7iYnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4957CC4CEC3;
	Wed, 13 Nov 2024 20:50:21 +0000 (UTC)
Date: Wed, 13 Nov 2024 15:50:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, Indu Bhagat
 <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
 <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>, Sam
 James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Florian Weimer <fweimer@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
Message-ID: <20241113155040.6a9a1bed@gandalf.local.home>
In-Reply-To: <1f83be89-b816-48a3-a7ee-9b72f07b558e@linux.ibm.com>
References: <cover.1730150953.git.jpoimboe@kernel.org>
	<42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
	<1f83be89-b816-48a3-a7ee-9b72f07b558e@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Nov 2024 17:59:08 +0100
Jens Remus <jremus@linux.ibm.com> wrote:

> On 28.10.2024 22:47, Josh Poimboeuf wrote:
> ...
> > diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c  
> ...
> > +static int find_fde(struct sframe_section *sec, unsigned long ip,
> > +		    struct sframe_fde *fde)
> > +{
> > +	struct sframe_fde __user *first, *last, *found = NULL;
> > +	u32 ip_off, func_off_low = 0, func_off_high = -1;
> > +
> > +	ip_off = ip - sec->sframe_addr;
> > +
> > +	first = (void __user *)sec->fdes_addr;
> > +	last = first + sec->fdes_nr;  
> 
> Could it be that this needs to be:
> 
> 	last = first + sec->fdes_nr - 1;

Yep, I discovered the same issue.

-- Steve

> 
> > +	while (first <= last) {
> > +		struct sframe_fde __user *mid;
> > +		u32 func_off;
> > +
