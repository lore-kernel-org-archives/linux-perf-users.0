Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277CE45C1C;
	Wed, 28 Aug 2024 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879441; cv=none; b=QVGl1GSK+b4kHGvRXqJiUEwLo3aSHMKIuLmkZlDEUyqQ8Pt2fyKx7tjVVwOt/WhSuZfEXdQoCmRzC0jCWMq9maCN71pkoKitQgjEXmj4raQJs9P8VyVwzRfgLSWBv+YOX8DsgKhV2HNC3Ek8RIHY5yda8sqkp5KIbHbsPdqiE24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879441; c=relaxed/simple;
	bh=p7pNbtxW2a8q0ayOQwRd9oMMXqnYD6TO03sBwc1nZZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgPPVcFMC0wmz9jInUGHAME1HkHw3Jk4fH0yBd0ZhMuYxqqncYg6RMD95QPcinXBF/1CdEQ0VH2enHZQd8dL/E4m6YkuT77iAbEgmFqhw36VJ1NII26eBtvaABnYGieJ3uQ+mVS3IhtqTkz+M5YUSl4uxxP1xi9He94z9Xq9TiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkHXU4/m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkHXU4/m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09130C4CEC0;
	Wed, 28 Aug 2024 21:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724879440;
	bh=p7pNbtxW2a8q0ayOQwRd9oMMXqnYD6TO03sBwc1nZZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gkHXU4/mnxuurnnJUmhRyiORY5Y1BXSiiThdeFODqa0j3U8tXayOWR/Dd8Zg4LzIs
	 h/3sdJTz+aEnpOjJVrgVa9QQah8AWEDkxhnuEX06k8j+52JOo/db0F5nEhKPtSTC3q
	 wdmN/Os93DR1l2iZdZm0XUvO7XfO3pPhTITZu6WZasod90h25eyZa1SLHL9IK7XL3W
	 c17flJA+uNhxgRKynmiHKUKnFGKKqJqhPwjQbt7VhI8S+WHUQPrGtNJMzAGVJqQx1p
	 hNiq7w8IXHjHD+SqkuT3oIGcnd1wR6PhUXYUc9Vvwb5XYvz8gS7uiTG5f/EnBU/Jey
	 gYsocIaLu1giQ==
Date: Wed, 28 Aug 2024 18:10:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Kajol Jain <kjain@linux.ibm.com>, namhyung@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com, hbathini@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH 1/3] perf vendor events power10: Update JSON/events
Message-ID: <Zs-STZ3mQLjfBcjT@x1>
References: <20240827053206.538814-1-kjain@linux.ibm.com>
 <CAP-5=fWBjt3pypEwEsbKsuNTqX+ZA7v9WbNJCUgc09xxF=pt1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWBjt3pypEwEsbKsuNTqX+ZA7v9WbNJCUgc09xxF=pt1A@mail.gmail.com>

On Tue, Aug 27, 2024 at 08:30:09AM -0700, Ian Rogers wrote:
> On Mon, Aug 26, 2024 at 10:33 PM Kajol Jain <kjain@linux.ibm.com> wrote:
> >
> > Update JSON/events for power10 platform with additional events.
> >
> > Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> 
> For the series:
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
