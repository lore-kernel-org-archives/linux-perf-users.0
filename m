Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FB81DF759;
	Fri, 31 Oct 2025 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938963; cv=none; b=i02RnBnUQ+ZUIcpv4MxsfdrFMY5ryZin28Q+eUmltkq31/QtlWvDqazKbS2fK4wT/TaYayE766aoprMBVrf9P29tbe97MTXxLE4P/1yryfmvTvMQFmCMDAPpJk+pQJmsSqcPLY/j8bd0rljnesC/XXVpojP/9+jPIJ2WF10h91A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938963; c=relaxed/simple;
	bh=oQVmhMMFW6lHuhAykiZpLS1gzGK8GSGR2gOkw6MBoVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBE1df3ouwjUfsg4MH+KuoVyYWakSlZkhPWyWES5PA4bxp/KflRwrHCnwdskkPYCjcFf4tATL1WISCcUzumx46FfcXxQ06DXa47CpNmRWKo0bq2sX4DiOYlz3JfXk8S5q015NwOZh4d1IMSBJTllGbjyx6j2381LkHvfLUzzShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFwnXuOm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFwnXuOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9242C4CEE7;
	Fri, 31 Oct 2025 19:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761938963;
	bh=oQVmhMMFW6lHuhAykiZpLS1gzGK8GSGR2gOkw6MBoVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dFwnXuOmnICJHIAqYXOFJZL3M7NhrFAuz11xIhh6kOKj8LS6mg5LZsT+5OHZV4AYj
	 ms5mMNoYM9N6Uf+1Hvs51fXmQ8ilD6zIrdW5/D6PNkoQTVxzNZXZP9mSQUyFdeH8Ch
	 HuStTcK4waCNN6OZ0pvDNxrxCFgr9gNIDL7N9oaGqOefG6Hnt6yloMfjj7lkOyPBQM
	 4MWyhuT+RBZIpO+oBsTwS8y132B3Wn42IrQ7Uxw5VQiP6XFOJmHvoAQfpoS0zTmFCM
	 Dzd4syp2gh/F53RzPTkntwCXsfQtR+TVKJhXFcNQ3sBX3mhxFsK17m+XUhrLt8PTSV
	 V5bXok6YMAslw==
Date: Fri, 31 Oct 2025 12:29:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Howard Chu <howardchu95@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf trace: Increase syscall handler map size to 1024
Message-ID: <aQUOEU5Srvxvw_ye@google.com>
References: <20250519232539.831842-1-namhyung@kernel.org>
 <CAH0uvohxb4gvHYswCZMvCrrOn=0qSOeOaYyDVPEFb4GPhwntgw@mail.gmail.com>
 <CAP-5=fWZectSpLzkfJUj-W-_oxhDJdnnOE18ET_iPb+bjmTdHw@mail.gmail.com>
 <aCz-wD2Syq8mj2_0@google.com>
 <CAP-5=fVNgN5Budwaao_GqrZRN2wSrvo7CQySU-D9eEpnwBhY2A@mail.gmail.com>
 <CAP-5=fXyxrM4eEjo1AMjBTuC2duqxZLcOPpdqudYQeWQfUiVuQ@mail.gmail.com>
 <CAP-5=fVBXUeEH2oi6NU2Hs5GCBUqW7BMVUJ6=LDTBfmb=xoL3Q@mail.gmail.com>
 <aQUJHMtTQ5IVBQ2x@google.com>
 <CAP-5=fWumaLVt4DbSXXHmJ-9Y-hTyj9K61s2E8m_xZY+ux5nLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWumaLVt4DbSXXHmJ-9Y-hTyj9K61s2E8m_xZY+ux5nLg@mail.gmail.com>

On Fri, Oct 31, 2025 at 12:25:41PM -0700, Ian Rogers wrote:
> On Fri, Oct 31, 2025 at 12:08 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Oct 30, 2025 at 01:47:55PM -0700, Ian Rogers wrote:
> > > On Mon, Oct 13, 2025 at 1:22 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > On Thu, Aug 21, 2025 at 9:45 AM Ian Rogers <irogers@google.com> wrote:
> > > > >
> > > > > On Tue, May 20, 2025 at 3:14 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > >
> > > > > > Hi Ian,
> > > > > >
> > > > > > On Tue, May 20, 2025 at 08:05:37AM -0700, Ian Rogers wrote:
> > > > > > > On Mon, May 19, 2025 at 4:36 PM Howard Chu <howardchu95@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hello Namhyung,
> > > > > > > >
> > > > > > > > On Mon, May 19, 2025 at 4:25 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > The syscalls_sys_{enter,exit} map in augmented_raw_syscalls.bpf.c has
> > > > > > > > > max entries of 512.  Usually syscall numbers are smaller than this but
> > > > > > > > > x86 has x32 ABI where syscalls start from 512.
> > > > > > > > >
> > > > > > > > > That makes trace__init_syscalls_bpf_prog_array_maps() fail in the middle
> > > > > > > > > of the loop when it accesses those keys.  As the loop iteration is not
> > > > > > > > > ordered by syscall numbers anymore, the failure can affect non-x32
> > > > > > > > > syscalls.
> > > > > > > > >
> > > > > > > > > Let's increase the map size to 1024 so that it can handle those ABIs
> > > > > > > > > too.  While most systems won't need this, increasing the size will be
> > > > > > > > > safer for potential future changes.
> > > > > > >
> > > > > > > Do we need to worry about MIPS where syscalls can be offset by 1000s?
> > > > > > > https://lore.kernel.org/lkml/8ed7dfb2-1e4d-4aa4-a04b-0397a89365d1@app.fastmail.com/
> > > > > >
> > > > > > Argh..
> > > > > >
> > > > > > > We could do with a map that combines BPF_MAP_TYPE_HASH with the tails
> > > > > > > calls of BPF_MAP_TYPE_PROG_ARRAY.
> > > > > >
> > > > > > Right, it'd complicate things but I think it's doable.
> > > > >
> > > > > Should we merge the x32 fix while waiting for the hash fix?
> > > >
> > > > Just a reminder that this is still not resolved.
> >
> > What do you mean by the x32 fix?
> 
> This patch is the x32 fix. Your commit message says:
> "Usually syscall numbers are smaller than this but x86 has x32 ABI
> where syscalls start from 512."

Oh, you meant this patch. :)

> 
> We started discussing a hash table based fix because of MIPS, etc.

Right, I'll merge this as an interim solution.

Thanks,
Namhyung

