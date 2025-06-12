Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5508F5C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 08:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749718781; cv=none; b=KFss8pPVp5197RtaUBE/uZqASptcDXoY4mIHdIsreb+m5sA3A31XCLdsbVl7l4+m9Biv4RRcft4qtFcZ2aLn2Cxtb9F+cYHFxVFWynvRPlMd7FG0vUrIoeQ7OtwajHr0Z9XDvKYA9uEvyT9Tgdh5Ez5LlyL02S6GBhsHbdIZx3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749718781; c=relaxed/simple;
	bh=SVFr0O7+JSQq8Rhw2veWzfr6mSzV45zs9CjCdOJuoFg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m9mvb8elJvtBDDFvudXTEoywc66wLohG075IqUr+cyL9Vp2c/5cnLiJEXinsO3Jtnnfrk4GOGqEmf5zXv6fON7lUVSiQOFy/cfHcE/T6+2A9iDJ6h99ACwVvW+enraXGvZXVcvkfo5ZAz5DOvZfgD60HjsD6eVuq0qcvh1gAt+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name; spf=pass smtp.mailfrom=michel-slm.name; dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b=xYX/cqBx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UVoAs1wU; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b="xYX/cqBx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UVoAs1wU"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id D611A200816;
	Thu, 12 Jun 2025 04:59:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 12 Jun 2025 04:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michel-slm.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1749718777; x=1749725977; bh=Fl+UeH0U597ABFyW17NEIldFurw5BJwD
	qK7+SjPucyE=; b=xYX/cqBx28qeBbOAUeT3TSULGFltY+Mwz9MIvEVt8CLhxcFa
	JOReqsHYGtrmdN1BDmEzoJxrckiU5ra2/gg+YfXQsMfP+ug6ueagAs/UF0LmnLSC
	SbQ+Ryh5XH1RayH/sslG8gSEHsJHx+K1iYMulth2mkupX/+nAxkrEomHw0bo5bTP
	cnHs4e3JPYEsL8oQNxtu92L4cQinUQ5gfBBRu0hVemCJ3I8ouRoruNVRWWdgmw8P
	h2fUwBICuRfErLSzpWlIMurk4wRH+6tGq31HebwSF2uLT0Iw09kFKF6sOmU5z0hg
	MAvdgYpWISNh/kvrwHTYSs7fBHo85NZmoPq3iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749718777; x=
	1749725977; bh=Fl+UeH0U597ABFyW17NEIldFurw5BJwDqK7+SjPucyE=; b=U
	VoAs1wUoki2rGr+Ltkdpm7P31EL562+qeokOLIqnCgKXlnDRc85KT2V4CE7rs9NK
	nRQ6MvjiTxK1J+Bwmzx2tVISvo3bPEiwIo6iYw0ZzrI/I4rE1azlcnEPeVF94id8
	IJe4dLNo8FnX4f2kE6vEK/lZRJWxjfKY8bBR/8/2wrKshXl8di7ou4x/W5eX5S1z
	Emam2Ap7nQfOJgpmK25vWo1LGl7NVYXZSkGX4bJqtvjxL3vURWJrJiF4SsCZXIr0
	swlBx8LEG/C6iG4u/AL4jlZNp4rMRU+pDAAYz7qKs8xj26UGUCtODW8Iru1JbJzk
	6mZ6klKTKVgDaOrb87Wug==
X-ME-Sender: <xms:-ZZKaLWncn6d7lbbWmxvaK1HAg0Jdnh9VY1L4s57piDHMBHuvvd5wg>
    <xme:-ZZKaDkiULIahu1YEf0Bfomd1gFIchE5Bpgw1TBxqJdXr44pJnDFMgsUCVyaEf-Ez
    NyQwt2LuUx8EY4CnrI>
X-ME-Received: <xmr:-ZZKaHYgytyNTCx-CeBi6p3AubRAsBWgtpnqZPAEK1V5rxIxto7ixW2rSilQgDZjurFRT80HQcCtkyxOmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddugeeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtfggggfesthekredttder
    jeenucfhrhhomhepofhitghhvghlucfnihhnugcuoehmihgthhgvlhesmhhitghhvghlqd
    hslhhmrdhnrghmvgeqnecuggftrfgrthhtvghrnhepffefleeitdehueffudeguddtgedt
    kedtjeeggeetfefhleeuteejjeetffduledvnecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghdptggvnhhtohhsrdhorhhgpdhkvgihohigihguvgdrohhrghdpfhgvughorhgrphhr
    ohhjvggtthdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehmihgthhgvlhesmhhitghhvghlqdhslhhmrdhnrghmvgdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprggtmhgvsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpvghrfhdquhhsvghrshesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghmvghsrdgtlhgrrhhksehlihhnrg
    hrohdrohhrgh
X-ME-Proxy: <xmx:-ZZKaGVC5SBcIkRUappbgDPeF_DKEWzb2ruqWTdLVs6_wiWA8bNAJg>
    <xmx:-ZZKaFnHowK9sjV6H2AkVC0ebhaNE39Uko4thCvgcssimsS3ENvOTA>
    <xmx:-ZZKaDdzyLkScbi73YKlm0xKZCorEegSh33vD6DoAPypR0tLXIg_6A>
    <xmx:-ZZKaPEJLo3MD5Wb-qPr6wdqxMnSEuC_OwQCyzC4qlAeBSiRDf-wQg>
    <xmx:-ZZKaJ5APP3XYMSXCcEw3L5UmSW1RE3iT4QWYfu3-t_kOq7ChoSISG4j>
Feedback-ID: i71264891:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 04:59:36 -0400 (EDT)
Message-ID: <ec84befa833b18f7382054d2c1bc0ecd5456d8cb.camel@michel-slm.name>
Subject: Re: perf-tools v6.15 tarball not uploaded?
From: Michel Lind <michel@michel-slm.name>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>
Date: Thu, 12 Jun 2025 10:59:34 +0200
In-Reply-To: <aENMPp9SZdABPkic@x1>
References: <c5ac84be0a119d3dd432edf36196d07ad562b34c.camel@michel-slm.name>
	 <aEHylyR4hGaqZ6C8@x1>
	 <a4ac0d06699b0d69262953ce49c740d66590e05b.camel@michel-slm.name>
	 <aENMPp9SZdABPkic@x1>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-11.el9) 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Arnaldo, James,

On Fri, 2025-06-06 at 17:14 -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Jun 06, 2025 at 02:59:27PM -0500, Michel Lind wrote:
> > On Thu, 2025-06-05 at 16:40 -0300, Arnaldo Carvalho de Melo wrote:
> > > On Thu, Jun 05, 2025 at 11:24:50AM -0500, Michel Lind wrote:
> > > > I noticed the kernel.org mirrors don't have perf tarballs newer
> > > > than
> > > > 6.14.0 -
> > > > https://mirrors.edge.kernel.org/pub/linux/kernel/tools/perf/
> 
> > > > Will they be uploaded soon? Presumably I can just generate the
> > > > tarball
> > > > myself for now from the Git tag.
> 
> > > Its there now:
> 
> > > https://www.kernel.org/pub/linux/kernel/tools/perf/v6.15.0/perf-6.15.0.tar.xz
> 
> > Thanks! This works great on x86_64, on arm64 it's failing because
> > some
> > files that are needed to generate unistd_64.h per James' commits
> > starting Apr 29 are not there.
>  
> > (I tried copying the files that show up in the error log, but
> > eventually hit a wall - for the Hyperscale build I'm going to get
> > around it for now by just generating the file on CentOS Stream 9 and
> > Stream 10 VMs, but I'll try soldiering on a bit to get this fixed
> > properly next week)
> 
> Yeah, reproduced:
> 
>   CC      /tmp/build/perf-6.15.0/libapi/fd/array.o
>   MKDIR   /tmp/build/perf-6.15.0/libapi/fs/
>   CC      /tmp/build/perf-6.15.0/libapi/fs/fs.o
> make[4]: /tmp/perf-6.15.0/scripts/Makefile.asm-headers: No such file or
> directory
> make[4]: *** No rule to make target '/tmp/perf-
> 6.15.0/scripts/Makefile.asm-headers'.  Stop.
> make[3]: *** [Makefile:108: uapi-asm-generic] Error 2
> make[2]: *** [Makefile.perf:973: /tmp/build/perf-
> 6.15.0/libperf/libperf.a] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   INSTALL /tmp/build/perf-6.15.0/libapi/include/api/cpu.h
> 
> 
> We shouldn't be ever using anything outside tools, but over time we
> ended up doing that :-(
> 
> And its just arm64 that is getting things from outside tools/
> 
> ⬢ [acme@toolbx perf-tools]$ head tools/perf/MANIFEST 
> COPYING
> LICENSES/preferred/GPL-2.0
> arch/arm64/tools/gen-sysreg.awk
> arch/arm64/tools/syscall_64.tbl
> arch/arm64/tools/sysreg
> arch/*/include/uapi/asm/bpf_perf_event.h
> include/uapi/asm-generic/Kbuild
> tools/perf
> tools/arch
> tools/scripts
> ⬢ [acme@toolbx perf-tools]$
> 
> James, has this appeared on your radar before?
> 
Any idea if this can get addressed soon, and otherwise, what's the best
workaround? e.g. would copying the file generated from a checkout work?

I'm temporarily building 6.15.0 for x86_64 only for CentOS Hyperscale
(limiting it to the "facebook" variant only, until this is resolved)

https://cbs.centos.org/koji/buildinfo?buildID=61023

since some users are reporting a regression in 6.14.0 and want to test
if this is fixed:

"When trying to get a flamegraph using DCPERF_RECORD_PERF=1, the
flamegraph cannot be correctly generated."

Thanks,

-- 
 _o) Michel Lind
_( ) identities:
https://keyoxide.org/5dce2e7e9c3b1cffd335c1d78b229d2f7ccc04f2
     README:     https://fedoraproject.org/wiki/User:Salimma#README


