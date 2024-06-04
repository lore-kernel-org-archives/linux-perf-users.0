Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49D414D435
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Jun 2024 22:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541024; cv=none; b=kEzIduNggm5DMDy2hNS6yq/+csCAEo+Dzz1lCfqK1RYe8l5s9Y8/m0AufLybO1YbnxjJzE+vUCes5vGht7B+lRy2mYgQiCtHfPP3m491QQUrawbGKaO0smngOvQ2XgynxwEseVxxHO/3AdOmRQ8bNeV6OQmjfVbXHQvTqoJO75s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541024; c=relaxed/simple;
	bh=7R+oJZ1QwpWam0oyPvl07XLWiT2XA4Ke7/fE/PCabxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvRRDOIoPyMrQTvckPKFIxNewGZ5fYwSxId+xI4JD5u0TWeB2NNDTTOXSio/XvNeWjMOwyg/sVWyNWXd4RHU/+50tbOB9tFE/6lrRk6M08RAOwvF3A4FmvPlMSA5Xrvl9CHNPOCbXLNyEZTWyuylUPjxlwMpirqeUTrBYqwxZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxcsKbnV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxcsKbnV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385B6C3277B;
	Tue,  4 Jun 2024 22:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717541024;
	bh=7R+oJZ1QwpWam0oyPvl07XLWiT2XA4Ke7/fE/PCabxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rxcsKbnVEvcvqUKhhGCW9T0ifCX/ix3aYfUCy78w7HgyVehsVT5JH05KWs8JiFj0E
	 spunf6+FA7rQu9UNckmABOpbxkXYfFtaHLEjwvuVhSaE2PdCZ8HQRBTyBogtOfikc4
	 6RH2rWojAAROlj2EzMVkld4CgwbXnbWKiO0AB1DC5gICpheFz+WB8tRT8tfVK1BnOm
	 kq5mXaPG0q91fAew7hiFS1CnLeJb9PyJ2vTwcX1y18RH/qptI7qVLrOYobF8+h1hf8
	 53T/f93kR86pQLDdok3BMXaz5mV8QKEWCp+L4fK04tzEuD8eFtdYOwdMkJ4RdJPtDp
	 rvP5YxcXbXi0A==
Date: Tue, 4 Jun 2024 15:43:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: perf FTBFS due to -Werror with gcc 14.1.1
Message-ID: <Zl-YnpW2BUcr-M8c@google.com>
References: <11178410.LHx4AX4RY1@milian-workstation>
 <Zl8akMdx92DdF7C_@x1>
 <4396113.DFci0H2nWq@milian-workstation>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4396113.DFci0H2nWq@milian-workstation>

Hello,

On Tue, Jun 04, 2024 at 09:58:20PM +0200, Milian Wolff wrote:
> On Dienstag, 4. Juni 2024 15:45:52 MESZ Arnaldo Carvalho de Melo wrote:
> > On Tue, Jun 04, 2024 at 01:40:19PM +0200, Milian Wolff wrote:
> > > Hey all,
> > > 
> > > I cannot build the acme perf/core branch on Arch anymore with gcc 14.1.1
> > > and
> > perf/core isn't being updated for quite a while, we nowadays update just
> > the perf-tools (current merge window) and perf-tools-next (next merge
> > window/devel).
> > 
> > Also I still keep my tree uptodate when I'm updating those branches, but
> > nowadays the trees/branches to be used are:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git
> > perf-tools
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
> > perf-tools-next
> > 
> > As Namhyung Kim is a perf tools co-maintainer and keeps one of these
> > trees+branch while I keep the other.
> > 
> > Right now I'm taking care of perf-tools while Namhyung is managing
> > perf-tools.next.
> 
> Ah indeed that's it, thank you!
> 
> Which one of the two would you recommend for interested parties that want to 
> keep track of perf tools development, i.e. what was perf/core?

The perf-tools-next is for new development (previously perf/core) and the
perf-tools is for fixes in the current cycles (previously perf/urgent).

Thanks,
Namhyung

