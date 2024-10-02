Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E565212F00;
	Wed,  2 Oct 2024 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893142; cv=none; b=AszfEZWcacXjy4lWd9E+8F+aMhvJgmP/nt5bKmXktWtHANgsZbuUmdtWulVSyM3J/Vg3QiPboX5Oz3p3W/+dR7rubPVE50IOqtKylp0dEVqAX77v8lL5CqAGeJlcY2xGAoB6H5MXdRFGTCPXMawJZbykKiuu32zy+CiY1kaJri0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893142; c=relaxed/simple;
	bh=dHefylI3YjR90w1RAwenUM6Z63PhTl4WJuv7ko0bfrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbfB6fELdWbB8YHI/UxgjegPqXCO+BsJ3vxBBmlVoMtl4Y/V8YIbSKQH6zViY6Rf+WVhyTnD3PhNcXGLq+Wj4W5jlGp+QQBUMuytgOho52kQxveT08bmQAkWzjITA9K/FEVD4lDU48XzIcMEHan72FvUcqtWK8Zn/P+wgNsihOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxcP36zB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxcP36zB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE5DC4CEC2;
	Wed,  2 Oct 2024 18:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727893141;
	bh=dHefylI3YjR90w1RAwenUM6Z63PhTl4WJuv7ko0bfrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZxcP36zBtjFJHvG00TT5l67duxdm6GK/X398wptNs2sPo3yEkZi4SfsCu3VZYGWvm
	 BCBvZWGAtN6LnWgziozDXx5JQlwac/d8AzCab7+IcboiiWJUxaTgi/9aXZbsBQuQwv
	 zn6L4n5rry9GNJ+zv4+aq3I40NivCnxps4KlZVIUac2qEjRYbkBlXHba18227GCe9A
	 3RXTWpcp93VAQ59MJ/brK3V4oPHJjzVWXWScnWP5uNuoM3E4Ibz0LyyROblOaYYnTI
	 AOrBk4AxstCCmVWGqWqKiP6X90XJbhwahd5jEsy7I7C+W0eLoMwB+VaJwBo12VWOBw
	 tJpHwGE3iEWUQ==
Date: Wed, 2 Oct 2024 11:18:59 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] check_headers.sh with hunk exceptions
 (lib/list_sort.c tools/ copy)
Message-ID: <Zv2Ok-bMFy_e4AUm@google.com>
References: <20240930202136.16904-1-acme@kernel.org>
 <Zv2A/npbGyP2SlKV@visitorckw-System-Product-Name>
 <Zv2DEHipdoUoeyp-@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zv2DEHipdoUoeyp-@x1>

Hi Arnaldo,

On Wed, Oct 02, 2024 at 02:29:52PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Oct 03, 2024 at 01:21:02AM +0800, Kuan-Wei Chiu wrote:
> > On Mon, Sep 30, 2024 at 05:21:34PM -0300, Arnaldo Carvalho de Melo wrote:
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > 	Please take a look, as per tools/include/uapi/README we carry
> > > copies of kernel files for various reasons and check when it drifts, in
> > > this case we need another way to accept diffs while checking, its all
> > > spelled out in the individual patches, please ack.
> 
> > > Arnaldo Carvalho de Melo (2):
> > >   tools check_headers.sh: Add check variant that excludes some hunks
> > >   perf tools: Cope with differences for lib/list_sort.c copy from the kernel
> 
> > LGTM. For the series:
>  
> > Acked-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> 
> Adding it to that cset before pushing to the written in stone
> perf-tools/perf-tools branch.

Oh, I thought you wanted to have it in the perf-tools-next branch.
But it's ok to go through perf-tools.  I'll drop this patchset from
tmp.perf-tools-next.

Thanks,
Namhyung

>  
> > While reviewing the patches, I noticed that there was already a
> > difference between lib/list_sort.c and tools/lib/list_sort.c regarding
> > an additional #include <linux/bug.h>. This prompted me to investigate
> > the reason for this discrepancy. From what I can see, both files only
> > seem to require only three headers:
> 
> > #include <linux/compiler.h> /* for likely() macro */
> > #include <linux/export.h> /* for EXPORT_SYMBOL() macro */
> > #include <linux/list_sort.h> /* for list_sort() and linux/types.h */
>  
> > I'll check the git history and run build tests to confirm. If only
> > these headers are needed, I'll submit a cleanup patch.
> 
> tools/ is a sidecar or sorts for the kernel, that tries to add value to
> kernel developers while not getting in their way.
> 
> Sometimes things we discover while using more widely things that were
> designed for use in the kernel source may be of help to kernel
> developers, if this is one such case, great!
> 
> But IIRC that linux/bug.h discrepancy, without further checking, was
> something already somehow accepted via:
> 
> +check lib/list_sort.c                '-I "^#include <linux/bug.h>"'
> 
> in the cset that introduced the copy:
> 
>   92ec3cc94c2cb60d ("tools lib: Adopt list_sort() from the kernel sources")
> 
> - Arnaldo
