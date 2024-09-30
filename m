Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD31AF4E8;
	Mon, 30 Sep 2024 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731609; cv=none; b=QxTk5N4jM+YOiB8kQDbP6VISNg2Iz6SiQdlczD+1Pstr2fZdnx8XZB08XYnL0gu3PM//avQbq6blQwLB2uYzB+eQo7Z8PlhIYBTe8VNCfRMfcmwaEcju3KBRJjwaP5JR1t7azJg1RMbuwjjQUNjHZEewmBSVaqq6k9coK/6edGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731609; c=relaxed/simple;
	bh=PDFMQnY7zW0c/c24/w5bzXFlbGk7N8QPC1yUMeTcXK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X11Za1J+JRXLjyq53+WCcTqWlodiJuMHS/a1ZXi6391/GiaOUS3ClJpBUWucjXdtjc7eix5gWAOQkB62TpDI47r7y+3h9vcYVLuKPKnHWeBu3VGeuUAY2ggOYosbvsh5W4S5nM2C61mNaUJFQ5DM/FygqVa3nEJYhwCZ5JmRVbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH+5T4FM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH+5T4FM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A607FC4CECD;
	Mon, 30 Sep 2024 21:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727731609;
	bh=PDFMQnY7zW0c/c24/w5bzXFlbGk7N8QPC1yUMeTcXK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HH+5T4FMiWNvRpiExQ/EH4EtuDDvXEng4OV+WLdPd5SA3Ho08NFJ0fpu88Dx9pIDH
	 wS6Ycu+PX0buUMjdN0pqufrFTqkZDKiHMDHpIGCXfaqToOgVjcpu7hw+r2UPNeDzsj
	 Ae/PTmZSN49dXRKeJjZxtaG7x6z+kaZ+KyduYF2B5kfhgXpECg7UVR7C0EGyiNyh4p
	 Vl+MDHyyl9h6YP2wrcgkSKgfk1NHvyREUjeK/T9xmK51H4PfCet0S56aKBQoXiH+XM
	 IijSkYHJTmIAAVd4B6peCK/qIBrkTuT7JG9X1dRQqeR9Q6TlH+2AKohZZDYofCW+AI
	 JTkURcRgcGusQ==
Date: Mon, 30 Sep 2024 14:26:47 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	Zixian Cai <fzczx123@gmail.com>, Paran Lee <p4ranlee@gmail.com>,
	Ben Gainey <ben.gainey@arm.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf python: Remove python 2 scripting support
Message-ID: <ZvsXl2g6kYDi6F9o@google.com>
References: <20240918225418.166717-1-irogers@google.com>
 <20240918225418.166717-2-irogers@google.com>
 <Zut-iM3v9rJHehxJ@tassilo>
 <CAP-5=fWS-xOPurApZpMA=Zzukt5PQDYjF_7otCPTAL33PYmXAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWS-xOPurApZpMA=Zzukt5PQDYjF_7otCPTAL33PYmXAQ@mail.gmail.com>

On Thu, Sep 19, 2024 at 06:45:23AM +0200, Ian Rogers wrote:
> On Thu, Sep 19, 2024 at 3:29 AM Andi Kleen <ak@linux.intel.com> wrote:
> >
> > On Thu, Sep 19, 2024 at 12:54:17AM +0200, Ian Rogers wrote:
> > > Python2 was deprecated 4 years ago, remove support and workarounds.
> >
> > Nacked-by: Andi Kleen
> >
> > I don't see any advantages of breaking perfectly fine existing setups
> > for no benefits.

Well, I think the benefit is in the maintenance.  The EOL of Python 2
was 2020/1/1 [1] and we are targeting this release (v6.13) in 2025.  So
I think it's reasonable to consider removing Python 2 support now.

> 
> The reason is that since moving to linking libraries rather than
> building code we now have the ability to call functions like
> parse_events - previously parse_events was stubbed out because there
> was no way to build lex/yacc code. Calling parse_events is more
> sensible than existing logic that does things like open a legacy
> cycles event only on 1 PMU type. That is, the existing code doesn't
> support hybrid. Practically there is no way to test python2 support
> builds and works without having python2. We shouldn't be in the
> business of installing python2 in 2024, my organization has removed
> all support for over 3 years.

I think the problem nowdays is the container images for old distro.  I'm
not sure how long we need to support them but it should be cut out at
some point.

Thanks,
Namhyung


[1] https://www.python.org/doc/sunset-python-2/
