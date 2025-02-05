Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29419193436;
	Wed,  5 Feb 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738774375; cv=none; b=mb5CgYplEJh+Vf3hozlnCYZ0o2BkqyeL+B78w/wtYeue2ZWUYNqYMcDOCpTAVK+JVjd2yQgdDIWJsfVfUKCEl2ZKbJHW+mZFxqFpyhrn6fxVeH2C48xLachDI7VM33P0LZP26gmYIM8NBHIDq6C0lpwDQRXuxPrZbRw16sQLNWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738774375; c=relaxed/simple;
	bh=MZX1aiElAf/wBBYEzwG0LmNRp3/R5sTvrYMDQ486w4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7dmDayRDL3VcAcH0O1JQi7fFw8eHd/TRLy3OMgdBM5tbGwZbfPadLWlhVpLMunn2tuE+oc8yU9XJ8LVqy4hvzcziijKwz7PAyT7Or3Hzaewd6/81cB0d27Cj+klUToi/JS8IwCi6QYKJbLrErUIaKajqtV2DXpVUlo6fw+R8rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=IEQDOg7t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=04gnE32p; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="IEQDOg7t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="04gnE32p"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 30F1F138017B;
	Wed,  5 Feb 2025 11:52:52 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 05 Feb 2025 11:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738774372;
	 x=1738860772; bh=4Ff8uNZFWrL12Ts+CTuP9c/TuX47E65KwL5a+LkGyJo=; b=
	IEQDOg7tAB/7oZOJzwMeHDyFcJx6MvkaM2fvdzm33tj2RvJeETvmE9lE6pqePQip
	q4caQS1d86MNYY/UHuf6DFrsv9rvP6SZuPJe2+Fs6UEVPPreh+S9Gn5P5flGFyN+
	INz9Txbm/3+99P2q1Hcb8l2KTI7jd0Ghmi0hsYPJylbVQaaywDXKZ/gYSSdPh0+N
	PBkki8PCZhYH63WOjtJ2B735XwJdR+lOHfnDWDLb2+BpmvErvFC7qhNKJrzQVo5f
	55SErNtFSpUY6R/FiU2meXSomsIxJPAmgamRi9K1VjubKUOEGYj6qMLEsemoYXGz
	rVSgWF30t8uNW0BsXcgmJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738774372; x=
	1738860772; bh=4Ff8uNZFWrL12Ts+CTuP9c/TuX47E65KwL5a+LkGyJo=; b=0
	4gnE32pga9ATr+XaUD7yWKJ3BpoEOFptRMy7pcsx5v/7au/7mr3hKv2T0u5T0v56
	pgd52tz6REIgJ3qGfVy2TY4MI3Mfbg0oMvoxzpzGwh711hpNR7IXD56+v7x13HR9
	1NIYfscMlHXbs9xPhge7p8H00RoHdnM7GTRrHIY4Fqe7zHX5xp6FgUarHVzJYhBI
	YtzbAQtu8AcE8ClsYPumLX8qakXjrEPye2HmlrxuGzlBFMSu3H8m11hTtAQA4q4k
	gAeAa5H/g9G7x014ooQGWp4VzEgueVSdAbCcnRJQkICy7mxaYPCtewqzXwkZhzOA
	GtQI09BZyLQDyg5tz3atg==
X-ME-Sender: <xms:YpejZ9yRpRJLr48UvUdYuFpxqhSLnnu98pEwzbYna4zVlWm92HNqQg>
    <xme:YpejZ9TeUDidyCqkKT3zPXvdDoz7346qZDntowKBtbIrU_dVoQAKaB1Nrh5Sv8-dl
    6BUyQVGHwy7qbgjSA>
X-ME-Received: <xmr:YpejZ3Wwcd3khW0befiVSXcw0rpAcTfRF18FUetqY3VJB5vtrnZdbZXsW6ZAnatds-Qw52zUZBfDdP9vfAJ-H-eson_UzUGLac3RXHX2rkvvXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculddvfedmnecujfgurhepfffhvfevuffk
    fhggtggugfgjsehtkefstddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepffduhffgudehueeiiedvhefg
    jedugeeuveehveegheefkeeiudfhhfehledvgfdunecuffhomhgrihhnpehkvghrnhgvlh
    drohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghpthhtoh
    epvdeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehirhhoghgvrhhssehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopegrtghm
    vgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrmhhhhihunhhgsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgt
    phhtthhopegrlhgvgigrnhguvghrrdhshhhishhhkhhinheslhhinhhugidrihhnthgvlh
    drtghomhdprhgtphhtthhopehjohhlshgrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrughrihgrnhdrhhhunhhtvghrsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:YpejZ_irsNQF8wt3lKn_DARv-ff4rgeZgWPYPmSIH180Nr5EOY-6kw>
    <xmx:YpejZ_DMnR4PowZUIh8K6IfY17TRvPeV60zY2c4je1R86JqgIYZQOA>
    <xmx:YpejZ4J-dl18h0anSM_6IXcLYCnhcjmqj9TqC4iLHgUCAOulqURm1Q>
    <xmx:YpejZ-A6kg_t06OmiI7ssBMvQ4rBz-oA135Nb-U-XbImgkuxmQANYQ>
    <xmx:ZJejZ6VoJm1Emn4tDnPex1BbxpsIkoL1X5SnFb50sao0J_oE-s_xQ_WW>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 11:52:48 -0500 (EST)
Date: Wed, 5 Feb 2025 09:52:46 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v1] perf symbol: Add rust v0 demangling support
Message-ID: <bnf37cpripiwvsadi7pmtgdqech2e6zqktk3u4dr72toug6i27@mftn3hsa3yz7>
References: <20250129193037.573431-1-irogers@google.com>
 <f500ef21-5c87-4c60-8453-d98ee637a60c@app.fastmail.com>
 <CAP-5=fVJHV=JgR_FR91V6zcVnLXnakdoiNP4Y5j-+X72r2STmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVJHV=JgR_FR91V6zcVnLXnakdoiNP4Y5j-+X72r2STmQ@mail.gmail.com>

On Mon, Feb 03, 2025 at 09:20:30AM -0800, Ian Rogers wrote:
> On Thu, Jan 30, 2025 at 11:35 AM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > Hi Ian,
> >
> > Thanks so much for working on this!
> >
> > Only did a quick skim. Seems like it'd be nice to reuse the official
> > demangler now that we know about it. Will be interesting to
> > see how that gets packaged for distros.
> 
> I think the best solution is to use the official demangler but in
> general we'd like fewer rather than more library dependencies. For
> example your initial comments were to work to make the coupling with
> capstone and LLVM disassemblers more loose via dlopen:
> https://lore.kernel.org/lkml/20250122174308.350350-1-irogers@google.com/
> 
> Thinking through the options (note I'm not doing Rust things and so my
> level of skin in the game is minimal):
> 1) stay as we are - well this is a mess as there is no v0 support and
> the legacy support comes from libbfd/libiberty.
> 2) option (1) plus this change cleaned up - there's still the mess
> with the legacy support, which is probably more important given v0
> isn't widely adopted.
> 3) wait for the official demangler to be packaged as a library and
> depend upon it, add testing from here - solves legacy and v0 issues,
> but brings in an extra library dependency to the build. Timeline not
> clear.
> 4) "contribute"/copy-paste the official demangler into perf tree and
> do like (3). Perhaps remove the forked file when a dependable library
> exists (there's some precedent for this with how libtraceevent was in
> and then removed from the linux tree) - solves the timeline, not great
> to fork the official demangler, so far not heard from the author Ariel
> Ben-Yehuda and I would strongly prefer they contribute rather than I
> copy-paste it.
> 
> For (3) and (4) it is probably a good idea to engage the Rust folks in:
> https://github.com/rust-lang/rust/issues/60705
> 
> Having broken Rust demangling seems like a high priority issue for the
> perf tool.
> 

FWIW, while I quite enjoy rust, I don't write much of it day to day
anymore. I was only investigating on behalf of someone else. So whatever
other folks prefer is fine with me.

[...]

> >
> >      * INPUT:
> >      *     sym: symbol that has been through BFD-demangling
> >
> > Perhaps double check that cxxabi is sufficient and update the comment?
> 
> I've not tested this change beyond making it pass the tests the change
> contains, that are based on the v0 specification's examples. I believe
> this/legacy may be working as most C++ implies libstdc++ which I
> believe uses libiberty in cxxabi, so BFD demangling. Given the
> popularity of libstdc++ I imagine things like LLVM's libcxx will try
> to be compatible. Perhaps if there are examples of legacy Rust symbols
> we can add a test?

Like you said above, let's see which direction the community prefers
first.

Thanks again,
Daniel
