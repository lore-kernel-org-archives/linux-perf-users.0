Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBDE13B5AB;
	Thu,  6 Jun 2024 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717712412; cv=none; b=VxBuAykHqULVkx42jFJU0I7vIphW6SviEpgnAhYbE8ExRW17IZqojV6jB4Ag5wSQ3xgiTp7PtJO6MRsqikBuwC+kNH9Zu9fvE+zh0Sxr5hGxbKhvCQnwoF2jGG1SUQfNHqNkIILBjNAZY2qzxrGPF/r9TMOFWBsAEpWAl/so36w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717712412; c=relaxed/simple;
	bh=V2mhAI3N/CK2RAkvpKzrmFJaAkBiHqMsJK628EGcqOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M19tsElCwBBUa/H/wW0YQLBDx4/pQoi4Di4GQyCjIe7Dk/bxVSLIHi9g7v5WV/3tOaMLmLewnUkMrLrIu1qLlYP+NfPlCe2FPL7PvDI0QxTptlspugbH9zD0mK0EpypKx3IGXjd5b/rxbLHofzdh4MDuTdXrk7JOvdvKUY20M/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdGVDGPj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdGVDGPj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27ECC2BD10;
	Thu,  6 Jun 2024 22:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717712411;
	bh=V2mhAI3N/CK2RAkvpKzrmFJaAkBiHqMsJK628EGcqOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RdGVDGPj6PpPZjWrGE7/T/tYX8TjRpkqKcVx8nvPXTwZ15gir0phES2KM6JAHN97m
	 A7Iz6Acykxaktq4oqEzvy8exrqeMQEkXCHlfPcy2aFZLc7joEKkM+psXO8NVrfNu6v
	 ISyjkLqj+wobzuwVD3jJvc3tGjHqhk3a8N8UALObbQ5+7IlXODGycElOQOPhlvJlbW
	 9PbuvzK7mQaLyjqzy10PW3Qk0yGz1Ol6vQ5wnTVBZ8DC8BYAZgbgrvrTA/JjNd6Sfy
	 ZZv/AeWykr/QvIyzU+DYt/QfcsO3F08gySWokmgLy2ICQVH4mqOYJP60MkuZA+brz/
	 vOv0jJUDbBEwQ==
Date: Thu, 6 Jun 2024 15:20:10 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Milian Wolff <milian.wolff@kdab.com>,
	linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@kenel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf 6.9-1 (archlinux) crashes during recording of cycles +
 raw_syscalls
Message-ID: <ZmI2Gumx5yUwyFsT@google.com>
References: <23879991.0LEYPuXRzz@milian-workstation>
 <Zl8bhWfHSXxs35r2@x1>
 <Zl8g1LxRCYgTSxhy@x1>
 <CAP-5=fVJRr2Qgf88ugEJ2FGerzKNv_dD6XOT_dSuFyYp2ubwSw@mail.gmail.com>
 <Zl9ksOlHJHnKM70p@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zl9ksOlHJHnKM70p@x1>

On Tue, Jun 04, 2024 at 04:02:08PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Jun 04, 2024 at 11:48:09AM -0700, Ian Rogers wrote:
> > On Tue, Jun 4, 2024 at 7:12 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > Can you please try with the attached and perhaps provide your Tested-by?
> 
> > > From ab355e2c6b4cf641a9fff7af38059cf69ac712d5 Mon Sep 17 00:00:00 2001
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Date: Tue, 4 Jun 2024 11:00:22 -0300
> > > Subject: [PATCH 1/1] Revert "perf record: Reduce memory for recording
> > >  PERF_RECORD_LOST_SAMPLES event"
> 
> > > This reverts commit 7d1405c71df21f6c394b8a885aa8a133f749fa22.
>  
> > I think we should try to fight back reverts when possible. Reverts are
> > removing something somebody poured time and attention into. When a
> 
> While in the development phase, yeah, but when we find a regression and
> the revert makes it go away, that is the way to go.
> 
> The person who poured time on the development gets notified and can
> decide if/when to try again.
> 
> Millian had to pour time to figure out why something stopped working,
> was kind enough to provide the output from multiple tools to help in
> fixing the problem and I had to do the bisect to figure out when the
> problem happened and to check if reverting it we would have the tool
> working again.
> 
> If we try to fix this for v6.10 we may end up adding yet another bug, so
> the safe thing to do at this point is to do the revert.
> 
> We can try improving this once again for v6.11.

I think I found a couple of problems with this issue. :(

 1. perf_session__set_id_hdr_size() uses the first evsel in the session
    But I think it should pick the tracking event.  I guess we assume
    all events have the same set of sample_type wrt the sample_id_all
    but I'm not sure if it's correct.

 2. With --call-graph dwarf, it seems to set unrelated sample type bits
    in the attr like ADDR and DATA_SRC.

 3. For tracepoint events, evsel__newtp_idx() sets a couple of sample
    type regardless of the configuration.  This includes RAW, TIME and
    CPU.  This one changes the format of the id headers.

 4. PERF_RECORD_LOST_SAMPLES is for the sampling event, so it should
    use the event's sample_type.  But the event parsing looks up the
    event using evlist->is_pos which is set for the first event.

 5. I think we can remove some sample type (i.e. TID and CPU) from the
    tracking event in most cases.  ID(ENTIFIER) will be used for LOST_
    SAMPLES and TIME is needed anyway.  TID is might be used for SWITCH
    but others already contain necessary information in the type.  I
    wish we could add id field to PERF_RECORD_LOST_SAMPLES and tid/pid
    to PERF_RECORD_SWITCH.

Thanks,
Namhyung

> 
> > regression has occurred then I think we should add the regression case
> > as a test.
> 
> Sure, I thought about that as well, will try and have one shell test
> with that, referring to this case, for v6.11.
> 
> - Arnaldo
