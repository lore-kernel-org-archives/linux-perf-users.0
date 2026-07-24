Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FFC26738B;
	Fri, 24 Jul 2026 05:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872479; cv=none; b=mx3xesM8dEKWp/PzqOC9jBYTRi/CYgTyNV+CwHdsPNQcHbOcxgVG+Ye3xlulnvMLon+Xv7/W3FMAj2zsQlsQGOWjKyxTOn/Jp0fqLe8nAkO44SQDp2Ge7RoKdzc/EzFe8fSObwHSEn+CkLAYjhPDafFrkxziKl0iHTuVNc18DbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872479; c=relaxed/simple;
	bh=kzU8IhqAm37yQQeYM2Xf/TwOmctkRnxvQBBZHtJsGo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=You0Fqdleakpn54dhmnvCYW+93BlKrXLTJUHPrkn8ZpEmueFPO3njibSW78I+r+AFUK+oY9H4IGVPsuCj54E8LdH/9g7YsdIOfZPeSFqPSqzdCPBRvby2K3o90MGzFnCVXUt2etFYdHJLHQrxIN924ggyku4WqAm4Vj5j0yijAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yo9/Ndai; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yo9/Ndai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DB51F000E9;
	Fri, 24 Jul 2026 05:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784872478;
	bh=8t39udPraz8NCdDRgiJMs4JsYMg5tRsmrIZnwlrW5nM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yo9/NdaiFmVxHWvaaD6fmqawZBmbaZzGjWBam9LjEqF1DDLJEsJbOLdNZ3xh4XQ7k
	 q4LIa7lTxXaGq2a90/64QXue4ZbbbZvu0BajrCKpm4RXf1zSYLEDtkOiU9o1SPeEgM
	 14BJT7ipGgfV+kGUsB3Cv71EZnysndNoLbwqn9q2aT4g4X1l4J1UdaFJAzfTxkbrjH
	 yDqxiF4ujRWflj1TbBZs8gzVbfqILV8dm+YEPbtMVvIoUrTAks/SOOzvR9Z9AE84HP
	 C0PSU/QGpgpNeECUN6qJx7hjwFx5oawpWvWfQqukPtxoZoqBc52/ylNyzwlqGMcmxk
	 5ZOxnfIUp37jw==
Date: Thu, 23 Jul 2026 22:54:35 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com,
	chjohnst@mail.com, sean@ashe.io, steve@abita.co,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] perf trace: Add --bitmask-list command-line option
Message-ID: <amL-G7h_LC5Vsa-U@google.com>
References: <20260722155050.503516-1-atomlin@atomlin.com>
 <20260722155050.503516-3-atomlin@atomlin.com>
 <amGrbXzdup2hvg3k@google.com>
 <kick2ndzn7nisgdnxjit2tp6tfyub3nor54dbgqxqwy7ctgsdd@zxy23kkhc3uh>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kick2ndzn7nisgdnxjit2tp6tfyub3nor54dbgqxqwy7ctgsdd@zxy23kkhc3uh>

On Thu, Jul 23, 2026 at 11:28:48AM -0400, Aaron Tomlin wrote:
> On Wed, Jul 22, 2026 at 10:49:33PM -0700, Namhyung Kim wrote:
> > On Wed, Jul 22, 2026 at 11:50:49AM -0400, Aaron Tomlin wrote:
> > > Introduce a new '--bitmask-list' command-line option for 'perf trace'.
> > > When this option is specified, the formatting of cpumasks is delegated
> > > to bitmap_scnprintf(), enabling cpumasks to be displayed as a condensed,
> > > human-readable list (e.g., "0,2-5,7") instead of the default hexadecimal
> > > representation. An example is provided below:
> > 
> > Do you know any other places than cpumask use bitmask too?  I'm just
> > curious if it needs to handle other cases or not.
> 
> Hi Namhyung,
> 
> As far as I can tell, currently no other users.

Ok, I was thinking about --cpumask-list or --cpulist.  But I'm fine with
the current name as long as we can update other use cases in the future.
I'll process this unless others have different opinions.

Thanks,
Namhyung

