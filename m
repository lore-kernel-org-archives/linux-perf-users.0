Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D9E1E9B2D;
	Tue, 11 Feb 2025 06:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739257188; cv=none; b=MAfPTMel1/B/8vv8BzgjevG31Jr5B6sehw6OLGBfZO1//DTa2WDdDR4p4ZR9oYBgiQvFWQtl9dN7A2n4Bc0riExFiYBXkeD8/AK3KsRiWPQYDfvFMHD+jfrvMvjUY9Hmjj0vgs88ytriBKTf6PX7IyF5TgpYcp+trEVIZkhhwg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739257188; c=relaxed/simple;
	bh=aZA2VhXLslsO+rW9gDYbT7BHncOZEzesAjlj64CzaBo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=buaI5BIxLXwXru+y9FEmMA+opGZMwN+xUIC7YEI9YoaUj/CQ3TmRK/ZzyV4ETrPumMRH97CWAEhkGrVP4LS9kpZeYETBNpmCT8jGYq1L9+u6fraaXtIVRlwozLRSsQ65mAm9HtIGBRLsHD+BOqqhZ8mzl8+wrv0PUUQKssMViUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nh2jjdUv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nh2jjdUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CE4C4CEDD;
	Tue, 11 Feb 2025 06:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739257188;
	bh=aZA2VhXLslsO+rW9gDYbT7BHncOZEzesAjlj64CzaBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nh2jjdUvZlHBjr6cdJcjN47DmLGdC6kgXOvfbbHJaI1l5rAcrd8sXqSns+M11Z5Oy
	 X1ABngoGb152yOdMJVoWOy8DDdvK6/WNplidjXzFztWSUoTXq1toXMtBYvpqIPyQ6F
	 kXLKbgD/nFlJBCuqbFF1JBZs2UXcI1ux0ZbShK27XQtIAOvzQJVAipx0uXoMwt36Am
	 eSlpD4Juaxl8IxxhgJg+r22jDeox7JmVTIrDpEP/a+lCFPzIxlfL/QoLNacA66r34n
	 aYqo/lnKn4NY1YlzXSZWe0u9A1znlIj+iqgKzg0V5nfGd2bqHrVZKTGrEE32E1aRo4
	 v6BqpVrDtwrrA==
Date: Tue, 11 Feb 2025 07:59:43 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, "Liang, Kan" <kan.liang@linux.intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers
 <irogers@google.com>, "Ingo Molnar" <mingo@redhat.com>, Mark Rutland
 <mark.rutland@arm.com>, "Peter Zijlstra" <peterz@infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 3/6] tools: perf: tools: perf: exported-sql-viewer: drop
 support for Python 2
Message-ID: <20250211075943.7aa74ff1@foz.lan>
In-Reply-To: <ef4110a1-d76b-4d01-bbed-734e7ba13ef5@intel.com>
References: <cover.1738171937.git.mchehab+huawei@kernel.org>
	<761ec2ebe518b5506e67d088797b559f89c396bb.1738171937.git.mchehab+huawei@kernel.org>
	<ef4110a1-d76b-4d01-bbed-734e7ba13ef5@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 30 Jan 2025 09:00:26 +0200
Adrian Hunter <adrian.hunter@intel.com> escreveu:

> On 29/01/25 19:39, Mauro Carvalho Chehab wrote:
> > As stated at process/changes.rsy doc, the current minimal Python
> > version is 3.x, so drop support for EOL python 2.x.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  tools/perf/scripts/python/exported-sql-viewer.py | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
> > index 121cf61ba1b3..b096592fd35f 100755
> > --- a/tools/perf/scripts/python/exported-sql-viewer.py
> > +++ b/tools/perf/scripts/python/exported-sql-viewer.py
> > @@ -3939,9 +3939,8 @@ def CopyTreeCellsToClipboard(view, as_csv=False, with_hdr=False):
> >  	indent_str = " " * indent_sz
> >  
> >  	expanded_mark_sz = 2
> > -	if sys.version_info[0] == 3:
> > -		expanded_mark = "\u25BC "
> > -		not_expanded_mark = "\u25B6 "
> > +    expanded_mark = "\u25BC "
> > +    not_expanded_mark = "\u25B6 "  
> 
> You removed the 'if' but left the 'else'.
> 
> The white is messed up.
> 
> So presumably not tested at all:
> 
>   python3 tools/perf/scripts/python/exported-sql-viewer.py
>     File "/home/user/git/review2/tools/perf/scripts/python/exported-sql-viewer.py", line 3942
>       expanded_mark = "\u25BC "
>                              ^
>   IndentationError: unindent does not match any outer indentation level
> 
> Posting untested patches, especially tidy-ups,
> should really be discouraged.
> 
> There are many other obvious python2 things in this
> file that have not been addressed.  When asked, AI
> listed 10 things.

You're right. Btw my main goal was just to make vermin to detect the
minimal version of this script.

I tried to run this script on Fedora 41, installing PySide with
pip there (*):

	$ pip install --user PySide2
	...
	$ perf record  ls
	...
	$ perf script -s tools/perf/scripts/python/export-to-sqlite.py pt_example branches calls
	Segmentation fault (core dumped)


but it gives me segmentation fault on a required library:

	Program terminated with signal SIGSEGV, Segmentation fault.
	#0  0x00007fcab2e0d1ec in SbkObject_TypeF () from ~/.local/lib/python3.13/site-packages/shiboken2/libshiboken2.abi3.so.5.13

(*) Fedora 41 doesn't have pyside2 packages anymore. 

Thanks,
Mauro
