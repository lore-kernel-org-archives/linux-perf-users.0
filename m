Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EE3383
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Nov 2024 06:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786896; cv=none; b=YUZVPFXNjVb6UNdCawb2dRHPbxsIM+vyOcddmW267RDhgBj6fJl/HJE5q5+XxYmOehVxj6prUOyW8BimpA4eG4yWCR2SoHExqg23B8J1DR0unszduMrh+nV6itPyVCBUNFtBPZAjzDRpQrnBTE1LR/gpYYOZVyWDHP/FhPrVyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786896; c=relaxed/simple;
	bh=oArN6ZU24DqOFDhHdvQ1R8DCbNQDAGbXJaXisbblSgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM4bT21mha1PEXkOti2ZPr7RZpFm8rv2rgKWI9egjsLYxC/PSPJbBxDFLsjBxiKa0jKSfgxSsS4RS8Eq31wAFnOZgbg59xSe+wg6szaKmglJa6xHX42kRf7ijsowY1duIaqWQwUsZjHruFheJf/CD80N8utpPJsNmxo2HCzeRKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9FH3/1r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9FH3/1r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB497C4CECF;
	Tue,  5 Nov 2024 06:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730786894;
	bh=oArN6ZU24DqOFDhHdvQ1R8DCbNQDAGbXJaXisbblSgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9FH3/1r3YViZC8eqy/Og0melq/IP6sHL+n6OCpsnnHB7kanq/ipFEaxTct9UNcjP
	 ztxMFG+50T0WcozaLsZzWK6g714el5/EaqQgsM62bNtpcEQYjWP0c+JuyZvDBbd3GJ
	 0r2+e9IcgwHElJ5W9ywI6sV2O44Yn/1LOzMLfsfpVaAvIzfVSnOLNz8OqfWre9QNu0
	 1v+qyCUbuwupoTx/Bof8UwoM4Ss23UA5usEAJ/QuFZrwXhHH6naJjRy3UuQVqwXU31
	 b2GozJ5o+xbOTXFt81VBJ71sssii8cTAz5TC54NY1PePURpPjXUdExDjU8WFaoKj3S
	 sIgqjTYfOZIuA==
Date: Mon, 4 Nov 2024 22:08:11 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: yangyicong@hisilicon.com, acme@kernel.org, peterz@infradead.org,
	mingo@redhat.com, linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, linuxarm@huawei.com,
	Guilherme Amadio <amadio@gentoo.org>, Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH] perf build: Add missing cflags when building with custom
 libtraceevent
Message-ID: <Zym2S-7rdqlfMaUK@google.com>
References: <20241024133236.31016-1-yangyicong@huawei.com>
 <ZyF5_Hf1iL01kldE@google.com>
 <a8143fa2-d7e2-48d7-5c9b-2c00e2adbe9c@huawei.com>
 <20241030110458.GD24446@e132581.arm.com>
 <ZyXFX-8SnakeuZrl@google.com>
 <20241104104741.GA14610@e132581.arm.com>
 <ZyjDatxYxoIg0R5J@gentoo.org>
 <260274f8-3188-cc77-4783-ee04d98eeb44@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <260274f8-3188-cc77-4783-ee04d98eeb44@huawei.com>

On Tue, Nov 05, 2024 at 10:06:34AM +0800, Yicong Yang wrote:
> On 2024/11/4 20:51, Guilherme Amadio wrote:
> > Hi Namhyung,
> > 
> > On Mon, Nov 04, 2024 at 10:47:41AM +0000, Leo Yan wrote:
> >> On Fri, Nov 01, 2024 at 11:23:27PM -0700, Namhyung Kim wrote:
> >>
> >> [...]
> >>
> >>>>> Checked how we handle with libtracefs currently:
> >>>>>  ifeq ($(feature-libtracefs), 1)
> >>>>>     CFLAGS +=  $(shell $(PKG_CONFIG) --cflags libtracefs) # we've added the cflags from pkg-config
> >>>>>     LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtracefs)
> >>>>
> >>>> The libtracefs.pc file claims requesting libtraceevent, as a result, it
> >>>> returns the header paths for both libtraceevent and libtracefs:
> >>>>
> >>>>   $ pkg-config --cflags libtracefs
> >>>>   -I/usr/local/include/tracefs -I/usr/local/include/traceevent
> >>>>
> >>>> I checked the packages libtraceevent-dev and libtracefs-dev and either
> >>>> can be installed independently. Therefore, it seems to me that this
> >>>> patch is correct for finding the traceevent header path, with no
> >>>> dependency on tracefs.
> >>>
> >>> I'm ok with the patch itself.  Can I get your Acked-by, Leo?
> >>
> >> Yes.
> >>
> >> Reviewed-by: Leo Yan <leo.yan@arm.com>
> > 
> > I agree that this was a mistake I made in my patch. I added the cflags
> > to the feature check in tools/build/Makefile.feature, but in Makefile.config
> > I added it only for libtracefs and missed it for libtraceevent. The fixes tag
> > is correct. This patch fixes my mistake.
> > 
> > Reviewed-by: Guilherme Amadio <amadio@gentoo.org>
> > 
> 
> Thanks for the review by Leo and Guilherme!
> 
> Hi Namhyung,
> 
> As you noticed we should use the include path from pkg-config [1]. Would you like
> to post a patch yourself or want me to post this as well? It's correct and we also
> need this. (I didn't found this may because I changed my custom libtraceevent.pc when
> debugging and currently approach is ok if libtraceevent's installed system wide).

Please do that as a follow-up.

Thanks,
Namhyung
