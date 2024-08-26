Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F951143C70;
	Mon, 26 Aug 2024 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682823; cv=none; b=AIORKEp8so4eBRT+fMdgKwqv1sOXVPLeiQL1N86otaUCQxfOn66+wxaNr1+7cSVG5PU/EhTNapIHrpBZ9j/kzNzteYuUKMAe0GzP0OP4YhXlMuQ8GclKoPxuScqEbiJvWnCHxIOvYXx9btvFq7rTsu4T0MDvq+advt4l2B6Cjto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682823; c=relaxed/simple;
	bh=l/+SPXXc/fG12j/0jauNpuKR04TNoWJBFRvZLUJm+0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soZY8b0hsLQswzouMxS7YZwKqr8pnzyrMRvaCrDjuL7PYAbR3WixiS6Vpqd58L3fnkifognUlX8Q+PpO/8EGshxZbzi/iktks/clIrLp1gRGMT4CDBHqxWbYAcLIvEV7KCHNq5I4AQ0PMHq3oK6MEHu0GkBxuUR9sLh/arAC0tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIe9SSts; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIe9SSts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343D7C4DE04;
	Mon, 26 Aug 2024 14:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724682822;
	bh=l/+SPXXc/fG12j/0jauNpuKR04TNoWJBFRvZLUJm+0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YIe9SStsZbSfCXeirt3V7FcFAFF4cSSyXZ8za/G7QwlQV3y9pR00CJl3esBWj/st3
	 IDLjzzJmpRtHOmeN/L/vfLERZ97jtvb9ve+HZSpOBDsN27qGoZZunDJIZUtAblukBf
	 0xf+bkcwi1zwt1oPwAYNH6oeVL6upQ2H0tuUMwh4TjiGSJ1ykj5itvowMLvGRZwE/Q
	 6cth5bLeS54DHHMtJsDqWUyBdNoMYWNz5Jtr+gIV8VfrrcHXsm6NXYRB20n3m04GPO
	 WMgmI7FR1YfMhF+jm/C2sJlu2VQJli2JlE4UApuhWGxXpbMCbzP0HrfJHaa0aD5ck4
	 /+R3wAFiRv+7g==
Date: Mon, 26 Aug 2024 11:33:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: kan.liang@linux.intel.com, irogers@google.com, peterz@infradead.org,
	mingo@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf hist: Don't set hpp_fmt_value for members in
 --no-group
Message-ID: <ZsySQ9MADfhrABFy@x1>
References: <20240820183202.3174323-1-kan.liang@linux.intel.com>
 <CAM9d7ch1tmkmrpcxdW4Txz20Xzt6NFx_-0m6HQzTwXAV7Opg2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ch1tmkmrpcxdW4Txz20Xzt6NFx_-0m6HQzTwXAV7Opg2Q@mail.gmail.com>

On Wed, Aug 21, 2024 at 05:38:45PM -0700, Namhyung Kim wrote:
> Hi Kan,
> 
> On Tue, Aug 20, 2024 at 11:31 AM <kan.liang@linux.intel.com> wrote:
> >
> > From: Kan Liang <kan.liang@linux.intel.com>
> >
> > Perf crashes as below when applying --no-group
> >
> > perf record -e "{cache-misses,branches"} -b sleep 1
> > perf report --stdio --no-group
> > free(): invalid next size (fast)
> > Aborted (core dumped)
> >
> > In the __hpp__fmt(), only 1 hpp_fmt_value is allocated for the current
> > event when --no-group is applied. However, the current implementation
> > tries to assign the hists from all members to the hpp_fmt_value, which
> > exceeds the allocated memory.
> >
> > Fixes: 8f6071a3dce4 ("perf hist: Simplify __hpp_fmt() using hpp_fmt_data")
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo
