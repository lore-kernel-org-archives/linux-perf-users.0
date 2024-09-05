Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A6C19E7F6
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548341; cv=none; b=SzMGzDrN7Z230kN+P8o8h4ParJAu98hDOYOFGwC8lanYJu0cSTajpnoaMdGNFDS6ZWiJeahUPkbpkcrO1ALiGPnF0xFwlLZ7C0JQChczbqB1kc/Gtnyo5dhoyMY1Mq4FVTemqP7dDy77lWhLzmSzhpk+FZTK0tLrAcSO/cc+oPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548341; c=relaxed/simple;
	bh=OwKQ8gefJtlo9/FKC0YJ4+xfuKBWJQAA4VRzKkk7VJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIwwyyhQuoVeJy0uW1mKkLOos78HuS2J25kt/BhbwoR9rG+eYQqCFX0WqmV4Nb0LaQ5ASF7RaWfIdVtUBe5hsP6As44SUNkY0JagWsg+FxRc4esraDf9eFe7gpEdNo7rZA50y13T1vIkQ8oGthvWXtDfah0AW8NfsJW5JTN/Rgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5V7UZF0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5V7UZF0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D57C4CEC3;
	Thu,  5 Sep 2024 14:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725548340;
	bh=OwKQ8gefJtlo9/FKC0YJ4+xfuKBWJQAA4VRzKkk7VJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5V7UZF03z126KaIyBArIZDQHba5Svw1e0umNZc6CoqKQTQNtOnv+lRgjWpwluRa3
	 7f0A5SIJFIxcJlYT0ZU1Hioxw5tM+zNNZ/vzzC36bN2oFKWmqnzUnsh+np+kR5iqxx
	 XyTLV3P2cieMOEnpEFA+ATC2Baylo2u2Cj8RwcEIen6hbmeewWOmQvE1AQOW6vw1RE
	 LcudqCN90xdnvofBmz2pG4Ks0Zx0owZP3qxRvW8T98pqOLoZMfIki5bqDdL8Ez9m2U
	 Ye5spmadAjApq8ZUqbOj71MDDnxVLVPmgHPgZnfX3cbdkFuLtgUXxTZtCsvITEjf4C
	 pH3BFbcTVKBrQ==
Date: Thu, 5 Sep 2024 11:58:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v15 7/7] perf: Add more features to supported_features
 list
Message-ID: <ZtnHMKBHYr5hrRyM@x1>
References: <20240904190132.415212-1-adityag@linux.ibm.com>
 <20240904190132.415212-8-adityag@linux.ibm.com>
 <Zti81yV0jRIB7oQ6@x1>
 <b8d14ee1-c97e-4cac-8668-9476ab2b61d7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8d14ee1-c97e-4cac-8668-9476ab2b61d7@linux.ibm.com>

On Thu, Sep 05, 2024 at 08:03:08PM +0530, Aditya Gupta wrote:
> On 05/09/24 01:32, Arnaldo Carvalho de Melo wrote:
> 
> > On Thu, Sep 05, 2024 at 12:31:32AM +0530, Aditya Gupta wrote:
> > > As suggested in [1], add more feature names and corresponding names,
> > > based on the information in Makefile.config
> > > 
> > > The entries were added after seeing the corresponding -D option which is
> > > added to CFLAGS, based on the presence of a feature in Makefile.config,
> > > such as:
> > > 
> > >      ifeq ($(feature-file-handle), 1)
> > >        CFLAGS += -DHAVE_FILE_HANDLE
> > >      endif
> > > 
> > > For above feature 'file-handle', corresponding entry has been added to
> > > supported_features as below:
> > > 
> > >      FEATURE_STATUS("file-handle", HAVE_FILE_HANDLE)
> > > 
> > > [1]: https://lore.kernel.org/linux-perf-users/Zn7EvDbsnlbLXj4g@x1/
> > I'll remove this now because there were some that sounds really strange,
> > like:
> Okay.
> > acme@x1:~/git/perf-tools-next$ sudo su -
> > [sudo] password for acme:
> > root@x1:~# perf -vv
> > perf version 6.11.rc3.g15dc9f274b8e
> >                   glibc: [ OFF ]  # LIBC_SUPPORT
> > libslang-include-subdir: [ OFF ]  # HAVE_SLANG_INCLUDE_SUBDIR
> > 
> > 
> > The first one is the strange one, how come, no LIBC_SUPPORT? glibc?
> Debugged it:
> 
> 
> Output of `make` says glibc is there:
> 
> 
>     Auto-detecting system features:
> 
>     ...                                   ...
> 
>     ...                                   glibc: [ on  ]
> 
>     ...                                   ...
> 
>     ...                                  libelf: [ on  ]
> 
> 
> But, in Makefile.config, 'LIBC_SUPPORT' is only defined if libelf is NOT
> there:
> 
> 
>     ifeq ($(feature-libelf), 0)
>         ifeq ($(feature-glibc), 1)
>             LIBC_SUPPORT := 1
>         endif
>      ifeq ($(BIONIC),1)
>           LIBC_SUPPORT := 1
>       endif
> 
> 
> Hence since LIBC_SUPPORT is not defined, the check --feature command says
> glibc is OFF.
> 
> I think we can simply remove libc entry from the features array in this
> patch, as glibc is kind of obvious to be there if compilation worked.

Right, but please put some thought, if you have the time and
inclination, to try to make this LIBC_SUPPORT thing make sense, as it is
it is nuts :-)
 
> Meanwhile I will check all feature entries added in this patch again. I can
> post this patch as an independent patch.

Sure
 
> > The second looks irrelevant, I'll see.
> 
> Sure.

Thanks!

- Arnaldo
