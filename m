Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F9C17BB17;
	Fri, 30 Aug 2024 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024758; cv=none; b=rT+qrpBXd++Sd/0mJQqiDEbLEyNbMhC+TGVOBXO3ptdM2koj9pBI9E11hTehmV6FlZriJPPTk7tN+1Zr4+eqQf6VGk+eF1ov7FSpc9bHix8n8Z9a7uh22iYToJN/raw8Wgr0UdC3Q/JqsurNAUsi8qCfQ+VM191qqy+x7xDbeHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024758; c=relaxed/simple;
	bh=0hkmyUrgKgnCT1jdQMLQhzZ3cXAJeNIFBAkTsJ5biJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/vtSktzempm27VZH6Kqg6Zs9eiS1T1m32YFhrHh9j20kBpD/Kc4KGeJVdp8jjPyHxawKoParowHQCgOlBUeMV6M88onvLSJRp/iSrkWt+ONRHB+Ps2/2imgDPnebEaL7DFXc5XcJF6yAKG1Csc5bM4tm8de6E7zWjYN9UCNzks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiWgM4MN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiWgM4MN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBED0C4CEC5;
	Fri, 30 Aug 2024 13:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725024758;
	bh=0hkmyUrgKgnCT1jdQMLQhzZ3cXAJeNIFBAkTsJ5biJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kiWgM4MNTosRBmWOdS+mnDenaMdaHuMjFXpUrRb0JSTA7meQWV8+jp3nLOvXlh2bb
	 m7jc5+5pEReuhXb12R+56+tfmgun0JBxZfgSoc9akEQtYR0BqIo6Pj5QcUqriPizPm
	 Ce4BdQtq01bDzCp43Fxbqpn3wcnkonJPAptWtzMjbXLdf5K8kOki0/P0j2IxiDxf2P
	 G4C2QtaGxAQUmLPKv9xRYH/w/+tJaefdvuC0Aw9iN/Juaq6QItSfvh8oaXsljjDH8K
	 KOKptvu3BBUXtbn1lmfCNQvl8w8Xsi0wH/AhXlaLEj9Fsk+F7k2g5quWM81QXDpwgs
	 nZE85aCPxtphQ==
Date: Fri, 30 Aug 2024 10:32:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Yang Jihong <yangjihong@bytedance.com>, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf sched timehist: Fixed timestamp error when
 unable to confirm event sched_in time
Message-ID: <ZtHJ83dtmi16zR9D@x1>
References: <20240819024720.2405244-1-yangjihong@bytedance.com>
 <CAM9d7cjvx2jozQNiSj+Anf1+hsyL7DT17XJWv8oDJUr_4Ud=hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjvx2jozQNiSj+Anf1+hsyL7DT17XJWv8oDJUr_4Ud=hg@mail.gmail.com>

On Mon, Aug 19, 2024 at 01:08:57PM -0700, Namhyung Kim wrote:
> On Sun, Aug 18, 2024 at 7:47 PM Yang Jihong <yangjihong@bytedance.com> wrote:
> > Fixes: 853b74071110 ("perf sched timehist: Add option to specify time window of interest")
> > Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo
