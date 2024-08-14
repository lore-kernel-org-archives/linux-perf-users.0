Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98FB1B5830
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2024 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650893; cv=none; b=fW0qo7IZmO5XyoeZHgeicRXm8IrL8swjrLkYn8PcBHyx+ACHW2TwQYGuj0/0oB12dGcPlu5Xu79aBRJcLbdQHWO4KQxiaHri+/ywA9IpKaPxd7S94OBOUQU/6rjrY3lDe8jK/YmPClOx4D0udoDQx2JW0MO4rC83ZPr4aEONkn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650893; c=relaxed/simple;
	bh=QtuFYGBBIkA8y2dCZ9Sx8MiDhuvYk1MDMxcMuOx+oCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G07KJhLycp413P0hP5mdjhNr+jwIgJaE3sEx0oKiEBox6Vm8bsy1/JKn3lLFzprEt7CxV/RbGX24VSrQieQceKB3tY4NdbITQh4V6mkgA0OXC3pSDqni1blQshIA7zdx7C1PRCHBGzH2dvRNg3H8FehdWd2JeOAaRK7pmgLX8bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlQ7ne2U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlQ7ne2U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184DAC4AF0A;
	Wed, 14 Aug 2024 15:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723650893;
	bh=QtuFYGBBIkA8y2dCZ9Sx8MiDhuvYk1MDMxcMuOx+oCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mlQ7ne2UOme6i2rUU+2Dk9w3aNiYglfv6EZYINO6lxNvl5WStTPsIujPoe/NbbAlu
	 xnt/5nyHkDrZIT1hV3ya+aIJIqd93PbTtiBdlSY3nrVpjwpcDWZb3omePhdzKeEsMC
	 2dLyiaqPVibUhGuMbn/c64rjYtfhFnZZlquDeh+gTutrWqL1LmC5KHsoq6JRPPv99t
	 Qda6+k4ovHQDpEE1u3OyuFig3SyrIOwi4II88uBTisvSEYYo7mqXrwuufkIajWi43L
	 mVxHYd70JvWKsQvehmf2fu2xK1S/Llm1SaZba4C/iufQEe1lcVl++KApaIt1VFUXWD
	 r/ec5GwWUk+Rw==
Date: Wed, 14 Aug 2024 12:54:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com,
	adrian.hunter@intel.com, atrajeev@linux.vnet.ibm.com,
	irogers@google.com, jolsa@kernel.org, kjain@linux.ibm.com,
	mpetlan@redhat.com, rstoyano@redhat.com
Subject: Re: [PATCH v3] perf test record.sh: Raise limit of open file
 descriptors
Message-ID: <ZrzTS46l3Ct_I0Oj@x1>
References: <20240814151734.15409-1-vmolnaro@redhat.com>
 <ZrzOFDmwl9Z8F8NP@x1>
 <ZrzO2T1s_tIpqizG@x1>
 <d847f760-896e-4bdf-9f8c-933f52a5aed8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d847f760-896e-4bdf-9f8c-933f52a5aed8@redhat.com>

On Wed, Aug 14, 2024 at 05:42:01PM +0200, Veronika Molnarova wrote:
> 
> 
> On 8/14/24 17:35, Arnaldo Carvalho de Melo wrote:
> > On Wed, Aug 14, 2024 at 12:32:39PM -0300, Arnaldo Carvalho de Melo wrote:
> >> On Wed, Aug 14, 2024 at 05:17:34PM +0200, vmolnaro@redhat.com wrote:
> >>> From: Veronika Molnarova <vmolnaro@redhat.com>
> >>
> >> Ok? I'm applying it with this change. Thanks,
> > 
> > So I added this to the log message:
> > 
> > Committer notes:
> > 
> > Instead of disabling ShellCheck warnings all the uses of 'uname -n',
> > i.e. those:
> > 
> >   In tests/shell/record.sh line 35:
> >   default_fd_limit=$(ulimit -Sn)
> >                             ^-^ SC3045 (warning): In POSIX sh, ulimit -S is undefined.
> > 
> > We can just switch from using '/bin/sh' to '/bin/bash' for this test, as
> > bash _has_ 'ulimit -n', so ShellCheck will not emit that warning.
> > 
> > There are dozens of 'perf test' shell tests that do just that,
> > '/bin/bash' is a reasonable expectation for those tests.
> > 
> > ----------------------------------------------------------
> > 
> > Please let me know if you find any issues with this course of action,
> > 
> > Thanks,
> > 
> > - Arnaldo
> > 
> If so then the check whether the ulimit is supported doesn't need to be done
> as bash is given as a requirement. Thought that it should be supporting all
> possible shells, even though couldn't find shell not supporting 'ulimit -Sn'.
> 
> Can I send a quick fix that just changes to the '/bin/bash' so that the code
> won't have unnecessary code?

See my last message, I went with your v2 + switch from /bin/sh to
/bin/bash, as you suggest above.

- Arnaldo
