Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFEA1B8E94
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2024 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653558; cv=none; b=tLernfp7MQ8ECZet9wwjR4AFpwKVZ8smgIFQgL+AbFupos/6tKd8uJUXXeKWjnPHgTp4Xd+2qDlJd1yWt/8JzPe+2ZT6acgq2x2ha8QgXttp/w6pqsXeMtG4xbyod1BHK04MIuGvI6XPR0hSm/7GMLA9mLWgC0PNseSsYtUdPxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653558; c=relaxed/simple;
	bh=pNeJw06P0QVUZ1Aa5sq3s/a77ejvj/klxkaDa0/vIiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdSo9BfTy/iAOs95/+RlUy4JOo4RhYS5Mcx0gaM7vFRQGeRIc4ITpZG5ANvep1RSJLZgwl9LJ1/XOSQt2uDmkAonctvPeZV5IZfKv5S8Uz7SUv6ndngGinyC6ozJ6A6nwQc4Kz56oA0sO6Dr6BTAyLBXdDGG1pxfpIMY8xyC85Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnRep9vD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnRep9vD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C9EC116B1;
	Wed, 14 Aug 2024 16:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723653557;
	bh=pNeJw06P0QVUZ1Aa5sq3s/a77ejvj/klxkaDa0/vIiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pnRep9vDQyWVYUA22B2zexNHv4t0brI2GDa4oBsCRLtqtBz1WOsTQ6Oc8kg/dZNs9
	 qTsk4/x9LWOtHDqFQMdeDfQZq2S743cwqPxZU/pIreEThWtqbVdLk9K6WO/ebMIroi
	 IU2gAxK2LNhie3HxBv+fEdBy/Qux8H5uebKwQpgsAbZu4HRYwQ8Ll+Y/x1LzvJqfMw
	 ddXB6SYWYUFW5iJFW3vZ6EUICSS+vWIBElVfNO43YcMvARk3/BlbWlAtsTmLGjtRT6
	 FWrb2PJMH2cZNnTaUC7vDt+xmDf1NkixEN6p7idy03hRzUguIMMZMK/ECNLcZj1im4
	 PVQOxlu7/zQBA==
Date: Wed, 14 Aug 2024 13:39:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com,
	adrian.hunter@intel.com, atrajeev@linux.vnet.ibm.com,
	irogers@google.com, jolsa@kernel.org, kjain@linux.ibm.com,
	mpetlan@redhat.com, rstoyano@redhat.com
Subject: Re: [PATCH v3] perf test record.sh: Raise limit of open file
 descriptors
Message-ID: <Zrzds_xPdjI_rljK@x1>
References: <20240814151734.15409-1-vmolnaro@redhat.com>
 <ZrzOFDmwl9Z8F8NP@x1>
 <ZrzO2T1s_tIpqizG@x1>
 <d847f760-896e-4bdf-9f8c-933f52a5aed8@redhat.com>
 <ZrzTS46l3Ct_I0Oj@x1>
 <ZrzTyVLQCQPiV_D3@x1>
 <15098bfe-e1c1-4d97-bbb8-be26d589664b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15098bfe-e1c1-4d97-bbb8-be26d589664b@redhat.com>

On Wed, Aug 14, 2024 at 06:04:27PM +0200, Veronika Molnarova wrote:
> 
> 
> On 8/14/24 17:56, Arnaldo Carvalho de Melo wrote:
> > On Wed, Aug 14, 2024 at 12:54:51PM -0300, Arnaldo Carvalho de Melo wrote:
> >> On Wed, Aug 14, 2024 at 05:42:01PM +0200, Veronika Molnarova wrote:
> >>>
> >>>
> >>> On 8/14/24 17:35, Arnaldo Carvalho de Melo wrote:
> >>>> On Wed, Aug 14, 2024 at 12:32:39PM -0300, Arnaldo Carvalho de Melo wrote:
> >>>>> On Wed, Aug 14, 2024 at 05:17:34PM +0200, vmolnaro@redhat.com wrote:
> >>>>>> From: Veronika Molnarova <vmolnaro@redhat.com>
> >>>>>
> >>>>> Ok? I'm applying it with this change. Thanks,
> >>>>
> >>>> So I added this to the log message:
> >>>>
> >>>> Committer notes:
> >>>>
> >>>> Instead of disabling ShellCheck warnings all the uses of 'uname -n',
> >>>> i.e. those:
> >>>>
> >>>>   In tests/shell/record.sh line 35:
> >>>>   default_fd_limit=$(ulimit -Sn)
> >>>>                             ^-^ SC3045 (warning): In POSIX sh, ulimit -S is undefined.
> >>>>
> >>>> We can just switch from using '/bin/sh' to '/bin/bash' for this test, as
> >>>> bash _has_ 'ulimit -n', so ShellCheck will not emit that warning.
> >>>>
> >>>> There are dozens of 'perf test' shell tests that do just that,
> >>>> '/bin/bash' is a reasonable expectation for those tests.
> >>>>
> >>>> ----------------------------------------------------------
> >>>>
> >>>> Please let me know if you find any issues with this course of action,
> >>>>
> >>>> Thanks,
> >>>>
> >>>> - Arnaldo
> >>>>
> >>> If so then the check whether the ulimit is supported doesn't need to be done
> >>> as bash is given as a requirement. Thought that it should be supporting all
> >>> possible shells, even though couldn't find shell not supporting 'ulimit -Sn'.
> >>>
> >>> Can I send a quick fix that just changes to the '/bin/bash' so that the code
> >>> won't have unnecessary code?
> >>
> >> See my last message, I went with your v2 + switch from /bin/sh to
> >> /bin/bash, as you suggest above.
> > 
> > And added the '-S' to ulimit, since you changed that from v2, are you
> > sure that is better than using just -n? Why?
> > 
> > - Arnaldo
> > 
> 
> It doesn't matter for checking the value, 'ulimit -n' is the same as 'ulimit -Sn'.
> But when setting up the value without the option -S, both soft and hard limits are
> set to the provided value. For us, only raising the soft limit is important, as it
> is very unlikely that that hard limit would need to be raised. Also, then the hard
> limit would have to be restored separately to its original value.

Thanks for the explanation, I kept the -S.

- Arnaldo
