Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2E4440A3E
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790373161; cv=none; b=pndkjDbvzGMUnyzHwmex1SDznYWYzJ8D6MWd4ji8isKpqcESVuM/+Abc6C+MAmbdAS5KxCp/oqxbf/9aSzDVpK7/JG8QkFocer9sRXOwcvpHUM5g6RwPWW67vz7PJZUmn1pp6vBMLYahGfj8/8vsmjZRDQh806noCTQM37mZJrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790373161; c=relaxed/simple;
	bh=00F0yg0Teu3X28mXRYSm2uaqofhkFeODDxzCbuXoGQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uniZN/xlCy/Z2b9cQ6bPcNCUBUAnKFNfMbOepj7ZWHYFcozVR4/pIXfNeGfOHpE/baOTsYlJ7JSQ4GCyoWl9nAGh698LUsVxNWagO3/H6KRl/tAq57QSG9gjwe1Cs9LOxKIE+tOBeNvczfvXBrO1gHKGXd7g/xstBMkqfOHkC5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZmSMWj8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZmSMWj8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647841F000FF;
	Fri, 25 Sep 2026 21:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790373159;
	bh=ZGlvwiziv8X895QE4TXFSWzrG5aZLyAT8wL2tHF39Bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lZmSMWj8xp0B5DUPyrPiWX/XPDL6rjlYAXLG2wOAjuTAUUIIVrByQWmqvzYXzQR0p
	 sNFIcd3EFaKIJINEITbIW6rXVFYhps7edfWM78RROKVU9c0F8Ez8L5TFrV7Qv7GZId
	 RWXg6CgLw6wBkfjUzpYLgrzb0bRVYJMRaXRSnvgKkZf8HL3lGRSklZHAPWXgjGHCS8
	 5XaweqnOZmL/tX7PsUFd9SfzZoeL4qF1f1UnyLsOXFq7ik/ijbXxjmvB/5gXTuz0fF
	 Mkpw4At65aqIVRPP86/fTVqdT2brP41bvCc/V7VQ+gtlueUsNCc47A8dHzvvGeBcTr
	 5kNfPrR2uhfwA==
Date: Fri, 25 Sep 2026 23:52:37 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf: Fix Python 3.6 build breakage in jevents.py
 and util/setup.py
Message-ID: <arbtJUe-jizeRugc@x2>
References: <arbd4TJm4s9MVjN-@x2>
 <CAP-5=fVXxUEYSfWb=AExGQoZ7w7FqGhD8Ga1+hjwF3gTZfsbpA@mail.gmail.com>
 <arbkQymeBZ0ja6sc@x2>
 <CAP-5=fW3yv2u4MS1TrbLe4iBL_MyfJx3m4KvP5visKsmT_qwvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW3yv2u4MS1TrbLe4iBL_MyfJx3m4KvP5visKsmT_qwvg@mail.gmail.com>

On Fri, Sep 25, 2026 at 02:29:12PM -0700, Ian Rogers wrote:
> On Fri, Sep 25, 2026 at 2:14 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Fri, Sep 25, 2026 at 01:57:06PM -0700, Ian Rogers wrote:
> > > On Fri, Sep 25, 2026 at 1:47 PM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > perf's build still accepts Python 3.6: Makefile.config only rejects
> > > > interpreters older than 3.6 and jevents.py keeps its own removesuffix()
> > > > shim for it, but two recently added constructs are evaluated when the
> > > > module or the function is defined and only work on newer interpreters.
> > >
> > > Could we remove the shim and bump the minimum Python version to 3.9 to
> > > be in line with the rest of the kernel build?
> > > https://github.com/torvalds/linux/blob/master/Documentation/process/changes.rst
> >
> > Since RHEL8 based systems will still be in use for a long time and new
> > perf versions can be useful in solving problems in such systems, maybe
> > we should keep the support on 3.6 as is now :-\
> >
> > This patch is not that big and fixes the only cases where python 3.6 was
> > breaking, so maybe this is not unreasonable to do.
> 
> Could we update the review prompts for this then? Currently the
> prompts load from changes.rst:
> https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/build.md
> and so Python 3.9. We can then comment that we're doing this for RHEL8 support.

I didn't know about python 3.9 being the minimal version for kernel
python usage.
 
> RHEL8 appears to be in maintenance mode:
> https://endoflife.date/rhel
> which means "New functionality and new hardware enablement are not
> planned for availability in the Maintenance Support Phase."
> https://access.redhat.com/support/policy/updates/errata#Maintenance_Support_Phase
> So is RHEL8 support only necessary for people building the code
> themselves? In that case, they could also update their Python?

Fair enough, I'm reworking the patch to instead make 3.9 be the minimal
for perf as well.

- Arnaldo
