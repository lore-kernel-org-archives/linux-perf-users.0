Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B83DF9D6;
	Thu, 10 Oct 2024 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728522070; cv=none; b=dUSSCGBSSm7GTNa0Stu13UFibgCPEC4qAs3i+Nxh5bJ/FDMIGeG7fmmEF+wcQ2IThvuB3djwXiFBHRr2orWuQhfiHX8MNK8OEel9+sPM3ByfZLmD59GycEUtdrIZiC1e6qBeC+MS9seEoKH6l0J0/JlkI7lGUuNjE/I+hlFD7YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728522070; c=relaxed/simple;
	bh=DpeB5UWr5Bb8oES9qXDvqB1/Pw3hbXWVNjFtf+W36Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqlJoUfuxG7GVGp4CFNEOndrDU/vVK9MMV8JlMoEkiAWYWC4Eq9EtFW1pqVqvqb4KTwn39EFSyFvMnLiCisXnEncWP0FcMYoArZ09aQaXDoPjQnR0gr9FFQgcgIxxG5lpBHBy7HjDLfUoJOxeKZCGH2hhM5U/RkTlaGpOYmfHFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8ORzYCT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8ORzYCT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A53CC4CEC3;
	Thu, 10 Oct 2024 01:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728522069;
	bh=DpeB5UWr5Bb8oES9qXDvqB1/Pw3hbXWVNjFtf+W36Ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8ORzYCTeYXPJAEUkV/ulCHp01iGvhr9UK67dKySFI+txfdyWr395q8DTkG/u1M5+
	 2hjwsknNZMbcehlq2JmjJlQsEVASp93fzS6VN9IVcUeZy0vmnfm1nb4sfmvgeze9J5
	 9UX9hLkWB7+BxJznALD0kQ0z5DHJlnwHfcZL/4Nmuy0ssGtr3jH6TEZ6hmlebb/yHV
	 OWjjNDpNjtHfFu+2Q0nNKFxSvJlnGU0QpJUm4Esm+uyxXpsZmJNeLd5K394jo6h6J6
	 cp/Z2EPI6tjPK/AJo6Q9IAGuy6qPK87JL7lARUyTIB3L4mBzgnNNpQ5EKjcvro8pc8
	 f8hulp7/CU9KA==
Date: Wed, 9 Oct 2024 18:01:08 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf build: Require at least clang 16.0.6 to build
 BPF skeletons
Message-ID: <ZwcnVKn3wVSSMcaL@google.com>
References: <caad2d84-a8ff-4304-b8ab-04642ea18323@linaro.org>
 <ZuL_0V5jgaaEUOY_@x1>
 <49fe18ff-827a-429b-9d74-9d8ed02ac409@linaro.org>
 <CA+JHD936J-q0-7LANQ3aW2G-PEmFP8PnXQ-TF-AMs9MtrCqfew@mail.gmail.com>
 <CAH0uvojUEXiT2mk1pknLS1nc-gA3Py+AjmEW22ETiCCyOLLr8Q@mail.gmail.com>
 <CAH0uvogXyYP1LqF3fbjZGHHDL6BFZ2ZKu5JAASnK_brgnymf0w@mail.gmail.com>
 <CAH0uvohEozKixjDM9_jJ5FFxYK7agsqVO-BrAsm=4hCTDQAx2A@mail.gmail.com>
 <9bbfe425-1f2b-4846-a5a3-a31618742e9a@oracle.com>
 <CAH0uvojJ1rME4hb6NfrA4NPj2XmGMDLOLP3wEbHh8B5-qWGvFQ@mail.gmail.com>
 <CAH0uvohW7_st0i=ek8rc_SucuQEQUgs+fWt12cc3jqiYfxAjmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH0uvohW7_st0i=ek8rc_SucuQEQUgs+fWt12cc3jqiYfxAjmw@mail.gmail.com>

On Tue, Oct 08, 2024 at 12:27:24AM -0700, Howard Chu wrote:
> Hi Alan, Arnaldo and James,
> 
> This problem was solved in [PATCH 0/2] perf trace: Fix support for the
> new BPF feature in clang 12 (Link:
> https://lore.kernel.org/linux-perf-users/20241007051414.2995674-1-howardchu95@gmail.com/T/#t),
> sorry I forgot to cc you two.
> 
> Alan's thought was correct. Thank you so much! :)

It'd be great if any of you can test this change.  Now I only have
machines with clang 16.

Thanks,
Namhyung

