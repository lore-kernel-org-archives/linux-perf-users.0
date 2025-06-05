Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB49216E1B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Jun 2025 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749152410; cv=none; b=iVhPOdCdLu4VM+nreEr1PQDmRpIiI9v2FcYBvqHk2QzqWaKYlflw/OyGO+Iw1PcDMZRJUPH+wPJgBt000DNGnuA3cNZhm9Z6EhtVJ9Xy1G9A8bgWj2DMmvMEfNAQLhbJLg2m4+anAmqcJvPufKQhcja8Y4Hn0NXiOMA0cJPRh3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749152410; c=relaxed/simple;
	bh=8puERAQlgSh4eMIQQfeNCSHwd4/5qA73108sC0GYZmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBX13wTJHWb1BzFpxKD+t+hcWaaGwZzO9KtzytqVufyTCw/StJ9gO12diBFNoft7szC+IprT+l7kRv9QRvzdOMktgqYgTs3wQXvTW4nnjTvlvtsw88Q22dxNkYUW4Od8flWpjgvLt6ORW0W9izQHh1z+zFeTRPB4RAB3dfieBL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXaO2MZ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXaO2MZ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D393C4CEF3;
	Thu,  5 Jun 2025 19:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749152410;
	bh=8puERAQlgSh4eMIQQfeNCSHwd4/5qA73108sC0GYZmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qXaO2MZ7De1lRrqtw3ztO/WWdiZPEPcullMMvYhwLVsjDA8H2ed0olepqpwvCu0HW
	 p6HRl4Gtj6qm+pBBE5b6v9UaZzr1X7Tr+jY5ZlscUC2X8hfavoeirVBYgLRZwDq5EK
	 1VTXAxerKd6ulHJnChk1UE8Nyhn2gIL5aRodgHPu3CT518wNc1pIg0WUbI/2UoLmAR
	 FQ+u4vBcwJL9us7VwGnptWUm/hG4UlkRvY/FJ9jgop2ziaZlk1rpxlKmjvC9F1ofpn
	 ZiGfuaM5Ivz06fM7FsxGICRagLgc9kpa/J9etatHMNiSS0XyktBtv+5s76l7BWTZev
	 3ljKRBxYPBp+g==
Date: Thu, 5 Jun 2025 16:40:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Michel Lind <michel@michel-slm.name>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: perf-tools v6.15 tarball not uploaded?
Message-ID: <aEHylyR4hGaqZ6C8@x1>
References: <c5ac84be0a119d3dd432edf36196d07ad562b34c.camel@michel-slm.name>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5ac84be0a119d3dd432edf36196d07ad562b34c.camel@michel-slm.name>

On Thu, Jun 05, 2025 at 11:24:50AM -0500, Michel Lind wrote:
> Hi Arnaldo,
> 
> I noticed the kernel.org mirrors don't have perf tarballs newer than
> 6.14.0 - https://mirrors.edge.kernel.org/pub/linux/kernel/tools/perf/
> 
> Will they be uploaded soon? Presumably I can just generate the tarball
> myself for now from the Git tag.

Its there now:

https://www.kernel.org/pub/linux/kernel/tools/perf/v6.15.0/perf-6.15.0.tar.xz

- Arnaldo
