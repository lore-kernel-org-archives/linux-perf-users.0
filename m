Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D0C241139;
	Mon, 16 Mar 2026 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654679; cv=none; b=j8YFIaSVq+HrwjGaDcnXIuJbNT2ip3Raq2Oc9q1ZTOd/3FXpRNqNEcduI2mgnEpV/E/etXfL9W7qO5/vKmKhYoEQkDl+4NfBGCLOPGgx8sQxD0kTlCuiQ3ojur83fYnQVw3w61MmF94EP1mYxG3pUKjvH26U6Xzh9RQ0q3EQHCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654679; c=relaxed/simple;
	bh=NLHd8iQrmBKRbUFuO0oeDQyU3Kz2qGWb556moxpXuJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhMMHkQ7+n3WmwAZQITxkXRShFcmJmW6xPBOiSdUFMiF3T2L+NZVI3Er8okMxMUUH/AFH6Saa8wqrkMOyXnhcDuON8es8RGnz/6ffZU7wZk32TKsQaB+hSqUiCxrwbcl/gT4VSrvfO6bipI6Kdbfl8z/ZKUOadyLGAqUuoAeP7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56F521477;
	Mon, 16 Mar 2026 02:51:11 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C15B33F778;
	Mon, 16 Mar 2026 02:51:15 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:51:10 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Oliver Upton <oupton@kernel.org>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: REQUEST: Syncing tools/arch/arm64/include/asm/cputype.h with the
 kernel sources
Message-ID: <abfSjoaZYrSqmIdA@J2N7QTR9R3>
References: <aba3Z0aelph_gQ6c@x1>
 <20260316094344.GA8048@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316094344.GA8048@e132581.arm.com>

On Mon, Mar 16, 2026 at 09:43:44AM +0000, Leo Yan wrote:
> Hi Arnaldo,
> 
> [ + Mark ]
> 
> On Sun, Mar 15, 2026 at 10:43:03AM -0300, Arnaldo Carvalho de Melo wrote:
> > Hi,
> > 
> > 	Can someone please address this perf build warning:
> > 
> >   make: Entering directory '/home/acme/git/perf-tools/tools/perf'
> >   BUILD:   Doing 'make -j32' parallel build
> > Warning: Kernel ABI header differences:
> >   diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
> > 
> > I tried updating that header and got the problems below.
> > 
> > I just merged perf-tools with upstream, will push to tmp.perf-tools at:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tmp.perf-tools
> > 
> > Thanks in advance,
> 
> Sorry that this issue has come up again.
> 
> A quick summary:
> 
> The plan was to extract the CPU ID definitions from cputype.h so that
> kernel and userspace can share the same definitions.  This would avoid
> keep syncing cputype.h between the kernel and userspace [1].
> 
> James worked on this a bit, and later Mark wanted to try a different
> implementation.  However, we haven't posted formal patches yet.
> 
> To avoid extra burden on perf maintainers, I suggest removing the
> cputype.h check in check-headers.sh.  In the short term, Arm developers
> will take responsibility for keeping it up to date.  In the long term,
> once the CPU ID refactoring is completed, we can do a proper cleanup of
> cputype.h.
> 
> James, Mark, is this reasonable?
> 
> [1] https://lore.kernel.org/linux-perf-users/aFJ8bQh_30JMzF_-@J2N7QTR9R3/

Removing the check sounds good to me; that's one of the options I
suggested in [1]:

| The simple solution for now is to *NOT* update the userspace header,
| and to stop warning that this has diverged from the kernel header. 

I think it's fine if we need to manually update that header when
teaching the perf tool about specific CPUs.

Are you happy to spin a patch to remove the check?

Mark.
