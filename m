Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC8416133C
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Aug 2024 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722884319; cv=none; b=FtHPuIfi6ANJ+o1KyngP4wdcL2FAmh4d6HYc27NAzeh2z07nLUOIZDCGGuro7TyiqOLe9BG2UJfzELcd4pYAjp0VGhp3OwP305tncu2taqLHJ5D+NwZ85ijPLArrQYT+YogQ5NqUcsvkqo0CD3ZisxOPuQXsa1s5KI2F8onOdxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722884319; c=relaxed/simple;
	bh=uDABVFC57LpXgSGzsKtoy4nWQ5Y7liz/puQes35xni4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9pCnvqaAkuP1vgmvMY4hZTP+6mzNZPk3ST4pquOqu8db0roop2HEYx48dx88MkE2ENn1lGO1Rghwd8CcqJIMJVqi7ladhywa7DzI9fORoHNcFV1GBDMwwg7ANYIRa6rP3RN35CTHjJTRhPNkUTDnWYsXtVeCPNBSzB7+pyctbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHd2NoXz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHd2NoXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A45FC32782;
	Mon,  5 Aug 2024 18:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722884319;
	bh=uDABVFC57LpXgSGzsKtoy4nWQ5Y7liz/puQes35xni4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHd2NoXzLsupvmt0esiKjHl/AuGnPGZMbVpinda54Sz3YzMwGnj7FS/u1mvJRP3YQ
	 +ZYpQwfMl9jPlcwW0h1sn+16V2s9luD0hUcfKG6H+vOXXTvaWoIPya3sjREhC8iigV
	 ghyfzKykTKcSdBE1ymxzE26zRoqdZvMcZXqkdntMlvvSgqjyewrwiKvLpS7XQEJo2l
	 +HVMDAThncv5FmgLZuphdgJJVIMMW9H3EN4DbtOLWHtjwoPIAYuRavoKUydTsTSeK7
	 I7uInfbNp1XYI6GV+VfWCqRLkhMpVkfklaTmbN+1oCcf3N1OhLrw71N4vDJETUlIQz
	 W56oOKtXyToiw==
Date: Mon, 5 Aug 2024 11:58:37 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 3/4] perf script: Fix perf script -F +metric
Message-ID: <ZrEg3eWdGCkZQyrg@google.com>
References: <20240724190137.3810429-1-ak@linux.intel.com>
 <20240724190137.3810429-3-ak@linux.intel.com>
 <ZqLuWGKZjdUrkd0L@google.com>
 <ZqqRTKW80JJpNpRj@tassilo>
 <Zq0k1pRHZWB4N94a@google.com>
 <Zq1IbXj7oxBd7S82@tassilo>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zq1IbXj7oxBd7S82@tassilo>

On Fri, Aug 02, 2024 at 01:58:21PM -0700, Andi Kleen wrote:
> > > Not with leader sampling because the group is contiguous and output
> > > after its end, with all the previous values forgotten then.
> > > The other cases don't really work anyways as multiple people pointed
> > > out.
> > 
> > Right, but we cannot prevent people to do that..  Maybe we can disable
> > metric with a warning if leader sampling is not used?  Or at least add
> > a comment in the code that it's only intended for the use case.
> 
> Yes I did that in the version I posted yesterday. It prints a one
> time warning and disables metric output.

Oh ok, I'll take a look at the new version.

Thanks,
Namhyung
