Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1FA1A2567;
	Tue, 25 Feb 2025 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740511540; cv=none; b=mEdsTKliPb6ZdrE5eczSC5ZKJIJavCbs4XiBtF4yksvUhTQ1V+OwnNl9vcepj7zMIghk51wCuYmttaUSfhEc75WSK0XFLO2Q3eJdTeg7wjfV+TLic1y8CJuIC3jq9286j7xgE5XXqPW9Hhmp62z9TRl4Y4oFAj8enfD4MfEVNmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740511540; c=relaxed/simple;
	bh=+O3EF/rxjqnHgbKvtM7VSwt9fAuuyUxJoM6cx4zF+dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXKEl3et/493QkUDniukuBxvkN+Ba5PSLFucZ38eEJWVE6Xc2HpgEobO52I4l9f5xx+AQSNgf7Sw3PaSDvNHVMR8aeOr8tEAXOPuGOJfVNUJJy//Kxl2corlNq9/trJ08qrl3DWzVZBCvoooCcAGUmzabDG8GDDDTa3GvGOYa6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgfJIp4m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgfJIp4m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A1DC4CEDD;
	Tue, 25 Feb 2025 19:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740511539;
	bh=+O3EF/rxjqnHgbKvtM7VSwt9fAuuyUxJoM6cx4zF+dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AgfJIp4mqO0KE8T7UZHQBYF4jIf9caPOsCewPpjBBXOZ2cLZ0kFqyPNB/Q8TJVaHo
	 U+7Nhh9rlpEaozzD4xf31o3yzMn/HuwD3NyAbntdz2KKInhymGXba+MtYa25Czpze/
	 PGffHzw6RFNHS19Mhi8NcA7woi85E2ZAZCLh6r0ycGgDDwE1V8BJfQf7Vu0vFVr8LW
	 zSX4xSE13wm+jY8hJVI7QlajFuS0a3ZpLPdoUzeCo3IXMrwGhrJ/m3gyQY8DA48m3x
	 NgE6bWqp3jlnMqv0gI9BW8MKiaYHR47CDEP9pHXEkC9A9TOhxr/omyDJ5M4h4LBWqr
	 BVoqrigZXLTIg==
Date: Tue, 25 Feb 2025 20:25:35 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf report: Add 'tgid' sort key
Message-ID: <Z74ZL6SUwWL_a5EK@x1>
References: <Z7XvEFEZtCRZKG7Y@x1>
 <Z7ZIqpwffQbibwL2@google.com>
 <CAP-5=fWZXPjD3Ok5XmMwwaYt+9mL+V8t8fNSUdf-F5PPiEAvrg@mail.gmail.com>
 <Z7gllQZeg6U2OvZE@google.com>
 <CAP-5=fXEEMFgPF2aZhKsfrY_En+qoqX20dWfuE_ad73Uxf0ZHQ@mail.gmail.com>
 <Z70wHEl6Sp0H0c-3@google.com>
 <CAP-5=fUosOVUKi5tQ3gVtHhfApk0oH3r2zHDW7-i+_qASKm+Cg@mail.gmail.com>
 <Z712hzvv22Ni63f1@google.com>
 <Z74U5s7Yf0f6I7Mo@x1>
 <Z74V0hZXrTLM6VIJ@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z74V0hZXrTLM6VIJ@x1>

On Tue, Feb 25, 2025 at 08:11:17PM +0100, Arnaldo Carvalho de Melo wrote:
> On Tue, Feb 25, 2025 at 08:07:18PM +0100, Arnaldo Carvalho de Melo wrote:
> > On Mon, Feb 24, 2025 at 11:51:35PM -0800, Namhyung Kim wrote:
> > > On Mon, Feb 24, 2025 at 08:40:37PM -0800, Ian Rogers wrote:
> > > > On Mon, Feb 24, 2025 at 6:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > On Mon, Feb 24, 2025 at 10:18:37AM -0800, Ian Rogers wrote:
> > > [SNIP]
> > > > > > I thought the real-time processing had to use
> > > > > > maps__fixup_overlap_and_insert (rather than maps__insert) as mmap
> > > > > > events only give us VMA data and two mmaps may have been merged.
> > > > > > Shouldn't doing this change be the simplest fix?
> 
> > > > > Make sense.  How about this?
> 
> > > > Lgtm, I have no way to test the issue. Why does maps__fixup_end need
> > > > to get pushed later?
> 
> > > I just noticed it would add extra kernel maps after modules.  I think it
> > > should fixup end address of the kernel maps after adding all maps first.
> 
> > > Arnaldo, can you please test this?
>  
> > Trying it now.
> 
> Now we have something different:
> 
> root@number:~# perf record sleep
> sleep: missing operand
> Try 'sleep --help' for more information.
> [ perf record: Woken up 1 times to write data ]
> perf: util/maps.c:80: check_invariants: Assertion `RC_CHK_EQUAL(map__kmap(map)->kmaps, maps)' failed.
> Aborted (core dumped)
> root@number:~#

__maps__insert() does:

        if (dso && dso__kernel(dso)) {
                struct kmap *kmap = map__kmap(new);

                if (kmap)
                        kmap->kmaps = maps;
                else
                        pr_err("Internal error: kernel dso with non kernel map\n");
        }

while maps__fixup_overlap_and_insert() doesn't.

It calls __maps__insert_sorted() that probably should do what
__maps__insert() does?

- Arnaldo
