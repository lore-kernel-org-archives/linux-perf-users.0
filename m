Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C1D1A2FC3
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Jun 2024 23:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271796; cv=none; b=idif9lr3iwsBX2QeEUKPCv78dQyqeW9042I4bDtrmLNyGv4LAg8twDOzavshGUnaG2UQxY/NtrVcIt6PHituItF9cNpYdhZhiYIrr+lQRo01NKdy0h74zlbVZG/1Vzx/FkX5LwBd3FatmLKFZvzx/6nHDXs3Mp31qr/aHJb5B8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271796; c=relaxed/simple;
	bh=Zw61pUBa1NFKDQ+LhNLeeTliRVvzZlnUGsjm8zzvV+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUf7krlAyfaC6D5r37bdgc3Tj5nf/dtLZbvGtZ3ddSHAoTnxJKh0nMubreYzDkiUGRUf0SNY+yEfORfAhGxcA+37s87vQuSN5e/jtldTxtMdLkGZqQGA+d6gwIKAho6wiNAlvHMKmOF1G7sYjySM8kTC04Di0hjv8QuUJsrKInA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTx02qnS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTx02qnS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B34C32789;
	Mon, 24 Jun 2024 23:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719271796;
	bh=Zw61pUBa1NFKDQ+LhNLeeTliRVvzZlnUGsjm8zzvV+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nTx02qnS/x7KHnx/ewu2TJr4caQVaLcTspgNT1/18vJftFUH+fckLEGqtaoijWhVS
	 xp602r9IEDUWaeyAej1q98wf3JSrnBtoFPrqW0ITuXdr6DdTMrdtFU2sT1JDlcLYdm
	 LFZ+aCdoXShyX+kSCY2HFQTbXagqB1DcSkSSGAoGJF/1dFByXlRO84C1lyfEgpGfXK
	 +at40j6t5fi3BZiVnywxJYx04Fi3GQsDPPvmOZ7YfxoMuFSuNnygixa+NWAFbyhkhc
	 mGU2kpN6Er+8Xed5xwlNYliaI3n5xGsaj0PlYlVu4SdkHhDpFIRehBRro97KRxJR7R
	 /bkIshyJKr3Xw==
Date: Mon, 24 Jun 2024 16:29:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>,
	linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com
Subject: Re: [PATCH V3 09/10] perf tools: Only treat files as map files when
 they have the extension .map
Message-ID: <ZnoBcgVcEwPFsH5Z@google.com>
References: <20240601125946.1741414-1-ChaitanyaS.Prakash@arm.com>
 <20240601125946.1741414-10-ChaitanyaS.Prakash@arm.com>
 <371abb9c-41a5-4bf0-928f-a60848776bfc@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <371abb9c-41a5-4bf0-928f-a60848776bfc@arm.com>

Hello,

On Mon, Jun 17, 2024 at 02:52:52PM +0100, James Clark wrote:
> 
> 
> On 01/06/2024 13:59, Chaitanya S Prakash wrote:
> > From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> > 
> > Strengthen the check to locate symbol map files in the tool's /tmp
> > directory. As the existing check allows non map files named in
> > "/tmp/perf-" pattern, it leads to possible dwarf library corruption
> > when perf is built with NO_DWARF=1. The try_to_find_probe_trace_events()
> > function behaves differently when built in that manner. Extending the
> > current check condition using the str_has_suffix() function to not only
> > validate the pattern but also ensure the file is of ".map" type allows
> > test perf probe of function from different CU to pass when built with
> > NO_DWARF=1.
> > 
> > Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> > ---
> >  tools/perf/util/symbol.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 9e5940b5bc59..fbcc189edd8d 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1799,7 +1799,8 @@ int dso__load(struct dso *dso, struct map *map)
> >  	const char *map_path = dso__long_name(dso);
> >  
> >  	mutex_lock(dso__lock(dso));
> > -	perfmap = strncmp(dso__name(dso), "/tmp/perf-", 10) == 0;
> > +	perfmap = strncmp(dso__name(dso), "/tmp/perf-", 10) == 0 &&
> > +		  str_has_prefix(dso__name(dso), ".map") != 0;
> 
> Does this work? Shouldn't it be str_has_suffix()?

Yep, I think it should be

  perfmap = str_has_prefix(dso__name(dso), "/tmp/perf-") &&
            str_has_suffix(dso__name(dso), ".map"));

> 
> For reference, there's another fix for the same issue here:
> https://lore.kernel.org/linux-perf-users/20240617130332.13427-1-atrajeev@linux.vnet.ibm.com/T/#m9b1e62f0cdbcd4caf019f2ad97d69b29df568522

Right, it seems this patchset is posted earlier than the above.  But I
prefer Athira's fix as it touches less codes basically and contains more
fixes.

Thanks,
Namhyung


> 
> >  	if (perfmap) {
> >  		if (dso__nsinfo(dso) &&
> >  		    (dso__find_perf_map(newmapname, sizeof(newmapname),
