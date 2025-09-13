Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530521684B0;
	Sat, 13 Sep 2025 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757774493; cv=none; b=hHo9OchosriQfMqYlwHIxTq/gfLrIt1vriNYce4wua9SvHQ0sQsEw3lgsFYykigdLHQ/QeaMrRIAjBnWigo2+hL1LrmlUAZAFAtOvhxM7I3h4XgBDRoIhf6+grAxAZvxAQemRYIVie/U4LmxBoFDD0BvRTZaQ0Y/kuVltAzLlYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757774493; c=relaxed/simple;
	bh=EJ20niRDRCpy5ltgrVyEy2cwZcfwHRS6Ohbpbbx4muI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twLbgloVVSHmWR0MTjAydOHxqgyWwi5dfCueBvBh4ZK8ArDCE8ce+8O+6WWRHUlFUDovH0RfTdY2KZyhvOG87xi6iBE4QinIGRBpLquY/T1d/SGSrFYS6WuyT1LXwweu8pDA0n7AgycwFuxxH4Fz9c7vudeDesJjvHhs654eYMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGjpKzLN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGjpKzLN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCB9C4CEEB;
	Sat, 13 Sep 2025 14:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757774493;
	bh=EJ20niRDRCpy5ltgrVyEy2cwZcfwHRS6Ohbpbbx4muI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VGjpKzLN4UYTp3bsiLFLEWhW0nBO9BvUSpVL7/BGirzEr4KYFo1XSnUhyJNfMUZxk
	 eDugvl9jmJ+VtyfgD1DbEMZRG+oxVQ84rb/FfrNta7tGhUbDPW1TkP9Llp2Cv7+oZU
	 3BdbMyOdXWXSTx0BK6fLLWwu/fXSssij/9b8torOS0cdxvzATnkS7bpXyjmZPze/Bh
	 Ki/UdyUb3QPL7V6Ifmm6UDVH6TKCkwucWWSkcvT8RBuf4jdY8V/lgaqFQ5SFa0B4h2
	 tQWtV++gJfxWzVRDY6kj2WEY3V4GNBlNHUN0tBSptBAqj0h1xxYnAQ/kE6TetxZim9
	 ElUU3BrvLIqvw==
Date: Sat, 13 Sep 2025 11:41:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Zecheng Li <zecheng@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] perf dwarf-aux: fix __die_find_scope_cb for
 namespaces
Message-ID: <aMWCmkQhlOj4fNol@x1>
References: <20250825195817.226560-1-zecheng@google.com>
 <aLKpAxq5QQIwD_Z_@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLKpAxq5QQIwD_Z_@google.com>

On Sat, Aug 30, 2025 at 12:32:19AM -0700, Namhyung Kim wrote:
> On Mon, Aug 25, 2025 at 07:58:17PM +0000, Zecheng Li wrote:
> > Currently __die_find_scope_cb goes to check siblings when the DIE
> > doesn't include the given PC. However namespaces don't have a PC and
> > could contain children that have that PC. When we encounter a namespace,
> > we should check both its children and siblings.
> > 
> > Signed-off-by: Zecheng Li <zecheng@google.com>
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

I'm cherry picking this one as well.

- Arnaldo
