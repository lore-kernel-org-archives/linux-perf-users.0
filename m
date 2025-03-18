Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C313FE4;
	Tue, 18 Mar 2025 02:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742264284; cv=none; b=s50XK7F3hZkvGo7VLhHStvsOZsBERmNXihFt9zrb9DM2u+4Ys/mybD1/zIFMqin98gZURosOaZ3s0iD7XSkq5OneBnhVk+oN0YGxYnJm4SLDtywlu8ibkri2F3qximjkTV6B3xaDcYflnnj0YyWiKVOvWk5iZbjOb0+o6VenaSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742264284; c=relaxed/simple;
	bh=HVDN2pGLCB4bzDnyUQxCey5v2yly+55gu5sSPJYR9iI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iut5Fjw84Fm5selLj0oufZ0MAFC2knoy56zmkqouD4GYHMavPifZs8RhYj6gIxD9rmis4Vp5XXHOwOL5BayVIHv1KvXdzPGbbt7IlI7uTDo/R+I87XOQQPOQ15MCDhlRTevpJxh36c5adFQHbPQ8lXETd+wvYxKrJ9ddWEU8+xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=k+2ohUuO; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="k+2ohUuO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fiUNY
	KxDB20XSgvYONP91r8uk+FBdrjCRxoI/Rp44A8=; b=k+2ohUuOWFJEQM8oXwqbO
	l/76cNnwzw+R5mXr3biSx+JCeUdW564zkn3XF4bE5sVfo/VK8u5kORJn99qvWcXP
	UvuHi1I/FhfIG1XWSd4KGtxDvKDYSw7mqYf71cZeQKHnaCpCPqT9VFVxc4ZGbFTg
	JXu542f9cedmND13fFT9NI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAX4bSq19hnd_QXAg--.25431S2;
	Tue, 18 Mar 2025 10:17:15 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: irogers@google.com
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	yangfeng59949@163.com
Subject: Re: [PATCH] perf kwork: Remove unreachable judgments
Date: Tue, 18 Mar 2025 10:17:03 +0800
Message-Id: <20250318021703.78297-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAP-5=fUPz9R60Lay=k-0k5Q8C9AdStAMycOgsKqA5MJ_o7Ag3Q@mail.gmail.com>
References: <CAP-5=fUPz9R60Lay=k-0k5Q8C9AdStAMycOgsKqA5MJ_o7Ag3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAX4bSq19hnd_QXAg--.25431S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUnVbkUUUUU
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiGAYUeGfY0s75QwAAsr

On Mon, 17 Mar 2025 08:44:45 -0700 Ian Rogers <irogers@google.com> wrote:
> 
> On Thu, Mar 13, 2025 at 8:10 PM Feng Yang <yangfeng59949@163.com> wrote:
> >
> > From: Feng Yang <yangfeng@kylinos.cn>
> >
> > When s2[i] = '\0', if s1[i] != '\0', it will be judged by ret,
> > and if s1[i] = '\0', it will be judegd by !s1[i].
> > So in reality, s2 [i] will never make a judgment
> 
> Sgtm. Out of curiosity, was this tripping a compiler warning? If so,
> could you provide the details?
> 
> Thanks,
> Ian

There was no warning during compilation,
I just accidentally discovered it while testing and analyzing this code.

Feng

