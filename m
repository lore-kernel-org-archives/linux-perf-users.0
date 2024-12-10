Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E587523ED5A;
	Tue, 10 Dec 2024 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860885; cv=none; b=BSPVBqrtYyNcZuB1D2XW2o/Bq0+JuQu5Y9EIQc7hbPfBwWPRkiEOohwwONuo8Uo6f93t3ZvCInMwS4TNtGk20ePfTulVXNO5a/PhmIk1P6SW/s+pAuXSKCv7aohadsrVEcJiYk4oWTRbU8hggiYs2amihEpNpkOmvhPPU+2BhSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860885; c=relaxed/simple;
	bh=WKyTv58AqXYbXuKoBaXnVQPqw9lNxzSXEzGjTbzx6Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMrpsvHvMYIqXy4/78KrqwUES3mCXZptWNBplRnnyTpSpLaqgEM2A8kBSLAvpKmTeaj8Zm3Kn2CbCUhUcUXC6ci+zTphRkHH8rlOuupBPR749gSgp0HhOCZHbsUZ2qy/YoVH2vXo/qtEKxqgbt+VHc4RuDrkDl8AiMTKRPqIKY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POnaKq2W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POnaKq2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0166AC4CEE0;
	Tue, 10 Dec 2024 20:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733860884;
	bh=WKyTv58AqXYbXuKoBaXnVQPqw9lNxzSXEzGjTbzx6Jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=POnaKq2Wz/3Q+YvozF2Psn0nHOr1LObKHh6LUqtOUCtVvltoPMTc4NvYh9cKgth+E
	 o4jlXuNG8EqOGSDJzhtI+0YcGdzoBSjqSr7w5rUu4qeJ7ega0nDoOmG5gR0Q9JRlXZ
	 HBbaU0ql1KIDauSdTpKs1vIAbLs/WEct2/1CQ5Rj3fHdiJ6YoBNhHHYGqmQ/T6lCBW
	 CRG3gW1HOhao9yYfGWxIn3SxqWu1XjJJnB42T+rM3x7Ao2uEZ768HnYfeaeeis5BGs
	 D4Cwnr84IIHFW6orT1VHVFACSUukmxE9+tH2BKtCsQe8uRaIlI/nKgWxtw4M8GeF3e
	 U6nI6wDuK9cqg==
Date: Tue, 10 Dec 2024 17:01:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Sandipan Das <sandipan.das@amd.com>, Xu Yang <xu.yang_2@nxp.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf jevents: Fix build issue in '*/' in event
 descriptions
Message-ID: <Z1ieEX22EyS-v36o@x1>
References: <20241113165558.628856-1-irogers@google.com>
 <CAP-5=fWK-eeDEvE4+LeeScbHFecmc5+H8WB_5fepfrJJLZsF0Q@mail.gmail.com>
 <Z1dS6HrfkVS4OeZz@x1>
 <CAP-5=fUze9j8etq-17L0dWVoYfE-bA+61wrEAXN9vJSCj9dCbw@mail.gmail.com>
 <Z1g-8ggHQ8MoVNhx@x1>
 <Z1iTtJcMMsuwI0JX@x1>
 <CAP-5=fXN-KaVnyciw-YBauS=QSWfi36Aan9eGu1xFV57MDcnNA@mail.gmail.com>
 <Z1idV3K4RxLdMhT_@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1idV3K4RxLdMhT_@x1>

On Tue, Dec 10, 2024 at 04:58:19PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Dec 10, 2024 at 11:24:28AM -0800, Ian Rogers wrote:
> > On Tue, Dec 10, 2024 at 11:17 AM Arnaldo Carvalho de Melo
> > > On Tue, Dec 10, 2024 at 10:15:30AM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Probably best to have big patches via perf-tools-next at this point in
> > > > time.
> > >
> > > I'm seeing this after applying:
> > >
> > > /home/acme/git/perf-tools-next/tools/perf/pmu-events/jevents.py:434: SyntaxWarning: invalid escape sequence '\*'
> > >   return s.replace('*/', '\*\/')
> > 
> > It likely needs to be:
> > ```
> > return s.replace('*/', r'\*\/')
> > ```
> > note the r. Could you test for me?
> 
> Sure.

Yeah, no more warning, thanks, fixed it up.

- Arnaldo
