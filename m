Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF151BFDFE;
	Tue,  1 Oct 2024 23:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727827141; cv=none; b=tQYdr1q9PflcJJg55R8am4jOhUFV/TE1wPnIT/07vR9EtVXihTeNdxPQ05CTP+2DbRYwSY+jiTxaVSYThT7Hd1UHt2xT/eLJi4622PmibLSMKHDsXECmOMJXeM1LibkwAFDfhk8ZulwJhD/yljx8jKBN4bQJsQ0GDO9Qt1KB8mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727827141; c=relaxed/simple;
	bh=VzEbZVagWQal/mZU9TpTiSBwVAhimMl8r2t0YidJUA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uiq4yTGxQnPyEo4rFGej+jmgxP5w4XvicK3XPdKL24PAudZD3fcbhv+1m1nHxnXGpK2IF13A2fdZ5x4OPA/60WVfdsU+PpeBLjw2gFn0jTJzfnD3+dc6ETq5RzBQLy/3JfU0eCsbNmojMELuyjqKwid/0rVDt9pAJmlD8+am/h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBs4nShn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBs4nShn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A121EC4CEC6;
	Tue,  1 Oct 2024 23:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727827141;
	bh=VzEbZVagWQal/mZU9TpTiSBwVAhimMl8r2t0YidJUA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uBs4nShnKB6H1yAjwQfeHxTKgP/mwDwGrQU3vpXNMU300Mrr9mZXra9AIeTkLkA79
	 KlOu4BBhT+llHPXlYEAchdE907//EvRYV9LSfWT25kySAljDAgZwuViozgjZkHRGKz
	 W8s/1u5vogqRPQNKtEwmO317BDtHw4wTz5/eb5yxRazRMzBkHyWkacxpN64a1x+dFK
	 iyjn8G/9MQGILpj5i2ewum/U/oW4dVhfF6a7kHgVVS56qubZkFTnrakkqPoQoe4Czh
	 Kt19VZk0mUQEvR9+kDMHsX6RmAswGt9v+VnZHxJeYDt9c97FA5Coj1V1iBhko7wMHH
	 NuMxjhbmk7vUg==
Date: Tue, 1 Oct 2024 16:58:59 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Hemant Kumar <hemant@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yang Jihong <yangjihong@bytedance.com>, leo.yan@arm.com
Subject: Re: [PATCH v1 0/3] 2 memory fixes and a build fix
Message-ID: <ZvyMw2xwnyEnMaSa@google.com>
References: <20240924003720.617258-1-irogers@google.com>
 <ZvMEGn5RIWMZNvFc@google.com>
 <CAP-5=fUP07h=RFQ7n0pwzeK4-DgD2st3tfYxT0_e-y9GOst4fA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUP07h=RFQ7n0pwzeK4-DgD2st3tfYxT0_e-y9GOst4fA@mail.gmail.com>

On Mon, Sep 30, 2024 at 10:11:34PM -0700, Ian Rogers wrote:
> On Tue, Sep 24, 2024 at 11:25 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Sep 23, 2024 at 05:37:17PM -0700, Ian Rogers wrote:
> > > I was looking into some lsan regressions and a latent issue with
> > > libdw, creating these fixes.
> > >
> > > A thought, we should probably simplify the libdw logic but rather than
> > > do it here I'll do it as a separate series on top of these. The issues
> > > I see are:
> > >
> > > 1) dwfl_thread_getframes is used to test for the presence of
> > >    libdw-dwarf-unwind. The blame date on this function is
> > >    2013-05-30. As the function is 10 years old I think having libdw
> > >    implies having dwfl_thread_getframes and so we can just merge the
> > >    two pieces of logic instead of having different feature tests and
> > >    ifdefs.
> > >
> > > 2) similarly, dwarf_getlocations has a blame date of 2013-08-23 so
> > >    let's just make libdw tests test for this and make having libdw
> > >    imply dwarf_getlocations support.
> > >
> > > 3) similarly, dwarf_getcfi has a blame date of 2009-06-24 so let's
> > >    just make libdw tests test for this and make having libdw imply
> > >    dwarf_getcfi support.
> > >
> > > 4) in Makefie.config feature-dwarf is a synonym for libdw support. I
> > >    think using the name libdw is more intention revealing as dwarf can
> > >    mean multiple things. Let's change HAVE_DWARF_SUPPORT to
> > >    HAVE_LIBDW_SUPPORT and all similar dwarf vs libdw names.
> > >
> > > 5) We have "#if _ELFUTILS_PREREQ(0, 142)" testing for elfutils version
> > >    0.142. Elfutils 0.142 was released around 2009-06-13 (via git blame
> > >    on the NEWS file). Let's remove the #if and ensure elfutils feature
> > >    tests for at least 0.142. If someone were using an incredibly old
> > >    version then they'd lose some elfutils support, but given the 15
> > >    year old age of the library I find it unlikely anyone is doing
> > >    this. They can also just move to a newer version.
> >
> > Looking at the map file in libdw, the latest addition was 0.158 for
> > dwfl_thread_getframes().  Probably we can add the version check to the
> > feature test to make sure if it has all the required APIs.
> >
> > https://sourceware.org/git/?p=elfutils.git;a=blob;f=libdw/libdw.map;h=552588a94c0c1a1f2fd5b973553c784026e6de14;hb=HEAD#l274
> >
> > >
> > > From the mailing list I notice also overlap with the last patch and
> > > this series:
> > > https://lore.kernel.org/lkml/20240919013513.118527-1-yangjihong@bytedance.com/
> > > Simplifying the libdw support will address some of those issues too.
> >
> > Yeah I noticed that too and feel like it should go to perf-tools tree.
> > Probably it doesn't clash with this so I think it's ok to have this in
> > perf-tools-next.
> 
> I think the comments wrt libdw are covered in the series cleaning up libdw:
> https://lore.kernel.org/lkml/20240924160418.1391100-1-irogers@google.com/
> so these fixes should be good to land?

Sure, I'll just adjust the errno.h part as it's picked up by Arnaldo
to the perf-tools already.  I'll merge the branch later.

Thanks,
Namhyung
