Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2561802E;
	Thu, 20 Jun 2024 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875814; cv=none; b=PZUzLZPEgN27GC9SM86aq42sbA8oast85f2Trb8d0ji8b5K86LGrVquuWStAsxqWQ7d9hoaA68rtNbyatCge9iCsPfRzxWgh1CWYPwSD6mqe73JC8sTG9jNGNku7nPSkdbRyCnuhtplh8rsRn7+iJHT3SObrsh6W7lpNQLan/ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875814; c=relaxed/simple;
	bh=Fdm3uwDH8kPloDZ5bbG8L+LSca1yLBAjSbkLrX2rK1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idhTs23glBRiOSpwkQH9+fFr7plIj/0bfhJKusxuy6jo6NG622gVRi9xzLjY40gtZF78T979fY0qpV0cT8qA3N4ixWr+Qj4NsW8jxsygbFxkojcNbSyelMJjZf0qjyIy0GGUFKdRPnXs6Qy66TO41QbLAbyH0EJ/rDLVRddmeEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1VxdkgC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1VxdkgC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70492C2BD10;
	Thu, 20 Jun 2024 09:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718875813;
	bh=Fdm3uwDH8kPloDZ5bbG8L+LSca1yLBAjSbkLrX2rK1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r1VxdkgCtotLfCQosH9x004FEmXRGwpFwv196rVqL5qCnxEkEx5pFH27m76s20f47
	 noaHZ7Kdjj3QiUrm23CXO3QP+ekPzEo7BGNv8SoPWR+y6uJRA0mzaWt+MtRhvVriUn
	 maF93cK9ptS37J8iAEexMaOtOHP0HfaA3biH97WEU5ef52b9o/TndW+hog6g7PRtzR
	 CCpGWP3K4NbKJs3HkfFNXfQpcYG4crVSqwZyMA4f6ORFXwvP+Wd+oeR/1pUAEXr4Tt
	 b8HmSiukskOsxNoF+MThhSXEa/d8Vofdyh1irv9wzOwr1n6Q0XWv81Ky8wZhJ8vfvo
	 PtaoMGht7mOQQ==
Date: Thu, 20 Jun 2024 10:30:07 +0100
From: Will Deacon <will@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: hw_breakpoint: Save privilege of access control
 via ptrace
Message-ID: <20240620093007.GA4464@willie-the-truck>
References: <20240618071010.11214-1-yangtiezhu@loongson.cn>
 <20240619151524.GB24240@redhat.com>
 <9cc6d314-2431-c1b5-3d46-63c0ac80ed4d@loongson.cn>
 <20240620090807.GC30070@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620090807.GC30070@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jun 20, 2024 at 11:08:07AM +0200, Oleg Nesterov wrote:
> On 06/20, Tiezhu Yang wrote:
> >
> > On 06/19/2024 11:15 PM, Oleg Nesterov wrote:
> > >>--- a/include/uapi/linux/perf_event.h
> > >>+++ b/include/uapi/linux/perf_event.h
> > >>@@ -467,6 +467,7 @@ struct perf_event_attr {
> > >> 		__u32		wakeup_watermark; /* bytes before wakeup   */
> > >> 	};
> > >>
> > >>+	__u8			bp_priv;
> > >> 	__u32			bp_type;
> > >
> > >Is it safe to add the new member in the middle of uapi struct?
> > >This will break userspace...
> >
> > Let me put the new member "bp_priv" at the end of uapi struct
> > perf_event_attr in the next version if you are OK with it.
> 
> And add PERF_ATTR_SIZE_VER9 ?
> 
> Well, you can safely ignore me, you should ask the maintainers ;)
> 
> But to me the very idea of arm64-specific and "kernel only" member in
> perf_event_attr looks a bit strange.

Yeah, completely agreed.

Will
