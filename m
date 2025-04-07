Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DB421421A
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744045451; cv=none; b=JxYK2ebHtUh2scPovzvZognaBg8z87aUsnbkc5f1QiL48UCVXWXc5Be0MsMgpSrQ581Bo4HrFCT1SFxyJ3iUWuA0T5yGjmcSrvr0vcC0keCab7UwUtrsVwwpsb7pHFaZjq4kc+8/Jfxdd6Ax4SJ00DAaKeH8YJgcHXHEZ3hmywA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744045451; c=relaxed/simple;
	bh=2/oGmMek5kGMAQl5gYOVqLxqsniDyNCpPAj7JjZcmUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gu0rnhfOucBKXt5lvxFyO3oLQrbhKW0X7StcOUVMATE6KarN+ToPtvPCtHZl6N/1bY/G+sHCM6OKESx1ZoUvXbf1JPhtfBHWqW+87MZufJCQuGUS15NMERcbQlzX6wWkRXzMmxDGPKXRkeeGpmRLnZxNBxOHfSQ7vejhRlcBbyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNfykhnr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNfykhnr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17405C4CEDD;
	Mon,  7 Apr 2025 17:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744045450;
	bh=2/oGmMek5kGMAQl5gYOVqLxqsniDyNCpPAj7JjZcmUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNfykhnr3gwAwvti95l6SWteFLf3jMxyJ6t3fP8hCRXEBNXk/aYdmWVrui3gtgoqZ
	 CQbDt61jT0eDUXSxNZEFmhrWtuljaN/CaZuqWBqYyELsyBM4jpcT3941hareFEfwnP
	 ah3x6Glu0EnnsKj+ZMurNuzEWjjJbOZgKsunGtNzTryGxLNO0VVMEL1evXe+vhvk2I
	 P5WxPeWXfddJn6x8Aw/IiEv8/yuFIcKwYq2Vqhb8+l0nlID6GBL9G2XmiaCohlf6sm
	 ErNKGhnZtKJruxgjihOe27F8myv9/zotTLyiJ+r/CHvKKWC/ZrHyQoxc86WMVulQQ7
	 GnuPUwkrsYSYg==
Date: Mon, 7 Apr 2025 19:04:05 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [perf top] annotation doesn't work, libunwind doesn't seem to be
 working either
Message-ID: <Z_QFhSOIA3vOYpbd@gmail.com>
References: <20250307080829.354947-1-namhyung@kernel.org>
 <Z9tjKcKvjYgbR6hb@google.com>
 <Z9vgt1pjiNbDBDbM@gmail.com>
 <Z9w_aFlzOkoCTSqK@google.com>
 <Z-EJnye74la1triY@gmail.com>
 <Z--pWmTHGb62_83e@gmail.com>
 <CAH0uvoi3oaZesWKLtaJRm3AkJx9j-G_Xm66Z276xH5+k11zisQ@mail.gmail.com>
 <Z_QEND63LoxP0h9H@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_QEND63LoxP0h9H@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> Yet:
> 

BTW., on a side quest, more details about these other dependency error 
messages:

>   Makefile.config:1142: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel

But I have openjdk-8-jdk installed:

  root@starship:~# apt list --installed | grep openjdk-8

  openjdk-8-jdk-headless/oracular-updates,oracular-security,now 8u442-b06~us1-0ubuntu1~24.10 amd64 [installed,automatic]
  openjdk-8-jdk/oracular-updates,oracular-security,now 8u442-b06~us1-0ubuntu1~24.10 amd64 [installed]
  openjdk-8-jre-headless/oracular-updates,oracular-security,now 8u442-b06~us1-0ubuntu1~24.10 amd64 [installed,automatic]
  openjdk-8-jre/oracular-updates,oracular-security,now 8u442-b06~us1-0ubuntu1~24.10 amd64 [installed,automatic]

(and a bunch of other OpenJDK packages.)

> Makefile.config:1155: libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev

This one was resolved by the suggestion:

  apt install libpfm4-dev

(yay!)

Although it would be nice if it was done via the regular feature 
checksL: a red 'OFF' there catches my attention - some random message 
in a 1000 lines long build log doesn't ...

> Makefile.config:1187: libtracefs is missing. Please install libtracefs-dev/libtracefs-devel

This too got resolved by the suggestion offered:

  apt install libtracefs-dev

Same observation to move this to the 'on/OFF' type of detection 
applies.

Thanks,

	Ingo
