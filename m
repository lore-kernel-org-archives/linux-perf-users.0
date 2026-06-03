Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666132FD1DA;
	Wed,  3 Jun 2026 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494225; cv=none; b=tcf9OAKA3FIgUuQUP5wTrKz4OVCZghf7T1B5wB1fGkhqgNB0l8C6HquETCBQ30Trm9MGsAs1jDFBS6g9CabNzUrFit0erFOwLWEHn635aeMAg7q6rUnl97yWR6pXuHFaINegp8M1JI/GUBbXCy1PCAkXOut0WfMIXrp5dFuGtYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494225; c=relaxed/simple;
	bh=XS3AUT8gLJh/VCtqlwIdaljPjNYM4Ji4B9GWl1mdiYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsnsMuhfqpmfoQNbjEXr8XKrmhcxoPpfFT8e0saP3SbS6cQfMEvIEQX2Hj6pQOkLgxC0j77yCkYYFRpfTBFkpZE78YZvD9I66MKrdSUaEdkhYWLyL7cVCNMcyf+Brlc57v9CBMlLKn4up3yE4FEdwGB8pRPeL29uF300TYIMvfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=soxvulSm; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="soxvulSm"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0ED4F32E6;
	Wed,  3 Jun 2026 06:43:37 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EF173F86F;
	Wed,  3 Jun 2026 06:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780494222; bh=XS3AUT8gLJh/VCtqlwIdaljPjNYM4Ji4B9GWl1mdiYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=soxvulSmaI7IldxbFJnpQ0O2B7ZFKecG/cj6e+NCMPC1l9CHaQRwjo0Ww8JD9A2Md
	 qILposO+e1SBiLkjUv14P1U/wLNm8giZZ/rgnkp8yl7uNRXvSyP996OkdAGcSKQPtg
	 cURuBHT/vIt/T+1d9SOPqPvEBEcfV/Yqr7I1tMUI=
Date: Wed, 3 Jun 2026 14:43:39 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paschalis Mpeis <Paschalis.Mpeis@arm.com>,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 05/18] perf test: Add deterministic workload
Message-ID: <20260603134339.GU101133@e132581.arm.com>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-5-85b5ce6f55c6@linaro.org>
 <20260603112742.GT101133@e132581.arm.com>
 <b4836fe9-49cf-44c3-96a9-548e890cee29@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4836fe9-49cf-44c3-96a9-548e890cee29@linaro.org>

On Wed, Jun 03, 2026 at 02:10:37PM +0100, James Clark wrote:
> 
> 
> On 03/06/2026 12:27 pm, Leo Yan wrote:
> > On Tue, Jun 02, 2026 at 03:26:47PM +0100, James Clark wrote:
> > 
> > [...]
> > 
> > > @@ -22,3 +23,4 @@ CFLAGS_brstack.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
> > >   CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
> > >   CFLAGS_traploop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
> > >   CFLAGS_inlineloop.o       = -g -O2
> > > +CFLAGS_deterministic.o    = -g -O0
> > 
> > I have no strong opinion for using 'noinline' in source or using the
> > global option '-fno-inline', just thought this is not easy to follow
> > up if anyone (likely myself) will write a new workload for disabling
> > inline. Could we have consistent style for this?
> > 
> > For the patch itself:
> > 
> > Reviewed-by: Leo Yan <leo.yan@arm.com>
> 
> Actually it's a fair question why some have -fno-inline and others do it in
> the code, it could just be copied from when these were built by their shell
> script tests. From a quick look I would say we can easily drop the
> -fno-inline and do it in the code, and it's better to only noinline what's
> needed rather than everything. But that's probably a change for another
> time.

Seems to me, `-fno-inline` is more reliable.

I.e., in this patch deterministic() has no 'noinline' annotation, my
understanding is the test expects it is not inlined. With `-fno-inline`
flag, we don't need to worry anything is missed.

Thanks,
Leo
