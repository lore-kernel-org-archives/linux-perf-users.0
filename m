Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B35C3C6BA;
	Mon,  4 Nov 2024 23:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730762534; cv=none; b=c9bE6nQ4W2OFLwmKThvUcVer88l7OylgAZP6fV4B31dXkN0lQHh8AzA0F/3LZp8s+GSpdV7q7aj4YRBmueiSbTi7sIy0h8c/cJzXV/6/7lp6nUwkTLaU9gzz/omDnmy/HfjbOL/+TqH8uMaCXEm8ljwaTscsW08iZyil+qZ5A2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730762534; c=relaxed/simple;
	bh=GdJwSfKUqTDy07ce4q/7vwI85c4xMt3VIdX6qK2UUI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPjcd/Fz1ZuHUIULJnim4x5+yN35MIzhvFEcq/umJ+o+huPeeaCwNKN/QvXGOGn8+JgB6k+4YX/FhEtotRzDx6jvi8vXMV4c5DcP8c0iz8jaF/+ALWrMsa1i8uXLz6JW8/tqQubf52FWAMExAC2JRxTbNQc400MPcvrXFpYrf9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5JG2yRA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5JG2yRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00050C4CECE;
	Mon,  4 Nov 2024 23:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730762533;
	bh=GdJwSfKUqTDy07ce4q/7vwI85c4xMt3VIdX6qK2UUI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h5JG2yRAe/OPI8CFWltbrblYdIokgfpSTpOjJJYPocHI8dEuus9LmXhrIGA7KRgzu
	 mT+c+CRZqFjbxgDoBzTGDX9t5E18icQqjLayat60YxQQGEhwf/2za9qv4ur3ynm1rB
	 UpSOq5UuQvGKT2MKJCVxaI/P0Opkg1Xp8wNllF+qbb3kUNJNCEYEJlDRYCf9rdVKI4
	 yGvLzmFf57iq0I2iZoYK729awiaYmN4sseESk7VRWLltJ3F8XQVLMzZljtLs3btOv7
	 4+fN0z8YnN2tNZM+ChiCmyFPXMpMIKmh1LdoXG+wqdbPbaVFuW70ylZ42OCyKByw8b
	 Yc72YW0DsHCzg==
Date: Mon, 4 Nov 2024 15:22:11 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 06/21] perf script: Move find_scripts to
 browser/scripts.c
Message-ID: <ZylXI4zj7Hs8Uvov@google.com>
References: <ZyPX7ayIO4teziDX@x1>
 <CAP-5=fVgJu8BJWFVUkCy1Zsi3piTPdV-GXL1bTpWZeO=nm=jrg@mail.gmail.com>
 <Zykk2MJ4REGCaqVw@google.com>
 <CAP-5=fXQpej43wxEtMYFbxdofHtUi98X68W4AaR9UCfsbDir5A@mail.gmail.com>
 <ZykxD41c6gWQoIrQ@x1>
 <CAP-5=fWf8guTgqwfrrct3AGYDC=Lb1Oxo7kXU_x1yEr5urFSkQ@mail.gmail.com>
 <Zyk19KgzI7ybPkQ4@google.com>
 <CAP-5=fXj1-wqt+Bs-0ZypRsaZw2VP0qyKdeeRHpjUD5BwO9OBg@mail.gmail.com>
 <ZylGJF7Ux3JdJllo@google.com>
 <CAP-5=fUz_LSJ4v4aaAWoLMQRXAtsqeQSjcyRun2kBVXUHTzvUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUz_LSJ4v4aaAWoLMQRXAtsqeQSjcyRun2kBVXUHTzvUA@mail.gmail.com>

On Mon, Nov 04, 2024 at 02:20:30PM -0800, Ian Rogers wrote:
> On Mon, Nov 4, 2024 at 2:09 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Nov 04, 2024 at 01:06:35PM -0800, Ian Rogers wrote:
> > > On Mon, Nov 4, 2024 at 1:00 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Mon, Nov 04, 2024 at 12:48:01PM -0800, Ian Rogers wrote:
> > > > > Namhyung was asking that the c&p of code be 1 patch then "add new
> > > > > changes like using openat() on top". That is:
> > > > >
> > > > > patch 1: add is_directory_at - introduce the 2 line helper function
> > > > > patch 2: move the code
> > > > > patch 3: update the code to use is_directory_at
> > > > >
> > > > > patch 2 is known broken as patch 3 is fixing it.
> > > > >
> > > > > Hopefully this is clear.
> > > >
> > > > Actually I don't care about the patch ordering.  My request is not
> > > > to break build and just to separate different changes out. :)
> > >
> > > So, patch 2 can't be separated from patch 3 - are we agreed? So we
> > > squash patch 2 with patch 3. Patch 1 is trivial and fails to meet the
> > > bar of a meaningful change, so we squash that. We end up with this
> > > patch. If there's a later revert and a dependence of the 2 liner, just
> > > don't revert that part of the change. We've never had such a revert so
> > > it is hard to see why we need to generate so much churn because of it.
> >
> > As I said the patch 1 should be the c&p and no need to introduce
> > is_directory_at() before that.  Why not doing
> >
> >  patch1: move the code
> >  patch2: add and use is_directory_at() + openat()
> >
> > ?
> 
> Because placing all the code in 1 file expands GCC's analysis and the
> build fails. In the commit message I describe this:
> "The arrays are warned about potential buffer overflows by GCC now
> that all the code exists in a single C file."
> A standard unsound workaround to this is to change "sizeof(...)" to
> "sizeof(...) - 1", as it is ugly I added is_directory_at to not suffer
> the problem as the arrays are gone.

Ok, it's strange that this type of analysis depends on the placement.
Anyway it seems there's a problem in the code already.  Then we can fix
it first and then move.  How about this?

 patch1: add and use is_directory_at() + openat()
 patch2: move the code

Thanks,
Namhyung

