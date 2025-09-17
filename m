Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CAC1A9FBE;
	Wed, 17 Sep 2025 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758127318; cv=none; b=BcVYxJamP7u0k8gnPtGfpzNjSYWa+mMFlMCd73Jt8g16HvkvgeeYAZo2VS8CDN5DH2EtVhTRlksq8vyKu1f2tQkXlWQZl20DnZne+ZS6iBbRvXFPl8WGoRFNb3blAmTr5wJC7gp70zNJiFFSECDnB8sMgC8xCiFq6PviojXy/iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758127318; c=relaxed/simple;
	bh=H5+WBnWe3MWBYM4eBRe3qCY0iIElJYW8j9sDBLad/TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hONZLhwJe7sbNNYz8M0gEuSy7CS2HGYKobyaEm2ERNju3B/8tl+Xw13J/pWLsM4DDEBso/a/3N7DwbSW+Ulp48ht5I1YkEmKYlWPjGZGCnXiiBwpAyD0ZVjQrVxnzd/00gG5TC/9KzBPH2AYqkpVU/9bBBgNuLphhvT5/26JSlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBBB0OG7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBBB0OG7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D58C4CEF9;
	Wed, 17 Sep 2025 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758127318;
	bh=H5+WBnWe3MWBYM4eBRe3qCY0iIElJYW8j9sDBLad/TM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBBB0OG7azD8+aZC4yztyVTFFJsbnR8c9A0zNn09pkMImVCBqnFCPu+DylHUzUsLQ
	 QgkdQzzkA8vOcLieykYHo+CzAVvLg+PS5W4LQBQ6syR7DPTnHBvDEtL9m53oOWyQLA
	 2MsUCxb724GoankvFPSBHyl5NXsAagxrEyMlKOMkBslFr03n4PsP/yQ+SAfFB6DBMl
	 D78GFTmrd58ToaHL9Hy6Kq5D44V0sOnEtgPn6ppyWG1YV4uc5+dYc/GZx4n682ks//
	 QZoFUP7ygKrsR6F9c8+sktLqz5QcCHfZJtHuennehowcZoxU/IGGMfn7eNR5suUySF
	 ECduk+XwEQ0fA==
Date: Wed, 17 Sep 2025 13:41:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Gautam Menghani <gautam@linux.ibm.com>, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	maddy@linux.ibm.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf python: Add an example for sampling
Message-ID: <aMrk03gigBlGcYLK@x1>
References: <20250728055937.58531-1-gautam@linux.ibm.com>
 <aMlmiHATn5WHUcSM@mac.in.ibm.com>
 <aMm5uvPsMfXEv8Oo@x1>
 <CAP-5=fW4JQYJ2NCRsRVePidCcZ9+JcQbfY=xQ00xZG-bSn96ew@mail.gmail.com>
 <aMqrmmDG65BGeZp0@x1>
 <CAP-5=fXnM15Zj5mCYcsd9usUMtHoPOd3Wz8-L1N5UaB-YvKuHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXnM15Zj5mCYcsd9usUMtHoPOd3Wz8-L1N5UaB-YvKuHQ@mail.gmail.com>

On Wed, Sep 17, 2025 at 08:29:24AM -0700, Ian Rogers wrote:
> On Wed, Sep 17, 2025 at 5:37 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > And make:

> > perf script rwtop

> > Just call 'python PATH_TO_PYTHON_SCRIPTS/rwtop.py' transparently?
 
> Yeah, that's it. The perf script libpython stuff is just providing
> trace_begin, process_event and trace_end. Using the sampling
> mechanism, as shown in Gautum's patches, it is pretty easy to migrate
> them to being stand alone bits of python.
 
> > That looks interesting indeed, that way we would stop linking with
> > libpython, etc.

> > I wonder if there are out of tree scripts using the current tools/perf/util/scripting-engines/trace-event-python.c
> > mechanism...

> > But even that can fallback to a python based mechanism, right?

> I think so. Like I said about the use of a Dict for process_event, we
> may want to streamline things so there is a tension with what the API
> should be and compatibility. We can always have 2 APIs and try to
> deprecate one of them.

> > Import the script, if it has a given structure, use the new way, if not,
> > call a glue that reads the events and feed to the old style code.

> > Seems doable and would save code on the main perf binary and headaches
> > with the libpython and libperl build processes.

> So I see this for libpython, and I think it'd be pretty cool if we
> could have things work like this for say "perf script ilist" and

I think we could even try to, not having a builtin-ilist.c convert
'perf ilist' to 'perf script ilist' automagically.

> Alice's textual flamegraph work. I worry what the work for libperl
> would be like and whether it is worth it (hence sending the patch to
> at least start to make it opt-in rather than opt-out).

Maybe we should be a tad more cautious and start with emitting a warning
that "libperl is deprecated (holler if you disagree if you use it!)" and
then make it opt-in, and then remove it.

> Do you need my tags for these changes or wdyt about making the
> kwlist/API surface smaller?

Lemme look at the original post...

- Arnaldo
