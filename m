Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4F71BDAB5;
	Thu, 23 Jan 2025 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737676133; cv=none; b=nf4TY0kRxxPozOK5+eKmhrCuUE5FawivmhNM48ufWuXgWH+cvVQZR7yxKYhrzAo6wA7WfBOXlfYvC2W4m3MhWG4m519R9abYbd+Epkn1594BQXTtHKkpPQpeArc4N8KB64B5FbQaoRCtuhKzuYTY9BohEa5flLGEbc+TTW0Opag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737676133; c=relaxed/simple;
	bh=SiEgAeLJ7UUpKCLTfXfDd8AfUyVfAc6pr3CSVOEfDrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNMkIDX+yyMdACZfyRGBhCLdgZ00jYP5TpTuq+NxmGoorA6lC6Qpigq02pYIWFeMI+B9PUuHkeYugjgBJdSHRfVjL75bVZ/x9B1MwIPRFlD72k76uIPNXwkRRTId9E+3zWAw0U7BfX9wsXeMmYIBVr+iOvGZCfvSJyx1Ds70tcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIylCQW6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIylCQW6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2CEC4CED3;
	Thu, 23 Jan 2025 23:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737676132;
	bh=SiEgAeLJ7UUpKCLTfXfDd8AfUyVfAc6pr3CSVOEfDrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BIylCQW6+hjV7Dj2uYSAIWybegaBpq9gSy6ggefCThhB9PSL9/yTUlAo3/uotIVsR
	 aHG5r/D655vTuB5aewVhLviAOEnaQgfYhb3LinjpMTiLeRbACQFJ15aRjzXFQrTlCo
	 m2UrBxblIZzExWQbMdWy5h4GWFvYQCJ8EpSXsCJ3ZkVMdeO/zlUFZBqX0TpTPAszzo
	 XzqZYJ7duYKOWCKnj0gS4FNS7SSnRmmY6nQEGsXmvS0b50RUCM/aCq0uAu6dQZutQj
	 d10DFF+AHYFiqPS2Vwb6YbwQNh48DZOUVyZAWrK4wi4JZYOEwUqdSNqjSUk2Hjs3Fx
	 bzau53j/o6dGg==
Date: Thu, 23 Jan 2025 15:48:50 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Benjamin Peterson <benjamin@engflow.com>
Cc: Howard Chu <howardchu95@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf trace: Remove return value of
 trace__fprintf_tp_fields
Message-ID: <Z5LVYtjPZduzcoE-@google.com>
References: <20241212-void-fprintf_tp_fields-v1-1-b0c23fff4c54@engflow.com>
 <CAH0uvoi6=JmtX2xit9y7+NR5O+1S5zbxWpmLpbzC9+9nrkudHQ@mail.gmail.com>
 <CAH0uvohQvqRYo8JBX_Z1yVobqcxRgQG4G1Y8o8XMv18CnrqBbA@mail.gmail.com>
 <Z5FCGGBxBHD95zjT@google.com>
 <CAEmfU+tj6kUbRNe7YbCorRStyAKs=7ndj73BvPUpkwA-gcBZCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEmfU+tj6kUbRNe7YbCorRStyAKs=7ndj73BvPUpkwA-gcBZCg@mail.gmail.com>

On Wed, Jan 22, 2025 at 11:19:05AM -0800, Benjamin Peterson wrote:
> On Wed, Jan 22, 2025 at 11:08 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Tue, Jan 21, 2025 at 07:01:53PM -0800, Howard Chu wrote:
> > > Hello fellow maintainers,
> > >
> > > Just a slight ping.
> >
> > Thanks for the reminder.
> 
> Thanks for taking a look.
> 
> >
> > >
> > > Thanks,
> > > Howard
> > >
> > > On Fri, Dec 13, 2024 at 10:06 AM Howard Chu <howardchu95@gmail.com> wrote:
> > > >
> > > > Hello Benjamin,
> > > >
> > > > On Thu, Dec 12, 2024 at 7:56 PM Benjamin Peterson <benjamin@engflow.com> wrote:
> > > > >
> > > > > The return value of this function was meaningless and therefore ignored by
> > > > > the caller. Remove it.
> >
> > In fact, I don't see the reason to merge this, as it's the convention to
> > return the number of characters it prints.  Yes, it's not used but not
> > much reason to remove it.
> 
> The main reason to remove the return value is that it has no useful
> interpretation and is therefore confusing. To wit, the function
> returns two times the number of bytes it prints.

Oh, ok.  Then please just fix it to return the correct number.

Thanks,
Namhyung

