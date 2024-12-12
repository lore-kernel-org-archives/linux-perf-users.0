Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E88019CC0F;
	Thu, 12 Dec 2024 20:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734037132; cv=none; b=oOThe6yFsfpU2+jgGky16oJoniZk15oAwfJyN4qtj/S6TlejbZ4hltFI4wyXAj5QYDSIaK2DOXQ5bUYSQfo2qWpihblhZKNjd1aYztsOBB/1fSOQP9orxtikik9Jbriau3XrUvAigRV96PfyHIL++f/2d/sMYf9/NGqICD1IOtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734037132; c=relaxed/simple;
	bh=+Azc6SCsBw+GSqaSZp397/47kzP3mEE3hTD9ptW2dp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKWUlsjpaTsgpOajZa6W+7gBRJ5X64iKC7tiPhquzYWpcqIyxgz3nzerZA6PFkey4hKyYN76j2f5VPPNVekx4DuNx9dIC/V/gZoyRRuvleOHF0ynKiB3sSz3yAz7d2djFkLqjddrZXQTUIg6K7UKLSP4AZQhyhIdPYHAqyR7Z/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apX+6L5j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apX+6L5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA22C4CED0;
	Thu, 12 Dec 2024 20:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734037132;
	bh=+Azc6SCsBw+GSqaSZp397/47kzP3mEE3hTD9ptW2dp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=apX+6L5jE+SSMA0td7S+PWpJ13vkay89LxSWKYLINud8RdU4P1N1xvylVF5uZ+A54
	 EZANxpWfxJzkcyChfhMTSnz1T4qh0OpJcj/hY63GrTv2LpwSh59670RokYbb3d/EcZ
	 Gac4e15j/Wms9mJIr/99l57b6EL4B7JXdvS9pWvofqugcQ7eKJCaoR4vTtPxLS07gk
	 wsu73WnqqB5oXajNEyxm9oMd2nzCRqhgXXbs57FdwA6zu5N7lvZSN4617qvM183BXx
	 5FomohSnvirfnC0Qmp3pHwnyI6YAcr0XaI3Z1Snl6abh72xdqJclWeuXaifcs5V20g
	 Uz00T5LWAig5w==
Date: Thu, 12 Dec 2024 12:58:50 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, nick.forrington@arm.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 2/3] perf lock: Add percpu-rwsem for type filter
Message-ID: <Z1tOileaITRq7nwc@google.com>
References: <20241210200847.1023139-1-ctshao@google.com>
 <20241210200847.1023139-2-ctshao@google.com>
 <Z1nk1gxH9siszkwG@google.com>
 <Z1sy2NgchmkOOVt_@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1sy2NgchmkOOVt_@x1>

On Thu, Dec 12, 2024 at 04:00:40PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Dec 11, 2024 at 11:15:34AM -0800, Namhyung Kim wrote:
> > On Tue, Dec 10, 2024 at 12:08:21PM -0800, Chun-Tse Shao wrote:
> > > percpu-rwsem was missing in man page. And for backward compatibility,
> > > replace `pcpu-sem` with `percpu-rwsem` before parsing lock name.
> > > Tested `./perf lock con -ab -Y pcpu-sem` and `./perf lock con -ab -Y
> > > percpu-rwsem`
> 
> > > Fixes: 4f701063bfa2 ("perf lock contention: Show lock type with address")
> > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> 
> > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> 
> Here the reviewer can also add info about where this should go, i.e.
> this is a fix, has a Fixes tag, but then there is extra work for
> maintainers to do: Is this a regression introduced in this merge window?
> Should this go to urgent or next? If the submitter adds this, it helps,
> if the reviewer agrees, even better, otherwise emit an opinion where it
> should go.
> 
> In this specific case:
> 
> ⬢ [acme@toolbox perf-tools-next]$ git tag --contains 4f701063bfa2 | grep ^v[56] | grep -v -- -rc
> v6.10
> v6.11
> v6.12
> v6.4
> v6.5
> v6.6
> v6.7
> v6.8
> v6.9
> ⬢ [acme@toolbox perf-tools-next]$
> 
> Looks something its there for quite a while, so probably can go to
> perf-tools-next?

Yeah, I think it should be ok to go to perf-tools-next.

Thanks,
Namhyung

