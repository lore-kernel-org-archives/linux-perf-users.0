Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB70035F18C;
	Wed, 18 Mar 2026 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773838590; cv=none; b=Y2eUQj9BH6LvEvRnTfGy6dKlFlvTfCMnIxpkuoQU9iB8cSu43Si1I5gse0DVghmNtm8glYfDoXa8UwujpN5ZI2OVRdLU6QLnCm6UpJURfpskA7W97mY2kBYqEtPDkD7Ld1sB+U59MJRLZPGAaiDYdRyjTk6P7ywwYg4dCjhVo3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773838590; c=relaxed/simple;
	bh=xTkxOfbbA7OEmglbTow6+h2Q9I2EMYnohn7EFiQXT9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buqeYUPgshbA3zCP3XDyNMMrn55r9h81AausZHxjsElSZEMK2kDKjyCRB8mgwKd3NkpUEZ9tX+p6EPdp+JLQesn5jXqWAcOWHu579SGdJtTzEVmV8iH+jBhiUdBgrOTJO0fvplWY+EpwNfcDCIXtSW2X8jr8bSArdgRRPGMXrkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpykgjqM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpykgjqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EEBC19421;
	Wed, 18 Mar 2026 12:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773838590;
	bh=xTkxOfbbA7OEmglbTow6+h2Q9I2EMYnohn7EFiQXT9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NpykgjqM9ua2DOvj631FBbKsHbZPnIlNftfi/jv6r/upOXmrxdx/c6QEQ328u1GGk
	 bqtE9Hn6WiQ1nPtONUUb1aGtBUzQUnvxVzoUEGCrWNZNA4JdOfez973MUwEr0jb8Le
	 9wXxFrzH77xw96mVyueyFkYCMKcDQXzlC31Bmh39Km0wm/wngaRNIJ1g99Wjc2IRku
	 9JCZ5iBSSB0AwvPvYhe+4VuQbM0XfceqVQ1w5grZWN3efmjEugSCNyGZ41YP46M8gD
	 XrSXudtm0WeY2QwwcNWDeUAF17iXsH/8KH1OneZBvkAKkyHFW+1qbnS9+4xcCzE3PF
	 PSN0z0XRgeDKQ==
Date: Wed, 18 Mar 2026 09:56:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Mike Leach <mike.leach@arm.com>, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org, leo.yan@linaro.org,
	peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@redhat.com, namhyung@kernel.org
Subject: Re: [PATCH 2/2] perf: tools: cs-etm: Enhance raw Coresight trace
 debug display
Message-ID: <abqg-uKHqobUTn3n@x1>
References: <20260313132129.2743468-1-mike.leach@arm.com>
 <20260313132129.2743468-3-mike.leach@arm.com>
 <20260313144518.GN4153946@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313144518.GN4153946@e132581.arm.com>

On Fri, Mar 13, 2026 at 02:45:18PM +0000, Leo Yan wrote:
> LGTM and I tested it:

> Tested-by: Leo Yan <leo.yan@arm.com>

I think this is perf-tools-next material, Namhyung, please pick this
one.

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Ah, BTW, this one I picked up by perusing the https://sashiko.dev list
of reviewed patches that were CCed to linux-perf-users:

https://sashiko.dev/#/?list=org.kernel.vger.linux-perf-users

Thanks,

- Arnaldo
