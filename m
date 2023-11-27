Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDC431739
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0VNXQBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00C3C433C9;
	Mon, 27 Nov 2023 14:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701096186;
	bh=Mpooaxd6qlzBPGhMTWc6TBoY3fAhwP8179zOVmhHZc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C0VNXQBwfae+zomFI11MW8jQNo54Ite29pj5VueZhibOsECkW6sXOwK6tXfRNQP39
	 +IANnpFjvNm7rfjHrm5isjxt0alRAe6nU/iHbwgglaLhKcvRfsc0+SG/ZiQlfwrC4k
	 uFJ93bmvs3WS7htUoE6m0HcGEJ++rLv62oBk9t5FENgZX4ynbmk2ALPVALcsQzL4KY
	 IydyWZQQ0ULedy1YINLzCUgNShE96xrcq7pjdmJFBqGtqCOEk134V4yq3V7rIFZ4HR
	 XWN03DeJB7jFFCfE/lXbBs13/O9H67frXJCL6GhMO1QQnFIFKPYhp3xupFRFTwEIyP
	 4ZZYC5W77KIcg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 8094940094; Mon, 27 Nov 2023 11:43:03 -0300 (-03)
Date: Mon, 27 Nov 2023 11:43:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Nick Forrington <nick.forrington@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 2/2] perf lock info: Enforce exactly one of --map and
 --thread
Message-ID: <ZWSq96mWUpLuGh0L@kernel.org>
References: <20231031120526.11502-1-nick.forrington@arm.com>
 <20231031120526.11502-3-nick.forrington@arm.com>
 <ZUEfXU34ZijKe8aA@kernel.org>
 <3ae2cf90-b0a1-5f54-56aa-ed4a04dca8b0@arm.com>
 <CAM9d7cjQs0BrFAMa4=PGxxPBoGOAVzermH=0HrA1rhegmAA8zg@mail.gmail.com>
 <ZUvvXhkY+NcSxaJU@kernel.org>
 <df428c93-e3b8-c60c-001f-2228845983cf@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df428c93-e3b8-c60c-001f-2228845983cf@arm.com>
X-Url: http://acmel.wordpress.com

Em Mon, Nov 13, 2023 at 11:50:16AM +0000, Nick Forrington escreveu:
> On 08/11/2023 20:28, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Nov 01, 2023 at 11:00:42PM -0700, Namhyung Kim escreveu:
> > > On Wed, Nov 1, 2023 at 7:35 AM Nick Forrington <nick.forrington@arm.com> wrote:
> > > > On 31/10/2023 15:38, Arnaldo Carvalho de Melo wrote:
> > > > > Em Tue, Oct 31, 2023 at 12:05:25PM +0000, Nick Forrington escreveu:
> > > > > > Improve error reporting for command line arguments.
> > > > > > Display error/usage if neither --map or --thread are specified (rather
> > > > > > than a non user-friendly error "Unknown type of information").
> > > > > > Display error/usage if both --map and --thread are specified (rather
> > > > > > than ignoring "--map" and displaying only thread information).
> > > > > Shouldn't one of them be the default so that we type less for the most
> > > > > common usage?
> > > > There isn't an obvious choice (to me) for which would be the default.
> > > > Both options display completely different data/outputs, so I think it
> > > > makes sense to be explicit about which data is requested.
> > > Maybe we can default to display both. :)
> > Yeah, that would be a better approach, I think.
 
> I'll submit an updated series for this, with the next update to patch 1/2
 
Thanks, tried using b4 but it din't find a v2, will wait then.

- Arnaldo
