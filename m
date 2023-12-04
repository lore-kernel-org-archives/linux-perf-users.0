Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F21230CFB
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4O3MZ4z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54494C433C8;
	Mon,  4 Dec 2023 20:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701721025;
	bh=0UrX2iBVuIergkZq8gZnOx8mwnXEDjVYpx4+esY98GU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f4O3MZ4z0dRtwiB0/ZvjjwMFvPnFXrN6dAEeKSDBJ3T0hTbOmn184Vs9B3YZNRCV1
	 5RiEt6BWASfQvlyx0qJsX7J1SlR1EYqdpx7bKoVBB+pYzN491YUiBSSTs3shyCfDp4
	 qfE2JzPjGUW4lzU/3gpLPhK8jLk8E+uIz0yqALstD6OwCgyAN5vpLSP0MXlP1trO4q
	 vVklbt2/xkhTpJZiAGsMdPlmP96CgtRrJgW2nVPm79LxuxU0/734pnIWcPciyDR9Tj
	 h0SCgDjyEaAC11WRizXjiQjQcq0XfVDAlOxhi0dkSgEFJPAj7fvG7ZfYye8lU5ghzq
	 QRJTZz9Yi3I3w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id A0C9F40094; Mon,  4 Dec 2023 17:17:02 -0300 (-03)
Date: Mon, 4 Dec 2023 17:17:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, mingo@redhat.com,
	peterz@infradead.org, mark.rutland@arm.com, namhyung@kernel.org,
	jolsa@kernel.org, adrian.hunter@intel.com, ravi.bangoria@amd.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Ammy Yi <ammy.yi@intel.com>
Subject: Re: [PATCH] perf mem: Fix perf mem error on hybrid
Message-ID: <ZW4zvk2ZUnLuFgFK@kernel.org>
References: <20231128203940.3964287-1-kan.liang@linux.intel.com>
 <CAP-5=fUdEgnwk_FNHb-Ju3wCYE2PLLrPHqwZoyBGyURXQhBeSA@mail.gmail.com>
 <083bfe11-6f6e-487f-ac28-aec22e6b6b06@linux.intel.com>
 <CAP-5=fXTYX6_QdR4RCBu9yh+k1VwhsTjabKdseVP9Cvi6PE=sA@mail.gmail.com>
 <f5112f5e-c77c-4a9a-ac3b-66772adba471@linux.intel.com>
 <CAP-5=fU6EXenN9uU1DZ3X=L+k6Y-4a-XESfY9gL9ZCowhSazWA@mail.gmail.com>
 <afefab15-cffc-4345-9cf4-c6a4128d4d9c@linux.intel.com>
 <CAP-5=fW=b7KmiJKgFOxWd4ayG9A+f4E6QuTKCV0bZmf=SWSQ4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW=b7KmiJKgFOxWd4ayG9A+f4E6QuTKCV0bZmf=SWSQ4Q@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Fri, Dec 01, 2023 at 06:08:13PM -0800, Ian Rogers escreveu:
> On Fri, Dec 1, 2023 at 1:43 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> > On 2023-11-30 3:36 p.m., Ian Rogers wrote:
> > > On Wed, Nov 29, 2023 at 1:15 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> > > Anyway, if you don't feel like the refactor we can move forward with
> > > this or a v2, let me know.

> > I think the refactor is doable. I will work on it next week.
> > But I think it should be on top of this fix.
> > If you are OK with the fix, I think it's better to have it merged first.
> > So everything would work properly. The validation work will not be blocked.
> > Then I can send a patch set to cleanup the perf mem events separately.
 
> Thanks Kan.
 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next.

- Arnaldo

