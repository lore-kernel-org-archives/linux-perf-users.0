Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0B618E030;
	Tue,  3 Sep 2024 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725389188; cv=none; b=obgYJKMek9gQ73HTyvz2oe1k6aPKPOjiY6eZLAmiEhls2cRhSo5HbODh5Z5TEc8e3eJT0GFDqFx3Mo+CohKAkC+7Aoj0RD7woUenzniWDHNdV7qfw+0dw+3bPB3nLAfeVnuByuzfp6gEQUvWlMz5NN2ZBthr+qyb2ufKeB6pE/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725389188; c=relaxed/simple;
	bh=tI528c0Xm0NDXWUVoq5ggvY7QfFEOJKeDW04OW5LyAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h24Rptw81O+tUOP4CW6wFSw0VOOviRDvDuEXbVX+8dZ0F+JvemzJBsvSsGkqZxfsqYTNK4hGsTFqFCiHe07JuwGH7X13vJuymvTsvLqndanXRGHVUXZzpWgnTixD5jyu4O5lnt+BjT1PA9kJ0XRrpN47plF/krjc6K13AvCyWsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F815zm/V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F815zm/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9223C4CEC4;
	Tue,  3 Sep 2024 18:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725389188;
	bh=tI528c0Xm0NDXWUVoq5ggvY7QfFEOJKeDW04OW5LyAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F815zm/VpCJ0wxjqGm9bcMqbvAJF+MsV07QTPV97f7WIvV23WfNp4dfgIJu4mrQVd
	 qjSsd8XMcf789ndMUjZPcYZrUcVI2tGjtUdbJV3z9H7+uH+FqSodHuihAeSknTcajK
	 fXgezMStElA3VRO1XirXRVvxGbTUq/l6kC0kRA96kdzFBO5LEVsZsg1x0Wprm4rRR0
	 0BujYIfYtSVqktYHHAUrDZoie1NJNcQYnG1WvwgocXsjkYydMXILYPKrcmFcsNlGLF
	 dwEsW+a7bm2alAvYnFZEDhISfV7EvQgYbEn8cRmYM4VQOY1OI2jgedv8DamFo8NrEs
	 TvV9jjMaR+YWA==
Date: Tue, 3 Sep 2024 15:46:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Yang Jihong <yangjihong@bytedance.com>, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf sched timehist: Add --show-prio & --prio
 option
Message-ID: <ZtdZfxSx09lF5MyG@x1>
References: <20240819033016.2427235-1-yangjihong@bytedance.com>
 <CAM9d7cjAVXAqDrT72vjpZvfccaGAZnw_jie5Qz5yX5vSfVWRMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjAVXAqDrT72vjpZvfccaGAZnw_jie5Qz5yX5vSfVWRMw@mail.gmail.com>

On Mon, Aug 19, 2024 at 01:13:43PM -0700, Namhyung Kim wrote:
> On Sun, Aug 18, 2024 at 8:30 PM Yang Jihong <yangjihong@bytedance.com> wrote:
> >
> > This patch set adds --show-prio and --prio to show and filter task priorities.
> > Sometimes may only be interested in the scheduling of certain tasks
> > (such as RT tasks). Support for analyzing events of tasks with given priority(ies)
> > only.
> >
> > Both options are disabled by default, consistent with the original behavior.
> >
> > Changes since v1:
> >  - Rebase based on the latest perf-tools-next branch.
> >  - Enhance documentation's --prio entry, add a description of how to use multiple priorities. (suggested-by Namhyung)
> >
> > Yang Jihong (2):
> >   perf sched timehist: Add --show-prio option
> >   perf sched timehist: Add --prio option
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo
