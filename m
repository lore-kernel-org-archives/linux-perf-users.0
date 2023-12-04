Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE062C1AB
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkN+KIYE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E37C433C8;
	Mon,  4 Dec 2023 20:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701720043;
	bh=wl30XAUkpa2pw6wKx+oaNQPx6pqNHEJ1mH0tMi3TDP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NkN+KIYEfqZlby3k70htcyJEW+wz3qRaaIIG/9jFqO/IQK6UBjEh5OiAEYxNOr7+1
	 ZC7aESnNoYL3tQYhztlBDKSX3/tUk/iRmddx3uQD5cxctWI4mU/ynLndvIlCXowxZp
	 Yul0nHP82EEnsleheDPujc4YDH7RKoI8jI6D0n9Z1lTKlgD2+Zpm8tbd4QxbZ3F/H3
	 dnEQ0FXzUSH7dHHHhTY3y3fBPv6Lyyud0pC8dZLJy6mObyBUMgAPIDfVz/RMAuH8OT
	 VKyhupE1fd1YZqhPjkEqR9ju/RDS9XV02lDVrrC0Iw8/QP5pJC3kJ4hLnH784QLde7
	 7kvTmaUNPe07A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 5B20040094; Mon,  4 Dec 2023 17:00:40 -0300 (-03)
Date: Mon, 4 Dec 2023 17:00:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Disha Goel <disgoel@linux.ibm.com>, Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@arm.com>, Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	Kajol Jain <kjain@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Disha Goel <disgoel@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf vendor events: Update datasource event name to fix
 duplicate events
Message-ID: <ZW4v6OpQKGC7bHi2@kernel.org>
References: <20231123160110.94090-1-atrajeev@linux.vnet.ibm.com>
 <92bbba90-c7e4-43de-98dc-497ca323eacc@linux.ibm.com>
 <5293CFEC-6578-477B-86C2-40A50EBA144B@linux.vnet.ibm.com>
 <87E3CA3F-77D0-4A99-8575-C85544D207E1@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87E3CA3F-77D0-4A99-8575-C85544D207E1@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com

Em Sun, Dec 03, 2023 at 09:27:25PM +0530, Athira Rajeev escreveu:
> > On 29-Nov-2023, at 10:51 AM, Athira Rajeev <atrajeev@linux.vnet.ibm.com> wrote:
> >> On 27-Nov-2023, at 5:32 PM, Disha Goel <disgoel@linux.ibm.com> wrote:
> >>> Fixes: fc1435807533 ("perf vendor events power10: Update JSON/events")
> >>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

> >> I have tested the patch on Power10 machine. Perf list works correctly without any segfault now.

> >> # ./perf list

> >> List of pre-defined events (to be used in -e or -M):

> >>  branch-instructions OR branches                    [Hardware event]
> >>  branch-misses                                      [Hardware event]

> >> Tested-by: Disha Goel <disgoel@linux.ibm.com>

> > Thanks Disha for testing

> Hi Arnaldo,
 
> Can we get this pulled in if the patch looks good ?

Thanks, applied to perf-tools-next.

- Arnaldo

