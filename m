Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B107200C2;
	Fri,  3 Apr 2026 03:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775185993; cv=none; b=KXoWmW5u4aDZ8uCA1daFcyrJmrn7A/vaQMksTqyBePskVUD/26wICYuXE2ILEQLr4niV46wR+W2aIB4ZCLQ6z//AnFS3LepMjbsV+JgwZATCW9M0qTt9K7LbcgizXTL3P93KEqYcXgxHZi5ZxSqXx7wNNajtjkn5hvSCpgN+l0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775185993; c=relaxed/simple;
	bh=PQRVQiqWH0bXcbBVhQ5uQimCFUuUhqXRIo7zfkoiEiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USRaIST/+zD9+rXfv4SqTmtqDQIrc9xC14BrbvQcRqrkfgzeq3UGKYxw+EPR3s1qcMY4EA2RJDjzhlpfWpPGP9QHTY5fMWHz+uD4Ti/OwHm6CL6YDr/par2ZLKwdwWmFUlieuyD27WXud2RvjO8rWOaXxwWz+b+/dt/fEg6U2z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5wPtn6e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5wPtn6e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461E1C116C6;
	Fri,  3 Apr 2026 03:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775185992;
	bh=PQRVQiqWH0bXcbBVhQ5uQimCFUuUhqXRIo7zfkoiEiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5wPtn6eOwaZOvKuGceaZJ/1HXeMC6V4EE3D82dlhzhVfznTXdrfO3RYDHqVyAWjX
	 hPRbnwFhI7nrYUzaCYbVG+vrxRky/p80HhPXHm/RevhcXzvUE/mXJcRKkL/+ciZi8E
	 sRldS89mm4cdWpV/Ia7lzeK4Jxl94vacYmjpYWLSGsPRLiP6NlUsw4BFIssc5094RY
	 ks9abeLD4va3yZpZnU600S1774qMo7ZYfKWx8TeYssJvKuWxqrNsIjGN/Aj+3YaM45
	 LkyEWeqO4xGApRuMa95E9rpuIuxTHASc5LB0oActa1GmaVHi0+DAFSxh7y5wItTjYD
	 J6HD0b3pLSlNA==
Date: Thu, 2 Apr 2026 20:13:10 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf ftrace: Proper error clean up in
 print_profile_result
Message-ID: <ac8wRsk5APQQIKpG@google.com>
References: <20260306185022.2016541-1-irogers@google.com>
 <CAP-5=fX6ttKud+b0sDS2SjHytocVNq8Ga7j66LFwRBXOwKJ85g@mail.gmail.com>
 <CAP-5=fVw338CJLJNpD6qjWVA3ofqd9H5-0PvjUfhQRjOtnN4Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVw338CJLJNpD6qjWVA3ofqd9H5-0PvjUfhQRjOtnN4Gg@mail.gmail.com>

On Tue, Mar 31, 2026 at 10:53:57PM -0700, Ian Rogers wrote:
> On Fri, Mar 20, 2026 at 7:50 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Fri, Mar 6, 2026 at 10:50 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > The ftrace profile_hash is cleaned up on success but not on memory
> > > allocation and empty paths. Fix by running the clean up for all. Free
> > > the profile too, so make it NULL, just for clarity that this is all
> > > clean up code.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Ping.
> 
> Ping.

Sorry for the delay.  Can you please rebase the change?  It doesn't
apply anymore.

Thanks,
Namhyung

