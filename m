Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412DC3FF89A
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303078; cv=none; b=XqtJMLVdWSekaXJAXVXBp1IBHSWxYAakWk401as0L/xI+4g1yPNop9fd1P3bvbwkzs+MOqHrZSrTM5T7fg09HxXThvYbJAO5/BZ8j7IUHIZHx0l3mkJPG/eRx/ZY6fbaYDfx4vJp8vzcIiTzNFNGgOPGLwcVoV+fgMy/8Vc2OAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303078; c=relaxed/simple;
	bh=ZSvns0h/S8ThPUNfZdPyhwAmjjvyKwdJNfSpWwZMURQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEe7vpBO/5rW8QOSkNwwQJT+HafIAe8HsJd3o9iNgPjYtv1FOfaHcAr/+8JqIwiuMTTS1iSjdAB6pUoHGmwNmnBTnAQBvmS+jzWUzn8+PIHR0FIIIrskHWexOKyagnQNqMlC7BrCfGBIEAH6/BSywggWI29BJ6Ipboo40sCerGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUs89q65; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUs89q65"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4740A1F00894;
	Wed, 20 May 2026 18:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779303075;
	bh=oBnvnTkMeJlEtlHHOru2DVOsWJaCWCWLU6/4oPK5Y2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DUs89q65ssS5ec+p6lIZokzbImll5MEdr0u7TkoLwZwlQ64Ifq6Tdg38cJ5HOpAM9
	 Rq5bhEG6RCBiIn7V/HQzslVxPizo+9sbYSau/RgdZtGmS3ZMvMJL28OjcVIhL0gFIq
	 kFI1oUlaAUwupDb4UDPMh5uLZH5S27NWx4F+j8u8TN25cyKQRNwjVT0bL30E2fi07s
	 mo2/22n1I/5vUUKerSW6QEGzYtn42oXSCWUErgnqQceagvrRC7H/NF+zZ+sQHF+sDC
	 aJwDuiaFq02b0bGMM0Wz7eyR+cJDdw4yxf6daSkvWoHNuIQp7AGN2akhfpszFHf3Yh
	 Nxx7MlhTum3wQ==
Date: Wed, 20 May 2026 15:51:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org,
	namhyung@kernel.org
Subject: Re: [PATCH] perf build-id: Fix off-by-one bug when printing
 kernel/module build-id
Message-ID: <ag4CoMSo8MMLoeTM@x1>
References: <20260519223855.191637-1-mpetlan@redhat.com>
 <CAP-5=fV=ouJST+4Aww9gHBLSyag0mZsXM+HWYGLQNd1T3oH0Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV=ouJST+4Aww9gHBLSyag0mZsXM+HWYGLQNd1T3oH0Rg@mail.gmail.com>

On Wed, May 20, 2026 at 08:55:51AM -0700, Ian Rogers wrote:
> On Tue, May 19, 2026 at 3:39 PM Michael Petlan <mpetlan@redhat.com> wrote:
> >
> > When changing sprintf functions to snprintf, one byte got lost. Since
> > snprintf ones do not handle the '\0' terminating character, the number
> > of printed characters is 40, while sizeof(sbuild_id) is 41, including
> > the terminating '\0' character. This makes the later check fail so that
> > nothing is printed.
> >
> > Fix that.
> >
> > Before:
> >     [Michael@Carbon ~]$ perf buildid-list -k
> >     [Michael@Carbon ~]$
> >
> > After:
> >     [Michael@Carbon ~]$ perf buildid-list -k
> >     a527806324d543c4bc3ff2f9c9519d494fed5f68
> >     [Michael@Carbon ~]$
> >
> > Fixes: fccaaf6fbbc5 ("perf build-id: Change sprintf functions to snprintf")
> >
> > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> 
> Tested-by: Ian Rogers <irogers@google.com>
> also Sashiko is green for this patch:
> https://sashiko.dev/#/patchset/20260519223855.191637-1-mpetlan%40redhat.com

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
