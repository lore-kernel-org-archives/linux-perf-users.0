Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84AC19924D;
	Mon, 12 Aug 2024 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495875; cv=none; b=JzaUBvzYAr/Ia0g/8dMzyX7c43QBVY2nW4uC7bjxXf1fj0CvBCqWD8vXE0slbCvxxrqWEqTWTf9z5C4s+LdCFJK9GXaXBHIFC7/YPJ2Mo29eX5IsxCmCyxybWKqLxuXUYG2OsxdfHP4tksq91PaJZ0MxBUiKLAW+OdhdgNIAh10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495875; c=relaxed/simple;
	bh=LwT8+9nkgmGlBa4uGsMgfTOWb72fFqWy+MQwcBF6N4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKE/z3kKOQ5kd055Ns+V4nrjjzKdFfZeFFsk1KE8/cxlkjCes22LuisaNbyVaKHwQyeUncm73R+c+ceVvugM4F/rLxd4FUjCuUh9WeaXAJ6BbzJnmpGArKqfzLlDby0dzFIWZKmOgLBHBT2Kkqr2h/vQpPi0loIbJEUTqZagrlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGSU7UPb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGSU7UPb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D47C4AF0E;
	Mon, 12 Aug 2024 20:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723495875;
	bh=LwT8+9nkgmGlBa4uGsMgfTOWb72fFqWy+MQwcBF6N4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bGSU7UPb6V8ldsgnAKljgkdYw/Ms789M9ivxzH7PU94AeVJw34CTcZT8jTTocuJ/B
	 khLeU1kIHRTlPZTrgUO5bc1ugc08ga2HCt2egd6GrjkbXmNai9oJF/abstKftQ1NX+
	 2k/ydVrlRYIBA7t8ZAAT4BMOoH+nj+knnLev7A/3pvVwFa7DwllSsyn40tKVUZeJiW
	 ayMtuJGnFVQrgONTSSg/upbkQ07u5vy40S7BYtPDsrJGjTsBqNlDN/LzwVxov2zC7B
	 9H+xaWXmXSMnS4kb/xQXK/eGAxSU0qaziBJWldG+PLscC8K5ophNwedH7DYQHINvF5
	 SaIiteRSbrjZQ==
Date: Mon, 12 Aug 2024 17:51:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1] perf inject: Fix leader sampling inserting additional
 samples
Message-ID: <Zrp1vxhQMOSoBQnZ@x1>
References: <20240729220620.2957754-1-irogers@google.com>
 <ZqqAkcz4xOto_sK5@google.com>
 <CAP-5=fXN4y++hD-TzVToobrmH73V_h1fbGq+DuZxmgi=jF5NWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXN4y++hD-TzVToobrmH73V_h1fbGq+DuZxmgi=jF5NWQ@mail.gmail.com>

On Mon, Aug 12, 2024 at 01:37:36PM -0700, Ian Rogers wrote:
> On Wed, Jul 31, 2024 at 11:21 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > This behavior is incorrect as in the case above perf inject should
> > > have done nothing. Fix this behavior by disabling separating samples
> > > for a tool that requests it. Only request this for `perf inject` so as
> > > to not affect other perf tools. With the patch and the test above
> > > there are no differences between the orig.txt and new.txt.

> > > Fixes: e4caec0d1af3 ("perf evsel: Add PERF_SAMPLE_READ sample related processing")
> > > Signed-off-by: Ian Rogers <irogers@google.com>

> > Acked-by: Namhyung Kim <namhyung@kernel.org>

> Ping.

Thanks, applied to perf-tools-next,

- Arnaldo
