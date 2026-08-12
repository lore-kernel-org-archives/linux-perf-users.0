Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE79346774;
	Wed, 12 Aug 2026 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555212; cv=none; b=PLKeZQ9FNJM9kXOgC0ji+erxe+ZlC8kGV6vd0nPCMJ4DIk9bMB7VZdUXuNDVCBU4OJ2ngUA7U02Q/VdUAs96mFoTPNZ9ZhS4B28sYcr4nMLTYTESIh5/Ao8sIfkK2JmZPSPgN29DXqYjZrP/PLTuiCtCRA9g/ieOcnw/7EjKQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555212; c=relaxed/simple;
	bh=W+JOhUKlk+DaudLiWbcKaAiRpxSWivdty4F3egEz6V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VN9AaMlfd5i7BylrJ8yfsQPKm9pJQm1oZAhgrvA6OyRiynYfNo+G+j+FNi/IRpMcu0CJBCKU7hIeQ5cIVdGJt5rLQbsvRzywJoX62zs9C/9GAKyHjZ5jbO0Nl8cfSUqDvmhLymQno4F9Y04rIz4Nxh6tVqimVuZli8GRr2MVyFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUdVCkTj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUdVCkTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797E11F00A3A;
	Wed, 12 Aug 2026 17:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555211;
	bh=N2sTjqCjgxnIh1EcQaCNKzs3CBC+V7Uq57mWQ+/VIbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AUdVCkTj7Az4UuHqEbbRK6A7tgLabI664eboIiqnImmeaYJvb1sVp1j/vRkuLLdrc
	 gYm7QurMN5iSOe/6uJqfg0pDw27sChXIUUWN4LSo+5ggTkx+AAChoy0Gl7B9Gh0ePK
	 1jZcW2JgqKVhaBjc6ra0j7JFv65GCN12V9kk4ORGCGZXB+JtzKE383a2HLzSuekBuj
	 pE3I7au3LyjoAuJ+oh6tBuLs0hPNGfQrR1jiLoMRSjvOhrxfPcKG8mD5T9c3KXeEuL
	 eHGvq7oNZgtii8lnV8/RIDnp2p7tP9wh2Mgx2pnEk1OCFk504QX5KotpbBd2SMUsJp
	 KkicnngK3Aa0A==
Date: Wed, 12 Aug 2026 14:20:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCHES v9 0/7] perf build: Add target to install devel
 packages needed to build perf
Message-ID: <anyrSMrYWJz-TpBE@x1>
References: <20260811182900.27063-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811182900.27063-1-acme@kernel.org>

On Tue, Aug 11, 2026 at 03:28:53PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> This series adds a 'make -C tools/perf install-build-deps' target that
> installs the development packages needed to build perf on Fedora, Ubuntu,
> Debian, and RHEL family distributions.

This is sashiko clean now, if there are no further human reviews can we
have this merged?

https://sashiko.dev/#/patchset/20260811182900.27063-1-acme%40kernel.org

Best regards,

- Arnaldo
