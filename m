Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18251203707;
	Wed,  8 Jan 2025 20:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736368307; cv=none; b=b7tgXPM9r0VHFrt0hjqali7hffKtp3ujKuIwUXv6uwbhvywR2rPa4Y4ILHO3QgknSb3a4lhgByAMLZ8grPLPQ3JDh7fuFw6+oHEHglIPiEsTlH5aXfR7Qg4gXUbYhfZTI17pvlDzni0OJHvMl6a++2JA4aWdj/Syn8H9qopL6MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736368307; c=relaxed/simple;
	bh=b29+CF/PEz/b1hsWXXJGiMw8nBb5RF/311tTzXLN0JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWeXHDayf7N3WU/K9nr/W9QNAsvH+KhkTipFRskr1f4mH1RU3XdirXaWLUpYAlzOoAegHDGEksEVK80p5Ayv7GlE6E3QRyX3X2+eRwexe0EF3ygqPtXoR6TTSh1Ua8f1IJJYOyHGmTrnnN/FEi2btbhcFi5fACdzR/+XaxGfA74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5WYarDd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5WYarDd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F2CC4CED3;
	Wed,  8 Jan 2025 20:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736368306;
	bh=b29+CF/PEz/b1hsWXXJGiMw8nBb5RF/311tTzXLN0JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V5WYarDdeFWEAEde2Sexunsqtq+GuQ3Qy+qK04r64kXZOH8rSA7eti6eyeLmfiFfB
	 Bki/SYuapvcligSS6YWbNNkjpQGtyKey4rSl7wS3VX5YBVDeVJCKRkPpkL160OxtJT
	 DqQq2+1hRZe1vWiYjjedBg+YMtAXSeqE0p1SsKuzRwwAyrgLrwI7WMDYTVItxucMpr
	 esXdCjWrMFQuqBuoP9X6rQ/Azoy6Tql7XKWdRK5LEvkPWvNQV39LWX3yYXXO4vJGQ8
	 0HPoKvLdvwoh/ReZ50+8y1RdmI4zvKOprjjw7yv6zr+pkIJfBm+OIPIWbYwZASi0fi
	 bRpqJ+Qq4BOXA==
Date: Wed, 8 Jan 2025 17:31:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephane Eranian <eranian@google.com>,
	Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>
Cc: Francesco Nigro <fnigro@redhat.com>, Ilan Green <igreen@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 0/5 v1] Processing java JIT dumps from containers
Message-ID: <Z37gr-4tS5SFhFHi@x1>
References: <20241206204828.507527-1-acme@kernel.org>
 <Z2m_VVM-vXGVor_z@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2m_VVM-vXGVor_z@x1>

On Mon, Dec 23, 2024 at 04:51:49PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Dec 06, 2024 at 05:48:23PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
 > Hi,
> > 
> > 	This is trying to move the needle on supporting jitdump done
> > from a container while perf is running from the outside, that is not
> > working right now.
> > 
> > 	I tried to collect as much details on what is being done in the
> > commit logs to document further work that needs to be done to support
> > such a scenario in a streamlined way, but what in this patchkit at least
> > helped in a real case, allowing us to get 'perf annotate' to work and
> > confirm suspicions.
> 
> I'm going to apply this to perf-tools-next, please holler if you
> disagree.

Applied.

- Arnaldo
