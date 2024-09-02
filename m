Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6063E1A3A87;
	Mon,  2 Sep 2024 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725303255; cv=none; b=gYeItIMmGEVNm6RsTbFlAKa9ZLluSp7edAS+PAYL3b3F2Ghn51vZ350iTrzlC2FKjT9sIwUiSh8IHfiJjrhXNo2IezreO1R+Wg9eheXNzDH9BPWCi8gZKQ5p0mJ5MmgZu80NqLLCZ1/HjioMrg0/xbn6xPX68nUcW2oWcVZvCe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725303255; c=relaxed/simple;
	bh=x6KTZuenD7p0PdSDKZxP6dWikTN2SEdS4eNXb36SVK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNmaYAJEiBcLyr1fO1xAPmDEfFW3cUTj9cEU4tJF5cEHJqON74wTfzFXuOAlYu09fn4S250VbD4CBHfbEHtWy2Qvzlibl7L9sU0qYWhouY2LegXuMX658RUtGE5aGOYHH45isU8EXBJAASbZN1LrceClI4TkzmmijOLv2xr8qtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RquFLRjJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RquFLRjJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793F3C4CEC2;
	Mon,  2 Sep 2024 18:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725303254;
	bh=x6KTZuenD7p0PdSDKZxP6dWikTN2SEdS4eNXb36SVK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RquFLRjJ7jOp8ofqzdYa62Pwf0FOVtB/Fgs9V/PLZ7dSAQLb4hFd4y3weoYXyO44N
	 cAQtM7CC5Yuzvakgr8z5KxclpiXOixrHsJd+5nDPKhk/GeZYEOrZAPJ8t9C/DPFVkS
	 oW/U9LSXqbKvbcJQhdlK9OJm34SMzhqxOhOt7DFchygIiAomJ9ghViVgkdiq3Sddot
	 XZ4uA3DuWz0R9vUvNouH7ddurjJxgARA8g44CYUMlAeKN92s9VSLc7Kq3rTw8oJ3tA
	 2J0HON5vK/zLsPsSSHmu5MNaS4++0AYPtEoI/gt9Q4M2c1/mac2XqPHB+6wcYKzxi7
	 qN95vP3QlbCew==
Date: Mon, 2 Sep 2024 15:54:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@intel.com>, Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH/RFT] Re: [PATCH v5 1/8] perf trace: Fix iteration of
 syscall ids in syscalltbl->entries
Message-ID: <ZtYJ0z8f-1jwYSbV@x1>
References: <20240705132059.853205-1-howardchu95@gmail.com>
 <20240705132059.853205-2-howardchu95@gmail.com>
 <6fe63fa3-6c63-4b75-ac09-884d26f6fb95@kernel.org>
 <ZtJWEVn8-w07Wm0q@x1>
 <0f841525-e02a-4e11-b5f8-1acc61979ccf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f841525-e02a-4e11-b5f8-1acc61979ccf@kernel.org>

On Mon, Sep 02, 2024 at 07:25:17AM +0200, Jiri Slaby wrote:
> On 31. 08. 24, 1:30, Arnaldo Carvalho de Melo wrote:
> >  From 174899051e54ecdab06c07652a3d04ad000ab301 Mon Sep 17 00:00:00 2001
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date: Fri, 30 Aug 2024 19:53:47 -0300
> > Subject: [PATCH 1/1] perf tools: Build x86 32-bit syscall table from
> >   arch/x86/entry/syscalls/syscall_32.tbl
> > 
> > To remove one more use of the audit libs and address a problem reported
> > with a recent change where a function isn't available when using the
> > audit libs method, that should really go away, this being one step in
> > that direction.
> > 
> > The script used to generate the 64-bit syscall table was already
> > parametrized to generate for both 64-bit and 32-bit, so just use it and
> > wire the generated table to the syscalltbl.c routines.
> > 
> > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Howard Chu <howardchu95@gmail.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Link: https://lore.kernel.org/lkml/6fe63fa3-6c63-4b75-ac09-884d26f6fb95@kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Tested-by: Jiri Slaby <jirislaby@kernel.org>

Thanks a lot! Added to the cset.

- Arnaldo
