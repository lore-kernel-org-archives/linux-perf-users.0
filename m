Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A373AA195;
	Tue, 20 Jan 2026 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941130; cv=none; b=g2p4mVfhajd9OthgUo2KbubnsxHiEj7wk+3QgXpsK/4+JzBQavCPv9H/U21nn6MUiR2azhLVpBdm7TESNEBOcCf2fqRYwbsLwSSmjDfclcbLOR2Vbstkimj+k9IyuOTZvzE938QARjI+2lMnT1ILzH3e2Q7vUKiaHyobxNpNTk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941130; c=relaxed/simple;
	bh=1zg+J5kv/yyUUj0j+F868PF9rK/lTAe42LH5TP4orTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rd4J5j2gI/qA9kqp7qAWKKxdeeJEiOYiZ+bTOghCwO8DpKrnYrH+ZfhZUUU1m73QZ+eIt5i3qoJ5XyvqqWEIpiglF7xPBh2GKwh/DA2zPN+wq/eDFlBjndyGPQzokaiF11aCjPY4x4z+gVX94PNAo/8D7D57LN9UxFA8FBKDF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urG4pxoD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urG4pxoD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6E9C16AAE;
	Tue, 20 Jan 2026 20:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768941127;
	bh=1zg+J5kv/yyUUj0j+F868PF9rK/lTAe42LH5TP4orTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=urG4pxoD7GXbtxH0vY9qt6kESSzA32rnQjqIfKdNLxeJKrE7jf6NMwrI03qCj527D
	 6sZST++kf+c6Kjr1kxyceN72u3znyGnafp27lAcQ6SDCCD98IzW0wKlypvJoDLfTVk
	 AuDr2hqSmBWnzTXvavn5GgLwhXEmqP+jcB1pivNir4AKYawMBvO905aJS96V6pQrLK
	 6I18lxK9D381ltvvU441D4oy9qEny2xm0kX6F0Q6+Nk1nJZ8GDdughOFk8EXobCzJz
	 iOLFoPJSEXtev/8oMCvnupT18wxHMYh0twMgICtZOPG5EwQlQW2Y/U7EwSmW2p/0vn
	 hwVFzDUYd0AxQ==
Date: Tue, 20 Jan 2026 17:32:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Mike Leach <mike.leach@linaro.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>
Subject: Re: [PATCH v2 2/2] perf c2c: Update documentation for adding memory
 event table
Message-ID: <aW_mRD7W7QkAE3Lw@x1>
References: <20251212-perf_c2c_update_event-v2-0-27df9a6cb1d4@arm.com>
 <20251212-perf_c2c_update_event-v2-2-27df9a6cb1d4@arm.com>
 <651e1a79-356f-4f86-a6c3-8119f1c6c98f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <651e1a79-356f-4f86-a6c3-8119f1c6c98f@linaro.org>

On Mon, Dec 15, 2025 at 10:40:04AM +0200, James Clark wrote:
> On 12/12/2025 19:25, Leo Yan wrote:
> > Users may occasionally need to see which options are applied to memory
> > events.  This helps to understand the behavior of "perf c2c" and
> > "perf mem", and provides guidance for configuring memory event options
> > directly.
> > 
> > Add a table to track memory events and their corresponding options, and
> > include the Arm SPE events in it.
> > 
> > Suggested-by: Al Grant <al.grant@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks, applied to perf-tools-next,

- Arnaldo
