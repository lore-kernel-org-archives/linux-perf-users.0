Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3576621420A;
	Tue, 10 Dec 2024 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857416; cv=none; b=QdqNRngm5I+WPZVER0jFFn5eA31uE2wuFVTVA83PvK0LSIkcRhSKpA+FoOOUoJHtLWRtcUfHeVnmg5rPZOqvchslydcjuopG9v30B2jXctdBwvLRPIDuIIUeAPhcRhfIvx6D8A4+prfl940usIZ6WEulTbthFWvq9s/2UQ6UcFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857416; c=relaxed/simple;
	bh=4oezj9P0v6OHDqQy0p+1h+9SQPQBzV2h/aMu3Q3bmic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5vhzcrKzAKrChrKCD/s79CDRaDxCxhkRcQ5ygP+nFczCUp81zKMZ3TwiMWFLCRFUJc/baQXEiThMlnMJafcKzGJ07znAYRjVYmHwF/p4gROaBZqN/WZ1uo7+IJuu7EJ/pCme5q3wxrgJgQ0BcnzGTg5W601SVuyODGsytMKAOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyX2Q84s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyX2Q84s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B3DC4CED6;
	Tue, 10 Dec 2024 19:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733857415;
	bh=4oezj9P0v6OHDqQy0p+1h+9SQPQBzV2h/aMu3Q3bmic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OyX2Q84sxxv/o8t6Ecw64+Drcve06uxDTuLFwceUNZqpXcnxFoQArnN/sMePFmlFg
	 RZhoI3tvY27DVuj8IXIVAINb/ptEep3H4gCMpX3iNFosy2CjRsQUdW7n3lvnzhJs/q
	 vwpwGKG30ld96Q/KzTYQ8sDHXzuCF0Q2ffC31mxBtWJ8zMxBlHz57+8wFEoOSf9BB+
	 Rcpztiuw5k/9hceXShHfZ6qOl7ZCaxdNcTeBGHbEpQT10DPBbyASkwfjGl7otw7S5l
	 0JDlixxvnIJTt0AG4MY7KydjptXKMoIdD+jNq6h2/TIaunveWjaqY09+8V/6usSHl7
	 11YWKXV1AGOvA==
Date: Tue, 10 Dec 2024 16:03:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Kan Liang <kan.liang@linux.intel.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Edward Baker <edward.baker@intel.com>,
	Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH v1 00/22] Intel vendor events and TMA 5.01 metrics
Message-ID: <Z1iQhL4WXFL4Wf27@x1>
References: <20241209222800.296000-1-irogers@google.com>
 <CAP-5=fWr9R74-NbKbW96otG6KitQYaQng4D40Bv4z9ov9yvNJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWr9R74-NbKbW96otG6KitQYaQng4D40Bv4z9ov9yvNJA@mail.gmail.com>

On Mon, Dec 09, 2024 at 04:44:27PM -0800, Ian Rogers wrote:
> On Mon, Dec 9, 2024 at 2:28 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Update the Intel vendor events to the latest.
> > Update the metrics to TMA 5.01.
> > Add Arrowlake support.
> > Add metrics for LNL and GNR.
> > Address IIO uncore issue spotted on EMR, GRR, GNR, SPR and SRF.
> >
> > The perf json was generated using the script:
> > https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> > with the generated json being in:
> > https://github.com/intel/perfmon/tree/main/scripts/perf
> >
> > Thanks to Perry Taylor <perry.taylor@intel.com>, Caleb Biggers
> > <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com> and
> > Weilin Wang <weilin.wang@intel.com> for helping get this patch series
> > together.
> 
> I should have also said, this series requires:
> https://lore.kernel.org/all/20241113165558.628856-1-irogers@google.com/

Applying that one now to perf-tools-next,

Kan, can I have your Acked-by or Reviewed-by?

Thanks,

- Arnaldo
