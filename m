Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE0725B66D;
	Tue, 20 May 2025 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747769939; cv=none; b=QKA3dBf1J0phubxoO/4yUkSkBLk4RZM6Tn2FleKHlk8jZv2CkjxkbS4sUKuHOUyd1+/5k2vUY9/jjpukN76HLip0w0pFbe3kBFna9jofE24+/O4haObwTwXUfA/Kr3kBS83iGNWPLQZB+AINSsF5opvSrTLcAFzdh2rZ6aAcYic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747769939; c=relaxed/simple;
	bh=hvfz3f70a+l77rLPSk8ZwDyqvzU4xNGTCHx63U5c1VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEogvaiUaZzYO7PKHgdcT1B2FilqW7kUI6y7KyzhffEMY1Q0Lbrtcpj0vGYM+N7LmvPsSzVd5n1fYWvhyH4HTPwegWlLA1R71aKRlvwkCMmeru2DgW0QJdZ8oI9ByQdyMObQN452uWE6gbzo11ONWUTPapT64zOEWc7fseWT6Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJPCb4mT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJPCb4mT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB498C4CEE9;
	Tue, 20 May 2025 19:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747769938;
	bh=hvfz3f70a+l77rLPSk8ZwDyqvzU4xNGTCHx63U5c1VM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJPCb4mTDOL7sAWboKmCyamIkKMFR2ns+d0zmwPz8i0OFmGhMjoUkmwH3M0ojUVmK
	 EiDDg4Mh6yHKZymNDW0ZjSx5mHypyCRXmu/F1QVPqa2CDLPNPPdGFCp23zFNtgPyQR
	 9J5W3+zXzvRJqG1zLSXjv+Mi0JQ5Dgoc0j9wmlqTUh/HTuw2EM4F2nbYcAdX0grawl
	 CL7S28i1jZhn5jhD/oisS09mpebX0ISJ3WABSWYSVRa1cItMThBElyGKExjR0OgGCc
	 HlL5y1QAJj5b9tPPw8blsE3jTV6xxGaA7pE5G1sUOzb3smThkFUnjAbPXsrSjlmp+K
	 n2/uJDOkyZsUw==
Date: Tue, 20 May 2025 16:38:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	I Hsin Cheng <richard120310@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Peng Jiang <jiang.peng9@zte.com.cn>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH FYI 0/7] Updating some kernel headers with the kernel
 sources
Message-ID: <aCzaTQJ9vwjjc22V@x1>
References: <20250519214126.1652491-1-acme@kernel.org>
 <CAMZ6RqJUf=LpczMNu9WwLik9i-4tJHYENvM3d15nxjNM+_vc5w@mail.gmail.com>
 <aCylQUlY3W7rbZAs@x1>
 <5b83c1b3-6370-4df1-8a57-7940d7a629fd@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b83c1b3-6370-4df1-8a57-7940d7a629fd@wanadoo.fr>

On Wed, May 21, 2025 at 01:02:49AM +0900, Vincent Mailhol wrote:
> On 21/05/2025 at 00:52, Arnaldo Carvalho de Melo wrote:
> > On Tue, May 20, 2025 at 09:44:05AM +0900, Vincent Mailhol wrote:
> >> On Tue. 20 May 2025 at 06:41, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> (...)
> 
> > I think there is value in doing it now, as it clears up the build
> > warnings and solves already one prep work that syncing would entail,
> > namely the inclusion of const_true() in the tools compiler.h file.
> 
> Ack.
> 
> > I think I can take your "I am not objecting to this series in any way."
> > as an Acked-by?
> 
> Sure. You can add my Acked-by to patch 6 and 7 (the ones in which you put me in
> CC). I did not have a look at the other ones (and do not plan to do so).

Thanks, just did it,

- Arnaldo
