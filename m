Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445C05372DE;
	Tue, 22 Sep 2026 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080767; cv=none; b=Jj41ghcLI22nr3MQ5KlSa2ftNyVNFTiudEVS2dW3U93gswfnGh2yqpOo3AMstY8HrtaD51Tr430pVBh1kFPb1Vn1e/sScLDUh+f4iAmjEDYFUOkqsVgKpQ1grnDb8aRgTBhOZ2WnP18+9n9G+/PzD+rjp7Yy38JbrmmfqJOdomc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080767; c=relaxed/simple;
	bh=TsJ3XIPVwt9acaX3COTgWLQRCn8mKSI32QPnuB3vMqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQ5+UiI7lLrqoaxsyWQ0t1nN1syq4hayhj3WMuvQ50/QHJHKR+yV//vkkz8SKrRv2D7A0krO0+1c0XDrKVQth+VasRQVx0EuKFGLQupKR6lg533MDhUrYh/U4m3Or0KRdg4olJQBTjLp1paQefL7TDQGqPIcn0ZPxl6+cBmRe0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/ALuN3q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/ALuN3q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D8D1F000FF;
	Tue, 22 Sep 2026 12:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080765;
	bh=QLoR3dFRtXbr6vPpFSReD2HvpuUUBOOt3jsnT9F9Frc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V/ALuN3qgtC+lokrz/DCEpCcDSste1zqnFoX4pmZehexTIOWOFBFVS1aiaLgfyJUc
	 OcWssi2r7yLhioNqQBYCTSBeqKtT8uuyppAgvT2hawe0ePTfHfR29/e+Ngsep1lAMX
	 gusO8DXlswjpkpxl66a0hdxCWlEE1KxWdkvmS1/sVJP+2uBeIaiBFeevEf6pRr/z7t
	 cDHvGOSNoKyWCy/LUjRyyZJhsikQb9ARRUk18/4qv4liZvOPKjbWeyYxGMuBA6NrZ/
	 SZ1+yY+pwsHt7JR3QQtQMcebZr9ZQewRLwL7xOvlPpiGuqpGGzMwEkZcOBDXahcrvF
	 exvVbjRBnAFvA==
Date: Tue, 22 Sep 2026 14:39:18 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Chen Pei <cp0613@linux.alibaba.com>, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, james.clark@linaro.org,
	john.g.garry@oracle.com, will@kernel.org, mike.leach@arm.com,
	leo.yan@linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: Fix a leaked map reference in the arch dwarf
 unwind tests
Message-ID: <arJ29sSmeze39D0R@x2>
References: <20260914121903.1212-1-cp0613@linux.alibaba.com>
 <CAP-5=fVW6nJXoh8qf4e_jkLXGUzCGCTCg9YivHkN9kkVJmMa-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVW6nJXoh8qf4e_jkLXGUzCGCTCg9YivHkN9kkVJmMa-A@mail.gmail.com>

On Tue, Sep 15, 2026 at 12:35:23PM -0700, Ian Rogers wrote:
> On Mon, Sep 14, 2026 at 5:19 AM Chen Pei <cp0613@linux.alibaba.com> wrote:
> >
> > maps__find() has returned a reference to the map it finds since
> > commit 42fd623b58db ("perf maps: Get map before returning in
> > maps__find"), which updated arch/x86/tests/dwarf-unwind.c but missed
> > the arm, arm64 and powerpc copies. Release the map after reading its
> > end, as x86 does. All other callers of maps__find() already release
> > what they get.
> >
> > Fixes: 42fd623b58db ("perf maps: Get map before returning in maps__find")
> > Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
