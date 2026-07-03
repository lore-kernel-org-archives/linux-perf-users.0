Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF50934DCC7
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Jul 2026 23:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783123195; cv=none; b=uvVohPPQQLkaAb003R8ysybLzcA3rfw34TwCYw7CN58eRmCbzKcYNmjQRiFDxbBQP15lp5TKUMXDBFjqyU5Gy4uFrcgaVp0zouhFOEKwUhF3tIEwNhKNuIDV3VrWSeACPirvATHGVxpQifS16AB2ZXvU1sK5VXx95HY4vqs0ct4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783123195; c=relaxed/simple;
	bh=Gn1hssmdik1zphnfMG6D25zjrCctNicnCJm7pRbDlyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kT+CnqR3OE3cMUpC+f609yZBL7++Fqp6R50IwQ1xlKcShHTFX//3br6OyLTB853D47nJJ5MOJbuu+ZojTUCC1dfii9afZ53IvzUN6aMM5I6M/WM04MOhlU/E4D27jhF8ilDKcw7+i8KhBg5osju5ZD4qgYl4tkCMsLY/Lb4Ookg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOtSshoo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOtSshoo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042B61F000E9;
	Fri,  3 Jul 2026 23:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783123193;
	bh=neDxvJLZqydMYExJ0EqIpg5nFmchQ3Fc9GHFErQRroM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VOtSshooeVOroaoJJmLAj7EQl8rWwHTcwE8RZj7t9eYCwASLt3GnAEzn2EoCxjIct
	 HWRgDNqL4+2EZRUbvKxuLxjMr53ZZNJJemRld6cT3d0M3Ulf4p+fhrk2mvt0hsBizK
	 wV3+4MI8sNLuN9PlXJ1fMTZzBaTOHOStzYRoRsYJ+KtMCRqQE1QZD0WeaFmwxZ07Nb
	 J9ERdleg8J8KpOZBf8dQf+Puqr9cN7YkPFUlA0QccDpuc6HBsEfp4KXlpRhMV9AaCU
	 aQ7SAsegaDT8m60ZnmXJN18QlCllZ0tLT+hPCwVTnUUi3MDAzrBvC9AtC8R816O2vg
	 bMjlizbJ8nHxw==
Date: Fri, 3 Jul 2026 16:59:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tanushree Shah <tshah@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, jolsa@kernel.org,
	adrian.hunter@intel.com, vmolnaro@redhat.com, mpetlan@redhat.com,
	tmricht@linux.ibm.com, maddy@linux.ibm.com, irogers@google.com,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	atrajeev@linux.ibm.com, hbathini@linux.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	Shivani.Nittor@ibm.com
Subject: Re: [PATCH] perf data convert json: Fix trace_seq memory leak in
 process_sample_event()
Message-ID: <akhM9-d-tNjZzb-A@google.com>
References: <20260604065519.112101-1-tshah@linux.ibm.com>
 <aiHuIBAIgv3L6TI7@x1>
 <f6937d04-6346-443b-8054-6f8a801a4fd8@linux.ibm.com>
 <akWEgMBK7Y39sgc8@google.com>
 <bf12f3d6-7410-44da-b4c4-32dc21244a12@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf12f3d6-7410-44da-b4c4-32dc21244a12@linux.ibm.com>

On Thu, Jul 02, 2026 at 12:46:54PM +0530, Tanushree Shah wrote:
> Hi Namhyung,
> 
> Yes, I was planning to send a v2 based on the review comments to fix the
> pre-existing issue.
> 
> However, Arnaldo mentioned that the original patch had already been merged
> before I got to send a v2, so I addressed the pre-existing issue in a
> separate patch instead. The patch is available here:
> 
> https://lore.kernel.org/linux-perf-users/20260606121528.406919-2-tshah@linux.ibm.com/
> 
> That said, although Arnaldo mentioned that this patch had been merged, I
> don't see it in perf-tools-next yet either. I'll wait for him to clarify its
> current status.

It's not in the perf-tools-next, and no plan to add it.  Please send v2.

Thanks,
Namhyung

