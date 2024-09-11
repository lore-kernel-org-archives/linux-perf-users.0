Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11E7192D86;
	Wed, 11 Sep 2024 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069955; cv=none; b=AwXt9+0wXiiiW6jVgusmI40ZudDVfCHK0uNpjJYav6ConUjmHYZG17tmNy05ISaV/0vqKzlZ64QCXlHk2IMVdDmGBBhYvS/UqXMTa/ARlH3lYm+AO6MdCgWAbTbEAmfAWfvieVcKvy29GCdkDFAMz3cJ7cVo4I1bBzBZlGhMgHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069955; c=relaxed/simple;
	bh=rKWA3UShZ/s8ZMt2mlMUZHDP2tW4HLoJaMa0ps78jio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WR0gb5IehgFR6b/WU2EDY45SDTrHEdg40IIn4yamV7QgVoyipgKQr4y+b1dAFtgCSepjxMsTuvsocDbzZJcxJjFMkYbrsFZf5gYfCsXC08Z4lR7d1hyYhTGYtqhZRhpl4CSdiUbJNvdHk45CaisMk2myXOqTptToSfubMIhDWls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oe2UFUkT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oe2UFUkT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF749C4CEC0;
	Wed, 11 Sep 2024 15:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726069955;
	bh=rKWA3UShZ/s8ZMt2mlMUZHDP2tW4HLoJaMa0ps78jio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oe2UFUkTIMMsv9Lx5GYRuQa/ml85xgNW4CoT9+MOsE7O0JyYoTZhGEgA3lUYd+aCO
	 RhlLQxv+5hTVZoGSMOuKDb4yAgk3VYIndLuPn6idTHofUUmfnV9ZxKIGoZDZFf0Cty
	 4IfiXdG3Q2a2tm6genjGkHxPm+V/tI8c3vHQr8jR05jteS/W0Um8R5J7LmGV22wxEL
	 3Y/oSsDHJaOQc0ghCh8QWk6vs2vLV7048s73HPsvT5JJ/fmWL2adS8stre2XkGMONa
	 HwHVkGbwHfAEDWUtviB04P7em/H7AeDvgWzpBGaxH7UPwuL1o2cEpqSFDYVD119ggO
	 i1GwAAD42A19w==
Date: Wed, 11 Sep 2024 12:52:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: kan.liang@linux.intel.com, namhyung@kernel.org, jolsa@kernel.org,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf evlist: Print hint for group
Message-ID: <ZuG8wCjFjeW3stUI@x1>
References: <20240908202847.176280-1-kan.liang@linux.intel.com>
 <CAP-5=fXjH5C0H8RWULGm9UJc36mp=1rfoeBCxVVoHxe2KnGY8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXjH5C0H8RWULGm9UJc36mp=1rfoeBCxVVoHxe2KnGY8g@mail.gmail.com>

On Mon, Sep 09, 2024 at 09:54:57AM -0700, Ian Rogers wrote:
> On Sun, Sep 8, 2024 at 1:28 PM <kan.liang@linux.intel.com> wrote:
> >
> > From: Kan Liang <kan.liang@linux.intel.com>
> >
> > An event group is a critical relationship. There is a -g option that can
> > display the relationship. But it's hard for a user to know when should
> > this option be applied.
> >
> > If there is an event group in the perf record, print a hint to suggest
> > the user apply the -g to display the group information.
> >
> > With the patch,
> >
> >  $perf record -e "{cycles,instructions},instructions" sleep 1
> >  [ perf record: Woken up 1 times to write data ]
> >  [ perf record: Captured and wrote 0.024 MB perf.data (4 samples) ]
> >
> >  $perf evlist
> >  cycles
> >  instructions
> >  instructions
> >  # Tip: use 'perf evlist -g' to show group information
> >
> >  $perf evlist -g
> >  {cycles,instructions}
> >  instructions
> >
> > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Closes: https://lore.kernel.org/lkml/ZttgvduaKsVn1r4p@x1/
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, tested:

    Committer testing:
    
    So for a perf.data file _with_ a group:
    
      root@number:~# perf evlist -g
      {cpu_core/branch-instructions/pp,cpu_core/branches/}
      dummy:u
      root@number:~# perf evlist
      cpu_core/branch-instructions/pp
      cpu_core/branches/
      dummy:u
      # Tip: use 'perf evlist -g' to show group information
      root@number:~#
    
    Then for something _without_ a group, no hint:
    
      root@number:~# perf record ls
      <SNIP>
      [ perf record: Woken up 1 times to write data ]
      [ perf record: Captured and wrote 0.035 MB perf.data (7 samples) ]
      root@number:~# perf evlist
      cpu_atom/cycles/P
      cpu_core/cycles/P
      dummy:u
      root@number:~#
    
    No suggestion, good.
    
    Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
    Reviewed-by: Ian Rogers <irogers@google.com>
    Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>


Applied.

- Arnaldo
