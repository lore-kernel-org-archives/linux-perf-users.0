Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467326;
	b=VaFPQh0YARGIRwA/FUcJseNX3z/DymwqNYDgoULocSbJ5WohbbAjpKqy6JXVOXUyoZRi
	 mm/7RI1NuEdamx7paFAvu1b6OuOVryQQRonXmDYAMANT5KquM53qZTKN8x3n/+JRspArt
	 uA4jKvZdEB198yjhaH5OeUgk7okJwC0Z/eIfBNY31tFFe1/2Wz+DQUcXHV/gsL3hOOcGL
	 wQSM8uCeRjX2Br+5mgFGCgR2LSaZU5Us/5fjOc9Uo5qmMdmFRJ3piwkYKIzq6KwoeDfmn
	 7OfhgE0SQ0lIMFm1Dr9EoDTbOzkpDbAllJk+/UyOOlbrx9fCDq0DxHPVy49emRDHeuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467326;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xOnoRmEigNaegkFULd649iKomOHecvpRX+b4jS7mEEY=;
	b=IdD/yhpykfBqL/EZRWQuwexg5Sv1M8hTczbHXHI3XMjdw0f8pcvMX6MvTnojwb8ha+O4
	 I+B1Tu9OyXRNlicWD0dqwg88bhlhlrHft37dDtpaCzh5ns6pGHWNi4d6nvX0zMCL+nUaA
	 X8ArIT0s+rOf9vd24JOINPp9EB2YAV14wmJoA+ZBc+raJCyXvDFRburgvjEuTjWkVjlKO
	 DHN54vF1PDwoEbXq+fvGo3cy9e3kXFvH0ZJuHepT0C7l8kkwz+2p89b7ymXrOAzyrYGxV
	 pBiqiEBSP/n4QVOD8a3b5sokpmKu16YzDu0NA3LpVnH+ImlMyWpEma+JdMjbO6c+HcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9P8eD69;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252F3606A321;
	Thu, 12 Nov 2026 07:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9P8eD69
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720E01F00A05;
	Thu, 12 Nov 2026 07:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794467326;
	bh=xOnoRmEigNaegkFULd649iKomOHecvpRX+b4jS7mEEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V9P8eD69Mx2G8ddiwKLU3jdDtFrkSITBq6AcNA5t+y/LqA9yDap///bfXzp5hhmAo
	 iUTri9tdKOr1AaXrviQkD1AHLHwCvzpIJwRuNjqbUWqHQUQW6GUGqI+BjU0f84u0df
	 k+65uTjDlI/unJWXWOSBYWzHVNe7x6FtJEoB6pKUgkpIdd//i+vZpovCqlFPCcEChn
	 jJRRjULuSLKZP0vjd6dcuu5KMLbU5Lx6UKi/AvSsU19+8k9XKcE/Ys9vBHDy3Zk2vs
	 WWJKTlTxzf14Q7wckV23RJfN+L0CWWZ2Zl55p1eS+i/8ydjwO9HHSNhaqBrOBd5slq
	 wkm6rQtAHWMzA==
Date: Wed, 11 Nov 2026 23:08:44 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, bvanassche@acm.org,
	elver@google.com, james.clark@linaro.org, jolsa@kernel.org,
	justinstitt@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev,
	mingo@redhat.com, morbo@google.com, nathan@kernel.org,
	ndesaulniers@google.com, peterz@infradead.org
Subject: Re: [PATCH v12 16/20] perf intel-tpebs: Use DEFINE_MUTEX for
 tpebs_mtx
Message-ID: <avVl_JNcFqq7sZvd@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-17-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111174213.3526604-17-irogers@google.com>

On Wed, Nov 11, 2026 at 09:42:08AM -0800, Ian Rogers wrote:
> Replace tpebs_mtx_get() and its pthread_once() initialization helper
> tpebs_init() with DEFINE_MUTEX(tpebs_mtx) and static initializers for
> control_fd and ack_fd.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/intel-tpebs.c | 91 +++++++++++++++--------------------
>  1 file changed, 38 insertions(+), 53 deletions(-)
> 
> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> index 5cb090b27fbd..2edd8297fa1b 100644
> --- a/tools/perf/util/intel-tpebs.c
> +++ b/tools/perf/util/intel-tpebs.c
> @@ -38,12 +38,12 @@
>  
>  bool tpebs_recording;
>  enum tpebs_mode tpebs_mode;
> +static DEFINE_MUTEX(tpebs_mtx);
>  static LIST_HEAD(tpebs_results);
>  static pthread_t tpebs_reader_thread;
>  static struct child_process tpebs_cmd;
> -static int control_fd[2], ack_fd[2];
> -static struct mutex tpebs_mtx;
>  static struct cond tpebs_cmd_cond = { .cond = PTHREAD_COND_INITIALIZER };
> +static int control_fd[2] = { -1, -1 }, ack_fd[2] = { -1, -1 };

Nit: I think it's better to split the line when they have initializers.

Thanks,
Namhyung


>  static bool tpebs_stopping;
>  static bool tpebs_enabled;
>  static bool tpebs_cmd_in_flight;
