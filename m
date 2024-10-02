Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90151D150D;
	Wed,  2 Oct 2024 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890196; cv=none; b=KZktDU/9S/mv29ekuAG8AVDr9fSOuuaCaLxVyz5Aucz+NSVl9Cmi44ISSANw+VAANjZ/MGQ2YhTB7A/GDGTYH8GIP6TDlGNd5z0Eg2wlZfHUgVlvmETrKTN+i44UEbChra80uxhokh9d8HSdD21mV0yKEgqkhVQN4i7QRa/GoT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890196; c=relaxed/simple;
	bh=1tEUJVx1sDty55VLdaRSVXZb3SyfKZ7rXbiK8C7VMuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdI+Ex9/6Db7bGjBdrUJXdO6T4ZMbRor8mDypNkS4q0Owf6dbgbtFnX3rpTbMvFCYxJMarMHUnAILRgn+CwKGjJZcuyh222WVGhuXdPSurr18PnQ1HC4trfqE05RY/rVk3aqZDMmnNB6w5Y4mRKy48SxQa9p7KTN8sAbWKmF4as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGaLw581; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGaLw581"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E51C4CEC2;
	Wed,  2 Oct 2024 17:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727890196;
	bh=1tEUJVx1sDty55VLdaRSVXZb3SyfKZ7rXbiK8C7VMuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cGaLw581lMYnYGzDhV7vic2yC7KZ58lSuQD/Dj7f0BZNuSaUb/sa5841DIxXuvENH
	 KHTt6LQoC/pmnDVopHuEqvudZgfY7vSLN+UsttWbD3O/MQ3rWjvyOVHMnnxRgXySxX
	 cyF3vOEiMU5IYvWaf+tWVZxXdfCZsyvCgt507o0YkSwcOL2vbY7qGTqp6SlYkuLxjg
	 8u805O03ntDkM8rxSigdiJ+o55bbNCODQM7GUkdK/bub9dsZXeCvFjB+tnjnaMWP2n
	 hEWYJHG8L7ADsR8sKhqZjOpJRr0cHNUWC08r2iwKgNfr8OFlSndftuARkmLE/Zkb6L
	 qIbqj/FGQlKBQ==
Date: Wed, 2 Oct 2024 14:29:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] check_headers.sh with hunk exceptions
 (lib/list_sort.c tools/ copy)
Message-ID: <Zv2DEHipdoUoeyp-@x1>
References: <20240930202136.16904-1-acme@kernel.org>
 <Zv2A/npbGyP2SlKV@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv2A/npbGyP2SlKV@visitorckw-System-Product-Name>

On Thu, Oct 03, 2024 at 01:21:02AM +0800, Kuan-Wei Chiu wrote:
> On Mon, Sep 30, 2024 at 05:21:34PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 	Please take a look, as per tools/include/uapi/README we carry
> > copies of kernel files for various reasons and check when it drifts, in
> > this case we need another way to accept diffs while checking, its all
> > spelled out in the individual patches, please ack.

> > Arnaldo Carvalho de Melo (2):
> >   tools check_headers.sh: Add check variant that excludes some hunks
> >   perf tools: Cope with differences for lib/list_sort.c copy from the kernel

> LGTM. For the series:
 
> Acked-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Adding it to that cset before pushing to the written in stone
perf-tools/perf-tools branch.
 
> While reviewing the patches, I noticed that there was already a
> difference between lib/list_sort.c and tools/lib/list_sort.c regarding
> an additional #include <linux/bug.h>. This prompted me to investigate
> the reason for this discrepancy. From what I can see, both files only
> seem to require only three headers:

> #include <linux/compiler.h> /* for likely() macro */
> #include <linux/export.h> /* for EXPORT_SYMBOL() macro */
> #include <linux/list_sort.h> /* for list_sort() and linux/types.h */
 
> I'll check the git history and run build tests to confirm. If only
> these headers are needed, I'll submit a cleanup patch.

tools/ is a sidecar or sorts for the kernel, that tries to add value to
kernel developers while not getting in their way.

Sometimes things we discover while using more widely things that were
designed for use in the kernel source may be of help to kernel
developers, if this is one such case, great!

But IIRC that linux/bug.h discrepancy, without further checking, was
something already somehow accepted via:

+check lib/list_sort.c                '-I "^#include <linux/bug.h>"'

in the cset that introduced the copy:

  92ec3cc94c2cb60d ("tools lib: Adopt list_sort() from the kernel sources")

- Arnaldo
