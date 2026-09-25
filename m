Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D204D9565;
	Fri, 25 Sep 2026 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351932; cv=none; b=hyiuBkIhcF5eeyrmi/HEjLliMI93LQVVCLJkXdnCPv9Fb2MIZKktU3IRPDQhcqI7xRPM5sSELsaHx9d3mqbp1eL1at8/fzK5mkEEDV7Qd5fxgqirhTuUd4eR1an+f0tmZY4H9BzQuyo5WHl9q5wprGQqG3ZBDsB59LiLPIs1U+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351932; c=relaxed/simple;
	bh=WydZ2Zc55QQttrkrVXrRDgs8rIJ6ASU1aGCO9JVSA64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhk01l6qnyZVkqwqgh+NTBWkc44BR8XcdfIy8dIA6eDSsjWoGrUDuSDej/6pF0avgVJiWTpLA5cknaGSgESyETbj2qvdcifvKznP3EZsZ34GTDTSKgRLiW6ElzsdBOBE8714/sy0TRu3zRCYW9kWqEftTLuj5RGZoBXS1Kgf9Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoRgSEDc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoRgSEDc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C231F000FF;
	Fri, 25 Sep 2026 15:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790351930;
	bh=d8oMKv5Oaum11/qJhCh0Qp6N1SicG0suQtEpxSVI8/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SoRgSEDc3ktxsYbCP1Tlq8BK4PjIZjuv6KQ5M1uQDiaChljKzVcPWMsSiPsJw9oLu
	 /8aG56K0LKpA4Omx56acJJDnhcJeLDbMmbON+8dVovIiaeK9cq1TLxLMETSuuJzXYx
	 +eu0u7JSqGRIn+EHnLxgcWLyK5AHIopSNqiqPjpfVOpgr5c+ZddS4qDcF/zWyDZOpi
	 6q5tWPChqFmiwgfa5Z3QJoSDL8ybBLxHpLTH8nPhcQ3VsHJmeP634ajzRprKOO1fba
	 D5+Rdaj/mZ+g+dT6e1fqNUn6jvzSPG839obrT+tzAXlpDsDqTDTHo6//Zxh75sd+gZ
	 YsfSJEcVRNqRw==
Date: Fri, 25 Sep 2026 17:58:46 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v5 0/6] perf annotate-data: Fix hangs on broken debug
 info, AMD mem record
Message-ID: <araaNhLrRM4K4hs0@x2>
References: <20260925150657.1826942-1-acme@kernel.org>
 <araXPQChZ9HHNFzY@z2>
 <araX1vz6-Vo9v1I1@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <araX1vz6-Vo9v1I1@x2>

On Fri, Sep 25, 2026 at 05:48:38PM +0200, Arnaldo Carvalho de Melo wrote:
> On Fri, Sep 25, 2026 at 08:46:05AM -0700, Namhyung Kim wrote:
> > On Fri, Sep 25, 2026 at 05:06:51PM +0200, Arnaldo Carvalho de Melo wrote:
> > > This originated in another patch series, 'perf tools: Annotate fixes,
> > > stdio progress indication, debuginfo-client in more places', and is
> > > being split off so that these fixes can be reviewed right away; the
> > > debuginfod download feature work from it will come later, separately,
> > > based on this series.
<SNIP>
> > I have a nitpick on the patch 4, but otherwise looks good to me.

> > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
 
> I'm fixing that one, thanks for reviewing!

Fixed.

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
