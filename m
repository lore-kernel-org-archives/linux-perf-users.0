Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084661E876
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Jun 2024 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718898662; cv=none; b=T/WK0ELXcTKcb2WbMc7Jo/GH4FPoK06WnjPXP2Eh8jsTj6Aua5GLPevkb4UqP1q2Htf9fJY3eQpPSVxTMK62ePUCqy6pF6zo5RNyiBOh+Y9J6uSq36Mh1RYollLOE5uI0bUtx/TSR75E7s46CCvJU9ez5bn+1W9AU+M6c0L8O94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718898662; c=relaxed/simple;
	bh=aK+wfFd/HKcs/wC1cia9HhjkM4Lt1O2zM8C8K320mLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4Omai5OYUJYB5rfo1PBBVJUELBoIyg6R+IRGtRjj+So68Y1UnLrMy8TzIBemaK4c84J6QEbtiXoQNXU2OxcuKyKh1gi3UjZzjzyy+FY7HfjBTdvOYpq9gd1P5XLB15KjDHrfWfLk2foJGB0n9aI5n3v6gnH9FY2aEf+KHR4o3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvC8korC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvC8korC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28095C2BD10;
	Thu, 20 Jun 2024 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718898661;
	bh=aK+wfFd/HKcs/wC1cia9HhjkM4Lt1O2zM8C8K320mLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvC8korClv/WQFetyv979CiCmHT0iFGAu8BP6TwurSZER48caOsnWl9Qv5udBWYiT
	 AzrTfHuh+rgOC2Q0Xff8vogebmX9LcZgNgb+1pqRfLh7D/YEwOfQzBFPOmeSNwxSrY
	 XygelJl0IIt9Q1z4Sj0hwYMcSer+w5aeUzE7MatibaNFcwQa5WZoW5gLQbinSiQQ/I
	 LuYF2uglocChXS4dR3/CT1LmMwxeMnzv+ojqqbYhj04UrF07pyszEuraFl9ZVilH4+
	 fd6KmYd/pf1nnzAaYlJ06rVY+Nt+Ztssp393Q2bqelTRcxgK0PENkowpCQyFJwNrkx
	 V3jz+VC3z+vXw==
Date: Thu, 20 Jun 2024 12:50:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: Linux Perf Tool Office Hours
Message-ID: <ZnRP4hJLcRpZzs4x@x1>
References: <CAP-5=fXOQxiKJBfzKs3Gz4DuMoxxoTWf-Hw4dKDbhRguSup9Qw@mail.gmail.com>
 <CAP-5=fU3D9YZ+O-Mm0CqrpY4Ubhe6qW_nn8NkjuQ_jfVu2-scw@mail.gmail.com>
 <CAP-5=fVF9LVxO5kpyutmbOTC31ywQCO-qgNk3qnqv5rVOf-JDA@mail.gmail.com>
 <CAH0uvoiCX=asogf6e4D8mZ2Yw+8pj3HMTyvYTtQjFTtgKKP6GQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvoiCX=asogf6e4D8mZ2Yw+8pj3HMTyvYTtQjFTtgKKP6GQ@mail.gmail.com>

On Thu, Jun 20, 2024 at 11:40:44PM +0800, Howard Chu wrote:
> Hi,
> 
> Ian is busy so I'll do the announcement.
> 
> 4th week of Google Summer-of-Code. Office hours this week are the same
> as last week:

Great, I'll be there.

- Arnaldo
 
> Linux perf tool office hours
> Friday, June 21 · 8:00 – 9:00am
> 
> To join the office hours, use the link below:
> 
> Time zone: America/Los_Angeles
> Google Meet joining info
> Video call link: https://meet.google.com/tif-efem-uiq
> Or dial: ‪(US) +1 425-217-5482‬ PIN: ‪791 261 968‬#
> More phone numbers: https://tel.meet/tif-efem-uiq?pin=2651187837256
> 
> Thanks,
> Howard
> 
> On Thu, Jun 13, 2024 at 9:48 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Hi,
> >
> > 3rd week of Google Summer-of-Code. Office hours this week are the same
> > as last week:
> >
> > Linux perf tool office hours
> > Friday, June 14 · 8:00 – 9:00am
> > Time zone: America/Los_Angeles
> > Google Meet joining info
> > Video call link: https://meet.google.com/tif-efem-uiq
> > Or dial: ‪(US) +1 425-217-5482‬ PIN: ‪791 261 968‬#
> > More phone numbers: https://tel.meet/tif-efem-uiq?pin=2651187837256
> >
> > Thanks,
> > Ian
